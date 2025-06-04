Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9E9BC5B543
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Jun 2025 13:07:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AE35C42D80;
	Wed,  4 Jun 2025 15:07:49 +0200 (CEST)
Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com
 [162.62.57.49])
 by mails.dpdk.org (Postfix) with UTF8SMTP id CDB8742D80
 for <dev@dpdk.org>; Wed,  4 Jun 2025 15:07:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
 s=s201512; t=1749042459;
 bh=Hjr0XbO/ojJw0nJu2dHawW6RJJudiS3hOQ1CIPsGNWM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=W7GshvlMLufsjEjGJO8uHd6LgpvtV1BFHIXNxQdHnuQ+V61jzeUgNNLpRzKesN4+L
 6hpnz7JtpgRuIJnZcFIMLwupRxHuzc3+R4E3y2NEl8BnFyxtf2hFopYPzOlXyG36ak
 u+0ne3TRVA1J4KWhJwtHhXl0xf6FzGkzXkV51tw0=
Received: from localhost.localdomain ([116.139.97.45])
 by newxmesmtplogicsvrszb20-0.qq.com (NewEsmtp) with SMTP
 id 1E695429; Wed, 04 Jun 2025 21:07:38 +0800
X-QQ-mid: xmsmtpt1749042458tpq9h1aj6
Message-ID: <tencent_51258569F10CA9965AA00D6D162FCD45600A@qq.com>
X-QQ-XMAILINFO: OATpkVjS499uluhqroXs7S+O6qwi2hfztQpI/tcfWWxQ1LwhM02MmUIEjq1GYF
 ZqKmY6CFj+9872L0pGlhjZn9sROFttrKH2uF7/VmhghpGTKbnrJlTOJ1PZ4IRhJBPyfsyTmy+Edq
 PJvFDZX4YgBZLEl1Hq8r/IFfXTD2KA3qHUFCLNZP6b/18WTVc8ABK6E+KrGlee+4AHjtM8Av17iL
 rgEfXjhg5rIZKj+qUUUTjEOfd1V2+mb24vZjuKSLI5GxlLNXCrYLR/6zTDQM+M98vO8YjPtma7e3
 fGcW62alIko8CZEfYQYVqHHWj0HRJHm3CKsZE2Mwf+5FXCwE+oYMV0j1DCgfPZSn9vzQLNlcpfZj
 JD98Ujqg+2fh7QQ16Rcs0FKZbyPCmJN6B9KgJU4ZnwhEy9d2JEM0SVRPzn3bengRcJ0kAYL62QVN
 tQxcKTRJZBYELoNPpCsEYTE36ihR/4q7YusisaAvzfEAD1BdeYaMQ1Gd7/xVu3PXB1yaElz0WoaU
 2GmUpBIGx3MFxzXGeiURBIqDd8JkaST39evGFhmFCWLrXAU7DOdLkoOW5w2IsxgR3xIz6KfQ/g7X
 91He5RUS9DEB1HxIk6wPqjdzRD2c5QLKOeEpUHxHBUlXQxLrdzXz9fzVtXlMxbRE9NfZzr0TDKC6
 FH2dXqtCgZM0vitBCMbL8AHZrP4QQ5bdqP0g/LzImesoyQpectzYOK4koATqimB2m+JjiPebEG7U
 SLPTLXmcQVy+e81pEpY0quQgeMmB2vYtsQUQ17ylTFRldpvzbQ/oEF22iq7GQrFoetWji92+Wlar
 mxI5pFh1ebQCriRcspAe/oPdQrYV4/li0EEWPWrvnss+EqrBD9iSktuOoGfTb3unPdIQDcbGvUKm
 JmHFLD1VcjOmyWVj7eNYlhCrK5paNFVW+mFr6r68foneh7WL8THKOz8BIEjX5nTB3u/BKk5KfvXs
 CSJI/GkIzT1suJfIG77wBWYTKCs1HrFvGPasy4ZJ7av1ZoHHPQnSqem/WVFhOQDqThxZwI6Uoa3T
 m366Rqxw==
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
From: uk7b@foxmail.com
To: dev@dpdk.org
Cc: sunyuechi <sunyuechi@iscas.ac.cn>
Subject: [PATCH v2 0/3] Add RISC-V V extension detection and LPM optimization
Date: Wed,  4 Jun 2025 21:07:33 +0800
X-OQ-MSGID: <20250604130733.2346936-1-uk7b@foxmail.com>
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

### v2:
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

