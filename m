Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99D00C5CFEB
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Aug 2026 14:44:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 868E642EA4;
	Thu, 13 Aug 2026 16:42:44 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id EFD1542DE3
 for <dev@dpdk.org>; Thu, 13 Aug 2026 16:42:40 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id D0DDC200081;
 Thu, 13 Aug 2026 16:42:40 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 983B5200053;
 Thu, 13 Aug 2026 16:42:40 +0200 (CEST)
Received: from lsv03583.swis.in-blr01.nxp.com (lsv03583.swis.in-blr01.nxp.com
 [92.120.146.12])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 415EF18000B7;
 Thu, 13 Aug 2026 22:42:39 +0800 (+08)
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: stephen@networkplumber.org,
	thomas@monjalon.net,
	dev@dpdk.org
Subject: [PATCH v11 25/25] doc: update release notes with NXP DPAA changes
Date: Thu, 13 Aug 2026 20:12:05 +0530
Message-Id: <20260813144205.2505031-26-hemant.agrawal@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260813144205.2505031-1-hemant.agrawal@nxp.com>
References: <20260813104405.2313474-1-hemant.agrawal@nxp.com>
 <20260813144205.2505031-1-hemant.agrawal@nxp.com>
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
    - ORP burst enqueue API (qman_enqueue_multi_orp)
    - DMA scatter-gather support and ERR050757 workaround

Signed-off-by: Hemant Agrawal <hemant.agrawal@nxp.com>
---
 doc/guides/rel_notes/release_26_11.rst | 29 ++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index c8cc86295d..22af88bf44 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -55,6 +55,35 @@ New Features
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
+* **Added NXP DPAA DMA scatter-gather and ERR050757 workaround.**
+
+  Added scatter-gather (SG) support to the DPAA QDMA driver and a
+  workaround for hardware errata ERR050757 to prevent data corruption
+  on affected silicon when ``RTE_DMA_DPAA_ERRATA_ERR050757`` is defined.
+
 
 Removed Items
 -------------
-- 
2.25.1

