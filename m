Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 683C2C5DF85
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Aug 2026 14:45:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5C8C540EDF;
	Thu, 20 Aug 2026 16:43:51 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id 70A1740E45
 for <dev@dpdk.org>; Thu, 20 Aug 2026 16:43:45 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 5624C1A01A4;
 Thu, 20 Aug 2026 16:43:45 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 1F4211A019C;
 Thu, 20 Aug 2026 16:43:45 +0200 (CEST)
Received: from lsv03583.swis.in-blr01.nxp.com (lsv03583.swis.in-blr01.nxp.com
 [92.120.146.12])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id BA53F18000B1;
 Thu, 20 Aug 2026 22:43:43 +0800 (+08)
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: stephen@networkplumber.org,
	thomas@monjalon.net,
	dev@dpdk.org
Subject: [PATCH v14 23/23] doc: update release notes with NXP DPAA changes
Date: Thu, 20 Aug 2026 20:13:12 +0530
Message-Id: <20260820144312.3922316-24-hemant.agrawal@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260820144312.3922316-1-hemant.agrawal@nxp.com>
References: <20260819105004.2272880-1-hemant.agrawal@nxp.com>
 <20260820144312.3922316-1-hemant.agrawal@nxp.com>
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
 doc/guides/rel_notes/release_26_11.rst | 34 ++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index c8cc86295d..a08a020c70 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -55,6 +55,40 @@ New Features
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
+
 
 Removed Items
 -------------
-- 
2.25.1

