Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 430B0CD37BE
	for <dpdk-dev@archiver.kernel.org>; Tue, 12 May 2026 00:54:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B279F40609;
	Tue, 12 May 2026 02:54:09 +0200 (CEST)
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com
 [209.85.222.202])
 by mails.dpdk.org (Postfix) with ESMTP id 4E7F440278
 for <dev@dpdk.org>; Tue, 12 May 2026 02:54:08 +0200 (CEST)
Received: by mail-qk1-f202.google.com with SMTP id
 af79cd13be357-8ee1a909037so933121485a.3
 for <dev@dpdk.org>; Mon, 11 May 2026 17:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1778547247; x=1779152047; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
 :reply-to; bh=S0LeSsuQGN+WgP3txGUZm577Uwzxqz6Azco3qB7dxl0=;
 b=LKonhPvKX01UIfGuKpqrtIlMoOWvCX0nbOvgv8fm1DQx0rZ3bYqxqLnaZV9HViZbjl
 D8/PNoSGdvCWtfn0GmKQ/2vCAfEnxZatEZaGsft/rUkZK6ZKLEmcEmz9Sk5V/WT8n6Ho
 3BR6h7frMoJHH/D/Kom2TBplD/h189CDeXJuZCagyiaKFDTI74Pfgb6RKYS2CCRf+4PE
 BL4bKS4W5zD/21jX9DX4rlMl//FCg9I3JkACplr0FVIpWZjBIOfR+DcS5aVXsBB90xHg
 xG527JGCWOu1FsYy4rGoWXsErw6Z6/gq5VYoVR2oVdE0YcWxQ1lgZym9quDeWfVmddsn
 NCNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778547247; x=1779152047;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=S0LeSsuQGN+WgP3txGUZm577Uwzxqz6Azco3qB7dxl0=;
 b=DwIxI1A/eQOSYTS6fgmJSE5OEPPGujBGWXxIPrn86nTy1VjrMvMYVaQyUwZuV8Lnu8
 fgyBxJ3+q/hhEev0JiHNKl20X/2igs0JBnjoe/wudtKcXz/1JUtL+RcozTQ3DS3lEjyg
 HcsLt2ME57PJt0q+3GxMNACAJ8xRSmFrPmNJ0oOwjImlig/JiSMr0SXl5ic+u+ruMJBE
 pfK+jVM/TriL/7DEnoyR54nPBPgiv98umBaLVZP0Pn+JemK1G07FTjR9yNPk4aXJsMtq
 C1bvIBB756WZN2r8jvbV8THzOStLVCOlGRz0htlfjhqzffgzqsmxSWFZlshiBg74FgG5
 9IoA==
X-Gm-Message-State: AOJu0YzDJNQ038HqXySgR9G+ADNSoLbGCfC+oyoF5OS0r7xvDTm0CNTf
 1HVvP4VXWDsPXvWBPA5QGWrzPePKL/A+c2845//U3+8glnyIDIgyNN3hxfwoJNG9C+ONyGT3WBj
 Ux0Hoew==
X-Received: from qvdf4.prod.google.com ([2002:a05:6214:1d24:b0:8bf:8cba:1f9])
 (user=blasko job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:461e:b0:8ec:c4a7:f8e5
 with SMTP id af79cd13be357-907bad06b07mr2486887485a.31.1778547247349; Mon, 11
 May 2026 17:54:07 -0700 (PDT)
Date: Tue, 12 May 2026 00:53:48 +0000
In-Reply-To: <20260512005404.946979-1-blasko@google.com>
Mime-Version: 1.0
References: <20260512005404.946979-1-blasko@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260512005404.946979-2-blasko@google.com>
Subject: [PATCH 1/6] net/gve: add thread safety to admin queue
From: Mark Blasko <blasko@google.com>
To: stephen@networkplumber.org
Cc: dev@dpdk.org, Mark Blasko <blasko@google.com>, 
 Joshua Washington <joshwash@google.com>,
 "Jasper Tran O'Leary" <jtranoleary@google.com>
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
 .mailmap                          |  1 +
 drivers/net/gve/base/gve_adminq.c | 68 +++++++++++++++++++++++++------
 drivers/net/gve/gve_ethdev.h      |  1 +
 3 files changed, 57 insertions(+), 13 deletions(-)

diff --git a/.mailmap b/.mailmap
index 3ab7364668..7f7590866b 100644
--- a/.mailmap
+++ b/.mailmap
@@ -1009,6 +1009,7 @@ Mario Carrillo <mario.alfredo.c.arevalo@intel.com>
 M=C3=A1rio Kuka <kuka@cesnet.cz>
 Mariusz Drost <mariuszx.drost@intel.com>
 Mark Asselstine <mark.asselstine@windriver.com>
+Mark Blasko <blasko@google.com>
 Mark Bloch <mbloch@nvidia.com> <markb@mellanox.com>
 Mark Gillott <mgillott@vyatta.att-mail.com>
 Mark Kavanagh <mark.b.kavanagh@intel.com>
diff --git a/drivers/net/gve/base/gve_adminq.c b/drivers/net/gve/base/gve_a=
dminq.c
index 9c5316fb00..28661fb6cd 100644
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
@@ -241,6 +242,12 @@ int gve_adminq_alloc(struct gve_priv *priv)
 	priv->adminq_get_ptype_map_cnt =3D 0;
 	priv->adminq_cfg_flow_rule_cnt =3D 0;
=20
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
=20
@@ -418,7 +426,10 @@ static int gve_adminq_issue_cmd(struct gve_priv *priv,
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
@@ -509,17 +520,24 @@ static int gve_adminq_execute_cmd(struct gve_priv *pr=
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
@@ -693,13 +711,19 @@ int gve_adminq_create_tx_queues(struct gve_priv *priv=
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
@@ -747,13 +771,19 @@ int gve_adminq_create_rx_queues(struct gve_priv *priv=
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
@@ -779,13 +809,19 @@ int gve_adminq_destroy_tx_queues(struct gve_priv *pri=
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
@@ -811,13 +847,19 @@ int gve_adminq_destroy_rx_queues(struct gve_priv *pri=
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
2.54.0.563.g4f69b47b94-goog

