Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12FEEC5B549
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Jun 2025 11:49:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DE7EA402D8;
	Wed,  4 Jun 2025 13:49:25 +0200 (CEST)
Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com
 [162.62.58.216])
 by mails.dpdk.org (Postfix) with UTF8SMTP id 797FA4029D
 for <dev@dpdk.org>; Wed,  4 Jun 2025 13:49:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
 s=s201512; t=1749037756;
 bh=Hjr0XbO/ojJw0nJu2dHawW6RJJudiS3hOQ1CIPsGNWM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Pn4oZCal37ij2dOMN+RyB28HjNyOZvFrL6Zlt8A/p9Lp96MMAkqQWU1VO6/KN5qHV
 irHOV/yP6hyv1XKMrcs5c4pdpQYvRtMJhgM6ci+3xrS1XTDmOGHh2EHbZsofmtdXKF
 FkztgjxD3XR9/3jj1i/PbJn2z5F6e/Krbc1/0gqo=
Received: from localhost.localdomain ([116.139.97.45])
 by newxmesmtplogicsvrszgpuc5-0.qq.com (NewEsmtp) with SMTP
 id C4E996CB; Wed, 04 Jun 2025 19:49:14 +0800
X-QQ-mid: xmsmtpt1749037754t93jiqudl
Message-ID: <tencent_9A0D6514C3CF8D60298569F0ECA8565BF40A@qq.com>
X-QQ-XMAILINFO: Mkw1Oys1xyjCvcYyHO6xtDe7/E68x8R0u4YUpvuVhpgffC9Rd5eTKKmEiS+snO
 vMU1Kltamm2dqPxW7u6JTG8pTqEGxZAK9yI6U3fYR5q99sGbRC1P/PiKPowEYTQNSNj1MTzw9KCg
 TEK5X4RbLYGCl+PjR1BK2RHjIJKKN4mxnfY2wSmLrRUvwuENdKp9juqbmjFEuTg8YD1K43FVaLvF
 BXa9Dtuj8Fz1ZK2VUtpLyviFk3RnZEOkZvoHEB2gvkL3dulCK9ha0Q6YpqNcNeP7dUPq/6PE3WkH
 ooXTSdlo8c0FT19QobjJbI41sC85F6lfJ+a1+/V08ip1Q6wZycGcabwD2FN1UUvOo30KTXXn6tvq
 +rW3IkiSwbWIdXX5KDLSTBaybBkc8Vm4WUBgVgqnmjQnB4/1aM6RqTG/Zm/lBQmODKk5l4SOySwD
 nbIHnh8IzHnJz7P5VagACIn4ZM/cNqhHHbLizMRMGYOPM4kVo+mcuj83K0gTUoFn7Bu9DS6EjFI1
 18NxdWlWHJYNf1x+19lW468uejsfv4PHK5LbH482i+PdT5+C6gbJxejyxQnxMnous4JJHBvrpJz1
 +eB01UeIFz4KQdXwi+wbaRe7zhDCXo0d6tztRupmemCfR+CJp5VI1rL43Gk1POln0PuwhyL69ZOB
 SLe/Yp7Pm0XtzgdTdkxksfcMAagi26Ixuip30Ja1FF9TCii1PRZvsCzP4orF9kV+1piHvpbv4424
 XiwUw/ykt4Un2Gn4FYjxQhpWv3LWCRz/dR+ZRuDNEdACyBrmogY4YdD8OmJAE3R5kQDjph7yXZCd
 tjVtZPeusgi6JYkJX+a3d87y5KIAFboB2x+3Fzpy+w21jdwPVZNOC7u8ce3hecnjE4aaWUmkwPn7
 uBWqWiV+FrTuXbOXVigw6yBwYqurZsPbHp024U8YgMGeuAAh5iro7x49WRtN3hORbigbqEBBBZZo
 XwYqCvMQqbDYN7LlGD6XUT6iV4kQ+trK5TUP7ltDumz9y850sxS7ZprpIN21T1VaLB71Zkv6nr/J
 oQ3+tJKLPLRoYU5jlC
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
From: uk7b@foxmail.com
To: dev@dpdk.org
Cc: sunyuechi <sunyuechi@iscas.ac.cn>
Subject: [PATCH v2 0/3] Add RISC-V V extension detection and LPM optimization
Date: Wed,  4 Jun 2025 19:49:09 +0800
X-OQ-MSGID: <20250604114909.1947407-1-uk7b@foxmail.com>
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

