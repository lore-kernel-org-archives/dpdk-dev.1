Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B42B7CAC592
	for <dpdk-dev@archiver.kernel.org>; Fri, 19 Sep 2025 08:38:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E7146402C1;
	Fri, 19 Sep 2025 10:38:21 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 0DE24402B7
 for <dev@dpdk.org>; Fri, 19 Sep 2025 10:38:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758271099;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I7YU+7My8Uh68DSOUEykm3iJQTn8PiTzKnRZgFAPh0I=;
 b=jN70Rww7oHN7nWP23zeoFVrGXDz62pd+fxPNunTaaQSvy+G3JQRKV5wZCC/5qji4wcUHe9
 OkA+8XrMWfnOmPNdgA3H1GRYfcZIucmHzMf1DHUrTPgLcmhqMwZO4NxJIg2TgrHGgqgtgP
 U9TrPEKT9ZAMdJVyuPYsvOkH3sfL81c=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-642-0o9jX0XfMquBVUhesGQU6g-1; Fri,
 19 Sep 2025 04:38:16 -0400
X-MC-Unique: 0o9jX0XfMquBVUhesGQU6g-1
X-Mimecast-MFC-AGG-ID: 0o9jX0XfMquBVUhesGQU6g_1758271095
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D0E5219560A5; Fri, 19 Sep 2025 08:38:14 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.45.225.72])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 702C230002C5; Fri, 19 Sep 2025 08:38:11 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, maxime.coquelin@redhat.com, anatoly.burakov@intel.com,
 stephen@networkplumber.org
Subject: [PATCH v3 00/10] Cleanup VFIO API and import Linux uAPI header
Date: Fri, 19 Sep 2025 10:37:57 +0200
Message-ID: <20250919083808.1667491-1-david.marchand@redhat.com>
In-Reply-To: <20250903072826.1727004-1-david.marchand@redhat.com>
References: <20250903072826.1727004-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: OzX63BC1h4P680GFYnh7jqK3TlE0MudLqtRuQxVpI38_1758271095
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

Changes since RFC v2:
- fixed include guard for VDUSE and updated documentation,
- kept but renamed some local macros for /dev/vfio and vfio kmod,
- reimported VFIO header,
- converted net/xsc,
- fixed header inclusion order,

Changes since RFC v1:
- fixed FreeBSD compilation,
- fixed some inclusion of linux/vfio.h in common/cnxk and raw/ifpga,

David Marchand (10):
  uapi: fix include guards in VDUSE imported header
  drivers: remove unneeded VFIO header inclusion
  vfio: remove confusing check on VFIO presence
  vfio: assume VFIO is always and only present on Linux
  vfio: remove public wrappers
  eal/linux: remove more internal VFIO macros
  eal/linux: remove internal VFIO wrappers for old Linux
  vfio: stop including Linux kernel header in public and driver API
  uapi: import VFIO header
  vfio: use imported uAPI header

 config/meson.build                         |    3 -
 devtools/linux-uapi.sh                     |    3 +
 doc/api/doxy-api.conf.in                   |    1 -
 doc/guides/contributing/linux_uapi.rst     |    6 +
 doc/guides/cryptodevs/bcmfs.rst            |    4 -
 drivers/bus/cdx/cdx_vfio.c                 |   19 +-
 drivers/bus/fslmc/bus_fslmc_driver.h       |    3 +-
 drivers/bus/fslmc/fslmc_bus.c              |   13 +-
 drivers/bus/fslmc/fslmc_vfio.c             |   20 +-
 drivers/bus/fslmc/fslmc_vfio.h             |    1 -
 drivers/bus/fslmc/portal/dpaa2_hw_dpio.c   |    2 +
 drivers/bus/pci/linux/pci.c                |   22 -
 drivers/bus/pci/linux/pci_init.h           |    6 -
 drivers/bus/pci/linux/pci_vfio.c           |   37 +-
 drivers/bus/pci/pci_common.c               |    2 -
 drivers/bus/platform/bus_platform_driver.h |   20 +-
 drivers/bus/platform/platform.c            |    6 +-
 drivers/bus/platform/platform_params.c     |    5 -
 drivers/common/cnxk/roc_platform.c         |    3 +-
 drivers/common/qat/dev/qat_dev_gen_lce.c   |    4 -
 drivers/crypto/bcmfs/bcmfs_vfio.c          |   15 +-
 drivers/crypto/bcmfs/meson.build           |    4 +-
 drivers/net/hns3/hns3_ethdev_vf.c          |    1 -
 drivers/net/xsc/xsc_vfio.c                 |    3 +-
 drivers/raw/ifpga/afu_pmd_he_hssi.c        |    1 -
 drivers/raw/ifpga/afu_pmd_he_lpbk.c        |    1 -
 drivers/raw/ifpga/afu_pmd_he_mem.c         |    1 -
 drivers/raw/ifpga/afu_pmd_n3000.c          |    7 +-
 drivers/raw/ifpga/base/ifpga_feature_dev.c |    3 +-
 drivers/vdpa/ifc/ifcvf_vdpa.c              |    2 +
 drivers/vdpa/nfp/nfp_vdpa.c                |    2 +
 drivers/vdpa/sfc/sfc_vdpa_ops.c            |    3 +-
 kernel/linux/uapi/linux/vduse.h            |    6 +-
 kernel/linux/uapi/linux/vfio.h             | 1836 ++++++++++++++++++++
 kernel/linux/uapi/version                  |    2 +-
 lib/eal/include/rte_vfio.h                 |   90 +-
 lib/eal/linux/eal.c                        |    4 -
 lib/eal/linux/eal_interrupts.c             |   28 +-
 lib/eal/linux/eal_vfio.c                   |  126 +-
 lib/eal/linux/eal_vfio.h                   |   79 -
 lib/eal/linux/eal_vfio_mp_sync.c           |   10 -
 lib/vhost/vduse.c                          |    4 +-
 42 files changed, 1979 insertions(+), 429 deletions(-)
 create mode 100644 kernel/linux/uapi/linux/vfio.h

-- 
2.51.0

