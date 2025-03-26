Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 961E6C36008
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Mar 2025 09:00:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6E69A402DF;
	Wed, 26 Mar 2025 10:00:14 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 57478402DA
 for <dev@dpdk.org>; Wed, 26 Mar 2025 10:00:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742979611;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Gfn1VAaC2iwEbcjGbJ8QVxZZxYmiXwyTvSa7V/1zev8=;
 b=LFquLs4Xv5BIwBR7KVWiMoyLZ7VvbjpgVwmGvRCmIETh+qLYxfke8c+vvbwWEm17dcCbQ/
 toEk8oTkXblG7+lf58KcrDnsIj0VCTVVTs2ADErcCBJgwyeSbRDAyjD6zAMK50cf26h+Bq
 bzxNkvHZKIaG6d2iu+AhhUAVhdYcnpc=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-422-VQ0lDK8YNXOF0CAn8de9gw-1; Wed,
 26 Mar 2025 05:00:09 -0400
X-MC-Unique: VQ0lDK8YNXOF0CAn8de9gw-1
X-Mimecast-MFC-AGG-ID: VQ0lDK8YNXOF0CAn8de9gw_1742979609
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BDA6F196B344; Wed, 26 Mar 2025 09:00:08 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.45.224.228])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 760811801747; Wed, 26 Mar 2025 09:00:07 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net
Subject: [PATCH] version: 25.07-rc0
Date: Wed, 26 Mar 2025 10:00:03 +0100
Message-ID: <20250326090003.858426-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 5VWncUCIJJoFNQMYMx37IT7XPzFuvR3u-STpqYyuvYw_1742979609
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
 doc/guides/rel_notes/release_25_07.rst | 138 +++++++++++++++++++++++++
 5 files changed, 142 insertions(+), 3 deletions(-)
 create mode 100644 doc/guides/rel_notes/release_25_07.rst

diff --git a/.github/workflows/build.yml b/.github/workflows/build.yml
index fba46b920f..0cc4d12b0b 100644
--- a/.github/workflows/build.yml
+++ b/.github/workflows/build.yml
@@ -12,7 +12,7 @@ defaults:
 env:
   REF_GIT_BRANCH: main
   REF_GIT_REPO: https://github.com/DPDK/dpdk
-  REF_GIT_TAG: v24.11
+  REF_GIT_TAG: v25.03
 
 jobs:
   checkpatch:
diff --git a/ABI_VERSION b/ABI_VERSION
index 8b9bee5b58..a5615e1308 100644
--- a/ABI_VERSION
+++ b/ABI_VERSION
@@ -1 +1 @@
-25.1
+25.2
diff --git a/VERSION b/VERSION
index 16164a3867..fedf12952a 100644
--- a/VERSION
+++ b/VERSION
@@ -1 +1 @@
-25.03.0
+25.07.0-rc0
diff --git a/doc/guides/rel_notes/index.rst b/doc/guides/rel_notes/index.rst
index fc0309113e..6462f01966 100644
--- a/doc/guides/rel_notes/index.rst
+++ b/doc/guides/rel_notes/index.rst
@@ -8,6 +8,7 @@ Release Notes
     :maxdepth: 1
     :numbered:
 
+    release_25_07
     release_25_03
     release_24_11
     release_24_07
diff --git a/doc/guides/rel_notes/release_25_07.rst b/doc/guides/rel_notes/release_25_07.rst
new file mode 100644
index 0000000000..cd1025aac0
--- /dev/null
+++ b/doc/guides/rel_notes/release_25_07.rst
@@ -0,0 +1,138 @@
+.. SPDX-License-Identifier: BSD-3-Clause
+   Copyright 2025 The DPDK contributors
+
+.. include:: <isonum.txt>
+
+DPDK Release 25.07
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
+      xdg-open build/doc/guides/html/rel_notes/release_25_07.html
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
+* No ABI change that would break compatibility with 24.11.
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
2.48.1

