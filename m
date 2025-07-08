Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3308AC83F0A
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Jul 2025 14:23:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 521CD402A0;
	Tue,  8 Jul 2025 16:23:19 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 13DB24025E
 for <dev@dpdk.org>; Tue,  8 Jul 2025 16:23:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751984597;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=RT7K19Jp+UcCXuhtdBzmPfJv88i1rNGDFroTcvv8UKo=;
 b=ElLERWufecb1K5gVFmApbQ2fQoAk1ERGPbsKwOcIaqsrMUE57Yw/eaNNMUFKQSdlV2q018
 OgdwHYlJcPOyrVECj7jAWEV9DleFsAhtMQFJ9F1NzhMakXBGQE1CWxhGcKwXVKtDz4s0IW
 OfnkVrsfie8scq+5DC+OvEIn7UVOL9U=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-168-ewzQuXpIO62z9o8jIWgaiw-1; Tue,
 08 Jul 2025 10:23:16 -0400
X-MC-Unique: ewzQuXpIO62z9o8jIWgaiw-1
X-Mimecast-MFC-AGG-ID: ewzQuXpIO62z9o8jIWgaiw_1751984594
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6396C1956086; Tue,  8 Jul 2025 14:23:14 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.33.95])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4283C19560AB; Tue,  8 Jul 2025 14:23:09 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, stable@dpdk.org,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>, Hengqi Chen <hengqi.chen@gmail.com>,
 Baoyuan Li <updoing@sina.com>
Subject: [PATCH] net/virtio: revert Tx free threshold fix
Date: Tue,  8 Jul 2025 16:23:04 +0200
Message-ID: <20250708142305.3636707-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: h5pfKCZzK2seFUaW670wtQTQu64lDlC0SjFEkQiCiLM_1751984594
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

This fix introduced a performance regression.

The problem is under investigation, but we are too close to the release
(and the virtio/vhost maintainer is not available) to get a fix before
the v25.07 release.

Revert this change for now, we can revisit during v25.11.

Bugzilla ID: 1747
Fixes: 3e3c7f3fa5ac ("net/virtio: fix check of threshold for Tx freeing")
Cc: stable@dpdk.org

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 drivers/net/virtio/virtio_rxtx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/virtio/virtio_rxtx.c b/drivers/net/virtio/virtio_rxtx.c
index ab97f03d7d..edecd2011f 100644
--- a/drivers/net/virtio/virtio_rxtx.c
+++ b/drivers/net/virtio/virtio_rxtx.c
@@ -1873,7 +1873,7 @@ virtio_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 
 	nb_used = virtqueue_nused(vq);
 
-	if (likely(vq->vq_free_cnt < vq->vq_free_thresh))
+	if (likely(nb_used > vq->vq_nentries - vq->vq_free_thresh))
 		virtio_xmit_cleanup(vq, nb_used);
 
 	for (nb_tx = 0; nb_tx < nb_pkts; nb_tx++) {
-- 
2.50.0

