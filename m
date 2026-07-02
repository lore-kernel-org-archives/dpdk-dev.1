Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4D20C43458
	for <dpdk-dev@archiver.kernel.org>; Thu,  2 Jul 2026 20:01:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1F8D640A70;
	Thu,  2 Jul 2026 22:01:26 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id CF6F04067D
 for <dev@dpdk.org>; Thu,  2 Jul 2026 22:01:19 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.224.107])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4grnmq5Ls5zJ46Bm;
 Fri,  3 Jul 2026 04:00:27 +0800 (CST)
Received: from frapema500003.china.huawei.com (unknown [7.182.19.114])
 by mail.maildlp.com (Postfix) with ESMTPS id 2116A4058D;
 Fri,  3 Jul 2026 04:01:18 +0800 (CST)
Received: from localhost.localdomain (10.220.239.45) by
 frapema500003.china.huawei.com (7.182.19.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 2 Jul 2026 22:01:17 +0200
From: Marat Khalili <marat.khalili@huawei.com>
To: Chenbo Xia <chenbox@nvidia.com>, Nipun Gupta <nipun.gupta@amd.com>
CC: <dev@dpdk.org>, <thomas@monjalon.net>, <bruce.richardson@intel.com>
Subject: [PATCH 3/7] doc: fix typos in rte_bus_pci.h
Date: Thu, 2 Jul 2026 21:00:45 +0100
Message-ID: <20260702200050.88710-4-marat.khalili@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260702200050.88710-1-marat.khalili@huawei.com>
References: <f0e4ffa90e57467cb292d7888caa697e@huawei.com>
 <20260702200050.88710-1-marat.khalili@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.220.239.45]
X-ClientProxiedBy: frapema100006.china.huawei.com (7.182.19.111) To
 frapema500003.china.huawei.com (7.182.19.114)
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

This file contained a couple of doxygen typos that prevented successful
documentation build. It was not discovered previously because the driver
despite the presence of public headers was not included in the
documentation build.

Fix doxygen typos (replace `@bar` with `@p bar`).

Signed-off-by: Marat Khalili <marat.khalili@huawei.com>
---
 drivers/bus/pci/rte_bus_pci.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bus/pci/rte_bus_pci.h b/drivers/bus/pci/rte_bus_pci.h
index 19a7b15b99fd..22a7beb1fc4c 100644
--- a/drivers/bus/pci/rte_bus_pci.h
+++ b/drivers/bus/pci/rte_bus_pci.h
@@ -222,7 +222,7 @@ int rte_pci_write_config(const struct rte_pci_device *device,
  * @param len
  *   The length of the data buffer.
  * @param offset
- *   The offset into MMIO space described by @bar.
+ *   The offset into MMIO space described by @p bar.
  * @return
  *   Number of bytes read on success, negative on error.
  */
@@ -246,7 +246,7 @@ int rte_pci_mmio_read(const struct rte_pci_device *device, int bar,
  * @param len
  *   The length of the data buffer.
  * @param offset
- *   The offset into MMIO space described by @bar.
+ *   The offset into MMIO space described by @p bar.
  * @return
  *   Number of bytes written on success, negative on error.
  */
-- 
2.43.0

