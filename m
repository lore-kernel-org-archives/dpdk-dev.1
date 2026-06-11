Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D123FCD98CC
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Jun 2026 09:46:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B4CE342F7A;
	Thu, 11 Jun 2026 11:46:10 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 7F5044026A
 for <dev@dpdk.org>; Thu, 11 Jun 2026 11:46:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781171169;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=9KrtLBnm2c0cxQRkgq13ENNsnfcjDOYnkpSddWOIMT4=;
 b=Y80L0Qm1r2jKfXydfb6pYrrGzAG5p2fuMAmsfGogDkdsycR58aVukdKgh8L8+v2ZzCLT4n
 3RDnds3g8VnHgO3XPVjVjv5hScS0qVCroq4remjpgeZAyKX4hi6fXDogjK2FgrkUrXsUpA
 jpJ1/X4PHRASAotkA71l/PHy/asasH0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-683-qcNV0sMhMsuTJONTD1BVWg-1; Thu,
 11 Jun 2026 05:46:05 -0400
X-MC-Unique: qcNV0sMhMsuTJONTD1BVWg-1
X-Mimecast-MFC-AGG-ID: qcNV0sMhMsuTJONTD1BVWg_1781171164
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 133261808954; Thu, 11 Jun 2026 09:46:04 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.33.28])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D9BCF18005B3; Thu, 11 Jun 2026 09:46:01 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, stephen@networkplumber.org,
 bruce.richardson@intel.com, fengchengwen@huawei.com
Subject: [PATCH 00/13] Bus cleanup infrastructure and fixes
Date: Thu, 11 Jun 2026 11:45:37 +0200
Message-ID: <20260611094551.1514962-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 6qNVLEaD1CwOpdlhWGv3tAfq7RIpQmsv9GLSP7QhBpk_1781171164
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

The first part of the series (patches 1-8) addresses several bugs and
inconsistencies:
- Documentation and log message inconsistencies from earlier bus
  refactoring
- Device list management issues in dma/idxd and bus/vdev
- Resource leaks in PCI and VMBUS bus cleanup (mappings and interrupts)
- Simplified device freeing in NXP buses (DPAA and FSLMC)
- Deferred interrupt allocation to probe time (NXP buses, VMBUS)

The core infrastructure changes (patches 9-10) introduce the generic
cleanup framework:
- Refactors unplug operations to be the counterpart of probe_device
- Implements rte_bus_generic_cleanup() to centralize cleanup logic
- Adds .free_device operation to struct rte_bus
- Adds compile-time verification that rte_device is at offset 0

The final patches (11-13) convert remaining buses to use the generic
cleanup helper:
- DPAA bus: add unplug support
- VMBUS bus: switch to embedded device name and add unplug support

After this series, most buses use the generic cleanup helper, eliminating
duplicated code and ensuring consistent cleanup behavior across the
codebase.


-- 
David Marchand

David Marchand (13):
  bus: fix reference to plug callback
  dma/idxd: remove next pointer in bus specific device
  bus/vdev: remove driver setting in probe
  drivers/bus: cleanup device freeing in NXP bus
  drivers/bus: allocate interrupt during probing in NXP bus
  bus/pci: fix mapping leak in bus cleanup
  bus/vmbus: fix interrupt leak in cleanup
  bus/vmbus: allocate interrupt during probing
  bus: align unplug with device probe
  bus: implement cleanup in EAL
  bus/dpaa: support unplug
  bus/vmbus: store name in bus specific device
  bus/vmbus: support unplug

 doc/guides/prog_guide/device_hotplug.rst | 20 +++--
 doc/guides/rel_notes/release_26_07.rst   |  8 ++
 drivers/bus/auxiliary/auxiliary_common.c | 56 +++-----------
 drivers/bus/cdx/cdx.c                    | 31 ++------
 drivers/bus/dpaa/dpaa_bus.c              | 96 ++++++++++--------------
 drivers/bus/fslmc/fslmc_bus.c            | 55 ++++++--------
 drivers/bus/ifpga/ifpga_bus.c            | 65 ++++------------
 drivers/bus/pci/pci_common.c             | 69 +++--------------
 drivers/bus/platform/platform.c          | 28 ++-----
 drivers/bus/uacce/uacce.c                | 61 ++-------------
 drivers/bus/vdev/vdev.c                  | 71 ++++++------------
 drivers/bus/vmbus/bus_vmbus_driver.h     |  1 +
 drivers/bus/vmbus/linux/vmbus_bus.c      | 16 +---
 drivers/bus/vmbus/vmbus_common.c         | 56 ++++++++------
 drivers/dma/idxd/idxd_bus.c              |  3 +-
 lib/eal/common/eal_common_bus.c          | 33 +++++++-
 lib/eal/common/eal_common_dev.c          | 10 ++-
 lib/eal/include/bus_driver.h             | 42 ++++++++++-
 18 files changed, 268 insertions(+), 453 deletions(-)

-- 
2.53.0

