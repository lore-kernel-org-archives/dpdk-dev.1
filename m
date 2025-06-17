Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9F9DC71157
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Jun 2025 18:27:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0C7FB427A6;
	Tue, 17 Jun 2025 20:26:56 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 8B48B410F6;
 Tue, 17 Jun 2025 20:26:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750184815; x=1781720815;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=0SV8wJbr+zvgoGJ9HbKZFifTwabvGcNjITPqQcouvHs=;
 b=m1SzL6QIgm/kB8+SdnyS4Z/sKlvEXp++h/6W1ioByAZcvBP7hUQD1k6q
 /z7nZ8SdqqSeL3yx6aIqIKDblEoW+Yg1TQYVLlaYUCo5/P0oLKuqQp0Q0
 lomy+Q0KVVt21LoummF1ynOcDxE/hK8ZY+nXRO+ikLUupP4V3GAGdu6Ho
 v95wlqFRgl46HpvsAZAzCBAh4WlAQRQB7BU9aG01RLHJwwLVFLd8A4SpB
 cFlk8xl4Mu2hNmU2QB5Cs5Hd5780jiEDBa4A+YVVJ+0s1Ebi77OilXBZm
 SJyxdrHib2WbLEEBZaavDRuAkA+TzsDQ1THdZZsNNHP+x9x0kNHZa3F5f g==;
X-CSE-ConnectionGUID: rGujYlruThCK3eXauTURfg==
X-CSE-MsgGUID: lsAIpcxHQpWDixmDWTWSoQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11467"; a="63737775"
X-IronPort-AV: E=Sophos;i="6.16,244,1744095600"; d="scan'208";a="63737775"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jun 2025 11:26:54 -0700
X-CSE-ConnectionGUID: CblX/hP9Ssq8wEutZgoKfw==
X-CSE-MsgGUID: eArtnTzERMye4Pv7+w2QuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,244,1744095600"; d="scan'208";a="153622712"
Received: from txanpdk02.an.intel.com ([10.123.117.76])
 by orviesa003.jf.intel.com with ESMTP; 17 Jun 2025 11:26:53 -0700
From: Pravin Pathak <pravin.pathak@intel.com>
To: dev@dpdk.org
Cc: jerinj@marvell.com, mike.ximing.chen@intel.com, bruce.richardson@intel.com,
 thomas@monjalon.net, david.marchand@redhat.com, nipun.gupta@amd.com,
 chenbox@nvidia.com, tirthendu.sarkar@intel.com, stable@dpdk.org
Subject: [PATCH v3 7/7] event/dlb2: fix default credits based on HW version
Date: Tue, 17 Jun 2025 13:26:30 -0500
Message-Id: <20250617182631.257612-8-pravin.pathak@intel.com>
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
2.39.1

