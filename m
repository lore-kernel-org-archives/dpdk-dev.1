Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74AA7E9A048
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Feb 2026 14:39:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9333F40656;
	Thu, 19 Feb 2026 15:39:14 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 6B71A40654
 for <dev@dpdk.org>; Thu, 19 Feb 2026 15:39:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771511952;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H3pH5LHFjhXQtgNd8vDqAHYU02+Zm1Ro29WRVIDrZlk=;
 b=h/108fr2nRpMRhv1rEBTM03OFAjoqkufrFsth2wNQQXyksXveQjaiYCuz65PapHfyo5+HN
 EJxzEMzmNiA+HXrqNn4hTMroAGInhje+adRvgvWtsJcHEQgIg/c1/TQod6MutjK7QTILqJ
 NxmPqmdQf3j/R8nkZ3H6Wx5DmNd/WZA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-156-vc-alb2QNG2ExChCQzISyA-1; Thu,
 19 Feb 2026 09:39:09 -0500
X-MC-Unique: vc-alb2QNG2ExChCQzISyA-1
X-Mimecast-MFC-AGG-ID: vc-alb2QNG2ExChCQzISyA_1771511948
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 515E11956094; Thu, 19 Feb 2026 14:39:08 +0000 (UTC)
Received: from rh.redhat.com (unknown [10.44.32.51])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 97DA53003D85; Thu, 19 Feb 2026 14:39:05 +0000 (UTC)
From: Kevin Traynor <ktraynor@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, david.marchand@redhat.com, dsosnowski@nvidia.com,
 viacheslavo@nvidia.com, hkalra@marvell.com,
 Kevin Traynor <ktraynor@redhat.com>, stable@dpdk.org
Subject: [PATCH v4 3/3] net/mlx5: check devx disconnect/error interrupt events
Date: Thu, 19 Feb 2026 14:38:52 +0000
Message-ID: <20260219143852.200722-4-ktraynor@redhat.com>
In-Reply-To: <20260219143852.200722-1-ktraynor@redhat.com>
References: <20260128122055.192104-1-ktraynor@redhat.com>
 <20260219143852.200722-1-ktraynor@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: iT8OmWR3lA0c2eD1dqb0QAqvTHEUXgSAI-LMmDy8PJE_1771511948
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

A busy-loop may occur when there are disconnect/error events
such as EPOLLERR, EPOLLHUP or EPOLLRDHUP on Linux for the devx
interrupt fd.

This may happen if the interrupt fd is deleted, if the device
is unbound from mlx5_core kernel driver or if the device is
removed by the mlx5 kernel driver as part of LAG setup.

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

In order to prevent a busy-loop use the eal API rte_intr_active_events()
to get the interrupt events and check for disconnect/error.

If there is a disconnect/error event, unregister the devx callback.

Bugzilla ID: 1873
Fixes: f15db67df09c ("net/mlx5: accelerate DV flow counter query")
Cc: stable@dpdk.org

Signed-off-by: Kevin Traynor <ktraynor@redhat.com>
---
 drivers/net/mlx5/linux/mlx5_ethdev_os.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/net/mlx5/linux/mlx5_ethdev_os.c b/drivers/net/mlx5/linux/mlx5_ethdev_os.c
index 18819a4a0f..1ddb620f65 100644
--- a/drivers/net/mlx5/linux/mlx5_ethdev_os.c
+++ b/drivers/net/mlx5/linux/mlx5_ethdev_os.c
@@ -860,4 +860,24 @@ mlx5_dev_interrupt_handler_devx(void *cb_arg)
 	} out;
 	uint8_t *buf = out.buf + sizeof(out.cmd_resp);
+	uint32_t events = rte_intr_active_events();
+
+	if (events & (RTE_INTR_EVENT_HUP | RTE_INTR_EVENT_RDHUP | RTE_INTR_EVENT_ERR)) {
+		/*
+		 * Disconnect or Error event that cannot be cleared by reading.
+		 * Unregister callback to prevent interrupt busy-looping.
+		 */
+		DRV_LOG(WARNING, "disconnect or error event for mlx5 devx interrupt on fd %d"
+			" (events=0x%x)",
+			rte_intr_fd_get(sh->intr_handle_devx), events);
+
+		if (rte_intr_callback_unregister_pending(sh->intr_handle_devx,
+							 mlx5_dev_interrupt_handler_devx,
+							 (void *)sh, NULL) < 0) {
+			DRV_LOG(WARNING,
+				"unable to unregister mlx5 devx interrupt callback on fd %d",
+				rte_intr_fd_get(sh->intr_handle_devx));
+		}
+		return;
+	}
 
 	while (!mlx5_glue->devx_get_async_cmd_comp(sh->devx_comp,
-- 
2.53.0

