Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CA7960A7E5C
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 Oct 2026 15:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=vip.163.com header.i=@vip.163.com header.a=rsa-sha256 header.s=s110527 header.b=LjQ/bcox
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F236B40B9F;
	Mon, 19 Oct 2026 17:20:08 +0200 (CEST)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [220.197.30.221])
 by mails.dpdk.org (Postfix) with ESMTP id 51E5A40A6C
 for <dev@dpdk.org>; Mon, 19 Oct 2026 17:19:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=8nktWA9whzszFqnjBqRmbi6WowhBChYbNYNeaCm9JJY=;
 b=LjQ/bcoxBv0pAWt8l3nMh9siA+BqZXQqO36rrTNcTKS5QuhyrAMzRbS2ZNmhRv
 ZstEHk95Ie3ZUmCCxo5VVUFZctozHTrc5os3N/41js9WFEw/RBIhB7JjrI1AbQTo
 pTD+HFZybS7huhP0Y3t7LxN1SIoZttjv3eiKb4qJPGALw=
From: Jiacheng Ye <yejiacheng4@h-partners.com>
To: dev@dpdk.org
Cc: Feifei Wang <wangfeifei40@huawei.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH 08/27] net/hinic3: add SP230 Rx queue interrupt handling
Date: Mon, 19 Oct 2026 23:19:10 +0800
Message-ID: <20261019151930.1572-9-yejiacheng4@h-partners.com>
X-Mailer: git-send-email 2.53.0.windows.2
In-Reply-To: <20261019151930.1572-1-yejiacheng4@h-partners.com>
References: <20261014150923.838-1-yejiacheng4@h-partners.com>
 <20261019151930.1572-1-yejiacheng4@h-partners.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Ac8vCgCXK5cUNdZqqgUkBA--.15723S10
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cw4xZrykur43Ww4rAw15XFb_yoW8Ww4rpF
 Z8GFZ5CrykXa1aqanxG3y3CF1fWa97Wa47Kr9xJ34jvr13JF1rAryUGFy5ZFnrKrW3C3W2
 vr48Zr4vg3WUt3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j8YFAUUUUU=
Sender: wff_light@vip.163.com
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiNRujrWrWNRvSbwAA3P
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_ZEN_BLOCKED_OPENDNS,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On SP230 the Rx MSI-X vector is asserted during packet aggregation. When
Rx interrupts are disabled, skip the per-queue MSI-X enable and instead
configure the vectors' coalescing and auto-mask state at init, so those
assertions are masked instead of preempting a core.

Signed-off-by: Jiacheng Ye <yejiacheng4@h-partners.com>
---
 drivers/net/hinic3/hinic3_ethdev.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/net/hinic3/hinic3_ethdev.c b/drivers/net/hinic3/hinic3_ethdev.c
index 8502017c86..05762ecc50 100644
--- a/drivers/net/hinic3/hinic3_ethdev.c
+++ b/drivers/net/hinic3/hinic3_ethdev.c
@@ -1498,6 +1498,9 @@ hinic3_dev_rx_queue_intr_enable(struct rte_eth_dev *dev, uint16_t queue_id)
 	if (!rte_intr_dp_is_en(intr_handle) || !intr_handle->intr_vec)
 		return 0;
 
+	if (HINIC3_IS_SP230_NIC(nic_dev) && !dev->data->dev_conf.intr_conf.rxq)
+		return 0;
+
 	msix_intr = (uint16_t)intr_handle->intr_vec[queue_id];
 	hinic3_set_msix_auto_mask_state(nic_dev->hwdev, msix_intr,
 					HINIC3_SET_MSIX_AUTO_MASK);
@@ -1802,7 +1805,13 @@ hinic3_init_rxq_intr(struct rte_eth_dev *dev)
 
 	intr_handle = dev->intr_handle;
 	nic_dev = HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev);
-	if (!dev->data->dev_conf.intr_conf.rxq)
+
+	/*
+	 * SP230 asserts the Rx MSI-X vector during aggregation; configure the
+	 * vectors' coalescing/auto-mask at init so those assertions are masked
+	 * instead of preempting a core.
+	 */
+	if (!HINIC3_IS_SP230_NIC(nic_dev) && !dev->data->dev_conf.intr_conf.rxq)
 		return 0;
 
 	if (!rte_intr_cap_multiple(intr_handle)) {
-- 
2.33.0

