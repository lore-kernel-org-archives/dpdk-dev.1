Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1A95C624A4
	for <dpdk-dev@archiver.kernel.org>; Tue,  1 Sep 2026 03:07:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E302940A76;
	Tue,  1 Sep 2026 05:07:29 +0200 (CEST)
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
 by mails.dpdk.org (Postfix) with ESMTP id DECA340A76
 for <dev@dpdk.org>; Tue,  1 Sep 2026 05:07:27 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-05 (Coremail) with SMTP id zQCowAAHcz1tQZZqH_ghBw--.58231S2;
 Tue, 01 Sep 2026 11:07:26 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org,
	Jie Liu <liujie5@linkdatatechnology.com>
Subject: [PATCH v8 22/49] net/sxe2: align dev init and cleanup order
Date: Tue,  1 Sep 2026 11:07:25 +0800
Message-ID: <20260901030725.3684769-1-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260831024549.3231744-1-liujie5@linkdatatechnology.com>
References: <20260831024549.3231744-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowAAHcz1tQZZqH_ghBw--.58231S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr18tFy7GFWkJryxCF4rKrg_yoW8AFWfpF
 4Sg3W5AF12yFsrXw13AayxWF1UKayfKrWjkr4Ska4fXa48ur1YkFyUJF1ak34DC3yUA3WF
 ya12ywn8Kw4vgaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUkv14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
 6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8JV
 W8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
 2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJV
 W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lw4CEc2x0rVAKj4xx
 MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr
 0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAwCIc40Y0x0E
 wIxGrwCI42IY6xIIjxv20xvE14v26ryj6F1UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJV
 W8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF
 0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JU4v38UUUUU=
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

