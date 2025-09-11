Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8AD4CAC587
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Sep 2025 08:36:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DA14B402E8;
	Thu, 11 Sep 2025 10:36:21 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 1FA2A402E8
 for <dev@dpdk.org>; Thu, 11 Sep 2025 10:36:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757579779;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=fPGg+nqAxE7lnZdGE4QjzDCqmVn286aybWd2qRyAxQE=;
 b=NTpcXgWGvga1cKBVcvDeM/8EN2lhooBt6sx6QlviXcmSSb0lt1y5dE+Bu0JbcMexXllZTe
 06b3/a49WXUnoI/cD7Z3GE8420PZmVdIMvsQANwJZynIEbNewo+mLonqmf3/m9hACuGPGq
 OEtqCzYCmtAbDiwVTvZaNi5EV0G43qA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-574-qI0QoLxfPcuxo4GZkWr5qQ-1; Thu,
 11 Sep 2025 04:36:16 -0400
X-MC-Unique: qI0QoLxfPcuxo4GZkWr5qQ-1
X-Mimecast-MFC-AGG-ID: qI0QoLxfPcuxo4GZkWr5qQ_1757579775
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3AFC91944F03; Thu, 11 Sep 2025 08:36:15 +0000 (UTC)
Received: from max-p1.redhat.com (unknown [10.44.22.34])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0D4D41800452; Thu, 11 Sep 2025 08:36:11 +0000 (UTC)
From: Maxime Coquelin <maxime.coquelin@redhat.com>
To: dev@dpdk.org, chenbox@nvidia.com, david.marchand@redhat.com,
 amorenoz@redhat.com
Cc: Maxime Coquelin <maxime.coquelin@redhat.com>,
	stable@dpdk.org
Subject: [PATCH] vhost: add VDUSE virtqueue ready state polling workaround
Date: Thu, 11 Sep 2025 10:36:07 +0200
Message-ID: <20250911083607.3676640-1-maxime.coquelin@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: sOHF7LivXS05S6z81-Pl_VPGUqXVcjw-zL8Z_hkfGDU_1757579775
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

Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
---
 lib/vhost/vduse.c | 62 +++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 60 insertions(+), 2 deletions(-)

diff --git a/lib/vhost/vduse.c b/lib/vhost/vduse.c
index 9de7f04a4f..5a6025d702 100644
--- a/lib/vhost/vduse.c
+++ b/lib/vhost/vduse.c
@@ -272,6 +272,56 @@ vduse_vring_cleanup(struct virtio_net *dev, unsigned int index)
 	vq->last_avail_idx = 0;
 }
 
+
+/*
+ * Tests show that it succeeds at the first retry at worst,
+ * but let's be on the safe side and allow more retries.
+ */
+#define VDUSE_VQ_READY_POLL_MAX_RETRIES 100
+
+static int
+vduse_wait_for_virtqueues_ready(struct virtio_net *dev)
+{
+	struct vduse_vq_info vq_info;
+	unsigned int i;
+	int ret;
+
+	for (i = 0; i < dev->nr_vring; i++) {
+		int retry_count = 0;
+
+		while (retry_count < VDUSE_VQ_READY_POLL_MAX_RETRIES) {
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
+			/* Small delay between retries */
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
@@ -414,10 +464,18 @@ vduse_events_handler(int fd, void *arg, int *close __rte_unused)
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

