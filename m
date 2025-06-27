Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59ED7C7EE2A
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Jun 2025 03:58:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2E9E340277;
	Fri, 27 Jun 2025 05:58:53 +0200 (CEST)
Received: from out162-62-57-137.mail.qq.com (out162-62-57-137.mail.qq.com
 [162.62.57.137])
 by mails.dpdk.org (Postfix) with UTF8SMTP id 652DA40267
 for <dev@dpdk.org>; Fri, 27 Jun 2025 05:58:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
 s=s201512; t=1750996722;
 bh=TQD5k+33xQhqw3W+2fMsVlnQAq10n15WS4gHQFkKhuY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=e/d3oTSZ8kHeWnKwSBE2yvnv0MbSfONpN+7+3/JYiJ+VmB5p79+LJF666lSBZjP7O
 T1W4uXLPr08PKnjJmPwuq60kKHzVBePdrFup09ll+tLF3M6N5e67mumRyjYChtEudW
 tmIvRprG40keEHK3V1aaELK/Nz9ReswH9g1bTs/4=
Received: from localhost.localdomain ([113.231.69.199])
 by newxmesmtplogicsvrszb21-0.qq.com (NewEsmtp) with SMTP
 id EA914ED6; Fri, 27 Jun 2025 11:58:41 +0800
X-QQ-mid: xmsmtpt1750996721t7vwbwvdo
Message-ID: <tencent_212B254C80C75315CC826328B098610E0C05@qq.com>
X-QQ-XMAILINFO: NQR8mRxMnur9ynhg9YKTm3D3Ih+ll88lz8KuL1iqZVkw2DhWIQXn4mhOa++KL8
 k7hZMRoaBaBeT8rOY3l5HXg7E93cJAi3raCC5iOKYfX3SHQsnSbhz5iGQlvQ9sDFTe5fsvQ6RSo2
 /AIenueRIkUfzB63QFCnYKmoonJPQTosmze3pvhMiwi+5OMYhjm1UCtMWJ7XNSEDVUwtSBNau1Be
 RKAACZKBo1qM/RFJwZcl20mdv7oml7SAqIh3fGTgMABdrh5QR+UmHaA2VeodSQQgT3m499R6TmO6
 XERA52HovxHvyocoiF5rDr61GVwTUc1gHVJ6UqQQmHlNK41rsNjzW2tpRKhkvK4BZ7ORuBJcheB3
 Tw3EKNk+gg32P/JkIj5IQntMWpakZ5BQRoPWFBsgJ0hFNwmcsT2q9FcChE87bqQ7StdnEJDaAN8a
 ybWbvM11cq6DVoElMfD1VevOTq7reIA7KdsKgmyxP83HmF2Wyz3FH5VwXSB5NnfiDzn4/Oh2VdB4
 HGpEevxxRgcQ92Zd+Q5uOoQ/hda5EQDd1T9pGVGFi6ocMes+8yg3F6vDpGrUrrKMPLVR/Oczl6hy
 Vj/ItcjwtKIrYIcagm9/+D0FPkow77ZFuFmVy+ul9liQ3+QKotlWUKJb4yXiPBmfXYLA6keEI7wC
 91SnNYAuhOZv/IRelalns1smU5BVPBH+JPR4V8KHZ/z7SfKAr6Gg9S6dS6Ky1GS40yodn64F8xsz
 7EM+yGFbakC5oEkFjXu94abqtB0lIEOU9/oMkDV8XadOD8S1cxNodLDDf5l3JEFm+EAH0D6NSgyY
 U6AAssvmSHvu/3g1EREEK/QoXKeBiak6g5UK2VnrejnstannFxcZWsj1K5op18c/5/MIzBGTd1Yl
 ONPeQ6c5yHZ3m6rAwdbmIp+3YDZIeqiCL+Tp8MJjxWlw17IYM0yho=
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From: uk7b@foxmail.com
To: dev@dpdk.org
Cc: Sun Yuechi <sunyuechi@iscas.ac.cn>
Subject: [PATCH v6 0/3] Add RISC-V V extension detection and LPM optimization
Date: Fri, 27 Jun 2025 11:58:11 +0800
X-OQ-MSGID: <20250627035814.670775-1-uk7b@foxmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <tencent_6985C4D07FF1CB5C3AD652182E4F9DAA9906@qq.com>
References: <tencent_6985C4D07FF1CB5C3AD652182E4F9DAA9906@qq.com>
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

The initialization of vtbl_entry is not fully vectorized here because
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

Test results(LPM LookupX4):
    scalar: 5.7 cycles
    rvv:    4.6 cycles

v6:
- Updated the indentation in meson.build.
v5:
- Updated the commit message and moved test details and thoughts to the cover letter.
v4:
- Keep the LPM code consistent, use a static inline function instead of runtime detection.
- Update the commit message.
- Update the .mailmap file.
v3:
- Due to previous SMTP server restrictions, patches could not be sent as a proper series.
This version re-sends the same patches as a series. No code changes.
v2:
- Improved commit messages.

Sun Yuechi (3):
  config/riscv: detect V extension
  lib/lpm: R-V V rte_lpm_lookupx4
  riscv: override machine_args only when default

 .mailmap                 |  1 +
 MAINTAINERS              |  2 ++
 config/riscv/meson.build | 39 +++++++++++++++++++++----
 lib/lpm/meson.build      |  1 +
 lib/lpm/rte_lpm.h        |  2 ++
 lib/lpm/rte_lpm_rvv.h    | 62 ++++++++++++++++++++++++++++++++++++++++
 6 files changed, 101 insertions(+), 6 deletions(-)
 create mode 100644 lib/lpm/rte_lpm_rvv.h

-- 
2.49.0

