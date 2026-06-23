Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 567D4CDB471
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Jun 2026 16:51:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4DADC402E5;
	Tue, 23 Jun 2026 18:51:58 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id 87D2E40150
 for <dev@dpdk.org>; Tue, 23 Jun 2026 18:51:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782233517; x=1813769517;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=YLqW2tqnP1eAQluNMeABvGWaEExFfBCLSyl9moch/HU=;
 b=HngSUNQTF0kSPOP1Sjy+5PYA1VcrfYNxoxFf9aN8adSpIZpnzbtw9NqY
 y6SKScUVEnH9/ri/w+R9nyWFL79bTDs3xYUYbEuFoMwbGeeWwn0vouLWL
 3Pf1mFTmG9J3hPahko2GxO8wwLx/I0YodFADbqaPWS1PyyA4FjGqzn/IT
 51LPXR0o+J5tn0l3Al84FojcOohGOYsv7rQKv3rmc0E7xejjALFebHRtj
 43vieRF/twkwAw4HQROb/A4Avu67VD+a7ZjFU+hKSK5h/poDnHsm3ZXXV
 06DOv96bd44ZKX7cHxRZCiSDhDukApkiSE+vTmlnrzpNu54QR0AKIFQ86 Q==;
X-CSE-ConnectionGUID: gGOa9FmYRD676qyEkHgScA==
X-CSE-MsgGUID: zcOPNJsQSeGA6iqT0JBMzA==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="100534612"
X-IronPort-AV: E=Sophos;i="6.24,221,1774335600"; d="scan'208";a="100534612"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2026 09:51:56 -0700
X-CSE-ConnectionGUID: 95/LE82tQ6ek7AQ3rF/usg==
X-CSE-MsgGUID: 0XGBcGkORv22NiOlVvFYXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,221,1774335600"; d="scan'208";a="253928274"
Received: from silpixa00401385.ir.intel.com (HELO
 localhost.ger.corp.intel.com) ([10.20.224.226])
 by orviesa004.jf.intel.com with ESMTP; 23 Jun 2026 09:51:54 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH 00/17] drivers: replace strncpy with strlcpy
Date: Tue, 23 Jun 2026 17:51:30 +0100
Message-ID: <20260623165150.765443-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
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

Many uses of strncpy in DPDK drivers can be directly replaced by
a call to strlcpy instead, which is safer in that it always null-
terminates the string. This AI assisted patchset makes those
simple replacements, adjusting lengths as appropriate.

After this set, there are still a number of drivers with strncpy calls
in them, but those are not simple strncpy->strlcpy replacements, so
left for later rework.

Bruce Richardson (17):
  common/cnxk: replace strncpy with strlcpy
  common/mlx5: replace strncpy with strlcpy
  crypto/mvsam: replace strncpy with strlcpy
  crypto/scheduler: replace strncpy with strlcpy
  event/cnxk: replace strncpy with strlcpy
  net/ark: replace strncpy with strlcpy
  net/bnx2x: replace strncpy with strlcpy
  net/cnxk: replace strncpy with strlcpy
  net/dpaa: replace strncpy with strlcpy
  net/ionic: replace strncpy with strlcpy
  net/mlx4: replace strncpy with strlcpy
  net/mlx5: replace strncpy with strlcpy
  net/nfp: replace strncpy with strlcpy
  net/qede: replace strncpy with strlcpy
  net/softnic: replace strncpy with strlcpy
  net/vhost: replace strncpy with strlcpy
  net/virtio: replace strncpy with strlcpy

 drivers/common/cnxk/roc_model.c                   | 8 ++++----
 drivers/common/mlx5/linux/mlx5_common_os.c        | 2 +-
 drivers/crypto/mvsam/rte_mrvl_pmd.c               | 2 +-
 drivers/crypto/scheduler/scheduler_pmd.c          | 8 ++++----
 drivers/event/cnxk/cnxk_eventdev_stats.c          | 2 +-
 drivers/net/ark/ark_ethdev.c                      | 2 +-
 drivers/net/bnx2x/bnx2x.c                         | 2 +-
 drivers/net/bnx2x/bnx2x_vfpf.c                    | 2 +-
 drivers/net/cnxk/cnxk_eswitch.c                   | 4 ++--
 drivers/net/cnxk/cnxk_rep_msg.c                   | 2 +-
 drivers/net/dpaa/dpaa_ethdev.c                    | 2 +-
 drivers/net/ionic/ionic_main.c                    | 4 ++--
 drivers/net/mlx4/mlx4_ethdev.c                    | 2 +-
 drivers/net/mlx5/mlx5.c                           | 8 ++++----
 drivers/net/mlx5/windows/mlx5_ethdev_os.c         | 2 +-
 drivers/net/nfp/nfpcore/nfp_resource.c            | 2 +-
 drivers/net/qede/qede_ethdev.c                    | 2 +-
 drivers/net/softnic/conn.c                        | 4 ++--
 drivers/net/vhost/rte_eth_vhost.c                 | 2 +-
 drivers/net/virtio/virtio_user/vhost_kernel_tap.c | 2 +-
 20 files changed, 32 insertions(+), 32 deletions(-)

--
2.53.0

