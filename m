Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2738CD98F2
	for <dpdk-dev@archiver.kernel.org>; Thu, 18 Jun 2026 14:13:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3046340EE2;
	Thu, 18 Jun 2026 16:12:26 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id 3F4A040E5A;
 Thu, 18 Jun 2026 16:12:15 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 23B7C20001A;
 Thu, 18 Jun 2026 16:12:15 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id DEFB8200006;
 Thu, 18 Jun 2026 16:12:14 +0200 (CEST)
Received: from lsv03583.swis.in-blr01.nxp.com (lsv03583.swis.in-blr01.nxp.com
 [92.120.146.12])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 592781800086;
 Thu, 18 Jun 2026 22:12:13 +0800 (+08)
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: stephen@networkplumber.org,
	david.marchand@redhat.com,
	dev@dpdk.org
Cc: stable@dpdk.org
Subject: [PATCH v1 16/17] net/dpaa: fix null l3_len check in checksum offload
Date: Thu, 18 Jun 2026 19:41:50 +0530
Message-Id: <20260618141151.3990283-17-hemant.agrawal@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260618141151.3990283-1-hemant.agrawal@nxp.com>
References: <20260618141151.3990283-1-hemant.agrawal@nxp.com>
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
calculation (l3_hdr + mbuf->l3_len) will point to the start of the
L3 header rather than the L4 header, leading to incorrect checksum
computation on a corrupt or uninitialized packet. Add an early
return guard when l3_len is zero.

Fixes: 5a8cf1bef7 ("net/dpaa: support checksum offload")
Cc: stable@dpdk.org

Signed-off-by: Hemant Agrawal <hemant.agrawal@nxp.com>
---
 drivers/net/dpaa/dpaa_rxtx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/dpaa/dpaa_rxtx.c b/drivers/net/dpaa/dpaa_rxtx.c
index c5e393159a..1cda68e5af 100644
--- a/drivers/net/dpaa/dpaa_rxtx.c
+++ b/drivers/net/dpaa/dpaa_rxtx.c
@@ -377,6 +377,8 @@ static inline void dpaa_checksum(struct rte_mbuf *mbuf)
 	struct rte_ipv6_hdr *ipv6_hdr = (struct rte_ipv6_hdr *)l3_hdr;
 
 	DPAA_DP_LOG(DEBUG, "Calculating checksum for mbuf: %p", mbuf);
+	if (mbuf->l3_len == 0)
+		return;
 
 	if (((mbuf->packet_type & RTE_PTYPE_L3_MASK) == RTE_PTYPE_L3_IPV4) ||
 	    ((mbuf->packet_type & RTE_PTYPE_L3_MASK) ==
-- 
2.43.0

