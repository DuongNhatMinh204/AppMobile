//allprojects {
//    repositories {
//        google()
//        mavenCentral()
//    }
//}
//
//val newBuildDir: Directory = rootProject.layout.buildDirectory.dir("../../build").get()
//rootProject.layout.buildDirectory.value(newBuildDir)
//
//subprojects {
//    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
//    project.layout.buildDirectory.value(newSubprojectBuildDir)
//}
//subprojects {
//    project.evaluationDependsOn(":app")
//}
//
//tasks.register<Delete>("clean") {
//    delete(rootProject.layout.buildDirectory)
//}
// Áp dụng các kho lưu trữ Maven và Google
allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

// Định nghĩa thư mục build tùy chỉnh
val newBuildDir: Directory = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.set(newBuildDir)

// Cấu hình build cho từng module con (subprojects)
subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.set(newSubprojectBuildDir)
}

// Đảm bảo tất cả các module phụ được đánh giá sau module `:app`
subprojects {
    project.evaluationDependsOn(":app")
}

// Định nghĩa task dọn dẹp build
tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}

