Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CEB6C83F03
	for <dpdk-dev@archiver.kernel.org>; Fri,  4 Jul 2025 15:30:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 544D54065F;
	Fri,  4 Jul 2025 17:30:35 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id BAB03402F2
 for <dev@dpdk.org>; Fri,  4 Jul 2025 17:30:32 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4159C153B;
 Fri,  4 Jul 2025 08:30:18 -0700 (PDT)
Received: from localhost.localdomain (JR4XG4HTQC-2.cambridge.arm.com
 [10.1.30.57])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7FF173F66E;
 Fri,  4 Jul 2025 08:30:31 -0700 (PDT)
From: Luca Vizzarro <luca.vizzarro@arm.com>
To: dev@dpdk.org
Cc: Luca Vizzarro <luca.vizzarro@arm.com>, Patrick Robb <probb@iol.unh.edu>,
 Paul Szczepanek <paul.szczepanek@arm.com>
Subject: [PATCH v2 1/2] dts: remove dpdk example build function
Date: Fri,  4 Jul 2025 16:29:07 +0100
Message-ID: <20250704152908.683265-2-luca.vizzarro@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704152908.683265-1-luca.vizzarro@arm.com>
References: <20250702164204.607685-1-luca.vizzarro@arm.com>
 <20250704152908.683265-1-luca.vizzarro@arm.com>
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

Usage of example DPDK apps should be avoided. Therefore, remove
the function that allows to build example apps. Moreover,
provide a dedicated helper function to retrieve the path to a
DPDK app.

Signed-off-by: Luca Vizzarro <luca.vizzarro@arm.com>
---
 dts/framework/remote_session/dpdk.py | 33 +++-------------------------
 1 file changed, 3 insertions(+), 30 deletions(-)

diff --git a/dts/framework/remote_session/dpdk.py b/dts/framework/remote_session/dpdk.py
index e00c4a9bf9..606d6e22fe 100644
--- a/dts/framework/remote_session/dpdk.py
+++ b/dts/framework/remote_session/dpdk.py
@@ -267,36 +267,9 @@ def _build_dpdk(self) -> None:
             self.remote_dpdk_build_dir,
         )
 
-    def build_dpdk_app(self, app_name: str, **meson_dpdk_args: str | bool) -> PurePath:
-        """Build one or all DPDK apps.
-
-        Requires DPDK to be already built on the SUT node.
-
-        Args:
-            app_name: The name of the DPDK app to build.
-                When `app_name` is ``all``, build all example apps.
-            meson_dpdk_args: The arguments found in ``meson_options.txt`` in root DPDK directory.
-                Do not use ``-D`` with them.
-
-        Returns:
-            The directory path of the built app. If building all apps, return
-            the path to the examples directory (where all apps reside).
-        """
-        self._session.build_dpdk(
-            self._env_vars,
-            MesonArgs(examples=app_name, **meson_dpdk_args),  # type: ignore [arg-type]
-            # ^^ https://github.com/python/mypy/issues/11583
-            self.remote_dpdk_tree_path,
-            self.remote_dpdk_build_dir,
-            rebuild=True,
-            timeout=self._app_compile_timeout,
-        )
-
-        if app_name == "all":
-            return self._session.join_remote_path(self.remote_dpdk_build_dir, "examples")
-        return self._session.join_remote_path(
-            self.remote_dpdk_build_dir, "examples", f"dpdk-{app_name}"
-        )
+    def get_app(self, app_name: str) -> PurePath:
+        """Retrieve path for a DPDK app."""
+        return self._session.join_remote_path(self.remote_dpdk_build_dir, "app", f"dpdk-{app_name}")
 
     @cached_property
     def remote_dpdk_tree_path(self) -> PurePath:
-- 
2.43.0

