#!/bin/bash
echo "[MFB] Hello and Welcome to the Jenkins Minecraft Builder"
echo "[MFB] This is only a small status update. So that you know that the JMB is running"
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
        classpath \047net.minecraftforge.gradle:ForgeGradle:1.1-SNAPSHOT\047
    }
}

apply plugin: \047forge\047

version = "'$1'"
group= "'$2'"
archivesBaseName = "'$3'"

minecraft {
    version = "'$4'"
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
bash ./gradlew build
