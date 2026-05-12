Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 181B8CD4855
	for <dpdk-dev@archiver.kernel.org>; Tue, 12 May 2026 09:23:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4945A40651;
	Tue, 12 May 2026 11:23:14 +0200 (CEST)
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com
 [113.46.200.216])
 by mails.dpdk.org (Postfix) with ESMTP id 40B72400D7
 for <dev@dpdk.org>; Tue, 12 May 2026 11:23:11 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=oKnwkzLJ0ffjNodt8Ib2Mj55skPdVO63fRExaaLYyVw=;
 b=pHeONLmXY/Xe/iMtcqL6rVPSsMUXpwPUmUqoeE/iMRgPOs4VK3DYDFkUqSrgj74Sa4p1dVdNi
 5oHZnBPxQ3bdjz/rWhp7GSptLSNQ9UeKUAUORIRpsUvTEnCts8mjkU6XsIUsPowbwfyXFtvLfZ7
 HnBqWIC6hIIowQzSUkUoyUE=
Received: from mail.maildlp.com (unknown [172.19.163.0])
 by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4gF9t85V17z1T4G1;
 Tue, 12 May 2026 17:15:28 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id B0AE24056B;
 Tue, 12 May 2026 17:23:08 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 12 May 2026 17:23:08 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <thomas@monjalon.net>, <stephen@networkplumber.org>
CC: <dev@dpdk.org>, <wathsala.vithanage@arm.com>, <liuyonglong@huawei.com>
Subject: [PATCH v2 0/4] Introduce generic cache stash API and PCIe TPH
 implementation
Date: Tue, 12 May 2026 17:22:58 +0800
Message-ID: <20260512092302.23735-1-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260508092855.51987-1-fengchengwen@huawei.com>
References: <20260508092855.51987-1-fengchengwen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.50.163.32]
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
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
   series (v9 version), which is not yet merged upstream:
   https://lore.kernel.org/all/20260512080329.42593-1-fengchengwen@huawei.com/

2. The API design and cache stash model learn from the prior  work
   by Wathsala Vithanage: "An API for Cache Stashing with TPH".

3. The e1000/igb PMD is enabled as the first user of this API
   because it is the only PCIe TPH capable hardware available
   for testing at this time. The generic API design is extensible
   to other NICs and future cache stash mechanisms.

--
v2: Sync kernel side v9
    Move vfio interface to kernel/linux/uapi/linux/vfio.h
    Fix CI compile error

Chengwen Feng (4):
  bus/pci: introduce PCIe TPH support
  ethdev: introduce generic cache stash API
  net/e1000: add cache stash support via TPH
  app/testpmd: add TPH stash objects configuration

 app/test-pmd/parameters.c               |  20 +++
 app/test-pmd/testpmd.c                  |  81 ++++++++++
 app/test-pmd/testpmd.h                  |   1 +
 drivers/bus/pci/bsd/pci.c               |  51 ++++++
 drivers/bus/pci/linux/pci.c             |  48 ++++++
 drivers/bus/pci/linux/pci_init.h        |   9 ++
 drivers/bus/pci/linux/pci_vfio.c        | 164 +++++++++++++++++++
 drivers/bus/pci/rte_bus_pci.h           | 114 +++++++++++++
 drivers/bus/pci/windows/pci.c           |  51 ++++++
 drivers/net/intel/e1000/base/e1000_hw.h |   2 +
 drivers/net/intel/e1000/base/e1000_vf.h |   2 +
 drivers/net/intel/e1000/igb_ethdev.c    | 205 ++++++++++++++++++++++++
 kernel/linux/uapi/linux/vfio.h          |  41 +++++
 lib/ethdev/ethdev_driver.h              |  37 +++++
 lib/ethdev/rte_ethdev.c                 |  40 +++++
 lib/ethdev/rte_ethdev.h                 |  95 +++++++++++
 lib/pci/rte_pci.h                       |   1 +
 17 files changed, 962 insertions(+)

-- 
2.17.1

