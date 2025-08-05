Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4026BC87FD1
	for <dpdk-dev@archiver.kernel.org>; Tue,  5 Aug 2025 08:37:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 32AC140DD1;
	Tue,  5 Aug 2025 10:37:12 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 2502640DD1
 for <dev@dpdk.org>; Tue,  5 Aug 2025 10:37:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754383030;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=12HWIUGwO+1kWiNasqzqlFmLLzWXLTBSoHOE/o1GfNE=;
 b=KJ/GZXPK7SDWIhx5T4Vv8OeLf/TW2OpcoKjesMGKXFsJr2zNyluWByd64E3p5DqSbJKM7Y
 b51cTTR07Ip/lGVGQmAvtnYXfZOvDSqfhyvSTzkMpPc2kuzyDRgku3sP+yx5II0avtQ9+7
 xW3Ivqkv7Lt1TEYYTna46IMf5vqzoO4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-116-ZHpjQglKMkaU-4lvvoYMSw-1; Tue,
 05 Aug 2025 04:37:07 -0400
X-MC-Unique: ZHpjQglKMkaU-4lvvoYMSw-1
X-Mimecast-MFC-AGG-ID: ZHpjQglKMkaU-4lvvoYMSw_1754383026
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6716B19560B4; Tue,  5 Aug 2025 08:37:06 +0000 (UTC)
Received: from max-p1.redhat.com (unknown [10.44.22.6])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 90EC31800B65; Tue,  5 Aug 2025 08:37:02 +0000 (UTC)
From: Maxime Coquelin <maxime.coquelin@redhat.com>
To: dev@dpdk.org, amorenoz@redhat.com, chenbox@nvidia.com,
 david.marchand@redhat.com
Cc: schalla@marvell.com, Maxime Coquelin <maxime.coquelin@redhat.com>,
 stable@dpdk.org
Subject: [PATCH] net/virtio-user: fix used ring address calculation
Date: Tue,  5 Aug 2025 10:36:57 +0200
Message-ID: <20250805083657.1227817-1-maxime.coquelin@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: CNxTNyDaI60-QS2IcnrrkIZAbNg6Y749PyAICGkSrcs_1754383026
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

This patch fixes the used ring address calculation, to
avoid Vhost-vDPA backends (such as VDUSE) to fail while
trying to translate it.

Fixes: 666ef294ddf7 ("net/virtio-user: share descriptor IOVA to backend")
Cc: stable@dpdk.org

Reported-by: Adrian Moreno <amorenoz@redhat.com>
Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
---
 drivers/net/virtio/virtio_user/virtio_user_dev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/virtio/virtio_user/virtio_user_dev.c b/drivers/net/virtio/virtio_user/virtio_user_dev.c
index 187f81b066..7789f337f6 100644
--- a/drivers/net/virtio/virtio_user/virtio_user_dev.c
+++ b/drivers/net/virtio/virtio_user/virtio_user_dev.c
@@ -149,7 +149,8 @@ virtio_user_kick_queue(struct virtio_user_dev *dev, uint32_t queue_sel)
 	} else {
 		desc_addr = vring->desc_iova;
 		avail_addr = desc_addr + vring->num * sizeof(struct vring_desc);
-		used_addr = RTE_ALIGN_CEIL((uintptr_t)(&vring->avail->ring[vring->num]),
+		used_addr = RTE_ALIGN_CEIL(avail_addr + offsetof(struct vring_avail,
+						ring[vring->num]),
 					   VIRTIO_VRING_ALIGN);
 
 		addr.desc_user_addr = desc_addr;
-- 
2.50.1

