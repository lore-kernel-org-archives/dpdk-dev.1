Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45256C79FA0
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Sep 2026 07:38:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 29AF04026E;
	Tue,  8 Sep 2026 09:38:44 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 1D98F4026A
 for <dev@dpdk.org>; Tue,  8 Sep 2026 09:38:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788853121;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=MCE0Q+CX6yARoQcDQagT+XJgxAC3DHNhE4nLGT8xjNQ=;
 b=UuCZvzcnNFXcStW48F5zfMHUnZyLXuqMNsF6FJ8MPNt8TAsDcHsHOYKjAVVqj65g3oiEnF
 iDc7y9I6tGrdoIJMBMR35Th/L+nR2KytTkPW8KYc3WX8qjuK8tvQbd4wOBGhsxl8jmBAqD
 vZRLOC1RPWRd1ckNOe18wR0c4SksiPE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-52-SIw6ITcvNj6ou6KO9NQICw-1; Tue,
 08 Sep 2026 03:38:39 -0400
X-MC-Unique: SIw6ITcvNj6ou6KO9NQICw-1
X-Mimecast-MFC-AGG-ID: SIw6ITcvNj6ou6KO9NQICw_1788853119
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D40AC180886E; Tue,  8 Sep 2026 07:38:38 +0000 (UTC)
Received: from dmarchan.redhat.corp
 (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 119E91800640; Tue,  8 Sep 2026 07:38:37 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org,
	hkalra@marvell.com
Subject: [RFC v4 0/5] Interrupts API update
Date: Tue,  8 Sep 2026 09:38:29 +0200
Message-ID: <20260908073835.3422310-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 8dORD30HP34IHA7fkRlqf2mvzo9l1f-NvGCvnl7LlvU_1788853119
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
 lib/eal/freebsd/eal_alarm.c                   |  9 +-
 lib/eal/include/rte_interrupts.h              | 29 ++++++
 lib/eal/linux/eal_dev.c                       |  9 +-
 27 files changed, 212 insertions(+), 139 deletions(-)

-- 
2.54.0

