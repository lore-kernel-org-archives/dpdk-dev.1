Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46717CD98E1
	for <dpdk-dev@archiver.kernel.org>; Wed, 17 Jun 2026 03:34:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0737E40276;
	Wed, 17 Jun 2026 05:34:17 +0200 (CEST)
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
 by mails.dpdk.org (Postfix) with ESMTP id 8185F4026A
 for <dev@dpdk.org>; Wed, 17 Jun 2026 05:34:14 +0200 (CEST)
X-QQ-mid: esmtpsz11t1781667249t0068cf0a
X-QQ-Originating-IP: VCjeGJIxqiPA/syV74oBbuI6W95z8+nMee3HgQ+Puow=
Received: from DSK-zaiyuwang.trustnetic.com ( [183.157.22.210])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 17 Jun 2026 11:34:06 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 264661402801617433
EX-QQ-RecipientCnt: 2
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>
Subject: [PATCH v7 00/21] Wangxun Fixes
Date: Wed, 17 Jun 2026 11:33:38 +0800
Message-Id: <20260617033400.376-1-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NQf5gqJM31ZquKUVh6Ls9fqJUw3laHlgb6nZfHR9dyue4Wa8KEV2f2lX
 g/EbidCJcTZkeiEIWE5Es0uHaSI073WjLbXhtaCxigttHuIlTQZzGEe9bWW1O1uV6Shp0MO
 uQfuvH1gNydg83zkVRijmj5FbM1FhmlF6HirkBUAgAgCgwgh/PH2CXodEdp1cquaDv0xOZa
 b2pneKwooh5jddmKN0VMnRdpnMeTFpgqaKZCW6Ui7V6HISSr6wA4cjJKbGvIwK+eAw6+5D2
 WQaH2FMVgQ3rfJ5E61lLLR5lNlczNZ5v84Fr3hpgmSo8FCDgnfa+l3yuehJRZtW8wLJtDWp
 YwYreFcN5prCHC1L6eBDNwsg413K0LTFV7Tzc1NfVOsBu72aY0VShNEGPh/1xLdJ4iXXk8I
 JbL67vLp3jLJoAFFXfk+Tn3bXI/usE/gPQP1pJc7GTGuXmVwxDGq+0mvVAmSgAL1YNElGWl
 7VId4WNQg77uFhoAT6/iFuLR9Y8OtdZRK3apuk/6iwGcBnDBCMNsJ5FOo9xVjB/CB4yo0Ml
 WXIM0CmhavPTOQ7jR8BnBpIXBcldSciMyDcPsQthL6evXYvty3Q5wJCzql8AhV7AZfBmDPP
 RZ8IcSUbbnNXvyCYof1OGgmcFogiF7LgzyTQt9BzWN6CnFXMaE3xAn/4Xi3DeEUGPK5EGnP
 wswvIwU8VyCWRVgGjMqWa7+ZWRaxSjSO0KkXrCBG1J0jcf9lt2pylhX8kJNo1lH5CgGFD3u
 ayubRNp1ryKyEZsDDPTKEpV+V8GBev45RV8/NQRw0Eliy99NYqqwgc5SadMc3+XZ1+vS6Hf
 GsxPSi4JAcDMCqZ58IHbaZvRl4TGHJL7D+/OWqeB4z4za99dvkkVb7kAftVqZ4ctfq9izdv
 4DhhbKSKYsE6bk+yqDRLg5kqn2byNOOexLOPJggGUE/8q/J0/D0WlH882/PYi5p+61/76Y5
 9y+qQixdDBOTY9kTT2N1dXFFLcdS/s2N6sliqmARpvv6m5IXjbGKv7vuDm+WED89nV6j0Qf
 gAPAAPTRdhsh6cqpDljfbS5HhDYbgnZIKgyokY1UV9d2UpEiabjBJMnreF07aTqM1B4WmJj
 WniYoMU7xVrMIOo//ZjpJJ6n7ML9vY2DA==
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
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

This series fixes several issues found on Wangxun Emerald, Sapphire and
Amber-lite NICs, with a focus on link-related problems.
---
v7:
- Fixed inverted semantics of is_flat_mem to match SFF8636
---
v6:
- Fixed more issues identified by AI review
---
v5:
- Fixed issues identified by AI review
---
v4:
- Fixed issues identified by devtools scripts
---
v3:
- Addressed Stephen's comments
---
v2:
- Fixed compilation error and code style issues
---

Zaiyu Wang (21):
  net/txgbe: remove duplicate xstats counters
  net/ngbe: remove duplicate xstats counters
  net/ngbe: add missing CDR config for YT PHY
  net/ngbe: fix VF promiscuous and allmulticast
  net/txgbe: fix inaccuracy in Tx rate limiting
  net/txgbe: fix link status check condition
  net/txgbe: fix Tx desc free logic
  net/txgbe: fix link flow control registers for Amber-Lite
  net/txgbe: fix link flow control config for Sapphire
  net/txgbe: fix a mass of unknown interrupts
  net/txgbe: fix traffic class priority configuration
  net/txgbe: fix link stability for 25G NIC
  net/txgbe: fix link stability for 40G NIC
  net/txgbe: fix link stability for Amber-Lite backplane mode
  net/txgbe: fix FEC mode configuration on 25G NIC
  net/txgbe: fix SFP module identification
  net/txgbe: fix get module info operation
  net/txgbe: fix get EEPROM operation
  net/txgbe: fix to reset Tx write-back pointer
  net/txgbe: fix to enable Tx desc check
  net/txgbe: fix temperature track for AML NIC

 drivers/net/ngbe/base/ngbe_phy_yt.c       |    3 +
 drivers/net/ngbe/ngbe_ethdev.c            |    5 -
 drivers/net/ngbe/ngbe_ethdev_vf.c         |   11 +-
 drivers/net/txgbe/base/meson.build        |    2 +
 drivers/net/txgbe/base/txgbe.h            |    2 +
 drivers/net/txgbe/base/txgbe_aml.c        |  185 +-
 drivers/net/txgbe/base/txgbe_aml.h        |    6 +-
 drivers/net/txgbe/base/txgbe_aml40.c      |  114 +-
 drivers/net/txgbe/base/txgbe_aml40.h      |    6 +-
 drivers/net/txgbe/base/txgbe_dcb_hw.c     |    2 +-
 drivers/net/txgbe/base/txgbe_e56.c        | 3773 +++++++++++++++++++++
 drivers/net/txgbe/base/txgbe_e56.h        | 1753 ++++++++++
 drivers/net/txgbe/base/txgbe_e56_bp.c     | 2597 ++++++++++++++
 drivers/net/txgbe/base/txgbe_e56_bp.h     |  282 ++
 drivers/net/txgbe/base/txgbe_hw.c         |   54 +-
 drivers/net/txgbe/base/txgbe_hw.h         |    4 +-
 drivers/net/txgbe/base/txgbe_osdep.h      |    4 +
 drivers/net/txgbe/base/txgbe_phy.c        |  362 +-
 drivers/net/txgbe/base/txgbe_phy.h        |   46 +-
 drivers/net/txgbe/base/txgbe_regs.h       |   13 +-
 drivers/net/txgbe/base/txgbe_type.h       |   43 +-
 drivers/net/txgbe/txgbe_ethdev.c          |  472 ++-
 drivers/net/txgbe/txgbe_ethdev.h          |    7 +-
 drivers/net/txgbe/txgbe_rxtx.c            |  109 +-
 drivers/net/txgbe/txgbe_rxtx.h            |   36 +
 drivers/net/txgbe/txgbe_rxtx_vec_common.h |   17 +-
 26 files changed, 9464 insertions(+), 444 deletions(-)
 create mode 100644 drivers/net/txgbe/base/txgbe_e56.c
 create mode 100644 drivers/net/txgbe/base/txgbe_e56.h
 create mode 100644 drivers/net/txgbe/base/txgbe_e56_bp.c
 create mode 100644 drivers/net/txgbe/base/txgbe_e56_bp.h

-- 
2.21.0.windows.1

