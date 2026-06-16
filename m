Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35B45CD98E1
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Jun 2026 13:10:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7392D40289;
	Tue, 16 Jun 2026 15:10:09 +0200 (CEST)
Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com
 [113.46.200.226])
 by mails.dpdk.org (Postfix) with ESMTP id CE3384026A
 for <dev@dpdk.org>; Tue, 16 Jun 2026 15:10:07 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=X7cmSJ3/jtG2PfSYBryGM6RLmHw6vfqbsraicO1/R3Y=;
 b=Q8RDB/xM4TEeB4XQVOlRF4D2nXnDVjzUFZjj9oRmGDX7Q9rbX4Ok6Sjnm2mKHxBAem8/R8irg
 B4RX2zoZWyLYGLMY2HNRhW+SeJWPn2DyLYbYr4sfO0tyDySb2F7iL6pon+uJdXRue/ORZNnY/73
 7CBLruV9Ue44PpwpiHcmW28=
Received: from mail.maildlp.com (unknown [172.19.163.200])
 by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gfnFQ3LwszKm4C;
 Tue, 16 Jun 2026 21:02:02 +0800 (CST)
Received: from kwepemj100018.china.huawei.com (unknown [7.202.194.12])
 by mail.maildlp.com (Postfix) with ESMTPS id EA5934055B;
 Tue, 16 Jun 2026 21:10:02 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemj100018.china.huawei.com (7.202.194.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 16 Jun 2026 21:10:02 +0800
From: Xingui Yang <yangxingui@huawei.com>
To: <dev@dpdk.org>
CC: <stephen@networkplumber.org>, <david.marchand@redhat.com>,
 <aman.deep.singh@intel.com>, <fengchengwen@huawei.com>,
 <yangshuaisong@h-partners.com>, <lihuisong@huawei.com>,
 <liuyonglong@huawei.com>, <kangfenglong@huawei.com>
Subject: [PATCH v2] app/testpmd: add VLAN priority insert support
Date: Tue, 16 Jun 2026 21:10:01 +0800
Message-ID: <20260616131001.2955655-1-yangxingui@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260612081411.2798403-1-yangxingui@huawei.com>
References: <20260612081411.2798403-1-yangxingui@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.50.163.32]
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemj100018.china.huawei.com (7.202.194.12)
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

The tx_vlan set and tx_qinq set commands only accepted VLAN ID in range
[0, 4095]. This prevented users from setting 802.1p priority and CFI
bits when using hardware VLAN insertion.

Since mbuf vlan_tci field already supports full 16-bit VLAN Tag Control
Information (TCI), relax the validation for TX paths to allow priority
and CFI bits. The vlan_id parameter now accepts:
  - Bits 0-11:  VLAN ID (0-4095)
  - Bit 12:    CFI (Canonical Format Indicator)
  - Bits 13-15: Priority (0-7, 802.1p CoS)

Suggested-by: Stephen Hemminger <stephen@networkplumber.org>
Suggested-by: fengchengwen <fengchengwen@huawei.com>
Signed-off-by: Xingui Yang <yangxingui@huawei.com>
---
v2:
- Removed --enable-vlan-priority option and global variable as suggested
  by Stephen Hemminger. The feature is now always enabled for TX paths
- RX VLAN filter continues to enforce strict VLAN ID validation as
  suggested by fengchengwen
- Added documentation updates for testpmd_funcs.rst and release notes

 app/test-pmd/config.c                       | 13 ++++++++-----
 doc/guides/rel_notes/release_26_07.rst      |  7 +++++++
 doc/guides/testpmd_app_ug/testpmd_funcs.rst | 17 ++++++++++++++---
 3 files changed, 29 insertions(+), 8 deletions(-)

diff --git a/app/test-pmd/config.c b/app/test-pmd/config.c
index 9d457ca88e..38758f9c05 100644
--- a/app/test-pmd/config.c
+++ b/app/test-pmd/config.c
@@ -1241,8 +1241,11 @@ void print_valid_ports(void)
 }
 
 static int
-vlan_id_is_invalid(uint16_t vlan_id)
+vlan_id_is_invalid(uint16_t vlan_id, bool is_tx)
 {
+	if (is_tx)
+		return 0;
+
 	if (vlan_id < 4096)
 		return 0;
 	fprintf(stderr, "Invalid vlan_id %d (must be < 4096)\n", vlan_id);
@@ -6876,7 +6879,7 @@ rx_vft_set(portid_t port_id, uint16_t vlan_id, int on)
 
 	if (port_id_is_invalid(port_id, ENABLED_WARN))
 		return 1;
-	if (vlan_id_is_invalid(vlan_id))
+	if (vlan_id_is_invalid(vlan_id, false))
 		return 1;
 	diag = rte_eth_dev_vlan_filter(port_id, vlan_id, on);
 	if (diag == 0)
@@ -6923,7 +6926,7 @@ tx_vlan_set(portid_t port_id, uint16_t vlan_id)
 	struct rte_eth_dev_info dev_info;
 	int ret;
 
-	if (vlan_id_is_invalid(vlan_id))
+	if (vlan_id_is_invalid(vlan_id, true))
 		return;
 
 	if (ports[port_id].dev_conf.txmode.offloads &
@@ -6954,9 +6957,9 @@ tx_qinq_set(portid_t port_id, uint16_t vlan_id, uint16_t vlan_id_outer)
 	struct rte_eth_dev_info dev_info;
 	int ret;
 
-	if (vlan_id_is_invalid(vlan_id))
+	if (vlan_id_is_invalid(vlan_id, true))
 		return;
-	if (vlan_id_is_invalid(vlan_id_outer))
+	if (vlan_id_is_invalid(vlan_id_outer, true))
 		return;
 
 	ret = eth_dev_info_get_print_err(port_id, &dev_info);
diff --git a/doc/guides/rel_notes/release_26_07.rst b/doc/guides/rel_notes/release_26_07.rst
index 5d7aa8d1bf..e382c7f407 100644
--- a/doc/guides/rel_notes/release_26_07.rst
+++ b/doc/guides/rel_notes/release_26_07.rst
@@ -150,6 +150,13 @@ New Features
   * Added ``eof`` devarg to use link state to signal end of receive file input.
   * Added unit test suite.
 
+* **Added VLAN priority support in testpmd.**
+
+  Added support for setting VLAN priority and CFI bits in ``tx_vlan set``
+  and ``tx_qinq set`` commands. The ``vlan_tci`` parameter now accepts the
+  full 16-bit VLAN Tag Control Information (TCI) format, which includes
+  priority (bits 13-15), CFI (bit 12), and VLAN ID (bits 0-11).
+
 * **Added AI review helpers.**
 
   Added AGENTS.md file for AI review
diff --git a/doc/guides/testpmd_app_ug/testpmd_funcs.rst b/doc/guides/testpmd_app_ug/testpmd_funcs.rst
index f0f2b0758b..b967810b10 100644
--- a/doc/guides/testpmd_app_ug/testpmd_funcs.rst
+++ b/doc/guides/testpmd_app_ug/testpmd_funcs.rst
@@ -1120,15 +1120,26 @@ tx_vlan set
 
 Set hardware insertion of VLAN IDs in packets sent on a port::
 
-   testpmd> tx_vlan set (port_id) vlan_id[, vlan_id_outer]
+   testpmd> tx_vlan set (port_id) vlan_tci[, vlan_tci_outer]
+
+The ``vlan_tci`` parameter accepts the full 16-bit VLAN Tag Control Information (TCI)
+format, which includes:
+
+* Bits 0-11:  VLAN ID (0-4095)
+* Bit 12:    CFI (Canonical Format Indicator)
+* Bits 13-15: Priority (0-7, 802.1p CoS)
 
 For example, set a single VLAN ID (5) insertion on port 0::
 
-   tx_vlan set 0 5
+   testpmd> tx_vlan set 0 5
+
+Or, set a VLAN ID with priority (priority=3, VLAN ID=6) insertion on port 0::
+
+   testpmd> tx_vlan set 0 0x6006
 
 Or, set double VLAN ID (inner: 2, outer: 3) insertion on port 1::
 
-   tx_vlan set 1 2 3
+   testpmd> tx_vlan set 1 2 3
 
 
 tx_vlan set pvid
-- 
2.43.0

