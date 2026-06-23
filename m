Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57426CD98F2
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Jun 2026 11:38:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 429674042F;
	Tue, 23 Jun 2026 13:38:17 +0200 (CEST)
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
 by mails.dpdk.org (Postfix) with ESMTP id BD31E40612
 for <dev@dpdk.org>; Tue, 23 Jun 2026 13:38:14 +0200 (CEST)
X-QQ-mid: zesmtpsz6t1782214689t561e9cc4
X-QQ-Originating-IP: piO185SVAGo/SIQ87LIYcMtyMRqwI/GsZMQ2prgNJFo=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.204.248.247])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 23 Jun 2026 19:38:07 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12552831645946058964
EX-QQ-RecipientCnt: 2
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>
Subject: [PATCH v3 0/4] Wangxun fixes and new features
Date: Tue, 23 Jun 2026 19:38:00 +0800
Message-Id: <20260623113805.16464-1-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260617105959.10764-1-zaiyuwang@trustnetic.com>
References: <20260617105959.10764-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NzOHSugmTg7X/KKUrg5NpGtQD5AaEcsHoBRkzEYHN1il0fidGlU3qs4y
 372gsrwhrVyxGB9ddrDUTHwNuUaVxHv1Rrr+5FsnG0uyvKz72z8SH62vkMyf+BdQ1JqskR/
 /ebltLXbjs6DyOrzfGuqvTbZvprFLcmunBSrcpwXjzSnEqpnlVlEtGM1ksh9jRUgZ0atWsu
 82cOa8hAUuxR7XD8veJAyz//ZTdAvJcz/ld59iFT6283CnlhgzvTvgIH0WqKR9+49gZ+3/w
 tECxY5GDBig1nhYqjDsidBi3f7uvuvMqSpR5eepREiqCxJ34rVAi9FtIkJlOOdW2+flEyNo
 cACsARzKG+GZPqFDHjV6jVi840SRgFty/ImsTnAQ2YfFuHje/6L6BbNfe+RTmtwJLlFhKug
 vijgwpQVHIZUGWTfI1E26J3eZe1yPtNPHqVJEQRyxtWj2ZV5lSfAQvAoI5tobKRPSpMPlny
 YXAQHw2RcDQK1sg0UTdYw1Mi5VFmsV9LQj1BEGfy6ratBf2uGcY1v6izETlxAUOamTt8svl
 iExJ31OcuAUGhnpBRQmKFO8dt//PBIhbn0k94d6i3u/Am94gJEQBw2AUlBByYLYJ2yOE/pY
 phDzTxtRmGPQucN/iUtbf/OJiitj+A+HCQsbJUY+51yvQlRew7PtzHVNDncYvAegkuTNhkF
 IL2tLNFPTJokbuok+7uk0XiIW9X5jWWSiAUGek5U06faRzvhJsPLvqgHdNDaIhNq4hcEEq8
 lPUedcPDxMLmHvPmboIU228w8lfhux5CJ/qGFteR4JM3Or2uYxy7V3BflpWPar35VutDGFr
 MzpsM5V9bwJufPMCI4gWgulWuiMJRrfHYI2msbZYFVGdqCr1iMg+P3jHjXeEe/DgvlB/+jK
 sSeAWruhTICBq2ADGpXaUkdUwLsCHYwdFfj6723ze0RCri0+D6CqJkUE743PG25Z9TjO/vR
 ZCq41m8V97zTobldAcpTBLUTOSGW47MtfG6x+HQDZVOZccrZG8N6qM9lb/bDx9VpJB2zlGo
 0CsEMNMRsj8cLqm9H3ByCWosWrim/yeIq49/OZb+zmx+W+66VG
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
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
v3:
- Patches 1-2: change from new feature to bug fix.
- Patch 3: fix link status update in txgbevf_get_pf_link_status();
           extend speed mask from 0xFFF0 to 0x1FFFFE for 40G speed;
           reduce msgbuf array to a single u32 variable;
           correct commit message.
- Patch 4: add a cleanup note in commit message for dropping the
           redundant mac type check in txgbevf_check_mac_link_vf();
	   remove a redundant blank line in txgbe_reset_hw_vf().
---
v2:
- Rebased on top of commit 72fdcb7bd19d to resolve conflict in
  drivers/net/txgbe/base/txgbe_type.h.
- No code changes compared to v1.
---

Zaiyu Wang (4):
  net/ngbe: implement USO support
  net/txgbe: implement USO support
  net/txgbe: add support for VF sensing PF down
  net/txgbe: add VF support for Amber-Lite 40G NIC

 drivers/net/ngbe/ngbe_rxtx.c          | 13 +++---
 drivers/net/txgbe/base/txgbe_devids.h |  2 +
 drivers/net/txgbe/base/txgbe_hw.c     |  7 +++
 drivers/net/txgbe/base/txgbe_regs.h   |  7 ++-
 drivers/net/txgbe/base/txgbe_type.h   |  2 +
 drivers/net/txgbe/base/txgbe_vf.c     |  6 +--
 drivers/net/txgbe/txgbe_ethdev.c      |  4 +-
 drivers/net/txgbe/txgbe_ethdev_vf.c   | 62 +++++++++++++++++++++++----
 drivers/net/txgbe/txgbe_rxtx.c        | 13 +++---
 9 files changed, 92 insertions(+), 24 deletions(-)

-- 
2.21.0.windows.1

