Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0A9CCD98F6
	for <dpdk-dev@archiver.kernel.org>; Thu, 18 Jun 2026 15:28:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D52414027F;
	Thu, 18 Jun 2026 17:28:37 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 22EE640268
 for <dev@dpdk.org>; Thu, 18 Jun 2026 17:28:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781796515;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mHhkpZVT4Or+TgG97wcJ/jNMqJVBT8kF23xGr7UsP2g=;
 b=IDX4FN383VcJyv2tcMaI9dV7O7ZK4XaOaJfweVS1oSm/Q3Z4LxqUU5ziWGbCoeLFI5vJqv
 4ysXArGteMT/nsO96xxWHy82PDur2tTFe2eiAPBsikocDPe6GTCSJQZ1+w9iVmPhscmwwy
 rG1rHfuwuPs/1PDt/jeKZHl7YcDV1QI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-167-cAaXRKs1NYSLrqO8HmI5Aw-1; Thu,
 18 Jun 2026 11:28:34 -0400
X-MC-Unique: cAaXRKs1NYSLrqO8HmI5Aw-1
X-Mimecast-MFC-AGG-ID: cAaXRKs1NYSLrqO8HmI5Aw_1781796512
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 557821955F26; Thu, 18 Jun 2026 15:28:32 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.50.197])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AC7231956045; Thu, 18 Jun 2026 15:28:29 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, stephen@networkplumber.org,
 bruce.richardson@intel.com, fengchengwen@huawei.com, longli@microsoft.com,
 hemant.agrawal@nxp.com
Subject: [PATCH v2 00/10] Bus cleanup infrastructure and fixes
Date: Thu, 18 Jun 2026 17:28:15 +0200
Message-ID: <20260618152826.490569-1-david.marchand@redhat.com>
In-Reply-To: <20260611094551.1514962-1-david.marchand@redhat.com>
References: <20260611094551.1514962-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: TbWel6e7S2zaTPoTdipoWoqF8PLHA9sVliE0msapnIo_1781796512
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

Changes since v1:
- dropped all changes on DPAA and FSLMC bus,
- added one more cleanup on the first patch,
- changed coding style in rte_vdev_init,
- implemented explicit .free_device instead of hack for calling free(),
- reordered interrupt handle allocation in VMBUS bus,

David Marchand (10):
  bus: fix reference to plug callback
  dma/idxd: remove next pointer in bus specific device
  bus/vdev: remove driver setting in probe
  bus/pci: fix mapping leak in bus cleanup
  bus/vmbus: fix interrupt leak in cleanup
  bus/vmbus: allocate interrupt during probing
  bus: align unplug with device probe
  bus: implement cleanup in EAL
  bus/vmbus: store name in bus specific device
  bus/vmbus: support unplug

 doc/guides/prog_guide/device_hotplug.rst | 20 ++++---
 doc/guides/rel_notes/release_26_07.rst   |  4 ++
 drivers/bus/auxiliary/auxiliary_common.c | 54 ++++-------------
 drivers/bus/cdx/cdx.c                    | 29 ++-------
 drivers/bus/dpaa/dpaa_bus.c              |  4 +-
 drivers/bus/fslmc/fslmc_bus.c            |  9 +--
 drivers/bus/ifpga/ifpga_bus.c            | 67 ++++++---------------
 drivers/bus/pci/pci_common.c             | 68 +++------------------
 drivers/bus/platform/platform.c          | 26 +++-----
 drivers/bus/uacce/uacce.c                | 59 +++---------------
 drivers/bus/vdev/vdev.c                  | 76 +++++++++---------------
 drivers/bus/vmbus/bus_vmbus_driver.h     |  1 +
 drivers/bus/vmbus/linux/vmbus_bus.c      | 16 +----
 drivers/bus/vmbus/vmbus_common.c         | 58 +++++++++++-------
 drivers/dma/idxd/idxd_bus.c              |  1 -
 lib/eal/common/eal_common_bus.c          | 33 +++++++++-
 lib/eal/common/eal_common_dev.c          | 10 ++--
 lib/eal/include/bus_driver.h             | 51 +++++++++++-----
 18 files changed, 222 insertions(+), 364 deletions(-)

-- 
2.53.0

