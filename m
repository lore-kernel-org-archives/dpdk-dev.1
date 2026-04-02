Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7C23D39415
	for <dpdk-dev@archiver.kernel.org>; Thu,  2 Apr 2026 11:28:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B37FB40DF6;
	Thu,  2 Apr 2026 13:28:15 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id EF92B4028B
 for <dev@dpdk.org>; Thu,  2 Apr 2026 13:28:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775129293;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=HEA4IuikynwkhNV1Ub6Vin63D5yjCue/WPo968tNOU8=;
 b=RJJwADGqW6Lk7sI2tpnXyhB9TKeFs+PjmTft84V9flh1O+Z55uB5HwEq4fb33aTkLcF+bt
 jJjX/5LWTx+jhSdGqQVArTmh/g/M6AEm2tkrikKGZ/4nFdsu91dTZNrOL1+KPGkFYHyhBc
 wSzILmzSWXPwmDMg06Hq4dWOmPLo/kU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-37-X7jNHukgPz6S0WaHwPWz5A-1; Thu,
 02 Apr 2026 07:28:11 -0400
X-MC-Unique: X7jNHukgPz6S0WaHwPWz5A-1
X-Mimecast-MFC-AGG-ID: X7jNHukgPz6S0WaHwPWz5A_1775129291
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3675F180075F
 for <dev@dpdk.org>; Thu,  2 Apr 2026 11:28:10 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.32.35])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 66C9D30030D2
 for <dev@dpdk.org>; Thu,  2 Apr 2026 11:28:09 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Subject: [PATCH] version: 26.07-rc0
Date: Thu,  2 Apr 2026 13:28:03 +0200
Message-ID: <20260402112803.537002-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ZBzZyV8RlSf3N-DU5NfJRqdK0V6EDuTV_ApGj4IBUak_1775129291
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

