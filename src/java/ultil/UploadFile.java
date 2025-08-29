package ultil;

import jakarta.servlet.http.Part;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Base64;
import java.util.Collection;

public class UploadFile {

    /**
     * Processes all file parts after upload, skipping non-file parts.
     *
     * @param fileParts file parts uploaded by the user
     * @param imageFile name of the file input tag
     * @param maxSize maximum size of file
     * @return String image in Base64 format with a delimiter (';') between images
     * @throws IOException in case of an error
     */
    public static String processFileParts(Collection<Part> fileParts, String imageFile, int maxSize) throws IOException {
        long totalSize = 0;
        StringBuilder base64Images = new StringBuilder();

        for (Part filePart : fileParts) {
            // Check if this part is a file upload (i.e., it has a valid file name)
            if (filePart.getSubmittedFileName() != null && !filePart.getSubmittedFileName().isEmpty() && filePart.getName().equals(imageFile)) {
                String dile = filePart.getSubmittedFileName();
                System.out.println("File name: " + filePart.getSubmittedFileName());
                String contentType = filePart.getContentType();
                try (InputStream inputStream = filePart.getInputStream()) {
                    // Convert image to Base64 format
                    String base64Image = convertImageToBase64(inputStream, contentType, totalSize, maxSize);
                    base64Images.append(base64Image).append(";");
                    totalSize += filePart.getSize();
                }
            }
        }

        return base64Images.toString();
    }

    /**
     * Converts an image input stream to a Base64-encoded string.
     *
     * @param inputStream the input stream of the image
     * @param contentType the MIME type of the file
     * @param totalSize the current total size of uploaded files
     * @param maxSize maximum size of file
     * @return String the Base64-encoded image
     * @throws IOException if an error occurs or file size exceeds the limit
     */
    private static String convertImageToBase64(InputStream inputStream, String contentType, long totalSize, int maxSize) throws IOException {
        maxSize = maxSize * 1024 * 1024;
        // Check if the content type is not an image
        if (contentType == null || !contentType.startsWith("image/")) {
            throw new IOException("File is not an image.");
        }

        ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
        byte[] buffer = new byte[1024];
        int bytesRead;
        long currentSize = 0;

        // Read the data from the inputStream and write it to the outputStream
        while ((bytesRead = inputStream.read(buffer)) != -1) {
            currentSize += bytesRead;
            if (currentSize + totalSize > maxSize) {
                throw new IOException("Total file size exceeds " + maxSize + "MB.");
            }
            outputStream.write(buffer, 0, bytesRead);
        }

        // Convert the byte array to a Base64-encoded string
        return Base64.getEncoder().encodeToString(outputStream.toByteArray());
    }
}
