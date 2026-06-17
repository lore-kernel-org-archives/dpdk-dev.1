Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C6C1CD98E4
	for <dpdk-dev@archiver.kernel.org>; Wed, 17 Jun 2026 11:33:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 55AD4402AB;
	Wed, 17 Jun 2026 13:33:45 +0200 (CEST)
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
 by mails.dpdk.org (Postfix) with ESMTP id 824D14027A
 for <dev@dpdk.org>; Wed, 17 Jun 2026 13:33:43 +0200 (CEST)
X-QQ-mid: esmtpsz20t1781696018t02e9aa40
X-QQ-Originating-IP: m+Kt+9UbgT5g4gRzukJ+Xcil9T1J+1ZxgLpVX3rI9RI=
Received: from DSK-zaiyuwang.trustnetic.com ( [183.157.22.210])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 17 Jun 2026 19:33:36 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17974610653225671492
EX-QQ-RecipientCnt: 2
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>
Subject: [PATCH v2 0/4] Wangxun new feature
Date: Wed, 17 Jun 2026 19:33:30 +0800
Message-Id: <20260617113335.15648-1-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260617105959.10764-1-zaiyuwang@trustnetic.com>
References: <20260617105959.10764-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: OFwcIyq3IdMx0+u5S9x0hjYmaAUEC6MiQjmGB0tX4lJzRsLhy2bYbTYf
 lZdNnuUzL0Zop1n1QHvhfT/dLLh9Gz4TChVu9q13jaNEFB4wDz/BWPUvYtY12NRKYjD2mR0
 el0nCcJAfj3auAB4t8DhZc+8T3WqM6HZeh28cUwzRZS37YMuLH93ELt2NcR+qfULhEdYWIi
 1myvBZNdyNuHUJLrC3X6NOxeFeBa1aMiaI/p2MFXU/VaQa4vmi5TSZ7WoLbY8EKuFFcI3EB
 Jd+iAAAdjL7DQgryhXJHcWz1tlCiJBjHpq2miIynUaDexqR7YE5If1z4DSOrcCC/grwX3+j
 NEKgJW2DbJBs1mMoxSrt5iMRcLic/3O7MmfkN2sxdCMM0SJW9Sd8MG82Rnvymbfl3W7VTRb
 wijuL+HSGPYzivZtW5W1dc5zPLnaNs91SnUvNe5T902YgF5wluVTTiMHTd7R7dEnY2ak68R
 sxKb1EZZBHyI7+DGWFvSwUyKh+6ZdvNPFNFYObeKxjKvMIbCbJW1H8Y4R2fKcf+Ygaimq7Y
 qhtR9KzBo1pd/HYljZF+ASqKPQx4D2cXhF1Qc8RolO1BYn1jsgI85bFv+26pJc4EP4wn9N9
 phTtAVnj1amSt4aNQl0DfQ5p6dvnywRv6Yq8K1UELTgRxGtwdQO0HMNLRlVBPUXYi3Nw8Ay
 2Vvb+Jlg1x+6lUhCLDngdFn49knaiHGca3PhjptA3ZEy74vqpBkE5m84mXHLJqFcmuDOElL
 YiPHPlhh8pHULd+2rZ6nhz2zIwxeaZDAN79NpQ6EoG/9eluK5IXNwR+BvTdBMnGb/Du+MEQ
 E9cYUVK5xSmvT7nAdJ7oashr8UhXu/21aoEEGvWGXF4b4PLyT4hic9UwhXL6JZgS/RSJ3ay
 wVs4ZPgIB2BQCBnpWq1ov2d3bgEG2/ez3Kz45gMlL1n+z1FjUAHYyiJ6P96Ic7sfgVeUuYV
 FjKsRUH1qPWI+eUl14XAPIWnaf/02LuPI6yxp0ByKMPEIJ9LWi8TrTnBGCXIX6cN/VMRKt8
 Z4xD/Q/PGjZzvw/5MgMNblvBr+fP1I3PDhpGf3fmdjJXNOg85FpYVNxpkbvwrhCx2s5b1dr
 w==
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-RECHKSPAM: 0
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

This patchset introduces three new features and critical fixes for our
recent release cycle.

Patches 1-2 add support for UDP Segmentation Offload (USO) to improve
large-packet transmission performance for UDP workloads.

Patch 3 enables VFs to sense PF ifconfig down/up events, allowing
better fault tolerance and fast recovery in virtualized environments.

Patch 4 adds the missing VF support for the Amber-Lite 40G NICs, which
was previously omitted in the initial integration.
---
v2:
- Rebased on top of commit 72fdcb7bd19d to resolve conflict in
  drivers/net/txgbe/base/txgbe_type.h.
- No code changes compared to v1. 
---

Zaiyu Wang (4):
  net/ngbe: add USO support
  net/txgbe: add USO support
  net/txgbe: add support for VF sensing PF down
  net/txgbe: add VF support for Amber-Lite 40G NIC

 drivers/net/ngbe/ngbe_rxtx.c          | 13 +++---
 drivers/net/txgbe/base/txgbe_devids.h |  2 +
 drivers/net/txgbe/base/txgbe_hw.c     |  7 ++++
 drivers/net/txgbe/base/txgbe_regs.h   |  7 +++-
 drivers/net/txgbe/base/txgbe_type.h   |  2 +
 drivers/net/txgbe/base/txgbe_vf.c     |  7 ++--
 drivers/net/txgbe/txgbe_ethdev.c      |  4 +-
 drivers/net/txgbe/txgbe_ethdev_vf.c   | 60 +++++++++++++++++++++++----
 drivers/net/txgbe/txgbe_rxtx.c        | 13 +++---
 9 files changed, 92 insertions(+), 23 deletions(-)

-- 
2.21.0.windows.1

