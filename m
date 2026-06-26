Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE6CDCDE008
	for <dpdk-dev@archiver.kernel.org>; Fri, 26 Jun 2026 06:45:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3CE2140272;
	Fri, 26 Jun 2026 08:45:53 +0200 (CEST)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by mails.dpdk.org (Postfix) with ESMTP id E9E1240264
 for <dev@dpdk.org>; Fri, 26 Jun 2026 08:45:50 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-03 (Coremail) with SMTP id rQCowABHGI8cID5qqgjnFQ--.16729S2;
 Fri, 26 Jun 2026 14:45:48 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org,
	Jie Liu <liujie5@linkdatatechnology.com>
Subject: [PATCH v9 15/23] net/sxe2: support firmware version reading
Date: Fri, 26 Jun 2026 14:45:48 +0800
Message-ID: <20260626064548.361185-1-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <220260625133139.207632-1-liujie5@linkdatatechnology.com>
References: <220260625133139.207632-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowABHGI8cID5qqgjnFQ--.16729S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr1rGw1UJF1UWw1DtFy7Jrb_yoW8Kry8pF
 4Yqa45uFWUJF1fWw4fAws5uF1agr4xKrykKr9Igw1fCasrJ347AFyDtFyYvw1rAryxAF1r
 Kan7ZF1DGa18Wr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUkv14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
 6F4UM28EF7xvwVC2z280aVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr
 0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
 6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr
 0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4kE6xkIj40Ew7xC
 0wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r
 1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij
 64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr
 0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF
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

This patch implements the logic to retrieve the firmware version and
Build ID from the hardware during device initialization.

The version is exposed to applications through the dev_info_get API.

Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>
---
 drivers/net/sxe2/sxe2_ethdev.c | 35 +++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/drivers/net/sxe2/sxe2_ethdev.c b/drivers/net/sxe2/sxe2_ethdev.c
index 9bff741961..02ff6be322 100644
--- a/drivers/net/sxe2/sxe2_ethdev.c
+++ b/drivers/net/sxe2/sxe2_ethdev.c
@@ -119,7 +119,8 @@ static int32_t sxe2_udp_tunnel_port_add(struct rte_eth_dev *dev,
 					struct rte_eth_udp_tunnel *tunnel_udp);
 static int32_t sxe2_udp_tunnel_port_del(struct rte_eth_dev *dev,
 					struct rte_eth_udp_tunnel *tunnel_udp);
-
+static int32_t sxe2_fw_version_string_get(struct rte_eth_dev *dev,
+				      char *fw_version, size_t fw_size);
 
 static const struct eth_dev_ops sxe2_eth_dev_ops = {
 	.dev_configure              = sxe2_dev_configure,
@@ -180,6 +181,8 @@ static const struct eth_dev_ops sxe2_eth_dev_ops = {
 	.xstats_reset               = sxe2_stats_info_reset,
 
 	.queue_stats_mapping_set    = sxe2_queue_stats_mapping_set,
+
+	.fw_version_get             = sxe2_fw_version_string_get,
 };
 
 static int32_t sxe2_dev_configure(struct rte_eth_dev *dev)
@@ -1556,6 +1559,36 @@ static int32_t sxe2_eth_pmd_remove(struct sxe2_common_device *cdev)
 	return ret;
 }
 
+static int32_t sxe2_fw_version_string_get(struct rte_eth_dev *dev, char *fw_version, size_t fw_size)
+{
+	struct sxe2_adapter *adapter =
+		SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
+	struct sxe2_fw_info *fw_info = &adapter->dev_info.fw;
+	int32_t ret_len;
+	int32_t ret;
+
+	ret_len = snprintf(fw_version, fw_size,
+			   "%u.%u.%u.%u",
+			   fw_info->main_version_id,
+			   fw_info->sub_version_id,
+			   fw_info->fix_version_id,
+			   fw_info->build_id);
+
+	if (ret_len < 0) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	ret_len += 1;
+	if (fw_size < (size_t)ret_len)
+		ret = -EINVAL;
+	else
+		ret = 0;
+
+out:
+	return ret;
+}
+
 static uint16_t sxe2_switchdev_repr_id_encode_get(struct sxe2_switchdev_info *switchdev_info)
 {
 	enum rte_eth_representor_type type;
-- 
2.52.0

