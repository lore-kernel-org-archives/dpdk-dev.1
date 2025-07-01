Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C29CC83038
	for <dpdk-dev@archiver.kernel.org>; Tue,  1 Jul 2025 18:20:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E20C240299;
	Tue,  1 Jul 2025 20:20:50 +0200 (CEST)
Received: from out203-205-221-221.mail.qq.com (out203-205-221-221.mail.qq.com
 [203.205.221.221])
 by mails.dpdk.org (Postfix) with UTF8SMTP id 3096F40264
 for <dev@dpdk.org>; Tue,  1 Jul 2025 20:20:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
 s=s201512; t=1751394040;
 bh=nzaPA1ScZSUMA6b/KBB2pS8UwG2z91PUqWvfuFiD5vQ=;
 h=From:To:Cc:Subject:Date;
 b=r8OrH7YMvYCI8vnPh2ZPQKipdDeKH/UJvSjBQpLajox3vwX2EvgKGjpyxGS+e6WGu
 oaYHeNLZaWvzN7CAR+iSJeW5RrIs5GA0tyydu8bg1T5peslQdYwtemR4XiXsVQQmsX
 KULABk56K+q2wCWLSTZfWp1H93lxShoFllyAvJB8=
Received: from ar ([113.231.127.221])
 by newxmesmtplogicsvrsza29-0.qq.com (NewEsmtp) with SMTP
 id 5273C0B9; Wed, 02 Jul 2025 02:20:39 +0800
X-QQ-mid: xmsmtpt1751394039tm9ia4pfa
Message-ID: <tencent_9C7872AE1E4B238C85E75A95D7C26728B505@qq.com>
X-QQ-XMAILINFO: NFYAXF90nFLaYHxtDnWCt5T6FLgOTsF4F4wng6zg5rQCLGFOwDznSGEUcDRg+p
 540qHelarfr7RzGR6R15wVwKhl5QOzLl/btjlwRsbw7ibwv5VcqWADlMdBQS9lNnW5DrHl9V/Byu
 lvR8z4eCsMPjIubsxQcMlTuFhmcspaajcWCMq6dr8lq85UomIwrdFvmmOzRLZAp3ohynkmfj9bTQ
 aencXHVq6VSUsQI37XoFmVg6TFl5tTgNRS7su8d0liKAoY5feGz4xFpWhCwK3mg/wRW7iGZKbrT1
 YuyohAwD9HbaZGAExEt10oYXMP0gnc2cRv5qF3Dbq56LuqLkqEv8bmud4hCoITNdxAZrukxBA4j+
 wJy6ICoiXIYuAr0wKdJlnq2B6pgzG4A0n6apt3FtTq6TGnsgWrdUhnAhY5MLPyM5DofHdeDXoyBI
 1zRq/CGv+AVZc3KFI86UI5eubQzzvkMY79l2q6KuAgTgEJxmecIPowz6zhiVFi8odN4LTFXyfUGv
 mxRWn1vA0zgdZjF6rR6MQsL6zY0AWivdWhPXdszloE3HRc7rHS2WfJMboajgi4EPargRh+kMR9/p
 BRmXORYFarF/TN9TgQ/2QBJb7ePvHzFj583MWEKMDRTR3p5QSC7GhUBBTdHtB88QzzwpVfkxpQ6I
 pXgNLoL6lPHWyRzpJjP3PGVgAx/YevwCSacy72NCDLw29HhPpWVXatzfCvEYPRuQ6sMkY2GkeXQm
 pfvVT+uGqvo1KDsYMraQvjrChBo4w2kJfQ/raleIzjLmZj2tnTzpInlQ4YHTzJBYJyxmFLmklUA1
 e3hAd9wLXe3fzaPHoGqeNgnTChXGcqVEwfRknc/8PaCDShUc/ubRjhVEvRZw2KSnj6hS4RYPnouR
 fD6oxRrkCTCUTE2xyXQjAFCJLQI7XLCzvVqNNZoZAVppCAVPvmoxsPfbIdpiC3rA==
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From: uk7b@foxmail.com
To: dev@dpdk.org
Cc: Sun Yuechi <sunyuechi@iscas.ac.cn>
Subject: [PATCH v2 0/5] Add RISC-V V extension detection and LPM,
 FIB optimization
Date: Wed,  2 Jul 2025 02:20:28 +0800
X-OQ-MSGID: <20250701182033.642384-1-uk7b@foxmail.com>
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

v2:
- Add RTE_RISCV_FEATURE_V check.

Sun Yuechi (5):
  config/riscv: detect V extension
  eal/riscv/spinlock: add rte_cpuflag.h
  lib/lpm: R-V V rte_lpm_lookupx4
  lib/fib: R-V V rte_fib_lookup_bulk
  riscv: override machine_args only when default

 .mailmap                             |  1 +
 MAINTAINERS                          |  2 +
 config/riscv/meson.build             | 39 ++++++++++++++---
 lib/eal/riscv/include/rte_spinlock.h |  1 +
 lib/eal/riscv/include/rte_vect.h     |  4 ++
 lib/fib/dir24_8.c                    | 20 +++++++++
 lib/fib/dir24_8_rvv.c                | 64 ++++++++++++++++++++++++++++
 lib/fib/dir24_8_rvv.h                | 24 +++++++++++
 lib/fib/meson.build                  |  2 +
 lib/lpm/meson.build                  |  1 +
 lib/lpm/rte_lpm.h                    |  2 +
 lib/lpm/rte_lpm_rvv.h                | 59 +++++++++++++++++++++++++
 12 files changed, 213 insertions(+), 6 deletions(-)
 create mode 100644 lib/fib/dir24_8_rvv.c
 create mode 100644 lib/fib/dir24_8_rvv.h
 create mode 100644 lib/lpm/rte_lpm_rvv.h

-- 
2.50.0

