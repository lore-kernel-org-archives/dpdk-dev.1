Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8B54CCF9F8
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Nov 2025 15:52:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C496D40DD7;
	Fri,  7 Nov 2025 16:51:16 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id A381440DCB;
 Fri,  7 Nov 2025 16:51:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762530675; x=1794066675;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=aX6EewRmCdP8f1fl5qZq09o/2EppoUAbik0lSAYDyiE=;
 b=S4/U0pjqbWyleqlaOHGxF8+z5P+1Z9kANp9C7R1Q6EqKLgLu4Af/+ztL
 UeY5kJsxJpMnjblwxTD0cIoqIAYYbp5mt68iTr6PDgUBSL1T6DEUbMB6t
 QBhMb0XSTgWpWE0KCWIS7a4Tubqf10NNpsN/1rnAwmr5Rg6230WXi3zgu
 rkTkB0iSbAxk3yHWzZfVWL0wzflcoToXjIebsFi/MmRQAFUR6+0X+WYsL
 DCHoehV6ZgMqweuZgj8HSQHE0LVcVSrlu/h08+lrs3sCcw8qZtIFY77+i
 rsvByydlbDAetgTAD7soP5HY8TzxcYdGPW9GJCXBpQLCcuVL0iG/ATqil g==;
X-CSE-ConnectionGUID: p2QmnoDaS4qQXyvPktfsqg==
X-CSE-MsgGUID: GUCiDFINRgSgPjuk2zxOQA==
X-IronPort-AV: E=McAfee;i="6800,10657,11606"; a="90151845"
X-IronPort-AV: E=Sophos;i="6.19,287,1754982000"; d="scan'208";a="90151845"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Nov 2025 07:51:14 -0800
X-CSE-ConnectionGUID: q2xVMt1rR3OQFP2xU2gI6w==
X-CSE-MsgGUID: wCQc0X5/R5OP7TPbmR4n4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,287,1754982000"; d="scan'208";a="187321685"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa006.jf.intel.com with ESMTP; 07 Nov 2025 07:51:13 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>, stable@dpdk.org,
 Chenbo Xia <chenbox@nvidia.com>, Nipun Gupta <nipun.gupta@amd.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Tetsuya Mukawa <mtetsuyah@gmail.com>
Subject: [RFC PATCH v2 12/33] bus/pci: remove shadowed variables
Date: Fri,  7 Nov 2025 15:50:08 +0000
Message-ID: <20251107155034.436809-13-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251107155034.436809-1-bruce.richardson@intel.com>
References: <20251106140948.2894678-1-bruce.richardson@intel.com>
 <20251107155034.436809-1-bruce.richardson@intel.com>
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

Remove two instances where we had duplicate shadowed local variables
called "ret". In each case, we could just remove the inner instance,
since the outer value was not needing to be preserved.

Fixes: 03ba15ca65c1 ("vfio: allow mapping MSI-X BARs if kernel allows it")
Fixes: c0ce0577e84d ("pci: consolidate address comparisons")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/bus/pci/linux/pci.c      | 1 -
 drivers/bus/pci/linux/pci_vfio.c | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/bus/pci/linux/pci.c b/drivers/bus/pci/linux/pci.c
index 66d7e09a6e..2ffac82e94 100644
--- a/drivers/bus/pci/linux/pci.c
+++ b/drivers/bus/pci/linux/pci.c
@@ -326,7 +326,6 @@ pci_scan_one(const char *dirname, const struct rte_pci_addr *addr)
 		rte_pci_add_device(dev);
 	} else {
 		struct rte_pci_device *dev2;
-		int ret;
 
 		TAILQ_FOREACH(dev2, &rte_pci_bus.device_list, next) {
 			ret = rte_pci_addr_cmp(&dev->addr, &dev2->addr);
diff --git a/drivers/bus/pci/linux/pci_vfio.c b/drivers/bus/pci/linux/pci_vfio.c
index 8562fdcc6b..242f567ed7 100644
--- a/drivers/bus/pci/linux/pci_vfio.c
+++ b/drivers/bus/pci/linux/pci_vfio.c
@@ -797,7 +797,7 @@ pci_vfio_map_resource_primary(struct rte_pci_device *dev)
 	}
 	/* if we found our MSI-X BAR region, check if we can mmap it */
 	if (vfio_res->msix_table.bar_index != -1) {
-		int ret = pci_vfio_msix_is_mappable(vfio_dev_fd,
+		ret = pci_vfio_msix_is_mappable(vfio_dev_fd,
 				vfio_res->msix_table.bar_index);
 		if (ret < 0) {
 			PCI_LOG(ERR, "Couldn't check if MSI-X BAR is mappable");
-- 
2.48.1

