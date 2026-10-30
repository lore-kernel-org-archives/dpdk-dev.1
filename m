Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F30D606A31C
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 Oct 2026 14:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=vip.163.com header.i=@vip.163.com header.a=rsa-sha256 header.s=s110527 header.b=h7731rGx
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2F6D340E4A;
	Fri, 30 Oct 2026 15:48:14 +0100 (CET)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [1.95.21.2])
 by mails.dpdk.org (Postfix) with ESMTPS id 63F5D40B9C;
 Fri, 30 Oct 2026 15:47:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=P2OXV5zkKjQcmm0c+fv48aNjNeYlWfvAWDyF75UHpDw=;
 b=h7731rGxcbv3bVGunnsI0sOtt8BBSl5MunBa0Bc+9Z7VBokplJdZki++i3Axic
 dFDUbSD0g0VcQV9ki2MQ7P/R0VTdOP1MOp6EQ6ilAESRNHq/ZsOMp9YlWRHWW9M/
 LBLNnoyQyfxm3IolRcly6TJc/IZopaippjHFerCmf3KSw=
From: Jiacheng Ye <yejiacheng4@h-partners.com>
To: dev@dpdk.org
Cc: Feifei Wang <wangfeifei40@huawei.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Anatoly Burakov <anatoly.burakov@intel.com>, stable@dpdk.org
Subject: [PATCH v5 07/28] net/hinic3: attach ethdev and set ops in secondary
 process
Date: Fri, 30 Oct 2026 22:47:11 +0800
Message-ID: <20261030144733.2120-8-yejiacheng4@h-partners.com>
X-Mailer: git-send-email 2.53.0.windows.2
In-Reply-To: <20261030144733.2120-1-yejiacheng4@h-partners.com>
References: <20261023155809.855-1-yejiacheng4@h-partners.com>
 <20261030144733.2120-1-yejiacheng4@h-partners.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: As8vCgDHb_EUruRqpJ41BA--.59781S9
X-Coremail-Antispam: 1Uf129KBjvJXoW7tw45WFy5JF1DJryUAFykuFg_yoW8Wr4kpF
 Wjga95ArykJF47A3Z3Ca1fAa4ruw4xJ34UKry3Ga45C34rXF409343J3yjvrs8trZxAF17
 ZF4UCrWv9r12qaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jzrWrUUUUU=
Sender: wff_light@vip.163.com
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiNRiFj2rkrhhghAAA37
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

The secondary process probe path returns early without attaching the
already-created ethdev or assigning its dev_ops, leaving the device
unusable in secondary processes. Attach the ethdev and set the matching
PF/VF ops.

Fixes: 468368457681 ("net/hinic3: add device initialization")
Cc: stable@dpdk.org

Signed-off-by: Jiacheng Ye <yejiacheng4@h-partners.com>
---
 drivers/net/hinic3/hinic3_ethdev.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/net/hinic3/hinic3_ethdev.c b/drivers/net/hinic3/hinic3_ethdev.c
index 6c09d6e80d..4e9e936b10 100644
--- a/drivers/net/hinic3/hinic3_ethdev.c
+++ b/drivers/net/hinic3/hinic3_ethdev.c
@@ -2137,6 +2137,9 @@ hinic3_dev_close(struct rte_eth_dev *eth_dev)
 		HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(eth_dev);
 	int ret;
 
+	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
+		return 0;
+
 	if (hinic3_test_and_set_bit(HINIC3_DEV_CLOSE, &nic_dev->dev_status)) {
 		PMD_DRV_LOG(WARNING, "Device %s already closed",
 			    nic_dev->dev_name);
@@ -3410,6 +3413,18 @@ hinic3_func_init(struct rte_eth_dev *eth_dev)
 		PMD_DRV_LOG(INFO, "Initialize %s in secondary process",
 			    eth_dev->data->name);
 
+		nic_dev = HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(eth_dev);
+		if (nic_dev == NULL) {
+			PMD_DRV_LOG(ERR, "nic_dev hwdev is NULL, dev_name: %s",
+				    eth_dev->data->name);
+			return -ENOMEM;
+		}
+
+		if (HINIC3_FUNC_TYPE(nic_dev->hwdev) == TYPE_VF)
+			eth_dev->dev_ops = &hinic3_pmd_vf_ops;
+		else
+			eth_dev->dev_ops = &hinic3_pmd_ops;
+
 		return 0;
 	}
 
-- 
2.33.0

