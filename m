Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B26CF3D331
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Mar 2026 16:46:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5255C4029D;
	Thu,  5 Mar 2026 17:46:15 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id EBADB40287
 for <dev@dpdk.org>; Thu,  5 Mar 2026 17:46:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772729172;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GKdyqjfVQx/obpp+ViVobj3Mdifm8H5yFyHEQBi9WEs=;
 b=Vf7Zvhk6ltgkzkWn7K7uR3+WdrUOJ3vCeCQi62ho6Sgwz6HHNgx9h5CtHQEpuU1SFyHHmR
 5F65wKxCr1MonzS47SaPzW+gGfG9OM6WlSWJeaQ+LiSwJI6KEOz9WYU6HYmsdk073Toipe
 yRCNMullszR64QlXSRYqPT0nwFU6ggo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-448-T0GBzbdIPS-NqBmoRziVng-1; Thu,
 05 Mar 2026 11:46:11 -0500
X-MC-Unique: T0GBzbdIPS-NqBmoRziVng-1
X-Mimecast-MFC-AGG-ID: T0GBzbdIPS-NqBmoRziVng_1772729170
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6479F18909BD
 for <dev@dpdk.org>; Thu,  5 Mar 2026 16:46:00 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.45.224.121])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 99D211800361
 for <dev@dpdk.org>; Thu,  5 Mar 2026 16:45:59 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Subject: [RFC v3 0/7] Rework device probing
Date: Thu,  5 Mar 2026 17:45:42 +0100
Message-ID: <20260305164550.2067453-1-david.marchand@redhat.com>
In-Reply-To: <20260225112922.3982104-1-david.marchand@redhat.com>
References: <20260225112922.3982104-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 33Cw90qioxIcyaA77bT2JhRm5LiA0b0gaQvR5llSQN8_1772729170
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
 drivers/bus/fslmc/fslmc_vfio.c               | 22 ++----
 drivers/bus/ifpga/bus_ifpga_driver.h         |  2 -
 drivers/bus/ifpga/ifpga_bus.c                |  4 +-
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
 drivers/raw/ifpga/ifpga_rawdev.c             |  2 +-
 lib/eal/common/eal_common_bus.c              | 44 ++++++++++++
 lib/eal/common/eal_common_options.c          | 10 +++
 lib/eal/common/eal_internal_cfg.h            |  1 +
 lib/eal/common/eal_option_list.h             |  2 +
 lib/eal/include/bus_driver.h                 | 37 ++++++++++
 31 files changed, 288 insertions(+), 364 deletions(-)

-- 
2.53.0

