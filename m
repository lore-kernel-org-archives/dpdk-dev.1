Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FA36C43458
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Jun 2026 13:24:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9335F40695;
	Tue, 30 Jun 2026 15:24:31 +0200 (CEST)
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com
 [209.85.210.171])
 by mails.dpdk.org (Postfix) with ESMTP id 46FB840299
 for <dev@dpdk.org>; Mon, 29 Jun 2026 14:08:15 +0200 (CEST)
Received: by mail-pf1-f171.google.com with SMTP id
 d2e1a72fcca58-845b733e82cso1978813b3a.2
 for <dev@dpdk.org>; Mon, 29 Jun 2026 05:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782734894; x=1783339694; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tHYu4pyRQpSIBb+Wz7dketKDNSrNvf4j3Os6NXtcSQY=;
 b=ILAjbyqu0/v1HvB3plwYLpgRcwbK9Hi6BAlXIURupGf9lRoVs5BC4Rz9f8q15e9qg3
 Q+xtrA4kVJf+L8TVMIU/Qmcw/apyQHixE5wehcRxoaJdaoi0rdKSIRqfdyWpUelO5MTb
 ZrDaBYYtDi8NpHj84VeaxroY7Iy7VNqi7pvxfUZX1YGMx2A6WhMb7n6g9ZHXYBtNruuK
 HidtH8DznepkbxGBN5nwBz1VKdHzgOIIY2qivN8CGnR4bak6Nsf29C2rBJWyTgv93/cE
 7Ih8DvUCP5xK6H5dGpaZS6xFVUiNiRGJOy1D1c79EzCL4rt6bMh35NDfIkrv1FIIDPf0
 LGGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782734894; x=1783339694;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tHYu4pyRQpSIBb+Wz7dketKDNSrNvf4j3Os6NXtcSQY=;
 b=SJvKolp2Ws/MLtmitzUhPzAwu+BLZMe2vOWrnW1xxruVBlQG+OSSL7QXppByqTnIBT
 uGUC4PccOnzoRe6UnXxaHkqLMqQGGVxWSyZ2XubsVlY0Yxy4FLwd7KKsY63/UtNAB7y8
 h9FJDZLsrQIlcuJHavYjjuj6TmnDXqR+ZcZo4DXvIzt3o2XvQ5HzEGuJtYhuHalwtQWc
 o3/UiaKeJJsI2/cmyfuTDBYNs67UJ7wO33wwCx3pBWD9GGhgKvgjNjvqUZTBWjkS/s+X
 3O3ahv8+eFxwUUVqWaljj84WBBSgDHeR7UdSFxWL2bL0r4zCkRiOZEIdmTORGSSzPvnF
 cwyQ==
X-Gm-Message-State: AOJu0YywgdTTEmGy+6al+6l7LTHhAeHT0AeTVzegbufzbSgizU0mtRUu
 WsyKD8XFU9P61imrg83am+iriy1KvwoueFFhKJBISCfxu6osOYIzXlT7WerzYquSfsQ=
X-Gm-Gg: AfdE7cknDn223F4N87jRaLdKf4ZN30TXJl+QdwlHX1rcfmvbL9FwvDPK7FvgZV8H8dr
 R/7OmlRRuO41Pquzdk6JY+JPcYqdiwSP8Vxj15LRF2pEvWmxHa2QS/6nrFmsu6Hzl3bBlXDDlNy
 cbwOcOE0t4Gpn70CDY9B1qcqRZljaLnlNkB4FiKhKCGBxr4AXz2JDVvCIha8/+q350Fy3UduSp0
 egOfR4EfK+4DCBOUF8Ok8xZxdBkML1pZjbLMyA4F2P7dYimZXDcClWM3eSeLGLxTTMRjeLewX9M
 ZfjmtHWp3WuhdQ8NsT/2sMr85pR3i315sSJqWelOml40uESmQfUa4ZTeFvCf/TQoWl8oAdbd54c
 XT/Ig0MoueZM4f3P0vL6LVGFJ4xeM8UXGdMbuGBiVznG4GdLq6BdLulNavOv23s88XcxZyVuGH3
 RZ23u30OgYoXOU4usICd4I0SbV
X-Received: by 2002:a05:6a00:22d4:b0:842:5ea5:5fdd with SMTP id
 d2e1a72fcca58-8479af8bb55mr148772b3a.40.1782734893824; 
 Mon, 29 Jun 2026 05:08:13 -0700 (PDT)
Received: from dev-template-2404.. ([192.19.252.250])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-845a40d23d7sm11718410b3a.30.2026.06.29.05.08.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 05:08:12 -0700 (PDT)
From: Samar Yadav <samaryadav5@gmail.com>
To: dev@dpdk.org
Cc: chenbox@nvidia.com, maxime.coquelin@redhat.com, stable@dpdk.org,
 stephen@networkplumber.org, tiwei.bie@intel.com,
 Samar Yadav <samaryadav5@gmail.com>
Subject: [PATCH v2] net/virtio-user: fix eventfd sharing in secondary process
Date: Mon, 29 Jun 2026 12:06:14 +0000
Message-ID: <20260629120615.2701697-1-samaryadav5@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260626080513.2371033-1-ysamar@vmware.com>
References: <20260626080513.2371033-1-ysamar@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 30 Jun 2026 15:24:27 +0200
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

virtio_user secondary processes cannot communicate with the vhost
backend: the kick/call eventfds are opened by the primary and never
shared, so a secondary's queue notification writes to an invalid fd
and traffic stalls.

Share the fds over a dedicated virtio-user multiprocess channel. The
primary registers a process-wide MP action that returns a port's
kick/call fds (looked up by port name); a secondary requests them at
probe time, before the port is announced.

The received fds are stored in eth_dev->process_private, which is
per-process, instead of the primary-owned shared dev->kickfds and
dev->callfds arrays; the secondary data path notifies the backend using
its own kickfd. In the primary, the MP handler reads the fd arrays under
dev->mutex, and the teardown path takes the same lock while closing and
freeing them, so the two cannot race.

Also fix the pre-existing pthread_mutex_init(&dev->mutex, NULL) call in
virtio_user_dev_init(): POSIX requires PTHREAD_PROCESS_SHARED for a mutex
stored in shared memory regardless of which processes actually lock it;
use rte_thread_mutex_init_shared() as other multiprocess-aware drivers do.

Fixes: 1c8489da561b ("net/virtio-user: fix multi-process support")
Cc: tiwei.bie@intel.com
Cc: stable@dpdk.org

Signed-off-by: Samar Yadav <samaryadav5@gmail.com>
---
v2:
- Use rte_calloc() instead of rte_malloc() for the kick/call fd arrays
  in virtio_user_sync_eventfds() so allocation failures are cleaner and
  unset entries are zero-initialised before the explicit -1 sentinel loop.
  (Stephen Hemminger)
- Fix the pre-existing pthread_mutex_init(&dev->mutex, NULL) call in
  virtio_user_dev_init() to use rte_thread_mutex_init_shared(), which
  sets PTHREAD_PROCESS_SHARED as POSIX requires for a mutex in shared
  memory. Add #include <rte_thread.h> to pull in the declaration.
  (Stephen Hemminger)

 .mailmap                                      |   1 +
 .../net/virtio/virtio_user/virtio_user_dev.c  |  59 +++-
 .../net/virtio/virtio_user/virtio_user_dev.h  |  20 ++
 drivers/net/virtio/virtio_user_ethdev.c       | 260 +++++++++++++++++-
 4 files changed, 335 insertions(+), 5 deletions(-)

diff --git a/.mailmap b/.mailmap
index 4001e5f..8f921d4 100644
--- a/.mailmap
+++ b/.mailmap
@@ -1448,6 +1448,7 @@ Salem Sol <salems@nvidia.com>
 Sam Andrew <samandrew@microsoft.com>
 Sam Chen <sam.chen@nebula-matrix.com>
 Sam Grove <sam.grove@sifive.com>
+Samar Yadav <samaryadav5@gmail.com> <samar.yadav@broadcom.com>
 Sameer Vaze <svaze@qti.qualcomm.com>
 Sameh Gobriel <sameh.gobriel@intel.com>
 Samik Gupta <samik.gupta@broadcom.com>
diff --git a/drivers/net/virtio/virtio_user/virtio_user_dev.c b/drivers/net/virtio/virtio_user/virtio_user_dev.c
index f3df73c..82a8cf4 100644
--- a/drivers/net/virtio/virtio_user/virtio_user_dev.c
+++ b/drivers/net/virtio/virtio_user/virtio_user_dev.c
@@ -15,6 +15,7 @@
 #include <sys/stat.h>
 
 #include <rte_alarm.h>
+#include <rte_thread.h>
 #include <rte_string_fns.h>
 #include <rte_eal_memconfig.h>
 #include <rte_malloc.h>
@@ -34,6 +35,54 @@ const char * const virtio_user_backend_strings[] = {
 	[VIRTIO_USER_BACKEND_VHOST_VDPA] = "VHOST_VDPA",
 };
 
+/*
+ * Collect the primary device's kick/call fds (interleaved kick,call per queue)
+ * for sharing with a secondary process. Caller must serialize against the
+ * control path (dev->mutex) so the fd arrays are not freed concurrently.
+ */
+int
+virtio_user_get_eventfds_from_dev(struct virtio_user_dev *dev,
+				 int fds[VIRTIO_USER_MAX_EVENTFDS])
+{
+	uint32_t max_queues;
+	int i, total_fds = 0;
+	int kickfd, callfd;
+
+	if (dev == NULL || fds == NULL)
+		return -EINVAL;
+
+	if (dev->kickfds == NULL || dev->callfds == NULL) {
+		PMD_INIT_LOG(ERR, "Device eventfd arrays not initialized");
+		return -EINVAL;
+	}
+
+	max_queues = dev->max_queue_pairs * 2;
+	if (dev->hw_cvq)
+		max_queues += 1;
+
+	/* each queue contributes a kick and a call fd */
+	if (max_queues * 2 > VIRTIO_USER_MAX_EVENTFDS) {
+		PMD_INIT_LOG(ERR,
+			     "Device needs %u eventfds, exceeds MP limit %d",
+			     max_queues * 2, VIRTIO_USER_MAX_EVENTFDS);
+		return -E2BIG;
+	}
+
+	for (i = 0; i < (int)max_queues; i++) {
+		kickfd = dev->kickfds[i];
+		callfd = dev->callfds[i];
+		if (kickfd < 0 || callfd < 0) {
+			PMD_INIT_LOG(ERR, "Queue %d has invalid fds (kick=%d call=%d)",
+				     i, kickfd, callfd);
+			return -EINVAL;
+		}
+		fds[total_fds++] = kickfd;
+		fds[total_fds++] = callfd;
+	}
+
+	return total_fds;
+}
+
 static int
 virtio_user_uninit_notify_queue(struct virtio_user_dev *dev, uint32_t queue_sel)
 {
@@ -733,7 +782,7 @@ virtio_user_dev_init(struct virtio_user_dev *dev, char *path, uint16_t queues,
 {
 	uint64_t backend_features;
 
-	pthread_mutex_init(&dev->mutex, NULL);
+	rte_thread_mutex_init_shared(&dev->mutex);
 	strlcpy(dev->path, path, PATH_MAX);
 
 	dev->started = 0;
@@ -865,9 +914,15 @@ virtio_user_dev_uninit(struct virtio_user_dev *dev)
 
 	rte_mem_event_callback_unregister(VIRTIO_USER_MEM_EVENT_CLB_NAME, dev);
 
+	/*
+	 * Serialize closing/freeing the kick/call fd arrays against the MP
+	 * handler, which reads them under the same lock to share them with
+	 * secondary processes.
+	 */
+	pthread_mutex_lock(&dev->mutex);
 	virtio_user_dev_uninit_notify(dev);
-
 	virtio_user_free_vrings(dev);
+	pthread_mutex_unlock(&dev->mutex);
 
 	free(dev->ifname);
 
diff --git a/drivers/net/virtio/virtio_user/virtio_user_dev.h b/drivers/net/virtio/virtio_user/virtio_user_dev.h
index 66400b3..1a7334d 100644
--- a/drivers/net/virtio/virtio_user/virtio_user_dev.h
+++ b/drivers/net/virtio/virtio_user/virtio_user_dev.h
@@ -11,6 +11,11 @@
 #include "../virtio.h"
 #include "../virtio_ring.h"
 
+#include <rte_eal.h>
+
+/* Max eventfds shareable over the MP channel (bounded by SCM_RIGHTS). */
+#define VIRTIO_USER_MAX_EVENTFDS RTE_MP_MAX_FD_NUM
+
 enum virtio_user_backend_type {
 	VIRTIO_USER_BACKEND_UNKNOWN,
 	VIRTIO_USER_BACKEND_VHOST_USER,
@@ -89,5 +94,20 @@ int virtio_user_dev_get_rss_config(struct virtio_user_dev *dev, void *dst, size_
 				   int length);
 void virtio_user_dev_delayed_disconnect_handler(void *param);
 int virtio_user_dev_server_reconnect(struct virtio_user_dev *dev);
+
+/**
+ * Collect a primary device's kick/call eventfds for sharing with a
+ * secondary process over the multiprocess channel.
+ *
+ * @param dev
+ *   Pointer to the virtio_user device (primary).
+ * @param fds
+ *   Output array, must hold at least VIRTIO_USER_MAX_EVENTFDS elements.
+ * @return
+ *   Number of fds written on success, negative errno on error.
+ */
+int virtio_user_get_eventfds_from_dev(struct virtio_user_dev *dev,
+				     int fds[VIRTIO_USER_MAX_EVENTFDS]);
+
 extern const char * const virtio_user_backend_strings[];
 #endif
diff --git a/drivers/net/virtio/virtio_user_ethdev.c b/drivers/net/virtio/virtio_user_ethdev.c
index 747ddde..9817142 100644
--- a/drivers/net/virtio/virtio_user_ethdev.c
+++ b/drivers/net/virtio/virtio_user_ethdev.c
@@ -27,6 +27,35 @@
 #include "virtio_rxtx.h"
 #include "virtio_user/virtio_user_dev.h"
 #include "virtio_user/vhost.h"
+#include <errno.h>
+#include <rte_errno.h>
+#include <rte_string_fns.h>
+#include <rte_spinlock.h>
+
+/* Virtio-user multiprocess communication channel */
+#define VIRTIO_USER_MP_NAME "virtio_user_mp"
+
+struct virtio_user_mp_param {
+	char port_name[RTE_DEV_NAME_MAX_LEN];
+};
+
+/*
+ * Per-process private data, referenced by eth_dev->process_private which (unlike
+ * dev_private) is NOT shared between primary and secondary processes. A secondary
+ * stores the kick/call fds it receives from the primary here, so it never mutates
+ * the primary-owned shared dev->kickfds/dev->callfds arrays. callfds are kept for
+ * a complete per-process view of the backend fds; only kickfds are used by the
+ * secondary data path today.
+ */
+struct virtio_user_proc_priv {
+	uint32_t nr_queues;
+	int *kickfds;
+	int *callfds;
+};
+
+/* Guards one-time registration of the process-wide MP action. */
+static rte_spinlock_t virtio_user_mp_lock = RTE_SPINLOCK_INITIALIZER;
+static bool virtio_user_mp_registered;
 
 #define virtio_user_get_dev(hwp) container_of(hwp, struct virtio_user_dev, hw)
 
@@ -269,6 +298,26 @@ virtio_user_del_queue(struct virtio_hw *hw, struct virtqueue *vq)
 		virtio_user_dev_destroy_shadow_cvq(dev);
 }
 
+/*
+ * Return the kick fd to notify the backend for a queue in the running process.
+ * The secondary uses its own fds (process_private); the primary owns dev->kickfds.
+ */
+static int
+virtio_user_get_kickfd(struct virtio_hw *hw, struct virtio_user_dev *dev,
+		      uint16_t queue_idx)
+{
+	if (rte_eal_process_type() == RTE_PROC_SECONDARY) {
+		struct rte_eth_dev *eth_dev = &rte_eth_devices[hw->port_id];
+		struct virtio_user_proc_priv *pp = eth_dev->process_private;
+
+		if (pp == NULL || queue_idx >= pp->nr_queues)
+			return -1;
+		return pp->kickfds[queue_idx];
+	}
+
+	return dev->kickfds[queue_idx];
+}
+
 static void
 virtio_user_notify_queue(struct virtio_hw *hw, struct virtqueue *vq)
 {
@@ -282,8 +331,10 @@ virtio_user_notify_queue(struct virtio_hw *hw, struct virtqueue *vq)
 	}
 
 	if (!dev->notify_area) {
-		if (write(dev->kickfds[vq->vq_queue_index], &notify_data,
-			  sizeof(notify_data)) < 0)
+		int kickfd = virtio_user_get_kickfd(hw, dev, vq->vq_queue_index);
+
+		if (kickfd < 0 || write(kickfd, &notify_data,
+				sizeof(notify_data)) < 0)
 			PMD_DRV_LOG(ERR, "failed to kick backend: %s",
 				    strerror(errno));
 		return;
@@ -495,6 +546,166 @@ virtio_user_eth_dev_free(struct rte_eth_dev *eth_dev)
 	rte_eth_dev_release_port(eth_dev);
 }
 
+/* Close and free a secondary's per-process eventfd storage. */
+static void
+virtio_user_free_proc_priv(struct rte_eth_dev *eth_dev)
+{
+	struct virtio_user_proc_priv *pp = eth_dev->process_private;
+	uint32_t i;
+
+	if (pp == NULL)
+		return;
+
+	for (i = 0; i < pp->nr_queues; i++) {
+		if (pp->kickfds != NULL && pp->kickfds[i] >= 0)
+			close(pp->kickfds[i]);
+		if (pp->callfds != NULL && pp->callfds[i] >= 0)
+			close(pp->callfds[i]);
+	}
+
+	rte_free(pp->kickfds);
+	rte_free(pp->callfds);
+	rte_free(pp);
+	eth_dev->process_private = NULL;
+}
+
+/*
+ * Primary-side MP handler: reply with this port's kick/call eventfds so the
+ * requesting secondary can talk to the vhost backend. Always sends a reply
+ * (num_fds == 0 on error) so the secondary fails fast instead of timing out.
+ */
+static int
+virtio_user_mp_primary_handler(const struct rte_mp_msg *msg, const void *peer)
+{
+	const struct virtio_user_mp_param *param =
+		(const struct virtio_user_mp_param *)msg->param;
+	int eventfds[VIRTIO_USER_MAX_EVENTFDS];
+	struct rte_eth_dev *eth_dev;
+	struct virtio_user_dev *dev;
+	struct rte_mp_msg reply;
+	int num_fds;
+	int i;
+
+	memset(&reply, 0, sizeof(reply));
+	strlcpy(reply.name, msg->name, sizeof(reply.name));
+	reply.len_param = 0;
+	reply.num_fds = 0;
+
+	eth_dev = rte_eth_dev_get_by_name(param->port_name);
+	if (eth_dev == NULL || eth_dev->data->dev_private == NULL) {
+		PMD_INIT_LOG(ERR, "Failed to find virtio_user port: %s",
+			     param->port_name);
+		return rte_mp_reply(&reply, peer);
+	}
+
+	dev = eth_dev->data->dev_private;
+
+	/* serialize against control-path changes to the fd arrays */
+	pthread_mutex_lock(&dev->mutex);
+	num_fds = virtio_user_get_eventfds_from_dev(dev, eventfds);
+	if (num_fds >= 0 && num_fds <= RTE_MP_MAX_FD_NUM) {
+		reply.num_fds = num_fds;
+		for (i = 0; i < num_fds; i++)
+			reply.fds[i] = eventfds[i];
+	} else {
+		PMD_INIT_LOG(ERR, "Cannot share eventfds for %s (ret=%d)",
+			     param->port_name, num_fds);
+	}
+	pthread_mutex_unlock(&dev->mutex);
+
+	return rte_mp_reply(&reply, peer);
+}
+
+/*
+ * Secondary-side: request the primary's kick/call eventfds and store them in
+ * this process's eth_dev->process_private. The shared dev->kickfds/dev->callfds
+ * arrays (owned by the primary) are never touched.
+ */
+static int
+virtio_user_sync_eventfds(struct rte_eth_dev *eth_dev, struct virtio_user_dev *dev)
+{
+	struct rte_mp_msg mp_req, *mp_rep;
+	struct rte_mp_reply mp_reply = {0};
+	struct virtio_user_mp_param *req_param;
+	struct timespec ts = {.tv_sec = 5, .tv_nsec = 0};
+	struct virtio_user_proc_priv *pp;
+	uint32_t total_queues, i;
+	int nr_fds, ret = 0;
+
+	if (dev == NULL)
+		return -EINVAL;
+
+	if (rte_eal_process_type() != RTE_PROC_SECONDARY)
+		return -EINVAL;
+
+	total_queues = dev->max_queue_pairs * 2 + (dev->hw_cvq ? 1 : 0);
+
+	pp = rte_zmalloc("virtio_user_proc_priv", sizeof(*pp), 0);
+	if (pp == NULL)
+		return -ENOMEM;
+
+	pp->kickfds = rte_calloc("virtio_user_proc_priv",
+				 total_queues, sizeof(int), 0);
+	pp->callfds = rte_calloc("virtio_user_proc_priv",
+				 total_queues, sizeof(int), 0);
+	if (pp->kickfds == NULL || pp->callfds == NULL) {
+		ret = -ENOMEM;
+		goto err_free;
+	}
+	for (i = 0; i < total_queues; i++) {
+		pp->kickfds[i] = -1;
+		pp->callfds[i] = -1;
+	}
+
+	memset(&mp_req, 0, sizeof(mp_req));
+	req_param = (struct virtio_user_mp_param *)mp_req.param;
+	strlcpy(req_param->port_name, eth_dev->data->name,
+		sizeof(req_param->port_name));
+	strlcpy(mp_req.name, VIRTIO_USER_MP_NAME, RTE_MP_MAX_NAME_LEN);
+	mp_req.len_param = sizeof(*req_param);
+	mp_req.num_fds = 0;
+
+	if (rte_mp_request_sync(&mp_req, &mp_reply, &ts) < 0 ||
+	    mp_reply.nb_received != 1) {
+		PMD_INIT_LOG(ERR, "Failed to request eventfds from primary");
+		free(mp_reply.msgs);
+		ret = -EIO;
+		goto err_free;
+	}
+
+	mp_rep = &mp_reply.msgs[0];
+	nr_fds = mp_rep->num_fds;
+
+	/* a partially-synced device cannot work: treat any mismatch as fatal */
+	if (nr_fds != (int)total_queues * 2) {
+		PMD_INIT_LOG(ERR, "Expected %u eventfds, received %d",
+			     total_queues * 2, nr_fds);
+		for (i = 0; i < (uint32_t)nr_fds; i++)
+			close(mp_rep->fds[i]);
+		free(mp_reply.msgs);
+		ret = -EPROTO;
+		goto err_free;
+	}
+
+	for (i = 0; i < total_queues; i++) {
+		pp->kickfds[i] = mp_rep->fds[i * 2];
+		pp->callfds[i] = mp_rep->fds[i * 2 + 1];
+	}
+	pp->nr_queues = total_queues;
+	free(mp_reply.msgs);
+
+	eth_dev->process_private = pp;
+	PMD_INIT_LOG(DEBUG, "Synced %u queue eventfds for secondary port %s",
+		     total_queues, eth_dev->data->name);
+	return 0;
+
+err_free:
+	rte_free(pp->kickfds);
+	rte_free(pp->callfds);
+	rte_free(pp);
+	return ret;
+}
+
 /* Dev initialization routine. Invoked once for each virtio vdev at
  * EAL init time, see rte_bus_probe().
  * Returns 0 on success.
@@ -542,6 +753,17 @@ virtio_user_pmd_probe(struct rte_vdev_device *vdev)
 
 		eth_dev->dev_ops = &virtio_user_secondary_eth_dev_ops;
 		eth_dev->device = &vdev->device;
+
+		/* populate this process's eventfds before announcing the port */
+		ret = virtio_user_sync_eventfds(eth_dev, dev);
+		if (ret < 0) {
+			PMD_INIT_LOG(ERR,
+				     "Failed to sync eventfds in secondary: %d",
+				     ret);
+			rte_eth_dev_release_port(eth_dev);
+			return ret;
+		}
+
 		rte_eth_dev_probing_finish(eth_dev);
 		return 0;
 	}
@@ -722,6 +944,36 @@ virtio_user_pmd_probe(struct rte_vdev_device *vdev)
 		}
 	}
 
+	/*
+	 * Register the process-wide MP action once so secondaries can fetch a
+	 * port's eventfds by name. It is intentionally left registered for the
+	 * lifetime of the process (cleaned up at exit): unregistering per device
+	 * cannot drain handler calls already dispatched on the EAL MP thread.
+	 */
+	rte_spinlock_lock(&virtio_user_mp_lock);
+	if (!virtio_user_mp_registered) {
+		ret = rte_mp_action_register(VIRTIO_USER_MP_NAME,
+					     virtio_user_mp_primary_handler);
+		if (ret < 0 && rte_errno != EEXIST) {
+			rte_spinlock_unlock(&virtio_user_mp_lock);
+			if (rte_errno == ENOTSUP) {
+				PMD_INIT_LOG(WARNING,
+					"MP unsupported, secondary eventfd sharing disabled");
+				rte_eth_dev_probing_finish(eth_dev);
+				ret = 0;
+				goto end;
+			}
+			PMD_INIT_LOG(ERR, "Failed to register MP handler: %s",
+				     strerror(rte_errno));
+			virtio_user_dev_uninit(dev);
+			virtio_user_eth_dev_free(eth_dev);
+			ret = -1;
+			goto end;
+		}
+		virtio_user_mp_registered = true;
+	}
+	rte_spinlock_unlock(&virtio_user_mp_lock);
+
 	rte_eth_dev_probing_finish(eth_dev);
 	ret = 0;
 
@@ -749,8 +1001,10 @@ virtio_user_pmd_remove(struct rte_vdev_device *vdev)
 	if (!eth_dev)
 		return 0;
 
-	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
+	if (rte_eal_process_type() != RTE_PROC_PRIMARY) {
+		virtio_user_free_proc_priv(eth_dev);
 		return rte_eth_dev_release_port(eth_dev);
+	}
 
 	/* make sure the device is stopped, queues freed */
 	return rte_eth_dev_close(eth_dev->data->port_id);
-- 
2.43.0

