Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6AF8C43458
	for <dpdk-dev@archiver.kernel.org>; Mon, 13 Jul 2026 10:19:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2B4B740E42;
	Mon, 13 Jul 2026 12:18:15 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id 337DD40E40;
 Mon, 13 Jul 2026 12:18:12 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 16BBF1A000C;
 Mon, 13 Jul 2026 12:18:12 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id D0BCD1A0013;
 Mon, 13 Jul 2026 12:18:11 +0200 (CEST)
Received: from lsv03583.swis.in-blr01.nxp.com (lsv03583.swis.in-blr01.nxp.com
 [92.120.146.12])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 4D69318000B0;
 Mon, 13 Jul 2026 18:18:10 +0800 (+08)
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: stephen@networkplumber.org,
	thomas@monjalon.net,
	dev@dpdk.org
Cc: stable@dpdk.org
Subject: [PATCH v5 16/18] net/dpaa: fix null l3_len check in checksum offload
Date: Mon, 13 Jul 2026 15:47:45 +0530
Message-Id: <20260713101747.2947405-17-hemant.agrawal@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260713101747.2947405-1-hemant.agrawal@nxp.com>
References: <20260713092616.2902828-1-hemant.agrawal@nxp.com>
 <20260713101747.2947405-1-hemant.agrawal@nxp.com>
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

In dpaa_checksum(), if mbuf->l3_len is zero the L4 header pointer
calculation (l3_hdr + mbuf->l3_len) points to the start of the L3
header rather than the L4 header, leading to incorrect checksum
computation. Add an early return guard when l3_len is zero.

A debug warning is logged to aid diagnosis of mbufs with
uninitialized or corrupt l3_len, since silently skipping checksum
offload would cause the packet to be transmitted without the
requested checksum.

Fixes: 5a8cf1bef775 ("net/dpaa: support checksum offload")
Cc: stable@dpdk.org

Signed-off-by: Hemant Agrawal <hemant.agrawal@nxp.com>
---
 drivers/net/dpaa/dpaa_rxtx.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/dpaa/dpaa_rxtx.c b/drivers/net/dpaa/dpaa_rxtx.c
index c5e393159a..3734496d6f 100644
--- a/drivers/net/dpaa/dpaa_rxtx.c
+++ b/drivers/net/dpaa/dpaa_rxtx.c
@@ -377,6 +377,10 @@ static inline void dpaa_checksum(struct rte_mbuf *mbuf)
 	struct rte_ipv6_hdr *ipv6_hdr = (struct rte_ipv6_hdr *)l3_hdr;
 
 	DPAA_DP_LOG(DEBUG, "Calculating checksum for mbuf: %p", mbuf);
+	if (mbuf->l3_len == 0) {
+		DPAA_DP_LOG(WARNING, "l3_len is 0, skipping checksum for mbuf: %p", mbuf);
+		return;
+	}
 
 	if (((mbuf->packet_type & RTE_PTYPE_L3_MASK) == RTE_PTYPE_L3_IPV4) ||
 	    ((mbuf->packet_type & RTE_PTYPE_L3_MASK) ==
-- 
2.25.1

