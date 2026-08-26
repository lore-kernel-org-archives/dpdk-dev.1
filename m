Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91C6EC61DC2
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Aug 2026 08:57:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9CFC64067B;
	Wed, 26 Aug 2026 10:57:34 +0200 (CEST)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by mails.dpdk.org (Postfix) with ESMTP id 8469D4067B
 for <dev@dpdk.org>; Wed, 26 Aug 2026 10:57:23 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-03 (Coremail) with SMTP id rQCowAAXIkBxqo5q7uVMBg--.31311S2;
 Wed, 26 Aug 2026 16:57:21 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org
Subject: [PATCH v3 38/51] net/sxe2: use primary VSI ID for representor VSI
Date: Wed, 26 Aug 2026 16:57:21 +0800
Message-ID: <20260826085721.992158-1-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260818021518.2922515-14-liujie5@linkdatatechnology.com>
References: <20260818021518.2922515-14-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowAAXIkBxqo5q7uVMBg--.31311S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr18uF48Gry8tw43uFyDJrb_yoW8Xr4xpr
 W5XrZ0vF4kt3Z8X3WDW3Z29FyY9w18t34jgF4Sv3WfZF1qkr1UCry5Ka4rta4ktrZrZr13
 Za47ZryUXw1YkF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUkSb7Iv0xC_Cr1lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4
 vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40E
 FcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWrXVW3AwAv7VC2z280aVAFwI0_Gr
 0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4kE6xkIj40Ew7xC0wCF
 04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r
 18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij64vI
 r41lIxAIcVC0I7IYx2IY67AKxVW5JVW7JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr
 1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY
 6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUVNtxUUUUU
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

repr_priv_data->repr_vf_vsi_id is assigned with a ternary that falls
back to the backup (dpdk) VSI ID when the kernel VSI ID is invalid.
The V3 implementation assigns it directly from
repr_vf_primary_vsi_id.

Align with the V3 implementation by assigning repr_vf_vsi_id from
repr_vf_primary_vsi_id.

Cc: stable@dpdk.org
Cc: stephen@networkplumber.org
Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>
---
 drivers/net/sxe2/sxe2_switchdev.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/net/sxe2/sxe2_switchdev.c b/drivers/net/sxe2/sxe2_switchdev.c
index d0304ccc94..81ced7b855 100644
--- a/drivers/net/sxe2/sxe2_switchdev.c
+++ b/drivers/net/sxe2/sxe2_switchdev.c
@@ -323,11 +323,7 @@ int32_t sxe2_switchdev_repr_private_data_init(struct rte_eth_dev *dev,
 	repr_priv_data->repr_vf_backup_vsi_id =
 		parent_adapter->repr_ctxt.repr_vf_id[repr_id].dpdk_vsi_id;
 
-	repr_priv_data->repr_vf_vsi_id =
-		parent_adapter->repr_ctxt.repr_vf_id[repr_id].kernel_vsi_id !=
-		SXE2_INVALID_VSI_ID ?
-		parent_adapter->repr_ctxt.repr_vf_id[repr_id].kernel_vsi_id :
-		parent_adapter->repr_ctxt.repr_vf_id[repr_id].dpdk_vsi_id;
+	repr_priv_data->repr_vf_vsi_id = repr_priv_data->repr_vf_primary_vsi_id;
 
 	adapter->repr_priv_data = repr_priv_data;
 	goto l_end;
-- 
2.52.0

