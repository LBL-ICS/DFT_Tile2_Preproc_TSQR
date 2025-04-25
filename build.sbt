ThisBuild / version := "0.1.0-SNAPSHOT"
ThisBuild / logLevel := Level.Debug
ThisBuild / scalaVersion := "2.13.12"
val chiselVersion = "6.0.0"

lazy val root = (project in file("."))
  .settings(
    name := "TSQR-Chisel-HCL",
    addCompilerPlugin("org.chipsalliance" % "chisel-plugin" % chiselVersion cross CrossVersion.full),
    libraryDependencies += "org.chipsalliance" %% "chisel" % chiselVersion,

    libraryDependencies += "edu.berkeley.cs" %% "chiseltest" % "6.0.0"
  )

