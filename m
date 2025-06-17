Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AF72C71157
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Jun 2025 18:27:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BFB9341611;
	Tue, 17 Jun 2025 20:26:44 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 827DF42790;
 Tue, 17 Jun 2025 20:26:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750184803; x=1781720803;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=KuhRL2cSETQ2JZlcP59kfakP04WAYTGo9+u0rkJI0kM=;
 b=D97DdYQi+hynpPO6yONzepTAxBRLGpVljDe4JtUd8PMRm2lDWk0yNxDV
 npM1crxzcJO/IrR1LHQA1qXBPtLoI6gcd3BOd9X4IHzs3n6j1sZmgZ8cu
 TlubH/qCgWx0M+S9yuoaTQ7SAlhBqpt1OYDf0OztS/pI2781YvdEcF1U/
 1fVVx2A6coOAso84ZB7opQEjYFxT4XigEFOqYBlHwLsp7bPbyTPiv8wPa
 Vj3OiNoBDCA5dYMvqIgxXRZyL+JDx5lIIXHzFPMR6cqDQCbufp6+KOJ+r
 wwqdYrN1KjOkWXeFafo3IjxWRubxihGzZqkx13FbQ3tMN7iR4hICK/JuU A==;
X-CSE-ConnectionGUID: 2I12Z0ofQ5+b33nWNfSBjQ==
X-CSE-MsgGUID: q/jjtNw1Q+KAlYomiMwDUA==
X-IronPort-AV: E=McAfee;i="6800,10657,11467"; a="63737729"
X-IronPort-AV: E=Sophos;i="6.16,244,1744095600"; d="scan'208";a="63737729"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jun 2025 11:26:42 -0700
X-CSE-ConnectionGUID: 1jXJ6TIvQUuAOXzD5H0gcA==
X-CSE-MsgGUID: GLwTmWHvRgywC/faDzI7DQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,244,1744095600"; d="scan'208";a="153622648"
Received: from txanpdk02.an.intel.com ([10.123.117.76])
 by orviesa003.jf.intel.com with ESMTP; 17 Jun 2025 11:26:41 -0700
From: Pravin Pathak <pravin.pathak@intel.com>
To: dev@dpdk.org
Cc: jerinj@marvell.com, mike.ximing.chen@intel.com, bruce.richardson@intel.com,
 thomas@monjalon.net, david.marchand@redhat.com, nipun.gupta@amd.com,
 chenbox@nvidia.com, tirthendu.sarkar@intel.com,
 Pravin Pathak <pravin.pathak@intel.com>, stable@dpdk.org
Subject: [PATCH v3 3/7] event/dlb2: fix num single link ports for DLB2.5
Date: Tue, 17 Jun 2025 13:26:26 -0500
Message-Id: <20250617182631.257612-4-pravin.pathak@intel.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20250617182631.257612-1-pravin.pathak@intel.com>
References: <20250509042401.2634765-1-pravin.pathak@intel.com>
 <20250617182631.257612-1-pravin.pathak@intel.com>
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
2.39.1

