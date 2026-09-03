Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F0A1C61DD6
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Sep 2026 01:57:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9DAD6427C4;
	Thu,  3 Sep 2026 03:57:38 +0200 (CEST)
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
 by mails.dpdk.org (Postfix) with ESMTP id 95C28427B1
 for <dev@dpdk.org>; Thu,  3 Sep 2026 03:57:36 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-05 (Coremail) with SMTP id zQCowACnFD8O1JhqLhxABw--.57259S2;
 Thu, 03 Sep 2026 09:57:34 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org,
	Jie Liu <liujie5@linkdatatechnology.com>
Subject: [PATCH v10 38/48] net/sxe2: wrap command params fill debug log in
 macro
Date: Thu,  3 Sep 2026 09:57:34 +0800
Message-ID: <20260903015734.162332-1-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260902021650.83354-1-liujie5@linkdatatechnology.com>
References: <20260902021650.83354-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowACnFD8O1JhqLhxABw--.57259S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr18Cw15uryrZw48JF1rtFb_yoW8uF45pF
 WFvw1YqFs0qF48Arn7Jr4Iva4aka1UAa4j9a10gw1S9F9rXrWkZFWUKryrta4Duws0qF1S
 yFsrWay8Wr1xur7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUkC14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
 JVWxJr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
 1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
 7VC0I7IYx2IY67AKxVWrXVW3AwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r
 1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwAKzVCY07xG64k0
 F24l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxV
 WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI
 7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Xr0_Ar1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
 4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4U
 MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjTRKLvNUU
 UUU
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
index 3a55528c44..85098ac664 100644
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
+		struct sxe2_adapter *_ad = (adapter); \
+		PMD_DEV_LOG_DEBUG(_ad, DRV, "cmd opcode:%s", #opc); \
+		__sxe2_drv_cmd_params_fill(_ad, cmd, opc, in_data, in_len, out_data, out_len); \
+	} while (0)
 
 int32_t sxe2_drv_dev_caps_get(struct sxe2_adapter *adapter, struct sxe2_drv_dev_caps_resp *dev_caps)
 {
-- 
2.52.0

