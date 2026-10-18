Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFDEECCF2C9
	for <dpdk-dev@archiver.kernel.org>; Sun, 18 Oct 2026 09:46:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F15AE40615;
	Sun, 18 Oct 2026 11:46:26 +0200 (CEST)
Received: from pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com
 (pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com
 [50.112.246.219])
 by mails.dpdk.org (Postfix) with ESMTP id 5315C40276
 for <dev@dpdk.org>; Sun, 18 Oct 2026 11:46:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1792316785; x=1823852785;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version;
 bh=ecFwFcn/gkc43nQzblnwprGRR8Wb/xkpqpQNJXwZ+Xk=;
 b=lq4UwqMvU1iagB36XAPypJwrH/asiuGU0RT1PTUIigJS5BeqBg8J3+6P
 DUGCQsnoVZShIsKjuN+TzsTXVUQTb1q40GulgFXiz/izsat46qAGpog15
 sECDxogefW01ffsMA91YXN9dJCkFOROJkRfOX6SrZ0vqWkFy/L2BK2tf/
 LTxscHPV6APdKpjAhG696pqtTUA/2Rnxtks9bSgvZPgM9uIqW3+64+nAb
 8HmgYMr6jDkzt251RuyEubS9zA+RMabg2bz/jLiihcFDKSz8USwDPUERM
 ZDPiYG28Y+8YAC6GGgz1UDfIC5m0XNOcZ0YugiKAytYJSZVZKhJa5l+vy Q==;
X-CSE-ConnectionGUID: T3jpCgMJS9ON4H1eRSUGYg==
X-CSE-MsgGUID: X8SMXuhgRBioBMFt4157oQ==
X-IronPort-AV: E=Sophos;i="6.27,165,1787011200"; d="scan'208";a="31339703"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
 by internal-pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2026 09:46:21 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.48:24140]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.19.38:2525]
 with esmtp (Farcaster)
 id 6d278916-9c61-4d80-a26a-e395da291633; Sun, 18 Oct 2026 09:46:21 +0000 (UTC)
X-Farcaster-Flow-ID: 6d278916-9c61-4d80-a26a-e395da291633
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Sun, 18 Oct 2026 09:46:20 +0000
Received: from HFA15-CG15235BS.amazon.com (10.1.212.8) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.53;
 Sun, 18 Oct 2026 09:46:19 +0000
From: Shai Brandes <shaibran@amazon.com>
To: <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Shai Brandes <shaibran@amazon.com>
Subject: [PATCH v3 01/13] net/ena: avoid using un-needed admin response buffers
Date: Sun, 18 Oct 2026 12:46:09 +0300
Message-ID: <fad61c4ea3db11ce62f739290ac769870e014ed5.1792312030.git.shaibran@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1792312029.git.shaibran@amazon.com>
References: <20261018063606.973-1-shaibran@amazon.com>
 <cover.1792312029.git.shaibran@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.1.212.8]
X-ClientProxiedBy: EX19D031UWC003.ant.amazon.com (10.13.139.252) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
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

There are admin commands that do not require a response parsing.
For these, there's no need to set a response buffer.

Signed-off-by: Shai Brandes <shaibran@amazon.com>
---
 drivers/net/ena/base/ena_com.c | 356 +++++++++++++++++----------------
 1 file changed, 179 insertions(+), 177 deletions(-)

diff --git a/drivers/net/ena/base/ena_com.c b/drivers/net/ena/base/ena_com.c
index f0936a6262..b1fe0bcdf7 100644
--- a/drivers/net/ena/base/ena_com.c
+++ b/drivers/net/ena/base/ena_com.c
@@ -613,6 +613,149 @@ static int ena_com_wait_and_process_admin_cq_polling(struct ena_comp_ctx *comp_c
 	return ret;
 }
 
+static int ena_com_wait_and_process_admin_cq_interrupts(struct ena_comp_ctx *comp_ctx,
+							struct ena_com_admin_queue *admin_queue)
+{
+	unsigned long flags = 0;
+	int ret;
+
+	ENA_WAIT_EVENT_WAIT(comp_ctx->wait_event,
+			    admin_queue->completion_timeout);
+
+	/* In case the command wasn't completed find out the root cause.
+	 * There might be 2 kinds of errors
+	 * 1) No completion (timeout reached)
+	 * 2) There is completion but the device didn't get any msi-x interrupt.
+	 */
+	if (unlikely(comp_ctx->status == ENA_CMD_SUBMITTED)) {
+		ENA_SPINLOCK_LOCK(admin_queue->q_lock, flags);
+		ena_com_handle_admin_completion(admin_queue);
+		admin_queue->stats.no_completion++;
+		ENA_SPINLOCK_UNLOCK(admin_queue->q_lock, flags);
+
+		ret = ENA_COM_TIMER_EXPIRED;
+		/* Now that the admin queue has been polled, check whether the
+		 * request was fulfilled by the device
+		 */
+		if (comp_ctx->status != ENA_CMD_COMPLETED) {
+			ena_trc_err(admin_queue->ena_dev,
+				    "The ena device didn't send a completion for the admin cmd %d status %d\n",
+				    comp_ctx->cmd_opcode, comp_ctx->status);
+			goto close_aq;
+		}
+
+		admin_queue->is_missing_admin_interrupt = true;
+
+		ena_trc_err(admin_queue->ena_dev,
+			    "The ena device sent a completion but the driver didn't receive a MSI-X interrupt (cmd %d), autopolling mode is %s\n",
+			    comp_ctx->cmd_opcode, admin_queue->auto_polling ? "ON" : "OFF");
+		/* If fallback to polling is not enabled, missing an interrupt
+		 * is considered an error
+		 */
+		if (!admin_queue->auto_polling)
+			goto close_aq;
+
+		ena_com_set_admin_polling_mode(admin_queue->ena_dev, true);
+	} else if (unlikely(comp_ctx->status == ENA_CMD_ABORTED)) {
+		ena_trc_err(admin_queue->ena_dev, "Command was aborted\n");
+		ENA_SPINLOCK_LOCK(admin_queue->q_lock, flags);
+		admin_queue->stats.aborted_cmd++;
+		ENA_SPINLOCK_UNLOCK(admin_queue->q_lock, flags);
+		ret = ENA_COM_NO_DEVICE;
+		goto err;
+	}
+
+	ret = ena_com_admin_status_to_errno(admin_queue, comp_ctx);
+	comp_ctxt_release(admin_queue, comp_ctx);
+
+	return ret;
+close_aq:
+	admin_queue->running_state = false;
+err:
+	comp_ctxt_release(admin_queue, comp_ctx);
+
+	return ret;
+}
+
+/* There are two types to wait for completion.
+ * Polling mode - wait until the completion is available.
+ * Async mode - wait on wait queue until the completion is ready
+ * (or the timeout expired).
+ * It is expected that the IRQ called ena_com_handle_admin_completion
+ * to mark the completions.
+ */
+static int ena_com_wait_and_process_admin_cq(struct ena_comp_ctx *comp_ctx,
+					     struct ena_com_admin_queue *admin_queue)
+{
+	if (admin_queue->polling)
+		return ena_com_wait_and_process_admin_cq_polling(comp_ctx,
+								 admin_queue);
+
+	return ena_com_wait_and_process_admin_cq_interrupts(comp_ctx,
+							    admin_queue);
+}
+
+/* ena_com_execute_admin_command - Execute admin command
+ * @admin_queue: admin queue.
+ * @cmd: the admin command to execute.
+ * @cmd_size: the command size.
+ * @cmd_completion: command completion return value.
+ * @cmd_comp_size: command completion size.
+
+ * Submit an admin command and then wait until the device returns a
+ * completion.
+ * The completion will be copied into cmd_comp.
+ *
+ * @return - 0 on success, negative value on failure.
+ */
+int ena_com_execute_admin_command(struct ena_com_admin_queue *admin_queue,
+				  struct ena_admin_aq_entry *cmd,
+				  size_t cmd_size,
+				  struct ena_admin_acq_entry *comp,
+				  size_t comp_size)
+{
+	struct ena_comp_ctx *comp_ctx;
+	int ret;
+
+	comp_ctx = ena_com_submit_admin_cmd(admin_queue, cmd, cmd_size,
+					    comp, comp_size);
+	if (IS_ERR(comp_ctx)) {
+		ret = PTR_ERR(comp_ctx);
+		if (ret != ENA_COM_NO_DEVICE)
+			ena_trc_err(admin_queue->ena_dev,
+				    "Failed to submit command [%d]\n",
+				    ret);
+
+		return ret;
+	}
+
+	ret = ena_com_wait_and_process_admin_cq(comp_ctx, admin_queue);
+	if (unlikely(ret)) {
+		if (admin_queue->running_state)
+			ena_trc_err(admin_queue->ena_dev,
+				    "Failed to process command [%d]\n",
+				    ret);
+	}
+	return ret;
+}
+
+/* ena_com_execute_admin_command_no_resp - Execute admin command without response payload
+ * @admin_queue: admin queue.
+ * @cmd: the admin command to execute.
+ * @cmd_size: the command size.
+ *
+ * Submit an admin command and then wait until the device returns a
+ * completion, no return payload is expected.
+ *
+ * @return - 0 on success, negative value on failure.
+ */
+static int ena_com_execute_admin_command_no_resp(struct ena_com_admin_queue *admin_queue,
+						 struct ena_admin_aq_entry *cmd,
+						 size_t cmd_size)
+{
+	return ena_com_execute_admin_command(admin_queue, cmd, cmd_size, NULL, 0);
+}
+
 /*
  * Set the LLQ configurations of the firmware
  *
@@ -623,7 +766,6 @@ static int ena_com_set_llq(struct ena_com_dev *ena_dev)
 {
 	struct ena_com_llq_info *llq_info = &ena_dev->llq_info;
 	struct ena_com_admin_queue *admin_queue;
-	struct ena_admin_set_feat_resp resp;
 	struct ena_admin_set_feat_cmd cmd;
 	int ret;
 
@@ -642,11 +784,9 @@ static int ena_com_set_llq(struct ena_com_dev *ena_dev)
 		BIT(ENA_ADMIN_DISABLE_META_CACHING) |
 		BIT(ENA_ADMIN_LIMIT_TX_BURST);
 
-	ret = ena_com_execute_admin_command(admin_queue,
-					    (struct ena_admin_aq_entry *)&cmd,
-					    sizeof(cmd),
-					    (struct ena_admin_acq_entry *)&resp,
-					    sizeof(resp));
+	ret = ena_com_execute_admin_command_no_resp(admin_queue,
+						    (struct ena_admin_aq_entry *)&cmd,
+						    sizeof(cmd));
 
 	if (unlikely(ret))
 		ena_trc_err(ena_dev, "Failed to set LLQ configurations: %d\n", ret);
@@ -782,62 +922,6 @@ static int ena_com_config_llq_info(struct ena_com_dev *ena_dev,
 	return rc;
 }
 
-static int ena_com_wait_and_process_admin_cq_interrupts(struct ena_comp_ctx *comp_ctx,
-							struct ena_com_admin_queue *admin_queue)
-{
-	unsigned long flags = 0;
-	int ret;
-
-	ENA_WAIT_EVENT_WAIT(comp_ctx->wait_event,
-			    admin_queue->completion_timeout);
-
-	/* In case the command wasn't completed find out the root cause.
-	 * There might be 2 kinds of errors
-	 * 1) No completion (timeout reached)
-	 * 2) There is completion but the device didn't get any msi-x interrupt.
-	 */
-	if (unlikely(comp_ctx->status == ENA_CMD_SUBMITTED)) {
-		ENA_SPINLOCK_LOCK(admin_queue->q_lock, flags);
-		ena_com_handle_admin_completion(admin_queue);
-		admin_queue->stats.no_completion++;
-		ENA_SPINLOCK_UNLOCK(admin_queue->q_lock, flags);
-
-		if (comp_ctx->status == ENA_CMD_COMPLETED) {
-			admin_queue->is_missing_admin_interrupt = true;
-			ena_trc_err(admin_queue->ena_dev,
-				    "The ena device sent a completion but the driver didn't receive a MSI-X interrupt (cmd %d), autopolling mode is %s\n",
-				    comp_ctx->cmd_opcode, admin_queue->auto_polling ? "ON" : "OFF");
-			/* Check if fallback to polling is enabled */
-			if (admin_queue->auto_polling)
-				admin_queue->polling = true;
-		} else {
-			ena_trc_err(admin_queue->ena_dev,
-				    "The ena device didn't send a completion for the admin cmd %d status %d\n",
-				    comp_ctx->cmd_opcode, comp_ctx->status);
-		}
-		/* Check if shifted to polling mode.
-		 * This will happen if there is a completion without an interrupt
-		 * and autopolling mode is enabled. Continuing normal execution in such case
-		 */
-		if (!admin_queue->polling) {
-			admin_queue->running_state = false;
-			ret = ENA_COM_TIMER_EXPIRED;
-			goto err;
-		}
-	} else if (unlikely(comp_ctx->status == ENA_CMD_ABORTED)) {
-		ena_trc_err(admin_queue->ena_dev, "Command was aborted\n");
-		ENA_SPINLOCK_LOCK(admin_queue->q_lock, flags);
-		admin_queue->stats.aborted_cmd++;
-		ENA_SPINLOCK_UNLOCK(admin_queue->q_lock, flags);
-		ret = ENA_COM_NO_DEVICE;
-		goto err;
-	}
-	ret = ena_com_admin_status_to_errno(admin_queue, comp_ctx);
-err:
-	comp_ctxt_release(admin_queue, comp_ctx);
-	return ret;
-}
-
 /* This method read the hardware device register through posting writes
  * and waiting for response
  * On timeout the function will return ENA_MMIO_READ_TIMEOUT
@@ -903,29 +987,10 @@ static u32 ena_com_reg_bar_read32(struct ena_com_dev *ena_dev, u16 offset)
 	return ret;
 }
 
-/* There are two types to wait for completion.
- * Polling mode - wait until the completion is available.
- * Async mode - wait on wait queue until the completion is ready
- * (or the timeout expired).
- * It is expected that the IRQ called ena_com_handle_admin_completion
- * to mark the completions.
- */
-static int ena_com_wait_and_process_admin_cq(struct ena_comp_ctx *comp_ctx,
-					     struct ena_com_admin_queue *admin_queue)
-{
-	if (admin_queue->polling)
-		return ena_com_wait_and_process_admin_cq_polling(comp_ctx,
-								 admin_queue);
-
-	return ena_com_wait_and_process_admin_cq_interrupts(comp_ctx,
-							    admin_queue);
-}
-
 static int ena_com_destroy_io_sq(struct ena_com_dev *ena_dev,
 				 struct ena_com_io_sq *io_sq)
 {
 	struct ena_com_admin_queue *admin_queue = &ena_dev->admin_queue;
-	struct ena_admin_acq_destroy_sq_resp_desc destroy_resp;
 	struct ena_admin_aq_destroy_sq_cmd destroy_cmd;
 	u8 direction;
 	int ret;
@@ -945,11 +1010,9 @@ static int ena_com_destroy_io_sq(struct ena_com_dev *ena_dev,
 	destroy_cmd.sq.sq_idx = io_sq->idx;
 	destroy_cmd.aq_common_descriptor.opcode = ENA_ADMIN_DESTROY_SQ;
 
-	ret = ena_com_execute_admin_command(admin_queue,
-					    (struct ena_admin_aq_entry *)&destroy_cmd,
-					    sizeof(destroy_cmd),
-					    (struct ena_admin_acq_entry *)&destroy_resp,
-					    sizeof(destroy_resp));
+	ret = ena_com_execute_admin_command_no_resp(admin_queue,
+						    (struct ena_admin_aq_entry *)&destroy_cmd,
+						    sizeof(destroy_cmd));
 
 	if (unlikely(ret && (ret != ENA_COM_NO_DEVICE)))
 		ena_trc_err(ena_dev, "Failed to destroy io sq error: %d\n", ret);
@@ -1152,7 +1215,6 @@ int ena_com_set_hw_timestamping_configuration(struct ena_com_dev *ena_dev,
 					      u8 tx_enable,
 					      u8 rx_enable)
 {
-	struct ena_admin_set_feat_resp resp;
 	struct ena_admin_set_feat_cmd cmd;
 	int ret;
 
@@ -1170,11 +1232,9 @@ int ena_com_set_hw_timestamping_configuration(struct ena_com_dev *ena_dev,
 	cmd.u.hw_ts.rx = rx_enable ? ENA_ADMIN_HW_TIMESTAMP_RX_SUPPORT_ALL :
 				     ENA_ADMIN_HW_TIMESTAMP_RX_SUPPORT_NONE;
 
-	ret = ena_com_execute_admin_command(&ena_dev->admin_queue,
-					    (struct ena_admin_aq_entry *)&cmd,
-					    sizeof(cmd),
-					    (struct ena_admin_acq_entry *)&resp,
-					    sizeof(resp));
+	ret = ena_com_execute_admin_command_no_resp(&ena_dev->admin_queue,
+						    (struct ena_admin_aq_entry *)&cmd,
+						    sizeof(cmd));
 	if (unlikely(ret)) {
 		ena_trc_err(ena_dev,
 			    "Failed to set HW timestamping configuration, error: %d\n",
@@ -1469,37 +1529,6 @@ static void ena_com_update_intr_delay_resolution(struct ena_com_dev *ena_dev,
 /*******************************      API       ******************************/
 /*****************************************************************************/
 
-int ena_com_execute_admin_command(struct ena_com_admin_queue *admin_queue,
-				  struct ena_admin_aq_entry *cmd,
-				  size_t cmd_size,
-				  struct ena_admin_acq_entry *comp,
-				  size_t comp_size)
-{
-	struct ena_comp_ctx *comp_ctx;
-	int ret;
-
-	comp_ctx = ena_com_submit_admin_cmd(admin_queue, cmd, cmd_size,
-					    comp, comp_size);
-	if (IS_ERR(comp_ctx)) {
-		ret = PTR_ERR(comp_ctx);
-		if (ret != ENA_COM_NO_DEVICE)
-			ena_trc_err(admin_queue->ena_dev,
-				    "Failed to submit command [%d]\n",
-				    ret);
-
-		return ret;
-	}
-
-	ret = ena_com_wait_and_process_admin_cq(comp_ctx, admin_queue);
-	if (unlikely(ret)) {
-		if (admin_queue->running_state)
-			ena_trc_err(admin_queue->ena_dev,
-				    "Failed to process command [%d]\n",
-				    ret);
-	}
-	return ret;
-}
-
 int ena_com_create_io_cq(struct ena_com_dev *ena_dev,
 			 struct ena_com_io_cq *io_cq)
 {
@@ -1608,7 +1637,6 @@ int ena_com_destroy_io_cq(struct ena_com_dev *ena_dev,
 			  struct ena_com_io_cq *io_cq)
 {
 	struct ena_com_admin_queue *admin_queue = &ena_dev->admin_queue;
-	struct ena_admin_acq_destroy_cq_resp_desc destroy_resp;
 	struct ena_admin_aq_destroy_cq_cmd destroy_cmd;
 	int ret;
 
@@ -1617,11 +1645,9 @@ int ena_com_destroy_io_cq(struct ena_com_dev *ena_dev,
 	destroy_cmd.cq_idx = io_cq->idx;
 	destroy_cmd.aq_common_descriptor.opcode = ENA_ADMIN_DESTROY_CQ;
 
-	ret = ena_com_execute_admin_command(admin_queue,
-					    (struct ena_admin_aq_entry *)&destroy_cmd,
-					    sizeof(destroy_cmd),
-					    (struct ena_admin_acq_entry *)&destroy_resp,
-					    sizeof(destroy_resp));
+	ret = ena_com_execute_admin_command_no_resp(admin_queue,
+						    (struct ena_admin_aq_entry *)&destroy_cmd,
+						    sizeof(destroy_cmd));
 
 	if (unlikely(ret && (ret != ENA_COM_NO_DEVICE)))
 		ena_trc_err(ena_dev, "Failed to destroy IO CQ. error: %d\n", ret);
@@ -1660,7 +1686,6 @@ int ena_com_set_aenq_config(struct ena_com_dev *ena_dev, u32 groups_flag)
 {
 	struct ena_com_admin_queue *admin_queue;
 	struct ena_admin_get_feat_resp get_resp;
-	struct ena_admin_set_feat_resp resp;
 	struct ena_admin_set_feat_cmd cmd;
 	int ret;
 
@@ -1685,11 +1710,9 @@ int ena_com_set_aenq_config(struct ena_com_dev *ena_dev, u32 groups_flag)
 	cmd.feat_common.feature_id = ENA_ADMIN_AENQ_CONFIG;
 	cmd.u.aenq.enabled_groups = groups_flag;
 
-	ret = ena_com_execute_admin_command(admin_queue,
-					    (struct ena_admin_aq_entry *)&cmd,
-					    sizeof(cmd),
-					    (struct ena_admin_acq_entry *)&resp,
-					    sizeof(resp));
+	ret = ena_com_execute_admin_command_no_resp(admin_queue,
+						    (struct ena_admin_aq_entry *)&cmd,
+						    sizeof(cmd));
 
 	if (unlikely(ret))
 		ena_trc_err(ena_dev, "Failed to config AENQ ret: %d\n", ret);
@@ -1879,7 +1902,6 @@ int ena_com_phc_config(struct ena_com_dev *ena_dev)
 {
 	struct ena_com_phc_info *phc = &ena_dev->phc;
 	struct ena_admin_get_feat_resp get_feat_resp;
-	struct ena_admin_set_feat_resp set_feat_resp;
 	struct ena_admin_set_feat_cmd set_feat_cmd;
 	int ret = 0;
 
@@ -1934,11 +1956,9 @@ int ena_com_phc_config(struct ena_com_dev *ena_dev)
 	}
 
 	/* Send PHC feature command to the device */
-	ret = ena_com_execute_admin_command(&ena_dev->admin_queue,
-					    (struct ena_admin_aq_entry *)&set_feat_cmd,
-					    sizeof(set_feat_cmd),
-					    (struct ena_admin_acq_entry *)&set_feat_resp,
-					    sizeof(set_feat_resp));
+	ret = ena_com_execute_admin_command_no_resp(&ena_dev->admin_queue,
+						    (struct ena_admin_aq_entry *)&set_feat_cmd,
+						    sizeof(set_feat_cmd));
 
 	if (unlikely(ret)) {
 		ena_trc_err(ena_dev, "Failed to enable PHC, error: %d\n", ret);
@@ -2822,7 +2842,6 @@ int ena_com_get_customer_metrics(struct ena_com_dev *ena_dev, char *buffer, u32
 int ena_com_set_dev_mtu(struct ena_com_dev *ena_dev, u32 mtu)
 {
 	struct ena_com_admin_queue *admin_queue;
-	struct ena_admin_set_feat_resp resp;
 	struct ena_admin_set_feat_cmd cmd;
 	int ret;
 
@@ -2839,11 +2858,9 @@ int ena_com_set_dev_mtu(struct ena_com_dev *ena_dev, u32 mtu)
 	cmd.feat_common.feature_id = ENA_ADMIN_MTU;
 	cmd.u.mtu.mtu = mtu;
 
-	ret = ena_com_execute_admin_command(admin_queue,
-					    (struct ena_admin_aq_entry *)&cmd,
-					    sizeof(cmd),
-					    (struct ena_admin_acq_entry *)&resp,
-					    sizeof(resp));
+	ret = ena_com_execute_admin_command_no_resp(admin_queue,
+						    (struct ena_admin_aq_entry *)&cmd,
+						    sizeof(cmd));
 
 	if (unlikely(ret))
 		ena_trc_err(ena_dev, "Failed to set mtu %d. error: %d\n", mtu, ret);
@@ -2859,7 +2876,6 @@ int ena_com_set_hash_function(struct ena_com_dev *ena_dev)
 {
 	struct ena_com_admin_queue *admin_queue = &ena_dev->admin_queue;
 	struct ena_admin_get_feat_resp get_resp;
-	struct ena_admin_set_feat_resp resp;
 	struct ena_rss *rss = &ena_dev->rss;
 	struct ena_admin_set_feat_cmd cmd;
 	int ret;
@@ -2902,11 +2918,9 @@ int ena_com_set_hash_function(struct ena_com_dev *ena_dev)
 
 	cmd.control_buffer.length = sizeof(*rss->hash_key);
 
-	ret = ena_com_execute_admin_command(admin_queue,
-					    (struct ena_admin_aq_entry *)&cmd,
-					    sizeof(cmd),
-					    (struct ena_admin_acq_entry *)&resp,
-					    sizeof(resp));
+	ret = ena_com_execute_admin_command_no_resp(admin_queue,
+						    (struct ena_admin_aq_entry *)&cmd,
+						    sizeof(cmd));
 	if (unlikely(ret)) {
 		ena_trc_err(ena_dev, "Failed to set hash function %d. error: %d\n",
 			    rss->hash_func, ret);
@@ -3031,7 +3045,6 @@ int ena_com_set_hash_ctrl(struct ena_com_dev *ena_dev)
 	struct ena_com_admin_queue *admin_queue = &ena_dev->admin_queue;
 	struct ena_admin_feature_rss_hash_control *hash_ctrl;
 	struct ena_rss *rss = &ena_dev->rss;
-	struct ena_admin_set_feat_resp resp;
 	struct ena_admin_set_feat_cmd cmd;
 	int ret;
 
@@ -3063,11 +3076,9 @@ int ena_com_set_hash_ctrl(struct ena_com_dev *ena_dev)
 	}
 	cmd.control_buffer.length = sizeof(*hash_ctrl);
 
-	ret = ena_com_execute_admin_command(admin_queue,
-					    (struct ena_admin_aq_entry *)&cmd,
-					    sizeof(cmd),
-					    (struct ena_admin_acq_entry *)&resp,
-					    sizeof(resp));
+	ret = ena_com_execute_admin_command_no_resp(admin_queue,
+						    (struct ena_admin_aq_entry *)&cmd,
+						    sizeof(cmd));
 	if (unlikely(ret))
 		ena_trc_err(ena_dev, "Failed to set hash input. error: %d\n", ret);
 
@@ -3195,7 +3206,6 @@ int ena_com_indirect_table_set(struct ena_com_dev *ena_dev)
 {
 	struct ena_com_admin_queue *admin_queue = &ena_dev->admin_queue;
 	struct ena_rss *rss = &ena_dev->rss;
-	struct ena_admin_set_feat_resp resp;
 	struct ena_admin_set_feat_cmd cmd;
 	int ret;
 
@@ -3232,11 +3242,9 @@ int ena_com_indirect_table_set(struct ena_com_dev *ena_dev)
 	cmd.control_buffer.length = (1ULL << rss->tbl_log_size) *
 		sizeof(struct ena_admin_rss_ind_table_entry);
 
-	ret = ena_com_execute_admin_command(admin_queue,
-					    (struct ena_admin_aq_entry *)&cmd,
-					    sizeof(cmd),
-					    (struct ena_admin_acq_entry *)&resp,
-					    sizeof(resp));
+	ret = ena_com_execute_admin_command_no_resp(admin_queue,
+						    (struct ena_admin_aq_entry *)&cmd,
+						    sizeof(cmd));
 
 	if (unlikely(ret))
 		ena_trc_err(ena_dev, "Failed to set indirect table. error: %d\n", ret);
@@ -3420,7 +3428,6 @@ int ena_com_set_host_attributes(struct ena_com_dev *ena_dev)
 {
 	struct ena_host_attribute *host_attr = &ena_dev->host_attr;
 	struct ena_com_admin_queue *admin_queue;
-	struct ena_admin_set_feat_resp resp;
 	struct ena_admin_set_feat_cmd cmd;
 	int ret;
 
@@ -3452,11 +3459,9 @@ int ena_com_set_host_attributes(struct ena_com_dev *ena_dev)
 
 	cmd.u.host_attr.debug_area_size = host_attr->debug_area_size;
 
-	ret = ena_com_execute_admin_command(admin_queue,
-					    (struct ena_admin_aq_entry *)&cmd,
-					    sizeof(cmd),
-					    (struct ena_admin_acq_entry *)&resp,
-					    sizeof(resp));
+	ret = ena_com_execute_admin_command_no_resp(admin_queue,
+						    (struct ena_admin_aq_entry *)&cmd,
+						    sizeof(cmd));
 
 	if (unlikely(ret))
 		ena_trc_err(ena_dev, "Failed to set host attributes: %d\n", ret);
@@ -3579,7 +3584,6 @@ int ena_com_config_dev_mode(struct ena_com_dev *ena_dev,
 
 int ena_com_set_frag_bypass(struct ena_com_dev *ena_dev, bool enable)
 {
-	struct ena_admin_set_feat_resp set_feat_resp;
 	struct ena_com_admin_queue *admin_queue;
 	struct ena_admin_set_feat_cmd cmd;
 	int ret;
@@ -3599,11 +3603,9 @@ int ena_com_set_frag_bypass(struct ena_com_dev *ena_dev, bool enable)
 	cmd.feat_common.feature_version = ENA_ADMIN_FRAG_BYPASS_FEATURE_VERSION_0;
 	cmd.u.frag_bypass.enable = (u8)enable;
 
-	ret = ena_com_execute_admin_command(admin_queue,
-					    (struct ena_admin_aq_entry *)&cmd,
-					    sizeof(cmd),
-					    (struct ena_admin_acq_entry *)&set_feat_resp,
-					    sizeof(set_feat_resp));
+	ret = ena_com_execute_admin_command_no_resp(admin_queue,
+						    (struct ena_admin_aq_entry *)&cmd,
+						    sizeof(cmd));
 
 	if (unlikely(ret))
 		ena_trc_err(ena_dev, "Failed to enable frag bypass. error: %d\n", ret);
-- 
2.17.1

