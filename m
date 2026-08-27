Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71DE2C61DC6
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Aug 2026 11:43:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 32A1B40150;
	Thu, 27 Aug 2026 13:43:32 +0200 (CEST)
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
 by mails.dpdk.org (Postfix) with ESMTP id 353424003C
 for <dev@dpdk.org>; Thu, 27 Aug 2026 13:43:29 +0200 (CEST)
X-QQ-mid: esmtpgz13t1787831005tc7ae18e3
X-QQ-Originating-IP: E7pl/oQEfy9uHC+AM2cVG002IgHa+uCUofKIQ1WRK08=
Received: from DSK-zaiyuwang.trustnetic.com ( [122.233.170.62])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Thu, 27 Aug 2026 19:43:20 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10305178004207229467
EX-QQ-RecipientCnt: 2
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>
Subject: [PATCH 00/13] Wangxun fixes and new features
Date: Thu, 27 Aug 2026 19:41:52 +0800
Message-ID: <31C12A7AAC7E19F2+20260827114309.10530-1-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NUTz4BkILuKLSsrCOECgUHXROIBcbl1OeNeH0mJtZ/3ucd4cjZeqgXVe
 pyGyN5FDG2pGvB1EwRDyKCODHLc7PsCPLsQzrK1T8/BsL2VdSjince18HRKr9FNZSnnfIp0
 y6b9ACHEzp0trl9WOz5VLj6w3fxd184BRoNm/qsn8iGg+1W5uv2skfSrEKD19G91o50qMvY
 OQtgWApaIAd3fjNvU7d4nBmc8kx3ipogIqEksLps+eK6gNhQzK6UJFOg+k2i+soE8jFgVmh
 YgqEvvJ/Ngwr9WKsov8cijQOT9yFkE1i8ijznVGKHvBWGaKsOSv/Cv03qnXjMj5EUiztHUC
 qxc65FaQtgIqXjSRsXbGU63gfs+dAzbdttsJP94L8lfjBaanR3Nxl785z9a/FEPgoH62EOp
 VFU1h7Bq5CNkoYJ0HOpm8LwZQu7BRoPSjZBanS43s2zXaFsyjDTXoPvFK8jscj5kx7U97Ly
 /3JUfQVz1SAdEHEptIpwyxiFZdAqm8QQ7YJFGjRD1yQjUyZvjQGZ1VX5Qf2OKi//I24UHE6
 kGjSzgSBKzFuKAFPmxR/o1YFp5f7R7okMggGfsbvhcJ4zgfnaaTv0YIZtdSxL2zVRxM/9us
 ZJVcDTCHD4sj//biZSZfj4tI0aHClsiD4Ls1D+gQyUIhucvlARvpmsUqw/4hRJXaaxq+0rV
 T9WbL292U23U5cc2wqaG/6J0eoDxbcKUklnfxGEDfhAiIGE+/xm4PqrjnPStnwmiVjUQ1MM
 pQc5iCYFWh2vMIwp5E8j/cCKUaDxXf8toY5Yp1CO/q8lF2gbUpXDCW8tPOVxVfdKuFxsJ+z
 2WtYz9mfFrYCOb+VlzrHK/Eoyc4jXgxGyusJ6M5iTixECA8R2i0ECoXB6mvfeD0a9aZysbl
 l0SEaedPTBlO/w7DVE8Tj+hfoBDhQFVzHBSlV6Wnwzz4wSmCfFp1sqmeCa+0ReT2gtndjws
 b+Lu0C8hxPu9iNAHJWrbhs0Qoo2cbJIiI7hqArdsI07GvcIr5lHpUZu80gebfWeS1A0lp3P
 s3o7IbuMqaKD0L3+fEx7MNDK0DZNIQtq4yuenXH/xMPiUP67U5BuNh5YP1ekg=
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
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

This series addresses link-related issues on Wangxun Amber-lite 25G/40G NICs (CR/KR training, hot-plug, 10G link state), and additionally refines UDP offload handling.

Zaiyu Wang (13):
  net/txgbe: fix e56 PHY configuration error
  net/txgbe: fix incorrect link state in 10G forced mode
  net/txgbe: do not force reconfig on link retry
  net/txgbe: set i2c sda hold time
  net/txgbe: fix link speed display info for 10G mode
  net/txgbe: remove stale outer UDP checksum offload flag
  net/txgbe: add offload support for tunnel type UDP
  net/txgbe: fix SFP hot-plug when auto-negotiation is on
  net/txgbe: fix DAC hot-plug on 40G NIC with auto-negotiation
  net/txgbe: add backplane FFE and capability devargs
  net/txgbe: add devarg to turn off Tx laser for 40G NIC
  net/txgbe: fix CR/KR link training and recovery
  net/txgbe: align link capabilities and DAC classification

 doc/guides/nics/txgbe.rst             |  18 +++
 drivers/net/txgbe/base/txgbe_aml.c    |   3 +-
 drivers/net/txgbe/base/txgbe_aml40.c  |  83 +++++++++++--
 drivers/net/txgbe/base/txgbe_e56.c    |  11 +-
 drivers/net/txgbe/base/txgbe_e56.h    |   6 +
 drivers/net/txgbe/base/txgbe_e56_bp.c | 161 +++++++++++++++-----------
 drivers/net/txgbe/base/txgbe_e56_bp.h |   2 +
 drivers/net/txgbe/base/txgbe_hw.c     |  22 ++++
 drivers/net/txgbe/base/txgbe_phy.c    |  13 +++
 drivers/net/txgbe/base/txgbe_phy.h    |   1 +
 drivers/net/txgbe/base/txgbe_regs.h   |   3 +
 drivers/net/txgbe/base/txgbe_type.h   |  17 ++-
 drivers/net/txgbe/txgbe_ethdev.c      | 120 +++++++++++++++++--
 drivers/net/txgbe/txgbe_rxtx.c        |  16 ++-
 14 files changed, 380 insertions(+), 96 deletions(-)

-- 
2.55.0.windows.2

