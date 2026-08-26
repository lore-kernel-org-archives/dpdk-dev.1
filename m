Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9075C5DF97
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Aug 2026 08:57:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 90E5440DCA;
	Wed, 26 Aug 2026 10:57:11 +0200 (CEST)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by mails.dpdk.org (Postfix) with ESMTP id 681F240C35
 for <dev@dpdk.org>; Wed, 26 Aug 2026 10:57:07 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-03 (Coremail) with SMTP id rQCowACnsT9gqo5q+eRMBg--.31291S2;
 Wed, 26 Aug 2026 16:57:04 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org
Subject: [PATCH v3 35/51] net/sxe2: align flow meta proc priority handling
 with V3
Date: Wed, 26 Aug 2026 16:57:04 +0800
Message-ID: <20260826085704.991992-1-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260818021518.2922515-14-liujie5@linkdatatechnology.com>
References: <20260818021518.2922515-14-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowACnsT9gqo5q+eRMBg--.31291S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr18GrW8WFyxZF1UKFy5CFg_yoW8XF1kpF
 4fWF9rZFykXr17W3yfA3WxXFyYgw18KFZxCFZay3W3Ca4UJ34kuryDta4Sgr97C3sxJFyf
 tFW2vF9xCan5urDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUkSb7Iv0xC_Zr1lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
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
 6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU3NB_UUUUU
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

sxe2_flow_meta_proc() uses a flat else-if chain for the priority
check, while the V3 implementation nests the switchdev mode check
inside the else branch. Align the structure with V3 for consistency.

Cc: stable@dpdk.org
Cc: stephen@networkplumber.org
Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>
---
 drivers/net/sxe2/sxe2_flow.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/net/sxe2/sxe2_flow.c b/drivers/net/sxe2/sxe2_flow.c
index 46f5763f62..037d9e6f9c 100644
--- a/drivers/net/sxe2/sxe2_flow.c
+++ b/drivers/net/sxe2/sxe2_flow.c
@@ -285,14 +285,16 @@ static int32_t sxe2_flow_meta_proc(struct rte_eth_dev *dev,
 					attr, "Only support priority 0.");
 			ret = -rte_errno;
 			goto l_end;
-		} else if (!adapter->switchdev_info.is_switchdev) {
-			PMD_LOG_ERR(DRV, "Legacy mode only support priority 0.");
-			rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_ATTR_PRIORITY,
-					attr, "Legacy mode only priority 0.");
-			ret = -rte_errno;
-			goto l_end;
 		} else {
-			flow->meta.flow_prio = attr->priority;
+			if (!adapter->switchdev_info.is_switchdev) {
+				PMD_LOG_ERR(DRV, "Legacy mode only support priority 0.");
+				rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_ATTR_PRIORITY,
+						attr, "Legacy mode only priority 0.");
+				ret = -rte_errno;
+				goto l_end;
+			} else {
+				flow->meta.flow_prio = attr->priority;
+			}
 		}
 	}
 
-- 
2.52.0

