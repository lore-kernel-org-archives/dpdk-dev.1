Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74DB8C7EE30
	for <dpdk-dev@archiver.kernel.org>; Tue,  1 Jul 2025 16:14:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A63D240276;
	Tue,  1 Jul 2025 18:14:38 +0200 (CEST)
Received: from out203-205-221-164.mail.qq.com (out203-205-221-164.mail.qq.com
 [203.205.221.164])
 by mails.dpdk.org (Postfix) with UTF8SMTP id E702740264
 for <dev@dpdk.org>; Tue,  1 Jul 2025 18:14:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
 s=s201512; t=1751386467;
 bh=tmitxNYs1Oa7Fij5v7Jg8Lln26YDvnrCP2k932NhTdY=;
 h=From:To:Cc:Subject:Date;
 b=Y1i6SaRYZpAO/Eud9W6L2xpAiXDaRfQf4OhF3sK1AafgDqdEbyx5kxz7WSRGYmu2p
 2Q+TTiIlfgvhbBbXOq35x1e4/pWuta+g3okW92u7VI9MClf6+YfAhhGA+N5zqEc/WF
 pkjtjAWqzuCtaiIOjxhpwX98aN5DoGA99ZzilQCo=
Received: from ar ([113.231.127.221])
 by newxmesmtplogicsvrszc13-0.qq.com (NewEsmtp) with SMTP
 id 39A13C1D; Wed, 02 Jul 2025 00:14:26 +0800
X-QQ-mid: xmsmtpt1751386466tpksrh1g7
Message-ID: <tencent_4A90436AC5AA735B587C61253C34AA891608@qq.com>
X-QQ-XMAILINFO: NYqi3QrBgYD/VKL9NYwkW5YTaFCHlNtYYrpP3WO5xiEu/XBm2eyDEcq0/YNRTF
 gIjxS9m3SdCd+GMcnQYokHDmc14Y2BXDlvL5WrnNSjxJ4CtB0SdXRPHVaNN6NNYZI34NxMwR61Qk
 JLcEs/lIA7v4D7Uk93DIYIqDhhrzYZQUCTxBwvCI4plifdqRyj3VxTwd+E6B93XBY4nw4dP5mQVS
 dVrtcxiC5IJC3JD3+ad0hUqwkmU4BclMVo3jl+XYj6dAX8se6d9fCc8r7eNCoVMWur3mSEKksfTV
 9qw/yM/OUJ4fxUlQO6Hu+Ep++ifM/PbdPJB5LcMt18VwYiI16mQ3mn4PkDZT7TiN8X7qKDfncB1/
 yubLXX2eMrVsEaGi6DNZhxhTnb2FrDKp7rphLnv2Cbg9qUocpqhCbiwJCVFA7FHjQKtlD+D7u69o
 SSRcf+a5lJIBR65WhcmkTNNmMowpni8OXGpPccPaxOlLPJtXEJCfGcbw3omf1BWE7Hmptqk4EiWv
 3rBTUjzyTpwcIa2BFkKn/CLCNMeiLOiuOOQXZU3VtlJpaEJazqVfRVaOCtlT6IFD4NIDesUi7AUe
 ro1HvXbSH73mSAm6Y4ko4hraUAlEyADDgPXwwRbEToRtmc8iraVoAgxk9Em3zHMHSNGz6g1DAhmu
 D6N0uhPizUs/8lFoNRRkJ8kViCTESxhPuiefNzsnJEzPZHHuzXmu/otUvid4Oo64DraL3T1d1J4f
 Mkrvg4KUo7uVNINMg3o+1OsXMar7JAUQyYEyqrIvDO70EOpUrVuytbK2XIp2DiWVRkbN5VwSFzDF
 xwccEMjovsgAlJcHAtV04/y7R/XtSXd9eN1lC6bAlhcMwaasoDk+zuecjEQBBHWXEJF0XB08qWaK
 NnlEGzhcC79xLg0CZLqCHSlA15cKV2/c6QVkG3KITB+xmRuhG3r1TNcHXB5hwOFw==
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
From: uk7b@foxmail.com
To: dev@dpdk.org
Cc: Sun Yuechi <sunyuechi@iscas.ac.cn>
Subject: [PATCH 0/5] *** Add RISC-V V extension detection and LPM,
 FIB optimization ***
Date: Wed,  2 Jul 2025 00:13:37 +0800
X-OQ-MSGID: <20250701161342.46750-1-uk7b@foxmail.com>
X-Mailer: git-send-email 2.50.0
MIME-Version: 1.0
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
- Cache: 256 KiB L1d ×8, 256 KiB L1i ×8, 1 MiB L2 ×2
- Memory: 16 GiB
- Kernel: Linux 6.6.36
- Compiler: GCC 14.2.0 (with RVV intrinsic support)

LPM LookupX4:
    scalar: 5.7 cycles
    rvv:    4.6 cycles

FIB lookup_bulk:
    scalar: 5.9 cycles
    rvv:    5.4 cycles

Sun Yuechi (5):
  config/riscv: detect V extension
  eal/riscv/spinlock: add rte_cpuflag.h
  lib/lpm: R-V V rte_lpm_lookupx4
  lib/fib: R-V V rte_fib_lookup_bulk
  riscv: override machine_args only when default

 .mailmap                             |  1 +
 MAINTAINERS                          |  2 +
 config/riscv/meson.build             | 39 +++++++++++++++---
 lib/eal/riscv/include/rte_spinlock.h |  1 +
 lib/eal/riscv/include/rte_vect.h     |  4 ++
 lib/fib/dir24_8.c                    | 20 ++++++++++
 lib/fib/dir24_8_rvv.c                | 60 ++++++++++++++++++++++++++++
 lib/fib/dir24_8_rvv.h                | 24 +++++++++++
 lib/fib/meson.build                  |  2 +
 lib/lpm/meson.build                  |  1 +
 lib/lpm/rte_lpm.h                    |  2 +
 lib/lpm/rte_lpm_rvv.h                | 59 +++++++++++++++++++++++++++
 12 files changed, 209 insertions(+), 6 deletions(-)
 create mode 100644 lib/fib/dir24_8_rvv.c
 create mode 100644 lib/fib/dir24_8_rvv.h
 create mode 100644 lib/lpm/rte_lpm_rvv.h

-- 
2.50.0

