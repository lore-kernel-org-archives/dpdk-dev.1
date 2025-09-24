Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07EC8CAC5AE
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Sep 2025 17:25:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E32504065C;
	Wed, 24 Sep 2025 19:25:45 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id F2B2140615
 for <dev@dpdk.org>; Wed, 24 Sep 2025 19:25:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758734743;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hqMQBMULUwx44pWAgoiTHsU352ze5MGFU3AR95aTVfI=;
 b=CO5zfA+zipJ6yTg3bY9ultOaC17k+PgwYG+sxaAutmp8FKmKjARtgdy15Rrr3OjB/f2VNX
 CIczK+SHFacbvFTTM6KgAlZ1KvpY4k+Vn68ue7l9jyz5rPElI85+5Soah2GM0qTf1DrsEy
 exRt6aFxo6ATbgdLdYEr1l3wPojVZMw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-92-6wn8Un0IOtajGWw1Mbcm4A-1; Wed,
 24 Sep 2025 13:25:42 -0400
X-MC-Unique: 6wn8Un0IOtajGWw1Mbcm4A-1
X-Mimecast-MFC-AGG-ID: 6wn8Un0IOtajGWw1Mbcm4A_1758734741
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 446671956050
 for <dev@dpdk.org>; Wed, 24 Sep 2025 17:25:41 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.45.225.72])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4D56219560B1
 for <dev@dpdk.org>; Wed, 24 Sep 2025 17:25:39 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Subject: [PATCH v3 0/7] Add a stricter headers check
Date: Wed, 24 Sep 2025 19:25:28 +0200
Message-ID: <20250924172536.2447183-1-david.marchand@redhat.com>
In-Reply-To: <20241127112617.1331125-1-david.marchand@redhat.com>
References: <20241127112617.1331125-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: YR4iE75v_1SOWuPyY24Mz4eNL4YpmduMbAPZPZ2B5o0_1758734741
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

As explained in patch 6, the current headers check can not catch
issues when a public header includes an internal header.

Patch 1-5 fixes have not been marked as backport material as those bugs
seems minor/easy to fix externally (by either including missing headers,
or enabling enable_driver_sdk option).


-- 
David Marchand

Changes since v2:
- major rework, dropping the makefile approach, and instead copying
  headers to a staging directory used by the check,
- rebased,
- dropped changes on raw cnxk drivers and disabled the associated
  build warning in the headers check,

David Marchand (7):
  baseband/acc: fix exported header
  drivers: drop export of driver headers
  eventdev: do not include driver header in DMA adapter
  gpudev: fix driver header for Windows
  drivers: fix some exported headers
  buildtools/chkincs: use a staging directory for headers
  power: separate public and driver headers

 MAINTAINERS                                   |  3 ++
 buildtools/chkincs/meson.build                | 41 +++++++++----------
 buildtools/meson.build                        |  1 +
 buildtools/stage-headers.py                   | 32 +++++++++++++++
 drivers/baseband/acc/meson.build              |  2 +-
 drivers/bus/vmbus/rte_vmbus_reg.h             |  6 +++
 drivers/crypto/cnxk/rte_pmd_cnxk_crypto.h     |  2 +
 drivers/meson.build                           | 28 +++++++++++--
 drivers/net/dpaa/rte_pmd_dpaa.h               |  2 +
 drivers/net/intel/iavf/rte_pmd_iavf.h         |  6 +++
 drivers/net/mlx5/rte_pmd_mlx5.h               |  3 ++
 drivers/raw/dpaa2_cmdif/rte_pmd_dpaa2_cmdif.h |  2 +
 drivers/raw/ntb/rte_pmd_ntb.h                 |  2 +
 lib/bbdev/meson.build                         | 14 ++++---
 lib/eal/include/meson.build                   |  8 ++++
 lib/eal/meson.build                           | 10 +++++
 lib/ethdev/meson.build                        |  6 +--
 lib/eventdev/rte_event_dma_adapter.h          |  2 +-
 lib/gpudev/gpudev.c                           |  1 +
 lib/gpudev/gpudev_driver.h                    |  4 +-
 lib/meson.build                               | 41 +++++++++++++++----
 lib/mldev/meson.build                         |  5 +--
 lib/power/meson.build                         |  7 +++-
 lib/power/power_cpufreq.h                     | 14 +------
 lib/power/power_uncore_ops.h                  |  1 +
 lib/power/rte_power_cpufreq.c                 |  2 +-
 lib/power/rte_power_cpufreq.h                 | 15 ++++++-
 lib/power/rte_power_uncore.c                  |  2 +-
 lib/power/rte_power_uncore.h                  |  3 +-
 lib/rawdev/meson.build                        |  3 +-
 lib/regexdev/meson.build                      |  3 +-
 lib/security/meson.build                      |  3 +-
 meson.build                                   |  4 ++
 staging/drivers/meson.build                   |  5 +++
 staging/meson.build                           |  7 ++++
 35 files changed, 217 insertions(+), 73 deletions(-)
 create mode 100644 buildtools/stage-headers.py
 create mode 100644 staging/drivers/meson.build
 create mode 100644 staging/meson.build

-- 
2.51.0

