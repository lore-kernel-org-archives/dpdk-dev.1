Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D506F606A321
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Nov 2026 17:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=vip.163.com header.i=@vip.163.com header.a=rsa-sha256 header.s=s110527 header.b=hazdqPNs
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9958440656;
	Wed, 25 Nov 2026 18:05:53 +0100 (CET)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [1.95.21.3])
 by mails.dpdk.org (Postfix) with ESMTPS id 5F6F540284;
 Wed, 25 Nov 2026 18:05:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=V7Kd9AquIUQKspICbCmJ1FXJ0A6AUt5BVCdSmrx3FKk=;
 b=hazdqPNs1Aro1jbpJ/gYzOwASGsNWHJ/mMAcjA8prbHi3/FzQJvyQf/elzwZY3
 BzXRVnmZM4G4FCBudLfbj/2Gk2kkdAU32BhCSo/h1UewNt06sTxIyFI/BWNTuSJZ
 RdLyqVH65NzBGAShNq9KaYRg7e8vWKgpPIs7x0pY0c934=
From: Jiacheng Ye <yejiacheng4@h-partners.com>
To: dev@dpdk.org
Cc: Feifei Wang <wangfeifei40@huawei.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org
Subject: [PATCH v9 08/30] net/hinic3: attach ethdev and set ops in secondary
 process
Date: Thu, 26 Nov 2026 01:04:02 +0800
Message-ID: <20261125170425.5430-9-yejiacheng4@h-partners.com>
X-Mailer: git-send-email 2.56.0.windows.2
In-Reply-To: <20261125170425.5430-1-yejiacheng4@h-partners.com>
References: <20261125170425.5430-1-yejiacheng4@h-partners.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: As8vCgDn77FiFQdrEdNeBQ--.6538S10
X-Coremail-Antispam: 1Uf129KBjvJXoW7tw45WFy5JF1DJryUAFykuFg_yoW8Xr13pF
 Wjga9YyrWkWF47A3ZxCa1fAa48uw4xJ34UKr93Ga45C34rXF4Fk343J3yUZr45t39xA3W7
 ZF4UCrWvvrnFqaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jzrWrUUUUU=
Sender: wff_light@vip.163.com
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiMgr7BmsHFWoaJwAA3r
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
 drivers/net/hinic3/hinic3_ethdev.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/hinic3/hinic3_ethdev.c b/drivers/net/hinic3/hinic3_ethdev.c
index d9821d1c9f..aaae6f4364 100644
--- a/drivers/net/hinic3/hinic3_ethdev.c
+++ b/drivers/net/hinic3/hinic3_ethdev.c
@@ -2135,6 +2135,9 @@ hinic3_dev_close(struct rte_eth_dev *eth_dev)
 		HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(eth_dev);
 	int ret;
 
+	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
+		return 0;
+
 	if (hinic3_test_and_set_bit(HINIC3_DEV_CLOSE, &nic_dev->dev_status)) {
 		PMD_DRV_LOG(WARNING, "Device %s already closed",
 			    nic_dev->dev_name);
@@ -3408,6 +3411,13 @@ hinic3_func_init(struct rte_eth_dev *eth_dev)
 		PMD_DRV_LOG(INFO, "Initialize %s in secondary process",
 			    eth_dev->data->name);
 
+		nic_dev = HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(eth_dev);
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

