Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38138C3ABC3
	for <dpdk-dev@archiver.kernel.org>; Fri,  9 May 2025 04:24:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7B40A40653;
	Fri,  9 May 2025 06:24:19 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id D4A624026C
 for <dev@dpdk.org>; Fri,  9 May 2025 06:24:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746764655; x=1778300655;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=d+YenHyAu1G+VVJHHk9b4oe7HNPU+iPNr5nQvbRjne4=;
 b=UuNtd3kADIHLgjSZ6qvPDILjuvCplqfpPGRF/ppnlNPpYY272JjHoZ49
 TlIAuJGpvpNZKnC+RV+f/B4zSbMDIsaxNKqPuZl1ksJsliAHaLQBTjNGA
 ZJJ+u94Ojx3VanBd9kJWXg0/CWM4JBLYMEnE116RxRAvggdzGsFH0meBZ
 DQTbOnjceTRO2LwVY6E8Yi5sRa6OgnYCvjeEtQwo9OkLa69d2dr03PcVQ
 72Pi+w1ZWdluMVJgUneOeK3/xdxAc72YphSmNFlXHJYkvm+fi5Zz7kTb5
 tS3ou1XE9Cz/LH0kWNxwoAMowazBVLJWxbbcuP5H4S4IGLKhmbRp3umxy A==;
X-CSE-ConnectionGUID: xJJfPRsSTWCHtc8UgI/7EQ==
X-CSE-MsgGUID: 1HxsZMjmRZi6p2TnIsuPEA==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="48692459"
X-IronPort-AV: E=Sophos;i="6.15,274,1739865600"; d="scan'208";a="48692459"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2025 21:24:14 -0700
X-CSE-ConnectionGUID: 36e6GkU3T1i+vmhcLj0EIw==
X-CSE-MsgGUID: xzypfrvnRCW+17wyfkiRaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,274,1739865600"; d="scan'208";a="136388890"
Received: from txanpdk02.an.intel.com ([10.123.117.76])
 by orviesa010.jf.intel.com with ESMTP; 08 May 2025 21:24:14 -0700
From: Pravin Pathak <pravin.pathak@intel.com>
To: dev@dpdk.org
Cc: jerinj@marvell.com, mike.ximing.chen@intel.com, bruce.richardson@intel.com,
 thomas@monjalon.net, david.marchand@redhat.com, nipun.gupta@amd.com,
 chenbox@nvidia.com, tirthendu.sarkar@intel.com
Subject: [PATCH v1 7/7] event/dlb2: fix default credits in
 dlb2_eventdev_info_get()
Date: Thu,  8 May 2025 23:24:01 -0500
Message-Id: <20250509042401.2634765-8-pravin.pathak@intel.com>
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

