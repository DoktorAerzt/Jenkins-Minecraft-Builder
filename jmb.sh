#!/bin/sh
echo "[MFB] Hello and Welcome to the Jenkins Minecraft Builder"
echo "[MFB] This is only a small status update. So that you know that the JMB is running"
buildgradle() {
    echo 'buildscript {
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
        classpath /'net.minecraftforge.gradle:ForgeGradle:1.1-SNAPSHOT/'
    }
}

apply plugin: /'forge/'

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
        include /'mcmod.info/'

        // replace version and mcversion
        expand /'version/':project.version, /'mcversion/':project.minecraft.version
    }

    // copy everything else, thats not the mcmod.info
    from(sourceSets.main.resources.srcDirs) {
        exclude /'mcmod.info/'
    }
}'
}
buildgradle $1 $2 $3 $4 > build.gradle
sh gradlew build
