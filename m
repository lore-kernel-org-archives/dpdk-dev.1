Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24CDDC44501
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Jul 2026 07:18:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E63A240270;
	Thu, 16 Jul 2026 09:18:39 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id BD9F5400D5;
 Thu, 16 Jul 2026 09:18:38 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 72DE41A0BAA;
 Thu, 16 Jul 2026 09:18:38 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id EA3E41A12B8;
 Thu, 16 Jul 2026 09:16:24 +0200 (CEST)
Received: from lsv03457.swis.in-blr01.nxp.com (lsv03457.swis.in-blr01.nxp.com
 [92.120.147.250])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 19F4F18000B5;
 Thu, 16 Jul 2026 15:16:24 +0800 (+08)
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org
Cc: hemant.agrawal@nxp.com, stable@dpdk.org, Gagandeep Singh <g.singh@nxp.com>
Subject: [PATCH] app/test-crypto-perf: reset mbuf state for IPsec outbound
 iterations
Date: Thu, 16 Jul 2026 12:46:20 +0530
Message-Id: <20260716071620.1550810-1-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
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

In cperf_set_ops_security_ipsec(), the same mbuf is reused across
multiple throughput iterations.  For outbound (encap) IPsec the PMD
may modify mbuf metadata such as data_off, data_len and pkt_len as
part of in-place protocol processing.  When the mbuf is recycled for
the next burst those modifications must be undone so the PMD always
sees a clean, freshly-allocated-like buffer.

Use rte_pktmbuf_reset() to restore the mbuf to its post-alloc state
in a PMD-agnostic manner, rather than patching individual fields with
driver-specific knowledge of the expected offset values.

Without this reset, drivers that back-adjust data_off after encap
(e.g. DPAA2 SEC, which advances data_off by SEC_FLC_DHR_OUTBOUND on
each dequeue) will receive a buffer with insufficient headroom on the
second and subsequent enqueues, causing hardware errors such as:

  DPAA2_SEC: SEC encap returned Error - 50000045
    (QI error 0x45: DHR correction underflow, reuse mode)
  DPAA2_SEC: SEC returned Error - 50000020
    (QI error 0x20: FD format error)

Fixes: 3b7d9f2bc6 ("app/test-crypto-perf: add ipsec lookaside support")
Cc: stable@dpdk.org

Signed-off-by: Gagandeep Singh <g.singh@nxp.com>
---
 app/test-crypto-perf/cperf_ops.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/app/test-crypto-perf/cperf_ops.c b/app/test-crypto-perf/cperf_ops.c
index 873fa3b59f..1c8d1e263a 100644
--- a/app/test-crypto-perf/cperf_ops.c
+++ b/app/test-crypto-perf/cperf_ops.c
@@ -409,6 +409,8 @@ cperf_set_ops_security_ipsec(struct rte_crypto_op **ops,
 		ops[i]->status = RTE_CRYPTO_OP_STATUS_NOT_PROCESSED;
 		rte_security_attach_session(ops[i], sess);
 		sym_op->m_src = (struct rte_mbuf *)((uint8_t *)ops[i] + src_buf_offset);
+		if (options->is_outbound)
+			rte_pktmbuf_reset(sym_op->m_src);
 		sym_op->m_src->pkt_len = test_buffer_size;
 
 		while ((m->next != NULL) && (offset >= m->data_len)) {
-- 
2.25.1

