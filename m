Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6940BCD98ED
	for <dpdk-dev@archiver.kernel.org>; Thu, 18 Jun 2026 08:28:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 04F7D40DC9;
	Thu, 18 Jun 2026 10:27:48 +0200 (CEST)
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
 by mails.dpdk.org (Postfix) with ESMTP id D07A24065F
 for <dev@dpdk.org>; Thu, 18 Jun 2026 10:27:36 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-05 (Coremail) with SMTP id zQCowAAnlunwqzNqY8cLFA--.46372S15;
 Thu, 18 Jun 2026 16:27:34 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org,
	Jie Liu <liujie5@linkdatatechnology.com>
Subject: [PATCH v3 13/20] net/sxe2: support firmware version reading
Date: Thu, 18 Jun 2026 16:27:16 +0800
Message-ID: <20260618082723.571054-14-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260618082723.571054-1-liujie5@linkdatatechnology.com>
References: <20260614092328.201826-21-liujie5@linkdatatechnology.com>
 <20260618082723.571054-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowAAnlunwqzNqY8cLFA--.46372S15
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr1rGw1UJF1UWw1DtFy7Jrb_yoW8Kry8pF
 4YqFy5uFWUJF1fWw4fAws5uF1agr48trykKr9Igw1fCasrJ347AFyjqFyYvw18AryxAF1r
 Kan2vF4DGay8Wr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUBl14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
 kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
 z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr
 1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWx
 Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2I
 x0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8
 JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lw4CEc2x0rVAKj4xxMx
 AIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_
 Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAwCIc40Y0x0EwI
 xGrwCI42IY6xIIjxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWx
 JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcV
 C2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbfcTJUUUUU==
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
index 282713dab3..98f79c180c 100644
--- a/drivers/net/sxe2/sxe2_ethdev.c
+++ b/drivers/net/sxe2/sxe2_ethdev.c
@@ -121,7 +121,8 @@ static int32_t sxe2_udp_tunnel_port_add(struct rte_eth_dev *dev,
 					struct rte_eth_udp_tunnel *tunnel_udp);
 static int32_t sxe2_udp_tunnel_port_del(struct rte_eth_dev *dev,
 					struct rte_eth_udp_tunnel *tunnel_udp);
-
+static int32_t sxe2_fw_version_string_get(struct rte_eth_dev *dev,
+				      char *fw_version, size_t fw_size);
 
 static const struct eth_dev_ops sxe2_eth_dev_ops = {
 	.dev_configure              = sxe2_dev_configure,
@@ -182,6 +183,8 @@ static const struct eth_dev_ops sxe2_eth_dev_ops = {
 	.xstats_reset               = sxe2_stats_info_reset,
 
 	.queue_stats_mapping_set    = sxe2_queue_stats_mapping_set,
+
+	.fw_version_get             = sxe2_fw_version_string_get,
 };
 
 static int32_t sxe2_dev_configure(struct rte_eth_dev *dev)
@@ -1578,6 +1581,36 @@ static int32_t sxe2_eth_pmd_remove(struct sxe2_common_device *cdev)
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
2.31.1

