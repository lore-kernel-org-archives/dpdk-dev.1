Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7D6CC71159
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Jun 2025 04:04:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B670F42E56;
	Thu, 19 Jun 2025 06:03:38 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id A0F1042DD9;
 Thu, 19 Jun 2025 06:03:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750305817; x=1781841817;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=sryi5bJzt5NS2SSfwAP1n52F69RkCOyT/rfU7Gn5THk=;
 b=DEwpfSknX/JeKNFugNvqORbpvFfgoeetwAzn0gtubfr7NovShwCoitTy
 okeniHG54lIjMwTuYp30Ch0PY7wwYxJcxFOx25Atp7gShYdRANAJS8RA7
 aqbtrDMPUHKLBks/9bqQP7RrkvwrlJp3Ct0ySFvNh2QLK2xQh4rypK0Oq
 pS3XUALpEv78Cc6LL3OZviIB98ZCnvohKXve8O/3tCuFLWKprsh0fmHKS
 im3vxPEvX2RgBpGaSVzLWFzvzg3h0UerFzzAXjVccwRTn2g6FrgbUBGEB
 A8Mi0USQ2bHC6egADVs5maHLiqzIZQn5KfR/wbQbMAoNffHc+Bax/s6mo g==;
X-CSE-ConnectionGUID: OGOjFl0wR1OrPFS0KTSGDg==
X-CSE-MsgGUID: Ds3AstoLRYqYXF18K+c9Aw==
X-IronPort-AV: E=McAfee;i="6800,10657,11468"; a="63592787"
X-IronPort-AV: E=Sophos;i="6.16,247,1744095600"; d="scan'208";a="63592787"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jun 2025 21:03:36 -0700
X-CSE-ConnectionGUID: ZjkWHDfoQHyvDW2rwtd1hQ==
X-CSE-MsgGUID: gxRoqyHWS1yc/W3Yrc6i7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,247,1744095600"; d="scan'208";a="150665574"
Received: from txanpdk02.an.intel.com ([10.123.117.76])
 by orviesa007.jf.intel.com with ESMTP; 18 Jun 2025 21:03:35 -0700
From: Pravin Pathak <pravin.pathak@intel.com>
To: dev@dpdk.org
Cc: jerinj@marvell.com, mike.ximing.chen@intel.com, bruce.richardson@intel.com,
 thomas@monjalon.net, david.marchand@redhat.com, nipun.gupta@amd.com,
 chenbox@nvidia.com, tirthendu.sarkar@intel.com, stable@dpdk.org
Subject: [PATCH v4 7/7] event/dlb2: fix default credits based on HW version
Date: Wed, 18 Jun 2025 23:03:16 -0500
Message-Id: <20250619040316.317733-8-pravin.pathak@intel.com>
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

From: Tirthendu Sarkar <tirthendu.sarkar@intel.com>

dlb2_eventdev_info_get() that implements rte_event_dev_info_get() should
return the maximum available credits as supported by HW.

Set maximum credits before device probing by checking HW version.

Fixes: b66a418d2ad3 ("event/dlb2: add v2.5 probe")
Cc: stable@dpdk.org

Signed-off-by: Tirthendu Sarkar <tirthendu.sarkar@intel.com>
---
 drivers/event/dlb2/pf/dlb2_pf.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/event/dlb2/pf/dlb2_pf.c b/drivers/event/dlb2/pf/dlb2_pf.c
index 15a06bee4f..edcdfb319f 100644
--- a/drivers/event/dlb2/pf/dlb2_pf.c
+++ b/drivers/event/dlb2/pf/dlb2_pf.c
@@ -789,6 +789,8 @@ dlb2_eventdev_pci_init(struct rte_eventdev *eventdev)
 	if (rte_eal_process_type() == RTE_PROC_PRIMARY) {
 		dlb2 = dlb2_pmd_priv(eventdev); /* rte_zmalloc_socket mem */
 		dlb2->version = DLB2_HW_DEVICE_FROM_PCI_ID(pci_dev);
+		if (dlb2->version == DLB2_HW_V2_5)
+			dlb2_args.max_num_events = DLB2_MAX_NUM_CREDITS(DLB2_HW_V2_5);
 
 		/* Were we invoked with runtime parameters? */
 		if (pci_dev->device.devargs) {
-- 
2.39.1

