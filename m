Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97FF5606A327
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Nov 2026 15:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=gPn24p0H
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1CCB940430;
	Thu, 26 Nov 2026 16:55:03 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTPS id 1242F402C9
 for <dev@dpdk.org>; Thu, 26 Nov 2026 16:55:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795708501; x=1827244501;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=ILNq0zPCMx6ev/HmAX/5SPxUSs35vLxwS+dbtaAoQUw=;
 b=gPn24p0HNzmnAdqAm6c8cbdAcAesiT5O5DgWFi1WAfj0Jp08fvHBRnh7
 is7KzZ0esJ7RlkbmDOvstEBFwyAiBN9h6ShpRPmKir2XW3PlzC8twsVHC
 eOKxdtzggGeV2jjwFDVVUSC1U7m8fJKcYZOJA6/idSUZWFENZtIIF1tCf
 o3rWczLIrhIAGc1DC8oBmLmQUZ5FDRbO5hoR67ylFpG7VSB1qGSMUF8/M
 Dncseh87A8xJFZMY7l+ybXmncgBq/1G5KQkVphZjikUDbE740xl3ghsqa
 Vf1ZWcK5DA22kGySSi4b2bnrkLZUsdbXO1xLrJESbwfGRA8YkxGbrajq7 w==;
X-CSE-ConnectionGUID: EWElZipHQzaLTdWzdEPl/g==
X-CSE-MsgGUID: Ne3QIk1uRLyoHzPhmj6ERA==
X-IronPort-AV: E=McAfee;i="6800,10657,11978"; a="4620156"
X-IronPort-AV: E=Sophos;i="6.27,235,1787036400"; 
   d="scan'208";a="4620156"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Nov 2026 07:54:59 -0800
X-CSE-ConnectionGUID: 623q+JAGSYK8SgPtNSR9Kg==
X-CSE-MsgGUID: xxNZUxylSESocvlCvA5PRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,235,1787036400"; d="scan'208";a="12091518"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa005.jf.intel.com with ESMTP; 26 Nov 2026 07:54:59 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH] version: 27.03-rc0
Date: Thu, 26 Nov 2026 15:54:47 +0000
Message-ID: <20261126155447.4095116-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Start a new release cycle with empty release notes.
Bump version and ABI minor.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 .github/workflows/build.yml            |   4 +-
 ABI_VERSION                            |   2 +-
 VERSION                                |   2 +-
 doc/guides/rel_notes/index.rst         |   1 +
 doc/guides/rel_notes/release_27_03.rst | 138 +++++++++++++++++++++++++
 5 files changed, 143 insertions(+), 4 deletions(-)
 create mode 100644 doc/guides/rel_notes/release_27_03.rst

diff --git a/.github/workflows/build.yml b/.github/workflows/build.yml
index 1ea5f92e51..754f813768 100644
--- a/.github/workflows/build.yml
+++ b/.github/workflows/build.yml
@@ -12,7 +12,7 @@ defaults:
 env:
   REF_GIT_BRANCH: main
   REF_GIT_REPO: https://github.com/DPDK/dpdk
-  REF_GIT_TAG: none
+  REF_GIT_TAG: v26.11
 
 jobs:
   checkpatch:
@@ -95,7 +95,7 @@ jobs:
             checks: stdatomic
           - os: ubuntu-22.04
             compiler: gcc
-            checks: debug+doc+examples+tests
+            checks: abi+debug+doc+examples+tests
           - os: ubuntu-22.04
             compiler: clang
             checks: asan+doc+tests
diff --git a/ABI_VERSION b/ABI_VERSION
index a0d6856dbe..6ef5383e94 100644
--- a/ABI_VERSION
+++ b/ABI_VERSION
@@ -1 +1 @@
-27.0
+27.1
diff --git a/VERSION b/VERSION
index 03a8c4fa8c..8546885f1a 100644
--- a/VERSION
+++ b/VERSION
@@ -1 +1 @@
-26.11.0
+27.03.0-rc0
diff --git a/doc/guides/rel_notes/index.rst b/doc/guides/rel_notes/index.rst
index d39ee24449..63e88097e4 100644
--- a/doc/guides/rel_notes/index.rst
+++ b/doc/guides/rel_notes/index.rst
@@ -8,6 +8,7 @@ Release Notes
     :maxdepth: 1
     :numbered:
 
+    release_27_03
     release_26_11
     release_26_07
     release_26_03
diff --git a/doc/guides/rel_notes/release_27_03.rst b/doc/guides/rel_notes/release_27_03.rst
new file mode 100644
index 0000000000..a91813faca
--- /dev/null
+++ b/doc/guides/rel_notes/release_27_03.rst
@@ -0,0 +1,138 @@
+.. SPDX-License-Identifier: BSD-3-Clause
+   Copyright 2026 The DPDK contributors
+
+.. include:: <isonum.txt>
+
+DPDK Release 27.03
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
+      xdg-open build/doc/guides/html/rel_notes/release_27_03.html
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
+* No ABI change that would break compatibility with 26.11.
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
2.55.0

