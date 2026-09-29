Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 552DACA5FA1
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 10:54:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 025BB4279F;
	Tue, 29 Sep 2026 12:54:08 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id AB33341132
 for <dev@dpdk.org>; Tue, 29 Sep 2026 12:54:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790679245;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0r8ejS4tG8C41E+9uw2ruExFAivAAe/qJ+kPLlxUNY4=;
 b=Ul2jPzY3mOwGC8+XB96TsNyrD+BCOyfGeMqrfRS9FWUZaCRQsoWa1vrlBXlvG6mFYYjMmf
 sV3lJspdwxd6KPiYKnz9ckvCTIZeiv12Z/4dEcGW5UQiDuUNNhPgyZvr38R8g8BKGL0VT4
 XJcYOFFkhZuKfgdOh5jWxYVN+DQkXyU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-26-EnzICLmYNhq7KkLQHjijUQ-1; Tue,
 29 Sep 2026 06:54:01 -0400
X-MC-Unique: EnzICLmYNhq7KkLQHjijUQ-1
X-Mimecast-MFC-AGG-ID: EnzICLmYNhq7KkLQHjijUQ_1790679240
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 95323195605C; Tue, 29 Sep 2026 10:54:00 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.48.139])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 53F4B30000E4; Tue, 29 Sep 2026 10:53:56 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: mst@redhat.com, david.marchand@redhat.com, dev@dpdk.org,
 Yongji Xie <xieyongji@bytedance.com>, chenbox@nvidia.com,
 Bruce Richardson <bruce.richardson@intel.com>,
 Stephen Hemminger <stephen@networkplumber.org>, jasowangio@gmail.com
Subject: [PATCH v3 4/9] vhost: add virtqueues groups support to VDUSE
Date: Tue, 29 Sep 2026 12:53:34 +0200
Message-ID: <20260929105339.1554051-5-eperezma@redhat.com>
In-Reply-To: <20260929105339.1554051-1-eperezma@redhat.com>
References: <20260929105339.1554051-1-eperezma@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: xrROSL9t3m26p5Is6p_fG9fKFxj2wbJ9suiSH0192co_1790679240
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

From: Maxime Coquelin <maxime.coquelin@redhat.com>

VDUSE API version 1 introduces the notion of virtqueue
groups, which once supported, enables the support of
multiple addresses spaces.

For VDUSE networking devices, we need two groups, one for
the datapath queues, and one for the control queue.

Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
 lib/vhost/vduse.c | 52 +++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 50 insertions(+), 2 deletions(-)

diff --git a/lib/vhost/vduse.c b/lib/vhost/vduse.c
index ceef207ad2df..8c031168bf77 100644
--- a/lib/vhost/vduse.c
+++ b/lib/vhost/vduse.c
@@ -38,12 +38,24 @@ static const char * const vduse_reqs_str[] = {
 	"VDUSE_GET_VQ_STATE",
 	"VDUSE_SET_STATUS",
 	"VDUSE_UPDATE_IOTLB",
+	"VDUSE_SET_VQ_GROUP_ASID",
 };
 
 #define vduse_req_id_to_str(id) \
 	(id < RTE_DIM(vduse_reqs_str) ? \
 	vduse_reqs_str[id] : "Unknown")
 
+static uint64_t vduse_vq_to_group(struct virtio_net *dev, struct vhost_virtqueue *vq)
+{
+	if (dev->vduse_api_ver < 1)
+		return 0;
+
+	if (vq == dev->cvq)
+		return 1;
+
+	return 0;
+}
+
 static int
 vduse_inject_irq(struct virtio_net *dev, struct vhost_virtqueue *vq)
 {
@@ -271,6 +283,7 @@ vduse_vring_cleanup(struct virtio_net *dev, unsigned int index)
 	vq->size = 0;
 	vq->last_used_idx = 0;
 	vq->last_avail_idx = 0;
+	vq->asid = 0;
 }
 
 /*
@@ -410,6 +423,7 @@ vduse_events_handler(int fd, void *arg, int *close __rte_unused)
 	struct vduse_dev_response resp;
 	struct vhost_virtqueue *vq;
 	uint8_t old_status = dev->status;
+	uint32_t i;
 	int ret;
 
 	memset(&resp, 0, sizeof(resp));
@@ -450,6 +464,34 @@ vduse_events_handler(int fd, void *arg, int *close __rte_unused)
 				req.iova.last - req.iova.start + 1);
 		resp.result = VDUSE_REQ_RESULT_OK;
 		break;
+	case VDUSE_SET_VQ_GROUP_ASID:
+		if (dev->vduse_api_ver < 1) {
+			resp.result = VDUSE_REQ_RESULT_FAILED;
+			break;
+		}
+
+		if (req.vq_group_asid.asid >= RTE_DIM(dev->iotlb)) {
+			VHOST_CONFIG_LOG(dev->ifname, ERR,
+				"Invalid ASID %u for group %u",
+				req.vq_group_asid.asid, req.vq_group_asid.group);
+			resp.result = VDUSE_REQ_RESULT_FAILED;
+			break;
+		}
+
+		VHOST_CONFIG_LOG(dev->ifname, INFO, "\tAssigning ASID %d to group %d",
+				req.vq_group_asid.asid, req.vq_group_asid.group);
+
+		for (i = 0; i < dev->nr_vring; i++) {
+			vq = dev->virtqueue[i];
+
+			if (vduse_vq_to_group(dev, vq) == req.vq_group_asid.group) {
+				vq->asid = req.vq_group_asid.asid;
+				VHOST_CONFIG_LOG(dev->ifname, INFO, "\t\tVQ %d gets ASID %d",
+						i, req.vq_group_asid.asid);
+			}
+		}
+		resp.result = VDUSE_REQ_RESULT_OK;
+		break;
 	default:
 		resp.result = VDUSE_REQ_RESULT_FAILED;
 		break;
@@ -760,6 +802,10 @@ vduse_device_create(const char *path, bool compliant_ol_flags, bool extbuf, bool
 		dev_config->features = features;
 		dev_config->vq_num = total_queues;
 		dev_config->vq_align = rte_mem_page_size();
+		if (ver >= 1) {
+			dev_config->ngroups = 2;
+			dev_config->nas = 2;
+		}
 		dev_config->config_size = sizeof(struct virtio_net_config);
 		memcpy(dev_config->config, &vnet_config, sizeof(vnet_config));
 
@@ -848,11 +894,15 @@ vduse_device_create(const char *path, bool compliant_ol_flags, bool extbuf, bool
 		vq = dev->virtqueue[i];
 		vq->reconnect_log = &dev->reconnect_log->vring[i];
 
+		if (i == max_queue_pairs * 2)
+			dev->cvq = vq;
+
 		if (reconnect)
 			continue;
 
 		vq_cfg.index = i;
 		vq_cfg.max_size = 1024;
+		vq_cfg.group = vduse_vq_to_group(dev, vq);
 
 		ret = ioctl(dev->vduse_dev_fd, VDUSE_VQ_SETUP, &vq_cfg);
 		if (ret) {
@@ -861,8 +911,6 @@ vduse_device_create(const char *path, bool compliant_ol_flags, bool extbuf, bool
 		}
 	}
 
-	dev->cvq = dev->virtqueue[max_queue_pairs * 2];
-
 	ret = fdset_add(vduse.fdset, dev->vduse_dev_fd, vduse_events_handler, NULL, dev);
 	if (ret) {
 		VHOST_CONFIG_LOG(name, ERR, "Failed to add fd %d to vduse fdset",
-- 
2.55.0

