Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D31BCCD342F
	for <dpdk-dev@archiver.kernel.org>; Fri,  8 May 2026 09:29:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E69E040268;
	Fri,  8 May 2026 11:29:07 +0200 (CEST)
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com
 [113.46.200.222])
 by mails.dpdk.org (Postfix) with ESMTP id 212594013F
 for <dev@dpdk.org>; Fri,  8 May 2026 11:29:06 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=d3cF91JzEnPdw/R4w0Ug9P+MXPoP/u26g04nxUj/2VY=;
 b=O4HMNCZLIgYVX7aqyKWHYicftI2c3auZCcrhqEXwGSJ2xSsLE8WuR/ezYDL8EUdyZZJEjQ1cQ
 YCJuwJ1KzrBGOoOuhP1jFYtV3EReWNmNCm+Mu/iB59QCmQTHJgi21UhFrKWL0c1AE13q/HtC+zX
 SI2VVTxwhg1urEyT2MZs7wA=
Received: from mail.maildlp.com (unknown [172.19.163.163])
 by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4gBkBy6ClkzLlTt;
 Fri,  8 May 2026 17:21:30 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 71DD04048B;
 Fri,  8 May 2026 17:29:04 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 8 May 2026 17:29:04 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <thomas@monjalon.net>, <stephen@networkplumber.org>
CC: <dev@dpdk.org>, <wathsala.vithanage@arm.com>
Subject: [PATCH v1 0/4] Introduce generic cache stash API and PCIe TPH
 implementation
Date: Fri, 8 May 2026 17:28:51 +0800
Message-ID: <20260508092855.51987-1-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.50.163.32]
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemk500009.china.huawei.com (7.202.194.94)
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

This patch set introduces a generic ethdev cache stash framework,
provides PCIe TPH (Transaction Processing Hints) implementation
on PCI/VFIO bus, enables TPH cache stash support for e1000/igb PMD,
and adds testpmd command line configuration.

The patchset is organized as follows:
- Patch 1/4: bus/pci: introduce PCIe TPH support
  Add generic PCIe TPH APIs and VFIO backend implementation,
  with stub implementations for BSD and Windows.

- Patch 2/4: ethdev: introduce generic cache stash API
  Define unified cache stash capability/operation/config abstraction,
  support device-level and per-queue stash management.

- Patch 3/4: net/e1000: add cache stash support via TPH
  Implement ethdev cache stash ops for igb PMD based on PCIe TPH.

- Patch 4/4: app/testpmd: add TPH stash objects configuration
  Add testpmd CLI option to configure stash objects and
  automatically apply stash enable/disable on forwarding start/stop.

Note:
1. This implementation references the Linux kernel VFIO TPH uapi
   series (v8 version), which is not yet merged upstream:
   https://lore.kernel.org/all/20260508064053.37529-1-fengchengwen@huawei.com/

2. The API design and cache stash model learn from the prior  work
   by Wathsala Vithanage: "An API for Cache Stashing with TPH".

3. The e1000/igb PMD is enabled as the first user of this API
   because it is the only PCIe TPH capable hardware available
   for testing at this time. The generic API design is extensible
   to other NICs and future cache stash mechanisms.

Chengwen Feng (4):
  bus/pci: introduce PCIe TPH support
  ethdev: introduce generic cache stash API
  net/e1000: add cache stash support via TPH
  app/testpmd: add TPH stash objects configuration

 app/test-pmd/parameters.c               |  20 ++
 app/test-pmd/testpmd.c                  |  81 +++++++
 app/test-pmd/testpmd.h                  |   1 +
 drivers/bus/pci/bsd/pci.c               |  50 +++++
 drivers/bus/pci/linux/pci.c             |  48 +++++
 drivers/bus/pci/linux/pci_init.h        |   9 +
 drivers/bus/pci/linux/pci_vfio.c        | 272 ++++++++++++++++++++++++
 drivers/bus/pci/rte_bus_pci.h           | 112 ++++++++++
 drivers/bus/pci/windows/pci.c           |  50 +++++
 drivers/net/intel/e1000/base/e1000_hw.h |   2 +
 drivers/net/intel/e1000/base/e1000_vf.h |   2 +
 drivers/net/intel/e1000/igb_ethdev.c    | 221 +++++++++++++++++++
 lib/ethdev/ethdev_driver.h              |  37 ++++
 lib/ethdev/rte_ethdev.c                 |  40 ++++
 lib/ethdev/rte_ethdev.h                 |  95 +++++++++
 15 files changed, 1040 insertions(+)

-- 
2.17.1

