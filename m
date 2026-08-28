Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37440C61DB9
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Aug 2026 03:25:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 723AA40B9E;
	Fri, 28 Aug 2026 05:25:40 +0200 (CEST)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by mails.dpdk.org (Postfix) with ESMTP id 8A5AB40B9E
 for <dev@dpdk.org>; Fri, 28 Aug 2026 05:25:19 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-03 (Coremail) with SMTP id rQCowABXWzmc_5BqbiVwBg--.55073S2;
 Fri, 28 Aug 2026 11:25:17 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org
Subject: [PATCH v5 22/45] net/sxe2: align dev init and cleanup order
Date: Fri, 28 Aug 2026 11:25:16 +0800
Message-ID: <20260828032516.2107279-1-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260827024035.1432256-1-liujie5@linkdatatechnology.com>
References: <20260827024035.1432256-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowABXWzmc_5BqbiVwBg--.55073S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr18tFy7GFWkJryxCF4rKrg_yoW8AFWfpF
 4Sg3W5AF12yFsrXw13AayxWF1UKayfKrWjkr4Ska4fXa48ur1YkFyUJF1ak34DC3yUA3WF
 ya12ywn8Kw4vgaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUk2b7Iv0xC_Cr1lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Cr0_Gr1UM28EF7xvwV
 C2z280aVCY1x0267AKxVW8JVW8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
 F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26r4j6F
 4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwAKzVCY07xG64k0F24l42xK
 82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGw
 C20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAKI48J
 MIIF0xvE2Ix0cI8IcVAFwI0_Xr0_Ar1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMI
 IF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E
 87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU4KZXUUUUU
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

