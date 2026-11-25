Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02817606A31E
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Nov 2026 17:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=vip.163.com header.i=@vip.163.com header.a=rsa-sha256 header.s=s110527 header.b=Zmy4jhCe
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5E1B84068E;
	Wed, 25 Nov 2026 18:05:54 +0100 (CET)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [220.197.30.223])
 by mails.dpdk.org (Postfix) with ESMTPS id 8038A402B2;
 Wed, 25 Nov 2026 18:05:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=l5QAr0c4vgYgi1dXLPWmIpUvFIh+rUz+4fil2sUKYz0=;
 b=Zmy4jhCekPsBxbHgmH47FCmwcdQp/QXmLxS6JZQXD9EKTIiPATZQd8oyzyidb7
 U2zYdPPo8xOljODg7KrmoJnlXverRYAfbvovdNuI4L/bpkjpnzCY0a4uu3+kP1ti
 xXoe3q/R+0/Yg0/AbF1oiwh1zWu2x+6VLc2RJ7IgS+T00=
From: Jiacheng Ye <yejiacheng4@h-partners.com>
To: dev@dpdk.org
Cc: Feifei Wang <wangfeifei40@huawei.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org
Subject: [PATCH v9 09/30] net/hinic3: return success when no FDIR rule to
 update
Date: Thu, 26 Nov 2026 01:04:03 +0800
Message-ID: <20261125170425.5430-10-yejiacheng4@h-partners.com>
X-Mailer: git-send-email 2.56.0.windows.2
In-Reply-To: <20261125170425.5430-1-yejiacheng4@h-partners.com>
References: <20261125170425.5430-1-yejiacheng4@h-partners.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: As8vCgDn77FiFQdrEdNeBQ--.6538S11
X-Coremail-Antispam: 1Uf129KBjvJXoW7uF17tr15Ar4DGr1DXw1xAFb_yoW8Gr4xpF
 Z8Wayqy34qyay8GFyDJw4Ivasxua4DG34jg3WkC3WFvwn0vFWUu345Gay8Zr1Fyrs7AF12
 vF48Ka1Dtw4qy3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jrR6wUUUUU=
Sender: wff_light@vip.163.com
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiNQv7BmsHFWsftwAA35
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

hinic3_enable_rxq_fdir_filter() fails when the queue has no TCAM rule.
rx_queue_start() and rx_queue_stop() propagate this error as fatal, so
such a queue cannot be started or stopped. There is nothing to update in
that case; return success.

The no-rule path originally returned an uninitialized value; then
commit b247199927a1 ("net/hinic3: fix return value of FDIR enabling")
set it to -EINVAL, which still makes the callers fail.

Fixes: efa3b9b36fc7 ("net/hinic3: add flow control and filters")
Fixes: b247199927a1 ("net/hinic3: fix return value of FDIR enabling")
Cc: stable@dpdk.org
Signed-off-by: Jiacheng Ye <yejiacheng4@h-partners.com>
---
 drivers/net/hinic3/hinic3_fdir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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
 
-- 
2.33.0

