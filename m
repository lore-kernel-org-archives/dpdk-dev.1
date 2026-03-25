Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7370109C055
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Mar 2026 18:38:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EA5BF406BC;
	Wed, 25 Mar 2026 19:38:53 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 57DB1402CE;
 Wed, 25 Mar 2026 19:38:52 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1202)
 id DA11F20B710C; Wed, 25 Mar 2026 11:38:51 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DA11F20B710C
From: Long Li <longli@microsoft.com>
To: dev@dpdk.org
Cc: longli@microsoft.com, weh@microsoft.com, stephen@networkplumber.org,
 stable@dpdk.org
Subject: [PATCH] net/mana: fix CQE suppression handling on error completions
Date: Wed, 25 Mar 2026 11:38:36 -0700
Message-ID: <20260325183836.1925080-1-longli@microsoft.com>
X-Mailer: git-send-email 2.43.7
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

On error CQEs (e.g. SA_DROP), the hardware generates one CQE per WQE
regardless of the suppression flag. The previous code honored the
suppress_tx_cqe flag unconditionally, which caused it to skip reading
error CQEs and misalign the CQ consumer index.

This misalignment causes subsequent completions to be misinterpreted:
valid CQEs are read at wrong offsets, leading to spurious error
counts, NULL packet frees, and potential use-after-free of mbufs
that were already completed.

Check the CQE type before honoring suppression: only skip CQE reading
when the completion is CQE_TX_OKAY.

Fixes: cce2c9df44 ("net/mana: suppress Tx CQE generation whenever possible")
Cc: stable@dpdk.org

Signed-off-by: Long Li <longli@microsoft.com>
---
 drivers/net/mana/tx.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/mana/tx.c b/drivers/net/mana/tx.c
index 40931ac027..e5ab566e8a 100644
--- a/drivers/net/mana/tx.c
+++ b/drivers/net/mana/tx.c
@@ -228,9 +228,11 @@ mana_tx_burst(void *dpdk_txq, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 		txq->gdma_sq.tail += desc->wqe_size_in_bu;
 
 		/* If TX CQE suppression is used, don't read more CQE but move
-		 * on to the next packet
+		 * on to the next packet. On error CQEs, HW generates one CQE
+		 * per WQE regardless of suppression, so always advance.
 		 */
-		if (desc->suppress_tx_cqe)
+		if (desc->suppress_tx_cqe &&
+		    oob->cqe_hdr.cqe_type == CQE_TX_OKAY)
 			continue;
 
 		i++;
-- 
2.43.0

