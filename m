Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF239CCD1A5
	for <dpdk-dev@archiver.kernel.org>; Fri, 24 Oct 2025 09:18:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BDAFD4025E;
	Fri, 24 Oct 2025 11:18:29 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 095F440156;
 Fri, 24 Oct 2025 11:18:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761297508; x=1792833508;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=oQZFkbaVpkMTMXip1ZWaXc4aHT6WGWA0Mr52Ngm/qQQ=;
 b=LU7KWpzqqw80/MnZFHw3+Rs8LtAffHCL/zBMrjh1PbpJ5vkKsxEWZmMc
 j7Nz+rrFmMqVbtqVRNWhIG2WLgXVlLzi/+bhNFsf6Y0QXJZBHWu0QLcwM
 XgUGDdJ9OXJFUO5nDn80fh9mNciYsGKg7ANYtEqouejyLz8ksaaADv+Bf
 EnDEXeIdRI+Wq29UKYXniOiwJj3GTY551ASwvE9Mg4BafgrZCvaINBxNo
 /DrN7iK4Q5TH+14dZYktA25Z5lQX+eJSgJoDkFvnwpAv9Br/PoCy4Lokn
 ngVz9gTlibL56Xn5u7dpzEX5VFYUUt1WRvKjB9ZetYz9BQNfBxjfSF+YS g==;
X-CSE-ConnectionGUID: 9Q3vD7gjSoqSsrdrA3GKvQ==
X-CSE-MsgGUID: m2V/1MBCSfCdZuiKG/d92w==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63368861"
X-IronPort-AV: E=Sophos;i="6.19,252,1754982000"; d="scan'208";a="63368861"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Oct 2025 02:18:27 -0700
X-CSE-ConnectionGUID: XwM/PJmJToaNjGT8xIDgbA==
X-CSE-MsgGUID: dY9O4F3ZQ86K/EJanAwSOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,252,1754982000"; d="scan'208";a="184868712"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa009.fm.intel.com with ESMTP; 24 Oct 2025 02:18:25 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Chenbo Xia <chenbox@nvidia.com>,
 Nipun Gupta <nipun.gupta@amd.com>, Yahui Cao <yahui.cao@intel.com>,
 Sunil Kumar Kori <skori@marvell.com>
Cc: stable@dpdk.org
Subject: [PATCH v1 1/1] bus/pci: fix resource leak in secondary process
Date: Fri, 24 Oct 2025 10:18:24 +0100
Message-ID: <54e4e95f31382c1bb3babee07c107f1e39dc9093.1761297496.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
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

Right after setting up VFIO device, we attempt to fill region information.
This operation can fail, and if it does, we do not release the device fd.
Fix the control flow to free the device fd if getting region info failed.

Fixes: 4b741542ecde ("bus/pci: avoid depending on private kernel value")
Cc: stable@dpdk.org

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/bus/pci/linux/pci_vfio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bus/pci/linux/pci_vfio.c b/drivers/bus/pci/linux/pci_vfio.c
index c63721dd61..8562fdcc6b 100644
--- a/drivers/bus/pci/linux/pci_vfio.c
+++ b/drivers/bus/pci/linux/pci_vfio.c
@@ -932,7 +932,7 @@ pci_vfio_map_resource_secondary(struct rte_pci_device *dev)
 	char pci_addr[PATH_MAX] = {0};
 	int vfio_dev_fd;
 	struct rte_pci_addr *loc = &dev->addr;
-	int i, j, ret;
+	int j, ret, i = 0;
 	struct mapped_pci_resource *vfio_res = NULL;
 	struct mapped_pci_res_list *vfio_res_list =
 		RTE_TAILQ_CAST(rte_vfio_tailq.head, mapped_pci_res_list);
@@ -968,7 +968,7 @@ pci_vfio_map_resource_secondary(struct rte_pci_device *dev)
 
 	ret = pci_vfio_fill_regions(dev, vfio_dev_fd, &device_info);
 	if (ret)
-		return ret;
+		goto err_vfio_dev_fd;
 
 	/* map BARs */
 	maps = vfio_res->maps;
-- 
2.47.3

