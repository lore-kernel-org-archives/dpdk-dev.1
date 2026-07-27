Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CBE9C531D0
	for <dpdk-dev@archiver.kernel.org>; Mon, 27 Jul 2026 11:53:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DAD9B40279;
	Mon, 27 Jul 2026 13:53:20 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 9CA77400D6
 for <dev@dpdk.org>; Mon, 27 Jul 2026 13:53:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785153199;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GyUS0Kon/YVYRi3H0/1Hz1gs7O87qV1snPY4mGEWfRo=;
 b=gkUK6zx2KYPnuyqC0NkZFUc6S8j2X0URcQbfeWjB7ypcR4Fv1BdJzjswXhcAD9huaSNBpY
 VGNsVIVJKySCFkqNCRPWA6eALLuwB5TFWT08wLSQfrDuJdtLO9VdwHDmVNOjDw+Ah7RjG4
 tE9U5n56Xros3EqqIsKt16QrwSOOp0c=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-509-sGvdNpGuMDqUNrA6YgGh6A-1; Mon,
 27 Jul 2026 07:53:17 -0400
X-MC-Unique: sGvdNpGuMDqUNrA6YgGh6A-1
X-Mimecast-MFC-AGG-ID: sGvdNpGuMDqUNrA6YgGh6A_1785153196
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 96BF61955F28; Mon, 27 Jul 2026 11:53:16 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.48.202])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 986D81800480; Mon, 27 Jul 2026 11:53:15 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org,
	hkalra@marvell.com
Subject: [RFC v2 0/3] Interrupts API update
Date: Mon, 27 Jul 2026 13:53:06 +0200
Message-ID: <20260727115309.1377267-1-david.marchand@redhat.com>
In-Reply-To: <20260723131908.3313223-1-david.marchand@redhat.com>
References: <20260723131908.3313223-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: kyRClAluybBo-xMOl8jOUfmdBciXE0utWe8zwMooelw_1785153196
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

This series is a simple cleanup to have a simpler helper that close all
FD reference in an interrupt handle.
This should make life (a bit) easier on driver side.


-- 
David Marchand

Changes since RFC v1:
- squashed FreeBSD PCI change,
- updated interrupt unit test,


David Marchand (3):
  vdpa/mlx5: fix check on err interrupt FD
  interrupts: mark file descriptors invalid on allocation
  interrupts: close interrupt FDs

 app/test/test_interrupts.c             | 12 +++++++++--
 doc/guides/rel_notes/release_26_11.rst |  7 +++++++
 drivers/bus/cdx/cdx_vfio.c             |  6 ------
 drivers/bus/pci/bsd/pci.c              |  7 ++-----
 drivers/bus/pci/linux/pci_uio.c        | 15 +++----------
 drivers/bus/pci/linux/pci_vfio.c       | 29 +++++---------------------
 drivers/bus/pci/pci_common_uio.c       | 18 ++--------------
 drivers/bus/vmbus/linux/vmbus_uio.c    | 13 +++---------
 drivers/bus/vmbus/vmbus_common_uio.c   | 17 ++-------------
 drivers/net/failsafe/failsafe.c        |  3 ---
 drivers/net/mana/mana.c                |  5 +----
 drivers/net/memif/memif_socket.c       | 13 +++---------
 drivers/net/memif/rte_eth_memif.c      |  6 ------
 drivers/net/mlx4/mlx4.c                |  3 ---
 drivers/net/mlx4/mlx4_intr.c           |  1 +
 drivers/net/tap/rte_eth_tap.c          |  2 +-
 drivers/vdpa/mlx5/mlx5_vdpa_event.c    |  6 ++++--
 drivers/vdpa/mlx5/mlx5_vdpa_virtq.c    |  1 +
 lib/eal/common/eal_common_interrupts.c | 29 ++++++++++++++++++++++++++
 lib/eal/freebsd/eal_alarm.c            |  3 ---
 lib/eal/include/rte_interrupts.h       | 29 ++++++++++++++++++++++++++
 lib/eal/linux/eal_dev.c                |  9 +-------
 22 files changed, 104 insertions(+), 130 deletions(-)

-- 
2.54.0

