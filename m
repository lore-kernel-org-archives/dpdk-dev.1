Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08E11CCF9F8
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Nov 2025 00:29:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EFFEE40E03;
	Thu,  6 Nov 2025 01:29:34 +0100 (CET)
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com
 [113.46.200.220])
 by mails.dpdk.org (Postfix) with ESMTP id 5152B402B2
 for <dev@dpdk.org>; Thu,  6 Nov 2025 01:29:31 +0100 (CET)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=96R/CORi3Ngrm7NIT1pr4oTVAEl1jvNwkYNbCQiC3NU=;
 b=D0mdIQn9V9OA5ydggV2TGt4Pt0zjzrfjrdx9CLg6+GH4UwbtbaAqTC7g6H605iHAAR+RGC5Jv
 0VrF2TeXcke1UstHffb6BUPH0ilxQWDJ5Nbu0y3DuXR9s8IBtw9yFu8q6sDRF46GJ6NOt42CtuY
 CZagraHhNpqEiwMTDQF6BA4=
Received: from mail.maildlp.com (unknown [172.19.88.194])
 by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4d231k2djGz12LDZ;
 Thu,  6 Nov 2025 08:27:54 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 85196140276;
 Thu,  6 Nov 2025 08:29:29 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 6 Nov 2025 08:29:29 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <thomas@monjalon.net>, <stephen@networkplumber.org>
CC: <dev@dpdk.org>, <aman.deep.singh@intel.com>, <liuyonglong@huawei.com>,
 <yangxingui@huawei.com>, <lihuisong@huawei.com>
Subject: [PATCH 2/2] app/testpmd: fix wrong Rx queues when setup DCB forward
Date: Thu, 6 Nov 2025 08:29:20 +0800
Message-ID: <20251106002920.6162-3-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251106002920.6162-1-fengchengwen@huawei.com>
References: <20251106002920.6162-1-fengchengwen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.50.163.32]
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemk500009.china.huawei.com (7.202.194.94)
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

The nb_rx_queue should get from rxp_dcb_info not txp_dcb_info, this
commit fix it.

Fixes: 1a572499beb6 ("app/testpmd: setup DCB forwarding based on traffic class")
Cc: stable@dpdk.org

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 app/test-pmd/config.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/app/test-pmd/config.c b/app/test-pmd/config.c
index 0f687018c7..8557371488 100644
--- a/app/test-pmd/config.c
+++ b/app/test-pmd/config.c
@@ -5205,7 +5205,7 @@ dcb_fwd_config_setup(void)
 				fwd_lcores[lc_id]->stream_idx;
 			rxq = rxp_dcb_info.tc_queue.tc_rxq[i][tc].base;
 			txq = txp_dcb_info.tc_queue.tc_txq[i][tc].base;
-			nb_rx_queue = txp_dcb_info.tc_queue.tc_rxq[i][tc].nb_queue;
+			nb_rx_queue = rxp_dcb_info.tc_queue.tc_rxq[i][tc].nb_queue;
 			nb_tx_queue = txp_dcb_info.tc_queue.tc_txq[i][tc].nb_queue;
 			for (j = 0; j < nb_rx_queue; j++) {
 				struct fwd_stream *fs;
-- 
2.17.1

