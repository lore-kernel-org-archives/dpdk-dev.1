Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6E47E9A04A
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Feb 2026 14:39:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AE714402C6;
	Thu, 19 Feb 2026 15:39:04 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id CEEA0402AA
 for <dev@dpdk.org>; Thu, 19 Feb 2026 15:39:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771511943;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=25tdjYu6zRa4H1Q9rUTt6Ry6xF+PPL+PJL/DL6xkbqE=;
 b=WBTOt5gtJw2py4pvHC2bs87sfAgp48DjX89HOmzxI29U79cpxhCYh6NB0XdbmADJ+ujWjR
 pZl8O4umSGgH0dKAkIPHALUlxv0Zd9YoZ6OEqpe+3c8hGEVxGqyl07z5hioAdrfZZw1nHN
 lbDrGpvsVeks7Sbp2m4JQlsNVGwKN0k=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-245-tTT0RfAyPdmY3JFWUYAg6Q-1; Thu,
 19 Feb 2026 09:38:59 -0500
X-MC-Unique: tTT0RfAyPdmY3JFWUYAg6Q-1
X-Mimecast-MFC-AGG-ID: tTT0RfAyPdmY3JFWUYAg6Q_1771511938
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8569518005B0; Thu, 19 Feb 2026 14:38:58 +0000 (UTC)
Received: from rh.redhat.com (unknown [10.44.32.51])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BE0723000C26; Thu, 19 Feb 2026 14:38:55 +0000 (UTC)
From: Kevin Traynor <ktraynor@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, david.marchand@redhat.com, dsosnowski@nvidia.com,
 viacheslavo@nvidia.com, hkalra@marvell.com,
 Kevin Traynor <ktraynor@redhat.com>
Subject: [PATCH v4 0/3] interrupt disconnect/error event handling
Date: Thu, 19 Feb 2026 14:38:49 +0000
Message-ID: <20260219143852.200722-1-ktraynor@redhat.com>
In-Reply-To: <20260128122055.192104-1-ktraynor@redhat.com>
References: <20260128122055.192104-1-ktraynor@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: l2QvyEzGPpwgNTam_NPaFh9SJRgAWrlruQrW1dRe0JY_1771511938
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

2/3: provides an API for interrupt callbacks to get the interrupt events
for the active interrupt

3/3: deal with the observed issue as reported in
https://bugs.dpdk.org/show_bug.cgi?id=1873 where mlx5 devx interrupts
cause a busy-loop and 100% CPU of dpdk-intr thread.

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
 lib/eal/include/rte_interrupts.h        |  23 ++++++
 lib/eal/linux/eal_interrupts.c          | 103 +++++++++++++++++-------
 lib/eal/windows/eal_interrupts.c        |   7 ++
 5 files changed, 133 insertions(+), 27 deletions(-)

-- 
2.53.0

