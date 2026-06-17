Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB608CD98E2
	for <dpdk-dev@archiver.kernel.org>; Wed, 17 Jun 2026 11:00:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 913DD40289;
	Wed, 17 Jun 2026 13:00:20 +0200 (CEST)
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
 by mails.dpdk.org (Postfix) with ESMTP id 6A5AF4027A
 for <dev@dpdk.org>; Wed, 17 Jun 2026 13:00:17 +0200 (CEST)
X-QQ-mid: esmtpsz21t1781694011t9adc0de5
X-QQ-Originating-IP: ztstRv6xMslVlg0eKE6ugDKHYYHgHuRJeQEDm0gtHMQ=
Received: from DSK-zaiyuwang.trustnetic.com ( [183.157.22.210])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 17 Jun 2026 19:00:07 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12361192145808743525
EX-QQ-RecipientCnt: 2
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>
Subject: [PATCH 0/4] Wangxun new feature
Date: Wed, 17 Jun 2026 18:59:55 +0800
Message-Id: <20260617105959.10764-1-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MnOdDKjgRjEnaYUBpr29gjRBasGJlfDfwpmWdxxIgSqjGCsCdQBJiCLH
 kUDUe4LwCb/7zktcs4tOBtj8C7lGWDE3ASxtJiF5b0nJ7AFB2wE0OGxysPXP0eNbpRQdCLX
 K1+sblDJ8GChTk7wOESznw9Zb0XqErl2KqD/jRlTrjt7QHYQvEoSu2TxtbM8Bmcx6DDwKet
 hMfCic2cb6ypyz+jk220Qu8TXblOqnx1jp3vxxfMKGkSqnSe3ZPCoFO3f0oK+FSBHB+5QNg
 3lld79wxFHJASHTQsrHT2DQCgk9GQ6hBXL6EyYL9hoa7srdllOIqM1V8dIvTSJxPX+LaL25
 AuDwudIW+SZ1OwaACKzV6R9furXrdo35QK3KxvX7JmrlVET+mmJ6MZ7J8cZZ3cR2El2MJiC
 eLAmbMim6QMbZwQSnTGyVtXwPUGlY5dl57krE1VOODXJyBPI9YrttTfjvVcvwzLAJ52QXUd
 c0jWIwEtrZ7RV/rxFCfHMc4qvbsl3jeZnjOHXQBotpYnFBoMLLHLMPl4JOu0i3yy46+z5B0
 ZHjIwQa1hfvCwQQUFZwxV6b21VkMTcWBhaEXCMZfY/jRndQoNnq6I1QWXjsByg8aQ4fJ/V8
 RPeC1x9S7ZugmwyQSRhlz+5hrYeJOchuu4+Huh+YcxWVmYyE4D+cvRTH2FEwKyInMWTHsZr
 OiCtQgW6Q2SRc5uxLMS8SEWwF6XhtN5HfHIhM4QvKdOYoJ0KTlMI7h+ispzvauGtBYnhI9q
 gqFfyXeCWhVCO5wr/A5H0Jy1IlFD0uQJOBV7OVjZE6h5sJsAjZGN4EPVwuxry+gMImVmww/
 IolUCBRRXVc1/FfYmDfF0ospx398JYS+ggNoF8rJ8UdRKpEl/4YQ/7m1YObtpHXavgryih5
 /qNWeXoMqJ4AdUEeoBsHFMbjp9Uh2kAPXjeedfYd7PdtjjpfWvHy11sH3mI+6yQXw5E84K3
 WNBsFTBfNkNkb1JMtTKvk4/a+ITnlYzyQmGQXdDZjM9f5FEZ1g0qEbosGk6QkIlLgH+LRpl
 uDSNIo0XN57/uxS0jKgYcvIPHFcG+EQNbPo94cApF4/hbpGLPsyU9t9T6GIDgwEowUAZnn4
 gWmjZxwC45w
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
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

Patch 1/2 adds support for UDP Segmentation Offload (USO) to improve
large-packet transmission performance for UDP workloads.

Patch 3 enables VFs to sense PF ifconfig down/up events, allowing
better fault tolerance and fast recovery in virtualized environments.

Patch 4 adds the missing VF support for the Amber-Lite 40G NICs, which
was previously omitted in the initial integration.

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

