Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E7BBFC592F
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Feb 2026 11:58:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 214ED40661;
	Thu, 26 Feb 2026 12:58:19 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id DCAF440663
 for <dev@dpdk.org>; Thu, 26 Feb 2026 12:58:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772107097; x=1803643097;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=hcBbdkhHGKB5LHK9HoXMsoP1MoBrMp7f7YiyQqVcRto=;
 b=UebbpRRUbN++iCqcFQBwpIv5C7iYNzJk1PlHufUawpADr9geCM/lyEwk
 wONZQ93VKoS+ppaTAMZ2qozqaCLOBR86MOff91BZYWP97fj/rKvLNt+qa
 Q39oBUrPodq+sbyKfZNciJTnhbYmle9o6KffNZJ4YDf3vZ+kuKkXyQger
 UqHEO88abDEknTCkLHWC9mdTlWRPpWN2mTpOs23gW4lIBi6OtP6OrGAzh
 hudGpLdyh7yRETLZQGPCVotB/HWJWDgWD1fF4T3tYxD60oDouut9JG4bt
 fHbjPdSS9gMLBB3vHgSAyBJXpc8xJSK7payrDrqi+jDzdyFddwQ7dSdx8 Q==;
X-CSE-ConnectionGUID: gRQuDg1VTw2RNSosVKYjXg==
X-CSE-MsgGUID: ZiqEV1uARJu8sMY/J4YEMQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11712"; a="77033347"
X-IronPort-AV: E=Sophos;i="6.21,312,1763452800"; d="scan'208";a="77033347"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2026 03:58:16 -0800
X-CSE-ConnectionGUID: NkMpNgQ0R/+5PYZVIDe4FA==
X-CSE-MsgGUID: oTKhSCBvRmyggjZohRqc2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,312,1763452800"; d="scan'208";a="244135179"
Received: from fenlix-mobl.ccr.corp.intel.com ([10.239.252.5])
 by fmviesa001.fm.intel.com with ESMTP; 26 Feb 2026 03:58:14 -0800
From: Soumyadeep Hore <soumyadeep.hore@intel.com>
To: dev@dpdk.org, bruce.richardson@intel.com, rajesh3.kumar@intel.com,
 aman.deep.singh@intel.com, manoj.kumar.subbarao@intel.com
Subject: [PATCH v7 4/4] doc/guides: add PTP IDPF documentation
Date: Thu, 26 Feb 2026 19:33:14 -0500
Message-ID: <20260227003314.439267-5-soumyadeep.hore@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260227003314.439267-1-soumyadeep.hore@intel.com>
References: <20260214194920.139066-5-soumyadeep.hore@intel.com>
 <20260227003314.439267-1-soumyadeep.hore@intel.com>
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

Updates the IDPF Documentation with PTP feature.

Signed-off-by: Soumyadeep Hore <soumyadeep.hore@intel.com>
Acked-by: Rajesh Kumar <rajesh3.kumar@intel.com>
---
 doc/guides/nics/features/idpf.ini      |  1 +
 doc/guides/nics/idpf.rst               | 15 +++++++++++++++
 doc/guides/rel_notes/release_26_03.rst |  4 ++++
 3 files changed, 20 insertions(+)

diff --git a/doc/guides/nics/features/idpf.ini b/doc/guides/nics/features/idpf.ini
index 63b799289a..f546648924 100644
--- a/doc/guides/nics/features/idpf.ini
+++ b/doc/guides/nics/features/idpf.ini
@@ -19,6 +19,7 @@ RSS reta update      = Y
 L3 checksum offload  = P
 L4 checksum offload  = P
 Timestamp offload    = P
+Timesync             = Y
 Packet type parsing  = Y
 Basic stats          = Y
 Linux                = Y
diff --git a/doc/guides/nics/idpf.rst b/doc/guides/nics/idpf.rst
index b99cc18188..998c1a5dfa 100644
--- a/doc/guides/nics/idpf.rst
+++ b/doc/guides/nics/idpf.rst
@@ -109,3 +109,18 @@ The paths are chosen based on 2 conditions:
   A value "P" means the offload feature is not supported by vector path.
   If any not supported features are used, idpf vector PMD is disabled
   and the scalar paths are chosen.
+
+  Time Synchronization
+  ~~~~~~~~~~~~~~~~~~~~
+
+  The system operator can run a PTP (Precision Time Protocol) client application
+  to synchronize the time on the network card in ACC
+  (and optionally the time on the system) to the PTP primary.
+
+  IDPF PMD supports PTP client applications that use the DPDK IEEE 1588 API
+  to communicate with the PTP primary clock.
+  Note that PTP client application needs to run on PF in ACC.
+
+  .. code-block:: console
+
+    examples/dpdk-ptpclient -l 0-3 -n 3 -a 0000:ec:00.1 -- -T 1 -p 0x1
diff --git a/doc/guides/rel_notes/release_26_03.rst b/doc/guides/rel_notes/release_26_03.rst
index afdf1af06c..16b5a0b0b1 100644
--- a/doc/guides/rel_notes/release_26_03.rst
+++ b/doc/guides/rel_notes/release_26_03.rst
@@ -63,6 +63,10 @@ New Features
 
   * The timestamp value has been updated to make it usable.
 
+* **Updated Intel idpf ethernet driver.**
+
+  * Added support for time sync features.
+
 * **Updated Intel iavf driver.**
 
   * Added support for pre and post VF reset callbacks.
-- 
2.47.1

