Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5ED9CD4F26
	for <dpdk-dev@archiver.kernel.org>; Tue, 12 May 2026 07:56:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 625864066F;
	Tue, 12 May 2026 09:55:55 +0200 (CEST)
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com
 [209.85.219.74]) by mails.dpdk.org (Postfix) with ESMTP id D4CAD40278
 for <dev@dpdk.org>; Tue, 12 May 2026 00:23:45 +0200 (CEST)
Received: by mail-qv1-f74.google.com with SMTP id
 6a1803df08f44-8b3fe2f190bso131311846d6.2
 for <dev@dpdk.org>; Mon, 11 May 2026 15:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1778538225; x=1779143025; darn=dpdk.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=xlJCOaK7ruzLyv/YJH53EUXEmD2vmNyvovGyfpEKMt4=;
 b=ni8y0lUvSXb/1eiJVjnhkrLXIsrK7CcjrsfEFezg+cEnSmvIfEPbyCP/mk54hdgDiz
 64gTZz+7JwuJUeRWgcFbAHrfdfIW6XIBW9i2/W1FtAPWTOPe65iX8wqlfq57OjN8xGDr
 BhaqUArWXbFE3MnWJg4vUTmNGgISi8YQvIeyy3c8tlsLPviJjquUl3RAQ8pUNWOCLV2P
 oYts9R4AIyboa8Kxgh6r0Lo/cDrySTwCK3wjxUHfZJGjukqE68BgELJvNxvYFS3gOAX/
 TlJH1fz0JpN/ucrfGUHn1+DWm3E/0ncIgOEF9vgMyU6FInUck+71L6ZMCRmb/W7pe4OS
 pwdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778538225; x=1779143025;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xlJCOaK7ruzLyv/YJH53EUXEmD2vmNyvovGyfpEKMt4=;
 b=h3VS+2gL/FNpNG6SsUNNiWaq9JHq/dvNnLiQ5aBnqQArlKfH8xzi0QZqpFrD4mbRxs
 Ck7kxkBx1Rw4EK1PAiUvLIuFYuOuxJJoeb+j3gQOi3FiAKgokrU0XUBk/4hIIJoxMLEb
 sRjD7cCQfgqHIhKFAahJYh4t0CnfpkEEnJVLPWWFDtvXnwuIYE0QI+dXYeGiJvHPhyC4
 wzIhUsX1rhEuoQznQn9kXr+zY68wf3UI/QeNU8rFg4By30jLl72djjKT/P4bLCTLDF+b
 feKQdYOhqpVYVhX4QyU6QbW6c3gVhnaauZQ+3fazpJX4VwpPhSj20h00HmdLthCBZcz9
 FgYw==
X-Gm-Message-State: AOJu0Yzlrcu67E9tSNLGPi+Z7PP0qcwVTrvmLoY0fJkg31tfT12L7b21
 ttJx+IAcGQZFdNecLYt6ASt+krZS0hTClJ2fyzLK9mDTIS16oPX0aCkSj4hPdfrrxPBWkFEg3QJ
 0Z0sQfA==
X-Received: from qvbiu5.prod.google.com ([2002:ad4:5cc5:0:b0:8ad:a08f:e000])
 (user=blasko job=prod-delivery.src-stubby-dispatcher) by
 2002:a0c:e006:0:b0:89a:1575:e1d3
 with SMTP id 6a1803df08f44-8c6616ce1c1mr9499386d6.12.1778538224986; Mon, 11
 May 2026 15:23:44 -0700 (PDT)
Date: Mon, 11 May 2026 22:22:55 +0000
In-Reply-To: <20260511222301.862880-1-blasko@google.com>
Mime-Version: 1.0
References: <20260511222301.862880-1-blasko@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260511222301.862880-2-blasko@google.com>
Subject: [PATCH 1/6] net/gve: add thread safety to admin queue
From: mark-blasko <blasko@google.com>
To: jeroendb@google.com, joshwash@google.com
Cc: dev@dpdk.org, jtranoleary@google.com, Mark Blasko <blasko@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Tue, 12 May 2026 09:55:49 +0200
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

From: Mark Blasko <blasko@google.com>

Introduce a pthread_mutex to protect the admin queue operations.
Locking was added around gve_adminq_execute_cmd and the batch
queue creation/destruction functions.

Signed-off-by: Mark Blasko <blasko@google.com>
Reviewed-by: Joshua Washington <joshwash@google.com>
Reviewed-by: Jasper Tran O'Leary <jtranoleary@google.com>
---
 drivers/net/gve/base/gve_adminq.c | 68 +++++++++++++++++++++++++------
 drivers/net/gve/gve_ethdev.h      |  1 +
 2 files changed, 56 insertions(+), 13 deletions(-)

diff --git a/drivers/net/gve/base/gve_adminq.c b/drivers/net/gve/base/gve_adminq.c
index 9c5316fb00..28661fb6cd 100644
--- a/drivers/net/gve/base/gve_adminq.c
+++ b/drivers/net/gve/base/gve_adminq.c
@@ -216,6 +216,7 @@ gve_process_device_options(struct gve_priv *priv,
 
 int gve_adminq_alloc(struct gve_priv *priv)
 {
+	pthread_mutexattr_t mutexattr;
 	uint8_t pci_rev_id;
 
 	priv->adminq = gve_alloc_dma_mem(&priv->adminq_dma_mem, PAGE_SIZE);
@@ -241,6 +242,12 @@ int gve_adminq_alloc(struct gve_priv *priv)
 	priv->adminq_get_ptype_map_cnt = 0;
 	priv->adminq_cfg_flow_rule_cnt = 0;
 
+	pthread_mutexattr_init(&mutexattr);
+	pthread_mutexattr_setpshared(&mutexattr, PTHREAD_PROCESS_SHARED);
+	pthread_mutexattr_setrobust(&mutexattr, PTHREAD_MUTEX_ROBUST);
+	pthread_mutex_init(&priv->adminq_lock, &mutexattr);
+	pthread_mutexattr_destroy(&mutexattr);
+
 	/* Setup Admin queue with the device */
 	rte_pci_read_config(priv->pci_dev, &pci_rev_id, sizeof(pci_rev_id),
 			    RTE_PCI_REVISION_ID);
@@ -304,6 +311,7 @@ void gve_adminq_free(struct gve_priv *priv)
 		return;
 	gve_adminq_release(priv);
 	gve_free_dma_mem(&priv->adminq_dma_mem);
+	pthread_mutex_destroy(&priv->adminq_lock);
 	gve_clear_admin_queue_ok(priv);
 }
 
@@ -418,7 +426,10 @@ static int gve_adminq_issue_cmd(struct gve_priv *priv,
 	    (tail & priv->adminq_mask)) {
 		int err;
 
-		/* Flush existing commands to make room. */
+		/* Flush existing commands to make room.
+		 * Note: This kicks the doorbell for all staged commands.
+		 * Any failure here means we failed after attempting to kick.
+		 */
 		err = gve_adminq_kick_and_wait(priv);
 		if (err)
 			return err;
@@ -509,17 +520,24 @@ static int gve_adminq_execute_cmd(struct gve_priv *priv,
 	u32 tail, head;
 	int err;
 
+	pthread_mutex_lock(&priv->adminq_lock);
 	tail = ioread32be(&priv->reg_bar0->adminq_event_counter);
 	head = priv->adminq_prod_cnt;
-	if (tail != head)
+	if (tail != head) {
 		/* This is not a valid path */
-		return -EINVAL;
+		err = -EINVAL;
+		goto unlock_and_return;
+	}
 
 	err = gve_adminq_issue_cmd(priv, cmd_orig);
 	if (err)
-		return err;
+		goto unlock_and_return;
 
-	return gve_adminq_kick_and_wait(priv);
+	err = gve_adminq_kick_and_wait(priv);
+
+unlock_and_return:
+	pthread_mutex_unlock(&priv->adminq_lock);
+	return err;
 }
 
 static int gve_adminq_execute_extended_cmd(struct gve_priv *priv, u32 opcode,
@@ -693,13 +711,19 @@ int gve_adminq_create_tx_queues(struct gve_priv *priv, u32 num_queues)
 	int err;
 	u32 i;
 
+	pthread_mutex_lock(&priv->adminq_lock);
+
 	for (i = 0; i < num_queues; i++) {
 		err = gve_adminq_create_tx_queue(priv, i);
 		if (err)
-			return err;
+			goto unlock_and_return;
 	}
 
-	return gve_adminq_kick_and_wait(priv);
+	err = gve_adminq_kick_and_wait(priv);
+
+unlock_and_return:
+	pthread_mutex_unlock(&priv->adminq_lock);
+	return err;
 }
 
 static int gve_adminq_create_rx_queue(struct gve_priv *priv, u32 queue_index)
@@ -747,13 +771,19 @@ int gve_adminq_create_rx_queues(struct gve_priv *priv, u32 num_queues)
 	int err;
 	u32 i;
 
+	pthread_mutex_lock(&priv->adminq_lock);
+
 	for (i = 0; i < num_queues; i++) {
 		err = gve_adminq_create_rx_queue(priv, i);
 		if (err)
-			return err;
+			goto unlock_and_return;
 	}
 
-	return gve_adminq_kick_and_wait(priv);
+	err = gve_adminq_kick_and_wait(priv);
+
+unlock_and_return:
+	pthread_mutex_unlock(&priv->adminq_lock);
+	return err;
 }
 
 static int gve_adminq_destroy_tx_queue(struct gve_priv *priv, u32 queue_index)
@@ -779,13 +809,19 @@ int gve_adminq_destroy_tx_queues(struct gve_priv *priv, u32 num_queues)
 	int err;
 	u32 i;
 
+	pthread_mutex_lock(&priv->adminq_lock);
+
 	for (i = 0; i < num_queues; i++) {
 		err = gve_adminq_destroy_tx_queue(priv, i);
 		if (err)
-			return err;
+			goto unlock_and_return;
 	}
 
-	return gve_adminq_kick_and_wait(priv);
+	err = gve_adminq_kick_and_wait(priv);
+
+unlock_and_return:
+	pthread_mutex_unlock(&priv->adminq_lock);
+	return err;
 }
 
 static int gve_adminq_destroy_rx_queue(struct gve_priv *priv, u32 queue_index)
@@ -811,13 +847,19 @@ int gve_adminq_destroy_rx_queues(struct gve_priv *priv, u32 num_queues)
 	int err;
 	u32 i;
 
+	pthread_mutex_lock(&priv->adminq_lock);
+
 	for (i = 0; i < num_queues; i++) {
 		err = gve_adminq_destroy_rx_queue(priv, i);
 		if (err)
-			return err;
+			goto unlock_and_return;
 	}
 
-	return gve_adminq_kick_and_wait(priv);
+	err = gve_adminq_kick_and_wait(priv);
+
+unlock_and_return:
+	pthread_mutex_unlock(&priv->adminq_lock);
+	return err;
 }
 
 static int gve_set_desc_cnt(struct gve_priv *priv,
diff --git a/drivers/net/gve/gve_ethdev.h b/drivers/net/gve/gve_ethdev.h
index 0577f03974..524e48e723 100644
--- a/drivers/net/gve/gve_ethdev.h
+++ b/drivers/net/gve/gve_ethdev.h
@@ -339,6 +339,7 @@ struct gve_priv {
 	struct gve_tx_queue **txqs;
 	struct gve_rx_queue **rxqs;
 
+	pthread_mutex_t adminq_lock; /* Protects AdminQ command execution */
 	uint32_t stats_report_len;
 	const struct rte_memzone *stats_report_mem;
 	uint16_t stats_start_idx; /* start index of array of stats written by NIC */
-- 
2.54.0.563.g4f69b47b94-goog

