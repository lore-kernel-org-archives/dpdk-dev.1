Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC9D7C5321C
	for <dpdk-dev@archiver.kernel.org>; Mon, 27 Jul 2026 11:53:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CA287402EE;
	Mon, 27 Jul 2026 13:53:27 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 51974400D6
 for <dev@dpdk.org>; Mon, 27 Jul 2026 13:53:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785153205;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RRjgE5vEvNzUGWnrEJP69/ZivYfFeLESMyNtxzQ9XD0=;
 b=NHQQqsvnEjxKAVII3NT9RT5DF05zspJ5yB5lqhZ59GId2n0KNmPgMapFD6rEzdUyIhYkw7
 lPiRHhriC956tWlc5DHRAVIHnw2PVvycE4Mz8sXT1WW+A0OP/uTJPqE+WjWRqeDSELpyWq
 zWZiEfMl0BJTDA+hijbervG32laslZw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-91-xLxB7T-MMXep9sGR_GL28Q-1; Mon,
 27 Jul 2026 07:53:22 -0400
X-MC-Unique: xLxB7T-MMXep9sGR_GL28Q-1
X-Mimecast-MFC-AGG-ID: xLxB7T-MMXep9sGR_GL28Q_1785153201
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4D7C21955E9E; Mon, 27 Jul 2026 11:53:21 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.48.202])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5740518001DD; Mon, 27 Jul 2026 11:53:19 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org,
	hkalra@marvell.com
Cc: Matan Azrad <matan@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 Xueming Li <xuemingl@nvidia.com>
Subject: [RFC v2 1/3] vdpa/mlx5: fix check on err interrupt FD
Date: Mon, 27 Jul 2026 13:53:07 +0200
Message-ID: <20260727115309.1377267-2-david.marchand@redhat.com>
In-Reply-To: <20260727115309.1377267-1-david.marchand@redhat.com>
References: <20260723131908.3313223-1-david.marchand@redhat.com>
 <20260727115309.1377267-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ARONOcZZBPdr4URzC-KCp7dYqFbYyt0vtPPIhyeWMI0_1785153201
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

