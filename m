Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22433FEE4FE
	for <dpdk-dev@archiver.kernel.org>; Sat, 28 Feb 2026 20:35:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8497940BA6;
	Sat, 28 Feb 2026 21:34:57 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id 8B1C840DF5
 for <dev@dpdk.org>; Sat, 28 Feb 2026 21:34:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772310896; x=1803846896;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=s6Z1ENwjPFYA1NwSIC+V4v82gKSA+wjn0MBv4fEU6xE=;
 b=liiFuWGPZkkX9Ur5FmyHsSMkS79sLDXlmsRKTQ2HD1H0FkcbSRWaq6+q
 uNrHa5cUynPMA2tEhB3BUGjXBxuOpskNSNweUGWcSXi98kgx6xMdVLeow
 ZDokoK9nl6+tJGv6bi8DJwr/zz8ASI9c0DHB7MeJcd2e2NPE4vzZygfjF
 QjUMA75qym+UZUlNTqkzRexa7OycG+FBiozKF4POP21sra86iNKS5k8a6
 MFWthtcslSycyIUhohMYMHHSTgnyQrhlOtUv20QgMeWG1+/ZuRbSZtEvQ
 YL7zX4oyrDMQI+FNEdWlfDFE4oW33iveWzK7zcGmGDLty5ZZfpALvXkgw w==;
X-CSE-ConnectionGUID: G5lhH59qR7O0NRePMOERCA==
X-CSE-MsgGUID: b6flvNoDS6qSWehhm9e4kQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11715"; a="84002135"
X-IronPort-AV: E=Sophos;i="6.21,316,1763452800"; d="scan'208";a="84002135"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Feb 2026 12:34:56 -0800
X-CSE-ConnectionGUID: sWMiA6Z5QVauAwv4yZhwBA==
X-CSE-MsgGUID: 5FFZkOQiQZu1I7fXSoiR6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,316,1763452800"; d="scan'208";a="220401548"
Received: from fenlix-mobl.ccr.corp.intel.com ([10.239.252.5])
 by fmviesa004.fm.intel.com with ESMTP; 28 Feb 2026 12:34:54 -0800
From: Soumyadeep Hore <soumyadeep.hore@intel.com>
To: bruce.richardson@intel.com, manoj.kumar.subbarao@intel.com,
 aman.deep.singh@intel.com, dev@dpdk.org
Cc: Rajesh Kumar <rajesh3.kumar@intel.com>
Subject: [PATCH v8 4/4] doc/guides: add PTP IDPF documentation
Date: Sun,  1 Mar 2026 04:10:40 -0500
Message-ID: <20260301091040.10647-5-soumyadeep.hore@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260301091040.10647-1-soumyadeep.hore@intel.com>
References: <20260227003314.439267-5-soumyadeep.hore@intel.com>
 <20260301091040.10647-1-soumyadeep.hore@intel.com>
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
index b4499ec066..ec55a4888e 100644
--- a/doc/guides/rel_notes/release_26_03.rst
+++ b/doc/guides/rel_notes/release_26_03.rst
@@ -73,6 +73,10 @@ New Features
 
   * Added application-initiated device reset.
 
+* **Updated Intel idpf ethernet driver.**
+
+  * Added support for time sync features.
+
 * **Updated Intel iavf driver.**
 
   * Added support for pre and post VF reset callbacks.
-- 
2.47.1

