Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0977DC624DE
	for <dpdk-dev@archiver.kernel.org>; Fri,  4 Sep 2026 07:47:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 20E594279D;
	Fri,  4 Sep 2026 09:47:00 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 85A0D40297
 for <dev@dpdk.org>; Fri,  4 Sep 2026 09:46:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788508017;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0e4OdoGYm1Am8iGerT0o1GUSTdVdEvz+bTsAq/vPhvw=;
 b=Ux6SfBMrGJTxoI0H3KF5X5UaPzY+PQpKNmBHoF61is5cyfJFRaus7Ashj2RieFlvLsvsBH
 koMl1o7CzcNYwCY9PtPQo8iWibqZBW9gj4WMPwHZp12ZYy9iNEUU4ozeYpB9wD4CrFCoaz
 gh7BgirT2sFsyxqJNeUWAtQ+ASxeHk0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-399-gmP5uuOlNt2EAV1z9gOMmw-1; Fri,
 04 Sep 2026 03:46:54 -0400
X-MC-Unique: gmP5uuOlNt2EAV1z9gOMmw-1
X-Mimecast-MFC-AGG-ID: gmP5uuOlNt2EAV1z9gOMmw_1788508013
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 95FF118D62E2; Fri,  4 Sep 2026 07:46:53 +0000 (UTC)
Received: from dmarchan.home (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7ED1F1800609; Fri,  4 Sep 2026 07:46:52 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: maxime.coquelin@redhat.com,
	dev@dpdk.org
Cc: bruce.richardson@intel.com
Subject: [PATCH v2 0/6] Drop vhost async (DMA-accelerated) datapath
Date: Fri,  4 Sep 2026 09:46:42 +0200
Message-ID: <20260904074649.1979166-1-david.marchand@redhat.com>
In-Reply-To: <20260723153111.3943368-1-david.marchand@redhat.com>
References: <20260723153111.3943368-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: SN9HgLdsFF8pa_a7IBtkJHMGXh1T1fztN2JQ4dXM-gg_1788508013
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

Changes since v1:
- removed unneeded dependencies on the PCI library,

Changes since RFC:
- maintained guest pages population in a new flag (vhost_crypto/SPDK),
- removed remaining helpers which had sync_ in their names,


David Marchand (6):
  vhost: decouple guest pages population from async datapath
  examples/vhost: stop using async datapath
  examples/vdpa: remove dependency on PCI library
  vhost: drop async datapath
  vhost: rename packed layout helpers for batches
  vhost: simplify some descriptor handling

 doc/guides/prog_guide/vhost_lib.rst    |  152 +-
 doc/guides/rel_notes/release_26_11.rst |   20 +
 examples/vdpa/main.c                   |    1 -
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
 18 files changed, 736 insertions(+), 4228 deletions(-)
 delete mode 100644 lib/vhost/rte_vhost_async.h

-- 
2.54.0

