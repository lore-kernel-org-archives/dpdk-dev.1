Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7D87CC6B1A
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Oct 2026 15:58:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F20CC4064C;
	Wed, 14 Oct 2026 17:58:02 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id E20BD4060F
 for <dev@dpdk.org>; Wed, 14 Oct 2026 17:58:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791993481;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iXXX72FloBCTu6eHVzqE5FaD4FQsd/pr/tDJEo84qys=;
 b=bB0OvzmtHGKo3Qpp4fET625M52+Arq7f2EUort1T6GQZEoVXqj9kwA19WoJnGPeNPXqCwA
 auJQoI9sYa2FKMSY1bYZEnPMvrjTFNBocF0RKr56N+fsvOerYrH0nPZfLY1Ux4rpF/WVzl
 fFAiz/LsvAzIX0P6HWQ4drbF+ek9yWQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-684-AMgg3IUiOiynVa2ywKle4A-1; Wed,
 14 Oct 2026 15:57:59 +0000
X-MC-Unique: AMgg3IUiOiynVa2ywKle4A-1
X-Mimecast-MFC-AGG-ID: AMgg3IUiOiynVa2ywKle4A_1791993479
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C6EED19560BA; Wed, 14 Oct 2026 15:57:58 +0000 (UTC)
Received: from dmarchan.redhat.corp
 (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3E014195608D; Wed, 14 Oct 2026 15:57:56 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: maxime.coquelin@redhat.com,
	dev@dpdk.org
Cc: bruce.richardson@intel.com
Subject: [PATCH v4 0/6] Drop vhost async (DMA-accelerated) datapath
Date: Wed, 14 Oct 2026 17:57:44 +0200
Message-ID: <20261014155750.1269862-1-david.marchand@redhat.com>
In-Reply-To: <20260723153111.3943368-1-david.marchand@redhat.com>
References: <20260723153111.3943368-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -bALynEk_gtxqWq43e7uGQpzBWPlawWnhnP3meoggBI_1791993479
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

Changes since v3:
- rebased after CVE fixes and various changes: RTE_PTR_ADD, VFIO,
  signal cleanup in examples,

Changes since v2:
- updated release notes and vhost example documentation,
- removed some async statistics missed in previous revisions,
- re-added checks on map populate and post copy or other virtio features,

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
 doc/guides/rel_notes/release_26_11.rst |   24 +
 doc/guides/sample_app_ug/vhost.rst     |   10 -
 examples/vdpa/main.c                   |    1 -
 examples/vhost/Makefile                |    2 -
 examples/vhost/main.c                  |  437 +---
 examples/vhost/main.h                  |   21 +-
 examples/vhost/meson.build             |    2 -
 examples/vhost_crypto/Makefile         |    1 -
 examples/vhost_crypto/main.c           |    2 +-
 examples/vhost_crypto/meson.build      |    1 -
 lib/vhost/meson.build                  |    3 +-
 lib/vhost/rte_vhost.h                  |    2 +-
 lib/vhost/rte_vhost_async.h            |  293 ---
 lib/vhost/socket.c                     |   23 +-
 lib/vhost/vhost.c                      |  436 ----
 lib/vhost/vhost.h                      |  119 +-
 lib/vhost/vhost_user.c                 |  115 +-
 lib/vhost/virtio_net.c                 | 3318 +++++-------------------
 19 files changed, 731 insertions(+), 4231 deletions(-)
 delete mode 100644 lib/vhost/rte_vhost_async.h

-- 
2.54.0

