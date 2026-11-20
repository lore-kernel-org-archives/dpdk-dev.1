Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E530606A320
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Nov 2026 16:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=vip.163.com header.i=@vip.163.com header.a=rsa-sha256 header.s=s110527 header.b=Tt+0EteY
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AB73A4067D;
	Fri, 20 Nov 2026 17:35:19 +0100 (CET)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [220.197.30.222])
 by mails.dpdk.org (Postfix) with ESMTPS id 724D240263
 for <dev@dpdk.org>; Fri, 20 Nov 2026 17:35:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=TKzlPa02XP/EIlWCZLvz2fWrrmU6iAZm+itHa3n40pk=;
 b=Tt+0EteYtCKHn42NH6Jc2teh07hBT4l4CB5GYe7uclDVBt/IlI1vYG9OB5bYB4
 iy5MI0NjGu3TI5uBno8cIoCa/HdJ8dYaqe7HB4YiecVw0BJ6mQPN+1aa/A4kB/IQ
 ykR1NMECfR1cT+j/rJayPYazbK/cQbSPM9k8S4naMIFzQ=
From: Jiacheng Ye <yejiacheng4@h-partners.com>
To: dev@dpdk.org
Cc: Feifei Wang <wangfeifei40@huawei.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v8 08/28] net/hinic3: fix per-queue start/stop on non-HTN
 devices
Date: Sat, 21 Nov 2026 00:34:33 +0800
Message-ID: <20261120163454.1159-9-yejiacheng4@h-partners.com>
X-Mailer: git-send-email 2.53.0.windows.2
In-Reply-To: <20261120163454.1159-1-yejiacheng4@h-partners.com>
References: <20261117155711.1048-1-yejiacheng4@h-partners.com>
 <20261120163454.1159-1-yejiacheng4@h-partners.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Ac8vCgCHL5q7dgBrCNqsBQ--.46998S10
X-Coremail-Antispam: 1Uf129KBjvJXoW7ArW7Xr1rCFWxAFy3tFyfXrb_yoW8urWUpF
 Wqga9rZFyDtay8X34DJw4xua45X3WDG34jg3WkC3WF9wn8ZFy5Z345KFW8ZrnYqrWIyF42
 vF1qkr4Dt3WjqwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UtsqAUUUUU=
Sender: wff_light@vip.163.com
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiNh+nsWsAdr8QdwAA36
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

On a device without HTN FDIR, rx_queue_start() and rx_queue_stop() return
-EINVAL whenever the queue has no TCAM rule:
hinic3_enable_rxq_fdir_filter() reports -EINVAL in that case and both
callers treat it as fatal. Such a queue has nothing to update, so return
success.

hinic3_start_rq() gates the RQ enable command on NIC_F_FDIR, but the
intended flag is NIC_F_HTN_FDIR, as the stop path already uses. Fix the
check so an STN device is not sent a command it rejects.

Fixes: b247199927a1 ("net/hinic3: fix return value of FDIR enabling")
Fixes: b20dc78b286a ("net/hinic3: support Compact CQE in Rx")
Signed-off-by: Jiacheng Ye <yejiacheng4@h-partners.com>
---
 drivers/net/hinic3/hinic3_fdir.c | 2 +-
 drivers/net/hinic3/hinic3_rx.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/hinic3/hinic3_fdir.c b/drivers/net/hinic3/hinic3_fdir.c
index 95ce7cfe16..f3a570b358 100644
--- a/drivers/net/hinic3/hinic3_fdir.c
+++ b/drivers/net/hinic3/hinic3_fdir.c
@@ -1278,7 +1278,7 @@ hinic3_enable_rxq_fdir_filter(struct rte_eth_dev *dev, uint32_t queue_id, uint32
 	struct hinic3_nic_dev *nic_dev = HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev);
 	struct hinic3_tcam_filter *it;
 	struct hinic3_tcam_cfg_rule fdir_tcam_rule;
-	int ret = -EINVAL;
+	int ret = 0;
 	uint32_t queue_res;
 	uint16_t index;
 
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

