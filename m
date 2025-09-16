Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8F18CAC598
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Sep 2025 09:36:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 00899402E3;
	Tue, 16 Sep 2025 11:36:05 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 2ADAE402E0
 for <dev@dpdk.org>; Tue, 16 Sep 2025 11:36:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758015363;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V/O5jNlIkDxx+W2x5GeLGyV5poEQIdNcH6Rcqz2x1Qc=;
 b=S7xDqYI6a0jvso5699Hk8WFuYQg0coDbI+mJagKXDlwBpDRMFvNHXhl7P2FsuFOKa60cMH
 iCDsSVM+4Sk7BqjT4vT8ht37S+e8a5Ilm+Fl9jIMjfzzqKYOIUSY6V0g7TY6j2IWq3x8lJ
 62wOqlI8jgBoJwoe/fPAPfBqSno1HKA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-270-K_u6aKhSM1io4L_ji-I5kA-1; Tue,
 16 Sep 2025 05:36:01 -0400
X-MC-Unique: K_u6aKhSM1io4L_ji-I5kA-1
X-Mimecast-MFC-AGG-ID: K_u6aKhSM1io4L_ji-I5kA_1758015361
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D93BF195608C; Tue, 16 Sep 2025 09:36:00 +0000 (UTC)
Received: from max-p1.redhat.com (unknown [10.45.242.14])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EEE501800446; Tue, 16 Sep 2025 09:35:58 +0000 (UTC)
From: Maxime Coquelin <maxime.coquelin@redhat.com>
To: dev@dpdk.org,
	david.marchand@redhat.com,
	chenbox@nvidia.com
Cc: Maxime Coquelin <maxime.coquelin@redhat.com>,
	stable@dpdk.org
Subject: [PATCH v2 2/2] vhost: fix uninitialized VQ info in VDUSE vring setup
Date: Tue, 16 Sep 2025 11:35:50 +0200
Message-ID: <20250916093550.1345901-3-maxime.coquelin@redhat.com>
In-Reply-To: <20250916093550.1345901-1-maxime.coquelin@redhat.com>
References: <20250916093550.1345901-1-maxime.coquelin@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: YiKd8vI6uN-ot-tlyB5vmv6AXJ_TDvts2IlQVazMM8I_1758015361
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

Initialize vduse_vq_info structure to zero to avoid using
uninitialized memory when setting up VDUSE virtual rings.
This ensures all fields start with known values.

Fixes: a9120db8b98b ("vhost: add VDUSE device startup")
Cc: stable@dpdk.org

Reported-by: David Marchand <david.marchand@redhat.com>
Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
---
 lib/vhost/vduse.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/vhost/vduse.c b/lib/vhost/vduse.c
index 422c4ab8f3..6f286c2963 100644
--- a/lib/vhost/vduse.c
+++ b/lib/vhost/vduse.c
@@ -141,7 +141,7 @@ vduse_vring_setup(struct virtio_net *dev, unsigned int index, bool reconnect)
 {
 	struct vhost_virtqueue *vq = dev->virtqueue[index];
 	struct vhost_vring_addr *ra = &vq->ring_addrs;
-	struct vduse_vq_info vq_info;
+	struct vduse_vq_info vq_info = { 0 };
 	struct vduse_vq_eventfd vq_efd;
 	int ret;
 
-- 
2.51.0

