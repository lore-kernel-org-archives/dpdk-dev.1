Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE51DC61DD6
	for <dpdk-dev@archiver.kernel.org>; Wed,  2 Sep 2026 02:01:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2722441101;
	Wed,  2 Sep 2026 04:01:47 +0200 (CEST)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
 by mails.dpdk.org (Postfix) with ESMTP id 6595041109;
 Wed,  2 Sep 2026 04:01:44 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-01 (Coremail) with SMTP id qwCowACXau6Eg5dqt5gHBw--.39743S2;
 Wed, 02 Sep 2026 10:01:42 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org,
	Jie Liu <liujie5@linkdatatechnology.com>,
	stable@dpdk.org
Subject: [PATCH v9 27/48] net/sxe2: refactor primary process MP message
 handling
Date: Wed,  2 Sep 2026 10:01:37 +0800
Message-ID: <20260902020137.77119-1-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260901031006.3686638-1-liujie5@linkdatatechnology.com>
References: <20260901031006.3686638-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowACXau6Eg5dqt5gHBw--.39743S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXw47Kr1xCF48ury5ZrW8Zwb_yoWrXFy3pF
 1fKr1rXF1xXw129r13Ja1kZFn0krWxJr1UCFZxt34ftw15tF18CF45tr90y3WFk3sxAr1F
 ka17tF98G3W2vaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUkm14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
 6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr
 0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
 6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr
 0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4kE6xkIj40Ew7xC
 0wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r
 1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij
 64vIr41lIxAIcVC0I7IYx2IY67AKxVW5JVW7JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr
 0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI
 42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfU8KsjUUUUU
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

