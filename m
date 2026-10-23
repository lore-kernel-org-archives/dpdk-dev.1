Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49072606A31A
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Oct 2026 15:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=vip.163.com header.i=@vip.163.com header.a=rsa-sha256 header.s=s110527 header.b=L/RCZDO6
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4574D40A82;
	Fri, 23 Oct 2026 17:58:27 +0200 (CEST)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [220.197.30.221])
 by mails.dpdk.org (Postfix) with ESMTP id BEA044068A;
 Fri, 23 Oct 2026 17:58:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=7fIOxm3rCOwJZSnVBDwripZXQlqgpKGsOtjdeE3+mY8=;
 b=L/RCZDO6QlDlyCL9FY3czUydm59qMi2zpgcm+R53mW92jS2gIgdIlXFPpRMRl+
 dHE2u+KghU/V0EFNme4Y/3OLSrXGKGiaLCepQa6L9sgtrpT6OOGPWt8gVkey4hhd
 1VRY0Gy4gj7v1X+WTBLc4/4+AZUlxC8HKcWRt0J6dCO3A=
From: Jiacheng Ye <yejiacheng4@h-partners.com>
To: dev@dpdk.org
Cc: Feifei Wang <wangfeifei40@huawei.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Anatoly Burakov <anatoly.burakov@intel.com>, stable@dpdk.org
Subject: [PATCH v4 06/27] net/hinic3: attach ethdev and set ops in secondary
 process
Date: Fri, 23 Oct 2026 23:57:47 +0800
Message-ID: <20261023155809.855-7-yejiacheng4@h-partners.com>
X-Mailer: git-send-email 2.53.0.windows.2
In-Reply-To: <20261023155809.855-1-yejiacheng4@h-partners.com>
References: <20261019151930.1572-1-yejiacheng4@h-partners.com>
 <20261023155809.855-1-yejiacheng4@h-partners.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: As8vCgAnQEEUhNtqKyfqAw--.15103S8
X-Coremail-Antispam: 1Uf129KBjvJXoW7tw45WFy5JF1DJryUAFykuFg_yoW8Wr4kpF
 WjgayrAFykGF47A3Z3Ca1fAa4ruw4xJ34UKr9xGa45C34rXF4jk343J3yjvrs8trZxAF17
 ZF4UCrWv9rnFq3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jzrWrUUUUU=
Sender: wff_light@vip.163.com
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiMhe3wWrbhBfihgAA3V
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
index eb5ddd9de6..5d67615a94 100644
--- a/drivers/net/hinic3/hinic3_ethdev.c
+++ b/drivers/net/hinic3/hinic3_ethdev.c
@@ -2127,6 +2127,9 @@ hinic3_dev_close(struct rte_eth_dev *eth_dev)
 		HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(eth_dev);
 	int ret;
 
+	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
+		return 0;
+
 	if (hinic3_test_and_set_bit(HINIC3_DEV_CLOSE, &nic_dev->dev_status)) {
 		PMD_DRV_LOG(WARNING, "Device %s already closed",
 			    nic_dev->dev_name);
@@ -3400,6 +3403,18 @@ hinic3_func_init(struct rte_eth_dev *eth_dev)
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

