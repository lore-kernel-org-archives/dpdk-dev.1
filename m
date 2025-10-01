Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F73FCCA470
	for <dpdk-dev@archiver.kernel.org>; Wed,  1 Oct 2025 06:45:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9B45D402AF;
	Wed,  1 Oct 2025 08:45:27 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 42B06400EF
 for <dev@dpdk.org>; Wed,  1 Oct 2025 08:45:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759301125;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qoAXinDBsSl/pwzn9aiNM/hYp96hMb9C3Bz+nsSe5M4=;
 b=Y16mQPpBuwrNvUjr6EOkRnmWoUTA6Gv5TSdwCgHzLY+wsAxjPkb0UmnzbzpHdxnz3AEF3p
 kO81TT9cslMpHG6KPB5p+MzkSK1+vfupD2RWdoNDbzbGhofALgIKAaa9klZ/+NcwuvyXCV
 VuQy5M5nj5G09EI59izUHU1s/2yXyJ4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-612-t6S0Z6LeNeGr_-PEyF-pVw-1; Wed,
 01 Oct 2025 02:45:24 -0400
X-MC-Unique: t6S0Z6LeNeGr_-PEyF-pVw-1
X-Mimecast-MFC-AGG-ID: t6S0Z6LeNeGr_-PEyF-pVw_1759301123
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4FCD71800578; Wed,  1 Oct 2025 06:45:23 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.45.224.213])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E8BCC1800452; Wed,  1 Oct 2025 06:45:21 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com
Subject: [PATCH v7 0/9] Add a stricter headers check
Date: Wed,  1 Oct 2025 08:45:02 +0200
Message-ID: <20251001064512.2539269-1-david.marchand@redhat.com>
In-Reply-To: <20241127112617.1331125-1-david.marchand@redhat.com>
References: <20241127112617.1331125-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: GsNe-ESmnmzays7Q_Xaa74y4Gq7wtqnxY9z7rHNCjyc_1759301123
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

Changes since v6:
- a rabbit told me I should fix driver headers include path:
  https://github.com/david-marchand/dpdk/pull/2#discussion_r2390690589,

Changes since v5:
- added headers staging cleanup,

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

 buildtools/chkincs/meson.build                | 68 +++++++++++++++----
 .../chkincs/staging/drivers/meson.build       | 13 ++++
 buildtools/chkincs/staging/meson.build        | 43 ++++++++++++
 buildtools/chkincs/staging/stage-headers.py   | 50 ++++++++++++++
 config/meson.build                            |  3 +-
 devtools/checkpatches.sh                      |  8 +++
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
 41 files changed, 276 insertions(+), 86 deletions(-)
 create mode 100644 buildtools/chkincs/staging/drivers/meson.build
 create mode 100644 buildtools/chkincs/staging/meson.build
 create mode 100755 buildtools/chkincs/staging/stage-headers.py

-- 
2.51.0

