Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBE96C61DC2
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Aug 2026 08:58:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 34DBC40E1D;
	Wed, 26 Aug 2026 10:58:18 +0200 (CEST)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by mails.dpdk.org (Postfix) with ESMTP id 8253B40B9E
 for <dev@dpdk.org>; Wed, 26 Aug 2026 10:58:15 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-03 (Coremail) with SMTP id rQCowACXmzmlqo5qN+lMBg--.29194S2;
 Wed, 26 Aug 2026 16:58:13 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org
Subject: [PATCH v3 47/51] net/sxe2: harden ACL flow count resource handling
Date: Wed, 26 Aug 2026 16:58:13 +0800
Message-ID: <20260826085813.993075-1-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260818021518.2922515-14-liujie5@linkdatatechnology.com>
References: <20260818021518.2922515-14-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowACXmzmlqo5qN+lMBg--.29194S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZFyxuF13JrW7Kr48tF4kXrb_yoW5Wr4Dpr
 48Wry3ZFWaqFnxGw4rJw4fZFyY93W7Jry2kFW09w4Sv3WUXry7urs8Ka45Kw1DCr4xJr1f
 tFW2vF15Can5A3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUkqb7Iv0xC_tr1lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjc
 xK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG
 64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Wrv_ZF1lYx0Ex4A2jsIE14v26r
 4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwAKzVCY07xG64k0F24l
 42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
 WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAK
 I48JMIIF0xvE2Ix0cI8IcVAFwI0_Ar0_tr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r
 4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAI
 cVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IUn0D77UUUUU==
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

Fix issues found in the ACL flow count (statistics) support:

- sxe2_flow_free_mgr(): when the flow engine type is neither ACL nor
  FNAV, the code skipped the TAILQ_REMOVE but still called rte_free()
  on the manager, leaving a freed pointer on the list. Return -ENOTSUP
  for an unknown engine type instead.
- sxe2_flow_cid_mgr.stat_index is uint16_t while the firmware returns
  and consumes a uint32_t stat id; widen it to uint32_t to avoid silent
  truncation.
- sxe2_drv_cmd_code: write the ACL STAT_ALLOC/STAT_FREE entries with an
  explicit SXE2_MK_DRV_CMD() value instead of relying on implicit
  increment over the encoded QUERY value.

Cc: stable@dpdk.org
Cc: stephen@networkplumber.org
Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>
---
 drivers/net/sxe2/sxe2_drv_cmd.h     | 6 ++++--
 drivers/net/sxe2/sxe2_flow.c        | 6 ++++++
 drivers/net/sxe2/sxe2_flow_define.h | 2 +-
 3 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/net/sxe2/sxe2_drv_cmd.h b/drivers/net/sxe2/sxe2_drv_cmd.h
index f66b574e83..8d907b3843 100644
--- a/drivers/net/sxe2/sxe2_drv_cmd.h
+++ b/drivers/net/sxe2/sxe2_drv_cmd.h
@@ -836,8 +836,10 @@ enum sxe2_drv_cmd_code {
 
 	SXE2_DRV_CMD_FLOW_ACL_STAT_QUERY =
 		SXE2_MK_DRV_CMD(SXE2_DRV_CMD_MODULE_ACL, 1),
-	SXE2_DRV_CMD_FLOW_ACL_STAT_ALLOC,
-	SXE2_DRV_CMD_FLOW_ACL_STAT_FREE,
+	SXE2_DRV_CMD_FLOW_ACL_STAT_ALLOC =
+		SXE2_MK_DRV_CMD(SXE2_DRV_CMD_MODULE_ACL, 2),
+	SXE2_DRV_CMD_FLOW_ACL_STAT_FREE =
+		SXE2_MK_DRV_CMD(SXE2_DRV_CMD_MODULE_ACL, 3),
 
 };
 
diff --git a/drivers/net/sxe2/sxe2_flow.c b/drivers/net/sxe2/sxe2_flow.c
index 037d9e6f9c..45ace5b848 100644
--- a/drivers/net/sxe2/sxe2_flow.c
+++ b/drivers/net/sxe2/sxe2_flow.c
@@ -1288,6 +1288,12 @@ int32_t sxe2_flow_free_mgr(struct sxe2_adapter *adapter,
 			cid_mgr_list = &adapter->flow_ctxt.fnav_hw_res.flow_cid_mgr_list;
 			TAILQ_REMOVE(cid_mgr_list, mgr, next);
 			ret = sxe2_drv_flow_fnav_free_stat(adapter, mgr->stat_index);
+		} else {
+			PMD_LOG_ERR(DRV,
+				"Failed to free flow count, unknown engine type: %d.",
+				flow->engine_type);
+			ret = -ENOTSUP;
+			return ret;
 		}
 		if (ret) {
 			rte_flow_error_set(error, EIO,
diff --git a/drivers/net/sxe2/sxe2_flow_define.h b/drivers/net/sxe2/sxe2_flow_define.h
index f56f687dc7..d04499f5cb 100644
--- a/drivers/net/sxe2/sxe2_flow_define.h
+++ b/drivers/net/sxe2/sxe2_flow_define.h
@@ -100,7 +100,7 @@ TAILQ_HEAD(rte_flow_list_t, rte_flow);
 
 struct sxe2_flow_cid_mgr {
 	TAILQ_ENTRY(sxe2_flow_cid_mgr) next;
-	uint16_t stat_index;
+	uint32_t stat_index;
 	uint32_t user_id;
 	uint32_t driver_id;
 	uint32_t count_type;
-- 
2.52.0

