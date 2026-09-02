Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11C40C61DD6
	for <dpdk-dev@archiver.kernel.org>; Wed,  2 Sep 2026 02:03:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2D6F442707;
	Wed,  2 Sep 2026 04:03:45 +0200 (CEST)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
 by mails.dpdk.org (Postfix) with ESMTP id 7E3D340A82;
 Wed,  2 Sep 2026 04:03:42 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-01 (Coremail) with SMTP id qwCowAB3Se3fg5dqR5wHBw--.32861S2;
 Wed, 02 Sep 2026 10:03:32 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org,
	Jie Liu <liujie5@linkdatatechnology.com>,
	stable@dpdk.org
Subject: [PATCH v9 33/48] net/sxe2: fix RSS action attribute validation
Date: Wed,  2 Sep 2026 10:03:01 +0800
Message-ID: <20260902020301.77761-1-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260901031006.3686638-1-liujie5@linkdatatechnology.com>
References: <20260901031006.3686638-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowAB3Se3fg5dqR5wHBw--.32861S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr1rGw4DKFWkWFyrCFW8Xrb_yoW8Cw1kpw
 45urn8ZrZaqa1xGw4fAr40qFyY9r1UWFWjkFZayw4fA3Wqqw4DG34q9w1jkw18CrZ8Aw40
 gay7KF17Cr4kAFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUkC14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
 JVWxJr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
 1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
 7VC0I7IYx2IY67AKxVWrXVW3AwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r
 1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwAKzVCY07xG64k0
 F24l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxV
 WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI
 7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Xr0_Ar1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
 4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4U
 MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjTRKLvNUU
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

The rss->level/key_len/queue_num checks only set the rte_flow_error
but still return 0 (success), so invalid RSS configurations are
accepted instead of being rejected with ENOTSUP.

Return the error code from the validation checks, matching the
behavior in the V3 implementation.

Fixes: 635084db5d57 ("net/sxe2: support VF representors")
Cc: stable@dpdk.org
Cc: stephen@networkplumber.org
Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>
---
 drivers/net/sxe2/sxe2_flow_parse_action.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/net/sxe2/sxe2_flow_parse_action.c b/drivers/net/sxe2/sxe2_flow_parse_action.c
index 03ada4e8a6..65ddfeb47f 100644
--- a/drivers/net/sxe2/sxe2_flow_parse_action.c
+++ b/drivers/net/sxe2/sxe2_flow_parse_action.c
@@ -12,7 +12,7 @@
 static int32_t sxe2_flow_check_rss_action_attr(const struct rte_flow_action_rss *rss,
 					   struct rte_flow_error *error)
 {
-	int32_t ret = ENOTSUP;
+	int32_t ret = -ENOTSUP;
 	switch (rss->func) {
 	case RTE_ETH_HASH_FUNCTION_DEFAULT:
 	case RTE_ETH_HASH_FUNCTION_TOEPLITZ:
@@ -25,15 +25,21 @@ static int32_t sxe2_flow_check_rss_action_attr(const struct rte_flow_action_rss
 		goto l_end;
 	}
 
-	if (rss->level > 2)
+	if (rss->level > 2) {
 		rte_flow_error_set(error, ENOTSUP, RTE_FLOW_ERROR_TYPE_ACTION, NULL,
 			"RSS  level is could not be greater than 2");
-	if (rss->key_len)
+		goto l_end;
+	}
+	if (rss->key_len) {
 		rte_flow_error_set(error, ENOTSUP, RTE_FLOW_ERROR_TYPE_ACTION, NULL,
 			"a nonzero RSS key_len is not supported");
-	if (rss->queue_num)
+		goto l_end;
+	}
+	if (rss->queue_num) {
 		rte_flow_error_set(error, ENOTSUP, RTE_FLOW_ERROR_TYPE_ACTION, NULL,
 			"a non-NULL RSS queue is not supported");
+		goto l_end;
+	}
 	ret = 0;
 l_end:
 	return ret;
-- 
2.52.0

