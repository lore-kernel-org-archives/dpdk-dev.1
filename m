Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D089EB26F7
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Feb 2026 18:13:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 581C6402CC;
	Tue, 10 Feb 2026 19:13:18 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id AAD15402B0
 for <dev@dpdk.org>; Tue, 10 Feb 2026 19:13:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770747195;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JVeIXDQLgliZCzv/xCPU7LlOpWm1f1XRcO68rWuHngY=;
 b=aiTEUKRS0P6ZJwRFXuHqWoZAbkpI9TIVApnqvHgWnEiH1a3R76TqcM5TdySwXcA9is3Mm9
 7kUCP5lWMcD0uQxM7nz39h+4xib3QPs3JP8feX22Hv4CUZGtPsOaCg2zIhqglIAumEPjio
 LvC9at8E8lzCyQmaquLO6lhL1Fo/QjE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-664-y-9OjxT0PUaeB4-adiInrg-1; Tue,
 10 Feb 2026 13:06:50 -0500
X-MC-Unique: y-9OjxT0PUaeB4-adiInrg-1
X-Mimecast-MFC-AGG-ID: y-9OjxT0PUaeB4-adiInrg_1770746809
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1A5C6195608F; Tue, 10 Feb 2026 18:06:48 +0000 (UTC)
Received: from rh.redhat.com (unknown [10.44.33.40])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5B8A318003F5; Tue, 10 Feb 2026 18:06:43 +0000 (UTC)
From: Kevin Traynor <ktraynor@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, david.marchand@redhat.com, dsosnowski@nvidia.com,
 viacheslavo@nvidia.com, hkalra@marvell.com,
 Kevin Traynor <ktraynor@redhat.com>
Subject: [PATCH v3 0/2] interrupt epoll event handling
Date: Tue, 10 Feb 2026 18:06:32 +0000
Message-ID: <20260210180634.187586-1-ktraynor@redhat.com>
In-Reply-To: <20260128122055.192104-1-ktraynor@redhat.com>
References: <20260128122055.192104-1-ktraynor@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 47G7a9_FmFtGU-6iKvtY5a6xwdGIgmmEoacvEq2ZbUQ_1770746809
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

In the interrupt handling code, some interrupts are read directly in eal
and some just call registered callback which will read the interrupt.

v1 version was too aggressively dealing with epoll disconnect/error events
by detecting and removing the interrupt in the eal interrupt code and
not calling the registered callbacks.

This was a problem for virtio, which needs to handle these scenarios
itself so it can enable reconnect for vhost server.

In v2, if the read is not done in eal then the registered callback will
be called and it is up to handlers external to eal to deal with the
interrupt as they see fit.

This better respects interrupt types like RTE_INTR_HANDLE_EXT and
RTE_INTR_HANDLE_VDEV.

To deal with the observed issue of mlx5 devx interrupts causing a
busy-loop and 100% CPU of dpdk-intr thread, extra handling is added to
the devx interrupt handler.

1/2: deals with mlx5 devx interrupt busy-loop
2/2: deals with disconnect/error epoll events for interrupts read in eal

The patches are independent but 1/2 is the direct fix for the real life
bug observed and reported in https://bugs.dpdk.org/show_bug.cgi?id=1873.

v3:
- 1/2 and 2/2 fix some coding nits (Stephen/AI/David)
- 2/2 Make log level consistant (David)

Sending v3 as it is fixing some minor coding issues and is prepared.

***NOTE:*** Slava has raised some concerns on the operation of 1/2 that
will need to be discussed further.

Kevin Traynor (2):
  net/mlx5: check for no data read in devx interrupt
  eal/linux: handle interrupt epoll events

 drivers/net/mlx5/linux/mlx5_ethdev_os.c | 34 +++++++++---
 lib/eal/linux/eal_interrupts.c          | 72 ++++++++++++++++---------
 2 files changed, 74 insertions(+), 32 deletions(-)

-- 
2.52.0

