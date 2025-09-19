Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92684CAC592
	for <dpdk-dev@archiver.kernel.org>; Fri, 19 Sep 2025 16:36:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 91A834042F;
	Fri, 19 Sep 2025 18:36:05 +0200 (CEST)
Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com
 [162.62.58.216])
 by mails.dpdk.org (Postfix) with UTF8SMTP id 3F2AB4028E
 for <dev@dpdk.org>; Fri, 19 Sep 2025 18:36:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
 s=s201512; t=1758299755;
 bh=jXCtoHdY3zSp10XR02ELCUCglxwOQuF3rVa8c2sqXdw=;
 h=From:To:Cc:Subject:Date;
 b=AOOZM6KO72g9PhFNpRJHYvlyRncKSIt+ufSPMhCwW8Lh6UyVJryr0NGvR7y8esp7h
 sAZ4Sa2CHNAIYfn2/yDBwaJ/bWX8p7qkoVcvooBTMKb1mT07m7wiUJGKjKUP+55qcP
 s2zQyBhh1gAIdkXIOFAD2RIkK3JuuEivlS+Kl/fE=
Received: from ar ([42.177.177.196])
 by newxmesmtplogicsvrsza36-0.qq.com (NewEsmtp) with SMTP
 id 8F5B36CE; Sat, 20 Sep 2025 00:35:53 +0800
X-QQ-mid: xmsmtpt1758299753t5fz776ce
Message-ID: <tencent_526C9BE741B5C28270A8B5F8674E00EB3C05@qq.com>
X-QQ-XMAILINFO: M9v5O5rJdQ32R8uaqVTKIJetVQJgxzqa2+X+BAQUYczUF8o1FCqElMG7XbDHBN
 AhIe6fcXZd3VkKxtgv5QbyxjlKhlZMj1IKeXNHOAvf3IC8lQbijkENzu9sOOiq3kD6Vne2Z4GTFx
 vMJrmx/ieVkrVpImEDRDVsfb5f3xRpgpzVJ4Ufzq5rnXYkgKAoetmqn6VdZuxhpOwIqJq0c3TL6P
 W1o+tQpcyPfY/NGQq4FBH7pA3YcwSXrud7n/IKDigNj61fpem95FyPVVUsfFhw23dyF952ISfStu
 uhdwHhYz6440o20fDnmvWYnlCvz9u3AfnPqmgKa4wFZKGcNMmH0sq07hO7fdZQRFPGojZHiIRedy
 EmwA9yhCVwrhpjlTdNM/4Mjkgj6f9xAGzoUlTC2IVjTT2/jjEHCWQplK84pwmgmjc2oMOGFm4Cul
 BTyvbhwKq1SKo1azevHiJSzxJS8MXpolS4q/P6xhUAokPY8hBX1yMkdkVuFjSSHKqrkKJ9KF5mt8
 ic7YdkwGUs3PFSxSdN1K8gs+dSysRs0tA7cBvXi/g2CoACbJK0QqwIqDbRFgmbuLJOALO0OsOrdL
 2SlQ9m8PBqbPO5Qry1rUHKjWYZVXptggVYzRTec14XsLkOXipVhGz9HzgpsqwazN4OqM3Ll2ee+L
 qfi5Pe7W9GdSLkaL1DBYEEDZLiQrO6H6P9wjxK6p3TfDMtgdkLTcN0SGJDdvQxHKEiJRrbjIraUF
 TZ147N5GZ0WvKcHdD7JNsv1VuhkO9Dgq0JmvAAl6BzR2Sbh26rvynaTnIpr+EsUUpjs9b7vKw2AI
 jxL5whjvYo9Rc+AdlKr7fbcmaBvid53LhwDL1YKIeL3UBXY6R2NyAB5FQsy9hqJWUKjEHEu1wDkD
 0z1QvzSIdisqY5lMbyd0cHH+QBJ6cpOCaCKALodkvuzoP/Ye43D7th8MNT+FV6P2nB+o79Hfov
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
From: uk7b@foxmail.com
To: dev@dpdk.org
Cc: Sun Yuechi <sunyuechi@iscas.ac.cn>
Subject: [PATCH v3 0/4] Add RISC-V V extension detection and LPM,
 FIB optimization
Date: Sat, 20 Sep 2025 00:33:53 +0800
X-OQ-MSGID: <20250919163358.2887335-1-uk7b@foxmail.com>
X-Mailer: git-send-email 2.51.0
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

From: Sun Yuechi <sunyuechi@iscas.ac.cn>

This patch series adds support for the RISC-V Vector (V) extension and
provides an optimized implementation of `rte_lpm_lookupx4` using RVV.

The initialization of lpm/vtbl_entry is not fully vectorized here because
doing so would require __riscv_vluxei32_v_u32m1, which is slower
than the scalar approach in this small-scale scenario.

- Test: app/test/lpm_perf_autotest
- Platform: Banana Pi BPI-F3
- SoC: Spacemit X60 (8 cores with Vector extension)
- CPU Frequency: up to 1.6 GHz
- Cache: 256 KiB L1d x8, 256 KiB L1i x8, 1 MiB L2 x2
- Memory: 16 GiB
- Kernel: Linux 6.6.36
- Compiler: GCC 14.2.0 (with RVV intrinsic support)

LPM LookupX4:
    scalar: 5.7 cycles
    rvv:    4.6 cycles

FIB lookup_bulk:
    scalar: 5.9 cycles
    rvv:    5.4 cycles

v3:
- Move rte_cpuflags.h into lib/fib/dir24_8_rvv.h.
v2:
- Add RTE_RISCV_FEATURE_V check.

Sun Yuechi (4):
  config/riscv: detect V extension
  lib/lpm: R-V V rte_lpm_lookupx4
  lib/fib: R-V V rte_fib_lookup_bulk
  riscv: override machine_args only when default

 .mailmap                         |  1 +
 MAINTAINERS                      |  2 +
 config/riscv/meson.build         | 39 ++++++++++++++++---
 lib/eal/riscv/include/rte_vect.h |  4 ++
 lib/fib/dir24_8.c                | 20 ++++++++++
 lib/fib/dir24_8_rvv.c            | 64 ++++++++++++++++++++++++++++++++
 lib/fib/dir24_8_rvv.h            | 26 +++++++++++++
 lib/fib/meson.build              |  2 +
 lib/lpm/meson.build              |  1 +
 lib/lpm/rte_lpm.h                |  2 +
 lib/lpm/rte_lpm_rvv.h            | 59 +++++++++++++++++++++++++++++
 11 files changed, 214 insertions(+), 6 deletions(-)
 create mode 100644 lib/fib/dir24_8_rvv.c
 create mode 100644 lib/fib/dir24_8_rvv.h
 create mode 100644 lib/lpm/rte_lpm_rvv.h

-- 
2.51.0

