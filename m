Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E7BDCFD2F6
	for <dpdk-dev@archiver.kernel.org>; Tue,  2 Dec 2025 13:08:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D483340268;
	Tue,  2 Dec 2025 14:08:48 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id E0FAF400D5
 for <dev@dpdk.org>; Tue,  2 Dec 2025 14:08:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764680927;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=9LR3Ajyq/NnYHpG04km6hDxYm3iGsXG7tgdtF1c0gDc=;
 b=Pj5RO9cToJNoyEd9fFfZF+2TZgMLCjQihtdpjUx+zOTQdRTEdf9JtrDn16NbeUFUzdsT8B
 ZQ+x4psX8EGOxiLFLOajK5jSuJ3MNAKUC6uzrmvYi/tA0cfvkM/rnEuZnW5iVmUpOaZU7O
 j3rxtS0vmsPxRZw7w+yPiv6p2pZpZ4g=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-488-YwxP_gWRNWe_wFLyxScfsA-1; Tue,
 02 Dec 2025 08:08:45 -0500
X-MC-Unique: YwxP_gWRNWe_wFLyxScfsA-1
X-Mimecast-MFC-AGG-ID: YwxP_gWRNWe_wFLyxScfsA_1764680924
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D5C92180063D; Tue,  2 Dec 2025 13:08:30 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.32.89])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C66311955F33; Tue,  2 Dec 2025 13:08:27 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net,
	Aaron Conole <aconole@redhat.com>
Subject: [PATCH] version: 26.03-rc0
Date: Tue,  2 Dec 2025 14:08:18 +0100
Message-ID: <20251202130819.3805720-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: DljqV7rasHyBJzwNoTWy8AJrweF7FJYYue-vT8FMl28_1764680924
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
Bump version and ABI minor.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 .github/workflows/build.yml            |   4 +-
 ABI_VERSION                            |   2 +-
 VERSION                                |   2 +-
 doc/guides/rel_notes/index.rst         |   1 +
 doc/guides/rel_notes/release_26_03.rst | 138 +++++++++++++++++++++++++
 5 files changed, 143 insertions(+), 4 deletions(-)
 create mode 100644 doc/guides/rel_notes/release_26_03.rst

diff --git a/.github/workflows/build.yml b/.github/workflows/build.yml
index 39b4275816..ab140f885e 100644
--- a/.github/workflows/build.yml
+++ b/.github/workflows/build.yml
@@ -12,7 +12,7 @@ defaults:
 env:
   REF_GIT_BRANCH: main
   REF_GIT_REPO: https://github.com/DPDK/dpdk
-  REF_GIT_TAG: none
+  REF_GIT_TAG: v25.11
 
 jobs:
   checkpatch:
@@ -96,7 +96,7 @@ jobs:
             checks: stdatomic
           - os: ubuntu-22.04
             compiler: gcc
-            checks: debug+doc+examples+tests
+            checks: abi+debug+doc+examples+tests
           - os: ubuntu-22.04
             compiler: clang
             checks: asan+doc+tests
diff --git a/ABI_VERSION b/ABI_VERSION
index facd73a332..dfa88c8ebb 100644
--- a/ABI_VERSION
+++ b/ABI_VERSION
@@ -1 +1 @@
-26.0
+26.1
diff --git a/VERSION b/VERSION
index 6cd39b74fa..22103a6c30 100644
--- a/VERSION
+++ b/VERSION
@@ -1 +1 @@
-25.11.0
+26.03.0-rc0
diff --git a/doc/guides/rel_notes/index.rst b/doc/guides/rel_notes/index.rst
index bf5ecb266e..b304fc3b41 100644
--- a/doc/guides/rel_notes/index.rst
+++ b/doc/guides/rel_notes/index.rst
@@ -8,6 +8,7 @@ Release Notes
     :maxdepth: 1
     :numbered:
 
+    release_26_03
     release_25_11
     release_25_07
     release_25_03
diff --git a/doc/guides/rel_notes/release_26_03.rst b/doc/guides/rel_notes/release_26_03.rst
new file mode 100644
index 0000000000..15dabee7a1
--- /dev/null
+++ b/doc/guides/rel_notes/release_26_03.rst
@@ -0,0 +1,138 @@
+.. SPDX-License-Identifier: BSD-3-Clause
+   Copyright 2025 The DPDK contributors
+
+.. include:: <isonum.txt>
+
+DPDK Release 26.03
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
+      xdg-open build/doc/guides/html/rel_notes/release_26_03.html
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
+* No ABI change that would break compatibility with 25.11.
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
2.51.1

