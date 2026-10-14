Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BBF4CC6B1A
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Oct 2026 15:02:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0286B40BA5;
	Wed, 14 Oct 2026 17:01:18 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 43B8040B95
 for <dev@dpdk.org>; Wed, 14 Oct 2026 17:01:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791990073;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dw1zvnSivvDDlSXl/YcfSvx1GwOpqAQVEEi8nVPoOn4=;
 b=DHIvzxaswpBu/nlt6m0sD5kbZf+IJlQ7sRlElTTKprV4u70hZW3JCG7RWlRg2m/78A5eCE
 a8bKkXnzlZ6BlBeYr6uPFHFubY8r3jGNDBQhES5jbOor8KcENgyfXb/dIMQrMv/u78h6Rd
 skaoByhwJThWZrwOhg6rAwVLxBcEt/U=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-619-xlS7PbJ0MmOXMUdivob7OQ-1; Wed,
 14 Oct 2026 15:01:08 +0000
X-MC-Unique: xlS7PbJ0MmOXMUdivob7OQ-1
X-Mimecast-MFC-AGG-ID: xlS7PbJ0MmOXMUdivob7OQ_1791990067
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D6FFE1800644; Wed, 14 Oct 2026 15:01:07 +0000 (UTC)
Received: from max-p1.redhat.corp (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BEC1E1800446; Wed, 14 Oct 2026 15:01:06 +0000 (UTC)
From: Maxime Coquelin <maxime.coquelin@redhat.com>
To: dev@dpdk.org
Cc: David Marchand <david.marchand@redhat.com>, stable@dpdk.org,
 Kevin Traynor <ktraynor@redhat.com>
Subject: [PATCH 10/14] vhost: check number of queues for VDPA
Date: Wed, 14 Oct 2026 17:00:45 +0200
Message-ID: <20261014150049.2540538-10-maxime.coquelin@redhat.com>
In-Reply-To: <20261014150049.2540538-1-maxime.coquelin@redhat.com>
References: <20261014150049.2540538-1-maxime.coquelin@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: QW-Kc8Y9ZlaqMnLvkfUOZTIXn_b4cjKc0RK8ROThevg_1791990067
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

From: David Marchand <david.marchand@redhat.com>

The vhost library was not enforcing any limit on the number of queue a
guest could allocate, which could result in out of bound accesses in the
driver or other nasty bugs.

CVE-2026-86856
Bugzilla ID: 2027

Fixes: 10421b0d9075 ("vdpa/nfp: add interrupt logic of vring relay")
Cc: stable@dpdk.org

Acked-by: Kevin Traynor <ktraynor@redhat.com>
Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 lib/vhost/vhost_user.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/lib/vhost/vhost_user.c b/lib/vhost/vhost_user.c
index 15f13ef443..6efe8fe860 100644
--- a/lib/vhost/vhost_user.c
+++ b/lib/vhost/vhost_user.c
@@ -3280,6 +3280,7 @@ vhost_user_check_and_alloc_queue_pair(struct virtio_net *dev,
 			struct vhu_msg_context *ctx)
 {
 	uint32_t vring_idx;
+	uint32_t queue_num;
 
 	switch (ctx->msg.request.frontend) {
 	case VHOST_USER_SET_VRING_KICK:
@@ -3303,7 +3304,12 @@ vhost_user_check_and_alloc_queue_pair(struct virtio_net *dev,
 		return 0;
 	}
 
-	if (vring_idx >= VHOST_MAX_VRING) {
+	if (rte_vhost_driver_get_queue_num(dev->ifname, &queue_num) < 0) {
+		VHOST_CONFIG_LOG(dev->ifname, ERR, "failed to get queue num");
+		return -1;
+	}
+
+	if (vring_idx >= queue_num * 2) {
 		VHOST_CONFIG_LOG(dev->ifname, ERR, "invalid vring index: %u", vring_idx);
 		return -1;
 	}
-- 
2.56.0

