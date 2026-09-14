Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 300E4C88E6F
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Sep 2026 17:37:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2E2F040C35;
	Mon, 14 Sep 2026 19:37:10 +0200 (CEST)
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com
 [209.85.210.169])
 by mails.dpdk.org (Postfix) with ESMTP id 3573A40C35
 for <dev@dpdk.org>; Mon, 14 Sep 2026 19:37:09 +0200 (CEST)
Received: by mail-pf1-f169.google.com with SMTP id
 d2e1a72fcca58-869d181419bso3348482b3a.2
 for <dev@dpdk.org>; Mon, 14 Sep 2026 10:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789407428;
 x=1790012228; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ur07clqzt47qx8pmFfLkWRnCVIen/OnbQGnYt+jYCD8=;
 b=hLRJja3evmN9j/HipyZiBtxE+Qn19nAqYGIa54/Jujbb2z0dFavS+MLb4TJ2OTY11P
 PlO+XHkAGb+uw/qr9H1CaZ83OdijH7r9V6p+Qf9bM6dyAzEX54EDUKoG5fAdHbGguUHX
 WaPP+1HGGZZBku7PnryZfW3Y0D4RTehYRW6gJQM96RLMUyWOuZpkMQ3fTi5QKGNHlLSa
 Xz9PIJL1+1u4gKoqNfu/2kox1el2e9JQefnrKY3KOrK9F1RiCge0c1a6aQr+TPDWz3yY
 S79JQgY8mlJ3QZaCqwXHhiwfkZNdGUQuiKvbDPVexHP8OBQdwnuLR/YdOX++X+JXqx/C
 k5fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789407428; x=1790012228;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ur07clqzt47qx8pmFfLkWRnCVIen/OnbQGnYt+jYCD8=;
 b=qQrlA7rGE0pCliu/JqfLx6wjIotLCUio1SPJFXPgEMathBW7GvkajANNDwUJRzJOZv
 4j/krn4XirDoYnGvdNN0LKjhk+4j2PLHsOa3PwNYMlnSYg4Qn/CD9092OLg/5ixKnNFQ
 VsuMa7DRBl/0feKTnw5WgDTWcLxx926ixizQ+kzWuTfXrtgW535Zd9pyJFQ4iE//4/4y
 kGHDDqjTv9byxUYUFyG0gHGu2QFc5Xz/lT69bTe0p57swi3T0ZPSy9OoUWGPrdBBsrmj
 vGZn68V02RexvIrmqtJt65dK9CumCS0MvoDQUJvus1mamcOuAmt8DSByTYfS0ZX8lLoE
 wYFg==
X-Gm-Message-State: AFuF++n4mrf3X7nEq1TeAoDZtfZ4J6ZW4VviCI1GdlmFRGqln2l4nw/s
 DRbieBX9NpgnKKuTcCugBMcHdJ/e0vp8ac50fT2Ej9k6PqzE2Ik8PVShFIc0K3GyL2qkwqE48yd
 zFkmsFMI=
X-Gm-Gg: AYBFou18ncgJRvC5+rbhoclERBLi1XmmeDIK3nQ7vbuQvLCRq3T2JZ2IHJh1aio9PoY
 rqXjM7zz2SQkapGPDhe4EFxMVUHFBdlQROsYMIONqIZ0DQHTM4WtfdQFBnHXLC4qj2qmtqhfRq0
 uJlgMBM1BbuD9zc6j0rVLQwMw5oiPBKcqUJ5Uwup83n4WMyrtNyWLuW2ibCPzL/04Anw4zajjf2
 JW1XiWzJPXJQAApV3aM8AlNR1FZ4ctX/4PxXyEsXRJd1bMQmDX1KCLgnnoz0TnmOeEFJBeBmXOA
 bYZ7AkyBSI6yDMI9r/SsKH3v6ShduJOMiQWk8SA+I+tM9b338ita1K708mDELgRjkzAacVjKGZT
 gry/AbM+bUMXu4txgvH8vOVluerLyMC1CF59z8cgxXQoXkDa9N9/uZmXu/i/gPUO7RvpIwbuuqH
 PKbm2zz6/5g0i2UxlJPGA+mqLRmCeXwDJXwB+A/io+MlluDFFR2wX6M66u4wZV1/CGpdCBgC3m3
 x21ih7BGAuxl3WZ1DVEMsShfrH7zxKFdypHVQ==
X-Received: by 2002:a05:6a00:148c:b0:848:2eac:bfb2 with SMTP id
 d2e1a72fcca58-86f85108aadmr6687390b3a.13.1789407428228; 
 Mon, 14 Sep 2026 10:37:08 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-86b286c49d2sm5159867b3a.10.2026.09.14.10.37.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 10:37:07 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v3 0/9] consolidate sysfs access
Date: Mon, 14 Sep 2026 10:36:13 -0700
Message-ID: <20260914173700.2795983-1-stephen@networkplumber.org>
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

v3 - fix doxygen comments

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
 lib/eal/include/rte_sysfs.h                   | 125 ++++++++++++
 lib/eal/linux/eal_hugepage_info.c             |  33 +--
 lib/eal/linux/eal_lcore.c                     |  18 +-
 lib/eal/linux/eal_sysfs.c                     | 188 ++++++++++++++++++
 lib/eal/linux/meson.build                     |   1 +
 lib/eal/unix/eal_filesystem.c                 |  31 ---
 lib/power/power_common.c                      |  52 +++--
 lib/power/power_common.h                      |   6 +
 lib/power/rte_power_qos.c                     |  29 +--
 33 files changed, 694 insertions(+), 755 deletions(-)
 create mode 100644 lib/eal/include/rte_sysfs.h
 create mode 100644 lib/eal/linux/eal_sysfs.c

-- 
2.53.0

