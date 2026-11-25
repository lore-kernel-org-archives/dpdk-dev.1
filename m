Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F4C606A31E
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Nov 2026 17:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=vip.163.com header.i=@vip.163.com header.a=rsa-sha256 header.s=s110527 header.b=eMa7NEz4
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2557E40B9F;
	Wed, 25 Nov 2026 18:06:04 +0100 (CET)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [1.95.21.2])
 by mails.dpdk.org (Postfix) with ESMTPS id 4963940678
 for <dev@dpdk.org>; Wed, 25 Nov 2026 18:05:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=Fyh4IZ4L7LC12Z6l46jBGmamFT4z4vo+3zsG6vQsR+Y=;
 b=eMa7NEz4uKprmeaHvYB+1qbZMnv9txlrSjWdDdUdQhVSc0oiUvTuhRjm2aktlU
 Wsz+uwwr6oc98imXgqYWHv/drSuMhi7dIxcnM3VZCBYzktauYDLBw4p4M5SKdkXL
 3pnbkHwOfxEZk9Zd00xKqBeaA2Hiq2NjuuePOHn11H2FQ=
From: Jiacheng Ye <yejiacheng4@h-partners.com>
To: dev@dpdk.org
Cc: Feifei Wang <wangfeifei40@huawei.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v9 10/30] net/hinic3: gate RQ enable on HTN FDIR
Date: Thu, 26 Nov 2026 01:04:04 +0800
Message-ID: <20261125170425.5430-11-yejiacheng4@h-partners.com>
X-Mailer: git-send-email 2.56.0.windows.2
In-Reply-To: <20261125170425.5430-1-yejiacheng4@h-partners.com>
References: <20261125170425.5430-1-yejiacheng4@h-partners.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: As8vCgDn77FiFQdrEdNeBQ--.6538S12
X-Coremail-Antispam: 1Uf129KBjvdXoWrurykZrWUKw47JrWfAF4xWFg_yoWkWrX_ur
 s5Ww43Zw1qgr1jqw18tF4Svryjyr1aqr1vk3ZYyrySk3y5Z34aqryDur45J3Z8WFsrCFs3
 Ar17J3WDCrn8tjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU85l1PUUUUU==
Sender: wff_light@vip.163.com
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiNwv7BmsHFWsfxAAA3I
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

hinic3_start_rq() checks NIC_F_FDIR, but hinic3_set_rq_enable() sends
the HTN-only SET_RQ_ENABLE command. An STN device rejects that command.
Use NIC_F_HTN_FDIR, as the stop path already does.

Fixes: b20dc78b286a ("net/hinic3: support Compact CQE in Rx")
Signed-off-by: Jiacheng Ye <yejiacheng4@h-partners.com>
---
 drivers/net/hinic3/hinic3_rx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/hinic3/hinic3_rx.c b/drivers/net/hinic3/hinic3_rx.c
index ed753ba4ec..90681ce15c 100644
--- a/drivers/net/hinic3/hinic3_rx.c
+++ b/drivers/net/hinic3/hinic3_rx.c
@@ -784,7 +784,7 @@ hinic3_start_rq(struct rte_eth_dev *eth_dev, struct hinic3_rxq *rxq)
 	hinic3_add_rq_to_rx_queue_list(nic_dev, rxq->q_id);
 
 	if (nic_dev->rss_state == HINIC3_RSS_ENABLE) {
-		if ((hinic3_get_driver_feature(nic_dev) & NIC_F_FDIR) != 0)
+		if ((hinic3_get_driver_feature(nic_dev) & NIC_F_HTN_FDIR) != 0)
 			err = hinic3_set_rq_enable(nic_dev, rxq->q_id, true);
 		if (err) {
 			PMD_DRV_LOG(ERR, "Flush rq failed, eth_dev:%s, queue_idx:%d",
-- 
2.33.0

