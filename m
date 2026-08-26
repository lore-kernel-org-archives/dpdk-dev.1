Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1122DC5DF97
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Aug 2026 14:02:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D769140279;
	Wed, 26 Aug 2026 16:02:26 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 656D740278
 for <dev@dpdk.org>; Wed, 26 Aug 2026 16:02:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787752944;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JzUW+VHuN8rJCXUw6Ax61R/g+fFPgNTAVwXBzlnxhOY=;
 b=PHsnCASjqbi3GBAJlnBSJoWL89mMj8yHpMdu6m+ehwF69FBAS/BveKFoLR4yzWuMbvXkFd
 EuWxnu1YDY0hcTSBOY4U5yViwotEyuQbCPnfc7LXmVk85JhyhKtceN1SOqg7ayieqcPocN
 rFln8FS9GSUV2tz5sboZp5n9hR9d0V8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-177-RMEHZvOONYy7-DHn-CIEqA-1; Wed,
 26 Aug 2026 10:02:22 -0400
X-MC-Unique: RMEHZvOONYy7-DHn-CIEqA-1
X-Mimecast-MFC-AGG-ID: RMEHZvOONYy7-DHn-CIEqA_1787752939
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A5E2E18E1318
 for <dev@dpdk.org>; Wed, 26 Aug 2026 14:02:11 +0000 (UTC)
Received: from dmarchan.home (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BDE8230002F1; Wed, 26 Aug 2026 14:02:10 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: maxime.coquelin@redhat.com,
	dev@dpdk.org
Subject: [PATCH 0/5] Drop vhost async (DMA-accelerated) datapath
Date: Wed, 26 Aug 2026 16:02:01 +0200
Message-ID: <20260826140206.1099433-1-david.marchand@redhat.com>
In-Reply-To: <20260723153111.3943368-1-david.marchand@redhat.com>
References: <20260723153111.3943368-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: E3JyIpyGZCcQQaE1ffLlklMv5s1Bt9eqkefz_0H1hC4_1787752939
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

There is one complication with the vhost_crypto and some external
applications that seemed to rely on the async flag to track and populate
guest pages, so a new flag replacing async is added by this series.


-- 
David Marchand

Changes since RFC:
- maintained guest pages population in a new flag (vhost_crypto/SPDK),
- removed remaining helpers which had sync_ in their names,


David Marchand (5):
  vhost: decouple guest pages population from async datapath
  examples/vhost: stop using async datapath
  vhost: drop async datapath
  vhost: rename packed layout helpers for batches
  vhost: simplify some descriptor handling

 doc/guides/prog_guide/vhost_lib.rst    |  152 +-
 doc/guides/rel_notes/release_26_11.rst |   20 +
 examples/vhost/Makefile                |    2 -
 examples/vhost/main.c                  |  436 +--
 examples/vhost/main.h                  |   21 +-
 examples/vhost/meson.build             |    2 -
 examples/vhost_crypto/Makefile         |    1 -
 examples/vhost_crypto/main.c           |    2 +-
 examples/vhost_crypto/meson.build      |    1 -
 lib/vhost/meson.build                  |    3 +-
 lib/vhost/rte_vhost.h                  |    2 +-
 lib/vhost/rte_vhost_async.h            |  293 ---
 lib/vhost/socket.c                     |   20 +-
 lib/vhost/vhost.c                      |  434 ---
 lib/vhost/vhost.h                      |  116 +-
 lib/vhost/vhost_user.c                 |  115 +-
 lib/vhost/virtio_net.c                 | 3343 +++++-------------------
 17 files changed, 736 insertions(+), 4227 deletions(-)
 delete mode 100644 lib/vhost/rte_vhost_async.h

-- 
2.54.0

