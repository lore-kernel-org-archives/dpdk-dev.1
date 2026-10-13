Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EB62CA9ED2
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Oct 2026 10:40:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D31194066C;
	Tue, 13 Oct 2026 12:39:04 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id 8EA5A4067A
 for <dev@dpdk.org>; Tue, 13 Oct 2026 12:38:45 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 7219D1A0004;
 Tue, 13 Oct 2026 12:38:45 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 3C65D1A009D;
 Tue, 13 Oct 2026 12:38:45 +0200 (CEST)
Received: from lsv03583.swis.in-blr01.nxp.com (lsv03583.swis.in-blr01.nxp.com
 [92.120.146.12])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id BE13B180006C;
 Tue, 13 Oct 2026 18:38:44 +0800 (+08)
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: stephen@networkplumber.org,
	thomas@monjalon.net,
	dev@dpdk.org
Subject: [PATCH v25 24/24] doc: update release notes with NXP DPAA changes
Date: Tue, 13 Oct 2026 16:08:33 +0530
Message-Id: <20261013103833.3822265-25-hemant.agrawal@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261013103833.3822265-1-hemant.agrawal@nxp.com>
References: <20261012080845.2325199-1-hemant.agrawal@nxp.com>
 <20261013103833.3822265-1-hemant.agrawal@nxp.com>
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

Add a single "Updated NXP DPAA drivers" entry for the new features and
device arguments added by this series, with one sub-bullet each:

  - Offline (O/H) port device support (drv_oldev bus devarg)
  - Rx/Tx taildrop threshold devargs (drv_rx_taildrop, drv_tx_taildrop)
  - Fmcless Rx queue count devarg (drv_fmcless_rxq)
  - Shared MAC kernel interface name devarg (drv_sh_if_name)
  - DMA devargs to control the existing scatter-gather batching, data
    validation and ERR050757 programming at runtime
    (dpaa_dma_sg_disable, dpaa_dma_data_validation,
    dpaa_dma_pci_read_disable)

Signed-off-by: Hemant Agrawal <hemant.agrawal@nxp.com>
---
 doc/guides/rel_notes/release_26_11.rst | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index e027c7a27f..fb2f1f29d1 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -120,6 +120,25 @@ New Features
   * Added Tx pause support for the ENETC4 VF via Rx congestion mode.
   * Added WRR Tx scheduler devarg (``enetc4_txq_wrr``) for ENETC4 VF ring weights.
 
+* **Updated NXP DPAA drivers.**
+
+  * Added ``drv_fmcless_rxq`` device argument to set the number of
+    Rx queues when running without FMC configuration. When the argument
+    is not given, the default number of Rx queues in FMCLESS mode is now
+    the maximum supported per port instead of the number of lcores,
+    because several queues may be processed on the same core.
+  * Added ``drv_sh_if_name`` device argument to provide the Linux kernel
+    interface name of a shared MAC interface when it differs from the
+    ``fmX-macY`` style name used by DPDK.
+  * Added device arguments to the DPAA QDMA driver to control existing
+    driver behaviour at runtime: ``dpaa_dma_sg_disable`` submits each
+    descriptor as an individual single-entry transfer instead of the
+    default scatter-gather batching, ``dpaa_dma_data_validation`` enables
+    the post-transfer data validation helper for debugging, and, when the
+    driver is built with ``RTE_DMA_DPAA_ERRATA_ERR050757``,
+    ``dpaa_dma_pci_read_disable`` skips the ERR050757 source
+    read-transaction programming.
+
 * **Updated Solarflare network driver.**
 
   * Added VF support on AMD Solarflare X45xx adapters.
-- 
2.25.1

