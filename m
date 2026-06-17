Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C61D1CD98D2
	for <dpdk-dev@archiver.kernel.org>; Wed, 17 Jun 2026 00:07:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4687B40679;
	Wed, 17 Jun 2026 02:07:21 +0200 (CEST)
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com
 [209.85.222.201])
 by mails.dpdk.org (Postfix) with ESMTP id 53B2740431
 for <dev@dpdk.org>; Wed, 17 Jun 2026 02:07:18 +0200 (CEST)
Received: by mail-qk1-f201.google.com with SMTP id
 af79cd13be357-91574ad681eso779799085a.0
 for <dev@dpdk.org>; Tue, 16 Jun 2026 17:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1781654837; x=1782259637; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
 :reply-to; bh=8B4ls13leG82YuYJHc4n6I7BEd+vNx0fEPVU1ngrt1s=;
 b=XlaWk79g38gicZuCDkvwN5aHB8WXMPTumrvZlZlNGQUqDQYIglPfqH7YAEdMwshBDG
 NSbvWXZwsos6IPlaNIKbnn3hyCVbl9US52Xl3RkE1tRFb7J3szF9xkKHmVjeouzC/xvR
 hjIxevbG97sjb3Zc30q5eYz2eEGSealqQLypkQ6b3wuLXXhtxuHgkTHRu8xjkBMQv8+E
 ATfGWjACRB+tYfgTNxADiBGGgdq/9lqBE4KF2BbgWtvXvUK86sS/mntsc0tWocYx7M83
 RCM6FOI6KKS0UMilnoK56CpBg29ZETwd3655TgecgO3qW5xMqag7EraKZvcTMbvTY7cc
 BL7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781654837; x=1782259637;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=8B4ls13leG82YuYJHc4n6I7BEd+vNx0fEPVU1ngrt1s=;
 b=qGq4R75C3f9TsYGKXfw6bVxL0tO9DiD0oTVUnxj8/F9YIYypmLTiFu+3O4oi05G44B
 8pbCuMRrXoY7+ev3IIrLblM0yWTo95iziuaZfPywDWAwjw2r+OBL0s5ResBx7eRXp+aL
 Vuhny+sCFSEVmRsF9aucntwzFL6+6R9ZgMpa/7WF4TZaD3HIKuvLKljLZ9KaLWn0oaGg
 Sc4xPEPMVtUlOXklJSIU7PWYB5krFA0eOKVLlJX2dl0Pmo7RQ/g/FJNLOl0dAFVLpMoZ
 Ob1DTOBCNCmEsSj27RKcQfLRw00DFB+u6RBlyCgEmL9t+2kgP6GmqgHjvTf2ZJkRmjVn
 yR3g==
X-Gm-Message-State: AOJu0YyBYJbR155IoSinUkZScfL7xlt9Zwivsz5UzpmHlDFmgOVBrGF5
 0I78rngX9UbSKeBTKtV4QRRGYDSssNRxuzd79vvNLYMtG5J6Up+FE8hvUuIfqg5L/N6cJE/u6uY
 UosMpjA==
X-Received: from qklv5.prod.google.com ([2002:a05:620a:f05:b0:913:3916:1c72])
 (user=blasko job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:171f:b0:915:a111:86ae
 with SMTP id af79cd13be357-91d8aadfca5mr353469385a.35.1781654837166; Tue, 16
 Jun 2026 17:07:17 -0700 (PDT)
Date: Wed, 17 Jun 2026 00:07:05 +0000
In-Reply-To: <20260617000712.2195506-1-blasko@google.com>
Mime-Version: 1.0
References: <20260613042300.3760470-1-blasko@google.com>
 <20260617000712.2195506-1-blasko@google.com>
X-Mailer: git-send-email 2.54.0.1189.g8c84645362-goog
Message-ID: <20260617000712.2195506-2-blasko@google.com>
Subject: [PATCH v5 1/6] net/gve: add thread safety to admin queue
From: Mark Blasko <blasko@google.com>
To: stephen@networkplumber.org
Cc: dev@dpdk.org, joshwash@google.com, jtranoleary@google.com, 
 blasko@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Introduce a pthread_mutex to protect the admin queue operations.
Locking was added around gve_adminq_execute_cmd and the batch
queue creation/destruction functions.

Signed-off-by: Mark Blasko <blasko@google.com>
Reviewed-by: Joshua Washington <joshwash@google.com>
Reviewed-by: Jasper Tran O'Leary <jtranoleary@google.com>
---
v2:
    - Dropped ROBUST mutex attribute.
---
 .mailmap                          |  1 +
 drivers/net/gve/base/gve_adminq.c | 67 +++++++++++++++++++++++++------
 drivers/net/gve/gve_ethdev.h      |  1 +
 3 files changed, 56 insertions(+), 13 deletions(-)

diff --git a/.mailmap b/.mailmap
index e052b85213..1b10cfca35 100644
--- a/.mailmap
+++ b/.mailmap
@@ -1016,6 +1016,7 @@ Mario Carrillo <mario.alfredo.c.arevalo@intel.com>
 M=C3=A1rio Kuka <kuka@cesnet.cz>
 Mariusz Drost <mariuszx.drost@intel.com>
 Mark Asselstine <mark.asselstine@windriver.com>
+Mark Blasko <blasko@google.com>
 Mark Bloch <mbloch@nvidia.com> <markb@mellanox.com>
 Mark Gillott <mgillott@vyatta.att-mail.com>
 Mark Kavanagh <mark.b.kavanagh@intel.com>
diff --git a/drivers/net/gve/base/gve_adminq.c b/drivers/net/gve/base/gve_a=
dminq.c
index 9c5316fb00..743ab8e7ae 100644
--- a/drivers/net/gve/base/gve_adminq.c
+++ b/drivers/net/gve/base/gve_adminq.c
@@ -216,6 +216,7 @@ gve_process_device_options(struct gve_priv *priv,
=20
 int gve_adminq_alloc(struct gve_priv *priv)
 {
+	pthread_mutexattr_t mutexattr;
 	uint8_t pci_rev_id;
=20
 	priv->adminq =3D gve_alloc_dma_mem(&priv->adminq_dma_mem, PAGE_SIZE);
@@ -241,6 +242,11 @@ int gve_adminq_alloc(struct gve_priv *priv)
 	priv->adminq_get_ptype_map_cnt =3D 0;
 	priv->adminq_cfg_flow_rule_cnt =3D 0;
=20
+	pthread_mutexattr_init(&mutexattr);
+	pthread_mutexattr_setpshared(&mutexattr, PTHREAD_PROCESS_SHARED);
+	pthread_mutex_init(&priv->adminq_lock, &mutexattr);
+	pthread_mutexattr_destroy(&mutexattr);
+
 	/* Setup Admin queue with the device */
 	rte_pci_read_config(priv->pci_dev, &pci_rev_id, sizeof(pci_rev_id),
 			    RTE_PCI_REVISION_ID);
@@ -304,6 +310,7 @@ void gve_adminq_free(struct gve_priv *priv)
 		return;
 	gve_adminq_release(priv);
 	gve_free_dma_mem(&priv->adminq_dma_mem);
+	pthread_mutex_destroy(&priv->adminq_lock);
 	gve_clear_admin_queue_ok(priv);
 }
=20
@@ -418,7 +425,10 @@ static int gve_adminq_issue_cmd(struct gve_priv *priv,
 	    (tail & priv->adminq_mask)) {
 		int err;
=20
-		/* Flush existing commands to make room. */
+		/* Flush existing commands to make room.
+		 * Note: This kicks the doorbell for all staged commands.
+		 * Any failure here means we failed after attempting to kick.
+		 */
 		err =3D gve_adminq_kick_and_wait(priv);
 		if (err)
 			return err;
@@ -509,17 +519,24 @@ static int gve_adminq_execute_cmd(struct gve_priv *pr=
iv,
 	u32 tail, head;
 	int err;
=20
+	pthread_mutex_lock(&priv->adminq_lock);
 	tail =3D ioread32be(&priv->reg_bar0->adminq_event_counter);
 	head =3D priv->adminq_prod_cnt;
-	if (tail !=3D head)
+	if (tail !=3D head) {
 		/* This is not a valid path */
-		return -EINVAL;
+		err =3D -EINVAL;
+		goto unlock_and_return;
+	}
=20
 	err =3D gve_adminq_issue_cmd(priv, cmd_orig);
 	if (err)
-		return err;
+		goto unlock_and_return;
=20
-	return gve_adminq_kick_and_wait(priv);
+	err =3D gve_adminq_kick_and_wait(priv);
+
+unlock_and_return:
+	pthread_mutex_unlock(&priv->adminq_lock);
+	return err;
 }
=20
 static int gve_adminq_execute_extended_cmd(struct gve_priv *priv, u32 opco=
de,
@@ -693,13 +710,19 @@ int gve_adminq_create_tx_queues(struct gve_priv *priv=
, u32 num_queues)
 	int err;
 	u32 i;
=20
+	pthread_mutex_lock(&priv->adminq_lock);
+
 	for (i =3D 0; i < num_queues; i++) {
 		err =3D gve_adminq_create_tx_queue(priv, i);
 		if (err)
-			return err;
+			goto unlock_and_return;
 	}
=20
-	return gve_adminq_kick_and_wait(priv);
+	err =3D gve_adminq_kick_and_wait(priv);
+
+unlock_and_return:
+	pthread_mutex_unlock(&priv->adminq_lock);
+	return err;
 }
=20
 static int gve_adminq_create_rx_queue(struct gve_priv *priv, u32 queue_ind=
ex)
@@ -747,13 +770,19 @@ int gve_adminq_create_rx_queues(struct gve_priv *priv=
, u32 num_queues)
 	int err;
 	u32 i;
=20
+	pthread_mutex_lock(&priv->adminq_lock);
+
 	for (i =3D 0; i < num_queues; i++) {
 		err =3D gve_adminq_create_rx_queue(priv, i);
 		if (err)
-			return err;
+			goto unlock_and_return;
 	}
=20
-	return gve_adminq_kick_and_wait(priv);
+	err =3D gve_adminq_kick_and_wait(priv);
+
+unlock_and_return:
+	pthread_mutex_unlock(&priv->adminq_lock);
+	return err;
 }
=20
 static int gve_adminq_destroy_tx_queue(struct gve_priv *priv, u32 queue_in=
dex)
@@ -779,13 +808,19 @@ int gve_adminq_destroy_tx_queues(struct gve_priv *pri=
v, u32 num_queues)
 	int err;
 	u32 i;
=20
+	pthread_mutex_lock(&priv->adminq_lock);
+
 	for (i =3D 0; i < num_queues; i++) {
 		err =3D gve_adminq_destroy_tx_queue(priv, i);
 		if (err)
-			return err;
+			goto unlock_and_return;
 	}
=20
-	return gve_adminq_kick_and_wait(priv);
+	err =3D gve_adminq_kick_and_wait(priv);
+
+unlock_and_return:
+	pthread_mutex_unlock(&priv->adminq_lock);
+	return err;
 }
=20
 static int gve_adminq_destroy_rx_queue(struct gve_priv *priv, u32 queue_in=
dex)
@@ -811,13 +846,19 @@ int gve_adminq_destroy_rx_queues(struct gve_priv *pri=
v, u32 num_queues)
 	int err;
 	u32 i;
=20
+	pthread_mutex_lock(&priv->adminq_lock);
+
 	for (i =3D 0; i < num_queues; i++) {
 		err =3D gve_adminq_destroy_rx_queue(priv, i);
 		if (err)
-			return err;
+			goto unlock_and_return;
 	}
=20
-	return gve_adminq_kick_and_wait(priv);
+	err =3D gve_adminq_kick_and_wait(priv);
+
+unlock_and_return:
+	pthread_mutex_unlock(&priv->adminq_lock);
+	return err;
 }
=20
 static int gve_set_desc_cnt(struct gve_priv *priv,
diff --git a/drivers/net/gve/gve_ethdev.h b/drivers/net/gve/gve_ethdev.h
index 0577f03974..524e48e723 100644
--- a/drivers/net/gve/gve_ethdev.h
+++ b/drivers/net/gve/gve_ethdev.h
@@ -339,6 +339,7 @@ struct gve_priv {
 	struct gve_tx_queue **txqs;
 	struct gve_rx_queue **rxqs;
=20
+	pthread_mutex_t adminq_lock; /* Protects AdminQ command execution */
 	uint32_t stats_report_len;
 	const struct rte_memzone *stats_report_mem;
 	uint16_t stats_start_idx; /* start index of array of stats written by NIC=
 */
--=20
2.54.0.1189.g8c84645362-goog

