Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 335EBC677C4
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Jun 2025 09:45:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0CDDA402DF;
	Wed, 11 Jun 2025 11:45:45 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 234D240144
 for <dev@dpdk.org>; Wed, 11 Jun 2025 11:45:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749635142;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kPbDPGOi1P6B48MA8tLqeCuBdU7G4RCRz6wMuW+5Dp0=;
 b=hD5bFYoD/bdoMrqlHBfeVNCpgzxyYYlmXbopvQhD3oZVmoNbIeT6zGBQkM6j3txgvOi7y9
 EP7XrkuSlzREcy1UgKnWGwssgUv/EWoPQIao7wU7Y/yclpDC/vFw76YVOfN71pwS8ya2eU
 wNyG/ZeFRPWyJblpB/s2Essh/knoaZ0=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-166-hRS74i_XPZe0sRCYn2TSNA-1; Wed,
 11 Jun 2025 05:45:41 -0400
X-MC-Unique: hRS74i_XPZe0sRCYn2TSNA-1
X-Mimecast-MFC-AGG-ID: hRS74i_XPZe0sRCYn2TSNA_1749635140
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3DD6D19560AA
 for <dev@dpdk.org>; Wed, 11 Jun 2025 09:45:40 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.33.8])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E0B8619560A3
 for <dev@dpdk.org>; Wed, 11 Jun 2025 09:45:38 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Subject: [PATCH v7 0/5] allow pmdinfo to be inserted and parsed using MSVC
Date: Wed, 11 Jun 2025 11:45:27 +0200
Message-ID: <20250611094532.1242167-1-david.marchand@redhat.com>
In-Reply-To: <20250610100947.421877-1-david.marchand@redhat.com>
References: <20250610100947.421877-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: DJEXrUVIilEMtcaTZAzDT-OMjynkAHBdYGHlCNohhm4_1749635140
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

Changes since v6:
- changed this_pmd_name symbols construction,

Changes since v5:
- moved details in dev_driver.h,
- renamed RTE_INCLUDE as RTE_PMD_EXPORT_SYMBOL,

Andre Muezerie (3):
  dev: export driver information with MSVC
  buildtools: embed driver information with MSVC
  usertools: enable pmdinfo with MSVC

David Marchand (2):
  dev: hide driver export macros
  dev: rename pmdinfo internal symbols

 buildtools/gen-pmdinfo-cfile.py              | 25 +++++++--
 buildtools/meson.build                       |  2 +
 buildtools/pmdinfogen.py                     | 13 ++---
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
 drivers/compress/mlx5/mlx5_compress.c        |  2 +-
 drivers/crypto/mlx5/mlx5_crypto.c            |  2 +-
 drivers/net/mlx4/mlx4.c                      |  2 +-
 drivers/net/mlx5/mlx5.c                      |  2 +-
 drivers/net/virtio/virtio_pci_ethdev.c       |  2 +-
 drivers/regex/mlx5/mlx5_regex.c              |  2 +-
 drivers/vdpa/mlx5/mlx5_vdpa.c                |  2 +-
 lib/eal/common/eal_common_options.c          |  2 +-
 lib/eal/include/dev_driver.h                 | 43 ++++++++++++++++
 lib/eal/include/rte_dev.h                    | 41 ---------------
 usertools/dpdk-pmdinfo.py                    | 53 ++++++++++++++++----
 26 files changed, 137 insertions(+), 85 deletions(-)

-- 
2.49.0

