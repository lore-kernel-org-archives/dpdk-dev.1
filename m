Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A199FC54E71
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 May 2025 14:23:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C768B42DA6;
	Wed, 21 May 2025 16:23:18 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id AD0964028F
 for <dev@dpdk.org>; Wed, 21 May 2025 16:23:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747837396;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=9Wv+S1Qok05Vj0JFF/Fm86XjCKZNyMIuorsh85vzH+w=;
 b=jT4zL4RUQCs57RrFdlenBAcq2EiUwKt4cIuoUhGI3UBKam4VPrCGFs5C5aGBg+eMxoDsrK
 U9MO/g8FLJVAj7RvSh2L+BEu/DHjlrmmK4L7x1M/vjf7bQ15aUcwp8aEyRWWDp0zTAjUBL
 nkNvjBP1rkltCEWmhOXKq/mPJhmv0KY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-126-UCMhoyvVMSSk5Xr2Qo_4bA-1; Wed,
 21 May 2025 10:23:13 -0400
X-MC-Unique: UCMhoyvVMSSk5Xr2Qo_4bA-1
X-Mimecast-MFC-AGG-ID: UCMhoyvVMSSk5Xr2Qo_4bA_1747837392
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 222C4195608A; Wed, 21 May 2025 14:23:12 +0000 (UTC)
Received: from max-p1.redhat.com (unknown [10.44.22.28])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BC36C19560AB; Wed, 21 May 2025 14:23:09 +0000 (UTC)
From: Maxime Coquelin <maxime.coquelin@redhat.com>
To: dev@dpdk.org,
	david.marchand@redhat.com,
	chenbox@nvidia.com
Cc: Maxime Coquelin <maxime.coquelin@redhat.com>
Subject: [PATCH v1] net/virtio-user: implement MAC setting for Vhost-kernel
Date: Wed, 21 May 2025 16:23:05 +0200
Message-ID: <20250521142305.343264-1-maxime.coquelin@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 4LMcLdn0Vdniag_ZN_s7HVa8tWLK0smZi416AlHoSME_1747837392
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

This patch implements MAC address setting with Vhost-kernel
backends.

With this, it is possible to set the TAP interface MAC address
using the Ethdev API.

Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
---

Change from RFC: Rebased on latest main

---

 drivers/net/virtio/virtio_user/vhost_kernel.c | 23 +++++++++++++++++++
 .../net/virtio/virtio_user/vhost_kernel_tap.c |  2 +-
 .../net/virtio/virtio_user/vhost_kernel_tap.h |  2 +-
 .../net/virtio/virtio_user/virtio_user_dev.c  |  2 +-
 4 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/drivers/net/virtio/virtio_user/vhost_kernel.c b/drivers/net/virtio/virtio_user/vhost_kernel.c
index e42bb35935..4ff47c2327 100644
--- a/drivers/net/virtio/virtio_user/vhost_kernel.c
+++ b/drivers/net/virtio/virtio_user/vhost_kernel.c
@@ -12,6 +12,7 @@
 #include <rte_memory.h>

 #include "vhost.h"
+#include "virtio.h"
 #include "virtio_user_dev.h"
 #include "vhost_kernel_tap.h"

@@ -152,6 +153,9 @@ vhost_kernel_get_features(struct virtio_user_dev *dev, uint64_t *features)
 	if (tap_flags & IFF_MULTI_QUEUE)
 		*features |= (1ull << VIRTIO_NET_F_MQ);

+	/* vhost_kernel supports setting tap MAC address. */
+	*features |= (1ull << VIRTIO_NET_F_MAC);
+
 	return 0;
 }

@@ -371,6 +375,24 @@ vhost_kernel_set_status(struct virtio_user_dev *dev __rte_unused, uint8_t status
 	return -ENOTSUP;
 }

+static int
+vhost_kernel_set_config(struct virtio_user_dev *dev,
+			const uint8_t *data, uint32_t off, uint32_t len)
+{
+	struct vhost_kernel_data *backend_data = dev->backend_data;
+
+	if (off == offsetof(struct virtio_net_config, mac)) {
+		if (len != RTE_ETHER_ADDR_LEN) {
+			PMD_DRV_LOG(ERR, "Invalid MAC address length");
+			return -EINVAL;
+		}
+
+		return tap_set_mac(backend_data->tapfds[0], data);
+	}
+
+	return -ENOTSUP;
+}
+
 /**
  * Set up environment to talk with a vhost kernel backend.
  *
@@ -613,6 +635,7 @@ struct virtio_user_backend_ops virtio_ops_kernel = {
 	.set_vring_addr = vhost_kernel_set_vring_addr,
 	.get_status = vhost_kernel_get_status,
 	.set_status = vhost_kernel_set_status,
+	.set_config = vhost_kernel_set_config,
 	.enable_qp = vhost_kernel_enable_queue_pair,
 	.update_link_state = vhost_kernel_update_link_state,
 	.get_intr_fd = vhost_kernel_get_intr_fd,
diff --git a/drivers/net/virtio/virtio_user/vhost_kernel_tap.c b/drivers/net/virtio/virtio_user/vhost_kernel_tap.c
index 611e2e25ec..3e13f8f65b 100644
--- a/drivers/net/virtio/virtio_user/vhost_kernel_tap.c
+++ b/drivers/net/virtio/virtio_user/vhost_kernel_tap.c
@@ -112,7 +112,7 @@ tap_get_flags(int tapfd, unsigned int *tap_flags)
 }

 int
-tap_set_mac(int tapfd, uint8_t *mac)
+tap_set_mac(int tapfd, const uint8_t *mac)
 {
 	struct ifreq ifr;

diff --git a/drivers/net/virtio/virtio_user/vhost_kernel_tap.h b/drivers/net/virtio/virtio_user/vhost_kernel_tap.h
index 636a0481be..0b9258dcb7 100644
--- a/drivers/net/virtio/virtio_user/vhost_kernel_tap.h
+++ b/drivers/net/virtio/virtio_user/vhost_kernel_tap.h
@@ -40,6 +40,6 @@ int tap_support_features(unsigned int *tap_features);
 int tap_open(const char *ifname, unsigned int r_flags, bool multi_queue);
 int tap_get_name(int tapfd, char **ifname);
 int tap_get_flags(int tapfd, unsigned int *tap_flags);
-int tap_set_mac(int tapfd, uint8_t *mac);
+int tap_set_mac(int tapfd, const uint8_t *mac);

 #endif
diff --git a/drivers/net/virtio/virtio_user/virtio_user_dev.c b/drivers/net/virtio/virtio_user/virtio_user_dev.c
index 187f81b066..d5475bc4eb 100644
--- a/drivers/net/virtio/virtio_user/virtio_user_dev.c
+++ b/drivers/net/virtio/virtio_user/virtio_user_dev.c
@@ -790,7 +790,7 @@ virtio_user_dev_init(struct virtio_user_dev *dev, char *path, uint16_t queues,
 	if (!packed_vq)
 		dev->unsupported_features |= (1ull << VIRTIO_F_RING_PACKED);

-	if (dev->mac_specified)
+	if (dev->mac_specified || (dev->device_features & (1ull << VIRTIO_NET_F_MAC)))
 		dev->frontend_features |= (1ull << VIRTIO_NET_F_MAC);
 	else
 		dev->unsupported_features |= (1ull << VIRTIO_NET_F_MAC);
--
2.49.0

