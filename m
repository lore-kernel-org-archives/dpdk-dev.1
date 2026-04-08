Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75D6110F995C
	for <dpdk-dev@archiver.kernel.org>; Wed,  8 Apr 2026 17:16:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 796604014F;
	Wed,  8 Apr 2026 19:16:49 +0200 (CEST)
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com
 [209.85.215.179])
 by mails.dpdk.org (Postfix) with ESMTP id A6E134013F
 for <dev@dpdk.org>; Wed,  8 Apr 2026 19:16:48 +0200 (CEST)
Received: by mail-pg1-f179.google.com with SMTP id
 41be03b00d2f7-c70f91776fcso64485a12.0
 for <dev@dpdk.org>; Wed, 08 Apr 2026 10:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1775668607;
 x=1776273407; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=xgmK2e7hrYjWi/Zz/5FDDRApNNvrycwV4dBC9nAozEA=;
 b=OQek1xEuTEAfxBnpcM1REV2PFEffGl2mwARJoiSfGkv49+yjpI5G9GRICAkFTfg/G2
 isorCB/x1TB1NyPIljKFw/kRrNWnDQA5afQfd1+rgREWJQEVjpoI+1T3hP+5uz18Ounr
 nHe1szBj9vv6MRYVDJWP6oJ99za0o4+Q7M4wRGhnreDx3yNtfm7oWLmso99Ke/fo71T/
 qgJ7Ay2O8BIlAi+UtUSQwtWY1ZIGWnkKCg4vXnm6kfxb1w7v8jYw2QXdWXZTsQq4+c53
 E714LqdT70xJ50W1fL9iGg0/UiXSiA/wU7TUHLIYN6HHBsg5NDIqctPxjZrg+6/Ksrvm
 OF6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775668607; x=1776273407;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xgmK2e7hrYjWi/Zz/5FDDRApNNvrycwV4dBC9nAozEA=;
 b=ZHK8Y6owcIxH8c46p/qrKBWvhdrQLUgY7nA6ZWu4rQOKU/XFgfCAZahPKB3l5GwiM4
 jGVY8hw3r9xgp79IlYQVth6K+1DNwW1lGcsh4J7NxCECj2K2ThTKIjP9hiranrL5Q/9F
 MjUxRK4ca7h9B+afoQk6FguSEnLPyiIBLLPhdCc8z/6IIA5s3/92METqn7IW6aELVk4W
 8lUZislyBS/aoiL/rZ4caWFDlbvk8YWmJK02tduL1eNkdRlaVE3T60Jo9Tw3PELUSH/v
 WCibKTuSAWGl7xzChjPLI76Hcvm8rmm8uWlwJL6OkBXJjOXhzHhPuBWsUR1hQwjk/ZQl
 DiRg==
X-Gm-Message-State: AOJu0Yw5MgDp4VriSiNq5oI9PlDPgHEyrDZ7UMh7judF+lJtC/QFbUwr
 Bk5K4mwTbn4MBC/NkgmUoM/CKrCKEGm6Pailj6VIdt0a97VZzX7dgmE7iQTMPdVoLrMWfBDOcCu
 z8nrb
X-Gm-Gg: AeBDiesVJ11j5Z5lB9LRcE7ZccPHMwUbNvkvnnsgL7NFzt6UAr6euvgmtrjHk4SB2OT
 txwfJsr4M6ewoHxw4bZqVqFFquYTFQuU2CSg8RzR9xPmBq91jGlRwfX0swhvEUS8ce4U1drJ8iS
 QpuUTNH6TC2p5olynuN9gKJtHIupzqtY9uw+IEcxN/BRJ41i5SbeMWARm5X4qU8NgrJC4bFWO6A
 xek52Rt2DL9c/24v70VLw4HlDz+FE1ZK3JwZ41BHPfB/M1+wIyc5x0p7QsAG9q4oA0NIjCEoBYj
 RKBFCmUOuxFxjylctm21YIskRY0A+JmTDIq11vY3QmCu3ZC6RVHdMZ6Bzy6ud8iuRSX8K5hMTAO
 XDuKHfHi35dPEAuTYtp1znOCWSlFDV/b2GaudeU5zHVto2uSgxtpz/WYx9s+5QVKDHW9p4BmBtR
 p3hplEV4JZChrw0o6zzmzeeZVRIAzRCDef
X-Received: by 2002:a05:7022:ec14:b0:12a:6c4b:9d1b with SMTP id
 a92af1059eb24-12bfb765fecmr11029782c88.31.1775668607156; 
 Wed, 08 Apr 2026 10:16:47 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12c14a371b1sm8641870c88.13.2026.04.08.10.16.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Apr 2026 10:16:46 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: David Marchand <david.marchand@redhat.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Aaron Conole <aconole@redhat.com>
Subject: [PATCH] version: 26.07-rc0
Date: Wed,  8 Apr 2026 10:16:44 -0700
Message-ID: <20260408171644.500333-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
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
Bump version and ABI minor.

Signed-off-by: David Marchand <david.marchand@redhat.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 .github/workflows/build.yml            |   2 +-
 ABI_VERSION                            |   2 +-
 VERSION                                |   2 +-
 doc/guides/rel_notes/index.rst         |   1 +
 doc/guides/rel_notes/release_26_07.rst | 138 +++++++++++++++++++++++++
 5 files changed, 142 insertions(+), 3 deletions(-)
 create mode 100644 doc/guides/rel_notes/release_26_07.rst

diff --git a/.github/workflows/build.yml b/.github/workflows/build.yml
index f0142efd3b..b3e2957411 100644
--- a/.github/workflows/build.yml
+++ b/.github/workflows/build.yml
@@ -12,7 +12,7 @@ defaults:
 env:
   REF_GIT_BRANCH: main
   REF_GIT_REPO: https://github.com/DPDK/dpdk
-  REF_GIT_TAG: v25.11
+  REF_GIT_TAG: v26.03
 
 jobs:
   checkpatch:
diff --git a/ABI_VERSION b/ABI_VERSION
index dfa88c8ebb..d38d431146 100644
--- a/ABI_VERSION
+++ b/ABI_VERSION
@@ -1 +1 @@
-26.1
+26.2
diff --git a/VERSION b/VERSION
index 98035c140f..81481ddcd9 100644
--- a/VERSION
+++ b/VERSION
@@ -1 +1 @@
-26.03.0
+26.07.0-rc0
diff --git a/doc/guides/rel_notes/index.rst b/doc/guides/rel_notes/index.rst
index b304fc3b41..5771a3f47b 100644
--- a/doc/guides/rel_notes/index.rst
+++ b/doc/guides/rel_notes/index.rst
@@ -8,6 +8,7 @@ Release Notes
     :maxdepth: 1
     :numbered:
 
+    release_26_07
     release_26_03
     release_25_11
     release_25_07
diff --git a/doc/guides/rel_notes/release_26_07.rst b/doc/guides/rel_notes/release_26_07.rst
new file mode 100644
index 0000000000..060b26ff61
--- /dev/null
+++ b/doc/guides/rel_notes/release_26_07.rst
@@ -0,0 +1,138 @@
+.. SPDX-License-Identifier: BSD-3-Clause
+   Copyright 2026 The DPDK contributors
+
+.. include:: <isonum.txt>
+
+DPDK Release 26.07
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
+      xdg-open build/doc/guides/html/rel_notes/release_26_07.html
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
2.53.0

