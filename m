Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40277C5AC81
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Aug 2026 17:17:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DF3914069D;
	Thu,  6 Aug 2026 19:16:49 +0200 (CEST)
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com
 [209.85.219.41]) by mails.dpdk.org (Postfix) with ESMTP id 35A0640685
 for <dev@dpdk.org>; Thu,  6 Aug 2026 19:16:48 +0200 (CEST)
Received: by mail-qv1-f41.google.com with SMTP id
 6a1803df08f44-8ff88549786so24161406d6.3
 for <dev@dpdk.org>; Thu, 06 Aug 2026 10:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1786036607; x=1786641407; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OJx9/FhUWBBcNxe1MEPvVjJB8LM0dj2Fsuv7b8M77oE=;
 b=WFdxc+VzGfEjjttDPk0Xj7YOvrIhTNB2gNiFdrh8cTwJvuEmZX7/LfQEnoYFXhdq09
 cd2JhIapFyNRorIA6+MKTLHZTsZoWXysq+idQkv/uZ2azZHOiOA2dndcCsSX8vVamF6o
 M+WyRUSIaZQZ6wstfgWeEUQiTDRhDmYujA724=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786036607; x=1786641407;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=OJx9/FhUWBBcNxe1MEPvVjJB8LM0dj2Fsuv7b8M77oE=;
 b=msjDEKJtvmK3BikJwTEP5OVXAM/3LaHjh4NLMsJ6hrmWyYKers9uIazG2bQjBWOhPf
 +YOpBQS80GhuZSgSYfv/uzJpYEeLCwChQcdlMNAHf8l9oMQFU0pSTNIuNF5VLv6M77IZ
 1bDdr6kD34ImzY2Fa/HoPwFEWbugN9h3bPmPg7jOE/dqWUMYQpBtAYF/HaI3yV9vN/AT
 V8Ud/UxwAFC2m+w+tOaCMLtZV1+9o7jnpaQ06ayz/Qi0thKSUFZXp0mNrOf1ZIgoddew
 tUavlDnNRDXA0BUviekKMgmxc1zE3ZqQMecVqAejb9aH/kWjE2v7nu684o4qTWHIjSbk
 bvsA==
X-Gm-Message-State: AOJu0YyJTMaLfnHr97a0z3hMFHgxbdcMCKSdEIe8txPh8dY+2XsAtRkC
 mPPHTvXZVJPtJbcX8GI6YmmBANZKlYSxoNWXSdb36ltsQkMSmiS/du8VXVliAw+pSLgjWH50oUg
 g9GSMBmrvGS7Zkkyiwz7FDcr9Y4xrafuzdS++W7D3WmvgHo0CiXWIT5vPc4TGCLBPkcLCW3RHEP
 lXGyquj8Pi5KvwJv3msQ58ycXz/U4=
X-Gm-Gg: AR+sD12O6OkXHwvFjZHla9dbv60u+Ba6AWGwVQY5URRiFZSyP2O5fgYLVaczDw/OLwm
 BqTWAT+2FUYyB4z4oRZ3fhXs3+mCr1O0xBjZegtKJ1A+iSbYYcLzVEQJT7XGabxQsnygcqpeDnF
 3z0oiFRhk+2dQFpg7NqWZXqRQP2N+nu/0Qayq5uY/zkX0TleYWX6qC8JJSCDCU+oy6/7/QGOFIy
 WQqUPyIdKMiK5RrgPSS2ludCj6PEynng9If0qGGnJEUge4gOTZ15yd1q40UJv2Z/YWyzVcI8+3A
 HINwDCEOOL5WhvRBTu5vngeGzsEiTRmFgEh0Aar7nXHB8l/OJv62e4k0wCHXZnucU5qEiYuBmc1
 Qx56T/BJab3XtOp9pOs6ME3wAIoHhhCbxYRyvP0qXWmPew3RPWU3uwtkJn8JF8vj5J78hY7dbN3
 /SL6VeNcxcDPqDgYt2jAqGkpn3BUzIw3thJ83RUmXrvt+8tFSRMeHTLmAY7lNk1N1HFOa5htAjk
 kPuosReBm26ofQ75/8ODkvsYfFuML6o7H+gSW0E
X-Received: by 2002:a05:6214:84c7:b0:908:93c5:25b5 with SMTP id
 6a1803df08f44-90893c527e0mr63651866d6.29.1786036607210; 
 Thu, 06 Aug 2026 10:16:47 -0700 (PDT)
Received: from syn-2603-7083-bff0-a0d0-0000-0000-0000-1a64.res6.spectrum.com
 ([2606:4100:3880:1257::1039]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-9087ffb8f76sm59934006d6.11.2026.08.06.10.16.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 10:16:46 -0700 (PDT)
From: Andrew Bailey <abailey@iol.unh.edu>
To: dev@dpdk.org,
	luca.vizzarro@arm.com,
	patrickrobb1997@gmail.com
Cc: knimoji@iol.unh.edu, lylavoie@iol.unh.edu, dladd@iol.unh.edu,
 David Marchand <david.marchand@redhat.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v6 3/7] version: 26.11.0-rc0
Date: Thu,  6 Aug 2026 13:16:32 -0400
Message-ID: <20260806171636.656181-4-abailey@iol.unh.edu>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260806171636.656181-1-abailey@iol.unh.edu>
References: <20260806135346.568766-1-abailey@iol.unh.edu>
 <20260806171636.656181-1-abailey@iol.unh.edu>
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

From: David Marchand <david.marchand@redhat.com>

Start a new release cycle with empty release notes.

The ABI version becomes 27.0.
The ABI exceptions are dropped and CI ABI checks are disabled because
compatibility is not preserved.

Note: we need to bump the version for symbol compat in ethdev and net/mlx5
temporarily. Next commits will drop this compat entirely.

Signed-off-by: David Marchand <david.marchand@redhat.com>
Acked-by: Thomas Monjalon <thomas@monjalon.net>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
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
2.55.0

