Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D24E8C5DF6D
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Aug 2026 05:35:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 595C840A73;
	Wed, 19 Aug 2026 07:34:36 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id 2B11F40655
 for <dev@dpdk.org>; Wed, 19 Aug 2026 07:34:23 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 0BFD61A018B;
 Wed, 19 Aug 2026 07:34:23 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id A0B3C1A0183;
 Wed, 19 Aug 2026 07:34:22 +0200 (CEST)
Received: from lsv03457.swis.in-blr01.nxp.com (lsv03457.swis.in-blr01.nxp.com
 [92.120.147.250])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 2DA0D18000B0;
 Wed, 19 Aug 2026 13:34:22 +0800 (+08)
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org
Cc: hemant.agrawal@nxp.com,
	Gagandeep Singh <g.singh@nxp.com>
Subject: [PATCH v11 11/15] net/enetc4: add per-queue Rx interrupt support for
 VF
Date: Wed, 19 Aug 2026 11:04:11 +0530
Message-Id: <20260819053415.645865-12-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260819053415.645865-1-g.singh@nxp.com>
References: <20260817063454.3290854-1-g.singh@nxp.com>
 <20260819053415.645865-1-g.singh@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
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

Add MSI-X per-queue Rx interrupt support to the ENETC4 VF PMD on the
cacheable (default) Rx path. This allows applications such as l3fwd-power
to block in epoll_wait when no traffic is present, reducing CPU utilization
to near zero.

MSI-X vector 0 is reserved for the PSI-to-VSI mailbox. Rx queue i is
mapped to MSI-X vector i + 1 via ENETC_SIMSIRRV. Per-ring coalescing is
enabled with ICPT=1 so the first arriving packet fires the interrupt
immediately. The SIRXIDR W1C detect bit is cleared before re-arming
ENETC_RBIER to prevent spurious interrupts after traffic stops.

The interrupt infrastructure (rte_intr_efd_enable +
rte_intr_vec_list_alloc) is set up before rte_intr_enable() so that
vfio-pci can wire each MSI-X vector to its eventfd when programming
the MSI-X table.

enetc4_dev_configure() is updated to trigger interrupt setup when
intr_conf.rxq is set (not only when intr_conf.lsc is set), as applications
like l3fwd-power set intr_conf.rxq without setting lsc.

Signed-off-by: Gagandeep Singh <g.singh@nxp.com>
---
 doc/guides/nics/enetc4.rst             | 65 ++++++++++++++++++
 doc/guides/nics/features/enetc4_vf.ini |  1 +
 doc/guides/rel_notes/release_26_11.rst |  1 +
 drivers/net/enetc/base/enetc4_hw.h     |  2 +
 drivers/net/enetc/enetc.h              |  1 +
 drivers/net/enetc/enetc4_ethdev.c      |  9 +--
 drivers/net/enetc/enetc4_vf.c          | 95 +++++++++++++++++++++++++-
 7 files changed, 168 insertions(+), 6 deletions(-)

diff --git a/doc/guides/nics/enetc4.rst b/doc/guides/nics/enetc4.rst
index 16389aee5b..2b73916682 100644
--- a/doc/guides/nics/enetc4.rst
+++ b/doc/guides/nics/enetc4.rst
@@ -59,6 +59,10 @@ Key functionality includes:
   Segment Coalesce (RSC), enabled when the TCP LRO Rx offload flag is
   requested. RSC requires the FCS to be stripped, so it cannot be combined
   with the KEEP_CRC Rx offload.
+- Per-queue Rx interrupts on VFs (cacheable Rx path only), enabling
+  interrupt-driven receive with ``vfio-pci``. Applications set
+  ``intr_conf.rxq = 1`` in ``rte_eth_conf`` to activate this feature.
+  See `Rx Interrupt Mode (VF)`_ for setup details.
 - Firmware version: The NETC IP version is reported via ``rte_eth_dev_fw_version_get``.
 - Registers dump: The station interface, port (PF only) and BD ring registers are dumped via ``rte_eth_dev_get_reg_info``.
 
@@ -167,3 +171,64 @@ PF/Common devargs
   Usage example::
 
     dpdk-testpmd -a 0000:00:00.0,nc=1 -- -i
+
+
+Rx Interrupt Mode (VF)
+----------------------
+
+The ENETC4 VF PMD supports per-queue MSI-X Rx interrupts on the cacheable
+(default) Rx path. This allows applications to block in ``epoll_wait``
+instead of busy-polling, reducing CPU utilization when traffic is absent.
+
+**MSI-X vector assignment**
+
+ENETC4 VF MSI-X vector 0 is reserved for the PSI-to-VSI mailbox interrupt
+(link status notifications). Rx queue ``i`` is mapped to vector ``i + 1``.
+The driver allocates all required eventfds before calling
+``rte_intr_enable()`` so that ``vfio-pci`` can wire each MSI-X vector to
+its eventfd when it programs the MSI-X table.
+
+**Kernel and driver requirements**
+
+- ``vfio-pci`` kernel module with no-IOMMU mode enabled (no SMMU required).
+- The non-cacheable memory mode (``nc=1`` devarg) does **not** support
+  Rx interrupts and returns ``-ENOTSUP`` from ``rx_queue_intr_enable``.
+
+**Host setup**
+
+.. code-block:: console
+
+   # Enable vfio-pci no-IOMMU mode (if SMMU is not available)
+   modprobe vfio enable_unsafe_noiommu_mode=1
+   modprobe vfio-pci
+
+   # Bind the VF to vfio-pci
+   echo vfio-pci > /sys/bus/pci/devices/<vf_pci_addr>/driver_override
+   echo <vf_pci_addr> > /sys/bus/pci/drivers_probe
+
+**Running l3fwd-power with a single queue and core**
+
+The ``l3fwd-power`` sample application demonstrates interrupt-driven Rx.
+It sets ``intr_conf.rxq = 1`` in ``rte_eth_conf``, which triggers the VF
+interrupt setup in the driver. The ``--vfio-intr=msix`` EAL flag instructs
+DPDK to use MSI-X eventfds for interrupt signalling.
+
+.. code-block:: console
+
+   ./dpdk-l3fwd-power -l 0-1 -n 1 --vfio-intr=msix \
+       -a <vf_pci_addr> -- \
+       -p 0x1 --config="(0,0,1)" --no-numa --interrupt-only
+
+Where:
+
+- ``-l 0-1`` assigns the main thread to core 0 and the forwarding lcore to
+  core 1.
+- ``-a <vf_pci_addr>`` specifies the VF PCI address (e.g. ``0000:01:00.1``).
+- ``--config="(0,0,1)"`` maps port 0, queue 0 to lcore 1.
+- ``--interrupt-only`` enables pure interrupt mode (no busy-poll fallback).
+
+With no incoming traffic the forwarding lcore sleeps in ``epoll_wait``;
+CPU utilization drops to near zero. On the first arriving packet the MSI-X
+interrupt fires, the lcore wakes, drains the ring, disables the interrupt,
+processes the burst, then re-enables and re-arms the interrupt before
+returning to sleep.
diff --git a/doc/guides/nics/features/enetc4_vf.ini b/doc/guides/nics/features/enetc4_vf.ini
index 55eaed6633..c6014fd5a9 100644
--- a/doc/guides/nics/features/enetc4_vf.ini
+++ b/doc/guides/nics/features/enetc4_vf.ini
@@ -5,6 +5,7 @@
 ;
 [Features]
 Link status event    = Y
+Rx interrupt         = Y
 Speed capabilities   = Y
 Link status          = Y
 LRO                  = Y
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index a42577c681..c182495118 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -71,6 +71,7 @@ New Features
   * Added ring parameters support for the ENETC4 VF (rxq_info_get / txq_info_get).
   * Refreshed VF link speed on the link-up interrupt in the ENETC4 VF driver.
   * Added stats reset for the ENETC4 VF using a software snapshot/delta approach.
+  * Added per-queue MSI-X Rx interrupt support for the ENETC4 VF.
 
 Removed Items
 -------------
diff --git a/drivers/net/enetc/base/enetc4_hw.h b/drivers/net/enetc/base/enetc4_hw.h
index 060dc03991..d4cdb01bcf 100644
--- a/drivers/net/enetc/base/enetc4_hw.h
+++ b/drivers/net/enetc/base/enetc4_hw.h
@@ -248,6 +248,8 @@ struct enetc_rx_bd_ext {
 #define ENETC4_VSIIDR            0xA08
 #define ENETC4_VSIIER_MRIE       BIT(9)
 #define ENETC4_SI_INT_IDX        0
+/* MSI-X vector base for per-Rx-queue interrupts; vector 0 is the mailbox. */
+#define ENETC4_VF_RX_VEC_BASE    1
 
 /* VSI Registers */
 #define ENETC4_VSIMSGSR  0x204   /* RO */
diff --git a/drivers/net/enetc/enetc.h b/drivers/net/enetc/enetc.h
index ae7fecbed2..dc5f66c0b7 100644
--- a/drivers/net/enetc/enetc.h
+++ b/drivers/net/enetc/enetc.h
@@ -135,6 +135,7 @@ struct enetc_eth_hw {
 	uint32_t vsi_delay;   /* VSI-PSI message wait delay (us) */
 	uint32_t *txq_prior;  /* per-queue TX priority (TBMR priority bits) */
 	uint8_t nc_mode;      /* 1 = non-cacheable BD memory, use _nc ops */
+	uint8_t rxq_intr_en;  /* 1 = per-queue Rx MSI-X interrupts enabled */
 	/* 1 = legacy PF-to-VF link message layout (4-bit speed / 4-bit cookie),
 	 * for PF kernel versions before 6.18.37. Set via vf_link_legacy devarg.
 	 */
diff --git a/drivers/net/enetc/enetc4_ethdev.c b/drivers/net/enetc/enetc4_ethdev.c
index eca756f90d..2be8c73403 100644
--- a/drivers/net/enetc/enetc4_ethdev.c
+++ b/drivers/net/enetc/enetc4_ethdev.c
@@ -878,7 +878,8 @@ enetc4_dev_close(struct rte_eth_dev *dev)
 		return 0;
 
 	if (hw->device_id == ENETC4_DEV_ID_VF) {
-		if (dev->data->dev_conf.intr_conf.lsc != 0)
+		if (dev->data->dev_conf.intr_conf.lsc != 0 ||
+		    dev->data->dev_conf.intr_conf.rxq != 0)
 			enetc4_vf_dev_intr(dev, false);
 		ret = enetc4_vf_dev_stop(dev);
 		pthread_mutex_destroy(&hw->vsi_lock);
@@ -1001,12 +1002,12 @@ enetc4_dev_configure(struct rte_eth_dev *dev)
 	if (hw->device_id != ENETC4_DEV_ID_VF)
 		enetc4_port_wr(enetc_hw, ENETC4_PARCSCR, checksum);
 
-	/* Enable interrupts */
 	if (hw->device_id == ENETC4_DEV_ID_VF) {
-		if (dev->data->dev_conf.intr_conf.lsc != 0) {
+		if (dev->data->dev_conf.intr_conf.lsc != 0 ||
+		    dev->data->dev_conf.intr_conf.rxq != 0) {
 			ret = enetc4_vf_dev_intr(dev, true);
 			if (ret)
-				ENETC_PMD_WARN("Failed to setup link interrupts");
+				ENETC_PMD_WARN("Failed to setup VF interrupts: %d", ret);
 		}
 	}
 
diff --git a/drivers/net/enetc/enetc4_vf.c b/drivers/net/enetc/enetc4_vf.c
index 985eb04a70..dfbb30e6dd 100644
--- a/drivers/net/enetc/enetc4_vf.c
+++ b/drivers/net/enetc/enetc4_vf.c
@@ -1594,6 +1594,60 @@ static const struct rte_pci_id pci_vf_id_enetc4_map[] = {
 	{ .vendor_id = 0, /* sentinel */ },
 };
 
+static int
+enetc4_vf_rx_queue_intr_enable(struct rte_eth_dev *dev, uint16_t queue_id)
+{
+	struct enetc_eth_hw *hw =
+		ENETC_DEV_PRIVATE_TO_HW(dev->data->dev_private);
+	struct enetc_hw *enetc_hw = &hw->hw;
+	struct enetc_bdr *rx_ring;
+	uint16_t vec;
+
+	if (hw->nc_mode)
+		return -ENOTSUP;
+
+	if (!hw->rxq_intr_en)
+		return -ENOTSUP;
+
+	vec = queue_id + ENETC4_VF_RX_VEC_BASE;
+	rx_ring = (struct enetc_bdr *)dev->data->rx_queues[queue_id];
+
+	enetc_wr(enetc_hw, ENETC_SIMSIRRV(queue_id), vec);
+	/*
+	 * Do not overwrite RBICR1 when RSC (LRO) is active: the timer
+	 * programmed there is the coalesce-hold window and zeroing it
+	 * would disable coalescing, flushing every segment individually.
+	 */
+	if (!rx_ring->rsc_enable)
+		enetc4_rxbdr_wr(enetc_hw, queue_id, ENETC4_RBICR1, 0);
+	enetc4_rxbdr_wr(enetc_hw, queue_id, ENETC4_RBICR0,
+			ENETC4_RBICR0_ICEN | ENETC4_RBICR0_ICPT(1));
+	enetc_wr(enetc_hw, ENETC_SIRXIDR, BIT(queue_id));
+
+	enetc4_rxbdr_wr(enetc_hw, queue_id, ENETC_RBIER, ENETC_RBIER_RXTIE);
+
+	return 0;
+}
+
+static int
+enetc4_vf_rx_queue_intr_disable(struct rte_eth_dev *dev, uint16_t queue_id)
+{
+	struct enetc_eth_hw *hw =
+		ENETC_DEV_PRIVATE_TO_HW(dev->data->dev_private);
+	struct enetc_hw *enetc_hw = &hw->hw;
+
+	if (hw->nc_mode)
+		return -ENOTSUP;
+
+	if (!hw->rxq_intr_en)
+		return 0;
+
+	enetc4_rxbdr_wr(enetc_hw, queue_id, ENETC_RBIER, 0);
+	enetc_wr(enetc_hw, ENETC_SIMSIRRV(queue_id), 0);
+
+	return 0;
+}
+
 /* Features supported by this driver */
 /* ops table used when VSI messaging is disabled */
 static const struct eth_dev_ops enetc4_vf_ops_no_vsi_m = {
@@ -1612,6 +1666,8 @@ static const struct eth_dev_ops enetc4_vf_ops_no_vsi_m = {
 	.rx_queue_stop        = enetc4_rx_queue_stop,
 	.rx_queue_release     = enetc4_rx_queue_release,
 	.rxq_info_get         = enetc4_rxq_info_get,
+	.rx_queue_intr_enable  = enetc4_vf_rx_queue_intr_enable,
+	.rx_queue_intr_disable = enetc4_vf_rx_queue_intr_disable,
 	.tx_queue_setup       = enetc4_tx_queue_setup,
 	.tx_queue_start       = enetc4_tx_queue_start,
 	.tx_queue_stop        = enetc4_tx_queue_stop,
@@ -1645,6 +1701,8 @@ static const struct eth_dev_ops enetc4_vf_ops = {
 	.rx_queue_stop        = enetc4_rx_queue_stop,
 	.rx_queue_release     = enetc4_rx_queue_release,
 	.rxq_info_get         = enetc4_rxq_info_get,
+	.rx_queue_intr_enable  = enetc4_vf_rx_queue_intr_enable,
+	.rx_queue_intr_disable = enetc4_vf_rx_queue_intr_disable,
 	.tx_queue_setup       = enetc4_tx_queue_setup,
 	.tx_queue_start       = enetc4_tx_queue_start,
 	.tx_queue_stop        = enetc4_tx_queue_stop,
@@ -1911,6 +1969,34 @@ enetc4_vf_dev_intr(struct rte_eth_dev *eth_dev, bool enable)
 		/* Vector index 0 */
 		enetc_wr(enetc_hw, ENETC4_SIMSIVR, ENETC4_SI_INT_IDX);
 
+		if (rte_intr_cap_multiple(intr_handle) &&
+		    eth_dev->data->nb_rx_queues > 0) {
+			uint16_t nb_rx = eth_dev->data->nb_rx_queues;
+			uint16_t i;
+
+			ret = rte_intr_efd_enable(intr_handle,
+					nb_rx + ENETC4_VF_RX_VEC_BASE);
+			if (ret) {
+				ENETC_PMD_WARN("Failed to enable per-queue Rx eventfds: %d",
+					       ret);
+				hw->rxq_intr_en = 0;
+			} else {
+				ret = rte_intr_vec_list_alloc(intr_handle,
+						"enetc4_vf_rx_intr", nb_rx);
+				if (ret) {
+					ENETC_PMD_WARN("Failed to alloc intr vec list: %d",
+						       ret);
+					rte_intr_efd_disable(intr_handle);
+					hw->rxq_intr_en = 0;
+				} else {
+					for (i = 0; i < nb_rx; i++)
+						rte_intr_vec_list_index_set(intr_handle, i,
+							i + ENETC4_VF_RX_VEC_BASE);
+					hw->rxq_intr_en = 1;
+				}
+			}
+		}
+
 		/* enable uio/vfio intr/eventfd mapping */
 		ret = rte_intr_enable(intr_handle);
 		if (ret) {
@@ -1934,12 +2020,17 @@ enetc4_vf_dev_intr(struct rte_eth_dev *eth_dev, bool enable)
 		ENETC_PMD_WARN("Failed to un-register link notification %d", ret);
 disable:
 	enetc_vf_enable_mr_int(enetc_hw, false);
+	hw->rxq_intr_en = 0;
 	ret = rte_intr_disable(intr_handle);
 	if (ret)
 		ENETC_PMD_WARN("Failed to disable INTR %d", ret);
 intr_enable_fail:
-	rte_intr_callback_unregister(intr_handle,
+	rte_intr_vec_list_free(intr_handle);
+	rte_intr_efd_disable(intr_handle);
+	ret = rte_intr_callback_unregister(intr_handle,
 			enetc4_dev_interrupt_handler, eth_dev);
+	if (ret < 0)
+		ENETC_PMD_WARN("Failed to unregister intr callback: %d", ret);
 
 	return ret;
 }
@@ -1953,7 +2044,7 @@ static struct rte_pci_driver rte_enetc4_vf_pmd = {
 
 RTE_PMD_REGISTER_PCI(net_enetc4_vf, rte_enetc4_vf_pmd);
 RTE_PMD_REGISTER_PCI_TABLE(net_enetc4_vf, pci_vf_id_enetc4_map);
-RTE_PMD_REGISTER_KMOD_DEP(net_enetc4_vf, "* igb_uio | uio_pci_generic");
+RTE_PMD_REGISTER_KMOD_DEP(net_enetc4_vf, "* igb_uio | uio_pci_generic | vfio-pci");
 RTE_PMD_REGISTER_PARAM_STRING(net_enetc4_vf,
 			      ENETC4_VSI_DISABLE "=<any> "
 			      ENETC4_VSI_TIMEOUT "=<uint> "
-- 
2.25.1

