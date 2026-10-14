Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB93FCC6B1A
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Oct 2026 16:31:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C477040272;
	Wed, 14 Oct 2026 18:31:55 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id E718B40144
 for <dev@dpdk.org>; Wed, 14 Oct 2026 18:31:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791995513;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=OaD7NqNJdKdW2xqnW6Brqw11Zf6efupgJ/h0q02xN/E=;
 b=Mqdqsd2zVXOUB5LZ5/FrK/lC2UtcObq0t/QwN9WMsJZDp4TmZ6TR0AktsAQdXVofQ0jR9R
 rIBfRNE9+Tz9fsFOiZvuwQTtdDB65grz6u+WK2AsDsrSEVTSRzlyrlkMj/r+xg6tF9ybXV
 MuFxlHHMfAXDVfNHOPBftvCwN7ICzSM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-247-g9wJ-fcJPeeHJa43xDT--A-1; Wed,
 14 Oct 2026 16:31:50 +0000
X-MC-Unique: g9wJ-fcJPeeHJa43xDT--A-1
X-Mimecast-MFC-AGG-ID: g9wJ-fcJPeeHJa43xDT--A_1791995509
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CDDDF1955F3D; Wed, 14 Oct 2026 16:31:48 +0000 (UTC)
Received: from dmarchan.redhat.corp
 (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 45AEA195608D; Wed, 14 Oct 2026 16:31:46 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: gmuthukrishn@marvell.com, gakhil@marvell.com,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>
Subject: [PATCH] vhost: make cryptodev support optional
Date: Wed, 14 Oct 2026 18:31:38 +0200
Message-ID: <20261014163138.1639970-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: uEYf7p0s2vCjzQrHcOiqWxMssXvRfMtzrAgauITMiEs_1791995509
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

The vhost crypto part has seen CVEs in the past and is getting a lot of
eyes those days.

Contrary to the vhost async datapath code, the cryptodev code seems to
have active contributors, so dropping this code does not seem a good
thing.

This change here allows to keep this support, yet disable it for
uninterested parties.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 lib/vhost/meson.build | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/lib/vhost/meson.build b/lib/vhost/meson.build
index 6a24981d10..93366a9609 100644
--- a/lib/vhost/meson.build
+++ b/lib/vhost/meson.build
@@ -30,7 +30,6 @@ sources = files(
         'vdpa.c',
         'vduse.c',
         'vhost.c',
-        'vhost_crypto.c',
         'vhost_user.c',
         'virtio_net.c',
         'virtio_net_ctrl.c',
@@ -39,9 +38,14 @@ headers = files(
         'rte_vdpa.h',
         'rte_vhost.h',
         'rte_vhost_async.h',
-        'rte_vhost_crypto.h',
 )
 driver_sdk_headers = files(
         'vdpa_driver.h',
 )
-deps += ['ethdev', 'cryptodev', 'hash', 'pci', 'dmadev']
+deps += ['ethdev', 'pci', 'dmadev']
+
+if dpdk_conf.has('RTE_LIB_CRYPTODEV')
+    sources += files('vhost_crypto.c')
+    headers += files('rte_vhost_crypto.h')
+    deps += ['cryptodev', 'hash']
+endif
-- 
2.54.0

