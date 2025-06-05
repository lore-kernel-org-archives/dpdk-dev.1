Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D30F4C5AE59
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Jun 2025 11:36:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 083F240654;
	Thu,  5 Jun 2025 13:36:05 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id B5F3D40616
 for <dev@dpdk.org>; Thu,  5 Jun 2025 13:36:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749123363;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=698bsvRbrbV6RdM7HlJdGPS+vZSC7vqHYcWiakVoMgM=;
 b=BfwbNN7cy8mtyAqpx2jyk6IId69Rkglvqepv5c06+PwY/CCBBnSZRvUw+2PmsDSBtkb1kz
 Uw+K9NViU6xXuG13R3eITf4xImC3wjttd0WRi7viluGJGjggxiSwriRbZdv7CsJlyuH8GH
 oG3Z96N82ZICwUo7+qyGbeCxXrkPssQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-592-GjMye08VMsqty9MK7_216w-1; Thu,
 05 Jun 2025 07:35:57 -0400
X-MC-Unique: GjMye08VMsqty9MK7_216w-1
X-Mimecast-MFC-AGG-ID: GjMye08VMsqty9MK7_216w_1749123356
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6EA701800871; Thu,  5 Jun 2025 11:35:56 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.224.24])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3C2B4195E74E; Thu,  5 Jun 2025 11:35:53 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: dev@dpdk.org
Cc: Chenbo Xia <chenbox@nvidia.com>, stable@dpdk.org,
 Maxime Coquelin <maxime.coquelin@redhat.com>
Subject: [PATCH 0/2] Search the split vq desc and avail in RO areas
Date: Thu,  5 Jun 2025 13:35:50 +0200
Message-ID: <20250605113552.918120-1-eperezma@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Lnr5cizlUAPuSA3kGeV8jDeLthBiGyUCmHUhAk6ygKU_1749123356
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
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

QEMU's shadow virtqueue and VDUSE exposes these areas as read-only. If
we don't change it, vhost_iova_to_vva do not consider them as valid and
returns that they're not found.

Eugenio Pérez (2):
  vhost: search the split vq desc and avail in RO areas
  vhost: search the packed vq driver area in RO areas

 lib/vhost/vhost.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

-- 
2.49.0

