Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE53FC531CB
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Jul 2026 13:19:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EADBE40663;
	Thu, 23 Jul 2026 15:19:21 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 0B97F40274
 for <dev@dpdk.org>; Thu, 23 Jul 2026 15:19:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784812759;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=IsLr0Cda7LizveDxboHvOOORkzVvJP50TVv+JzFmyLI=;
 b=KPDO6Go1BOrMb/wRWcMcZZxf7J19CvelVEQkFTeZQrb8+DqGqIJqDW8YOtSLBAWqunp1qp
 t/SuNhCRYsUr7ZbDEPdzCkkLoPcP+cBPPFbNxxHDEdPy9bxyoKk3mCB/2tuZdCIajJT8R9
 /zTKqIhx3pNT6oTwxry3g4R0+nE+ZeU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-582-19qm9BnnNVWAIbSGG5SE0A-1; Thu,
 23 Jul 2026 09:19:16 -0400
X-MC-Unique: 19qm9BnnNVWAIbSGG5SE0A-1
X-Mimecast-MFC-AGG-ID: 19qm9BnnNVWAIbSGG5SE0A_1784812755
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 242D7180A8D5; Thu, 23 Jul 2026 13:19:15 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.48.202])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2762A18002B7; Thu, 23 Jul 2026 13:19:13 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: hkalra@marvell.com
Subject: [RFC 0/4] Interrupts API update
Date: Thu, 23 Jul 2026 15:19:03 +0200
Message-ID: <20260723131908.3313223-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: qxOcwxnrhTQZuQ5ffEmyI1lFRhOyounu0caT5eOefUQ_1784812755
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

David Marchand (4):
  bus/pci: fix check on interrupt FD for FreeBSD
  vdpa/mlx5: fix check on err interrupt FD
  interrupts: mark file descriptors invalid on allocation
  interrupts: close interrupt FDs

 app/test/test_interrupts.c             |  5 +++--
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
 22 files changed, 97 insertions(+), 130 deletions(-)

-- 
2.54.0

