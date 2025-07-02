Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6645C83F04
	for <dpdk-dev@archiver.kernel.org>; Wed,  2 Jul 2025 16:43:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9A9F140ED6;
	Wed,  2 Jul 2025 18:43:31 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id 2E8994028E
 for <dev@dpdk.org>; Wed,  2 Jul 2025 18:43:29 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B227222D9;
 Wed,  2 Jul 2025 09:43:13 -0700 (PDT)
Received: from localhost.localdomain (JR4XG4HTQC-2.cambridge.arm.com
 [10.1.35.68])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DF6663F66E;
 Wed,  2 Jul 2025 09:43:27 -0700 (PDT)
From: Luca Vizzarro <luca.vizzarro@arm.com>
To: dev@dpdk.org
Cc: Luca Vizzarro <luca.vizzarro@arm.com>,
 Paul Szczepanek <paul.szczepanek@arm.com>, Patrick Robb <probb@iol.unh.edu>
Subject: [PATCH 1/2] dts: add DPDK build app helper function
Date: Wed,  2 Jul 2025 17:42:03 +0100
Message-ID: <20250702164204.607685-2-luca.vizzarro@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250702164204.607685-1-luca.vizzarro@arm.com>
References: <20250702164204.607685-1-luca.vizzarro@arm.com>
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

Make a distinction between example apps and app/ apps by renaming the
build app function. Moreover, provide a dedicated helper function to
retrieve the path to a DPDK app.

Signed-off-by: Luca Vizzarro <luca.vizzarro@arm.com>
Reviewed-by: Paul Szczepanek <paul.szczepanek@arm.com>
---
 dts/framework/remote_session/dpdk.py | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/dts/framework/remote_session/dpdk.py b/dts/framework/remote_session/dpdk.py
index e00c4a9bf9..ed1f808bdd 100644
--- a/dts/framework/remote_session/dpdk.py
+++ b/dts/framework/remote_session/dpdk.py
@@ -267,8 +267,8 @@ def _build_dpdk(self) -> None:
             self.remote_dpdk_build_dir,
         )
 
-    def build_dpdk_app(self, app_name: str, **meson_dpdk_args: str | bool) -> PurePath:
-        """Build one or all DPDK apps.
+    def build_dpdk_example_app(self, app_name: str, **meson_dpdk_args: str | bool) -> PurePath:
+        """Build one or all DPDK example apps.
 
         Requires DPDK to be already built on the SUT node.
 
@@ -298,6 +298,10 @@ def build_dpdk_app(self, app_name: str, **meson_dpdk_args: str | bool) -> PurePa
             self.remote_dpdk_build_dir, "examples", f"dpdk-{app_name}"
         )
 
+    def get_app(self, app_name: str) -> PurePath:
+        """Retrieve path for a DPDK app."""
+        return self._session.join_remote_path(self.remote_dpdk_build_dir, "app", f"dpdk-{app_name}")
+
     @cached_property
     def remote_dpdk_tree_path(self) -> PurePath:
         """The remote DPDK tree path."""
-- 
2.43.0

