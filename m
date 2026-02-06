Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9695EE20B9
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Feb 2026 17:21:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 05B7540431;
	Fri,  6 Feb 2026 18:21:17 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id A3DC840276
 for <dev@dpdk.org>; Fri,  6 Feb 2026 18:21:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770398474;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GOZ+k7G0NQySJvKLOnHMwOQgClKlwcP5KIvsfV1Dh1M=;
 b=bu5X5Ex3Xd6xwW0637fbDuvo0E+Q0CAw4CnxJzFGEv6WAhWT9eR6z1GAvTgdzJX3kxVRon
 GJp+/d8DHCOcPduATz5fgoutqiriKuN35tl5lsVnVdW9m7trkZIXXUbKC53IGDUVzKNrug
 jOFAcgKycdvrKtR6KQeQ4s2ef4b1c/8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-33-xB3iqAjYMCOTCWTl6Q0n5A-1; Fri,
 06 Feb 2026 12:21:10 -0500
X-MC-Unique: xB3iqAjYMCOTCWTl6Q0n5A-1
X-Mimecast-MFC-AGG-ID: xB3iqAjYMCOTCWTl6Q0n5A_1770398469
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 88FD01955F28; Fri,  6 Feb 2026 17:21:09 +0000 (UTC)
Received: from rh.redhat.com (unknown [10.45.224.57])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 270CD180035A; Fri,  6 Feb 2026 17:21:06 +0000 (UTC)
From: Kevin Traynor <ktraynor@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, david.marchand@redhat.com, dsosnowski@nvidia.com,
 viacheslavo@nvidia.com, Kevin Traynor <ktraynor@redhat.com>
Subject: [PATCH v2 0/2] interrupt epoll event handling
Date: Fri,  6 Feb 2026 17:20:52 +0000
Message-ID: <20260206172054.273858-1-ktraynor@redhat.com>
In-Reply-To: <20260128122055.192104-1-ktraynor@redhat.com>
References: <20260128122055.192104-1-ktraynor@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: edi0JdZNhZBb-Vukc2zj_or8U1honM0aXrwjwboJpCk_1770398469
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

Kevin Traynor (2):
  net/mlx5: check for no data read in devx interrupt
  eal/linux: handle interrupt epoll events

 drivers/net/mlx5/linux/mlx5_ethdev_os.c | 34 ++++++++++---
 lib/eal/linux/eal_interrupts.c          | 67 ++++++++++++++++---------
 2 files changed, 72 insertions(+), 29 deletions(-)

-- 
2.52.0

