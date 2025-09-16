Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7CCECAC598
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Sep 2025 09:36:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 05F35402C2;
	Tue, 16 Sep 2025 11:36:03 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 5748A402A7
 for <dev@dpdk.org>; Tue, 16 Sep 2025 11:36:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758015360;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uCh393pu/M3XD2FYl3XUzLd3JJhpyyNcusdh5AL6QIo=;
 b=FcRiHRvpf2zLD+fAtdB78PxjEgnO10JxhQ31Q7ed1qZrVT01nkylUBqHGMO5zfC7ICIT6/
 0mu2ley6+4/aoaEawOd2FYkGXclAsLwALzzabJteTo3GXi00Nky1hXtr/U71sNHs7bEhry
 eA5XLUXtIvQthwH+rbqHyLk5fNlsd6k=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-353-5LtIJiRpOaOI6ybqXfpo_Q-1; Tue,
 16 Sep 2025 05:35:59 -0400
X-MC-Unique: 5LtIJiRpOaOI6ybqXfpo_Q-1
X-Mimecast-MFC-AGG-ID: 5LtIJiRpOaOI6ybqXfpo_Q_1758015358
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7AFCB1800366; Tue, 16 Sep 2025 09:35:58 +0000 (UTC)
Received: from max-p1.redhat.com (unknown [10.45.242.14])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6F0F21800447; Tue, 16 Sep 2025 09:35:56 +0000 (UTC)
From: Maxime Coquelin <maxime.coquelin@redhat.com>
To: dev@dpdk.org,
	david.marchand@redhat.com,
	chenbox@nvidia.com
Cc: Maxime Coquelin <maxime.coquelin@redhat.com>,
	stable@dpdk.org
Subject: [PATCH v2 1/2] vhost: add VDUSE virtqueue ready state polling
 workaround
Date: Tue, 16 Sep 2025 11:35:49 +0200
Message-ID: <20250916093550.1345901-2-maxime.coquelin@redhat.com>
In-Reply-To: <20250916093550.1345901-1-maxime.coquelin@redhat.com>
References: <20250916093550.1345901-1-maxime.coquelin@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: KNUmL0Q2qbHdqqIAFKCpt1KTmfY_Ok6i2Hu_19uqk-c_1758015358
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

Add workaround to poll virtqueue ready states before starting device
when VIRTIO_DEVICE_STATUS_DRIVER_OK is set in vduse_events_handler().

For each virtqueue, poll using VDUSE_VQ_GET_INFO ioctl to check
vq_info->ready state with configurable retry limit. This addresses
timing issues where device start was attempted before all virtqueues
were properly initialized and ready.

A notification mechanism will be introduced in the next version of
the VDUSE uAPI. When it lands, we would only apply this workaround
when the kernel does not support it.

Fixes: a9120db8b98b ("vhost: add VDUSE device startup")
Cc: stable@dpdk.org

Reviewed-by: David Marchand <david.marchand@redhat.com>
Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
---
 lib/vhost/vduse.c | 61 +++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 59 insertions(+), 2 deletions(-)

diff --git a/lib/vhost/vduse.c b/lib/vhost/vduse.c
index 9de7f04a4f..422c4ab8f3 100644
--- a/lib/vhost/vduse.c
+++ b/lib/vhost/vduse.c
@@ -272,6 +272,55 @@ vduse_vring_cleanup(struct virtio_net *dev, unsigned int index)
 	vq->last_avail_idx = 0;
 }
 
+/*
+ * Tests show that virtqueues get ready at the first retry at worst,
+ * but let's be on the safe side and allow more retries.
+ */
+#define VDUSE_VQ_READY_POLL_MAX_RETRIES 100
+
+static int
+vduse_wait_for_virtqueues_ready(struct virtio_net *dev)
+{
+	unsigned int i;
+	int ret;
+
+	for (i = 0; i < dev->nr_vring; i++) {
+		int retry_count = 0;
+
+		while (retry_count < VDUSE_VQ_READY_POLL_MAX_RETRIES) {
+			struct vduse_vq_info vq_info = { 0 };
+
+			vq_info.index = i;
+			ret = ioctl(dev->vduse_dev_fd, VDUSE_VQ_GET_INFO, &vq_info);
+			if (ret) {
+				VHOST_CONFIG_LOG(dev->ifname, ERR,
+					"Failed to get VQ %u info while polling ready state: %s",
+					i, strerror(errno));
+				return -1;
+			}
+
+			if (vq_info.ready) {
+				VHOST_CONFIG_LOG(dev->ifname, DEBUG,
+					"VQ %u is ready after %u retries", i, retry_count);
+				break;
+			}
+
+			retry_count++;
+			usleep(1000);
+		}
+
+		if (retry_count >= VDUSE_VQ_READY_POLL_MAX_RETRIES) {
+			VHOST_CONFIG_LOG(dev->ifname, ERR,
+				"VQ %u ready state polling timeout after %u retries",
+				i, VDUSE_VQ_READY_POLL_MAX_RETRIES);
+			return -1;
+		}
+	}
+
+	VHOST_CONFIG_LOG(dev->ifname, INFO, "All virtqueues are ready after polling");
+	return 0;
+}
+
 static void
 vduse_device_start(struct virtio_net *dev, bool reconnect)
 {
@@ -414,10 +463,18 @@ vduse_events_handler(int fd, void *arg, int *close __rte_unused)
 	}
 
 	if ((old_status ^ dev->status) & VIRTIO_DEVICE_STATUS_DRIVER_OK) {
-		if (dev->status & VIRTIO_DEVICE_STATUS_DRIVER_OK)
+		if (dev->status & VIRTIO_DEVICE_STATUS_DRIVER_OK) {
+			/* Poll virtqueues ready states before starting device */
+			ret = vduse_wait_for_virtqueues_ready(dev);
+			if (ret < 0) {
+				VHOST_CONFIG_LOG(dev->ifname, ERR,
+					"Failed to wait for virtqueues ready, aborting device start");
+				return;
+			}
 			vduse_device_start(dev, false);
-		else
+		} else {
 			vduse_device_stop(dev);
+		}
 	}
 
 	VHOST_CONFIG_LOG(dev->ifname, INFO, "Request %s (%u) handled successfully",
-- 
2.51.0

