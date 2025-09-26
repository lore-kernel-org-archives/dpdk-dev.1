Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AD9BCAC5B9
	for <dpdk-dev@archiver.kernel.org>; Fri, 26 Sep 2025 12:41:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 19F08402B5;
	Fri, 26 Sep 2025 14:41:18 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id EED434025D
 for <dev@dpdk.org>; Fri, 26 Sep 2025 14:41:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758890475;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aFGD7mdgI/YY8FyhQKHlcP+pLV9XSFGhO4TB8QWOB6o=;
 b=PiW6FS82cRTH9YaSLcvSEp70BnNr8gdT5ql/ZA7GPyH4Qc48PhR3Ld3GjpZsXwfhbxNk/f
 e3y52F1TSSEXVfCOuVeWqh8fn4aurF/PYGySmHN92q7cGn9beP1bji+qxQFntuVYL0oIZc
 mAkLoYZbng7KoE+JN6OpOzzd54RPA44=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-79-akfIz92TPi65b8i9tRGZ9g-1; Fri,
 26 Sep 2025 08:41:14 -0400
X-MC-Unique: akfIz92TPi65b8i9tRGZ9g-1
X-Mimecast-MFC-AGG-ID: akfIz92TPi65b8i9tRGZ9g_1758890473
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 326C9180048E; Fri, 26 Sep 2025 12:41:13 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.45.225.72])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 164B01800579; Fri, 26 Sep 2025 12:41:11 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com
Subject: [PATCH v5 0/9] Add a stricter headers check
Date: Fri, 26 Sep 2025 14:40:53 +0200
Message-ID: <20250926124103.750844-1-david.marchand@redhat.com>
In-Reply-To: <20241127112617.1331125-1-david.marchand@redhat.com>
References: <20241127112617.1331125-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _UhXOgQP4pTRJDeod8vIxGJy2EBIrqDVaIPIZk5RDvU_1758890473
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

As explained in patch 8, the current headers check can not catch
issues when a public header includes an internal header.

Patch 1-5 fixes have not been marked as backport material as those bugs
seems minor/easy to fix externally (by either including missing headers,
or enabling enable_driver_sdk option).


-- 
David Marchand

Changes since v4:
- reworked headers install,
- fixed issue in ARM memcpy header,
- further simplified the header check modifications,

Changes since v3:
- narrowed down the changes under a check on check_includes= option,
- moved the staging directories under buildtools/chkincs,

Changes since v2:
- major rework, dropping the makefile approach, and instead copying
  headers to a staging directory used by the check,
- rebased,
- dropped changes on raw cnxk drivers and disabled the associated
  build warning in the headers check,

David Marchand (9):
  baseband/acc: fix exported header
  drivers: drop export of driver headers
  eventdev: do not include driver header in DMA adapter
  gpudev: fix driver header for Windows
  drivers: fix some exported headers
  eal/arm: fix C++ build for 32-bit memcpy
  build: factorize headers installation
  buildtools/chkincs: use a staging directory for headers
  power: separate public and driver headers

 buildtools/chkincs/meson.build                | 70 +++++++++++++++----
 buildtools/chkincs/stage-headers.py           | 32 +++++++++
 .../chkincs/staging/drivers/meson.build       | 12 ++++
 buildtools/chkincs/staging/meson.build        | 30 ++++++++
 config/meson.build                            |  3 +-
 devtools/checkpatches.sh                      |  9 +++
 drivers/baseband/acc/meson.build              |  2 +-
 drivers/bus/vmbus/rte_vmbus_reg.h             |  6 ++
 drivers/crypto/cnxk/rte_pmd_cnxk_crypto.h     |  2 +
 drivers/meson.build                           |  7 +-
 drivers/net/dpaa/rte_pmd_dpaa.h               |  2 +
 drivers/net/intel/iavf/rte_pmd_iavf.h         |  6 ++
 drivers/net/mlx5/rte_pmd_mlx5.h               |  3 +
 drivers/net/txgbe/meson.build                 |  2 +-
 drivers/raw/dpaa2_cmdif/rte_pmd_dpaa2_cmdif.h |  2 +
 drivers/raw/ntb/rte_pmd_ntb.h                 |  2 +
 lib/bbdev/meson.build                         | 14 ++--
 lib/eal/arm/include/meson.build               |  3 +-
 lib/eal/arm/include/rte_memcpy_32.h           |  6 +-
 lib/eal/include/meson.build                   |  3 +-
 lib/eal/loongarch/include/meson.build         |  3 +-
 lib/eal/ppc/include/meson.build               |  3 +-
 lib/eal/riscv/include/meson.build             |  3 +-
 lib/eal/x86/include/meson.build               |  6 +-
 lib/ethdev/meson.build                        |  6 +-
 lib/eventdev/rte_event_dma_adapter.h          |  2 +-
 lib/gpudev/gpudev.c                           |  1 +
 lib/gpudev/gpudev_driver.h                    |  4 +-
 lib/meson.build                               | 10 +--
 lib/mldev/meson.build                         |  5 +-
 lib/power/meson.build                         |  7 +-
 lib/power/power_cpufreq.h                     | 14 +---
 lib/power/power_uncore_ops.h                  |  1 +
 lib/power/rte_power_cpufreq.c                 |  2 +-
 lib/power/rte_power_cpufreq.h                 | 15 +++-
 lib/power/rte_power_uncore.c                  |  2 +-
 lib/power/rte_power_uncore.h                  |  3 +-
 lib/rawdev/meson.build                        |  3 +-
 lib/regexdev/meson.build                      |  3 +-
 lib/security/meson.build                      |  3 +-
 meson.build                                   | 21 ++++--
 41 files changed, 247 insertions(+), 86 deletions(-)
 create mode 100644 buildtools/chkincs/stage-headers.py
 create mode 100644 buildtools/chkincs/staging/drivers/meson.build
 create mode 100644 buildtools/chkincs/staging/meson.build

-- 
2.51.0

