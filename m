Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11144C61DE4
	for <dpdk-dev@archiver.kernel.org>; Mon, 31 Aug 2026 02:44:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A8BA540B8D;
	Mon, 31 Aug 2026 04:44:20 +0200 (CEST)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by mails.dpdk.org (Postfix) with ESMTP id CAC7240663;
 Mon, 31 Aug 2026 04:44:17 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-03 (Coremail) with SMTP id rQCowABHTTt_6pRq_tijBg--.22984S2;
 Mon, 31 Aug 2026 10:44:15 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org,
	Jie Liu <liujie5@linkdatatechnology.com>,
	stable@dpdk.org
Subject: [PATCH v7 33/47] net/sxe2: fix RSS action attribute validation
Date: Mon, 31 Aug 2026 10:44:15 +0800
Message-ID: <20260831024415.3231166-1-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260828074056.2250222-1-liujie5@linkdatatechnology.com>
References: <20260828074056.2250222-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowABHTTt_6pRq_tijBg--.22984S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr1rGw4DKFWkWFyrCFW8Xrb_yoW8Cw1kpw
 45urn8ZrZaqa1xGw4fAr40qFyY9r1UWFWjkFZayw4fA3Wqqw4DG34q9w1jkw18CrZ8Aw40
 gay7KF17Cr4kAFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUkE14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
 JVWxJr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r
 4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2Wl
 Yx0E2Ix0cI8IcVAFwI0_Wrv_ZF1lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbV
 WUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lw4CEc2x0rVAK
 j4xxMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
 0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y
 0x0EwIxGrwCI42IY6xIIjxv20xvE14v26F1j6w1UMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
 W8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWxJVW8
 Jr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0pR9NV
 PUUUUU=
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

