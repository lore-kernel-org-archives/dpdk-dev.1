Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F19B9C5AD49
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Jun 2025 18:05:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 11AF94161A;
	Tue,  3 Jun 2025 20:05:25 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id ECCAE41109
 for <dev@dpdk.org>; Tue,  3 Jun 2025 20:05:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748973923; x=1780509923;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=QcSuJSRxv9yMSyLul3pfZIYCbZ5bQdP7ibXezdlpWik=;
 b=JJXK1fFobE/uZimSfD30SCrzJO33coBBXDJcI5piiq6vOGl7npfzobHd
 3f4a0lLeKzgrs1BGLNfMay723KKsWEbFFPd87YR5GZCc+ZnfG6taERl6v
 gZNJ3h30jKzFlLqbZyQFmTHXKP4sqKDQReihEHsSNvNly4ESlkKuCNvj+
 zPGFIY6GnToyTT9veu3D76WbGp0b1SQvr+CMNiPaJZNNoUUVuGkVxZ4J7
 BudZXiRhIj6KZ7BK+upZBVwfM2YX/ygiCISwa5O91wQ7ROO5Ms5jluT/+
 UWX5eFHebeHaqtN4mynCtfpZizDYpoAck+8ULvm1QPNZuCGxpv/x4B4fB w==;
X-CSE-ConnectionGUID: GCD1OqofT3G7c9BMQXK0eg==
X-CSE-MsgGUID: DZDgkwpJTLqCrKyHHBOXNA==
X-IronPort-AV: E=McAfee;i="6700,10204,11453"; a="68463585"
X-IronPort-AV: E=Sophos;i="6.16,206,1744095600"; d="scan'208";a="68463585"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2025 11:05:22 -0700
X-CSE-ConnectionGUID: INvnim1bSv21Awn8tDcGNg==
X-CSE-MsgGUID: m16w1bH3SKuekyK138OaLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,206,1744095600"; d="scan'208";a="168110479"
Received: from txanpdk02.an.intel.com ([10.123.117.76])
 by fmviesa002.fm.intel.com with ESMTP; 03 Jun 2025 11:05:22 -0700
From: Pravin Pathak <pravin.pathak@intel.com>
To: dev@dpdk.org
Cc: jerinj@marvell.com, mike.ximing.chen@intel.com, bruce.richardson@intel.com,
 thomas@monjalon.net, david.marchand@redhat.com, nipun.gupta@amd.com,
 chenbox@nvidia.com, tirthendu.sarkar@intel.com,
 Pravin Pathak <pravin.pathak@intel.com>
Subject: [PATCH v2 3/7] event/dlb2: return 96 single link ports for DLB2.5
Date: Tue,  3 Jun 2025 13:05:10 -0500
Message-Id: <20250603180514.3826917-4-pravin.pathak@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250603180514.3826917-1-pravin.pathak@intel.com>
References: <20250509042401.2634765-1-pravin.pathak@intel.com>
 <20250603180514.3826917-1-pravin.pathak@intel.com>
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
API rte_event_dev_info_get() will return 64 directed
ports for DLB 2.0 and 96 single linked ports for DLB2.5

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

