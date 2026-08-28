Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D7BEC61DB9
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Aug 2026 03:27:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4B7EE40E44;
	Fri, 28 Aug 2026 05:26:55 +0200 (CEST)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by mails.dpdk.org (Postfix) with ESMTP id 6088440E2B
 for <dev@dpdk.org>; Fri, 28 Aug 2026 05:26:47 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-03 (Coremail) with SMTP id rQCowAD3AUD1_5Bq0itwBg--.60706S2;
 Fri, 28 Aug 2026 11:26:45 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org
Subject: [PATCH v5 37/45] net/sxe2: wrap command params fill debug log in macro
Date: Fri, 28 Aug 2026 11:26:45 +0800
Message-ID: <20260828032645.2108261-1-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260827024035.1432256-1-liujie5@linkdatatechnology.com>
References: <20260827024035.1432256-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowAD3AUD1_5Bq0itwBg--.60706S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr18Cw15uryrZw48JF1rtFb_yoW8uFWUpF
 WFvw1YqFs0qF48Ars7Jr4xZa4aka1UAa4j9F48Ww1FkF9rXrWkZFWUKryrta4Uuws0qF1S
 yFsFgay8WryxXrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUkab7Iv0xC_Cr1lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Cr0_Gr1UM28EF7xvwV
 C2z280aVCY1x0267AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
 Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26rWY6Fy7McIj6I8E87Iv67AKxVW8JV
 WxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lw4CEc2x0rVAKj4xxMxAI
 w28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr
 4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAwCIc40Y0x0EwIxG
 rwCI42IY6xIIjxv20xvE14v26ryj6F1UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr
 1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvE
 x4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j6Hq7UUUUU=
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

