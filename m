Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EABF8C88E56
	for <dpdk-dev@archiver.kernel.org>; Sat, 12 Sep 2026 17:03:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 84FE94027F;
	Sat, 12 Sep 2026 19:03:49 +0200 (CEST)
Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com
 [74.125.228.43]) by mails.dpdk.org (Postfix) with ESMTP id 417F440041
 for <dev@dpdk.org>; Sat, 12 Sep 2026 19:03:48 +0200 (CEST)
Received: by mail-pz2-f43.google.com with SMTP id
 d2e1a72fcca58-85469b2e1d5so1003478b3a.1
 for <dev@dpdk.org>; Sat, 12 Sep 2026 10:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789232627;
 x=1789837427; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=d2Rb1O7Hu6XlDsaghy9eNFBuaVy4qcz8eWVrb2+jVhY=;
 b=00uW+dtqKMqhashVHsShNBTg+dTmRRjbOC9ldGFwfqQTDD/ezl4xCGJI6MN5HLOjQ8
 U/zEetFotz5I1l+PAD/rtf/vwjKNpJdOIT25yryvAOd8y4On7CtdAx8LM7H4032rO1fB
 heZxrkeKC2ap7RjTvgmmjzSzpwOa09Lw2DmWLKjjOHbO0ADAuACDA0K8OPqFme4+oevk
 fCTvn5KFdcBQQhqBPQ4cixIGKswETMkYd8JqfhAeC//NxwlsVykzuWGWSPYisr6P88on
 EGKN0QuU5TaOV/XY3TFsJgRLLCalmCexbhTMQHBVX4t7Ok9nSNHMtAkd141UonpdAdNA
 WIAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789232627; x=1789837427;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=d2Rb1O7Hu6XlDsaghy9eNFBuaVy4qcz8eWVrb2+jVhY=;
 b=ZQk2azCcIpK7deOX1hCKGgQQnDEtpljkXxgrwpZh9OO9LOf+LzFqAWki6i3SPJMEHa
 4NiWX10LTXY7GUs8u2PCCfGU8u2OFhlGYx0lG6QRLN9mChs19FYjtkhhSiJ75ujB9uVv
 Bbz/mHpn/pYpM0JURBQBiXeabTJ1LBZopTcIBUpbGDEul96FpMFAQHFWnQ/U5cbEBh5W
 aIlGrcYLp3OtUBLuWshI7pL9TYy9/B6gpmZUecOKUXf03ji15aZ7zWb8ebuyf5vwgmiy
 1bKP6h6oPfr7caTzBy4dNYt1+y6dL7YSrRawOAz12NXCCOXqYlacn8HYu9p09xpEzVRr
 kxXA==
X-Gm-Message-State: AFuF++lDgbae8HfqGuxsYjJcJRTCCEkd/YV4UgbZKJadj+OByQO2rIED
 sQS/utQdDjXizo7pvws43wG76kQk2JyKvesKNPEyqeva6sdUIE7kVVnH8bTABhdr97u2lcMHwFr
 flXaxXP0=
X-Gm-Gg: AYBFou3AmE0sovNBk8Gx7HUz+YpOxZ9w4BtXmCt5mXiTZqHncZgOUPUA5yzsPkqlNeT
 oXPToIYH2WZlscBBheOjOcgOdTCH6soNM15qeq7BpHfv9n71XLZqGR7tR7bYWvvBrEL71tbTPvW
 qqSDPZWnxuk54nycuheiX6c+eZSKR9NaQ3dJVG+0Vu/mpNKUshNHIOTknQJzmeP/wtOy1xjQ3Vf
 9p7Tof95p6sjrT12n56Eu79zh83bTMzSSLeLL3dbSNyV9FGVqtKgiVZJbWTM0CEmd8X3iE5trEt
 Aw+vhqLHxH2rNXRSB0ewzskH4jr9p258kqIJrcZiYMvhBz4YQ39x5zJDFQUobuEQ8SytSsPe030
 SbwNbUX52AfRlraJZeoOWrjddlBHYcOF5aZ3MP5dXXtJLFN2/xsHxK5eNj8FdVu7LKuaMSyljPu
 +LJu5F2gUBaFVoKOg4iYUCx3Y9CrymX5+d1z1OfA8AgG07yx/BYvt5K4S8dqQ2U42ctc1zerEtT
 jYX+gj+SgxOTSziMPWUOr8tKIyls9kQBYfM9g==
X-Received: by 2002:a05:6a21:2d09:b0:3d0:cc29:ff64 with SMTP id
 adf61e73a8af0-3daed2e3982mr19025644637.15.1789232626885; 
 Sat, 12 Sep 2026 10:03:46 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc4c655c2f0sm2719569a12.18.2026.09.12.10.03.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 10:03:46 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v2 0/9] consolidate sysfs access
Date: Sat, 12 Sep 2026 10:02:12 -0700
Message-ID: <20260912170338.486978-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912063319.4117869-1-stephen@networkplumber.org>
References: <20260912063319.4117869-1-stephen@networkplumber.org>
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

After reviewing lots of drivers and seeing sloppy string handling
resorted to AI assistance to unify and consolidate the parsing
of sysfs values. Many drivers open code this with similar pattern
but lacked any coherent error handling. The kernel API is
consistent and won't give bad data, but it make sense to
check for garbage.

Add one set of routines in EAL that build the path from a printf
style format and convert with strtoul()/strtol(), then convert the
existing callers.

Since the new routines are Linux only, a driver that uses sysfs while
advertising support on FreeBSD or Windows now fails to link. Two such
cases turned up and are fixed here: the eal_fs test and common/ionic.

Note: existing eal_parse_sysfs_value() goes away with this.
It was exported as a stable symbol, which was a mistake:
the eal_ prefix and the private eal_filesystem.h both say it is internal,
and nothing outside the tree should have been calling it.
The new rte_sysfs_parse_XXX routines are exported, but marked
as internal use only.

v2 - checkpatch fixes
   - clang format attribute fix
   - sysfs is Linux only, not unix

Stephen Hemminger (9):
  eal: add common sysfs value routines
  dma/idxd: use common sysfs routines
  common/ionic: use common sysfs routines
  bus/vmbus: use common sysfs routines
  power: use common sysfs routines
  drivers/bus: remove duplicate sysfs string helpers
  common/mlx5: use common sysfs routines
  net/mlx5: use common sysfs routines
  net/mana: use common sysfs routines

 app/test/test_eal_fs.c                        | 148 ++++++++++----
 drivers/bus/auxiliary/linux/auxiliary.c       |  13 +-
 drivers/bus/cdx/cdx.c                         |   7 +-
 drivers/bus/pci/linux/pci.c                   |  44 ++--
 drivers/bus/platform/platform.c               |  43 +---
 drivers/bus/vmbus/linux/vmbus_bus.c           |  64 ++----
 drivers/bus/vmbus/linux/vmbus_uio.c           |  24 +--
 drivers/common/cnxk/roc_model.c               |  40 +---
 drivers/common/cnxk/roc_platform.h            |   3 +-
 drivers/common/ionic/ionic_common_uio.c       | 102 +++++-----
 .../common/mlx5/linux/mlx5_common_auxiliary.c |  13 +-
 drivers/common/mlx5/linux/mlx5_common_os.c    |  39 ++--
 drivers/dma/idxd/idxd_bus.c                   |  80 ++------
 drivers/net/af_xdp/rte_eth_af_xdp.c           |  13 +-
 drivers/net/mana/mana.c                       |  14 +-
 drivers/net/mlx5/linux/mlx5_ethdev_os.c       |  17 +-
 drivers/net/mlx5/linux/mlx5_os.c              |  13 +-
 drivers/power/acpi/acpi_cpufreq.c             |  21 +-
 drivers/power/amd_pstate/amd_pstate_cpufreq.c |  63 +-----
 drivers/power/cppc/cppc_cpufreq.c             |  69 +------
 .../power/intel_pstate/intel_pstate_cpufreq.c |  99 ++-------
 drivers/power/intel_uncore/intel_uncore.c     |  32 +--
 lib/eal/common/eal_filesystem.h               |   4 +-
 lib/eal/include/meson.build                   |   1 +
 lib/eal/include/rte_sysfs.h                   | 121 +++++++++++
 lib/eal/linux/eal_hugepage_info.c             |  33 +--
 lib/eal/linux/eal_lcore.c                     |  18 +-
 lib/eal/linux/eal_sysfs.c                     | 188 ++++++++++++++++++
 lib/eal/linux/meson.build                     |   1 +
 lib/eal/unix/eal_filesystem.c                 |  31 ---
 lib/power/power_common.c                      |  52 +++--
 lib/power/power_common.h                      |   6 +
 lib/power/rte_power_qos.c                     |  29 +--
 33 files changed, 690 insertions(+), 755 deletions(-)
 create mode 100644 lib/eal/include/rte_sysfs.h
 create mode 100644 lib/eal/linux/eal_sysfs.c

-- 
2.53.0

