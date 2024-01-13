extern crate hex;
use rand::RngCore;
use aes_gcm::{Aes256Gcm, KeyInit, aead::Aead}; // Add Aead here
use aes_gcm::aead::generic_array::GenericArray;

lazy_static::lazy_static! {
    static ref KEY: Aes256Gcm = Aes256Gcm::new(GenericArray::from_slice(&[0; 32]));
}

#[flutter_rust_bridge::frb(init)]
pub fn init_app() {
    // Default utilities - feel free to customize
    flutter_rust_bridge::setup_default_user_utils();
}

#[flutter_rust_bridge::frb(sync)] // Synchronous mode for simplicity of the demo
fn hex_string_to_bytes(hex_string: &str) -> Vec<u8> {
    let bytes: Vec<u8> = hex_string
        .as_bytes()
        .chunks(2)
        .map(|chunk| {
            u8::from_str_radix(std::str::from_utf8(chunk).expect("Invalid hex string"), 16)
                .expect("Invalid hex character")
        })
        .collect();

    if bytes.is_empty() {
        panic!("Hex string conversion resulted in an empty byte vector");
    }
    bytes
}

#[flutter_rust_bridge::frb(sync)] // Synchronous mode for simplicity of the demo
fn perform_encryption(key: &[u8], plaintext: &[u8]) -> (Vec<u8>, Vec<u8>) {
    let mut iv = [0u8; 12];
    rand::thread_rng().fill_bytes(&mut iv);
    let nonce = GenericArray::from_slice(&iv);

    let cipher = Aes256Gcm::new(GenericArray::from_slice(&key));
    let ciphertext = cipher.encrypt(nonce, plaintext).expect("Encryption failure!");

    (ciphertext.to_vec(), iv.to_vec())
}

#[flutter_rust_bridge::frb(sync)] // Synchronous mode for simplicity of the demo
pub fn encrypt_with_hex_string_key(shared_secret_key: String, plaintext: String) -> (Vec<u8>, Vec<u8>) {
    let key = hex_string_to_bytes(&shared_secret_key);
    let plaintext_bytes = plaintext.as_bytes();

    perform_encryption(&key, &plaintext_bytes)
}

#[flutter_rust_bridge::frb(sync)] // Synchronous mode for simplicity of the demo
pub fn encrypt_with_bytes_key(shared_secret_key: Vec<u8>, plaintext: String) -> (Vec<u8>, Vec<u8>) {
    let plaintext_bytes = plaintext.as_bytes();

    perform_encryption(&shared_secret_key, &plaintext_bytes)
}

#[flutter_rust_bridge::frb(sync)] // Synchronous mode for simplicity of the demo
pub fn decrypt_with_hex_string_key(shared_secret_key: String, ciphertext: Vec<u8>, iv: Vec<u8>) -> String {
    let shared_secret_bytes_key = hex_string_to_bytes(&shared_secret_key);
    let cipher = Aes256Gcm::new(GenericArray::from_slice(&shared_secret_bytes_key));
    let nonce = GenericArray::from_slice(&iv);

    let decrypted_text = cipher.decrypt(nonce, &*ciphertext).expect("Decryption failure!");
    String::from_utf8(decrypted_text).expect("Invalid UTF-8")
}

#[flutter_rust_bridge::frb(sync)] // Synchronous mode for simplicity of the demo
pub fn decrypt_with_bytes_key(shared_secret_key: Vec<u8>, ciphertext: Vec<u8>, iv: Vec<u8>) -> String {
    let cipher = Aes256Gcm::new(GenericArray::from_slice(&shared_secret_key));
    let nonce = GenericArray::from_slice(&iv);

    let decrypted_text = cipher.decrypt(nonce, &*ciphertext).expect("Decryption failure!");
    String::from_utf8(decrypted_text).expect("Invalid UTF-8")
}
