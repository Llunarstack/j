//! Enigma-style cryptography: AEAD, signing, key exchange, secrets.

use aes_gcm::{
    aead::{Aead as AesAead, KeyInit as AesKeyInit, Payload as AesPayload},
    Aes256Gcm, Nonce as AesNonce,
};
use argon2::{
    password_hash::{PasswordHasher, SaltString},
    Argon2, Params,
};
use chacha20poly1305::{
    aead::Payload,
    ChaCha20Poly1305, Nonce,
};
use ed25519_dalek::{SigningKey, VerifyingKey};
use hkdf::Hkdf;
use rand::rngs::OsRng;
use sha2::Sha256;
use subtle::ConstantTimeEq;
use x25519_dalek::{PublicKey, StaticSecret};

/// Hybrid keypair combining Ed25519 (signing) and X25519 (key exchange)
#[allow(dead_code)]
#[derive(Clone)]
pub struct EnigmaKeypair {
    #[allow(dead_code)]
    pub signing_key: SigningKey,
    #[allow(dead_code)]
    pub exchange_secret: StaticSecret,
}

impl EnigmaKeypair {
    /// Generate a new master keypair
    pub fn generate() -> Self {
        let mut csprng = OsRng;
        let signing_key = SigningKey::generate(&mut csprng);
        let exchange_secret = StaticSecret::random_from_rng(csprng);

        Self {
            signing_key,
            exchange_secret,
        }
    }

    /// Get the signing key
    #[allow(dead_code)]
    pub fn signing_key(&self) -> &SigningKey {
        &self.signing_key
    }

    /// Get the public key for key exchange
    #[allow(dead_code)]
    pub fn public_key(&self) -> PublicKey {
        PublicKey::from(&self.exchange_secret)
    }

    /// Get the verifying key (public key for signature verification)
    #[allow(dead_code)]
    pub fn verifying_key(&self) -> VerifyingKey {
        self.signing_key.verifying_key()
    }

    /// Derive a session key with forward secrecy
    #[allow(dead_code)]
    pub fn derive_session_key(
        &self,
        peer_public: &PublicKey,
        context: &str,
        key_length: usize,
        nonce_length: usize,
    ) -> Result<(Vec<u8>, Vec<u8>), String> {
        // Perform X25519 key exchange
        let shared_secret = self.exchange_secret.diffie_hellman(peer_public);

        // Use HKDF to derive key material
        let hk = Hkdf::<Sha256>::new(Some(context.as_bytes()), shared_secret.as_bytes());

        let mut key = vec![0u8; key_length];
        let mut nonce = vec![0u8; nonce_length];

        hk.expand(b"enigma-key", &mut key)
            .map_err(|_| "Failed to derive key")?;
        hk.expand(b"enigma-nonce", &mut nonce)
            .map_err(|_| "Failed to derive nonce")?;

        Ok((key, nonce))
    }
}

/// Encrypt data using ChaCha20-Poly1305 AEAD
pub fn enigma_encrypt(
    plaintext: &[u8],
    key: &[u8],
    nonce: &[u8],
    aad: &[u8],
) -> Result<Vec<u8>, String> {
    if key.len() != 32 {
        return Err(format!(
            "Key must be 32 bytes for 2026 security level, got {}",
            key.len()
        ));
    }

    if nonce.len() != 12 {
        return Err(format!("Nonce must be 12 bytes, got {}", nonce.len()));
    }

    let cipher =
        ChaCha20Poly1305::new_from_slice(key).map_err(|_| "Invalid key length".to_string())?;

    let nonce_array = Nonce::from_slice(nonce);

    let payload = Payload {
        msg: plaintext,
        aad,
    };

    cipher
        .encrypt(nonce_array, payload)
        .map_err(|_| "Encryption failed".to_string())
}

/// Decrypt data using ChaCha20-Poly1305 AEAD
pub fn enigma_decrypt(
    ciphertext: &[u8],
    key: &[u8],
    nonce: &[u8],
    aad: &[u8],
) -> Result<Vec<u8>, String> {
    if key.len() != 32 {
        return Err("Key must be 32 bytes".to_string());
    }

    if nonce.len() != 12 {
        return Err("Nonce must be 12 bytes".to_string());
    }

    let cipher =
        ChaCha20Poly1305::new_from_slice(key).map_err(|_| "Invalid key length".to_string())?;

    let nonce_array = Nonce::from_slice(nonce);

    let payload = Payload {
        msg: ciphertext,
        aad,
    };

    cipher
        .decrypt(nonce_array, payload)
        .map_err(|_| "Decryption failed - tampered or wrong key".to_string())
}

/// Encrypt data using AES-256-GCM AEAD (alternative to ChaCha20)
pub fn aes_encrypt(
    plaintext: &[u8],
    key: &[u8],
    nonce: &[u8],
    aad: &[u8],
) -> Result<Vec<u8>, String> {
    if key.len() != 32 {
        return Err(format!(
            "Key must be 32 bytes for AES-256, got {}",
            key.len()
        ));
    }

    if nonce.len() != 12 {
        return Err(format!(
            "Nonce must be 12 bytes for GCM, got {}",
            nonce.len()
        ));
    }

    let cipher = Aes256Gcm::new_from_slice(key).map_err(|_| "Invalid key length".to_string())?;

    let nonce_array = AesNonce::from_slice(nonce);

    let payload = AesPayload {
        msg: plaintext,
        aad,
    };

    cipher
        .encrypt(nonce_array, payload)
        .map_err(|_| "AES encryption failed".to_string())
}

/// Decrypt data using AES-256-GCM AEAD
pub fn aes_decrypt(
    ciphertext: &[u8],
    key: &[u8],
    nonce: &[u8],
    aad: &[u8],
) -> Result<Vec<u8>, String> {
    if key.len() != 32 {
        return Err("Key must be 32 bytes".to_string());
    }

    if nonce.len() != 12 {
        return Err("Nonce must be 12 bytes".to_string());
    }

    let cipher = Aes256Gcm::new_from_slice(key).map_err(|_| "Invalid key length".to_string())?;

    let nonce_array = AesNonce::from_slice(nonce);

    let payload = AesPayload {
        msg: ciphertext,
        aad,
    };

    cipher
        .decrypt(nonce_array, payload)
        .map_err(|_| "AES decryption failed - tampered or wrong key".to_string())
}

/// Generate cryptographically secure random bytes
pub fn random_bytes(length: usize) -> Vec<u8> {
    use rand::RngCore;
    let mut bytes = vec![0u8; length];
    OsRng.fill_bytes(&mut bytes);
    bytes
}

/// XOR two byte arrays (for one-time pad style encryption)
pub fn xor_bytes(a: &[u8], b: &[u8]) -> Result<Vec<u8>, String> {
    if a.len() != b.len() {
        return Err(format!(
            "XOR requires equal length inputs: {} != {}",
            a.len(),
            b.len()
        ));
    }

    Ok(a.iter().zip(b.iter()).map(|(x, y)| x ^ y).collect())
}

/// Derive a key from a password using Argon2id (password-based encryption)
pub fn derive_password_key(
    password: &str,
    salt: &[u8],
    ops_limit: u32,
    mem_limit_kb: u32,
) -> Result<Vec<u8>, String> {
    if salt.len() < 16 {
        return Err("Salt must be at least 16 bytes".to_string());
    }

    // Configure Argon2id parameters
    let params = Params::new(
        mem_limit_kb,
        ops_limit,
        1,        // parallelism
        Some(32), // output length
    )
    .map_err(|e| format!("Invalid Argon2 params: {}", e))?;

    let argon2 = Argon2::new(argon2::Algorithm::Argon2id, argon2::Version::V0x13, params);

    // Create salt string from bytes
    let salt_str =
        SaltString::encode_b64(salt).map_err(|e| format!("Failed to encode salt: {}", e))?;

    // Hash the password
    let hash = argon2
        .hash_password(password.as_bytes(), &salt_str)
        .map_err(|e| format!("Argon2 hashing failed: {}", e))?;

    // Extract the hash bytes
    let hash_bytes = hash.hash.ok_or("No hash output")?.as_bytes().to_vec();

    Ok(hash_bytes)
}

/// Constant-time comparison (prevents timing attacks)
pub fn secure_compare(a: &[u8], b: &[u8]) -> bool {
    if a.len() != b.len() {
        return false;
    }
    a.ct_eq(b).into()
}

/// Generate a cryptographic salt
pub fn generate_salt(length: usize) -> Vec<u8> {
    random_bytes(length)
}

/// Generate a cryptographic nonce
pub fn generate_nonce(length: usize) -> Vec<u8> {
    random_bytes(length)
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_keypair_generation() {
        let _kp = EnigmaKeypair::generate();
    }

    #[test]
    fn test_encrypt_decrypt() {
        let key = random_bytes(32);
        let nonce = random_bytes(12);
        let plaintext = b"Top secret duck plans!";
        let aad = b"metadata:urgent";

        let ciphertext = enigma_encrypt(plaintext, &key, &nonce, aad).unwrap();
        let decrypted = enigma_decrypt(&ciphertext, &key, &nonce, aad).unwrap();

        assert_eq!(plaintext.to_vec(), decrypted);
    }

    #[test]
    fn test_tampered_ciphertext_fails() {
        let key = random_bytes(32);
        let nonce = random_bytes(12);
        let plaintext = b"Secret message";
        let aad = b"metadata";

        let mut ciphertext = enigma_encrypt(plaintext, &key, &nonce, aad).unwrap();

        // Tamper with the ciphertext
        ciphertext[0] ^= 1;

        let result = enigma_decrypt(&ciphertext, &key, &nonce, aad);
        assert!(result.is_err());
    }

    #[test]
    fn test_xor_bytes() {
        let a = vec![0xFF, 0x00, 0xAA];
        let b = vec![0x0F, 0xF0, 0x55];
        let result = xor_bytes(&a, &b).unwrap();
        assert_eq!(result, vec![0xF0, 0xF0, 0xFF]);
    }

    #[test]
    fn test_aes_encrypt_decrypt() {
        let key = random_bytes(32);
        let nonce = random_bytes(12);
        let plaintext = b"AES-256-GCM test";
        let aad = b"metadata";

        let ciphertext = aes_encrypt(plaintext, &key, &nonce, aad).unwrap();
        let decrypted = aes_decrypt(&ciphertext, &key, &nonce, aad).unwrap();

        assert_eq!(plaintext.to_vec(), decrypted);
    }

    #[test]
    fn test_password_key_derivation() {
        let password = "super_secret_password";
        let salt = random_bytes(16);

        let key1 = derive_password_key(password, &salt, 2, 19456).unwrap();
        let key2 = derive_password_key(password, &salt, 2, 19456).unwrap();

        // Same password and salt should produce same key
        assert_eq!(key1, key2);
        assert_eq!(key1.len(), 32);
    }

    #[test]
    fn test_secure_compare() {
        let a = vec![1, 2, 3, 4];
        let b = vec![1, 2, 3, 4];
        let c = vec![1, 2, 3, 5];

        assert!(secure_compare(&a, &b));
        assert!(!secure_compare(&a, &c));
    }

    #[test]
    fn test_session_key_derivation() {
        let kp1 = EnigmaKeypair::generate();
        let kp2 = EnigmaKeypair::generate();

        let pub2 = PublicKey::from(&kp2.exchange_secret);
        let (key, nonce) = kp1
            .derive_session_key(&pub2, "test-context", 32, 12)
            .unwrap();

        assert_eq!(key.len(), 32);
        assert_eq!(nonce.len(), 12);
    }
}
