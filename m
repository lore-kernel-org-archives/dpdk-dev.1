Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12343CD4851
	for <dpdk-dev@archiver.kernel.org>; Fri, 15 May 2026 23:19:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AC1B240659;
	Sat, 16 May 2026 01:19:44 +0200 (CEST)
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com
 [209.85.219.74]) by mails.dpdk.org (Postfix) with ESMTP id C598440269
 for <dev@dpdk.org>; Sat, 16 May 2026 01:19:41 +0200 (CEST)
Received: by mail-qv1-f74.google.com with SMTP id
 6a1803df08f44-8aca29dcd69so10163846d6.1
 for <dev@dpdk.org>; Fri, 15 May 2026 16:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1778887181; x=1779491981; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
 :reply-to; bh=CnPFizJby9vMIlArbEoBLGjVv0NA3XQbB4oZLbmvNFU=;
 b=AY5KTwWfDK2P3h0b3rsgAPhnu0JsjBnLcBUMa+xyys3vLfIl2ZfltydRqDszF5OFoS
 ilGCa19do5pM2Vlr16Cq6GlsztlK7CZ9T1grXm0AWJcxYMzFQCB1nfMgAtAQXuAtTGSz
 7Czwvv1e9yWPvj9AM4foQk+XNKEFQ4ZWkGSKUQvGukFz7PkKCKxndgWXbByljWkqTLmH
 oyhesRDlW6+5o3EdwqWH8sbeRw8shZ7c47auoBYZMeZj1vGQwPcoYgaA1C21Tnn3YeWP
 Et8njuuezMIubi3utLuMJpWNcCUvdtCdk6dCeVuTDVZ5CUKD5O+438xhJraiiRj1Nstm
 bhRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778887181; x=1779491981;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=CnPFizJby9vMIlArbEoBLGjVv0NA3XQbB4oZLbmvNFU=;
 b=nBYJkreaADuMw+6ACPQB6je6mxa8nIrTm1fUYYwevYfpnvzawU29KrXGWIjWz3pYOr
 H2sw/XbUg0Rxv8OiYTn6ZkZEVW2xh6Q2+ECbRf7r6e8w2rICUAa4K+X1mVPJHs7FFa2R
 oMxb5T7RoTMyD7cNJ92lUhfTd4mAdRKv+w/nn3P8xK3PFNerx8yhnKpjEu5XygrEzOMc
 J/LoXldaCgC0XSXrEY9vyx9xbqkdnzdWexm9p0GFqUuSU5+6I9r03Q37druOxmZC/U73
 Iv9Y8EqLaLIg/hKR35Qmo6KgbAXh0mZoB4PAC4X5sQ9Q1jreld/kk9ZHafztdeVBaSZb
 i34g==
X-Gm-Message-State: AOJu0Yz73qZeH4KE092KfbgjKeYSGpyZR++mIe11dgtte8RWltZGIvJN
 lciZsA4a130wf7mvLks4Qjr7UA0zA9L939AsHg9HZA3oZgZjKKM7ZoZAg9pdZuNYet2lzV1LB7m
 bjSdaTA==
X-Received: from qvbgm7.prod.google.com ([2002:a05:6214:2687:b0:89c:e55f:aa16])
 (user=blasko job=prod-delivery.src-stubby-dispatcher) by
 2002:a0c:f94c:0:b0:8ac:732b:6cf1
 with SMTP id 6a1803df08f44-8ca0f67107dmr80146626d6.24.1778887180814; Fri, 15
 May 2026 16:19:40 -0700 (PDT)
Date: Fri, 15 May 2026 23:19:30 +0000
In-Reply-To: <20260515231936.3296603-1-blasko@google.com>
Mime-Version: 1.0
References: <20260511224354.872997-1-blasko@google.com>
 <20260515231936.3296603-1-blasko@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260515231936.3296603-2-blasko@google.com>
Subject: [PATCH v2 1/6] net/gve: add thread safety to admin queue
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
v2:
    - Dropped ROBUST mutex attribute.
---
 .mailmap                          |  1 +
 drivers/net/gve/base/gve_adminq.c | 67 +++++++++++++++++++++++++------
 drivers/net/gve/gve_ethdev.h      |  1 +
 3 files changed, 56 insertions(+), 13 deletions(-)

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
2.54.0.563.g4f69b47b94-goog

