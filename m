Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 682ECC5B543
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Jun 2025 10:09:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 73A6042E62;
	Tue, 10 Jun 2025 12:09:56 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id B4E5F42E5D
 for <dev@dpdk.org>; Tue, 10 Jun 2025 12:09:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749550194;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=xNQeTNlp4/9b+DazEb4ZVc0g9IVJl5Yh6a7iKf66Z2E=;
 b=GDRcZLcbOo4cInDm5cJ5SdHa9OJvvnhtwyLXhT1jQFe7/AMP4yYeMZ2xhTaYId4X2fwz4R
 37qRVn7rY5Z2kEam6ZcZH2YxgFoZJDfjkvetxB/uF/aVOpWjJnVuvTxxEpcoJG7ZoXlNvO
 oVVfzohRvbyn3yVUppQU4u8mtthp1RI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-256-E04YRLYBMyGZSR-zTpGHkQ-1; Tue,
 10 Jun 2025 06:09:53 -0400
X-MC-Unique: E04YRLYBMyGZSR-zTpGHkQ-1
X-Mimecast-MFC-AGG-ID: E04YRLYBMyGZSR-zTpGHkQ_1749550192
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 54E5519560A5
 for <dev@dpdk.org>; Tue, 10 Jun 2025 10:09:52 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.33.8])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8933818002B2
 for <dev@dpdk.org>; Tue, 10 Jun 2025 10:09:51 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Subject: [PATCH v6 0/4] allow pmdinfo to be inserted and parsed using MSVC
Date: Tue, 10 Jun 2025 12:09:43 +0200
Message-ID: <20250610100947.421877-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Y9Co94e60b8gYrr8GL5p80c8ycS_7Avf-jGdykG81bM_1749550192
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

This is a rework of Andre v5, trying to hide the ugly details in a
driver only macro not exposed publicly.


-- 
David Marchand

Changes since v5:
- moved details in dev_driver.h,
- renamed RTE_INCLUDE as RTE_PMD_EXPORT_SYMBOL,

Andre Muezerie (3):
  dev: export driver information with MSVC
  buildtools: embed driver information with MSVC
  usertools: enable pmdinfo with MSVC

David Marchand (1):
  dev: hide driver export macros

 buildtools/gen-pmdinfo-cfile.py              | 25 +++++++--
 buildtools/meson.build                       |  2 +
 buildtools/pmdinfogen.py                     | 11 ++--
 drivers/bus/auxiliary/bus_auxiliary_driver.h |  2 +-
 drivers/bus/cdx/bus_cdx_driver.h             |  5 +-
 drivers/bus/dpaa/bus_dpaa_driver.h           |  2 +-
 drivers/bus/fslmc/bus_fslmc_driver.h         |  4 +-
 drivers/bus/ifpga/bus_ifpga_driver.h         |  2 +-
 drivers/bus/pci/bus_pci_driver.h             |  2 +-
 drivers/bus/platform/bus_platform_driver.h   |  2 +-
 drivers/bus/uacce/bus_uacce_driver.h         |  2 +-
 drivers/bus/vdev/bus_vdev_driver.h           |  2 +-
 drivers/bus/vmbus/bus_vmbus_driver.h         |  2 +-
 drivers/common/mlx5/mlx5_common.c            |  2 +-
 drivers/common/mlx5/mlx5_common_pci.c        |  2 +-
 drivers/common/nitrox/nitrox_device.c        |  1 +
 drivers/compress/mlx5/mlx5_compress.c        |  2 +-
 drivers/crypto/mlx5/mlx5_crypto.c            |  2 +-
 drivers/event/octeontx/ssovf_evdev.c         |  1 +
 drivers/net/mlx4/mlx4.c                      |  2 +-
 drivers/net/mlx5/mlx5.c                      |  2 +-
 drivers/net/virtio/virtio_pci_ethdev.c       |  2 +-
 drivers/regex/mlx5/mlx5_regex.c              |  2 +-
 drivers/vdpa/mlx5/mlx5_vdpa.c                |  2 +-
 lib/eal/common/eal_common_options.c          |  2 +-
 lib/eal/include/dev_driver.h                 | 45 +++++++++++++++++
 lib/eal/include/rte_dev.h                    | 41 ---------------
 usertools/dpdk-pmdinfo.py                    | 53 ++++++++++++++++----
 28 files changed, 140 insertions(+), 84 deletions(-)

-- 
2.49.0

