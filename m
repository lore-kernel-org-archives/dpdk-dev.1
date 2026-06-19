Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A882ACD98F6
	for <dpdk-dev@archiver.kernel.org>; Fri, 19 Jun 2026 06:10:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6A7C740E35;
	Fri, 19 Jun 2026 08:09:47 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id 71CC740E22;
 Fri, 19 Jun 2026 08:09:41 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 56FC52001E6;
 Fri, 19 Jun 2026 08:09:41 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 20C6F2001EC;
 Fri, 19 Jun 2026 08:09:41 +0200 (CEST)
Received: from lsv03583.swis.in-blr01.nxp.com (lsv03583.swis.in-blr01.nxp.com
 [92.120.146.12])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 8E9551800088;
 Fri, 19 Jun 2026 14:09:39 +0800 (+08)
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: stephen@networkplumber.org,
	david.marchand@redhat.com,
	dev@dpdk.org
Cc: stable@dpdk.org
Subject: [PATCH v2 15/18] net/dpaa: remove duplicate ptype entries
Date: Fri, 19 Jun 2026 11:39:13 +0530
Message-Id: <20260619060916.485258-16-hemant.agrawal@nxp.com>
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

RTE_PTYPE_L4_TCP and RTE_PTYPE_L4_UDP were listed twice in the
supported ptypes array returned by dpaa_supported_ptypes_get().
Remove the duplicate entries.

Fixes: ec503d8fa782 ("net/dpaa: update supported ptypes")
Cc: stable@dpdk.org

Signed-off-by: Hemant Agrawal <hemant.agrawal@nxp.com>
---
 drivers/net/dpaa/dpaa_ethdev.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/dpaa/dpaa_ethdev.c b/drivers/net/dpaa/dpaa_ethdev.c
index 3d6405d5fa..b7f3c4360b 100644
--- a/drivers/net/dpaa/dpaa_ethdev.c
+++ b/drivers/net/dpaa/dpaa_ethdev.c
@@ -406,8 +406,6 @@ dpaa_supported_ptypes_get(struct rte_eth_dev *dev, size_t *no_of_elements)
 		RTE_PTYPE_L4_TCP,
 		RTE_PTYPE_L4_UDP,
 		RTE_PTYPE_L4_FRAG,
-		RTE_PTYPE_L4_TCP,
-		RTE_PTYPE_L4_UDP,
 		RTE_PTYPE_L4_SCTP,
 		RTE_PTYPE_TUNNEL_ESP,
 		RTE_PTYPE_TUNNEL_GRE,
-- 
2.43.0

