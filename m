Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC302CC6B1A
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Oct 2026 16:43:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2F164402A4;
	Wed, 14 Oct 2026 18:43:26 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 3A17C40272
 for <dev@dpdk.org>; Wed, 14 Oct 2026 18:43:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791996203;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x0SxR14Lu8zyjAT2R5G1uKnlpdRVKDZE7PTV0GmetVk=;
 b=DRxjNWaXBBywaWr9uSqZmBbN3XcrKlARKdDqZQod+Tv06ybZiCutuqvPKpOYHIXVEB5PqT
 K3pqSHnVlfSXB6pV/YUlZGre2oi2hhOcVERt9xgZW0/FsqhAPn9/bWvwe+zhY+TJ1UHdTc
 2ARe9yW6i/SOWwcC8qzXyV/wgMHi8QQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-70-IXTMVV7TPsydaI4gNBRrrQ-1; Wed,
 14 Oct 2026 16:43:20 +0000
X-MC-Unique: IXTMVV7TPsydaI4gNBRrrQ-1
X-Mimecast-MFC-AGG-ID: IXTMVV7TPsydaI4gNBRrrQ_1791996199
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 71CCE1800755; Wed, 14 Oct 2026 16:43:19 +0000 (UTC)
Received: from dmarchan.redhat.corp
 (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9BD5F195608D; Wed, 14 Oct 2026 16:43:18 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org,
	hkalra@marvell.com
Subject: [PATCH v2 0/5] Interrupts API update
Date: Wed, 14 Oct 2026 18:43:07 +0200
Message-ID: <20261014164313.1755520-1-david.marchand@redhat.com>
In-Reply-To: <20261002091758.2922227-1-david.marchand@redhat.com>
References: <20261002091758.2922227-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: SwTaRe_CiExoX-RQ2xYQ5DuprMrpGea80Ozv6zhhpNY_1791996199
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
It helped catch one small FD leak in FreeBSD EAL.

This should make life (a bit) easier on driver side and help limit FD
leaks.


-- 
David Marchand

Changes since v1:
- rebased,

Changes since RFC v4:
- rebased after internal API cleanup,
- sent as a non RFC,
- updated one comment in net/tap code,

Changes since RFC v3:
- fixed FreeBSD compilation,

Changes since RFC v2:
- added unit test for the new API,
- caught some FD leak by code review,
- split patch 3 from v2 in two, and added one debug check (see patch 5),

Changes since RFC v1:
- squashed FreeBSD PCI change,
- updated interrupt unit test,


David Marchand (5):
  vdpa/mlx5: fix check on err interrupt FD
  eal/freebsd: fix a FD leak in the alarm subsystem
  interrupts: mark file descriptors invalid on allocation
  interrupts: close interrupt FDs
  interrupts: warn on leaked file descriptors

 app/test/test_interrupts.c                    | 91 ++++++++++++++++++-
 doc/guides/rel_notes/release_26_11.rst        |  7 ++
 drivers/bus/cdx/cdx_vfio.c                    | 16 +---
 drivers/bus/pci/bsd/pci.c                     |  7 +-
 drivers/bus/pci/linux/pci_uio.c               | 15 +--
 drivers/bus/pci/linux/pci_vfio.c              | 29 +-----
 drivers/bus/pci/pci_common_uio.c              | 18 +---
 drivers/bus/vmbus/linux/vmbus_uio.c           | 13 +--
 drivers/bus/vmbus/vmbus_common_uio.c          | 17 +---
 drivers/common/cnxk/roc_platform.h            |  2 +
 drivers/common/mlx5/linux/mlx5_common_os.c    |  6 +-
 drivers/net/failsafe/failsafe.c               |  3 -
 drivers/net/mana/mana.c                       |  5 +-
 drivers/net/memif/memif_socket.c              | 13 +--
 drivers/net/memif/rte_eth_memif.c             |  6 --
 drivers/net/mlx4/mlx4.c                       |  3 -
 drivers/net/mlx4/mlx4_intr.c                  |  1 +
 drivers/net/sxe2/sxe2_irq.c                   |  5 +-
 drivers/net/tap/rte_eth_tap.c                 |  2 +-
 .../net/virtio/virtio_user/virtio_user_dev.c  |  2 +
 drivers/raw/cnxk_gpio/cnxk_gpio.c             |  3 +
 drivers/vdpa/mlx5/mlx5_vdpa_event.c           |  6 +-
 drivers/vdpa/mlx5/mlx5_vdpa_virtq.c           |  1 +
 lib/eal/common/eal_common_interrupts.c        | 35 +++++++
 lib/eal/freebsd/eal_alarm.c                   |  9 +-
 lib/eal/include/rte_interrupts.h              | 29 ++++++
 lib/eal/linux/eal_dev.c                       |  9 +-
 27 files changed, 214 insertions(+), 139 deletions(-)

-- 
2.54.0

