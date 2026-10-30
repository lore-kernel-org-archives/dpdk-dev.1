Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B23B606A31D
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 Oct 2026 14:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=vip.163.com header.i=@vip.163.com header.a=rsa-sha256 header.s=s110527 header.b=RLrqbkVT
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3562A40E40;
	Fri, 30 Oct 2026 15:48:13 +0100 (CET)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [1.95.21.5])
 by mails.dpdk.org (Postfix) with ESMTPS id C5DE040299;
 Fri, 30 Oct 2026 15:47:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=9loECt8hrIGh5sy147D10dpfpWo6lWHVJUsm7KRsC00=;
 b=RLrqbkVTf/lIZvOYiGiqKovI8ARgd/jRgar9kHBtDDagEWIAhXlYk1zm5UniMa
 ozgKL3Cl6ZacRIhXNuu0sbGSlTHbWITJUPwIGpKLbjWoZPIrB5uW88oIa7Hsgjrp
 IHh23RGNt2XARZIc1q+KEYnWgPjmCDWvXYh1jxOswOsbw=
From: Jiacheng Ye <yejiacheng4@h-partners.com>
To: dev@dpdk.org
Cc: Feifei Wang <wangfeifei40@huawei.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Anatoly Burakov <anatoly.burakov@intel.com>, stable@dpdk.org
Subject: [PATCH v5 02/28] net/hinic3: fix double removal in ethertype flow
 destroy
Date: Fri, 30 Oct 2026 22:47:06 +0800
Message-ID: <20261030144733.2120-3-yejiacheng4@h-partners.com>
X-Mailer: git-send-email 2.53.0.windows.2
In-Reply-To: <20261030144733.2120-1-yejiacheng4@h-partners.com>
References: <20261023155809.855-1-yejiacheng4@h-partners.com>
 <20261030144733.2120-1-yejiacheng4@h-partners.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: As8vCgDHb_EUruRqpJ41BA--.59781S4
X-Coremail-Antispam: 1Uf129KBjvdXoWrZrWrZr4rWw4DGw13Xw4Dtwb_yoWDCrg_Cr
 yI9F17A34qkr48tw1UKr43Z34akr4vqFyIvw4Iqry3G34UAF4IqFyUur4fJas7GF1UZFnx
 Cr9rK34Ik3s5KjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU01q2tUUUUU==
Sender: wff_light@vip.163.com
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiMxaEjmrkrhZTfwAA31
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

