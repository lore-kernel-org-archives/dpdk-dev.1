Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A2FEC61DB9
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Aug 2026 15:17:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AFEEF40E1C;
	Thu, 27 Aug 2026 17:15:23 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id 33A66406A2
 for <dev@dpdk.org>; Thu, 27 Aug 2026 17:15:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787843719; x=1819379719;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=C3MYF0hjxfZNAxumfTAijSfCiAsGC3t4oi8t7OvZP20=;
 b=K5XjmMv2/nb1jpikHaRpzJlN9JO66zD2LpV03lOa7jcBJXU+ik8XCBuR
 ejW9ULyTfie2+D9C7CT3AZti5LSP1AtoODkVDBx086+YDYbj0DpWZ3mJp
 5tUOQUMc5BazClY4wkQa5VWyhd0CzVcBIWC991ILTYxHr866yKKjdA6gr
 xG6Fj0i9A+UE4jJcDplhYO6qBV0OMgp8VBP7SFFVBzlr2wWcDnSTQzJ2W
 Zc/bwqu2s4MXEQ7XZFxehDaAJlG4pCcJUl1+UsqnoxXjIt5cXbUnXQRBO
 qImsWT9bolRdyI5bYOU44zQpG8+BFBTrv82NKB+3QE9YlWJ8+niH/8955 A==;
X-CSE-ConnectionGUID: 7ErrgqE6QVODXNXPslAlSQ==
X-CSE-MsgGUID: Toxy8vueSkupgqmqQYTfzw==
X-IronPort-AV: E=McAfee;i="6800,10657,11888"; a="88371665"
X-IronPort-AV: E=Sophos;i="6.25,246,1779174000"; d="scan'208";a="88371665"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Aug 2026 08:15:18 -0700
X-CSE-ConnectionGUID: wk34xmWuRzK0PDNUmMrTkg==
X-CSE-MsgGUID: pYhSrHZsSeqm14eCKq/23A==
X-ExtLoop1: 1
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa003.fm.intel.com with ESMTP; 27 Aug 2026 08:15:18 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Christian Koue Muf <ckm@napatech.com>,
 Serhii Iliushyk <sil-plv@napatech.com>
Subject: [PATCH v13 22/24] net/ntnic: use the new VFIO mode API
Date: Thu, 27 Aug 2026 16:14:25 +0100
Message-ID: <daf66536e15afdc96cc2b2a4ac796004812f9633.1787843386.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1787843385.git.anatoly.burakov@intel.com>
 <cover.1787843385.git.anatoly.burakov@intel.com>
References: 
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

Use new VFIO mode API to query no-IOMMU status.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/ntnic/ntnic_ethdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ntnic/ntnic_ethdev.c b/drivers/net/ntnic/ntnic_ethdev.c
index d9744a7d05..45629a567d 100644
--- a/drivers/net/ntnic/ntnic_ethdev.c
+++ b/drivers/net/ntnic/ntnic_ethdev.c
@@ -2690,7 +2690,7 @@ nthw_pci_probe(struct rte_pci_driver *pci_drv, struct rte_pci_device *pci_dev)
 			(pci_dev->device.devargs->data ? pci_dev->device.devargs->data : "NULL"));
 	}
 
-	const int n_dev_vfio_no_io_mmu_enabled = dev_vfio_noiommu_is_enabled();
+	const int n_dev_vfio_no_io_mmu_enabled = dev_vfio_get_mode() == DEV_VFIO_MODE_NOIOMMU;
 	NT_LOG(DBG, NTNIC, "vfio_no_iommu_enabled=%d", n_dev_vfio_no_io_mmu_enabled);
 
 	if (n_dev_vfio_no_io_mmu_enabled) {
-- 
2.52.0

