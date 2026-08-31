Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97F85C61DE4
	for <dpdk-dev@archiver.kernel.org>; Mon, 31 Aug 2026 02:43:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0BEFA40E03;
	Mon, 31 Aug 2026 04:43:18 +0200 (CEST)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by mails.dpdk.org (Postfix) with ESMTP id 28AAA40DCA
 for <dev@dpdk.org>; Mon, 31 Aug 2026 04:43:15 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-03 (Coremail) with SMTP id rQCowADn8T8_6pRqA9ajBg--.23638S2;
 Mon, 31 Aug 2026 10:43:11 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org,
	Jie Liu <liujie5@linkdatatechnology.com>
Subject: [PATCH v7 22/47] net/sxe2: align dev init and cleanup order
Date: Mon, 31 Aug 2026 10:43:11 +0800
Message-ID: <20260831024311.3230840-1-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260828074056.2250222-1-liujie5@linkdatatechnology.com>
References: <20260828074056.2250222-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowADn8T8_6pRqA9ajBg--.23638S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr18tFy7GFWkJryxCF4rKrg_yoW8AFWfpF
 4Sg3W5AF12yFsrXw13AayxWF1UKayfKrWjkr4Ska4fXa48ur1YkFyUJF1ak34DC3yUA3WF
 ya12ywn8Kw4vgaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUkC14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
 JVWxJr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
 1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
 7VC0I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r
 1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwAKzVCY07xG64k0
 F24l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxV
 WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI
 7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Ar0_tr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
 4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4U
 MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjfU8KsjUU
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

Move sxe2_eth_init() to be called before sxe2_sw_init() and
rearrange the error cleanup labels so that resources are torn down
in the reverse order of initialization.

Cc: stephen@networkplumber.org
Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>
---
 drivers/net/sxe2/sxe2_ethdev.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/sxe2/sxe2_ethdev.c b/drivers/net/sxe2/sxe2_ethdev.c
index 5d14e28d96..5bce710b29 100644
--- a/drivers/net/sxe2/sxe2_ethdev.c
+++ b/drivers/net/sxe2/sxe2_ethdev.c
@@ -1942,6 +1942,12 @@ static int32_t sxe2_dev_init(struct rte_eth_dev *dev,
 		goto init_switchdev_err;
 	}
 
+	ret = sxe2_eth_init(dev);
+	if (ret) {
+		PMD_LOG_ERR(INIT, "Failed to initialize eth parameters, ret=%d", ret);
+		goto init_eth_err;
+	}
+
 	ret = sxe2_sw_init(dev);
 	if (ret) {
 		PMD_LOG_ERR(INIT, "Failed to initialize sw parameters, ret=[%d]", ret);
@@ -1954,12 +1960,6 @@ static int32_t sxe2_dev_init(struct rte_eth_dev *dev,
 		goto init_irq_err;
 	}
 
-	ret = sxe2_eth_init(dev);
-	if (ret) {
-		PMD_LOG_ERR(INIT, "Failed to initialize eth parameters, ret=%d", ret);
-		goto init_eth_err;
-	}
-
 	ret = sxe2_security_init(dev);
 	if (ret) {
 		PMD_LOG_ERR(INIT, "Failed to initialize security, ret=%d", ret);
@@ -2014,12 +2014,12 @@ static int32_t sxe2_dev_init(struct rte_eth_dev *dev,
 init_rss_err:
 	sxe2_security_uinit(dev);
 init_security_err:
-	sxe2_eth_uinit(dev);
-init_eth_err:
 	sxe2_intr_uninit(dev);
 init_irq_err:
 	sxe2_sw_uninit(dev);
 init_sw_err:
+	sxe2_eth_uinit(dev);
+init_eth_err:
 	(void)sxe2_switchdev_uninit(dev);
 init_switchdev_err:
 init_dev_info_err:
-- 
2.52.0

