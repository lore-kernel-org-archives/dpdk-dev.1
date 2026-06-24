Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCD07CDE000
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Jun 2026 10:43:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1D2A940659;
	Wed, 24 Jun 2026 12:43:38 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 9491C40616
 for <dev@dpdk.org>; Wed, 24 Jun 2026 12:43:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782297816;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pAYxBpkLojOILp0UsV1b+1wjBMUZr7Jxf4lQ7gvrCik=;
 b=bHhwFZSG+ePBE+CJT/SNwEX2lYqbKZr7rjhJsxjed3AKgLa77UpRJxPvdL//xmgq8JgvDC
 x3b9gLX6z/EGoC5Sjmy2DqsNZH0i494OjA+kBijEQQiAd+esM2Vrw60xfvI9b8xFnmpXGd
 5+trDhMugTbHBEGLskuJ4MWXaeN3Gs4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-155-yMfzaXoGODCLaUB5OY8OaQ-1; Wed,
 24 Jun 2026 06:43:32 -0400
X-MC-Unique: yMfzaXoGODCLaUB5OY8OaQ-1
X-Mimecast-MFC-AGG-ID: yMfzaXoGODCLaUB5OY8OaQ_1782297811
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6741C1800581; Wed, 24 Jun 2026 10:43:30 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.48.202])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AB3B336921; Wed, 24 Jun 2026 10:43:27 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, stephen@networkplumber.org,
 bruce.richardson@intel.com, fengchengwen@huawei.com, longli@microsoft.com,
 hemant.agrawal@nxp.com
Subject: [PATCH v4 00/12] Bus cleanup infrastructure and fixes
Date: Wed, 24 Jun 2026 12:43:11 +0200
Message-ID: <20260624104324.3576408-1-david.marchand@redhat.com>
In-Reply-To: <20260611094551.1514962-1-david.marchand@redhat.com>
References: <20260611094551.1514962-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: bih0fIuoPHcFQtFgDADup6mZ0CD3hUmikeqZ77R4g9A_1782297811
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

This is a followup of the previous bus refactoring.
See https://inbox.dpdk.org/dev/CAJFAV8zvFpLwz8SY8DUUezyJyM43eRZ17Yj30ex808eHC4ZE=g@mail.gmail.com/.

This series refactors the bus cleanup infrastructure to reduce code
duplication and fix resource leaks in several bus drivers.
It should address the leak Thomas pointed at.

The first part of the series (patches 1-6) addresses several bugs and
inconsistencies:
- Documentation and log message inconsistencies from earlier bus
  refactoring
- Device list management issues in dma/idxd and bus/vdev
- Resource leaks in PCI and VMBUS bus cleanup (mappings and interrupts)
- Deferred interrupt allocation to probe time (VMBUS)

The core infrastructure changes (patches 7-8) introduce the generic
cleanup framework:
- Refactors unplug operations to be the counterpart of probe_device
- Implements rte_bus_generic_cleanup() to centralize cleanup logic
- Adds .free_device operation to struct rte_bus

The final patches (9-10) convert the VMBUS bus to use the generic
cleanup helper.

After this series, most buses use the generic cleanup helper, eliminating
duplicated code and ensuring consistent cleanup behavior across the
codebase.

NXP bus drivers require more (leak) fixes and refactoring and
are left untouched.


-- 
David Marchand

Changes since v3:
- added fix on vdpa/nfp,

Changes since v2:
- moved ifpga interruption allocation,

Changes since v1:
- dropped all changes on DPAA and FSLMC bus,
- added one more cleanup on the first patch,
- changed coding style in rte_vdev_init,
- implemented explicit .free_device instead of hack for calling free(),
- reordered interrupt handle allocation in VMBUS bus,


David Marchand (12):
  bus: fix reference to plug callback
  dma/idxd: remove next pointer in bus specific device
  bus/vdev: remove driver setting in probe
  vdpa/nfp: fix double PCI unmap on unplug
  bus/pci: fix mapping leak in bus cleanup
  bus/vmbus: fix interrupt leak in cleanup
  bus/vmbus: allocate interrupt during probing
  bus/ifpga: allocate interrupt during probing
  bus: align unplug with device probe
  bus: implement cleanup in EAL
  bus/vmbus: store name in bus specific device
  bus/vmbus: support unplug

 doc/guides/prog_guide/device_hotplug.rst | 20 +++---
 doc/guides/rel_notes/release_26_07.rst   |  4 ++
 drivers/bus/auxiliary/auxiliary_common.c | 54 +++------------
 drivers/bus/cdx/cdx.c                    | 29 ++------
 drivers/bus/dpaa/dpaa_bus.c              |  4 +-
 drivers/bus/fslmc/fslmc_bus.c            |  9 +--
 drivers/bus/ifpga/ifpga_bus.c            | 88 ++++++++----------------
 drivers/bus/pci/pci_common.c             | 68 +++---------------
 drivers/bus/platform/platform.c          | 26 ++-----
 drivers/bus/uacce/uacce.c                | 59 +++-------------
 drivers/bus/vdev/vdev.c                  | 76 ++++++++------------
 drivers/bus/vmbus/bus_vmbus_driver.h     |  1 +
 drivers/bus/vmbus/linux/vmbus_bus.c      | 16 +----
 drivers/bus/vmbus/vmbus_common.c         | 58 +++++++++-------
 drivers/dma/idxd/idxd_bus.c              |  1 -
 drivers/vdpa/nfp/nfp_vdpa.c              |  4 +-
 lib/eal/common/eal_common_bus.c          | 33 ++++++++-
 lib/eal/common/eal_common_dev.c          | 10 +--
 lib/eal/include/bus_driver.h             | 51 +++++++++-----
 19 files changed, 235 insertions(+), 376 deletions(-)

-- 
2.54.0

