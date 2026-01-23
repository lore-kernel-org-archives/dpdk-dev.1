Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A8F5C44500
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 Jan 2026 11:28:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9652A40616;
	Thu, 22 Jan 2026 12:28:00 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id 81DD14064A
 for <dev@dpdk.org>; Thu, 22 Jan 2026 12:27:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1769081280; x=1800617280;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=iKVdLrdLfHvI3kKK3JscWx0tWm5j5VJDLU0MyDkkEpU=;
 b=RvG/cYF+qGqd2u4XJFxQnydY/llIA8hzhcCRMSMARhwIILH/wK1gomwS
 hT+pQws5YGgnJ+/VdLXBACddBAAV5pl1wQenXT6rHEspVQu/GPTjJTk5H
 HdC7FD5cgC+6fN64XZUHBDCzlsrchYOdsVQTEFp1Zgd128y8v87ZpnTej
 AQIPX1af64Y6QAQV92F3zEM8t6oxryyyK9QHng1ZPbAa0naSH5ygbZzKk
 H2cReuIUkJOr97mFShXpLm82jHD81fH7YoKPEQRspQEO16pzICjn2dGus
 9QfbkpwsVLuImHJRdb0A+OiAk/f/2n3ssMgVE1iPiUyVbUjDy6cjj5bN3 A==;
X-CSE-ConnectionGUID: pnYxp5WhREqHKWFiv5CqgQ==
X-CSE-MsgGUID: HdL0Ya4bRLKpRr6tzIWLmw==
X-IronPort-AV: E=McAfee;i="6800,10657,11678"; a="74180096"
X-IronPort-AV: E=Sophos;i="6.21,246,1763452800"; d="scan'208";a="74180096"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jan 2026 03:27:59 -0800
X-CSE-ConnectionGUID: FiUWLuzbSSSMhvWk0M00qA==
X-CSE-MsgGUID: TXzDW502TSyXFGndp2AhOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,246,1763452800"; d="scan'208";a="229678135"
Received: from fenlix-mobl.ccr.corp.intel.com ([10.239.252.5])
 by fmviesa002.fm.intel.com with ESMTP; 22 Jan 2026 03:27:53 -0800
From: Soumyadeep Hore <soumyadeep.hore@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com
Cc: rajesh3.kumar@intel.com, aman.deep.singh@intel.com,
 manoj.kumar.subbarao@intel.com
Subject: [PATCH v5 4/4] doc: add PTP IDPF documentation
Date: Thu, 22 Jan 2026 19:04:49 -0500
Message-ID: <20260123000449.188008-5-soumyadeep.hore@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260123000449.188008-1-soumyadeep.hore@intel.com>
References: <20260120191120.137078-4-soumyadeep.hore@intel.com>
 <20260123000449.188008-1-soumyadeep.hore@intel.com>
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
index b99cc18188..1435cb78ca 100644
--- a/doc/guides/nics/idpf.rst
+++ b/doc/guides/nics/idpf.rst
@@ -109,3 +109,18 @@ The paths are chosen based on 2 conditions:
   A value "P" means the offload feature is not supported by vector path.
   If any not supported features are used, idpf vector PMD is disabled
   and the scalar paths are chosen.
+
+Time Synchronization
+~~~~~~~~~~~~~~~~~~~~
+
+The system operator can run a PTP (Precision Time Protocol) client application
+to synchronize the time on the network card in ACC
+(and optionally the time on the system) to the PTP primary.
+
+IDPF PMD supports PTP client applications that use the DPDK IEEE 1588 API
+to communicate with the PTP primary clock.
+Note that PTP client application needs to run on PF in ACC.
+
+.. code-block:: console
+
+   examples/dpdk-ptpclient -l 0-3 -n 3 -a 0000:ec:00.1 -- -T 1 -p 0x1
diff --git a/doc/guides/rel_notes/release_26_03.rst b/doc/guides/rel_notes/release_26_03.rst
index 15dabee7a1..597147f789 100644
--- a/doc/guides/rel_notes/release_26_03.rst
+++ b/doc/guides/rel_notes/release_26_03.rst
@@ -55,6 +55,10 @@ New Features
      Also, make sure to start the actual text at the margin.
      =======================================================
 
+* **Updated Intel idpf ethernet driver.**
+
+  * Added support for Timesync features.
+
 
 Removed Items
 -------------
-- 
2.47.1

