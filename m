Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 218C3C61DCD
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Aug 2026 07:37:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D6A0D4067D;
	Fri, 28 Aug 2026 09:37:27 +0200 (CEST)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by mails.dpdk.org (Postfix) with ESMTP id 874FB40150
 for <dev@dpdk.org>; Fri, 28 Aug 2026 09:37:26 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-03 (Coremail) with SMTP id rQCowAA3OzmzOpFqF8lzBg--.19627S2;
 Fri, 28 Aug 2026 15:37:24 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org
Subject: [PATCH v6 08/45] net/sxe2: use base device name for representor naming
Date: Fri, 28 Aug 2026 15:37:23 +0800
Message-ID: <20260828073723.2247965-1-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260828032731.2109423-1-liujie5@linkdatatechnology.com>
References: <20260828032731.2109423-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowAA3OzmzOpFqF8lzBg--.19627S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr15uF18Jw18Cr4DGF13CFg_yoW8Xr1DpF
 W8XFy5AFWfXFnrZw48Za18uryYkr4rtayqkFyYv34fCF9FqryDCrW5Kw1Ut34vkr4UZF4F
 yanYvr18Gw1qvrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUkqb7Iv0xC_Cr1lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
 C2z280aVCY1x0267AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
 Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv67AKxVWxJV
 W8Jr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4kE6xkIj40Ew7xC0wCF
 04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r
 18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij64vI
 r41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr
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

Update the representor device naming to use the base device name
prefix, and set the numa_node from the parent device data so that
representor devices are allocated on the same NUMA node.

Cc: stephen@networkplumber.org
Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>
---
 drivers/net/sxe2/sxe2_ethdev_repr.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/sxe2/sxe2_ethdev_repr.c b/drivers/net/sxe2/sxe2_ethdev_repr.c
index c698baafe0..b7096f5927 100644
--- a/drivers/net/sxe2/sxe2_ethdev_repr.c
+++ b/drivers/net/sxe2/sxe2_ethdev_repr.c
@@ -552,8 +552,8 @@ int32_t sxe2_switchdev_repr_devs_init(struct sxe2_adapter *adapter,
 	}
 
 	for (repr_idx = 0; repr_idx < req_eth_da->nb_representor_ports; ++repr_idx) {
-		snprintf(name, sizeof(name), "sxe2_representor_c%dpf%d%s%u",
-			 adapter->pf_idx, adapter->pf_idx,
+		snprintf(name, sizeof(name), "%s_representor_%s%u",
+			 adapter->cdev->dev->name,
 			 "vf",
 			 req_eth_da->representor_ports[repr_idx]);
 
@@ -562,6 +562,7 @@ int32_t sxe2_switchdev_repr_devs_init(struct sxe2_adapter *adapter,
 			ret = -ENOMEM;
 			goto l_release_port;
 		}
+		eth_dev->data->numa_node = adapter->dev_info.dev_data->numa_node;
 		eth_dev->data->dev_private = rte_zmalloc_socket(name,
 			sizeof(struct sxe2_adapter),
 			RTE_CACHE_LINE_SIZE,
-- 
2.52.0

