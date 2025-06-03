Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6115FC5AD49
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Jun 2025 18:06:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8AB464278D;
	Tue,  3 Jun 2025 20:05:30 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 739D642759
 for <dev@dpdk.org>; Tue,  3 Jun 2025 20:05:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748973928; x=1780509928;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=d+YenHyAu1G+VVJHHk9b4oe7HNPU+iPNr5nQvbRjne4=;
 b=kGYl4UNRCkHbJgWUnFxYLH1d0Q78k7zSg4HEjj0+j748/eW9xMXiaXOs
 K2nYMrT7ZfK3m10qiLOHhT1wOliynoojKie5315NhhQNVnPeIskiyTlzm
 9FVfo0AwsWf0neDS5mpTUdd1EIbhCmkO5+pbrI76AH96FediowJ5QM76W
 ZjIGEdz7MtO1U76P75zq8EqTbyfyxdKVX+gKVaB1Gz6eNmjR+cQyl2Fx/
 r+8CVZ1IDSZAQDd2dQlmaA/MpmUC6GVTx5b7Ials/O/iiRkX8tqaOe4wT
 peHLO8R3pwiWp/8Uh36CyInPTUui/lahN0UPsCVmq7NLvUCufhyoiq0kL w==;
X-CSE-ConnectionGUID: om4HE3nxS/qP4EY6xI1b1g==
X-CSE-MsgGUID: p3qG8m/XSTKEmyOQ3dX1Dg==
X-IronPort-AV: E=McAfee;i="6700,10204,11453"; a="68463613"
X-IronPort-AV: E=Sophos;i="6.16,206,1744095600"; d="scan'208";a="68463613"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2025 11:05:28 -0700
X-CSE-ConnectionGUID: J0kxWZXvRcOu7DqSK9YhYQ==
X-CSE-MsgGUID: M70Fk9qJSXeElceDMWMEcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,206,1744095600"; d="scan'208";a="168110500"
Received: from txanpdk02.an.intel.com ([10.123.117.76])
 by fmviesa002.fm.intel.com with ESMTP; 03 Jun 2025 11:05:27 -0700
From: Pravin Pathak <pravin.pathak@intel.com>
To: dev@dpdk.org
Cc: jerinj@marvell.com, mike.ximing.chen@intel.com, bruce.richardson@intel.com,
 thomas@monjalon.net, david.marchand@redhat.com, nipun.gupta@amd.com,
 chenbox@nvidia.com, tirthendu.sarkar@intel.com
Subject: [PATCH v2 7/7] event/dlb2: return default credits based on HW version
Date: Tue,  3 Jun 2025 13:05:14 -0500
Message-Id: <20250603180514.3826917-8-pravin.pathak@intel.com>
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

From: Tirthendu Sarkar <tirthendu.sarkar@intel.com>

dlb2_eventdev_info_get() that implements rte_event_dev_info_get() should
return the maximum available credits as supported by HW.

Set maximum credits before device probing by checking HW version.

Signed-off-by: Tirthendu Sarkar <tirthendu.sarkar@intel.com>
---
 drivers/event/dlb2/pf/dlb2_pf.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/event/dlb2/pf/dlb2_pf.c b/drivers/event/dlb2/pf/dlb2_pf.c
index a3f3e7f803..6c273742c9 100644
--- a/drivers/event/dlb2/pf/dlb2_pf.c
+++ b/drivers/event/dlb2/pf/dlb2_pf.c
@@ -756,6 +756,8 @@ dlb2_eventdev_pci_init(struct rte_eventdev *eventdev)
 	if (rte_eal_process_type() == RTE_PROC_PRIMARY) {
 		dlb2 = dlb2_pmd_priv(eventdev); /* rte_zmalloc_socket mem */
 		dlb2->version = DLB2_HW_DEVICE_FROM_PCI_ID(pci_dev);
+		if (dlb2->version == DLB2_HW_V2_5)
+			dlb2_args.max_num_events = DLB2_MAX_NUM_CREDITS(DLB2_HW_V2_5);
 
 		/* Were we invoked with runtime parameters? */
 		if (pci_dev->device.devargs) {
-- 
2.25.1

