# compilar, compilar recursos
mvn clean compile

# compilar, compilar recursos, compilar codigo de pruebas unitarias, compilar recursos de pruebas, 
# ejecutar pruebas unitarias
mvn clean test

# compilar, compilar recursos, compilar codigo de pruebas unitarias, compilar recursos de pruebas, 
# ejecutar pruebas unitarias, crear JAR SIN dependencias.
mvn clean package

# compilar, compilar recursos, compilar codigo de pruebas unitarias, compilar recuersos de pruebas, 
# ejecutar pruebas unitarias, crear JAR CON dependencias.
mvn clean package assembly:single

# compilar, compilar recursos, compilar codigo de pruebas unitarias, compilar recuersos de pruebas, ejecutar pruebas unitarias, 
# crear JAR CON dependencias, instalar JAR SIN dependencias en repositorio local. (.m2/repository)
mvn clean install 