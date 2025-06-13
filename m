Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CE8FC61DB2
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Jun 2025 08:42:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4859042E95;
	Fri, 13 Jun 2025 10:42:20 +0200 (CEST)
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
 by mails.dpdk.org (Postfix) with ESMTP id 9EEB4402E2
 for <dev@dpdk.org>; Fri, 13 Jun 2025 10:42:17 +0200 (CEST)
X-QQ-mid: esmtpsz18t1749804131t724c059d
X-QQ-Originating-IP: kTa3FHMWnUmx3ANGRmG+DEC1QEjzbyOaq3C7QD7OMvc=
Received: from lap-jiawenwu.trustnetic.com ( [36.20.60.58])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Fri, 13 Jun 2025 16:42:09 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12648560133224920175
EX-QQ-RecipientCnt: 3
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: dev@dpdk.org
Cc: zaiyuwang@trustnetic.com,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v3 00/17] Fixes and supports for Wangxun NICs
Date: Fri, 13 Jun 2025 16:41:42 +0800
Message-Id: <20250613084159.22184-1-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <00DEAE896AFE0D2D+20250606080117.183198-1-jiawenwu@trustnetic.com>
References: <00DEAE896AFE0D2D+20250606080117.183198-1-jiawenwu@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: OU1KiBGGGpgtUaHoKehAYKm7tYeuLhv28HpntfHWknPBl0ZjI0OFcvic
 LnHJXLpiKAQFzpg5BTRSc2kT61CQHb45uZUCOc0xh2sFBm/Gi0UyJdFAntOG3mtqZQ2TZwh
 JPYS6xLHFLxyInAIJM+tRJfJHjq2I8TmbxCRr4dhazGRafI0EedzQf0E5FGppc7dzwfyGZU
 KtVZvLycNPQYXUGH7DhiuldiWUHte4/U1tPnwytPdh3zAfJVC+c/UKZbRbUFJejhk4+Gzwn
 EIlWziDk7wsV+GazZfTXApRzYHaJWJZFOiEeYwWH19GhFrMGXXPMVXp5PrAi5YyEGGirb+z
 jbS0duYshZm6jqTX8iEs2lGFE+A6zdl0F9mFxA8q+IVQrqiUmHhiN4C3haCXYgOc4V37llI
 7jQEx/tqGP8DiF3qD2kvEFXZrQ1lLxCpg/xIR4MlCjIxx6F4u4Vl8Qs/iVSOL7//Ppm5fUR
 evsDi5KUaXpgplgs09tJ+xXtphv7jHkmDKdQu+csscq9XR7gvK4RvCdXCuKsp9yKb9zd8xM
 xfzN8e+GN70G2T6fspKpsC3b3zH/Y7DDUwEL97sUWZW2aD54sxls9UF0xVMTNNKgvfv0rRb
 9XHnYuftczjBeE9V6/q3VclHtugGV3nPOydEoSf0U0ltOPrUYUvPFHdjAE1GKDTmkgvCRAP
 vOe5yiP4lWbmtlVHhU9xcQ0AvEWYdZqZ5FGj6Nu8zhsYZQy0S03G/S2xUzT+0gEcvwjaV8w
 FVICvnoSMsCeM2KJ0v4wREgQephpyE+pF6lmdP72m5Eki+9RvO8YnL4M9bUaQlOPOu7TI27
 ELlLMao5VFo414h28zhUojcggj51fkO0LK0EPA5ILPUeKPqNf8dviB9+il//lP/xkjUoyV/
 zj3nqXsCsUpgrjMl6NFF6iYJND1vAREPowDeZLAP8zYXwEC/9CP13lIYNwJsSIpizuA8Ypv
 B6skA38xV1DRXFCrne72y/DECLI3KgPZ5Aed8HNjE65N4aGmbH3yvkxy+zzv4xCN8LZgESB
 vZJWPSYA==
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
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

Fix some bugs and improve flow filters.

v2 -> v3:
- Split the patch 2/12 for various changes

v1 -> v2:
- Add new flow feature geneve and gre into txgbe.ini

Jiawen Wu (17):
  net/txgbe: support flow filter for VF
  net/txgbe: fix incorrect parsing to ntuple filter
  net/txgbe: fix raw pattern match for FDIR rules
  net/txgbe: fix packet type for FDIR filters
  net/txgbe: fix to create FDIR filters for SCTP packets
  net/txgbe: fix FDIR perfect mode for IPv6 packets
  net/txgbe: fix to create FDIR filters for tunnel packets
  net/txgbe: fix reserved extra FDIR headroom
  net/txgbe: support RSS offload for SCTP port
  net/ngbe: support RSS offload for SCTP port
  net/txgbe: fix MAC control frame forwarding
  net/ngbe: fix MAC control frame forwarding
  net/txgbe: fix incorrect device statistics
  net/ngbe: fix incorrect device statistics
  net/txgbe: restrict VLAN strip configuration on VF
  net/ngbe: restrict VLAN strip configuration on VF
  net/txgbe: add missing LRO flag in mbuf when LRO enabled

 doc/guides/nics/features/txgbe.ini  |   2 +
 drivers/net/ngbe/base/ngbe_hw.c     |   9 +
 drivers/net/ngbe/base/ngbe_regs.h   |   2 +
 drivers/net/ngbe/base/ngbe_type.h   |   1 +
 drivers/net/ngbe/ngbe_ethdev.c      |   6 +-
 drivers/net/ngbe/ngbe_ethdev.h      |   2 +
 drivers/net/ngbe/ngbe_ethdev_vf.c   |  24 +-
 drivers/net/ngbe/ngbe_rxtx.c        |   8 +
 drivers/net/txgbe/base/txgbe_hw.c   |  23 +-
 drivers/net/txgbe/base/txgbe_hw.h   |   1 +
 drivers/net/txgbe/base/txgbe_mbx.h  |  17 +
 drivers/net/txgbe/base/txgbe_regs.h |   4 +
 drivers/net/txgbe/base/txgbe_type.h |  21 +-
 drivers/net/txgbe/base/txgbe_vf.c   |  29 +
 drivers/net/txgbe/base/txgbe_vf.h   |   2 +
 drivers/net/txgbe/txgbe_ethdev.c    |  18 +-
 drivers/net/txgbe/txgbe_ethdev.h    |  16 +-
 drivers/net/txgbe/txgbe_ethdev_vf.c | 111 +++-
 drivers/net/txgbe/txgbe_fdir.c      |  62 +-
 drivers/net/txgbe/txgbe_flow.c      | 857 ++++++++++++++++++++--------
 drivers/net/txgbe/txgbe_rxtx.c      |  18 +
 21 files changed, 945 insertions(+), 288 deletions(-)

-- 
2.48.1

