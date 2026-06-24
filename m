Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EDFBCDB47C
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Jun 2026 10:37:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4015F402E7;
	Wed, 24 Jun 2026 12:37:07 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id 14C29400EF
 for <dev@dpdk.org>; Wed, 24 Jun 2026 12:37:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782297425; x=1813833425;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=4sUl22c9mzyxj185Fpf5zb+us+yc5Ve0sgBXydQOcQY=;
 b=d1gUySyHR3PuN9T6i+M5lrx8ELwJ0PM2DtqkT7I7WqTuq3VF/43hQ1+l
 oFNnWOYd5FirUklUrn5B1I3nEK8rrT4Zz6QiS42T92R6jQzpE5dmRNTN7
 OHEG7BnmcZGIOxXjLhkWLeVMhf8jMSFIl27Ei3oPnuvjEX5gXDUtV6ePS
 3X0uV0hhCvFgTILO5NANFtdNzwiQxelP02DHHMCskYV/4+pLHRGeZu11h
 Lu4wAr5DibfmQL1PThAN4y7pU5VmnRlticMScXGqDWVaUjt932SOH0P+b
 JYfmoqfX01oRcZKA8XK7mhaN1jSq8XEQBdbHw31VsVxuC8vcJGdU1tvvH A==;
X-CSE-ConnectionGUID: K/9lv4TeS/ScK9PiP9R2DA==
X-CSE-MsgGUID: BivMUpotSWm4fRkyd6ir/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="93652327"
X-IronPort-AV: E=Sophos;i="6.24,222,1774335600"; d="scan'208";a="93652327"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jun 2026 03:37:04 -0700
X-CSE-ConnectionGUID: bYlwHE8zQj2wYfBt7lONiw==
X-CSE-MsgGUID: oN7WPGa1S+e56n+koXbshA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,222,1774335600"; d="scan'208";a="245459970"
Received: from silpixa00401385.ir.intel.com (HELO
 localhost.ger.corp.intel.com) ([10.20.224.226])
 by fmviesa006.fm.intel.com with ESMTP; 24 Jun 2026 03:37:03 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2 00/17] drivers: replace strncpy with strlcpy
Date: Wed, 24 Jun 2026 11:36:39 +0100
Message-ID: <20260624103658.792750-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260623165150.765443-1-bruce.richardson@intel.com>
References: <20260623165150.765443-1-bruce.richardson@intel.com>
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

v2:
* fix incorrect commit ids for fixlines.
* fix build errors due to missing rte_string_fns.h header include

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
 drivers/net/softnic/conn.c                        | 6 ++++--
 drivers/net/vhost/rte_eth_vhost.c                 | 2 +-
 drivers/net/virtio/virtio_user/vhost_kernel_tap.c | 2 +-
 20 files changed, 34 insertions(+), 32 deletions(-)

--
2.53.0

