Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FE75CD98E2
	for <dpdk-dev@archiver.kernel.org>; Wed, 17 Jun 2026 08:14:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 764D240289;
	Wed, 17 Jun 2026 10:14:44 +0200 (CEST)
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
 by mails.dpdk.org (Postfix) with ESMTP id 32A6B4027A
 for <dev@dpdk.org>; Wed, 17 Jun 2026 10:14:41 +0200 (CEST)
X-QQ-mid: zesmtpgz4t1781684076t66a3dee1
X-QQ-Originating-IP: k8VsSRhvyJG/PyTo7jUzRc2PbvRaLioiMRQYpOBQNp8=
Received: from DSK-zaiyuwang.trustnetic.com ( [183.157.22.210])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 17 Jun 2026 16:14:34 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 511779876356242016
EX-QQ-RecipientCnt: 2
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>
Subject: [PATCH v8 00/21] Wangxun Fixes
Date: Wed, 17 Jun 2026 16:12:47 +0800
Message-Id: <20260617081309.19124-1-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NrKIiCtjdVi7YhDmIwQhP+zUXeV8yTQ2KYiAJOz5lony8u+N3MeGpbcj
 aMVGg70OMh8EeD2flPSaubL8oFby9S/5gX8V4Yg70v/neQQ38hXZLzJ2cI+88FVhLM1QGnT
 9OT6A3yjNYol0M+gIExEKhvE5zSmUz93OW2MZwnQTvj2dChG0Rwoi6iE+kE6Qb+O+wlbxvx
 mw1DDHaqGwr3u4IwutPhhgcmfxhLe867k13SANhI3DEDKiIW0Wn6hmlWYPHytrQxwIFjXyn
 vKZL/5s5Z4C5dVAyEqZ5M+CGkJcCD/p1uhLYLS0+tB6+3IRJBFEdF+u88P1VOqF3Xru27p9
 dHlFGqTnpL/vL3zZYMQ2zmhnvGdWhG4DjDMoWv/zy5TCtW9tzyOudujOEqaSBdSXEW3PZnB
 Clw2t3vTvkxvrYuIfO2IHxRreIqvGMnxqjExqOZWUK2s3q/qktimkKND0aEaBKObxz/wnnA
 TUyRNzzhyA6ENfZk7BDH6agyV2LCWDLrN3krRdX0S/lg+t20iecC53HsKQ72G4qCbcXMasu
 /8Q/TgZrxjK0YjMvt/iq/PetARK2YQ9G5b22rn3FaynnkoASj9cgXwxJTdDKFXvl9A3DPy7
 t06E3ZF560bPH+tcml0Fav/DbSA+XtHw8/Iu7aaqPGlRBNWU/7AkOKFfS8meY9c2MnBI6WX
 jSGpgCFWn070xSaBUO4nVO6G3vaQxhtYRQnUWxr+rjypMYg6HwYRM94iyesaZ4cWFqlSUVi
 D65vB0nSHRluTx2mzBzQZxX+nTsmlVJPrBIEaxDTK6vlAy+uPtcUmfj1r7846k7wv3OFrTx
 YbPIaAOBJiaSN2loZXxchMviKjxVCCaMRTJcYcFnD/p0Y60Q3r0/bvwMzYWWk9BH00KmZEr
 Ku9MpwuG+auMUkwhyr0ncyLu8GoKn4hUG2DXtIZbKo4yzL6JcFnNtsrRxJT2KoCfS+ywM8N
 723eYVYf9Z1jVRu2pHwqA91/YRJxCEpS+VqLvXijuMBbM/nQTzPwwwns0GiJ69KWDyMkVtU
 j8uE9PvnT5lBxPbP4v4DXE3d+tIamwhsOe43eMorbe8rZ/ViOq5t2VePdMyQ+qq+ceDpBHK
 5mfg9PzmwxpKXKYECzYVmMM+afL9pvXnzyQLvnp7QZD
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

This series fixes several issues found on Wangxun Emerald, Sapphire and
Amber-lite NICs, with a focus on link-related problems.
---
v8:
- Fixed compilation error by replacing RTE_ETH_DEV_TO_PCI with RTE_CLASS_TO_BUS_DEVICE
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

