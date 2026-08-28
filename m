Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 903BDC61DCD
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Aug 2026 07:39:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E61ED40DCA;
	Fri, 28 Aug 2026 09:39:24 +0200 (CEST)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by mails.dpdk.org (Postfix) with ESMTP id 9AEF240DCD
 for <dev@dpdk.org>; Fri, 28 Aug 2026 09:39:23 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-03 (Coremail) with SMTP id rQCowABXWzkmO5Fq+tFzBg--.57903S2;
 Fri, 28 Aug 2026 15:39:18 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org
Subject: [PATCH v6 28/45] net/sxe2: refactor primary process MP message
 handling
Date: Fri, 28 Aug 2026 15:39:18 +0800
Message-ID: <20260828073918.2249197-1-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260828032731.2109423-1-liujie5@linkdatatechnology.com>
References: <20260828032731.2109423-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowABXWzkmO5Fq+tFzBg--.57903S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXw47Kr1xCF48ury5ZrW8Zwb_yoWrXFy3pF
 1fKr1rXF1xXw129r13Ja1kZFn0krWxJr1UCFZxt34ftw15tF18CF45tr90y3WFk3sxAr1F
 ka17tF98G3W2vaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUkmb7Iv0xC_Zr1lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4
 vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40E
 FcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Cr
 0_Gr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwAKzVCY07xG64k0F24l
 42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
 WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAK
 I48JMIIF0xvE2Ix0cI8IcVAFwI0_Xr0_Ar1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r
 4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Cr0_Gr1UMIIF
 0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxUcoqcUUUUU
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

Extract the multi-process work logic into the sxe2_mp_do_primary_work
helper and operate on a copy of the request in the primary handler so
the original message is not modified. Simplify the reply construction
and return -ENOENT instead of -EINVAL when no response is received
from the primary process.

Fixes: 5db446ba97b0 ("net/sxe2: support statistics and multi-process")
Cc: stable@dpdk.org
Cc: stephen@networkplumber.org

Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>
---
 drivers/net/sxe2/sxe2_mp.c | 59 ++++++++++++++++++++++----------------
 1 file changed, 34 insertions(+), 25 deletions(-)

diff --git a/drivers/net/sxe2/sxe2_mp.c b/drivers/net/sxe2/sxe2_mp.c
index a4a5c76495..93a11150a9 100644
--- a/drivers/net/sxe2/sxe2_mp.c
+++ b/drivers/net/sxe2/sxe2_mp.c
@@ -29,16 +29,11 @@ static int32_t sxe2_mp_secondary_handle(const struct rte_mp_msg *mp_msg,
 					 const void *peer);
 
 static int32_t
-sxe2_mp_primary_handle(const struct rte_mp_msg *mp_msg, const void *peer)
+sxe2_mp_do_primary_work(struct sxe2_mp_param *param)
 {
-	struct rte_mp_msg reply;
-	const struct sxe2_mp_param *param =
-			(const struct sxe2_mp_param *)mp_msg->param;
-	struct sxe2_mp_param *reply_param = (struct sxe2_mp_param *)reply.param;
 	struct rte_eth_dev *dev;
-	int32_t ret = 0;
 	struct sxe2_mp_shared_data *mz_data;
-	int32_t send_reply = 0;
+	int32_t ret = 0;
 	int32_t cnt = 0;
 
 	if (!rte_eth_dev_is_valid_port(param->port_id)) {
@@ -49,24 +44,21 @@ sxe2_mp_primary_handle(const struct rte_mp_msg *mp_msg, const void *peer)
 	}
 
 	dev = &rte_eth_devices[param->port_id];
-	sxe2_mp_mz = rte_memzone_lookup(SXE2_MP_MZ_NAME);
+
 	if (sxe2_mp_mz == NULL) {
-		PMD_LOG_ERR(DRV, "Failed to lookup memzone %s", SXE2_MP_MZ_NAME);
-		ret = -ENOENT;
-		goto out;
+		sxe2_mp_mz = rte_memzone_lookup(SXE2_MP_MZ_NAME);
+		if (sxe2_mp_mz == NULL) {
+			PMD_LOG_ERR(DRV, "Failed to lookup memzone %s",
+					SXE2_MP_MZ_NAME);
+			ret = -ENOENT;
+			goto out;
+		}
 	}
 
 	mz_data = (struct sxe2_mp_shared_data *)sxe2_mp_mz->addr;
-	send_reply = 1;
-
-	memset(&reply, 0, sizeof(reply));
-	(void)strlcpy(reply.name, SXE2_MP_NAME, sizeof(reply.name));
-	reply.len_param = sizeof(*reply_param);
-
 	switch (param->type) {
 	case SXE2_MP_REQ_GET_STATS:
-		ret = sxe2_stats_info_get(dev,
-					  &mz_data->payload.stats_blk.stats,
+		ret = sxe2_stats_info_get(dev, &mz_data->payload.stats_blk.stats,
 					  &mz_data->payload.stats_blk.qstats);
 		break;
 	case SXE2_MP_REQ_GET_XSTATS:
@@ -88,15 +80,32 @@ sxe2_mp_primary_handle(const struct rte_mp_msg *mp_msg, const void *peer)
 	default:
 		PMD_LOG_ERR(DRV, "primary process: unrecognized msg type: %d",
 				param->type);
-		send_reply = false;
 		ret = -EINVAL;
-		goto out;
+		break;
 	}
+
 out:
-	if (!send_reply)
-		return ret;
+	param->result = ret;
+	return ret;
+}
 
-	reply_param->result = ret;
+static int32_t
+sxe2_mp_primary_handle(const struct rte_mp_msg *mp_msg, const void *peer)
+{
+	struct rte_mp_msg reply;
+	struct sxe2_mp_param *reply_param = (struct sxe2_mp_param *)reply.param;
+	const struct sxe2_mp_param *param =
+			(const struct sxe2_mp_param *)mp_msg->param;
+	struct sxe2_mp_param param_copy;
+
+	memset(&reply, 0, sizeof(reply));
+	(void)strlcpy(reply.name, SXE2_MP_NAME, sizeof(reply.name));
+	reply.len_param = sizeof(*reply_param);
+
+	param_copy = *param;
+	(void)sxe2_mp_do_primary_work(&param_copy);
+
+	reply_param->result = param_copy.result;
 	reply_param->type = param->type;
 	reply_param->port_id = param->port_id;
 
@@ -275,7 +284,7 @@ int32_t sxe2_mp_request_simple(struct rte_eth_dev *dev,
 	if (reply.nb_received == 0) {
 		PMD_LOG_ERR(DRV, "No response received from primary for type=%d, port %u",
 			type, dev->data->port_id);
-		ret = -EINVAL;
+		ret = -ENOENT;
 		goto out;
 	}
 
-- 
2.52.0

