Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8C61CC6B1A
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Oct 2026 15:09:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CEE514067B;
	Wed, 14 Oct 2026 17:09:45 +0200 (CEST)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [1.95.21.3])
 by mails.dpdk.org (Postfix) with ESMTP id 5473E4026E;
 Wed, 14 Oct 2026 17:09:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=9loECt8hrIGh5sy147D10dpfpWo6lWHVJUsm7KRsC00=;
 b=Z0t1DaesFKOiM9l6lqfdHLcEbguDh2C+E6joU4Ed9kGLAaQRwzHl9fWMHcnN4P
 MKVCGCq9HyeNPKYFqmRz9fG8T0a8cYgKZ/KrsfUgyTQ7jrJPmntP9l666JxTwvWZ
 dEOE14MB4FK1/uAw+zUShL0/zzYzfPw781HtAYp7KeB5E=
From: Jiacheng Ye <yejiacheng4@h-partners.com>
To: dev@dpdk.org
Cc: Feifei Wang <wangfeifei40@huawei.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Anatoly Burakov <anatoly.burakov@intel.com>, stable@dpdk.org
Subject: [PATCH v2 02/26] net/hinic3: fix double removal in ethertype flow
 destroy
Date: Wed, 14 Oct 2026 23:08:58 +0800
Message-ID: <20261014150923.838-3-yejiacheng4@h-partners.com>
X-Mailer: git-send-email 2.53.0.windows.2
In-Reply-To: <20261014150923.838-1-yejiacheng4@h-partners.com>
References: <20261010144509.2731-1-yejiacheng4@h-partners.com>
 <20261014150923.838-1-yejiacheng4@h-partners.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: As8vCgAXMEEym89qB_SFAw--.62919S4
X-Coremail-Antispam: 1Uf129KBjvdXoWrZrWrZr4rWw4DGw13Xw4Dtwb_yoWDCrg_Cr
 yI9F17A34qkr48tw1UKr43Z34akr4vqFyIvw4Iqry3G34UAF4IqFyUur4fJas7GF1UZFnx
 Cr9rK34Ik3s5KjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU01q2tUUUUU==
Sender: wff_light@vip.163.com
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiNhWCjGrPmzUfZgAA3f
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

The ethertype destroy path removes the same flow node from
filter_ethertype_list twice, corrupting the tailq and leading to
use-after-free. Drop the redundant removal.

Fixes: efa3b9b36fc7 ("net/hinic3: add flow control and filters")
Cc: stable@dpdk.org

Signed-off-by: Jiacheng Ye <yejiacheng4@h-partners.com>
---
 drivers/net/hinic3/hinic3_flow.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/hinic3/hinic3_flow.c b/drivers/net/hinic3/hinic3_flow.c
index 5c255619e3..453b4369b3 100644
--- a/drivers/net/hinic3/hinic3_flow.c
+++ b/drivers/net/hinic3/hinic3_flow.c
@@ -1332,10 +1332,6 @@ hinic3_flow_destroy(struct rte_eth_dev *dev, struct rte_flow *flow,
 			&rules->ethertype_filter, false);
 		if (!ret)
 			TAILQ_REMOVE(&nic_dev->filter_ethertype_list, flow, node);
-
-		flow->rule = rules;
-		flow->filter_type = rules->filter_type;
-		TAILQ_REMOVE(&nic_dev->filter_ethertype_list, flow, node);
 		break;
 
 	case RTE_ETH_FILTER_FDIR:
-- 
2.33.0

