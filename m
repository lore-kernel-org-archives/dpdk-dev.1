Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D25AC5AE59
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Jun 2025 10:59:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 184AB40649;
	Thu,  5 Jun 2025 12:59:16 +0200 (CEST)
Received: from out203-205-221-202.mail.qq.com (out203-205-221-202.mail.qq.com
 [203.205.221.202])
 by mails.dpdk.org (Postfix) with UTF8SMTP id 43EAE40281
 for <dev@dpdk.org>; Thu,  5 Jun 2025 12:59:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
 s=s201512; t=1749121144;
 bh=KQm8bFbRUTnSgxo/Pj6XbW7wXXa9BZFq/ZEn7XYFN7g=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=NSfV3Wk+vKeEuuFhAkZhtFzrSaSdgt/xxEzHqozDB0lSZ42mLhkuHoJykm1I6VB6G
 is7NFvEogsw3kko11xO0VJ9WnzTL1SR5svSMbp1DS51Kv073hPHTOKB+oHBG+sS8hN
 /Cy/8aTKLGbg/VhDAGHQ1IjfKSvwy+WjUG52bxoY=
Received: from localhost.localdomain ([123.189.192.127])
 by newxmesmtplogicsvrszb20-0.qq.com (NewEsmtp) with SMTP
 id EC294E32; Thu, 05 Jun 2025 18:59:02 +0800
X-QQ-mid: xmsmtpt1749121142tfx2srimo
Message-ID: <tencent_C18B280C87275E35D0427508AF98674E1005@qq.com>
X-QQ-XMAILINFO: NZzGjqyvvdMfERXFnUoAr2N6EpahKlYr2CIVrccDKp2XorVrIyPHrGvQNsyQUy
 8aiFMQgRb2nOirUMhSVyf5zfq7E6zOnWXmBOVnKUAk5JBf2CdMZtIKrpjL8c0uZkeZ3zeIRRGNLL
 KmfTK+URCojX5dHRIO/7DPlX+VJBZKszoQhY3TMxsUYdm0HsTr5eVV5zMmYWTlXd6F8eqv3kDbSz
 wQ0U3MeDGZZo2MNHDtjhQ5C/t/apJHCY/cAJoZeO/SMGFM2bijDVAInGf4I/x0ebBcseT+TUNnEH
 +1D42WNA81SPRv7XnNo8G9i5qQ4K12bYcTmiKjul4jzvfNvNraPoyJzmfuL17yI2Gj2+QPOMhXMK
 40SkKHDvQvlMUWi9OIve3BThJkg6y7ZXHYZZBwBydZMbdtQU7iitwsax+MA98rbygKgnbnwJ7xHu
 YLGa47rDWznUW19eNSQGJsyKGBdmx2olOBRHTYZ9AB6Wdv32MAjLg/MI6DqbxAIUgkv2EBYqYhJu
 A9RHx3dYysVWCO4JjCYl7gh0bVbuLzRF3g39FR6aLRxhxS07N4UJiB8MFwIFHKxSULU9GCXMJwxe
 kT4rLqr3JMLOL/Ta7p9pae6LqonMky2WnzzKzuShHvpcJz61Y1A0pFLQM81oPgJmEx/u9Ug7E7Xm
 HmbL/s0djgdIInCW3vkCHKIqVoPjsUdM1aOsWqtFFSV5rPSBi15MO9opkuAHWT6Y9nLgC5ExpzPy
 8iIjyHzHpmLKnbk4dOMKlcq9mgm8/Hgo7tQlJqEi3ko8gVA863VL8hKoF7+9WEm9F3sScQzOllTp
 WjTUaHcgFeuvJTEUdCgqc0urHjqc5BjxV57sqkqzbjFlIwcd5s/thh1WgfSOd+8J6qK4pOHmYV21
 2aYX236nUtsNOGjx/751584vD1L9DwD5gK+4pqJjTvC7Oma53Um2ktbkK1bYKs4A==
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From: uk7b@foxmail.com
To: dev@dpdk.org
Cc: Sun Yuechi <sunyuechi@iscas.ac.cn>
Subject: [PATCH v4 0/3] [PATCH v4 0/3] Add RISC-V V extension detection and
 LPM optimization
Date: Thu,  5 Jun 2025 18:58:40 +0800
X-OQ-MSGID: <20250605105844.3931758-1-uk7b@foxmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <tencent_3C14F3CE0963698675F04CA9725B540D5D0A@qq.com>
References: <tencent_3C14F3CE0963698675F04CA9725B540D5D0A@qq.com>
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

