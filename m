Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD861EB2700
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Feb 2026 19:08:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A931C40B9E;
	Tue, 10 Feb 2026 20:08:08 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 4624240B91
 for <dev@dpdk.org>; Tue, 10 Feb 2026 20:08:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770750486;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XWcHNHy7pxQ3F3v1GSt4cfo7e0g6u1kRGyk4wUL4oU4=;
 b=drsrefV0w3XSjDnFDm/YDaCPcwrYVOGx90RpMuFl4W5Fvws63XyQowY2pxbmoozmfl8Tpf
 JoiThrs2gssIhZ/aS+chUka7J2MQntiTUKWLQM2Aj2KUoKigsVyplavQg5Qfo8KSZyl66U
 eY5n+wKshrpkJdRjSpc69saKauvn+bw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-627-lFkE2IJSPnycKGkxel6sxg-1; Tue,
 10 Feb 2026 13:06:54 -0500
X-MC-Unique: lFkE2IJSPnycKGkxel6sxg-1
X-Mimecast-MFC-AGG-ID: lFkE2IJSPnycKGkxel6sxg_1770746813
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D7C011955F12; Tue, 10 Feb 2026 18:06:52 +0000 (UTC)
Received: from rh.redhat.com (unknown [10.44.33.40])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 07D661800465; Tue, 10 Feb 2026 18:06:48 +0000 (UTC)
From: Kevin Traynor <ktraynor@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, david.marchand@redhat.com, dsosnowski@nvidia.com,
 viacheslavo@nvidia.com, hkalra@marvell.com,
 Kevin Traynor <ktraynor@redhat.com>, stable@dpdk.org
Subject: [PATCH v3 1/2] net/mlx5: check for no data read in devx interrupt
Date: Tue, 10 Feb 2026 18:06:33 +0000
Message-ID: <20260210180634.187586-2-ktraynor@redhat.com>
In-Reply-To: <20260210180634.187586-1-ktraynor@redhat.com>
References: <20260128122055.192104-1-ktraynor@redhat.com>
 <20260210180634.187586-1-ktraynor@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: qpOIpuCO5b8PYJWw0rUsNxU7CVdrIywpF2gDaM7Y5Vo_1770746813
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

A busy-loop may occur when there are EPOLLERR, EPOLLHUP or
EPOLLRDHUP epoll events for the devx interrupt fd.

This may happen if the interrupt fd is deleted, if the device
is unbound from mlx5_core kernel driver or if the device is
removed by the mlx5 kernel driver as part of LAG setup.

When that occurs, there is no data to be read and in the devx
interrupt handler an EAGAIN is returned on the first call to
devx_get_async_cmd_comp, but this is not checked.

As the interrupt is not removed or condition reset, it causes
an interrupt processing busy-loop, which leads to the dpdk-intr
thread going to 100% CPU.

e.g.
epoll_wait
   (6, [{events=EPOLLIN|EPOLLRDHUP, data={u32=28, u64=28}}], 8, -1) = 1
read(28, 0x7f1f5c7fc2f0, 40)
   = -1 EAGAIN (Resource temporarily unavailable)
epoll_wait
   (6, [{events=EPOLLIN|EPOLLRDHUP, data={u32=28, u64=28}}], 8, -1) = 1
read(28, 0x7f1f5c7fc2f0, 40)
   = -1 EAGAIN (Resource temporarily unavailable)

Add a check for an EAGAIN return from devx_get_async_cmd_comp on the
first read. If that happens, unregister the callback to prevent looping.

Bugzilla ID: 1873
Fixes: f15db67df09c ("net/mlx5: accelerate DV flow counter query")
Cc: stable@dpdk.org

Signed-off-by: Kevin Traynor <ktraynor@redhat.com>
---
 drivers/net/mlx5/linux/mlx5_ethdev_os.c | 34 ++++++++++++++++++++-----
 1 file changed, 28 insertions(+), 6 deletions(-)

diff --git a/drivers/net/mlx5/linux/mlx5_ethdev_os.c b/drivers/net/mlx5/linux/mlx5_ethdev_os.c
index 50997c187c..bb4ef40e06 100644
--- a/drivers/net/mlx5/linux/mlx5_ethdev_os.c
+++ b/drivers/net/mlx5/linux/mlx5_ethdev_os.c
@@ -859,11 +859,33 @@ mlx5_dev_interrupt_handler_devx(void *cb_arg)
 	} out;
 	uint8_t *buf = out.buf + sizeof(out.cmd_resp);
+	bool data_read = false;
+	int ret;
 
-	while (!mlx5_glue->devx_get_async_cmd_comp(sh->devx_comp,
-						   &out.cmd_resp,
-						   sizeof(out.buf)))
-		mlx5_flow_async_pool_query_handle
-			(sh, (uint64_t)out.cmd_resp.wr_id,
-			 mlx5_devx_get_out_command_status(buf));
+	while (!(ret = mlx5_glue->devx_get_async_cmd_comp(sh->devx_comp,
+							  &out.cmd_resp,
+							  sizeof(out.buf)))) {
+		data_read = true;
+		mlx5_flow_async_pool_query_handle(sh,
+			(uint64_t)out.cmd_resp.wr_id,
+			mlx5_devx_get_out_command_status(buf));
+	}
+
+	if (!data_read && ret == EAGAIN) {
+		/*
+		 * no data and EAGAIN indicate there is an error or
+		 * disconnect state. Unregister callback to prevent
+		 * interrupt busy-looping.
+		 */
+		DRV_LOG(DEBUG, "no data for mlx5 devx interrupt on fd %d",
+			rte_intr_fd_get(sh->intr_handle_devx));
+
+		if (rte_intr_callback_unregister_pending(sh->intr_handle_devx,
+						     mlx5_dev_interrupt_handler_devx,
+						     (void *)sh, NULL) < 0) {
+			DRV_LOG(WARNING,
+				"unable to unregister mlx5 devx interrupt callback on fd %d",
+				rte_intr_fd_get(sh->intr_handle_devx));
+		}
+	}
 #endif /* HAVE_IBV_DEVX_ASYNC */
 }
-- 
2.52.0

