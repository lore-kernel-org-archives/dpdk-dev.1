Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DB31C5B572
	for <dpdk-dev@archiver.kernel.org>; Mon, 17 Aug 2026 02:53:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5A48E40297;
	Mon, 17 Aug 2026 04:53:51 +0200 (CEST)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
 by mails.dpdk.org (Postfix) with ESMTP id DF0F340297
 for <dev@dpdk.org>; Mon, 17 Aug 2026 04:53:49 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-01 (Coremail) with SMTP id qwCowADHn_O5d4JqAwjkBQ--.21980S4;
 Mon, 17 Aug 2026 10:53:47 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org,
	Jie Liu <liujie5@linkdatatechnology.com>
Subject: [PATCH v1 02/13] net/sxe2: update switchdev repr VSI ID display format
Date: Mon, 17 Aug 2026 10:53:28 +0800
Message-ID: <20260817025339.2792682-3-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260817025339.2792682-1-liujie5@linkdatatechnology.com>
References: <20260817025339.2792682-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowADHn_O5d4JqAwjkBQ--.21980S4
X-Coremail-Antispam: 1UD129KBjvJXoWxXF1DCF4DGF1UZw4kKrW5GFg_yoWrGF4rpr
 Z8XrW5XF48JFnxt3srGa1fuFy5Kr48t3409F4Syw1a9F1UJr4UurW5KFyFyw1vkrZrZr1S
 yw17Zw1UXw1FyaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUBI14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
 x26xkF7I0E14v26r1I6r4UM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
 Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l84
 ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UM2AI
 xVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
 vE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xv
 r2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4kE6xkIj40Ew7xC0wCF04k20x
 vY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I
 3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij64vIr41lIx
 AIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAI
 cVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2js
 IEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUjiID7UUUUU==
X-Originating-IP: [118.112.177.181]
X-CM-SenderInfo: xolxyxrhv6zxpqngt3pdwhux5qro0w31of0z/
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

From: Jie Liu <liujie5@linkdatatechnology.com>

Update the output format for representor primary VSI ID and backup
VSI ID in switchdev dump function. The fields repr_vf_primary_vsi_id
and repr_vf_backup_vsi_id should be displayed correctly for better
debug visibility.

Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>
---
 drivers/net/sxe2/sxe2_dump.c      | 8 ++++----
 drivers/net/sxe2/sxe2_ethdev.h    | 4 ++--
 drivers/net/sxe2/sxe2_flow.c      | 4 ++--
 drivers/net/sxe2/sxe2_switchdev.c | 4 ++--
 4 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/net/sxe2/sxe2_dump.c b/drivers/net/sxe2/sxe2_dump.c
index d43473e083..590219f502 100644
--- a/drivers/net/sxe2/sxe2_dump.c
+++ b/drivers/net/sxe2/sxe2_dump.c
@@ -211,16 +211,16 @@ sxe2_dump_switchdev_info(FILE *file, struct rte_eth_dev *dev)
 			"\t  -- repr_pf_id: %u\n"
 			"\t  -- repr_vf_id: %u\n"
 			"\t  -- repr_vf_vsi_id: %u\n"
-			"\t  -- repr_vf_k_vsi_id: %s\n"
-			"\t  -- repr_vf_u_vsi_id: %s\n",
+			"\t  -- repr_vf_primary_vsi_id: %s\n"
+			"\t  -- repr_vf_backup_vsi_id: %s\n",
 			adapter->repr_priv_data->repr_id,
 			adapter->repr_priv_data->repr_q_id,
 			adapter->repr_priv_data->repr_pf_id,
 			adapter->repr_priv_data->repr_vf_id,
 			adapter->repr_priv_data->repr_vf_vsi_id,
-			sxe2_vsi_id_str(adapter->repr_priv_data->repr_vf_k_vsi_id,
+			sxe2_vsi_id_str(adapter->repr_priv_data->repr_vf_primary_vsi_id,
 					k_vsi_buf, sizeof(k_vsi_buf)),
-			sxe2_vsi_id_str(adapter->repr_priv_data->repr_vf_u_vsi_id,
+			sxe2_vsi_id_str(adapter->repr_priv_data->repr_vf_backup_vsi_id,
 					u_vsi_buf, sizeof(u_vsi_buf)));
 		goto l_end;
 	}
diff --git a/drivers/net/sxe2/sxe2_ethdev.h b/drivers/net/sxe2/sxe2_ethdev.h
index c54e8a435e..158198d74b 100644
--- a/drivers/net/sxe2/sxe2_ethdev.h
+++ b/drivers/net/sxe2/sxe2_ethdev.h
@@ -263,8 +263,8 @@ struct sxe2_repr_private_data {
 	uint16_t repr_pf_id;
 	uint16_t repr_vf_id;
 	uint16_t repr_vf_vsi_id;
-	uint16_t repr_vf_k_vsi_id;
-	uint16_t repr_vf_u_vsi_id;
+	uint16_t repr_vf_primary_vsi_id;
+	uint16_t repr_vf_backup_vsi_id;
 };
 
 struct sxe2_sched_hw_cap {
diff --git a/drivers/net/sxe2/sxe2_flow.c b/drivers/net/sxe2/sxe2_flow.c
index 63cfc36968..cf54803301 100644
--- a/drivers/net/sxe2/sxe2_flow.c
+++ b/drivers/net/sxe2/sxe2_flow.c
@@ -380,9 +380,9 @@ static int32_t sxe2_flow_src_split_proc(struct rte_eth_dev *dev,
 	if (adapter->switchdev_info.is_switchdev && adapter->is_dev_repr) {
 		flow_bond_num = 1;
 		flow_src_vsi[SXE2_MAX_DRV_TYPE_DPDK][0] =
-			adapter->repr_priv_data->repr_vf_u_vsi_id;
+			adapter->repr_priv_data->repr_vf_backup_vsi_id;
 		flow_src_vsi[SXE2_MAX_DRV_TYPE_KERNEL][0] =
-			adapter->repr_priv_data->repr_vf_k_vsi_id;
+			adapter->repr_priv_data->repr_vf_primary_vsi_id;
 	}
 
 	for (idx = 0; idx < flow_bond_num; idx++) {
diff --git a/drivers/net/sxe2/sxe2_switchdev.c b/drivers/net/sxe2/sxe2_switchdev.c
index 44703cfb5c..efb1468b91 100644
--- a/drivers/net/sxe2/sxe2_switchdev.c
+++ b/drivers/net/sxe2/sxe2_switchdev.c
@@ -312,9 +312,9 @@ int32_t sxe2_switchdev_repr_private_data_init(struct rte_eth_dev *dev,
 	repr_priv_data->repr_q_id = repr_id;
 	repr_priv_data->repr_pf_id = parent_adapter->pf_idx;
 	repr_priv_data->repr_vf_id = repr_id;
-	repr_priv_data->repr_vf_k_vsi_id =
+	repr_priv_data->repr_vf_primary_vsi_id =
 		parent_adapter->repr_ctxt.repr_vf_id[repr_id].kernel_vsi_id;
-	repr_priv_data->repr_vf_u_vsi_id =
+	repr_priv_data->repr_vf_backup_vsi_id =
 		parent_adapter->repr_ctxt.repr_vf_id[repr_id].dpdk_vsi_id;
 
 	repr_priv_data->repr_vf_vsi_id =
-- 
2.52.0

