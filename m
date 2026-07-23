Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D224FC531F7
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Jul 2026 15:31:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D356840663;
	Thu, 23 Jul 2026 17:31:23 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 7BA0340280
 for <dev@dpdk.org>; Thu, 23 Jul 2026 17:31:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784820680;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=40F8/GFJsJu/pIEsyPaUJmkRZ2VhUkcUuO79ZA0b3Og=;
 b=hGBv1pcTlRmiuj/HaCUGSWBg0Gr5Vezr4sS3e88A2eapqym7JxiPbMaO6ikKneIbgZH+L5
 8RjzS6RO3rHWj6NEANPODPS4Tp050zU8tqCCso/OoraqodCX2ykYbzwus+MHkOexJx+NG8
 qbCir7sSl4FbIsW6U4yV4LKKflkoY2Q=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-497-90vx02QePb68UPI2qUiHsg-1; Thu,
 23 Jul 2026 11:31:18 -0400
X-MC-Unique: 90vx02QePb68UPI2qUiHsg-1
X-Mimecast-MFC-AGG-ID: 90vx02QePb68UPI2qUiHsg_1784820677
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 91BFA182FA3E
 for <dev@dpdk.org>; Thu, 23 Jul 2026 15:31:17 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.48.202])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 72C35195605A; Thu, 23 Jul 2026 15:31:15 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: maxime.coquelin@redhat.com,
	dev@dpdk.org
Subject: [RFC 0/3] Drop vhost async (DMA-accelerated) datapath
Date: Thu, 23 Jul 2026 17:31:07 +0200
Message-ID: <20260723153111.3943368-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: E8f8Yirx3cAIfHy3hOITgfqdPt8MSF6a3psfLXDRDA8_1784820677
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

The integration of this feature in OVS has been postponed following
feedback how the current API forced the complexity on the application
side. There is no contributor working on making those changes.

The feature has no other identified opensource consumer.

On the other hand, this feature has been left unattended for some years
now while the "normal" datapath is actively maintained.
It is highly likely the async datapath code, which never underwent a
stabilisation phase, is riddled with bugs.

Given the craziness around finding security bugs with AI,
and since the vhost library is a good target, I propose to drop
this feature and reduce the library attack surface.


-- 
David Marchand

David Marchand (3):
  examples: stop using vhost async datapath
  vhost: refuse async datapath
  vhost: drop async datapath

 doc/guides/prog_guide/vhost_lib.rst    |  151 +-
 doc/guides/rel_notes/release_26_11.rst |   20 +
 examples/vhost/Makefile                |    2 -
 examples/vhost/main.c                  |  436 +---
 examples/vhost/main.h                  |   21 +-
 examples/vhost/meson.build             |    2 -
 examples/vhost_crypto/Makefile         |    1 -
 examples/vhost_crypto/main.c           |    3 +-
 examples/vhost_crypto/meson.build      |    1 -
 lib/vhost/meson.build                  |    3 +-
 lib/vhost/rte_vhost.h                  |    2 +-
 lib/vhost/rte_vhost_async.h            |  293 ---
 lib/vhost/socket.c                     |   27 +-
 lib/vhost/vhost.c                      |  434 ----
 lib/vhost/vhost.h                      |  115 -
 lib/vhost/vhost_user.c                 |  215 +-
 lib/vhost/virtio_net.c                 | 3275 +++++-------------------
 17 files changed, 708 insertions(+), 4293 deletions(-)
 delete mode 100644 lib/vhost/rte_vhost_async.h

-- 
2.54.0

