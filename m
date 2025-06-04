Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB65CC5B549
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Jun 2025 15:47:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D40C042DF1;
	Wed,  4 Jun 2025 17:47:37 +0200 (CEST)
Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com
 [162.62.58.211])
 by mails.dpdk.org (Postfix) with UTF8SMTP id 0E74D402B1
 for <dev@dpdk.org>; Wed,  4 Jun 2025 17:47:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
 s=s201512; t=1749052047;
 bh=AxcLVzhjSEdyWmQaYrOAnWPhChPXnHUOR5Zm60z8Lnk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=mYfmaLC9apH6FKnLKPUahDGdPA99JOxv6E/QFfUrDHjaxGus1//iOvjWoH2IbIwnn
 8XqDqF2eURmWX6prqENgQD8KfD6Vzt8tPjwVQM8wcPRRrQa/bS0Z0J7BX0hnhsnmic
 gltW9+GTvzWnL9HDbe1y5jx0HcYW6eJ+XwTgwGQw=
Received: from localhost.localdomain ([116.139.97.45])
 by newxmesmtplogicsvrsza29-0.qq.com (NewEsmtp) with SMTP
 id BDA9C279; Wed, 04 Jun 2025 23:47:26 +0800
X-QQ-mid: xmsmtpt1749052046tx4y0gjps
Message-ID: <tencent_2FE6D4B024C2E4791A55B92C3286FE8AB309@qq.com>
X-QQ-XMAILINFO: MFWpArBVhhGTFUbteNmM9RLzeA5qT+O0teEG6QX7MuAnLdwUAmgy3uwz92DSd5
 +P0bYPz7raVMlsD2rnf4ieVy6rGePRVG0TUJ0qx6Ybu6c06TrCScwsNoFxDNKCfJcikowgU7KuDI
 FWDxpKm3y6SlXUJSNTRxFA7ZlYeh5lL0uDC7RLxATJll9ijT/UNu9dikl2kxIk/Qqv99H6VQIVgV
 eOPU6+7M0R1X6xKUAi/23QRL/jFIEEGmTzdVJWUUGGIuyuS2eh4FcTWCVt9Vfn1pygNwr/DRGdRq
 cTWxZYZr8pxbHI5juSggXxQpOYyTndI60Is4jpbiwC7CkQAdiZ3DDGlOUppJFNut7cIWH5rWIeq5
 IOv30fOOsymFnIp/tTWxTMjUAHqAtC2u7B1MC1ADSUNkVrYoPX5GJiCxvo3o0bIIaRC2I2hrWT9o
 9Ago+wAKHr7AogUT40TSrTNfziWp0Sl20qSf76LKLbJmH0cqEp+XduuU/P3rCF8xFCgTBbTmlk7s
 TvDjt0xAu9Yt4pULcp+6yMFp5BWK3Fu5UQzZCobHa3IAL8PpD+VCOohCbFXMSMnIslqvB5RKZ4rQ
 2f32aSKrxmfea0z/9zAa7FY8YsDhRi9fRCJbNvwKquxJCfUPcCB/59ytFrbkPq/9pm0+naqmjBvH
 oVni9e/yk8XGtWguZG64ffNFTHIewk4ayNgqond26wz1tefturuwzJ/Fgl+K2UqmWjWA+iPHSEtg
 zg/5hgcdvbPUqEhPngYHOxLdkaEp/mq4d1K988AgBEjcUE/cpzrikabHX2AdQ5WrL2sBc/SF6yrO
 WQ81//+TaGDuv8JYnD32YPkTmq2mSOZZH3xHr5kha+1PZQWc8zMny8McpLdti0WLLZGpDMb4NsEC
 R2CfjTcitQVPJjuzQmkwUd3UhRu01DGYCvM4zjm7loT3mm1X5fzHGz/FNhrQP9QjL8odwMTH2SfP
 odjxJo8eqotm2v22S3oPCDO1JXcllerbjnS903n0IoCbDAvfIffTwIp2jWw8Z/
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From: uk7b@foxmail.com
To: dev@dpdk.org
Cc: sunyuechi <sunyuechi@iscas.ac.cn>
Subject: [PATCH v3 0/3] Add RISC-V V extension detection and LPM optimization
Date: Wed,  4 Jun 2025 23:47:17 +0800
X-OQ-MSGID: <20250604154720.3078131-1-uk7b@foxmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <tencent_3C14F3CE0963698675F04CA9725B540D5D0A@qq.com>
References: <tencent_3C14F3CE0963698675F04CA9725B540D5D0A@qq.com>
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

From: sunyuechi <sunyuechi@iscas.ac.cn>

This patch series adds support for the RISC-V Vector (V) extension and provides
an optimized implementation of `rte_lpm_lookupx4` using RVV. It includes runtime
detection of the V extension, conditional compilation based on compiler support
for RVV intrinsics.

Test results using lpm_perf_autotest on BPI-F3:
    scalar: 5.7 cycles
    rvv:    2.4 cycles

v3:
- Due to previous SMTP server restrictions, patches could not be sent as a proper series.
This version re-sends the same patches as a series. No code changes.
v2:
- Improved commit messages.

sunyuechi (3):
  config/riscv: detect V extension
  lib/lpm: R-V V rte_lpm_lookupx4
  riscv: override machine_args only when default

 MAINTAINERS              |  2 +
 config/riscv/meson.build | 27 ++++++++++++
 lib/lpm/meson.build      |  1 +
 lib/lpm/rte_lpm.h        |  2 +
 lib/lpm/rte_lpm_rvv.h    | 91 ++++++++++++++++++++++++++++++++++++++++
 5 files changed, 123 insertions(+)
 create mode 100644 lib/lpm/rte_lpm_rvv.h

--
2.49.0

