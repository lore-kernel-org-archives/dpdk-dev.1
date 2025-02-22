Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D20FC021B5
	for <dpdk-dev@archiver.kernel.org>; Sat, 22 Feb 2025 03:58:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E7B1E42D72;
	Sat, 22 Feb 2025 04:58:01 +0100 (CET)
Received: from lf-1-16.ptr.blmpb.com (lf-1-16.ptr.blmpb.com [103.149.242.16])
 by mails.dpdk.org (Postfix) with ESMTP id C59C242D2B
 for <dev@dpdk.org>; Sat, 22 Feb 2025 04:57:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1740196673; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=/NoJ0mlHsrGwUZ3f3MpU6usc55Afk/jTcpHI/FApcQ0=;
 b=OGuKfnnchV4s5/BMGSPRB8WyUGfi8u/EHK6qkyM+MHGJv0fhzmOq1Xa62ur4sWO6Qj0oaJ
 aFKWuXCS9Ys032dvov5pU9Dzoop43WlC/LHWc2U+7tsDB0RWbkYRCJLpDSbsvm7kFCps73
 7dCNY7mACXmUFyFBapvBfd2s/z2LeKjnBZqy1wir+V+B+5B4WWRkcuY+vat6ryiOGlIUQ+
 tMLYjeoIutp//GvmuUyciUac3ZlNG0EBve7SN+cHrofV0sD+Dkf7Z6LYjRUXntzQF0NhnH
 t7ruRkA69WvTfkXyBpWxG5PICvHFhKhuTx2ILZI8VtthII0pQoBqmJI2Tj3MPg==
Cc: <thomas@monjalon.net>, <stephen@networkplumber.org>, 
 <qianr@yunsilicon.com>, <nana@yunsilicon.com>, <zhangxx@yunsilicon.com>, 
 <xudw@yunsilicon.com>, <jacky@yunsilicon.com>, <weihg@yunsilicon.com>, 
 <zhenghy@yunsilicon.com>
From: "Renyong Wan" <wanry@yunsilicon.com>
Date: Sat, 22 Feb 2025 11:57:51 +0800
Content-Type: text/plain; charset=UTF-8
X-Original-From: Renyong Wan <wanry@yunsilicon.com>
X-Mailer: git-send-email 2.25.1
X-Lms-Return-Path: <lba+267b94b3f+2d61c1+dpdk.org+wanry@yunsilicon.com>
In-Reply-To: <20250222035732.2290067-1-wanry@yunsilicon.com>
References: <20250222035732.2290067-1-wanry@yunsilicon.com>
Content-Transfer-Encoding: 7bit
Subject: [PATCH 09/12] net/xsc: avoid assign the same value to a variable
Received: from ubuntu-liun.yunsilicon.com ([58.34.192.114]) by smtp.feishu.cn
 with ESMTPS; Sat, 22 Feb 2025 11:57:50 +0800
To: <dev@dpdk.org>
Message-Id: <20250222035749.2290067-10-wanry@yunsilicon.com>
Mime-Version: 1.0
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

This issue was reported by PVS studio, described as:
https://pvs-studio.com/en/docs/warnings/v1048/

Signed-off-by: Rong Qian <qianr@yunsilicon.com>
Signed-off-by: Renyong Wan <wanry@yunsilicon.com>
---
 drivers/net/xsc/xsc_np.c | 4 ----
 drivers/net/xsc/xsc_tx.c | 1 -
 2 files changed, 5 deletions(-)

diff --git a/drivers/net/xsc/xsc_np.c b/drivers/net/xsc/xsc_np.c
index eff7497255..7ff39f83c9 100644
--- a/drivers/net/xsc/xsc_np.c
+++ b/drivers/net/xsc/xsc_np.c
@@ -137,10 +137,6 @@ xsc_rss_hash_template_get(struct rte_eth_rss_conf *rss_conf)
 		rss_hf &= ~XSC_RSS_HASH_BIT_IPV6_SPORT;
 	}
 
-	if ((rss_conf->rss_hf & RTE_ETH_RSS_LEVEL_PMD_DEFAULT) ||
-	    (rss_conf->rss_hf & RTE_ETH_RSS_LEVEL_OUTERMOST))
-		outer = 1;
-
 	if (rss_conf->rss_hf & RTE_ETH_RSS_LEVEL_INNERMOST)
 		outer = 0;
 
diff --git a/drivers/net/xsc/xsc_tx.c b/drivers/net/xsc/xsc_tx.c
index 0d6a9981d0..d1a0f3284b 100644
--- a/drivers/net/xsc/xsc_tx.c
+++ b/drivers/net/xsc/xsc_tx.c
@@ -215,7 +215,6 @@ xsc_tx_wqe_ctrl_seg_init(struct xsc_txq_data *__rte_restrict txq,
 		cs->csum_en = 0;
 
 	if (txq->tso_en == 1 && (mbuf->ol_flags & RTE_MBUF_F_TX_TCP_SEG)) {
-		cs->has_pph = 0;
 		cs->so_type = 1;
 		cs->so_hdr_len = mbuf->l2_len + mbuf->l3_len + mbuf->l4_len;
 		cs->so_data_size = rte_cpu_to_le_16(mbuf->tso_segsz);
-- 
2.25.1
