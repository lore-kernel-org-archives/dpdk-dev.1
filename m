Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22A54C624D6
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Sep 2026 01:58:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DF6E842DA6;
	Thu,  3 Sep 2026 03:58:38 +0200 (CEST)
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
 by mails.dpdk.org (Postfix) with ESMTP id 155F142D83;
 Thu,  3 Sep 2026 03:58:35 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-05 (Coremail) with SMTP id zQCowACXBUBJ1JhqnR9ABw--.24637S2;
 Thu, 03 Sep 2026 09:58:33 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org,
	Jie Liu <liujie5@linkdatatechnology.com>,
	stable@dpdk.org
Subject: [PATCH v10 48/48] net/sxe2: fix devargs parse error check for
 representors
Date: Thu,  3 Sep 2026 09:58:32 +0800
Message-ID: <20260903015832.162481-1-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260902021650.83354-1-liujie5@linkdatatechnology.com>
References: <20260902021650.83354-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowACXBUBJ1JhqnR9ABw--.24637S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr15tw4fAFy3Kr47CrW3KFg_yoW8XF45pF
 4kGFyIvFW5K3WrXw45Aa1rXF1Y9w4xA3yjkFW8W34Ska45Ar4UAryqga4jg3W0kryDJr1I
 yF47tr4qva1fKaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUkK14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
 JVWxJr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r
 4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2Wl
 Yx0E2Ix0cI8IcVAFwI0_Wrv_ZF1lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbV
 WUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lw4CEc2x0rVAK
 j4xxMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
 0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y
 0x0EwIxGrwCI42IY6xIIjxv20xvE14v26F1j6w1UMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
 W8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWx
 JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7sRiTmhD
 UUUUU==
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

rte_eth_devargs_parse() returns a positive value (the number of
representor ports) when a representor is specified in the device
string, and a negative value on error.  The old check treated any
non-zero return as an error, so probing a representor device always
failed.

Only treat a negative return as an error, so the positive
representor count is not misreported.

Fixes: d8e4e075acb4 ("net/sxe2: add probing skeleton")
Cc: stable@dpdk.org
Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>
---
 drivers/net/sxe2/sxe2_ethdev.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/sxe2/sxe2_ethdev.c b/drivers/net/sxe2/sxe2_ethdev.c
index 82ad6e660a..abbec09cc2 100644
--- a/drivers/net/sxe2/sxe2_ethdev.c
+++ b/drivers/net/sxe2/sxe2_ethdev.c
@@ -2316,10 +2316,10 @@ static int32_t sxe2_parse_eth_devargs(struct rte_device *dev,
 		ret = rte_eth_devargs_parse(dev->devargs->cls_str,
 					    eth_da,
 					    1);
-		if (ret) {
+		if (ret < 0) {
 			PMD_LOG_ERR(INIT, "Failed to parse device arguments: %s",
 				dev->devargs->cls_str);
-			return -rte_errno;
+			return ret;
 		}
 	}
 
@@ -2327,10 +2327,10 @@ static int32_t sxe2_parse_eth_devargs(struct rte_device *dev,
 		ret = rte_eth_devargs_parse(dev->devargs->args,
 					    eth_da,
 					    1);
-		if (ret) {
+		if (ret < 0) {
 			PMD_LOG_ERR(INIT, "Failed to parse device arguments: %s",
 				dev->devargs->args);
-			return -rte_errno;
+			return ret;
 		}
 	}
 
-- 
2.52.0

