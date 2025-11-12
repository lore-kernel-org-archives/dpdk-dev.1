Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3721DCCFA18
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Nov 2025 02:42:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 34A8540280;
	Wed, 12 Nov 2025 03:42:09 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 1B3C14026A
 for <dev@dpdk.org>; Wed, 12 Nov 2025 03:42:08 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 54F5B20120BD; Tue, 11 Nov 2025 18:42:07 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 54F5B20120BD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1762915327;
 bh=a2q/z2TQGxr0Zrxr3+OVU6aoWXDRyDuABVkVrkY+oNE=;
 h=From:To:Cc:Subject:Date:From;
 b=HHmDxn0zbze1kpFniMj4TubQXM2MuBlyAgY6zSLPolbkmilPedzjMsksynRnfS3IC
 +CmS9uTQ78pKSYVxau4pzR45uj0/Nv200pTKeLzZEkoTIIp2dT1HDGfN1+5RZxaVVn
 r+bIGsvgj2oABsDvU74UL/5iVqdoC5YFv4bpwWdI=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>
Cc: dev@dpdk.org,
	Andre Muezerie <andremue@linux.microsoft.com>
Subject: [PATCH] doc: update instructions for Windows builds
Date: Tue, 11 Nov 2025 18:41:55 -0800
Message-Id: <1762915315-6610-1-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Unsubscribe: <https://mails.dpdk.org/options/dev>,
 <mailto:dev-request@dpdk.org?subject=unsubscribe>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
Errors-To: dev-bounces@dpdk.org

Updated some external links and removed a note which does not
apply to MSVC builds anymore.

Also reworded a sentence clarifying how to open a Visual Studio
Developer Command Prompt from CMD and Powershell, as the
original text could induce people to run VsDevCmd.bat from
a Powershell prompt, which does not work.

Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
---
 doc/guides/windows_gsg/build_dpdk.rst | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/doc/guides/windows_gsg/build_dpdk.rst b/doc/guides/windows_gsg/build_dpdk.rst
index 48241f7091..4fec5934b3 100644
--- a/doc/guides/windows_gsg/build_dpdk.rst
+++ b/doc/guides/windows_gsg/build_dpdk.rst
@@ -14,10 +14,6 @@ environments:
 * The MinGW-w64 10.0 (or later) toolchain (either native or cross).
 * Microsoft Visual Studio 2022 (any edition).
 
-  - note Microsoft Visual Studio 2022 does not currently build enough
-    of DPDK to produce a working DPDK application
-    but may be used to validate that changes are portable between toolchains.
-
 The Meson Build system is used to prepare the sources for compilation
 with the Ninja backend.
 The installation of these tools is covered in this section.
@@ -30,10 +26,10 @@ Install the Compiler
 ~~~~~~~~~~~~~~~~~~~~
 
 Download and install the clang compiler from
-`LLVM website <http://releases.llvm.org/download.html>`_.
+`LLVM website <https://releases.llvm.org>`_.
 For example, Clang-LLVM direct download link::
 
-	http://releases.llvm.org/7.0.1/LLVM-7.0.1-win64.exe
+    https://github.com/llvm/llvm-project/releases/download/llvmorg-19.1.0/LLVM-19.1.0-win64.exe
 
 
 Install the Linker
@@ -49,7 +45,7 @@ and ensure the Windows SDK is selected.
 Option 2. MinGW-w64 Toolchain
 -----------------------------
 
-On Windows, obtain the latest version installer from
+On Windows, obtain the latest installer version from
 `MinGW-w64 repository <https://sourceforge.net/projects/mingw-w64/files/>`_.
 Any thread model (POSIX or Win32) can be chosen, DPDK does not rely on it.
 Install to a folder without spaces in its name, like ``C:\MinGW``.
@@ -70,7 +66,7 @@ Download and install the build system from
 `Meson website <http://mesonbuild.com/Getting-meson.html>`_.
 A good option to choose is the MSI installer for both meson and ninja together::
 
-	http://mesonbuild.com/Getting-meson.html#installing-meson-and-ninja-with-the-msi-installer%22
+    http://mesonbuild.com/Getting-meson.html#installing-meson-and-ninja-with-the-msi-installer
 
 The minimal Meson supported version is 1.5.2.
 
@@ -134,14 +130,21 @@ required to build with Visual Studio 2022.
 Building DPDK applications that run on 32-bit Windows is currently not supported.
 If your Visual Studio environment defaults to producing 32-bit binaries,
 you can instruct the toolset to produce 64-bit binaries using "-arch" parameter.
-For more details about the Developer Prompt options, look at the
-`Visual Studio Developer Command Prompt and Developer PowerShell
-<https://learn.microsoft.com/en-us/visualstudio/ide/reference/command-prompt-powershell?view=vs-2022>`_.
+
+The command below opens a 'Visual Studio Developer Command Prompt' when invoked
+from a Windows Command Prompt.
 
 .. code-block:: console
 
     "C:\Program Files\Microsoft Visual Studio\2022\Enterprise\Common7\Tools\VsDevCmd.bat" -arch=amd64
 
+.. note::
+
+    To open a Developer Prompt from PowerShell, and for more details about the options
+    available, look at the
+    `Visual Studio Developer Command Prompt and Developer PowerShell
+    <https://learn.microsoft.com/en-us/visualstudio/ide/reference/command-prompt-powershell?view=vs-2022>`_.
+
 Compile the code from the developer prompt.
 
 .. code-block:: console
-- 
2.51.2.vfs.0.0

