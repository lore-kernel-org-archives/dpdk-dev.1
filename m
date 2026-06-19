Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3342FCD98F6
	for <dpdk-dev@archiver.kernel.org>; Fri, 19 Jun 2026 06:10:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9B6E540E43;
	Fri, 19 Jun 2026 08:09:49 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id ECB33406BC;
 Fri, 19 Jun 2026 08:09:43 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id D60471A020E;
 Fri, 19 Jun 2026 08:09:43 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 9FFB51A0203;
 Fri, 19 Jun 2026 08:09:43 +0200 (CEST)
Received: from lsv03583.swis.in-blr01.nxp.com (lsv03583.swis.in-blr01.nxp.com
 [92.120.146.12])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 1713D1800071;
 Fri, 19 Jun 2026 14:09:41 +0800 (+08)
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: stephen@networkplumber.org,
	david.marchand@redhat.com,
	dev@dpdk.org
Cc: stable@dpdk.org
Subject: [PATCH v2 17/18] net/dpaa: fix null l3_len check in checksum offload
Date: Fri, 19 Jun 2026 11:39:15 +0530
Message-Id: <20260619060916.485258-18-hemant.agrawal@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260619060916.485258-1-hemant.agrawal@nxp.com>
References: <20260618141151.3990283-1-hemant.agrawal@nxp.com>
 <20260619060916.485258-1-hemant.agrawal@nxp.com>
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

Fixes: 5a8cf1bef775 ("net/dpaa: support checksum offload")
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

