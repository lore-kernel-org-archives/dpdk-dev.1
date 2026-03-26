Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE048106F31D
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Mar 2026 10:24:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 01E03402F1;
	Thu, 26 Mar 2026 11:24:58 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 503E1402B5
 for <dev@dpdk.org>; Thu, 26 Mar 2026 11:24:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774520695;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RGNsK3ZhHS0xIs50H+oRVJzeq4EKeFHXIdkaxohLW4k=;
 b=f5Y5rFNM2w551SpyewqubUr4JuCwope9Df6B0SO1QxM03pQyBNKELiE67qcHaPnA3bGWoE
 M42N6Q3KaNZ1QCvY4N09GjduhmYJ1p2xorC4iO5QW337dX05eE9y6z1AoUYu97sawfCYK8
 m69Ep8iYRjDgselcVyqXddfZgpSwPfg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-711-UP6vDv0UNk2RiRNyj0OQ4A-1; Thu,
 26 Mar 2026 06:24:53 -0400
X-MC-Unique: UP6vDv0UNk2RiRNyj0OQ4A-1
X-Mimecast-MFC-AGG-ID: UP6vDv0UNk2RiRNyj0OQ4A_1774520692
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B1DFF19560AA
 for <dev@dpdk.org>; Thu, 26 Mar 2026 10:24:52 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.33.173])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id ECDAD3000223
 for <dev@dpdk.org>; Thu, 26 Mar 2026 10:24:51 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Subject: [PATCH v2 0/7] Rework device probing
Date: Thu, 26 Mar 2026 11:24:16 +0100
Message-ID: <20260326102424.2361945-1-david.marchand@redhat.com>
In-Reply-To: <20260323105306.1531689-1-david.marchand@redhat.com>
References: <20260323105306.1531689-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 4CMmPlYYl01n-fjG-PptJkWd7dDg4Nkf_HI30XDEQUY_1774520692
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

Applications relying on device hotplug don't work well with the default
probing of all available resources.
This series proposes to change this behavior via a new EAL option.


-- 
David Marchand

Changes since v1:
- restored per bus scan mode,
- fixed logic in device selection for dma/idxd,
- fixed raw/ifpga hotplug on ifpga bus,
- fixed some doxygen,

Changes since RFC v3:
- removed per bus scan mode,

Changes since RFC v2:
- went one step further and reworked devargs lookup in buses following
  Bruce comment (see patch 4 which is cosmetic, and patch 5),
- updated device selection helper accordingly and
  changed API to be device name based,
- renamed option, added check on -b presence, updated doc in the last
  patch,

Changes since RFC v1:
- reviewed bus probe() and cleaned up NXP drivers,
- changed approach following Bruce comment,

David Marchand (7):
  devtools: check packet forwarding in null test
  bus/fslmc: fix bus cleanup
  drivers/bus: require probe function for NXP drivers
  drivers: cleanup devargs lookup in bus scan
  bus: factorize devargs lookup
  bus: factorize device selection
  eal: configure initial device probing

 app/test/test_eal_flags.c                    | 63 +++++++++++++++++
 devtools/test-null.sh                        | 10 ++-
 doc/guides/linux_gsg/eal_args.include.rst    | 13 ++++
 drivers/bus/auxiliary/auxiliary_common.c     | 33 +--------
 drivers/bus/auxiliary/bus_auxiliary_driver.h |  2 -
 drivers/bus/auxiliary/linux/auxiliary.c      |  2 +-
 drivers/bus/auxiliary/private.h              |  6 --
 drivers/bus/cdx/cdx.c                        | 34 +---------
 drivers/bus/dpaa/dpaa_bus.c                  | 71 +++++++++-----------
 drivers/bus/fslmc/fslmc_bus.c                | 69 ++++++++-----------
 drivers/bus/fslmc/fslmc_vfio.c               | 21 ++----
 drivers/bus/ifpga/ifpga_bus.c                |  8 ++-
 drivers/bus/pci/bsd/pci.c                    |  5 +-
 drivers/bus/pci/linux/pci.c                  |  2 +-
 drivers/bus/pci/pci_common.c                 | 51 ++++----------
 drivers/bus/pci/private.h                    | 11 ---
 drivers/bus/pci/windows/pci.c                |  4 +-
 drivers/bus/platform/platform.c              | 43 +-----------
 drivers/bus/uacce/uacce.c                    | 39 +----------
 drivers/bus/vdev/vdev.c                      |  2 +-
 drivers/bus/vmbus/linux/vmbus_bus.c          |  2 +-
 drivers/bus/vmbus/private.h                  |  3 -
 drivers/bus/vmbus/vmbus_common.c             | 45 +++----------
 drivers/dma/idxd/idxd_bus.c                  | 18 +----
 lib/eal/common/eal_common_bus.c              | 44 ++++++++++++
 lib/eal/common/eal_common_options.c          | 10 +++
 lib/eal/common/eal_internal_cfg.h            |  1 +
 lib/eal/common/eal_option_list.h             |  2 +
 lib/eal/include/bus_driver.h                 | 38 +++++++++++
 29 files changed, 290 insertions(+), 362 deletions(-)

-- 
2.53.0

