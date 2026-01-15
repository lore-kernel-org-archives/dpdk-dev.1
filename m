Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F121D3CCB3
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Jan 2026 06:18:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F0CA740DCD;
	Thu, 15 Jan 2026 07:18:31 +0100 (CET)
Received: from out28-220.mail.aliyun.com (out28-220.mail.aliyun.com
 [115.124.28.220])
 by mails.dpdk.org (Postfix) with ESMTP id 69C7A402F0;
 Thu, 15 Jan 2026 07:18:29 +0100 (CET)
Received: from ubuntu.localdomain(mailfrom:dimon.zhao@nebula-matrix.com
 fp:SMTPD_---.g6s1wy2_1768457905 cluster:ay29) by smtp.aliyun-inc.com;
 Thu, 15 Jan 2026 14:18:26 +0800
From: Dimon Zhao <dimon.zhao@nebula-matrix.com>
To: dev@dpdk.org
Cc: Dimon Zhao <dimon.zhao@nebula-matrix.com>, stable@dpdk.org,
 Kyo Liu <kyo.liu@nebula-matrix.com>, Leon Yu <leon.yu@nebula-matrix.com>,
 Sam Chen <sam.chen@nebula-matrix.com>
Subject: [PATCH v2 1/1] net/nbl: fix hardware stats interrupt nesting issue
Date: Wed, 14 Jan 2026 22:18:07 -0800
Message-Id: <20260115061807.65832-2-dimon.zhao@nebula-matrix.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260115061807.65832-1-dimon.zhao@nebula-matrix.com>
References: <20260114081558.50370-2-dimon.zhao@nebula-matrix.com>
 <20260115061807.65832-1-dimon.zhao@nebula-matrix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The timer interrupt handler periodically queries and updates
hw_stats via mailbox.
Since mailbox operations rely on interrupts for packet reception,
this causes interrupt nesting.
To resolve this, trigger a task from the interrupt handler and
start a dedicated thread to execute this task,
eliminating the nested interrupt scenario.

Fixes: c9726a719ca1 ("net/nbl: support dropped packets counter")
Cc: stable@dpdk.org

Signed-off-by: Dimon Zhao <dimon.zhao@nebula-matrix.com>
---
 drivers/net/nbl/nbl_dev/nbl_dev.c | 56 ++++++++++++++++++++++++++++++-
 drivers/net/nbl/nbl_dev/nbl_dev.h |  2 ++
 2 files changed, 57 insertions(+), 1 deletion(-)

diff --git a/drivers/net/nbl/nbl_dev/nbl_dev.c b/drivers/net/nbl/nbl_dev/nbl_dev.c
index e926c06456..0afd5a37b1 100644
--- a/drivers/net/nbl/nbl_dev/nbl_dev.c
+++ b/drivers/net/nbl/nbl_dev/nbl_dev.c
@@ -168,11 +168,37 @@ static int nbl_dev_update_hw_stats(struct rte_eth_dev *eth_dev)
 	return ret;
 }
 
+static uint32_t nbl_dev_thread_hw_stats_task(void *param)
+{
+	struct rte_eth_dev *eth_dev = param;
+	struct nbl_adapter *adapter = ETH_DEV_TO_NBL_DEV_PF_PRIV(eth_dev);
+	struct nbl_dev_mgt *dev_mgt = NBL_ADAPTER_TO_DEV_MGT(adapter);
+	struct nbl_dev_net_mgt *net_dev = NBL_DEV_MGT_TO_NET_DEV(dev_mgt);
+	char unused[16];
+	ssize_t nr;
+
+	while (true) {
+		nr = read(net_dev->fd[0], &unused, sizeof(unused));
+		if (nr <= 0)
+			break;
+
+		nbl_dev_update_hw_stats(eth_dev);
+	}
+
+	return 0;
+}
+
 static void nbl_dev_update_hw_stats_handler(void *param)
 {
 	struct rte_eth_dev *eth_dev = param;
+	struct nbl_adapter *adapter = ETH_DEV_TO_NBL_DEV_PF_PRIV(eth_dev);
+	struct nbl_dev_mgt *dev_mgt = NBL_ADAPTER_TO_DEV_MGT(adapter);
+	struct nbl_dev_net_mgt *net_dev = NBL_DEV_MGT_TO_NET_DEV(dev_mgt);
+	char notify_byte = 0;
+	ssize_t nw;
 
-	nbl_dev_update_hw_stats(eth_dev);
+	nw = write(net_dev->fd[1], &notify_byte, 1);
+	RTE_SET_USED(nw);
 
 	rte_eal_alarm_set(NBL_ALARM_INTERNAL, nbl_dev_update_hw_stats_handler, eth_dev);
 }
@@ -187,6 +213,23 @@ static int nbl_dev_hw_stats_start(struct rte_eth_dev *eth_dev)
 	struct nbl_ustore_stats ustore_stats = {0};
 	int ret;
 
+	ret = pipe(net_dev->fd);
+	if (ret) {
+		NBL_LOG(ERR, "hw_stats pipe failed, ret %d", ret);
+		return ret;
+	}
+
+	ret = rte_thread_create_internal_control(&net_dev->tid, "nbl_hw_stats_thread",
+						 nbl_dev_thread_hw_stats_task, eth_dev);
+	if (ret) {
+		NBL_LOG(ERR, "create hw_stats thread failed, ret %d", ret);
+		close(net_dev->fd[0]);
+		close(net_dev->fd[1]);
+		net_dev->fd[0] = -1;
+		net_dev->fd[1] = -1;
+		return ret;
+	}
+
 	if (!common->is_vf) {
 		ret = disp_ops->get_ustore_total_pkt_drop_stats(NBL_DEV_MGT_TO_DISP_PRIV(dev_mgt),
 						common->eth_id, &ustore_stats);
@@ -261,8 +304,19 @@ static void nbl_dev_txrx_stop(struct rte_eth_dev *eth_dev)
 
 static int nbl_dev_hw_stats_stop(struct rte_eth_dev *eth_dev)
 {
+	struct nbl_adapter *adapter = ETH_DEV_TO_NBL_DEV_PF_PRIV(eth_dev);
+	struct nbl_dev_mgt *dev_mgt = NBL_ADAPTER_TO_DEV_MGT(adapter);
+	struct nbl_dev_net_mgt *net_dev = NBL_DEV_MGT_TO_NET_DEV(dev_mgt);
+
 	rte_eal_alarm_cancel(nbl_dev_update_hw_stats_handler, eth_dev);
 
+	/* closing pipe to cause hw_stats thread to exit */
+	close(net_dev->fd[0]);
+	close(net_dev->fd[1]);
+	net_dev->fd[0] = -1;
+	net_dev->fd[1] = -1;
+	rte_thread_join(net_dev->tid, NULL);
+
 	return 0;
 }
 
diff --git a/drivers/net/nbl/nbl_dev/nbl_dev.h b/drivers/net/nbl/nbl_dev/nbl_dev.h
index 21d87a372d..bfe2b06deb 100644
--- a/drivers/net/nbl/nbl_dev/nbl_dev.h
+++ b/drivers/net/nbl/nbl_dev/nbl_dev.h
@@ -60,6 +60,8 @@ struct nbl_dev_net_mgt {
 	u8 rsv:6;
 	struct nbl_hw_stats hw_stats;
 	bool hw_stats_inited;
+	rte_thread_t tid;
+	int fd[2];
 };
 
 struct nbl_dev_mgt {
-- 
2.34.1

