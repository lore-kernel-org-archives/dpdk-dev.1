Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AC14CA100C
	for <dpdk-dev@archiver.kernel.org>; Wed,  3 Sep 2025 07:28:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B4976402BC;
	Wed,  3 Sep 2025 09:28:39 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 6B79340261
 for <dev@dpdk.org>; Wed,  3 Sep 2025 09:28:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756884517;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=KNUOhOomKN+oZvUEwSBC61R2sj7K0tC9/32HlFrnfJA=;
 b=aoqu+zKlxd+dqUSXuQWtyp9qEwWiDyDFNorfbnTLawwQTjKoR5lFbi6zB+Y8tc+vbrmIUB
 ACZR2UA2vb4LcjN0Fx0jSfYWR6WzwURH4Z3DhCyfHPdnLwUtcZh7CqYwqIvuRkhrF54KXm
 k6UKMlPLPiTDs7Q0uxW5F3ulYIBuR+4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-113-WK_JgXyQMo-IH_8gie_jLA-1; Wed,
 03 Sep 2025 03:28:36 -0400
X-MC-Unique: WK_JgXyQMo-IH_8gie_jLA-1
X-Mimecast-MFC-AGG-ID: WK_JgXyQMo-IH_8gie_jLA_1756884515
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 871C4180057E; Wed,  3 Sep 2025 07:28:35 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.33.82])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C53C03000198; Wed,  3 Sep 2025 07:28:33 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net,
	maxime.coquelin@redhat.com
Subject: [RFC 0/8] Cleanup VFIO API and import Linux uAPI header
Date: Wed,  3 Sep 2025 09:28:17 +0200
Message-ID: <20250903072826.1727004-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: GelYPrLIpD5W_3LrS6Z_4wbPV_E9ED5fpGZyBu47zQs_1756884515
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

The VFIO headers have a number of issues:
- showing to the world a lot of internal considerations,
- defining macros with the VFIO_ namespace (confusing, and a source of
  conflicts with the VFIO official uAPI),
- wrapping around VFIO uAPI in case the kernel headers do not contain the
  expected API (putting the burden on DPDK developers to find the right
  way to detect the presence of a VFIO feature),
- (somehow related to the previous point) supporting old version of the
  Linux kernel while DPDK now requires a v5.4 Linux kernel at least,

This series proposes to cleanup those headers by hiding as much as
possible internal macros and structures, then removing the explicit
inclusion of linux/vfio.h from rte_vfio.h (pushing this inclusion to the
application which may want to do some funny stuff with VFIO and should
already include this header on its own) and finally importing the VFIO
uAPI header from Linux v6.15 for internal consumption by DPDK
components.


-- 
David Marchand

David Marchand (8):
  vfio: remove confusing check on VFIO presence
  vfio: assume VFIO is always and only present on Linux
  vfio: remove public wrappers
  eal/linux: remove more internal VFIO macros
  eal/linux: remove internal VFIO wrappers for old Linux
  vfio: stop including Linux kernel header in public and driver API
  uapi: import VFIO header
  vfio: use imported uAPI header

 config/meson.build                         |    3 -
 doc/api/doxy-api.conf.in                   |    1 -
 doc/guides/cryptodevs/bcmfs.rst            |    4 -
 drivers/bus/cdx/cdx_vfio.c                 |   19 +-
 drivers/bus/fslmc/bus_fslmc_driver.h       |    3 +-
 drivers/bus/fslmc/fslmc_bus.c              |   13 +-
 drivers/bus/fslmc/fslmc_vfio.c             |   22 +-
 drivers/bus/fslmc/fslmc_vfio.h             |    1 -
 drivers/bus/fslmc/portal/dpaa2_hw_dpio.c   |    2 +
 drivers/bus/pci/linux/pci.c                |   22 -
 drivers/bus/pci/linux/pci_init.h           |    6 -
 drivers/bus/pci/linux/pci_vfio.c           |   37 +-
 drivers/bus/pci/pci_common.c               |    2 -
 drivers/bus/platform/bus_platform_driver.h |   20 +-
 drivers/bus/platform/platform.c            |    6 +-
 drivers/bus/platform/platform_params.c     |    5 -
 drivers/common/qat/dev/qat_dev_gen_lce.c   |    3 +-
 drivers/crypto/bcmfs/bcmfs_vfio.c          |   15 +-
 drivers/crypto/bcmfs/meson.build           |    4 +-
 drivers/net/hns3/hns3_ethdev_vf.c          |    1 -
 drivers/raw/ifpga/afu_pmd_he_hssi.c        |    1 -
 drivers/raw/ifpga/afu_pmd_he_lpbk.c        |    1 -
 drivers/raw/ifpga/afu_pmd_he_mem.c         |    1 -
 drivers/raw/ifpga/afu_pmd_n3000.c          |    7 +-
 drivers/raw/ifpga/base/ifpga_feature_dev.c |    2 +-
 drivers/vdpa/ifc/ifcvf_vdpa.c              |    2 +
 drivers/vdpa/nfp/nfp_vdpa.c                |    2 +
 drivers/vdpa/sfc/sfc_vdpa_ops.c            |    3 +-
 kernel/linux/uapi/linux/vfio.h             | 1836 ++++++++++++++++++++
 kernel/linux/uapi/version                  |    2 +-
 lib/eal/include/rte_vfio.h                 |   87 -
 lib/eal/linux/eal.c                        |    4 -
 lib/eal/linux/eal_interrupts.c             |   28 +-
 lib/eal/linux/eal_vfio.c                   |  126 +-
 lib/eal/linux/eal_vfio.h                   |   79 -
 lib/eal/linux/eal_vfio_mp_sync.c           |   10 -
 36 files changed, 1956 insertions(+), 424 deletions(-)
 create mode 100644 kernel/linux/uapi/linux/vfio.h

-- 
2.51.0

