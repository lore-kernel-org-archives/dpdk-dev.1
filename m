Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31B8AC9833E
	for <dpdk-dev@archiver.kernel.org>; Mon, 28 Sep 2026 07:01:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 21D8B40E42;
	Mon, 28 Sep 2026 08:59:28 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id EDD8440A6C
 for <dev@dpdk.org>; Mon, 28 Sep 2026 08:59:00 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id D2DD32001BE;
 Mon, 28 Sep 2026 08:59:00 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 9C92C2001B7;
 Mon, 28 Sep 2026 08:59:00 +0200 (CEST)
Received: from lsv03583.swis.in-blr01.nxp.com (lsv03583.swis.in-blr01.nxp.com
 [92.120.146.12])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id C9C5718000BA;
 Mon, 28 Sep 2026 14:58:59 +0800 (+08)
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: stephen@networkplumber.org,
	thomas@monjalon.net,
	dev@dpdk.org
Subject: [PATCH v16 23/23] doc: update release notes with NXP DPAA changes
Date: Mon, 28 Sep 2026 12:28:49 +0530
Message-Id: <20260928065849.126909-24-hemant.agrawal@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260928065849.126909-1-hemant.agrawal@nxp.com>
References: <20260901101926.1574209-1-hemant.agrawal@nxp.com>
 <20260928065849.126909-1-hemant.agrawal@nxp.com>
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

Document the new features and device arguments added by the DPAA patch
series:
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
 doc/guides/rel_notes/release_26_11.rst | 33 ++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index dec96ccbc7..b8789d83d1 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -133,6 +133,39 @@ New Features
     with per-descriptor mbuf free (``rte_pktmbuf_free_seg``) and prefetch hints.
   * Changed the set of per-queue xstats counters.
 
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
+* **Added NXP DPAA DMA device arguments for runtime configuration.**
+
+  Added device arguments to the DPAA QDMA driver to control existing
+  driver behaviour at runtime:
+  ``dpaa_dma_sg_disable`` submits each descriptor as an individual
+  single-entry transfer instead of the default scatter-gather batching,
+  ``dpaa_dma_data_validation`` enables the post-transfer data validation
+  helper for debugging, and, when the driver is built with
+  ``RTE_DMA_DPAA_ERRATA_ERR050757``, ``dpaa_dma_pci_read_disable`` skips
+  the ERR050757 source read-transaction programming.
 
 Removed Items
 -------------
-- 
2.25.1

