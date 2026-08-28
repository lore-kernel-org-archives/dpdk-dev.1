Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0DFAC61DCD
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Aug 2026 07:37:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4340E406B6;
	Fri, 28 Aug 2026 09:37:45 +0200 (CEST)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by mails.dpdk.org (Postfix) with ESMTP id 7AAD34067C
 for <dev@dpdk.org>; Fri, 28 Aug 2026 09:37:43 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-03 (Coremail) with SMTP id rQCowACnsT_FOpFqWcpzBg--.56778S2;
 Fri, 28 Aug 2026 15:37:41 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org
Subject: [PATCH v6 11/45] net/sxe2: rename representor VSI ID fields
Date: Fri, 28 Aug 2026 15:37:40 +0800
Message-ID: <20260828073740.2248124-1-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260828032731.2109423-1-liujie5@linkdatatechnology.com>
References: <20260828032731.2109423-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowACnsT_FOpFqWcpzBg--.56778S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWF1fJFW7Ww15CF1DZFy8uFg_yoWrGryrpr
 Z8XrZ8ZF4xtFnxtwnrG3WfuFy5Kr18t3409F4Syw1fuF1UJr4UurW5KFyFyw1vkrZrZr1S
 y3W7Zw1UXw1YyaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUkqb7Iv0xC_Cr1lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
 C2z280aVCY1x0267AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
 Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv67AKxVWxJV
 W8Jr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4kE6xkIj40Ew7xC0wCF
 04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r
 18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij64vI
 r41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr
 1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26F4j6r4UJwCI42IY
 6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU8c_-PUUUUU==
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

Rename repr_vf_k_vsi_id/repr_vf_u_vsi_id to
repr_vf_primary_vsi_id/repr_vf_backup_vsi_id in
sxe2_repr_private_data and update all references.

Cc: stephen@networkplumber.org
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

