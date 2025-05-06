Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D29EBC3ABBF
	for <dpdk-dev@archiver.kernel.org>; Tue,  6 May 2025 13:31:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 73FCE40657;
	Tue,  6 May 2025 15:31:14 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id 52C054060F
 for <dev@dpdk.org>; Tue,  6 May 2025 15:31:13 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 008FF1A2D;
 Tue,  6 May 2025 06:31:02 -0700 (PDT)
Received: from localhost.localdomain (JR4XG4HTQC.cambridge.arm.com
 [10.1.25.44])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E665D3F5A1;
 Tue,  6 May 2025 06:31:11 -0700 (PDT)
From: Luca Vizzarro <luca.vizzarro@arm.com>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Luca Vizzarro <luca.vizzarro@arm.com>,
 Paul Szczepanek <paul.szczepanek@arm.com>, Patrick Robb <probb@iol.unh.edu>
Subject: [PATCH v2 2/3] dts: add facility to change file permissions
Date: Tue,  6 May 2025 14:29:32 +0100
Message-ID: <20250506132933.1580584-3-luca.vizzarro@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250506132933.1580584-1-luca.vizzarro@arm.com>
References: <20250331155800.449823-1-thomas.wilks@arm.com>
 <20250506132933.1580584-1-luca.vizzarro@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Add an abstraction to handle file permissions for the remote.

Signed-off-by: Luca Vizzarro <luca.vizzarro@arm.com>
Reviewed-by: Paul Szczepanek <paul.szczepanek@arm.com>
---
 dts/framework/testbed_model/os_session.py    | 34 ++++++++++++++++++++
 dts/framework/testbed_model/posix_session.py | 11 ++++++-
 2 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/dts/framework/testbed_model/os_session.py b/dts/framework/testbed_model/os_session.py
index 354c607357..869d575f0e 100644
--- a/dts/framework/testbed_model/os_session.py
+++ b/dts/framework/testbed_model/os_session.py
@@ -26,6 +26,7 @@
 from abc import ABC, abstractmethod
 from collections.abc import Iterable
 from dataclasses import dataclass
+from enum import Flag, auto
 from pathlib import Path, PurePath, PurePosixPath
 
 from framework.config.node import NodeConfiguration
@@ -44,6 +45,33 @@
 from .port import Port
 
 
+class FilePermissions(Flag):
+    """The permissions for a file and/or directory."""
+
+    #:
+    OTHERS_EXECUTE = auto()
+    #:
+    OTHERS_WRITE = auto()
+    #:
+    OTHERS_READ = auto()
+    #:
+    GROUP_EXECUTE = auto()
+    #:
+    GROUP_WRITE = auto()
+    #:
+    GROUP_READ = auto()
+    #:
+    OWNER_EXECUTE = auto()
+    #:
+    OWNER_WRITE = auto()
+    #:
+    OWNER_READ = auto()
+
+    def to_octal(self) -> str:
+        """Convert this flag to an octal representation."""
+        return format(self.value, "03o")
+
+
 @dataclass(slots=True, frozen=True)
 class OSSessionInfo:
     """Supplemental OS session information.
@@ -313,6 +341,12 @@ def copy_dir_to(
                 These patterns are used with `fnmatch.fnmatch` to filter out files.
         """
 
+    @abstractmethod
+    def change_permissions(
+        self, remote_path: PurePath, permissions: FilePermissions, recursive: bool = False
+    ) -> None:
+        """Change the permissions of the given path."""
+
     @abstractmethod
     def remove_remote_file(self, remote_file_path: str | PurePath, force: bool = True) -> None:
         """Remove remote file, by default remove forcefully.
diff --git a/dts/framework/testbed_model/posix_session.py b/dts/framework/testbed_model/posix_session.py
index 2d2701e1cf..fcd2faad6b 100644
--- a/dts/framework/testbed_model/posix_session.py
+++ b/dts/framework/testbed_model/posix_session.py
@@ -26,7 +26,7 @@
 )
 
 from .cpu import Architecture
-from .os_session import OSSession, OSSessionInfo
+from .os_session import FilePermissions, OSSession, OSSessionInfo
 
 
 class PosixSession(OSSession):
@@ -146,6 +146,15 @@ def copy_dir_to(
         self.extract_remote_tarball(remote_tar_path)
         self.remove_remote_file(remote_tar_path)
 
+    def change_permissions(
+        self, remote_path: PurePath, permissions: FilePermissions, recursive: bool = False
+    ) -> None:
+        """Overrides :meth:`~.os_session.OSSession.change_permissions`."""
+        self.send_command(
+            f"chmod {'-R ' if recursive else ''}{permissions.to_octal()} {remote_path}",
+            privileged=True,
+        )
+
     def remove_remote_file(self, remote_file_path: str | PurePath, force: bool = True) -> None:
         """Overrides :meth:`~.os_session.OSSession.remove_remote_dir`."""
         opts = PosixSession.combine_short_options(f=force)
-- 
2.43.0

