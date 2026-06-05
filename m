Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E724CD6E7C
	for <dpdk-dev@archiver.kernel.org>; Fri,  5 Jun 2026 21:30:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4B5A54065C;
	Fri,  5 Jun 2026 23:30:54 +0200 (CEST)
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com
 [209.85.160.202])
 by mails.dpdk.org (Postfix) with ESMTP id 16780402C4
 for <dev@dpdk.org>; Fri,  5 Jun 2026 23:30:53 +0200 (CEST)
Received: by mail-qt1-f202.google.com with SMTP id
 d75a77b69052e-51758177935so64041cf.1
 for <dev@dpdk.org>; Fri, 05 Jun 2026 14:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1780695052; x=1781299852; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
 :reply-to; bh=7xY66KUUzSgoaj8M55bM7a9TQizpIwbrP0FZOog5gLQ=;
 b=W5wrwAtN9RFXRn/BAVkM6mF6jCdEaIX4+O4/9568vxyNmlPVSO7HIma4ZHt/upDHaj
 5UCRjc3OmSs2MSAmPmqjt/KqHeePMjds9jS/beAZmIF/FekSUGyHK3eyl+C71mZLgfFh
 gc36ZyX5l4uY14q/jUXdywhG1ekAoWxauFf9Om9ej6lp+Qo+b7CT39NLIGlaMAAKc2Xb
 feSxABLSSNFeHINM9nTteeEe+2G2fnbaSt9Fmhi8YEH51LlfeY/ZHUXW65aihmzngouA
 gL26tzo39H+L0e5TrDGobMcI1qWR0OG1gQQeqVUdeUe16dWI9BFLBiWCyhbd0iAD/SNu
 VQnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780695052; x=1781299852;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=7xY66KUUzSgoaj8M55bM7a9TQizpIwbrP0FZOog5gLQ=;
 b=Gy6pgR5Inr+dTNVyo6rn9jX8dNX7/ujsVVjwA/6buj+WbWXzEeExxQWmjcXtazFztC
 AfzQOo04GCHdoPP9ao37O+1I4ELYzKDf0E4TWp2JYI+KLC4lk/VPhmR8qhvfqBrsMoN4
 s/KIjfUxoAoZQVBj4IMuWCyBTsCjEmOpZB82W+z+ovAMRH3cuSE8rPwq6FGq42JYbQ2C
 IEOgseWN0Gy57+cjaX/ARXPcalIJklqXWd9vIodFjUHVLP838ODecaaxf4BFRtnHiW9B
 J5H5p52Q5/ZaHvnNXmH/hWtQeLBVA6zPnrjG0Kr/uU3aIeA5ITrsLPzF+VICI0yZptDb
 XPGQ==
X-Gm-Message-State: AOJu0Yygkh0kENr7W7cs4QWqnfgPi0+PXAyK0tFW4znBxgOEua1nxC0c
 nx8LWBqv42sPVIDKp1lOFRHsWJqvavzbxcABL7bExiUKTmeND0FgC51XH3cGiWSlZl+QsVto7xD
 Fdxxk7A==
X-Received: from qtpk22.prod.google.com ([2002:ac8:4756:0:b0:517:8aa7:4aba])
 (user=blasko job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:2484:b0:516:e1d4:553f
 with SMTP id d75a77b69052e-51795c4fcf7mr90522111cf.36.1780695052194; Fri, 05
 Jun 2026 14:30:52 -0700 (PDT)
Date: Fri,  5 Jun 2026 21:29:39 +0000
In-Reply-To: <20260605213022.2770893-1-blasko@google.com>
Mime-Version: 1.0
References: <20260515231936.3296603-1-blasko@google.com>
 <20260605213022.2770893-1-blasko@google.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260605213022.2770893-2-blasko@google.com>
Subject: [PATCH v3 1/6] net/gve: add thread safety to admin queue
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
2.54.0.1032.g2f8565e1d1-goog

