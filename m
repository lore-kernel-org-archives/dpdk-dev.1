Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD180C624D5
	for <dpdk-dev@archiver.kernel.org>; Wed,  2 Sep 2026 02:16:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B81CA40DD8;
	Wed,  2 Sep 2026 04:16:58 +0200 (CEST)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
 by mails.dpdk.org (Postfix) with ESMTP id 5438040DD5;
 Wed,  2 Sep 2026 04:16:55 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-01 (Coremail) with SMTP id qwCowAB3Su4Wh5dqGsAHBw--.14406S2;
 Wed, 02 Sep 2026 10:16:54 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org,
	Jie Liu <liujie5@linkdatatechnology.com>,
	stable@dpdk.org
Subject: [PATCH v9 36/48] net/sxe2: validate representor ID against VF count
Date: Wed,  2 Sep 2026 10:16:50 +0800
Message-ID: <20260902021650.83354-1-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260901031006.3686638-1-liujie5@linkdatatechnology.com>
References: <20260901031006.3686638-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowAB3Su4Wh5dqGsAHBw--.14406S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr15Zw4fCF1ftr48uF1ftFb_yoW8XF13pr
 ZFgw45Zry5GFnxX3WDG3Z3uFyYkw4rG34jka1Fvw1fCF17CryUCr98Ka4rta4qkwsrZw1f
 Aa17ZryUWw1rZF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUkC14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
 6r4UJwA2z4x0Y4vEx4A2jsIE14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
 1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
 7VC0I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Cr0_Gr1UMcvjeVCFs4IE7xkEbV
 WUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lw4CEc2x0rVAK
 j4xxMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
 0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y
 0x0EwIxGrwCI42IY6xIIjxv20xvE14v26ryj6F1UMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
 WxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4U
 MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjfUOID7UU
 UUU
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

sxe2_switchdev_repr_private_data_init() indexes
parent_adapter->repr_ctxt.repr_vf_id[repr_id] without checking that
repr_id is within the number of configured VFs, which can access out
of bounds when an invalid representor ID is passed.

Add a bounds check on repr_id against repr_ctxt.nb_vf and return
-EINVAL on the error path.

Fixes: 635084db5d57 ("net/sxe2: support VF representors")
Cc: stable@dpdk.org
Cc: stephen@networkplumber.org
Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>
---
 drivers/net/sxe2/sxe2_switchdev.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/sxe2/sxe2_switchdev.c b/drivers/net/sxe2/sxe2_switchdev.c
index efb1468b91..d0304ccc94 100644
--- a/drivers/net/sxe2/sxe2_switchdev.c
+++ b/drivers/net/sxe2/sxe2_switchdev.c
@@ -312,6 +312,12 @@ int32_t sxe2_switchdev_repr_private_data_init(struct rte_eth_dev *dev,
 	repr_priv_data->repr_q_id = repr_id;
 	repr_priv_data->repr_pf_id = parent_adapter->pf_idx;
 	repr_priv_data->repr_vf_id = repr_id;
+	if (repr_id >= parent_adapter->repr_ctxt.nb_vf) {
+		PMD_LOG_ERR(INIT, "repr_id %u exceed max vf %u",
+			repr_id, parent_adapter->repr_ctxt.nb_vf);
+		ret = -EINVAL;
+		goto l_free;
+	}
 	repr_priv_data->repr_vf_primary_vsi_id =
 		parent_adapter->repr_ctxt.repr_vf_id[repr_id].kernel_vsi_id;
 	repr_priv_data->repr_vf_backup_vsi_id =
-- 
2.52.0

