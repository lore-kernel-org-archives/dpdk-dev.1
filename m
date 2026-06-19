Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36E4CCD98F6
	for <dpdk-dev@archiver.kernel.org>; Fri, 19 Jun 2026 10:40:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0982E410D0;
	Fri, 19 Jun 2026 12:39:33 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id 1ACD340EE1;
 Fri, 19 Jun 2026 12:39:30 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 00B6B1A0243;
 Fri, 19 Jun 2026 12:39:30 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id BDAC81A022C;
 Fri, 19 Jun 2026 12:39:29 +0200 (CEST)
Received: from lsv03583.swis.in-blr01.nxp.com (lsv03583.swis.in-blr01.nxp.com
 [92.120.146.12])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 30993180004C;
 Fri, 19 Jun 2026 18:39:28 +0800 (+08)
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: stephen@networkplumber.org,
	david.marchand@redhat.com,
	dev@dpdk.org
Cc: stable@dpdk.org
Subject: [PATCH v3 18/18] net/dpaa: fix mbuf leak in SG fd creation
Date: Fri, 19 Jun 2026 16:09:01 +0530
Message-Id: <20260619103901.2274740-19-hemant.agrawal@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260619103901.2274740-1-hemant.agrawal@nxp.com>
References: <20260619060916.485258-1-hemant.agrawal@nxp.com>
 <20260619103901.2274740-1-hemant.agrawal@nxp.com>
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

In dpaa_eth_mbuf_to_sg_fd(), when the allocated temp mbuf does not
have sufficient space for the SG entries, the function returned -1
without freeing 'temp', causing a memory leak. Free 'temp' before
returning the error.

Fixes: 8cffdcbe85aa ("net/dpaa: support scattered Rx")
Cc: stable@dpdk.org

Signed-off-by: Hemant Agrawal <hemant.agrawal@nxp.com>
---
 drivers/net/dpaa/dpaa_rxtx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/dpaa/dpaa_rxtx.c b/drivers/net/dpaa/dpaa_rxtx.c
index 3734496d6f..272960b6e3 100644
--- a/drivers/net/dpaa/dpaa_rxtx.c
+++ b/drivers/net/dpaa/dpaa_rxtx.c
@@ -992,6 +992,7 @@ dpaa_eth_mbuf_to_sg_fd(struct rte_mbuf *mbuf,
 	if (temp->buf_len < ((mbuf->nb_segs * sizeof(struct qm_sg_entry))
 				+ temp->data_off)) {
 		DPAA_PMD_ERR("Insufficient space in mbuf for SG entries");
+		rte_pktmbuf_free(temp);
 		return -1;
 	}
 
-- 
2.43.0

