Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4517FC5B552
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Jun 2025 07:05:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1322040687;
	Mon,  9 Jun 2025 09:05:17 +0200 (CEST)
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
 by mails.dpdk.org (Postfix) with ESMTP id 18DCA40661
 for <dev@dpdk.org>; Mon,  9 Jun 2025 09:05:13 +0200 (CEST)
X-QQ-mid: zesmtpsz9t1749452708t75f014e6
X-QQ-Originating-IP: sPHwHqqenCz3xI7U41/3HvTgkGllBNPdsMLpY5Ejuyk=
Received: from w-MS-7E16.trustnetic.com ( [220.184.249.46])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Mon, 09 Jun 2025 15:05:01 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1322182885600227918
EX-QQ-RecipientCnt: 3
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: dev@dpdk.org
Cc: zaiyuwang@trustnetic.com,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v2 00/12] Fixes and supports for Wangxun NICs
Date: Mon,  9 Jun 2025 15:04:42 +0800
Message-ID: <EF08B4F26F6A2669+20250609070454.223387-1-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <00DEAE896AFE0D2D+20250606080117.183198-1-jiawenwu@trustnetic.com>
References: <00DEAE896AFE0D2D+20250606080117.183198-1-jiawenwu@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: M3ZkD08p3wd5djYWUm3Ow+zkyuGbQ8kJZ8NRuV5ipeFL95p3CuoGzNjk
 Ie0vzSoetiwtFMs27FHCIUchdWxwCVpezerJUk/oUD0mB/gMeaRqLUOqrEgkhaMtLTiuKoE
 SYyHMzDgtfhCvkMWtz0dPNPMBOXkA9vk86GIBR6IossMtsm0IS4g2+A0kbWHdyndL0uFge4
 Payzpthhl9UklSeKtZweRd/mLS727QUtvVSRRArGqq3oPwdBpml290TIQJHM5lf/r9w/00M
 E0I8ldQY8KReBJhIYBcMZ+P4d+inhgkUaB3QIhvuag89qQVNJzv9KRB+wzE9gbFl//m6x0g
 jXPeBoTxy9yyDCBbpjV06B4CZP7cXjpG4qcdi1jdIKv1pWqnHotzFKTSZCWkH5Jn2gCQOK6
 sXLxJt48XFTpxIMEvfJ3lmXVs68mOjFSUAYgKvsGoXlB+rQkuTpQ+SL/IWUTdw0SbbAOFj/
 AvMhVNMBpXCp40sgXLxAwMpYEZ9mQT5lzhSTpHSmc8eF/oD/0Lv9SzLMrZzC2KXTcmeGfNT
 4htbFnEBON/J/RtFcv3H8tcg4GhMfB/Zm+RwZt/lu3pnKZGz6acqMvImYMHsML2y1Tn4tU9
 LGXJt8HPU/kLXYOxFT27S5kqmpcemQWpePZ7xhBy5d4TAHpMs48fZDO6Wd7Xpgwdr16tjiw
 4floOk1wXJXztGXGbCqBDmZK9+loaDz2Cb/ZOQrzVAU/iZDjInKTg99yGHTFnUQ6epFASkm
 dAMZSo2ehzet/N1qiWHc40zWVJv1P9pba3A5FGt9aLrNPjP/Hn2kL27O/Ej8upPpU/NqZH/
 G6vgEBEhaSVqOwRyA31TJHQMhbWewkglIMxagw1YwidXsci6HKwTlAjEFsedx/MCORbNswJ
 iocR07kC/e9TSpXVHco8nTpml7L0BSmnd5cX1mstX+4GumvqN1rDrH8Xrzj6aYTfxwyHNu3
 A13+FaPGGw1/lMssWgqETosll0J2Exwux+JbVO3ZUc8fdZoHdfdmwj7j2LQszKPBlX94qbL
 tzT6alHucmp47SGEe9
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
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

v1 -> v2:
- Add new flow feature geneve and gre into txgbe.ini

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

