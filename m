Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5119ECA5FFF
	for <dpdk-dev@archiver.kernel.org>; Wed,  7 Oct 2026 07:26:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 36F68427DA;
	Wed,  7 Oct 2026 09:25:02 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id 2A65A40EAB;
 Wed,  7 Oct 2026 09:24:48 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 0E05D200008;
 Wed,  7 Oct 2026 09:24:48 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id CE22E200002;
 Wed,  7 Oct 2026 09:24:47 +0200 (CEST)
Received: from lsv03583.swis.in-blr01.nxp.com (lsv03583.swis.in-blr01.nxp.com
 [92.120.146.12])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 3D105180006C;
 Wed,  7 Oct 2026 15:24:47 +0800 (+08)
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: stephen@networkplumber.org,
	thomas@monjalon.net,
	dev@dpdk.org
Cc: stable@dpdk.org
Subject: [PATCH v22 16/27] mempool/dpaa: fix write after free on pool free
Date: Wed,  7 Oct 2026 12:54:28 +0530
Message-Id: <20261007072439.3135351-17-hemant.agrawal@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261007072439.3135351-1-hemant.agrawal@nxp.com>
References: <20261006092703.2138929-1-hemant.agrawal@nxp.com>
 <20261007072439.3135351-1-hemant.agrawal@nxp.com>
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

dpaa_mbuf_free_pool() freed the pool private data and then wrote to it:

	rte_free(mp->pool_data);
	bp_info->bp = NULL;

bp_info is DPAA_MEMPOOL_TO_POOL_INFO(mp), which is mp->pool_data, so
both refer to the same allocation. Clearing bp_info->bp after the
rte_free() writes into freed memory.

Clear the field before releasing the allocation, and free bp_info
directly rather than the alias.

Fixes: 376fb49ecfca ("net/dpaa: prevent multiple mempool config")
Cc: stable@dpdk.org

Signed-off-by: Hemant Agrawal <hemant.agrawal@nxp.com>
---
 drivers/mempool/dpaa/dpaa_mempool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mempool/dpaa/dpaa_mempool.c b/drivers/mempool/dpaa/dpaa_mempool.c
index 2f8555a026..94aea5e77c 100644
--- a/drivers/mempool/dpaa/dpaa_mempool.c
+++ b/drivers/mempool/dpaa/dpaa_mempool.c
@@ -143,8 +143,8 @@ dpaa_mbuf_free_pool(struct rte_mempool *mp)
 		bman_free_pool(bp_info->bp);
 		DPAA_MEMPOOL_INFO("BMAN pool freed for bpid =%d",
 				  bp_info->bpid);
-		rte_free(mp->pool_data);
 		bp_info->bp = NULL;
+		rte_free(bp_info);
 		mp->pool_data = NULL;
 	}
 }
-- 
2.25.1

