Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0F39C79F89
	for <dpdk-dev@archiver.kernel.org>; Mon,  7 Sep 2026 12:13:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 14A524027F;
	Mon,  7 Sep 2026 14:13:58 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 6881340041
 for <dev@dpdk.org>; Mon,  7 Sep 2026 14:13:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788783236;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=VLGav7G4hD3+7LCcq6prleYtkenL8KGDgps01lFS4cg=;
 b=QSi531HvxEIl49kAb2yZ1tpP+b8ZjjRdKXQUn1+WVcdPUH/MBtWqp/i+sEIq2k3vw5wnUO
 TyRD5v160rD/wK3a7XtI+26czRSpIoHBy3DP+vMGmros9kv5PlYeM193MuJRo3k3i8dGf9
 z7ODvJIlFoN/gMdMbYoa4JmIoJ/3pqE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-203-pIVov7YGN8aXkichGw7zYQ-1; Mon,
 07 Sep 2026 08:13:54 -0400
X-MC-Unique: pIVov7YGN8aXkichGw7zYQ-1
X-Mimecast-MFC-AGG-ID: pIVov7YGN8aXkichGw7zYQ_1788783233
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B30911954215; Mon,  7 Sep 2026 12:13:53 +0000 (UTC)
Received: from dmarchan.redhat.corp
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E574D1955F05; Mon,  7 Sep 2026 12:13:52 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org,
	hkalra@marvell.com
Subject: [RFC v3 0/5] Interrupts API update
Date: Mon,  7 Sep 2026 14:13:43 +0200
Message-ID: <20260907121348.3049808-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: lXSKYi0srZxuTXvDAGgegy4GklIKDmWSWfXDaq1loxo_1788783233
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

 app/test/test_interrupts.c                    | 89 ++++++++++++++++++-
 doc/guides/rel_notes/release_26_11.rst        |  7 ++
 drivers/bus/cdx/cdx_vfio.c                    | 16 ++--
 drivers/bus/pci/bsd/pci.c                     |  7 +-
 drivers/bus/pci/linux/pci_uio.c               | 15 +---
 drivers/bus/pci/linux/pci_vfio.c              | 29 ++----
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
 lib/eal/common/eal_common_interrupts.c        | 35 ++++++++
 lib/eal/freebsd/eal_alarm.c                   |  8 +-
 lib/eal/include/rte_interrupts.h              | 29 ++++++
 lib/eal/linux/eal_dev.c                       |  9 +-
 27 files changed, 211 insertions(+), 139 deletions(-)

-- 
2.54.0

