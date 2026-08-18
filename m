Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEB53C5DF7D
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Aug 2026 11:20:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4120740E25;
	Tue, 18 Aug 2026 13:18:17 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id 1C2F040E12
 for <dev@dpdk.org>; Tue, 18 Aug 2026 13:18:08 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 0157720025D;
 Tue, 18 Aug 2026 13:18:08 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id BF97A200254;
 Tue, 18 Aug 2026 13:18:07 +0200 (CEST)
Received: from lsv03583.swis.in-blr01.nxp.com (lsv03583.swis.in-blr01.nxp.com
 [92.120.146.12])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 665AB18000B0;
 Tue, 18 Aug 2026 19:18:06 +0800 (+08)
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: stephen@networkplumber.org,
	thomas@monjalon.net,
	dev@dpdk.org
Subject: [PATCH v12 26/26] doc: update release notes with NXP DPAA changes
Date: Tue, 18 Aug 2026 16:47:30 +0530
Message-Id: <20260818111730.801760-27-hemant.agrawal@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260818111730.801760-1-hemant.agrawal@nxp.com>
References: <20260813144205.2505031-1-hemant.agrawal@nxp.com>
 <20260818111730.801760-1-hemant.agrawal@nxp.com>
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

Document new features added by the DPAA patch series:
    - Offline (O/H) port device support (drv_oldev bus devarg)
    - Rx/Tx taildrop threshold devargs (drv_rx_taildrop, drv_tx_taildrop)
    - Fmcless Rx queue count devarg (drv_fmcless_rxq)
    - DMA scatter-gather support and ERR050757 workaround

Signed-off-by: Hemant Agrawal <hemant.agrawal@nxp.com>
---
 doc/guides/rel_notes/release_26_11.rst | 40 ++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index c8cc86295d..b76d593d1d 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -55,6 +55,46 @@ New Features
      Also, make sure to start the actual text at the margin.
      =======================================================
 
+* **Added NXP DPAA offline (O/H) port device support.**
+
+  Added support for the DPAA Offline/Host-command (O/H) port, allowing
+  a DPDK application to use an offline port for packet processing.
+  The feature is selected through the ``drv_oldev`` bus device argument.
+
+* **Added NXP DPAA Rx/Tx taildrop threshold device arguments.**
+
+  Added ``drv_rx_taildrop`` and ``drv_tx_taildrop`` device arguments
+  to configure per-port frame queue taildrop congestion thresholds
+  at device probe time.
+
+* **Added NXP DPAA Tx rate limiting API.**
+
+  Added ``rte_pmd_dpaa_port_set_rate_limit()`` to configure the
+  transmit rate limit (burst size and rate) on a DPAA port using the
+  FMAN port rate limiter.
+
+* **Added NXP DPAA fmcless Rx queue count device argument.**
+
+  Added ``drv_fmcless_rxq`` device argument to set the number of
+  Rx queues when running without FMC configuration.
+
+* **Added NXP DPAA shared MAC kernel interface name device argument.**
+
+  Added ``drv_sh_if_name`` device argument to provide the Linux kernel
+  interface name of a shared MAC interface when it differs from the
+  ``fmX-macY`` style name used by DPDK.
+
+* **Added NXP DPAA DMA scatter-gather support and new device arguments.**
+
+  Added scatter-gather (SG) batching to the DPAA QDMA driver, enabled by
+  default, along with the ``dpaa_dma_sg_disable`` and
+  ``dpaa_dma_data_validation`` device arguments to disable SG batching and
+  to enable post-transfer data validation for debugging.
+  When the driver is built with ``RTE_DMA_DPAA_ERRATA_ERR050757``, the
+  source read type and stride are programmed to work around hardware
+  erratum ERR050757, and the ``dpaa_dma_pci_read_disable`` device argument
+  can be used to disable that programming.
+
 
 Removed Items
 -------------
-- 
2.25.1

