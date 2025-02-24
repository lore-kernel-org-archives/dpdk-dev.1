Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CA11C021B5
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Feb 2025 13:30:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 562F841153;
	Mon, 24 Feb 2025 14:30:17 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id CE567410F1
 for <dev@dpdk.org>; Mon, 24 Feb 2025 14:30:11 +0100 (CET)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 061D0201B;
 Mon, 24 Feb 2025 05:30:28 -0800 (PST)
Received: from localhost.localdomain (JR4XG4HTQC.cambridge.arm.com
 [10.1.32.39])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id AB0213F5A1;
 Mon, 24 Feb 2025 05:30:10 -0800 (PST)
From: Luca Vizzarro <luca.vizzarro@arm.com>
To: dev@dpdk.org
Cc: Luca Vizzarro <luca.vizzarro@arm.com>,
 Paul Szczepanek <paul.szczepanek@arm.com>, Patrick Robb <probb@iol.unh.edu>
Subject: [PATCH 5/6] dts: enable build-less DPDK driver binding
Date: Mon, 24 Feb 2025 13:28:22 +0000
Message-ID: <20250224132823.196509-6-luca.vizzarro@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250224132823.196509-1-luca.vizzarro@arm.com>
References: <20250224132823.196509-1-luca.vizzarro@arm.com>
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

Add a facility to bind drivers for DPDK on runtimes where the DPDK build
is lacking. This is needed to execute any program that is based on DPDK,
but is unrelated to the testing.

Bugzilla ID: 1420

Signed-off-by: Luca Vizzarro <luca.vizzarro@arm.com>
Reviewed-by: Paul Szczepanek <paul.szczepanek@arm.com>
---
 dts/framework/remote_session/dpdk.py | 34 +++++++++++++++++++++-------
 1 file changed, 26 insertions(+), 8 deletions(-)

diff --git a/dts/framework/remote_session/dpdk.py b/dts/framework/remote_session/dpdk.py
index 50c22769c1..8d9f3b8948 100644
--- a/dts/framework/remote_session/dpdk.py
+++ b/dts/framework/remote_session/dpdk.py
@@ -419,6 +419,7 @@ def setup(self, ports: Iterable[Port]):
         """Set up the DPDK runtime on the target node."""
         if self.build:
             self.build.setup()
+        self._prepare_devbind_script()
         self.bind_ports_to_driver(ports)
 
     def teardown(self, ports: Iterable[Port]) -> None:
@@ -467,21 +468,38 @@ def bind_ports_to_driver(self, ports: Iterable[Port], for_dpdk: bool = True) ->
             )
             port.bound_for_dpdk = for_dpdk
 
-    @cached_property
-    def devbind_script_path(self) -> PurePath:
-        """The path to the dpdk-devbind.py script on the node.
+    def _prepare_devbind_script(self) -> None:
+        """Prepare the devbind script.
+
+        If the environment has a build associated with it, then use the script within that build's
+        tree. Otherwise, copy the script from the local repository.
 
         Raises:
-            InternalError: If attempting to retrieve the devbind script in a build-less runtime.
+            InternalError: If dpdk-devbind.py could not be found.
         """
         if self.build:
-            return self._node.main_session.join_remote_path(
+            self.devbind_script_path = self._node.main_session.join_remote_path(
                 self.build.remote_dpdk_tree_path, "usertools", "dpdk-devbind.py"
             )
+        else:
+            local_script_path = Path("..", "usertools", "dpdk-devbind.py").resolve()
+            if not local_script_path.exists():
+                raise InternalError("Could not find dpdk-devbind.py locally.")
 
-        raise InternalError(
-            "DPDK runtime is not associated with any DPDK build. Can't retrieve dpdk-devbind.py."
-        )
+            self.devbind_script_path = self._node.main_session.join_remote_path(
+                self._node.tmp_dir, local_script_path.name
+            )
+
+            self._node.main_session.copy_to(local_script_path, self.devbind_script_path)
+
+    @cached_property
+    def devbind_script_path(self) -> PurePath:
+        """The path to the dpdk-devbind.py script on the node.
+
+        Raises:
+            InternalError: If accessed before environment setup.
+        """
+        raise InternalError("Accessed devbind script path before setup.")
 
     def filter_lcores(
         self,
-- 
2.43.0

