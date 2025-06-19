Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3078BC71136
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Jun 2025 04:03:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5593142E0C;
	Thu, 19 Jun 2025 06:03:29 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id CA9A342DDE;
 Thu, 19 Jun 2025 06:03:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750305808; x=1781841808;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=g4B+RmbDR0iz7DpgqP6Qs6OpGR735pNl5dfwKoFU6GI=;
 b=T0rZ4RL1/uEiPXZrphmH0P7DjoX1ZHMpksJ69R1xix/0boCwPuW5gyZU
 dEEqxVQVKx2ef9+nLVlm61VvmYByHchVejXEWMzSsC1cB0cdXPrI9Wokz
 ek7O39fIkvKy9aY+AU7u4NgrMBVhu+TrN2DVtgdS7VwBSDqZz/hvrvyrJ
 lWLSZ1+8QnuZ6m95JJ4fNLQTNKkMhjzi0JMLSxY0BL2Q0An4SmtnuuD0G
 f/2g+F9o8JfmBmfj0rG7CTR4xj1S/jP3G6ei9fpLfa7i8L0vtBHTYSKx2
 CX7zYnWgMN4gr9ajNiQsOcDiYi7QI8O6gH9X4+BPd3myR0aTo/jDR7Fjv g==;
X-CSE-ConnectionGUID: VRZrqDdmSYa2qaNu8wNMUw==
X-CSE-MsgGUID: WSXGdf2USTmt1MtMro9wIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11468"; a="63592753"
X-IronPort-AV: E=Sophos;i="6.16,247,1744095600"; d="scan'208";a="63592753"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jun 2025 21:03:28 -0700
X-CSE-ConnectionGUID: u4yhkPNuQL+5U2DfIJVlaA==
X-CSE-MsgGUID: OWvavU5XRRO7e1NoanDmZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,247,1744095600"; d="scan'208";a="150665513"
Received: from txanpdk02.an.intel.com ([10.123.117.76])
 by orviesa007.jf.intel.com with ESMTP; 18 Jun 2025 21:03:26 -0700
From: Pravin Pathak <pravin.pathak@intel.com>
To: dev@dpdk.org
Cc: jerinj@marvell.com, mike.ximing.chen@intel.com, bruce.richardson@intel.com,
 thomas@monjalon.net, david.marchand@redhat.com, nipun.gupta@amd.com,
 chenbox@nvidia.com, tirthendu.sarkar@intel.com,
 Pravin Pathak <pravin.pathak@intel.com>, stable@dpdk.org
Subject: [PATCH v4 3/7] event/dlb2: fix num single link ports for DLB2.5
Date: Wed, 18 Jun 2025 23:03:12 -0500
Message-Id: <20250619040316.317733-4-pravin.pathak@intel.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20250619040316.317733-1-pravin.pathak@intel.com>
References: <20250509042401.2634765-1-pravin.pathak@intel.com>
 <20250619040316.317733-1-pravin.pathak@intel.com>
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

Fixes: 4ce7bf9ec1c7 ("event/dlb2: add v2.5 get resources")
Cc: stable@dpdk.org

Signed-off-by: Pravin Pathak <pravin.pathak@intel.com>
---
 drivers/event/dlb2/dlb2.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/event/dlb2/dlb2.c b/drivers/event/dlb2/dlb2.c
index 8722e62948..69dc3cf7c9 100644
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
2.39.1

