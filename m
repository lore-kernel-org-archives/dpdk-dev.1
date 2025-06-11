Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1015C678DC
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Jun 2025 15:00:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B8C0B40A7A;
	Wed, 11 Jun 2025 17:00:30 +0200 (CEST)
Received: from out203-205-221-231.mail.qq.com (out203-205-221-231.mail.qq.com
 [203.205.221.231])
 by mails.dpdk.org (Postfix) with UTF8SMTP id 6700640A71
 for <dev@dpdk.org>; Wed, 11 Jun 2025 17:00:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
 s=s201512; t=1749654016;
 bh=Nc2PyHuHYKxGNsT3I/Lv3y3KWO5mcEjIncNQu7UbdBE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=EOcQN26ztzGMSYy8QmCUtHkkoKCK0KAdsrp/9357l/dxPlsYwCYhuvyNXZeHPqBxo
 jci9JOqvvCIIVfq3iMv1sHUr9r4shX/lk2U0v1xOkB/uKs31AVHIZjfHyWQWiLZuMG
 g+E/0i2cRQ6duqkHn2UX1F/hfCoCHa4ccCRo2hpc=
Received: from localhost.localdomain ([123.189.192.127])
 by newxmesmtplogicsvrsza36-0.qq.com (NewEsmtp) with SMTP
 id F10665; Wed, 11 Jun 2025 23:00:15 +0800
X-QQ-mid: xmsmtpt1749654015tzgzp21p7
Message-ID: <tencent_6985C4D07FF1CB5C3AD652182E4F9DAA9906@qq.com>
X-QQ-XMAILINFO: MFA3rFz8fXqrGaKkvq61FLuTIvwYfaEM/r+fKZbCYnxyqmNKfBmOEu6rqRR144
 p+Z8VxwWdc6SUkWyI5D/NtyWzXYOns3RJ9np5/Msb3s63GDEuNebbkBzQTHs0Nr3RLUZoHxOfp6R
 QsRv8+BvJxmF3BsEKJAwcCuuYfgdmGLPgAIi5ffKi+jZoihYGW/F31KrIsi6x4iDdmT836NfQiFg
 lsESL3hoaKaPC41BSFC86N4k+bBZIJ9FeXRPmf0MJ+DH6zsYyHLTaNOXaoQ3r7S7RPEDNTrL0jXz
 Jeo6DVADHenUWoSEV+TuATZzv8PDu6Raa8xgvYIrQaOmiHa1Sdu9m/PiS/wleQ8LKMPDa9jHH+DA
 cLIGPlxAEjGftqt1Z14SGDY0jiGue4ir0PtRXhwheAJBQR8daC9+uyWAn9NDVQ3Z/PhPQfaPvpcy
 qsP1RTDPt9qggrMZehOVtVT0fd6bJhGI+quUD+6bh2FUHloMJw7PztUAYtgjPWwp9okPiFZFusfd
 JgMr/+67S7J66NWZUj8Wq/9S/ybKGd98FiJM7xIS9BtA9hKw5EgoVAXggpoylxpMhKo315p9o4jW
 hNxh1h5NZZEuk11dPCgt8Sj040yaopmXuNVnE2itiqK0odxIV3Rig/iCIQQvjmTDFx+uGk3M3XJr
 Jcx77WZNVn6nERp7PaxyRSk03DpaNir9fLqI3lp9gOKDFSnFG+bxRRAasoVWjL//Lbj3LKY1oTw6
 lWDZ4WqbT6K46TnL61ia5bP4skktoELpAgg7+uKzqkocIj19mpMbre0YCbcKJd2Qz1rmQ49j1Odv
 Is1Hq1ACNQemUwEqgn/CVqbgGnqsh0NUA3uvYYAWgqJUPhrklNDfVjTA8Tv31EGutchqXKG8XEXP
 AisrK0L8Vmg3NV66UcUnjs5Y/MoLVrE7xtdXoAciebpV2WgC5RPAe3h5e5zUwkkQZhKLAu0vVQ7L
 nRrDcLkus=
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From: uk7b@foxmail.com
To: dev@dpdk.org
Cc: Sun Yuechi <sunyuechi@iscas.ac.cn>
Subject: [PATCH v5 0/3] Add RISC-V V extension detection and LPM optimization
Date: Wed, 11 Jun 2025 22:59:11 +0800
X-OQ-MSGID: <20250611145915.854026-1-uk7b@foxmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <tencent_C18B280C87275E35D0427508AF98674E1005@qq.com>
References: <tencent_C18B280C87275E35D0427508AF98674E1005@qq.com>
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
 config/riscv/meson.build | 27 +++++++++++++++++
 lib/lpm/meson.build      |  1 +
 lib/lpm/rte_lpm.h        |  2 ++
 lib/lpm/rte_lpm_rvv.h    | 62 ++++++++++++++++++++++++++++++++++++++++
 6 files changed, 95 insertions(+)
 create mode 100644 lib/lpm/rte_lpm_rvv.h

-- 
2.49.0

