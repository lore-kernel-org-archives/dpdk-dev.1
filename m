Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41172CCFA1A
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Nov 2025 11:32:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E7F3D40685;
	Tue, 11 Nov 2025 12:32:08 +0100 (CET)
Received: from out28-196.mail.aliyun.com (out28-196.mail.aliyun.com
 [115.124.28.196])
 by mails.dpdk.org (Postfix) with ESMTP id 39D9F40665
 for <dev@dpdk.org>; Tue, 11 Nov 2025 12:32:04 +0100 (CET)
Received: from ubuntu.localdomain(mailfrom:dimon.zhao@nebula-matrix.com
 fp:SMTPD_---.fJvT8AB_1762860720 cluster:ay29) by smtp.aliyun-inc.com;
 Tue, 11 Nov 2025 19:32:00 +0800
From: Dimon Zhao <dimon.zhao@nebula-matrix.com>
To: dev@dpdk.org
Cc: Dimon Zhao <dimon.zhao@nebula-matrix.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Alvin Wang <alvin.wang@nebula-matrix.com>,
 Leon Yu <leon.yu@nebula-matrix.com>, Sam Chen <sam.chen@nebula-matrix.com>
Subject: [PATCH v2 4/4] net/nbl: add IOVA mode check in Coexistence
Date: Tue, 11 Nov 2025 03:31:43 -0800
Message-Id: <20251111113144.3567291-5-dimon.zhao@nebula-matrix.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251111113144.3567291-1-dimon.zhao@nebula-matrix.com>
References: <20251107073459.3532524-1-dimon.zhao@nebula-matrix.com>
 <20251111113144.3567291-1-dimon.zhao@nebula-matrix.com>
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

Add IOVA mode check in Coexistence.
Update MAINTAINERS.
Refresh feature list and Coexistence Usage Instructions.

Signed-off-by: Dimon Zhao <dimon.zhao@nebula-matrix.com>
---
 .mailmap                                 |  2 +-
 MAINTAINERS                              |  2 +-
 doc/guides/nics/features/nbl.ini         |  1 +
 doc/guides/nics/nbl.rst                  |  7 +++++++
 drivers/net/nbl/nbl_common/nbl_userdev.c | 15 ++++++++++++---
 5 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/.mailmap b/.mailmap
index e5f0cab364..0cd4b65d75 100644
--- a/.mailmap
+++ b/.mailmap
@@ -78,6 +78,7 @@ Allen Hubbe <allen.hubbe@amd.com>
 Alok Makhariya <alok.makhariya@nxp.com>
 Alok Prasad <palok@marvell.com>
 Alvaro Karsz <alvaro.karsz@solid-run.com>
+Alvin Wang <alvin.wang@nebula-matrix.com>
 Alvin Zhang <alvinx.zhang@intel.com>
 Aman Singh <aman.deep.singh@intel.com>
 Amaranath Somalapuram <asomalap@amd.com>
@@ -869,7 +870,6 @@ Kumar Amber <kumar.amber@intel.com>
 Kumar Sanghvi <kumaras@chelsio.com>
 Kumara Parameshwaran <kumaraparamesh92@gmail.com> <kparameshwar@vmware.com>
 Kyle Larose <klarose@sandvine.com>
-Kyo Liu <kyo.liu@nebula-matrix.com>
 Lance Richardson <lance.richardson@broadcom.com>
 Laszlo Ersek <lersek@redhat.com>
 Laura Stroe <laura.stroe@intel.com>
diff --git a/MAINTAINERS b/MAINTAINERS
index 7fa01419cf..a0ed5b52d3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1023,8 +1023,8 @@ F: doc/guides/nics/rnp.rst
 F: doc/guides/nics/features/rnp.ini
 
 Nebulamatrix nbl
+M: Alvin Wang <alvin.wang@nebula-matrix.com>
 M: Dimon Zhao <dimon.zhao@nebula-matrix.com>
-M: Kyo Liu <kyo.liu@nebula-matrix.com>
 M: Leon Yu <leon.yu@nebula-matrix.com>
 M: Sam Chen <sam.chen@nebula-matrix.com>
 F: drivers/net/nbl/
diff --git a/doc/guides/nics/features/nbl.ini b/doc/guides/nics/features/nbl.ini
index 784ea3eecb..336a11d3aa 100644
--- a/doc/guides/nics/features/nbl.ini
+++ b/doc/guides/nics/features/nbl.ini
@@ -12,6 +12,7 @@ Unicast MAC filter   = Y
 Basic stats          = Y
 Extended stats       = Y
 Stats per queue      = Y
+VLAN offload         = P
 Linux                = Y
 ARMv8                = Y
 x86-64               = Y
diff --git a/doc/guides/nics/nbl.rst b/doc/guides/nics/nbl.rst
index f41da20eea..0cccb11b49 100644
--- a/doc/guides/nics/nbl.rst
+++ b/doc/guides/nics/nbl.rst
@@ -70,6 +70,13 @@ Anolis community:
 Alternatively, you can contact us to obtain the `nbl_core` code and installation package.
 
 
+Coexistence Between DPDK And Kernel Driver
+------------------------------------------
+When this device is bound to the nbl_core driver and IOMMU is in passthrough mode,
+it is necessary to force I/O virtual address (IOVA) to be mapped to physical address (PA)
+with the EAL command line option ``--iova-mode=pa``.
+
+
 Prerequisites
 -------------
 
diff --git a/drivers/net/nbl/nbl_common/nbl_userdev.c b/drivers/net/nbl/nbl_common/nbl_userdev.c
index bd0305affe..566f3a11ee 100644
--- a/drivers/net/nbl/nbl_common/nbl_userdev.c
+++ b/drivers/net/nbl/nbl_common/nbl_userdev.c
@@ -679,11 +679,20 @@ int nbl_pci_map_device(struct nbl_adapter *adapter)
 
 	NBL_USERDEV_INIT_COMMON(common);
 	iova_mode = rte_eal_iova_mode();
+
+	snprintf(pathname, sizeof(pathname), "/dev/nbl_userdev/" PCI_PRI_FMT, loc->domain,
+		 loc->bus, loc->devid, loc->function);
+
+	/* check iommu passthrough mode */
+	if (!access(pathname, F_OK) && iova_mode != RTE_IOVA_PA) {
+		NBL_LOG(ERR, "%s IOMMU is in passthrough mode, must select IOVA as PA"
+			" with --iova-mode=pa", pci_dev->device.name);
+		ret = -1;
+		return ret;
+	}
+
 	if (iova_mode == RTE_IOVA_PA) {
 		/* check iommu disable */
-		snprintf(pathname, sizeof(pathname),
-			 "/dev/nbl_userdev/" PCI_PRI_FMT, loc->domain,
-			 loc->bus, loc->devid, loc->function);
 		common->devfd = open(pathname, O_RDWR);
 		if (common->devfd >= 0)
 			goto mmap;
-- 
2.34.1

