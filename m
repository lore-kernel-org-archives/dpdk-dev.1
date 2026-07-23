Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B31AC44524
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Jul 2026 08:12:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 082C24028A;
	Thu, 23 Jul 2026 10:12:19 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 5705E4027C
 for <dev@dpdk.org>; Thu, 23 Jul 2026 10:12:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784794336;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uj8jaePHn707PqZM0XKeOFL32nSTRjkmzEJMLoTtAXw=;
 b=Wegm4TPqfGdvoj96Ex/x66l5nD3MOCBAHijngPSyGwYJZYsL36SHpzzcHCUTRuBm43mvaM
 6EZNA8AydVGG7DhRo3vUjareMtLjcZ3qantGD7GChQw1Bzi91dD+lTIHwmg0jR6nKPB49o
 o3mTNzJiZVlgBS01En1Oh03+gJwzxbI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-17-MWwvxET3MnenTXwT1B_PsA-1; Thu,
 23 Jul 2026 04:12:14 -0400
X-MC-Unique: MWwvxET3MnenTXwT1B_PsA-1
X-Mimecast-MFC-AGG-ID: MWwvxET3MnenTXwT1B_PsA_1784794333
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6D52918007FA; Thu, 23 Jul 2026 08:12:12 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.48.202])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B5635196B0A8; Thu, 23 Jul 2026 08:12:08 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: Thomas Monjalon <thomas@monjalon.net>, Aaron Conole <aconole@redhat.com>,
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH v2] version: 26.11.0-rc0
Date: Thu, 23 Jul 2026 10:12:05 +0200
Message-ID: <20260723081206.2105269-1-david.marchand@redhat.com>
In-Reply-To: <20260723062416.1340761-1-david.marchand@redhat.com>
References: <20260723062416.1340761-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: BCd_Mci02Kw78Ax7bJ70TKUnsnMYTm_8a7gBIQFCluo_1784794333
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
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

Start a new release cycle with empty release notes.

The ABI version becomes 27.0.
The ABI exceptions are dropped and CI ABI checks are disabled because
compatibility is not preserved.

Note: we need to bump the version for symbol compat in ethdev and net/mlx5
temporarily. Next commits will drop this compat entirely.

Signed-off-by: David Marchand <david.marchand@redhat.com>
Acked-by: Thomas Monjalon <thomas@monjalon.net>
---
Changes since v1:
- bumped symbol exports for ethdev and net/mlx5,

---
 .github/workflows/build.yml            |   4 +-
 ABI_VERSION                            |   2 +-
 VERSION                                |   2 +-
 devtools/libabigail.abignore           |   7 --
 doc/guides/rel_notes/index.rst         |   1 +
 doc/guides/rel_notes/release_26_11.rst | 136 +++++++++++++++++++++++++
 drivers/net/mlx5/mlx5_driver_event.c   |   4 +-
 drivers/net/mlx5/mlx5_flow.c           |   4 +-
 lib/ethdev/rte_flow.c                  |   2 +-
 9 files changed, 146 insertions(+), 16 deletions(-)
 create mode 100644 doc/guides/rel_notes/release_26_11.rst

diff --git a/.github/workflows/build.yml b/.github/workflows/build.yml
index f0ef39d34f..c63a9a3982 100644
--- a/.github/workflows/build.yml
+++ b/.github/workflows/build.yml
@@ -12,7 +12,7 @@ defaults:
 env:
   REF_GIT_BRANCH: main
   REF_GIT_REPO: https://github.com/DPDK/dpdk
-  REF_GIT_TAG: v26.03
+  REF_GIT_TAG: none
 
 jobs:
   checkpatch:
@@ -96,7 +96,7 @@ jobs:
             checks: stdatomic
           - os: ubuntu-22.04
             compiler: gcc
-            checks: abi+debug+doc+examples+tests
+            checks: debug+doc+examples+tests
           - os: ubuntu-22.04
             compiler: clang
             checks: asan+doc+tests
diff --git a/ABI_VERSION b/ABI_VERSION
index d38d431146..a0d6856dbe 100644
--- a/ABI_VERSION
+++ b/ABI_VERSION
@@ -1 +1 @@
-26.2
+27.0
diff --git a/VERSION b/VERSION
index 403cc28f7a..a14edb8414 100644
--- a/VERSION
+++ b/VERSION
@@ -1 +1 @@
-26.07.0
+26.11.0-rc0
diff --git a/devtools/libabigail.abignore b/devtools/libabigail.abignore
index 2a0efd718e..21b8cd6113 100644
--- a/devtools/libabigail.abignore
+++ b/devtools/libabigail.abignore
@@ -33,10 +33,3 @@
 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 ; Temporary exceptions till next major ABI version ;
 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
-
-; Ignore new bit selective_rx in rte_eth_rxseg_capa bitmap hole
-[suppress_type]
-        name = rte_eth_rxseg_capa
-        type_kind = struct
-        has_size_change = no
-        has_data_member_inserted_at = 6
diff --git a/doc/guides/rel_notes/index.rst b/doc/guides/rel_notes/index.rst
index 5771a3f47b..d39ee24449 100644
--- a/doc/guides/rel_notes/index.rst
+++ b/doc/guides/rel_notes/index.rst
@@ -8,6 +8,7 @@ Release Notes
     :maxdepth: 1
     :numbered:
 
+    release_26_11
     release_26_07
     release_26_03
     release_25_11
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
new file mode 100644
index 0000000000..938617ca75
--- /dev/null
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -0,0 +1,136 @@
+.. SPDX-License-Identifier: BSD-3-Clause
+   Copyright 2026 The DPDK contributors
+
+.. include:: <isonum.txt>
+
+DPDK Release 26.11
+==================
+
+.. **Read this first.**
+
+   The text in the sections below explains how to update the release notes.
+
+   Use proper spelling, capitalization and punctuation in all sections.
+
+   Variable and config names should be quoted as fixed width text:
+   ``LIKE_THIS``.
+
+   Build the docs and view the output file to ensure the changes are correct::
+
+      ninja -C build doc
+      xdg-open build/doc/guides/html/rel_notes/release_26_11.html
+
+
+New Features
+------------
+
+.. This section should contain new features added in this release.
+   Sample format:
+
+   * **Add a title in the past tense with a full stop.**
+
+     Add a short 1-2 sentence description in the past tense.
+     The description should be enough to allow someone scanning
+     the release notes to understand the new feature.
+
+     If the feature adds a lot of sub-features you can use a bullet list
+     like this:
+
+     * Added feature foo to do something.
+     * Enhanced feature bar to do something else.
+
+     Refer to the previous release notes for examples.
+
+     Suggested order in release notes items:
+     * Core libs (EAL, mempool, ring, mbuf, buses)
+     * Device abstraction libs and PMDs (ordered alphabetically by vendor name)
+       - ethdev (lib, PMDs)
+       - cryptodev (lib, PMDs)
+       - eventdev (lib, PMDs)
+       - etc
+     * Other libs
+     * Apps, Examples, Tools (if significant)
+
+     This section is a comment. Do not overwrite or remove it.
+     Also, make sure to start the actual text at the margin.
+     =======================================================
+
+
+Removed Items
+-------------
+
+.. This section should contain removed items in this release. Sample format:
+
+   * Add a short 1-2 sentence description of the removed item
+     in the past tense.
+
+   This section is a comment. Do not overwrite or remove it.
+   Also, make sure to start the actual text at the margin.
+   =======================================================
+
+
+API Changes
+-----------
+
+.. This section should contain API changes. Sample format:
+
+   * sample: Add a short 1-2 sentence description of the API change
+     which was announced in the previous releases and made in this release.
+     Start with a scope label like "ethdev:".
+     Use fixed width quotes for ``function_names`` or ``struct_names``.
+     Use the past tense.
+
+   This section is a comment. Do not overwrite or remove it.
+   Also, make sure to start the actual text at the margin.
+   =======================================================
+
+
+ABI Changes
+-----------
+
+.. This section should contain ABI changes. Sample format:
+
+   * sample: Add a short 1-2 sentence description of the ABI change
+     which was announced in the previous releases and made in this release.
+     Start with a scope label like "ethdev:".
+     Use fixed width quotes for ``function_names`` or ``struct_names``.
+     Use the past tense.
+
+   This section is a comment. Do not overwrite or remove it.
+   Also, make sure to start the actual text at the margin.
+   =======================================================
+
+
+Known Issues
+------------
+
+.. This section should contain new known issues in this release. Sample format:
+
+   * **Add title in present tense with full stop.**
+
+     Add a short 1-2 sentence description of the known issue
+     in the present tense. Add information on any known workarounds.
+
+   This section is a comment. Do not overwrite or remove it.
+   Also, make sure to start the actual text at the margin.
+   =======================================================
+
+
+Tested Platforms
+----------------
+
+.. This section should contain a list of platforms that were tested
+   with this release.
+
+   The format is:
+
+   * <vendor> platform with <vendor> <type of devices> combinations
+
+     * List of CPU
+     * List of OS
+     * List of devices
+     * Other relevant details...
+
+   This section is a comment. Do not overwrite or remove it.
+   Also, make sure to start the actual text at the margin.
+   =======================================================
diff --git a/drivers/net/mlx5/mlx5_driver_event.c b/drivers/net/mlx5/mlx5_driver_event.c
index d0e22d6151..52e6ad7824 100644
--- a/drivers/net/mlx5/mlx5_driver_event.c
+++ b/drivers/net/mlx5/mlx5_driver_event.c
@@ -236,7 +236,7 @@ notify_existing_devices(rte_pmd_mlx5_driver_event_callback_t cb, void *opaque)
 		notify_existing_queues(port_id, cb, opaque);
 }
 
-RTE_DEFAULT_SYMBOL(26, int, rte_pmd_mlx5_driver_event_cb_register,
+RTE_DEFAULT_SYMBOL(27, int, rte_pmd_mlx5_driver_event_cb_register,
 		   (rte_pmd_mlx5_driver_event_callback_t cb, void *opaque))
 {
 	struct registered_cb *r;
@@ -269,7 +269,7 @@ RTE_VERSION_EXPERIMENTAL_SYMBOL(int, rte_pmd_mlx5_driver_event_cb_register,
 	return rte_pmd_mlx5_driver_event_cb_register(cb, opaque);
 }
 
-RTE_DEFAULT_SYMBOL(26, int, rte_pmd_mlx5_driver_event_cb_unregister,
+RTE_DEFAULT_SYMBOL(27, int, rte_pmd_mlx5_driver_event_cb_unregister,
 		   (rte_pmd_mlx5_driver_event_callback_t cb))
 {
 	struct registered_cb *r;
diff --git a/drivers/net/mlx5/mlx5_flow.c b/drivers/net/mlx5/mlx5_flow.c
index e8141d2100..fb90caf178 100644
--- a/drivers/net/mlx5/mlx5_flow.c
+++ b/drivers/net/mlx5/mlx5_flow.c
@@ -12537,7 +12537,7 @@ flow_disable_steering_run_on_related(struct rte_eth_dev *dev,
 	}
 }
 
-RTE_DEFAULT_SYMBOL(26, void, rte_pmd_mlx5_disable_steering, (void))
+RTE_DEFAULT_SYMBOL(27, void, rte_pmd_mlx5_disable_steering, (void))
 {
 	uint16_t port_id;
 
@@ -12566,7 +12566,7 @@ RTE_VERSION_EXPERIMENTAL_SYMBOL(void, rte_pmd_mlx5_disable_steering, (void))
 	rte_pmd_mlx5_disable_steering();
 }
 
-RTE_DEFAULT_SYMBOL(26, int, rte_pmd_mlx5_enable_steering, (void))
+RTE_DEFAULT_SYMBOL(27, int, rte_pmd_mlx5_enable_steering, (void))
 {
 	uint16_t port_id;
 
diff --git a/lib/ethdev/rte_flow.c b/lib/ethdev/rte_flow.c
index 651630b2f8..799c5c4843 100644
--- a/lib/ethdev/rte_flow.c
+++ b/lib/ethdev/rte_flow.c
@@ -282,7 +282,7 @@ static const struct rte_flow_desc_data rte_flow_desc_action[] = {
 	MK_FLOW_ACTION(JUMP_TO_TABLE_INDEX, sizeof(struct rte_flow_action_jump_to_table_index)),
 };
 
-RTE_DEFAULT_SYMBOL(26, int, rte_flow_dynf_metadata_register, (void))
+RTE_DEFAULT_SYMBOL(27, int, rte_flow_dynf_metadata_register, (void))
 {
 	int offset;
 	int flag;
-- 
2.54.0

