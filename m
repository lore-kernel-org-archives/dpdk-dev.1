Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378E8606A31E
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Nov 2026 17:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=vip.163.com header.i=@vip.163.com header.a=rsa-sha256 header.s=s110527 header.b=K1btPN2v
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 28C2F40685;
	Wed, 25 Nov 2026 18:05:55 +0100 (CET)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [1.95.21.2])
 by mails.dpdk.org (Postfix) with ESMTPS id 81EB7402ED;
 Wed, 25 Nov 2026 18:05:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=9loECt8hrIGh5sy147D10dpfpWo6lWHVJUsm7KRsC00=;
 b=K1btPN2vZvj3NAku3zJZAnxw+SnGJy/ZVZ591R+gI2kkUWwT29NIFSgKx3LikV
 WKjqRPQkB+yq67aUSP1qn2yx8gHDSmD8EIsOrPNfY+sFYVFFEnj2mEkz0G7+K4jK
 iMwJBOGiTOI7ZM20c1Qy4qcIZ0mEF1Kt4As7lcG+2SgQM=
From: Jiacheng Ye <yejiacheng4@h-partners.com>
To: dev@dpdk.org
Cc: Feifei Wang <wangfeifei40@huawei.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org
Subject: [PATCH v9 02/30] net/hinic3: fix double removal in ethertype flow
 destroy
Date: Thu, 26 Nov 2026 01:03:56 +0800
Message-ID: <20261125170425.5430-3-yejiacheng4@h-partners.com>
X-Mailer: git-send-email 2.56.0.windows.2
In-Reply-To: <20261125170425.5430-1-yejiacheng4@h-partners.com>
References: <20261125170425.5430-1-yejiacheng4@h-partners.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: As8vCgDn77FiFQdrEdNeBQ--.6538S4
X-Coremail-Antispam: 1Uf129KBjvdXoWrZrWrZr4rWw4DGw13Xw4Dtwb_yoWDCrg_Cr
 yI9F17A34qkr48tw1UKr43Z34akr4vqFyIvw4Iqry3G34UAF4IqFyUur4fJas7GF1UZFnx
 Cr9rK34Ik3s5KjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU01q2tUUUUU==
Sender: wff_light@vip.163.com
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiNQj7BmsHFWgfrwAA3h
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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

