Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D409DC61DB9
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Aug 2026 07:40:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3B51940E09;
	Fri, 28 Aug 2026 09:40:35 +0200 (CEST)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by mails.dpdk.org (Postfix) with ESMTP id 348FB402B6
 for <dev@dpdk.org>; Fri, 28 Aug 2026 09:40:14 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-03 (Coremail) with SMTP id rQCowACXoD5aO5Fqs9VzBg--.62617S2;
 Fri, 28 Aug 2026 15:40:10 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org
Subject: [PATCH v6 37/45] net/sxe2: wrap command params fill debug log in macro
Date: Fri, 28 Aug 2026 15:40:10 +0800
Message-ID: <20260828074010.2249720-1-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260828032731.2109423-1-liujie5@linkdatatechnology.com>
References: <20260828032731.2109423-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowACXoD5aO5Fqs9VzBg--.62617S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr18Cw15uryrZw48JF1rtFb_yoW8uFWUpF
 WFvw1YqFs0qF48Ars7Jr4xZa4aka1UAa4j9F48Ww1FkF9rXrWkZFWUKryrta4Uuws0qF1S
 yFsFgay8WryxXrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUkmb7Iv0xC_Cr1lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4
 vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40E
 FcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWrXVW3AwAv7VC2z280aVAFwI0_Cr
 0_Gr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwAKzVCY07xG64k0F24l
 42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
 WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAK
 I48JMIIF0xvE2Ix0cI8IcVAFwI0_Xr0_Ar1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r
 4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Cr0_Gr1UMIIF
 0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxUIrWrDUUUU
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

sxe2_drv_cmd_params_fill() passes the opcode string as a
parameter to __sxe2_drv_cmd_params_fill() just to emit a debug
log. The debug log is level-gated by PMD_DEV_LOG_DEBUG either
way; moving it into the macro body only consolidates the call
sites.

Wrap the log and the fill helper in a do/while block, dropping
the opc_str parameter so the opcode stringization happens at
the call site. Evaluate the adapter argument exactly once
through a local variable.

Cc: stephen@networkplumber.org
Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>
---
 drivers/net/sxe2/sxe2_cmd_chnl.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/sxe2/sxe2_cmd_chnl.c b/drivers/net/sxe2/sxe2_cmd_chnl.c
index 16a2c3fea4..84fe401ec4 100644
--- a/drivers/net/sxe2/sxe2_cmd_chnl.c
+++ b/drivers/net/sxe2/sxe2_cmd_chnl.c
@@ -26,10 +26,9 @@ static void sxe2_drv_trace_id_alloc(uint64_t *trace_id)
 }
 
 static void __sxe2_drv_cmd_params_fill(struct sxe2_adapter *adapter,
-		struct sxe2_drv_cmd_params *cmd, uint32_t opc, const char *opc_str,
+		struct sxe2_drv_cmd_params *cmd, uint32_t opc,
 		void *in_data, uint32_t in_len, void *out_data, uint32_t out_len)
 {
-	PMD_DEV_LOG_DEBUG(adapter, DRV, "cmd opcode:%s", opc_str);
 	cmd->timeout = SXE2_DRV_CMD_DFLT_TIMEOUT;
 	cmd->opcode  = opc;
 	cmd->vsi_id  = adapter->vsi_ctxt.dpdk_vsi_id;
@@ -44,8 +43,11 @@ static void __sxe2_drv_cmd_params_fill(struct sxe2_adapter *adapter,
 }
 
 #define sxe2_drv_cmd_params_fill(adapter, cmd, opc, in_data, in_len, out_data, out_len) \
-	__sxe2_drv_cmd_params_fill(adapter, cmd, opc, #opc, in_data, in_len, out_data, out_len)
-
+	do { \
+		struct sxe2_adapter *__adapter = (adapter); \
+		PMD_DEV_LOG_DEBUG(__adapter, DRV, "cmd opcode:%s", #opc); \
+		__sxe2_drv_cmd_params_fill(__adapter, cmd, opc, in_data, in_len, out_data, out_len); \
+	} while (0)
 
 int32_t sxe2_drv_dev_caps_get(struct sxe2_adapter *adapter, struct sxe2_drv_dev_caps_resp *dev_caps)
 {
-- 
2.52.0

