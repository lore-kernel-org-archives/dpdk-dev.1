Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB7AEEDEBE6
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Mar 2026 18:58:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 12DDE402AA;
	Tue,  3 Mar 2026 19:58:35 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id A97E740268
 for <dev@dpdk.org>; Tue,  3 Mar 2026 19:58:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772564313;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y2iailCcvCazZYFcECrpHzD4JERFPP90q3M+lI7Afg0=;
 b=QibUjyKoPrOFFP5godJCTAaQxqzuifyO5oB1A9O/AyLaXBa8x3HLS9DtxdJpnXdO0Sw/19
 wfweoweXzkU3MDZbkIiXoQ270Ey5T6GdJPLWZhkiUvL3gDKSCKxQpmtqh3vAZ1JuNLHVc2
 3NKeOGqhQVDBk5cAxIcSjHG2BQoV5+4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-74-7zmayvVANLm2xqgv6k5YIw-1; Tue,
 03 Mar 2026 13:58:30 -0500
X-MC-Unique: 7zmayvVANLm2xqgv6k5YIw-1
X-Mimecast-MFC-AGG-ID: 7zmayvVANLm2xqgv6k5YIw_1772564308
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1AB161956046; Tue,  3 Mar 2026 18:58:28 +0000 (UTC)
Received: from rh.redhat.com (unknown [10.45.224.158])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 173E81800576; Tue,  3 Mar 2026 18:58:24 +0000 (UTC)
From: Kevin Traynor <ktraynor@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, david.marchand@redhat.com, dsosnowski@nvidia.com,
 viacheslavo@nvidia.com, hkalra@marvell.com, stephen@networkplumber.org,
 Kevin Traynor <ktraynor@redhat.com>
Subject: [PATCH v5 0/3] interrupt disconnect/error event handling
Date: Tue,  3 Mar 2026 18:58:15 +0000
Message-ID: <20260303185818.28689-1-ktraynor@redhat.com>
In-Reply-To: <20260128122055.192104-1-ktraynor@redhat.com>
References: <20260128122055.192104-1-ktraynor@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 76aY__RS4iUJMedendJ11NfhzHwCVN7jaXKmvawzhYM_1772564308
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

These patches are to fix some issues with epoll event handling for
EPOLLERR/EPOLLRDHUP/EPOLLHUP.

1/3: handles these disconnect/error events for interrupts that are read
in eal

2/3: provides an internal API for interrupt callbacks to get the interrupt
events for the active interrupt

3/3: deal with the observed issue as reported in
https://bugs.dpdk.org/show_bug.cgi?id=1873 where mlx5 devx interrupts
cause a busy-loop and 100% CPU of dpdk-intr thread.

v5:
- 2/3 changed API to rte_intr_active_event_flags() and made internal.
  used RTE_BIT32() for defines. Added Cc: stable. Kept Acks as no
  functional changes.

v4:
Updated to allow for case where devx interrupt handler may handle
multiple completions during one interrupt call, leading to no data being
read in a subsequent call as flagged by Slava.

- 1/3 No change
- 2/3 New API rte_intr_active_events() to get interrupt events
- 3/3 Use new API in mlx5 devx interrupt handler to detect if
  disconnect/error events and if so unregister the callback

v3:
- 1/2 and 2/2 fix some coding nits (Stephen/AI/David)
- 2/2 Make log level consistant (David)

v2:
- Only handle disconnect/error epoll events when the read is done in eal
  interrupt code. This is to allow interrupt handlers like virtio deal
  with disconnects in an appropriate
- Detect if not data is read in the mlx dex interrupt and if so unregister
  the callback

Kevin Traynor (3):
  eal/linux: handle interrupt epoll events
  eal/interrupt: add interrupt event info
  net/mlx5: check devx disconnect/error interrupt events

 drivers/net/mlx5/linux/mlx5_ethdev_os.c |  20 +++++
 lib/eal/freebsd/eal_interrupts.c        |   7 ++
 lib/eal/include/rte_interrupts.h        |  21 +++++
 lib/eal/linux/eal_interrupts.c          | 103 +++++++++++++++++-------
 lib/eal/windows/eal_interrupts.c        |   7 ++
 5 files changed, 131 insertions(+), 27 deletions(-)

-- 
2.53.0

