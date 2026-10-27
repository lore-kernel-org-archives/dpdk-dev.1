Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C09B606A31A
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Oct 2026 18:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=hSpakj4i
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 50FBD4068A;
	Tue, 27 Oct 2026 19:56:27 +0100 (CET)
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mails.dpdk.org (Postfix) with ESMTPS id 9E72C40613
 for <dev@dpdk.org>; Tue, 27 Oct 2026 19:56:26 +0100 (CET)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3adc5b185bfso197196a91.3
 for <dev@dpdk.org>; Tue, 27 Oct 2026 11:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1793127385; x=1793732185; darn=dpdk.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=dZ8P2s5a+XHA/v2AnHqsndoysZPxoVQybr9HY7Ydcpc=;
 b=hSpakj4iFxSeNG2HdNgkVxhwq7kNXpN6MDLNkjmpo6Cmp2mH6R+kG9TnJ/W4LZUAOB
 iMjnNuUYxPD15oXqAg7Jm7k+9h7Z6jjRZrQ1KRuwLns8EVqxCyDXHP4MBmjQvITKwV3P
 hNtfP7EIcc0XounpJGgq+kofmei8ElRgI9lsXrM/Zn+fMwLnNIj89YXv7ioMbR7rU+PS
 pVD/WyzBRelolE9f7IIiWg7h+BAx3mVoiV4OiaKrHxUeiDaFBQrHXAeC1e9aIWacC9wL
 4hsPhWcybqsccKLb3vmLI4dJbi50kfyMxidA2HhfaasCKnbcB5vIBoTOxyWqZTl0fnEc
 v6pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793127385; x=1793732185;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dZ8P2s5a+XHA/v2AnHqsndoysZPxoVQybr9HY7Ydcpc=;
 b=gwbahj2+kzOdWzaGEB18xxK/DwijflX4EV0lyWHxL27Tpi7s8zEvdjxtN5CYAPXur1
 is3hjpva/e798JA7cJvIOijA+UEr3BFDhO0x804VIWCUXlty54Egz2p3a65Lr16gh+fH
 FJt70ynsQlllu3cwWgM4JUcg6SZrEzMgnTgwb76V02hTpyMjrogw7HyilnIVrTA6dVBz
 fwdEjvpVqI8UhBNyKDG8zjJUV+MnDQ9JGMZUOfNMyTlW/cqNQFzFlPP4NEVlzebiAA7R
 y/cjqmzO1RcbCTUuH8Bygeq7L078wf9mtOCvlC9QCNtT1tSbV8Iu0XV5x5u7M138ZykG
 5OBg==
X-Gm-Message-State: AFq9FYIT8S6+EuyipFb/H35+2hF+9QuWjAmOl9UbyJ6iyRFwq5XLiNby
 kXvRyZ7ZnuxYttfXx0xN633MD7nihdxuHr6IaDIzMwmxZakREK0vJXPIoFeZ/MafIfSdfpn8zHC
 KzML+9JYNCpxDxvzqc6dCiBDgqhcnt3loLb2jTrwZVCs+4WHfeI20GCzVSvFHkhqdYHQna/My3u
 xdtcaLZTOGSR4l1umKs1MmbQBeqPce4TuJ57PctukbGmikpdZwsg==
X-Received: from pjbqb1.prod.google.com ([2002:a17:90b:2801:b0:3ad:cde0:ea04])
 (user=jtranoleary job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90a:e7ca:b0:3a8:59d3:5317 with SMTP id
 98e67ed59e1d1-3adeaf98405mr9772578a91.32.1793127384829; 
 Tue, 27 Oct 2026 11:56:24 -0700 (PDT)
Date: Tue, 27 Oct 2026 18:54:15 +0000
In-Reply-To: <20261027185420.724684-1-jtranoleary@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261027185420.724684-1-jtranoleary@google.com>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
Message-ID: <20261027185420.724684-7-jtranoleary@google.com>
Subject: [PATCH 6/9] net/gve: add check for device reset to AQ ctrl ops
From: "Jasper Tran O'Leary" <jtranoleary@google.com>
To: dev@dpdk.org, Joshua Washington <joshwash@google.com>
Cc: "Jasper Tran O'Leary" <jtranoleary@google.com>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Refactor the check for the device needing a reset into a control plane
operation. This will make it easier to add a corresponding Mailbox
operation in subsequent patches.

Signed-off-by: Jasper Tran O'Leary <jtranoleary@google.com>
Reviewed-by: Joshua Washington <joshwash@google.com>
---
 drivers/net/gve/gve_ethdev.c | 14 +++++++++++---
 drivers/net/gve/gve_ethdev.h |  1 +
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/net/gve/gve_ethdev.c b/drivers/net/gve/gve_ethdev.c
index 391e7923f..cfd043dbf 100644
--- a/drivers/net/gve/gve_ethdev.c
+++ b/drivers/net/gve/gve_ethdev.c
@@ -1711,14 +1711,14 @@ gve_set_default_ring_size_bounds(struct gve_priv *priv)
 static void
 gve_check_device_status(void *arg)
 {
+	struct gve_process_private *process_priv;
 	struct rte_eth_dev *dev = arg;
 	struct gve_priv *priv = dev->data->dev_private;
-	uint32_t dev_status;
 	int ret;
 
-	dev_status = ioread32be(&priv->reg_bar0->device_status);
+	process_priv = rte_eth_devices[priv->port_id].process_private;
 
-	if (dev_status & GVE_DEVICE_STATUS_RESET_MASK) {
+	if (process_priv->ctrl_ops->check_device_needs_reset(priv)) {
 		PMD_DRV_LOG(INFO,
 			"Device on port %u requests a reset. Stopping device status polling.",
 			dev->data->port_id);
@@ -1783,9 +1783,17 @@ gve_adminq_get_device_properties(struct gve_priv *priv)
 	return gve_adminq_describe_device(priv);
 }
 
+static bool
+gve_adminq_check_device_needs_reset(struct gve_priv *priv)
+{
+	uint32_t dev_status = ioread32be(&priv->reg_bar0->device_status);
+	return (dev_status & GVE_DEVICE_STATUS_RESET_MASK) != 0;
+}
+
 static const struct gve_ctrl_ops gve_adminq_ops = {
 	.init_ctrl_plane = gve_adminq_alloc,
 	.free_ctrl_plane = gve_adminq_free,
+	.check_device_needs_reset = gve_adminq_check_device_needs_reset,
 	.get_device_properties = gve_adminq_get_device_properties,
 	.get_ptype_map = gve_adminq_get_ptype_map_dqo,
 	.get_interrupt_dbs = gve_adminq_configure_device_resources,
diff --git a/drivers/net/gve/gve_ethdev.h b/drivers/net/gve/gve_ethdev.h
index d16db54a8..495b60c11 100644
--- a/drivers/net/gve/gve_ethdev.h
+++ b/drivers/net/gve/gve_ethdev.h
@@ -307,6 +307,7 @@ struct gve_txq_config {
 struct gve_ctrl_ops {
 	int (*init_ctrl_plane)(struct gve_priv *priv);
 	void (*free_ctrl_plane)(struct gve_priv *priv);
+	bool (*check_device_needs_reset)(struct gve_priv *priv);
 	int (*get_device_properties)(struct gve_priv *priv);
 	int (*get_ptype_map)(struct gve_priv *priv);
 	int (*get_interrupt_dbs)(struct gve_priv *priv);
-- 
2.56.0.307.g5fe7bd680c-goog

