Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1091CC83F27
	for <dpdk-dev@archiver.kernel.org>; Tue, 22 Jul 2025 13:24:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1C8264026C;
	Tue, 22 Jul 2025 15:24:54 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 79A7A4003C
 for <dev@dpdk.org>; Tue, 22 Jul 2025 15:24:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753190692;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=RkEQMIi9eh9wbcgSGVhVZodWGYJTJ2IcIC1poHlWCJM=;
 b=H7E21f4zossMZE4KKqMvrHX/lihgawCsXm0BhtgCvgS+unIJ7r7N6TiRzWWWUfYmrZHtLg
 mXrfw7Ki9UDQvgDJl8phZbxStjdLvlrUrZcqICebY4PLBXIrD2Hy4RV5Nc6LsjKdGo62YQ
 RwIv8P6DBw8TvtGDdPxzyurVHoG6etY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-147-vPQOn-OyMIOCjB0zVFOUAQ-1; Tue,
 22 Jul 2025 09:24:51 -0400
X-MC-Unique: vPQOn-OyMIOCjB0zVFOUAQ-1
X-Mimecast-MFC-AGG-ID: vPQOn-OyMIOCjB0zVFOUAQ_1753190690
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3F88E1944D01; Tue, 22 Jul 2025 13:24:50 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.33.51])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EE7BA180A1CE; Tue, 22 Jul 2025 13:24:48 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net
Subject: [PATCH 1/2] version: 25.11.0-rc0
Date: Tue, 22 Jul 2025 15:24:40 +0200
Message-ID: <20250722132441.3700305-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 3ID_D5WR7DjtySSkfVD8gAUdIhVkgIgJUDUMKDrOJh8_1753190690
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

The ABI version becomes 26.0.
The ABI exceptions are dropped and CI ABI checks are disabled because
compatibility is not preserved.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 .github/workflows/build.yml            |   4 +-
 ABI_VERSION                            |   2 +-
 VERSION                                |   2 +-
 devtools/libabigail.abignore           |  14 ---
 doc/guides/rel_notes/index.rst         |   1 +
 doc/guides/rel_notes/release_25_11.rst | 136 +++++++++++++++++++++++++
 6 files changed, 141 insertions(+), 18 deletions(-)
 create mode 100644 doc/guides/rel_notes/release_25_11.rst

diff --git a/.github/workflows/build.yml b/.github/workflows/build.yml
index e5f17ef6ac..aca86bb6ed 100644
--- a/.github/workflows/build.yml
+++ b/.github/workflows/build.yml
@@ -12,7 +12,7 @@ defaults:
 env:
   REF_GIT_BRANCH: main
   REF_GIT_REPO: https://github.com/DPDK/dpdk
-  REF_GIT_TAG: v25.03
+  REF_GIT_TAG: none
 
 jobs:
   checkpatch:
@@ -70,7 +70,7 @@ jobs:
             checks: stdatomic
           - os: ubuntu-22.04
             compiler: gcc
-            checks: abi+debug+doc+examples+tests
+            checks: debug+doc+examples+tests
           - os: ubuntu-22.04
             compiler: clang
             checks: asan+doc+tests
diff --git a/ABI_VERSION b/ABI_VERSION
index a5615e1308..facd73a332 100644
--- a/ABI_VERSION
+++ b/ABI_VERSION
@@ -1 +1 @@
-25.2
+26.0
diff --git a/VERSION b/VERSION
index 6917e971c8..01e7bf947c 100644
--- a/VERSION
+++ b/VERSION
@@ -1 +1 @@
-25.07.0
+25.11.0-rc0
diff --git a/devtools/libabigail.abignore b/devtools/libabigail.abignore
index 96ae32455f..21b8cd6113 100644
--- a/devtools/libabigail.abignore
+++ b/devtools/libabigail.abignore
@@ -23,11 +23,8 @@
 ; This is not a libabigail rule (see check-abi.sh).
 ; This is used for driver removal and other special cases like mlx glue libs.
 ;
-; SKIP_LIBRARY=librte_common_iavf
-; SKIP_LIBRARY=librte_common_idpf
 ; SKIP_LIBRARY=librte_common_mlx5_glue
 ; SKIP_LIBRARY=librte_net_mlx4_glue
-; SKIP_LIBRARY=librte_net_igc
 
 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 ; Experimental APIs exceptions ;
@@ -36,14 +33,3 @@
 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 ; Temporary exceptions till next major ABI version ;
 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
-
-[suppress_type]
-        name = rte_dma_port_param
-        type_kind = struct
-        has_size_change = no
-        has_data_member = {pcie}
-
-[suppress_type]
-        name = rte_node
-        has_size_change = no
-        has_data_member_inserted_between = {offset_after(original_process), offset_of(xstat_off)}
diff --git a/doc/guides/rel_notes/index.rst b/doc/guides/rel_notes/index.rst
index fdc30741f9..bf5ecb266e 100644
--- a/doc/guides/rel_notes/index.rst
+++ b/doc/guides/rel_notes/index.rst
@@ -8,6 +8,7 @@ Release Notes
     :maxdepth: 1
     :numbered:
 
+    release_25_11
     release_25_07
     release_25_03
     release_24_11
diff --git a/doc/guides/rel_notes/release_25_11.rst b/doc/guides/rel_notes/release_25_11.rst
new file mode 100644
index 0000000000..ccad6d89ff
--- /dev/null
+++ b/doc/guides/rel_notes/release_25_11.rst
@@ -0,0 +1,136 @@
+.. SPDX-License-Identifier: BSD-3-Clause
+   Copyright 2025 The DPDK contributors
+
+.. include:: <isonum.txt>
+
+DPDK Release 25.11
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
+      xdg-open build/doc/guides/html/rel_notes/release_25_11.html
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
-- 
2.50.0

