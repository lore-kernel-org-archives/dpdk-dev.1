Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC9D0CA5FAB
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Sep 2026 06:26:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 10D1E42E90;
	Wed, 30 Sep 2026 08:25:34 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id 4C59C427CE
 for <dev@dpdk.org>; Wed, 30 Sep 2026 08:24:49 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 2A8501A01B9;
 Wed, 30 Sep 2026 08:24:49 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id E791A1A019D;
 Wed, 30 Sep 2026 08:24:48 +0200 (CEST)
Received: from lsv03583.swis.in-blr01.nxp.com (lsv03583.swis.in-blr01.nxp.com
 [92.120.146.12])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 1975918000BA;
 Wed, 30 Sep 2026 14:24:48 +0800 (+08)
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: stephen@networkplumber.org,
	thomas@monjalon.net,
	dev@dpdk.org
Subject: [PATCH v18 24/24] doc: update release notes with NXP DPAA changes
Date: Wed, 30 Sep 2026 11:54:37 +0530
Message-Id: <20260930062437.3019096-25-hemant.agrawal@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260930062437.3019096-1-hemant.agrawal@nxp.com>
References: <20260929104519.1770698-1-hemant.agrawal@nxp.com>
 <20260930062437.3019096-1-hemant.agrawal@nxp.com>
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
 doc/guides/rel_notes/release_26_11.rst | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index dec96ccbc7..6d406657cd 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -133,6 +133,27 @@ New Features
     with per-descriptor mbuf free (``rte_pktmbuf_free_seg``) and prefetch hints.
   * Changed the set of per-queue xstats counters.
 
+* **Updated NXP DPAA drivers.**
+
+  * Added support for the DPAA Offline/Host-command (O/H) port, allowing
+    a DPDK application to use an offline port for packet processing.
+    The feature is selected through the ``drv_oldev`` bus device argument.
+  * Added ``drv_rx_taildrop`` and ``drv_tx_taildrop`` device arguments
+    to configure per-port frame queue taildrop congestion thresholds
+    at device probe time.
+  * Added ``drv_fmcless_rxq`` device argument to set the number of
+    Rx queues when running without FMC configuration.
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
 
 Removed Items
 -------------
-- 
2.25.1

