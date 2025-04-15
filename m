Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6A1BC369B4
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Apr 2025 13:09:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BCDE04067E;
	Tue, 15 Apr 2025 15:09:17 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id 0AB3340289
 for <dev@dpdk.org>; Tue, 15 Apr 2025 15:09:16 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C18621756;
 Tue, 15 Apr 2025 06:09:13 -0700 (PDT)
Received: from e132991.cambridge.arm.com (e132991.arm.com [10.1.30.26])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 559FB3F59E;
 Tue, 15 Apr 2025 06:09:14 -0700 (PDT)
From: Thomas Wilks <thomas.wilks@arm.com>
To: dev@dpdk.org
Cc: Paul Szczepanek <paul.szczepanek@arm.com>,
 Luca Vizzarro <luca.vizzarro@arm.com>, Patrick Robb <probb@iol.unh.edu>,
 Thomas Wilks <thomas.wilks@arm.com>,
 Paul Szczepanek <Paul.Szczepanek@arm.com>
Subject: [PATCH 1/2] dts: add remote create dir function
Date: Tue, 15 Apr 2025 14:09:02 +0100
Message-ID: <20250415130903.224858-2-thomas.wilks@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250415130903.224858-1-thomas.wilks@arm.com>
References: <20250415130903.224858-1-thomas.wilks@arm.com>
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

Add a function that creates a directory on the
remote.

Signed-off-by: Thomas Wilks <thomas.wilks@arm.com>
Reviewed-by: Luca Vizzarro <luca.vizzarro@arm.com>
Reviewed-by: Paul Szczepanek <Paul.Szczepanek@arm.com>
---
 dts/framework/testbed_model/os_session.py    | 4 ++++
 dts/framework/testbed_model/posix_session.py | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/dts/framework/testbed_model/os_session.py b/dts/framework/testbed_model/os_session.py
index 354c607357..2be4f78ac0 100644
--- a/dts/framework/testbed_model/os_session.py
+++ b/dts/framework/testbed_model/os_session.py
@@ -360,6 +360,10 @@ def create_remote_tarball(
             The path to the created tarball on the remote node.
         """
 
+    @abstractmethod
+    def create_directory(self, path: PurePath) -> None:
+        """Create a directory at a specified `path`."""
+
     @abstractmethod
     def extract_remote_tarball(
         self,
diff --git a/dts/framework/testbed_model/posix_session.py b/dts/framework/testbed_model/posix_session.py
index 2d2701e1cf..57d58030b4 100644
--- a/dts/framework/testbed_model/posix_session.py
+++ b/dts/framework/testbed_model/posix_session.py
@@ -195,6 +195,10 @@ def generate_tar_exclude_args(exclude_patterns) -> str:
 
         return target_tarball_path
 
+    def create_directory(self, path: PurePath) -> None:
+        """Overrides :meth:`~.os_session.OSSession.create_directory`."""
+        self.send_command(f"mkdir -p {path}")
+
     def extract_remote_tarball(
         self,
         remote_tarball_path: str | PurePath,
-- 
2.43.0

