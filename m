Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C06BEC5AD49
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Jun 2025 08:01:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 41EC8402D9;
	Fri,  6 Jun 2025 10:01:50 +0200 (CEST)
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
 by mails.dpdk.org (Postfix) with ESMTP id 7E65A400EF
 for <dev@dpdk.org>; Fri,  6 Jun 2025 10:01:46 +0200 (CEST)
X-QQ-mid: zesmtpsz2t1749196901te2bdd55e
X-QQ-Originating-IP: QjzFtsVZbfTmbpHvzgsat6t+3XH8v7OY7l5QgDalGLI=
Received: from w-MS-7E16.trustnetic.com ( [220.184.249.46])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Fri, 06 Jun 2025 16:01:34 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 15430318269192433800
EX-QQ-RecipientCnt: 3
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: dev@dpdk.org
Cc: zaiyuwang@trustnetic.com,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH 00/12] Fixes and supports for Wangxun NICs
Date: Fri,  6 Jun 2025 16:01:05 +0800
Message-ID: <00DEAE896AFE0D2D+20250606080117.183198-1-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: M5KJbUcTvJCQ871MSW5XsDlqkf7tAKquYb6lGHx/sfG+2Qnn61gfgdDx
 egthOqQbRZ2slzrZKXNzk3ZEgYfxVzVXzYUN5TQxi75rxMnQC+vzhgy0peoA2WB+8TJEA/Y
 GktiAef3vtYhJgYY/6SRTNzUG/aMJJ++MsG/HoFgMQapqNFAh2wUI2kyLOwYdF/CFwP0O3D
 62aKeZZR5UXJzi+tcJ8T3fRYMuja5+UaXrCeUqmy0rlybFZC++47NxuT/V68i/fwTwkXH+x
 CVQuKUKdBY7QeW05j3I637LcP0+1bIuTFcpvoOgV/6LUyCpySQPS3jo5WuOFvkbbBo1IeR5
 Fp/wvZbsVF1ve64Jka8KZiL3Hdf+S0fdfOvaRZgYlDFRgapMhMXkZK//Yw58XRKutu7y/lY
 5tj87joDBlxOdLEs/c/n6TI11vvSDm/e12JCG6URnE7qjrPxJep9xWf0rw3BvBqckP6kpSI
 4bENFC9MQCmuQJ8Jkzj2d5Q3B46X2u+t9BzNtbu3qnTuIsz4N2DV0XtdHIRz+PIy2/e3I1Y
 sgDL7keGAgEcqwce5Q0poVEa5UsQnWwRG6zptmvxERwUSCnkG0VtRXLOOKhbSrqt2olqIYR
 TKrpIbNpNHsOR8Ibh4YnmjNBVVxoCWNVPIJoCCA46F0LDmZRvKT1D2js33NT6Mz33YUf8wz
 Kg9gyaq7FG4fVwsZD52Cuojzx5S8K4rjqimM/Ch5jm9XEOiDaZo8EEaQMuAQ1pvcgrKPuAt
 QZrUX18gOwmMYfJEYykPnfIY5xWJ9HMuRA0biRhwnkj4P/UlS3iFxLDYaqnxN5RGbbEj8vd
 G3lA8wHI2zRpRm5oSmYiBUNuaPi0mvYdKwofu0kzJ56Oy6wH+qYl1gbj4RJq0VkIb01mNx4
 oME9zHQ+aIyYMCbifR13R93qF5k/CFyTsV2w77KhJGV36RdSdvAOPgSw/xebQKSnaZx/fz0
 ev9Bx0gItOQ8jnOjQBO7csxobVofGaFQcPQdos9TqIrjNJro30b0NSEvcfBBnMsa9w4IGdB
 VOUGztwQ==
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
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

Jiawen Wu (12):
  net/txgbe: support flow filter for VF
  net/txgbe: refactor FDIR filter to improve functionality
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
 20 files changed, 943 insertions(+), 288 deletions(-)

-- 
2.48.1

