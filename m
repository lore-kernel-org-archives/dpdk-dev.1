Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29BD6C88E45
	for <dpdk-dev@archiver.kernel.org>; Sat, 12 Sep 2026 06:33:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E175E4029D;
	Sat, 12 Sep 2026 08:33:28 +0200 (CEST)
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50]) by mails.dpdk.org (Postfix) with ESMTP id D0AC640281
 for <dev@dpdk.org>; Sat, 12 Sep 2026 08:33:27 +0200 (CEST)
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-3856d6fbcb3so1647414a91.2
 for <dev@dpdk.org>; Fri, 11 Sep 2026 23:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789194806;
 x=1789799606; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=W9xsswhqR6JyyTtPp3wsYTe0qcBkjGzzDuVanoEL0hc=;
 b=t6NpX4sY4VzjeFU8PGTVs/Ss/RXrwz6yI1bBsUx69VS9LFjSt4fmsqm/jLP2mvH+jV
 06ItAIh7rrhW5iv4cURTsKwzZvQ+JyFK6UlUBcuL9xMbZHY1u0jTDf8lCQnzAssXJ9RR
 nrqcy9eKbXBVx+eDNPXOTul4VEORbadiK63v29oX8HCtAJBmhD87UVKszEBFWohg6iJ6
 W5ir8icMBkmIIW04I95p4YnOcjlMCHSdfMWEEglr7CE7lPVn06uGapyYYxKP//HB6GDv
 Q4nGK5NNVUvzOuYlAuH4LafU6CmNu6qoPER9wwdPLGEAe+b/CekMrobGcHIJaoGGKriU
 v2Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789194806; x=1789799606;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=W9xsswhqR6JyyTtPp3wsYTe0qcBkjGzzDuVanoEL0hc=;
 b=bDaZxOSNj5YCOuaSYBtor7Ug+mceqCW0N22ITX+zYw4p6DYS2LqPzYrkASUkM+/MBh
 G1qPHhP3Vc4NrsJZO9f677koIZuW16zBk+Jz2jCdyuhO/FEd2WKT7GOtlQXfVH0jWptX
 y/eA3dRp6V++xZfZR3HoVQM0qcmC3wAMZHpUDkgoA8Yy2+3LxMc3g/Fj8pgAdAhSkdLG
 5JwPg1euNhWyUavvvTlCwxzD06WVsMGyzxaMmFFaG8Pa+tSFdc1xDxOUtwebY1pP9dj8
 qzoYfyq3PjB5QmciToYvQtCXMOLQ491JBKyy/R+Wzyv6WEEn7a8NZRxQiKRM1Huh5P+g
 Yt/g==
X-Gm-Message-State: AFuF++ks6tH2f/E4GhCBcqPIXS6YUnMeQGF1aPbfk2l1J2CW/rCk+D7c
 EeC55+TxJVpcwlybYWp0njfKL/G/5xukCIn98HUV72/QQUi+bTG/5pmssBLrtX3+IVpBkBjzL2u
 v3JcvuFw=
X-Gm-Gg: AYBFou0hc5TnNNWndyWA8xItgOVQHjGGf1EklESz03sP9Saz72rmsbP99K2At4ySoGe
 nNgDyB+AVPfKWVnlr6sW5dqgJbTFvB8Ncyc6UYGX8LfMoZUrqA22goCgtNfTNiKb5Q3GhfPb6BU
 44aIjifz+ayaPmch5tENXd5+SIuVEsyV1RQWPQjF7wx64LgY1JrCpjqxnwQ2lYm+kBBvaYy0qwh
 qZyH55XVe1IXDbrBrsk5p3fQHE/A84QEFH2/qfVDuWAGv++e76WrHEQG/XD5m7M96bcpJGFKHVh
 v8PmanRuM7w+A+9WI3YT/gLm3GkdTGtXSHpToSLFKj1B98El/hcFdySfrdH/ygiHa8+N/+pu7Pw
 KUZUgdVHH/7C2Dj/RuDLsKlBIQJX4fsWkc6fneAoJgvzjb8QR6cb2A/Cw+sLFxyt82X0I6QfaSL
 KXx/wlPpyZnpZtKIxR9lFtB37tOseZ/koDd4XN0wL5tTHFMZRgKrGyUm3AGlOEComwH8KV6qk7+
 o7t1vtex1FRK4eoSnWavQEVpg0/FZrNmtiIiA==
X-Received: by 2002:a17:90b:440e:b0:38f:efed:5445 with SMTP id
 98e67ed59e1d1-39d9bc0ff30mr12926458a91.4.1789194806488; 
 Fri, 11 Sep 2026 23:33:26 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39d95424fccsm8661497a91.10.2026.09.11.23.33.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 23:33:26 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 0/9] consolidate sysfs access
Date: Fri, 11 Sep 2026 23:30:19 -0700
Message-ID: <20260912063319.4117869-1-stephen@networkplumber.org>
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

After reviewing lots of drivers and seeing sloppy string handling
resorted to AI assistance to unify and consolidate the parsing
of sysfs values. Many drivers open code this with similar pattern
but lacked any coherent error handling. The kernel API is
consistent and won't give bad data, but it make sense to
check for garbage.

Add one set of routines in EAL that build the path from a printf
style format and convert with strtoul()/strtol(), then convert the
existing callers.

Note: existing eal_parse_sysfs_value() goes away with this.
It was exported as a stable symbol, which was a mistake:
the eal_ prefix and the private eal_filesystem.h both say it is internal,
and nothing outside the tree should have been calling it.
The new code does export rte_sysfs_parse_XXX are marked with
as internal use only.

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

 app/test/test_eal_fs.c                        | 135 ++++++++++---
 drivers/bus/auxiliary/linux/auxiliary.c       |  13 +-
 drivers/bus/cdx/cdx.c                         |   7 +-
 drivers/bus/pci/linux/pci.c                   |  44 ++---
 drivers/bus/platform/platform.c               |  43 +---
 drivers/bus/vmbus/linux/vmbus_bus.c           |  64 ++----
 drivers/bus/vmbus/linux/vmbus_uio.c           |  24 +--
 drivers/common/cnxk/roc_model.c               |  40 +---
 drivers/common/cnxk/roc_platform.h            |   3 +-
 drivers/common/ionic/ionic_common_uio.c       |  63 ++----
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
 .../power/intel_pstate/intel_pstate_cpufreq.c |  99 ++--------
 drivers/power/intel_uncore/intel_uncore.c     |  32 +--
 lib/eal/common/eal_filesystem.h               |   4 +-
 lib/eal/include/meson.build                   |   1 +
 lib/eal/include/rte_sysfs.h                   | 121 ++++++++++++
 lib/eal/linux/eal_hugepage_info.c             |  32 +--
 lib/eal/linux/eal_lcore.c                     |  18 +-
 lib/eal/unix/eal_filesystem.c                 |  31 ---
 lib/eal/unix/eal_unix_sysfs.c                 | 187 ++++++++++++++++++
 lib/eal/unix/meson.build                      |   1 +
 lib/power/power_common.c                      |  46 ++---
 lib/power/power_common.h                      |   6 +
 lib/power/rte_power_qos.c                     |  29 +--
 33 files changed, 639 insertions(+), 746 deletions(-)
 create mode 100644 lib/eal/include/rte_sysfs.h
 create mode 100644 lib/eal/unix/eal_unix_sysfs.c

-- 
2.53.0

