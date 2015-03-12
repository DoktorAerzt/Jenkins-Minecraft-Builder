#!/bin/bash
echo "[JMB] Hello and Welcome to the Jenkins Minecraft Builder"
echo "[JMB] This is only a small status update. So that you know that the JMB is running"
buildgradle() {
    echo -e 'buildscript {
    repositories {
        mavenCentral()
        maven {
            name = "forge"
            url = "http://files.minecraftforge.net/maven"
        }
        maven {
            name = "sonatype"
            url = "https://oss.sonatype.org/content/repositories/snapshots/"
        }
    }
    dependencies {
        classpath \047net.minecraftforge.gradle:ForgeGradle:1.2-SNAPSHOT\047
    }
}

apply plugin: \047forge\047

version = "'$1'"
group= "'$2'"
archivesBaseName = "'$3'"

minecraft {
    version = "'$4'"
}
dependencies {
    // you may put jars on which you depend on in ./libs
    // or you may define them like so..
    //compile "some.group:artifact:version:classifier"
    //compile "some.group:artifact:version"
      
    // real examples
    //compile \047com.mod-buildcraft:buildcraft:6.0.8:dev\047  // adds buildcraft to the dev env
    //compile \047com.googlecode.efficient-java-matrix-library:ejml:0.24\047 // adds ejml to the dev env

    // for more info...
    // http://www.gradle.org/docs/current/userguide/artifact_dependencies_tutorial.html
    // http://www.gradle.org/docs/current/userguide/dependency_management.html

}
processResources
{
    // replace stuff in mcmod.info, nothing else
    from(sourceSets.main.resources.srcDirs) {
        include \047mcmod.info\047

        // replace version and mcversion
        expand \047version\047:project.version, \047mcversion\047:project.minecraft.version
    }

    // copy everything else, thats not the mcmod.info
    from(sourceSets.main.resources.srcDirs) {
        exclude \047mcmod.info\047
    }
}'
}
buildgradle $1 $2 $3 $4 > build.gradle
mkdir forge_version
if ls forge_version/$1 1> /dev/null 2>&1; then
    echo "[JMB] Forge sould be on the right version"
else
    echo "[JMB] The JMB will try to install a new Forge version"
    bash ./gradlew setupDecompWorkspace --refresh-dependencies
    cd forge_version
    rm $(ls ./)
    cd ..
fi
touch forge_version/$1
bash ./gradlew build
