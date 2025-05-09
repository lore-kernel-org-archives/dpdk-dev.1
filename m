Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DEB0C3ABC3
	for <dpdk-dev@archiver.kernel.org>; Fri,  9 May 2025 04:24:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 74D6D40647;
	Fri,  9 May 2025 06:24:14 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id 3D9724026B
 for <dev@dpdk.org>; Fri,  9 May 2025 06:24:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746764651; x=1778300651;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=8svDvGCPSkyhtLpcci8qdaC1rbQwVVIBIxWmjBBqLQU=;
 b=UHEZnioTOjpixeftse1ezBAJee55qgvA/qsysdGsLiwMpwb45L7D6eoN
 LHQ+397wzti+AVaOMG/DTZ1SQP1ASTct8AivTP7bULvoOMpIrXmLqj9Me
 G84w5+QhYioPXD+1oLUm2noul9MPhJvtwew9lviyJ7kooSPE6DCv1yA2T
 +cqYhhzvi2P/vWApEgSzTgti365OMnUiZ7s5/uUn/zwQCFwcPWHv86KXk
 ZIFxxwA3ifXR36YxgdojGFmFFXNpB14c45IS63foevlrqBHzf/ZPM94dn
 i8tMACBH1VSbUf75yfiCM430zxRx0Zosln/WoGdpM3dPflU0tVKN/BVvq A==;
X-CSE-ConnectionGUID: xLBCyIs6RP+qrP2o/2su9w==
X-CSE-MsgGUID: E47flWGCSUuh/a3EyZ7t/w==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="48692430"
X-IronPort-AV: E=Sophos;i="6.15,274,1739865600"; d="scan'208";a="48692430"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2025 21:24:10 -0700
X-CSE-ConnectionGUID: uruLKRfeRQaMGOVCh2swjg==
X-CSE-MsgGUID: Hd48eo/aR6eUdxs1O97i2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,274,1739865600"; d="scan'208";a="136388818"
Received: from txanpdk02.an.intel.com ([10.123.117.76])
 by orviesa010.jf.intel.com with ESMTP; 08 May 2025 21:24:10 -0700
From: Pravin Pathak <pravin.pathak@intel.com>
To: dev@dpdk.org
Cc: jerinj@marvell.com, mike.ximing.chen@intel.com, bruce.richardson@intel.com,
 thomas@monjalon.net, david.marchand@redhat.com, nipun.gupta@amd.com,
 chenbox@nvidia.com, tirthendu.sarkar@intel.com,
 Pravin Pathak <pravin.pathak@intel.com>
Subject: [PATCH v1 3/7] event/dlb2: return 96 single link ports for DLB2.5
Date: Thu,  8 May 2025 23:23:57 -0500
Message-Id: <20250509042401.2634765-4-pravin.pathak@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250509042401.2634765-1-pravin.pathak@intel.com>
References: <20250509042401.2634765-1-pravin.pathak@intel.com>
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

DLB 2.0 device has 64 single linked or directed ports.
DLB 2.5 device has 96 single linked ports.
This commit fixes issue of rte_event_dev_info_get returning 64
instead of 96 single link ports for DLB2.5

Signed-off-by: Pravin Pathak <pravin.pathak@intel.com>
---
 drivers/event/dlb2/dlb2.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/event/dlb2/dlb2.c b/drivers/event/dlb2/dlb2.c
index 58eb27f495..24c56a7968 100644
--- a/drivers/event/dlb2/dlb2.c
+++ b/drivers/event/dlb2/dlb2.c
@@ -241,16 +241,16 @@ dlb2_hw_query_resources(struct dlb2_eventdev *dlb2)
 	 * The capabilities (CAPs) were set at compile time.
 	 */
 
-	if (dlb2->max_cq_depth != DLB2_DEFAULT_CQ_DEPTH)
-		num_ldb_ports = DLB2_MAX_HL_ENTRIES / dlb2->max_cq_depth;
-	else
-		num_ldb_ports = dlb2->hw_rsrc_query_results.num_ldb_ports;
+	num_ldb_ports = dlb2->hw_rsrc_query_results.num_ldb_ports;
 
 	evdev_dlb2_default_info.max_event_queues =
 		dlb2->hw_rsrc_query_results.num_ldb_queues;
 
 	evdev_dlb2_default_info.max_event_ports = num_ldb_ports;
 
+	evdev_dlb2_default_info.max_single_link_event_port_queue_pairs =
+		dlb2->hw_rsrc_query_results.num_dir_ports;
+
 	if (dlb2->version == DLB2_HW_V2_5) {
 		evdev_dlb2_default_info.max_num_events =
 			dlb2->hw_rsrc_query_results.num_credits;
-- 
2.25.1

