FROM swiftdocker/swift

# Build the app
ADD Package.swift /data/app/
ADD Source/*.swift /data/app/Source/
WORKDIR /data/app/
RUN swift build -c release
