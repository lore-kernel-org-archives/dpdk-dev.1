Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9188CA5FD4
	for <dpdk-dev@archiver.kernel.org>; Fri,  2 Oct 2026 09:18:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7FA7A40F16;
	Fri,  2 Oct 2026 11:18:20 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 35EF040EE7
 for <dev@dpdk.org>; Fri,  2 Oct 2026 11:18:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790932698;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ICeHBd5vk63Gb6ZNGpWjwpvSrWsE3aO82I5V6RRBtKI=;
 b=AldeuIt4gT7koVyQojxwDi+vUdsHiabBUZqKZTkKWqHY5+VTetmQwy/qCWrtrd9Sglp7pr
 SlErPrEeHAIPE6orlKqZT0BHExUNT4JaQ7ZsBysPzR6nws/mW0cnfnM4wJCPrP29nrMJiL
 ifqzcjjhAdR15VZjjdsEQ0IopgoXZfY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-180-rTbMQitDPfiYgIX4-eBmzQ-1; Fri,
 02 Oct 2026 05:18:15 -0400
X-MC-Unique: rTbMQitDPfiYgIX4-eBmzQ-1
X-Mimecast-MFC-AGG-ID: rTbMQitDPfiYgIX4-eBmzQ_1790932693
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5CEAF1977017; Fri,  2 Oct 2026 09:18:13 +0000 (UTC)
Received: from dmarchan.redhat.corp
 (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 691BF30000E4; Fri,  2 Oct 2026 09:18:11 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org,
	hkalra@marvell.com
Cc: Dariusz Sosnowski <dsosnowski@nvidia.com>, Matan Azrad <matan@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Xueming Li <xuemingl@nvidia.com>,
 Maxime Coquelin <maxime.coquelin@redhat.com>
Subject: [PATCH 1/5] vdpa/mlx5: fix check on err interrupt FD
Date: Fri,  2 Oct 2026 11:17:54 +0200
Message-ID: <20261002091758.2922227-2-david.marchand@redhat.com>
In-Reply-To: <20261002091758.2922227-1-david.marchand@redhat.com>
References: <20261002091758.2922227-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 1CQs3B0JJiOGnQtOvBfr2QGzWxlRmGCLoyVJcEgM7NU_1790932693
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
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

A 0 file descriptor is valid.
Prefer setting to -1 to indicate an invalid FD.

Fixes: 0474419bae7c ("vdpa/mlx5: handle hardware error")

Signed-off-by: David Marchand <david.marchand@redhat.com>
Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
---
 drivers/vdpa/mlx5/mlx5_vdpa_event.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/vdpa/mlx5/mlx5_vdpa_event.c b/drivers/vdpa/mlx5/mlx5_vdpa_event.c
index 43585a94b2..dee2ccc23d 100644
--- a/drivers/vdpa/mlx5/mlx5_vdpa_event.c
+++ b/drivers/vdpa/mlx5/mlx5_vdpa_event.c
@@ -452,7 +452,7 @@ mlx5_vdpa_err_event_setup(struct mlx5_vdpa_priv *priv)
 					 mlx5_vdpa_err_interrupt_handler,
 					 priv);
 	if (ret != 0) {
-		rte_intr_fd_set(priv->err_intr_handle, 0);
+		rte_intr_fd_set(priv->err_intr_handle, -1);
 		DRV_LOG(ERR, "Failed to register error interrupt for device %d.",
 			priv->vid);
 		rte_errno = -ret;
@@ -473,7 +473,7 @@ mlx5_vdpa_err_event_unset(struct mlx5_vdpa_priv *priv)
 	int retries = MLX5_VDPA_INTR_RETRIES;
 	int ret = -EAGAIN;
 
-	if (!rte_intr_fd_get(priv->err_intr_handle))
+	if (rte_intr_fd_get(priv->err_intr_handle) < 0)
 		return;
 	while (retries-- && ret == -EAGAIN) {
 		ret = rte_intr_callback_unregister(priv->err_intr_handle,
@@ -487,6 +487,7 @@ mlx5_vdpa_err_event_unset(struct mlx5_vdpa_priv *priv)
 			rte_pause();
 		}
 	}
+	rte_intr_fd_set(priv->err_intr_handle, -1);
 	if (priv->err_chnl) {
 #ifdef HAVE_IBV_DEVX_EVENT
 		union {
-- 
2.54.0

