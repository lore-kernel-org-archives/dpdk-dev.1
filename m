Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 096C8C02194
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Feb 2025 15:11:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9A91640EF1;
	Tue,  4 Feb 2025 16:11:32 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id CF37840265
 for <dev@dpdk.org>; Tue,  4 Feb 2025 16:11:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738681892; x=1770217892;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=W5AaSNqn19YPGcE9nsSSa9ge79TfJU96Q+uZucIuX98=;
 b=T1LMmSQORYToKUXIx1dXwLSxhbYFBvYIyToQQ877wLU35jR+mrQFiNi/
 gRnIBllo4wiEkLzW8nUtgHMIKUOPjRSZw3z6JWVqliYW/B8xtT76d+wYE
 yKHll5gTjmOMQjB6ldfrlG4B0HcnAiarKcMhzPs1OHAWpwGxeP/M2Ma1L
 ET9Xk8FV2xQoUFbBGGSoLDpyjDUqZQuCFBzbIfB0u9jMLpz41WQNw1Nvm
 s2hvy4TEwZDHXC/I0BBBQxTfDF0R4kdmrHu/e3BDCkLG3K5HmqRCD4eAy
 /ThgAquxwrOwbSSq4WZup8EZiN6CAR+Hv6IP5djjDHF3j8DVp3wU7mOGx A==;
X-CSE-ConnectionGUID: TM8wkX5aTxKI4tWNXjdwVA==
X-CSE-MsgGUID: PbUyuQMhTwWduzTkZiOgfQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="39097081"
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; d="scan'208";a="39097081"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Feb 2025 07:11:25 -0800
X-CSE-ConnectionGUID: guN1kobaT6mOSKTGGsdmxg==
X-CSE-MsgGUID: 5mkFwsDPSEOL4oeudBsIMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; d="scan'208";a="110792535"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa008.fm.intel.com with ESMTP; 04 Feb 2025 07:11:23 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com
Subject: [PATCH v2 00/54] Merge Intel IGC and E1000 drivers,
 and update E1000 base code
Date: Tue,  4 Feb 2025 15:10:06 +0000
Message-ID: <cover.1738681725.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1738328106.git.anatoly.burakov@intel.com>
References: <cover.1738328106.git.anatoly.burakov@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Intel IGC and E1000 drivers are distinct, but they are actually generated
from the same base code. This patchset will merge together all e1000-derived
drivers into one common base, with three different ethdev driver
frontends (EM, IGB, and IGC).

After the merge is done, base code is also updated to latest snapshot.

v1 -> v2:
- igc code is now a direct copy from IGC rather than a rebuild-from-source
- i225-related fixes are now separate, not squashed
- removed unused args warning workaround

Adam Ludkiewicz (1):
  net/e1000/base: add WoL definitions

Aleksandr Loktionov (1):
  net/e1000/base: fix mac addr hash bit_shift

Amir Avivi (1):
  net/e1000/base: fix iterator type

Anatoly Burakov (11):
  net/e1000/base: copy i225 code into e1000
  net/e1000: merge igc with e1000
  net/igc: remove the driver
  net/e1000/base: remove unused parameter workaround
  net/e1000: add missing i225 devices
  net/e1000: add missing hardware support
  net/e1000/base: correct formatting differences
  net/e1000/base: add missing definitions
  net/e1000/base: correct mPHY access logic
  net/e1000/base: add EEE common API function
  net/e1000/base: update readme

Barbara Skobiej (2):
  net/e1000/base: fix reset for 82580
  net/e1000/base: fix data type in MAC hash

Carolyn Wyborny (1):
  net/e1000/base: skip MANC check for 82575

Dima Ruinskiy (9):
  net/e1000/base: read PCIe bus info in i225
  net/e1000/base: fix deadlock in i225
  net/e1000/base: fix infinite loop
  net/e1000/base: fix typo in LTR calculation
  net/e1000/base: fix unused value
  net/e1000/base: make e1000_access_phy_wakeup_reg_bm non-static
  net/e1000/base: make debug prints more informative
  net/e1000/base: hardcode bus parameters for ICH8
  net/e1000/base: fix unchecked return

Evgeny Efimov (1):
  net/e1000/base: add PHY reset support for i225

Jakub Buchocki (1):
  net/e1000/base: fix uninitialized variable usage

Marcin Jurczak (1):
  net/e1000/base: remove non-inclusive language

Menachem Fogel (1):
  net/e1000/base: add LED blink support for i225

Nir Efrati (8):
  net/e1000/base: remove unused function
  net/e1000/base: make set_ltr for i225 non-static
  net/e1000/base: workaround for packet loss
  net/e1000/base: add definition for EXFWSM register
  net/e1000/base: use longer ULP exit timeout on more HW
  net/e1000/base: remove redundant access to RO register
  net/e1000/base: introduce PHY ID retry mechanism
  net/e1000/base: add PHY read/write retry mechanism

Pawel Malinowski (1):
  net/e1000/base: fix semaphore timeout value

Piotr Kubaj (1):
  net/e1000/base: rename NVM version variable

Piotr Pietruszewski (1):
  net/e1000/base: improve code flow in ICH8LAN

Przemyslaw Ciesielski (2):
  net/e1000/base: fix bitwise op type mismatch
  net/e1000/base: fix static analysis warnings

Sasha Neftin (9):
  net/e1000/base: rename VLAN PQF macros
  net/e1000/base: add PHY power management control
  net/e1000/base: increase PHY power up delay
  net/e1000/base: reset loop variable
  net/e1000/base: fix LTR for i225
  net/e1000/base: add queue select definitions
  net/e1000/base: add profile information field
  net/e1000/base: add LPI counters
  net/e1000/base: improve NVM checksum handling

Vitaly Lifshits (2):
  net/e1000: add support for more I219 devices
  net/e1000/base: correct disable k1 logic

 drivers/net/intel/e1000/base/README           |    8 +-
 .../net/intel/e1000/base/e1000_80003es2lan.c  |   10 +-
 drivers/net/intel/e1000/base/e1000_82571.c    |    4 +-
 drivers/net/intel/e1000/base/e1000_82575.c    |   21 +-
 drivers/net/intel/e1000/base/e1000_82575.h    |   29 -
 drivers/net/intel/e1000/base/e1000_api.c      |   77 +-
 drivers/net/intel/e1000/base/e1000_api.h      |    4 +-
 drivers/net/intel/e1000/base/e1000_base.c     |    7 +-
 drivers/net/intel/e1000/base/e1000_defines.h  |  262 +-
 drivers/net/intel/e1000/base/e1000_hw.h       |   95 +-
 drivers/net/intel/e1000/base/e1000_i210.c     |   14 +-
 drivers/net/intel/e1000/base/e1000_i210.h     |    4 +
 drivers/net/intel/e1000/base/e1000_i225.c     | 1372 +++++
 drivers/net/intel/e1000/base/e1000_i225.h     |  117 +
 drivers/net/intel/e1000/base/e1000_ich8lan.c  |  224 +-
 drivers/net/intel/e1000/base/e1000_ich8lan.h  |    3 +-
 drivers/net/intel/e1000/base/e1000_mac.c      |   62 +-
 drivers/net/intel/e1000/base/e1000_mac.h      |    2 +-
 drivers/net/intel/e1000/base/e1000_nvm.c      |   12 +-
 drivers/net/intel/e1000/base/e1000_osdep.c    |   10 +-
 drivers/net/intel/e1000/base/e1000_osdep.h    |   44 +-
 drivers/net/intel/e1000/base/e1000_phy.c      |  456 +-
 drivers/net/intel/e1000/base/e1000_phy.h      |   21 +
 drivers/net/intel/e1000/base/e1000_regs.h     |   53 +-
 drivers/net/intel/e1000/base/e1000_vf.c       |   14 +-
 drivers/net/intel/e1000/base/meson.build      |   13 +-
 drivers/net/intel/e1000/em_ethdev.c           |   36 +-
 drivers/net/intel/e1000/igb_ethdev.c          |    1 +
 drivers/net/intel/{igc => e1000}/igc_ethdev.c |  914 ++--
 drivers/net/intel/{igc => e1000}/igc_ethdev.h |   32 +-
 drivers/net/intel/{igc => e1000}/igc_filter.c |   84 +-
 drivers/net/intel/{igc => e1000}/igc_filter.h |    0
 drivers/net/intel/{igc => e1000}/igc_flow.c   |    2 +-
 drivers/net/intel/{igc => e1000}/igc_flow.h   |    0
 drivers/net/intel/{igc => e1000}/igc_logs.c   |    2 +-
 drivers/net/intel/{igc => e1000}/igc_txrx.c   |  376 +-
 drivers/net/intel/{igc => e1000}/igc_txrx.h   |    6 +-
 drivers/net/intel/e1000/meson.build           |   11 +
 drivers/net/intel/igc/base/README             |   29 -
 drivers/net/intel/igc/base/igc_82571.h        |   36 -
 drivers/net/intel/igc/base/igc_82575.h        |  351 --
 drivers/net/intel/igc/base/igc_api.c          | 1853 -------
 drivers/net/intel/igc/base/igc_api.h          |  111 -
 drivers/net/intel/igc/base/igc_base.c         |  190 -
 drivers/net/intel/igc/base/igc_base.h         |  127 -
 drivers/net/intel/igc/base/igc_defines.h      | 1670 -------
 drivers/net/intel/igc/base/igc_hw.h           | 1059 ----
 drivers/net/intel/igc/base/igc_i225.c         | 1372 -----
 drivers/net/intel/igc/base/igc_i225.h         |  110 -
 drivers/net/intel/igc/base/igc_ich8lan.h      |  296 --
 drivers/net/intel/igc/base/igc_mac.c          | 2100 --------
 drivers/net/intel/igc/base/igc_mac.h          |   64 -
 drivers/net/intel/igc/base/igc_manage.c       |  547 --
 drivers/net/intel/igc/base/igc_manage.h       |   65 -
 drivers/net/intel/igc/base/igc_nvm.c          | 1324 -----
 drivers/net/intel/igc/base/igc_nvm.h          |   69 -
 drivers/net/intel/igc/base/igc_osdep.c        |   64 -
 drivers/net/intel/igc/base/igc_osdep.h        |  163 -
 drivers/net/intel/igc/base/igc_phy.c          | 4420 -----------------
 drivers/net/intel/igc/base/igc_phy.h          |  337 --
 drivers/net/intel/igc/base/igc_regs.h         |  732 ---
 drivers/net/intel/igc/base/meson.build        |   19 -
 drivers/net/intel/igc/igc_logs.h              |   43 -
 drivers/net/intel/igc/meson.build             |   21 -
 drivers/net/meson.build                       |    1 -
 65 files changed, 3319 insertions(+), 18256 deletions(-)
 create mode 100644 drivers/net/intel/e1000/base/e1000_i225.c
 create mode 100644 drivers/net/intel/e1000/base/e1000_i225.h
 rename drivers/net/intel/{igc => e1000}/igc_ethdev.c (73%)
 rename drivers/net/intel/{igc => e1000}/igc_ethdev.h (91%)
 rename drivers/net/intel/{igc => e1000}/igc_filter.c (81%)
 rename drivers/net/intel/{igc => e1000}/igc_filter.h (100%)
 rename drivers/net/intel/{igc => e1000}/igc_flow.c (99%)
 rename drivers/net/intel/{igc => e1000}/igc_flow.h (100%)
 rename drivers/net/intel/{igc => e1000}/igc_logs.c (90%)
 rename drivers/net/intel/{igc => e1000}/igc_txrx.c (87%)
 rename drivers/net/intel/{igc => e1000}/igc_txrx.h (97%)
 delete mode 100644 drivers/net/intel/igc/base/README
 delete mode 100644 drivers/net/intel/igc/base/igc_82571.h
 delete mode 100644 drivers/net/intel/igc/base/igc_82575.h
 delete mode 100644 drivers/net/intel/igc/base/igc_api.c
 delete mode 100644 drivers/net/intel/igc/base/igc_api.h
 delete mode 100644 drivers/net/intel/igc/base/igc_base.c
 delete mode 100644 drivers/net/intel/igc/base/igc_base.h
 delete mode 100644 drivers/net/intel/igc/base/igc_defines.h
 delete mode 100644 drivers/net/intel/igc/base/igc_hw.h
 delete mode 100644 drivers/net/intel/igc/base/igc_i225.c
 delete mode 100644 drivers/net/intel/igc/base/igc_i225.h
 delete mode 100644 drivers/net/intel/igc/base/igc_ich8lan.h
 delete mode 100644 drivers/net/intel/igc/base/igc_mac.c
 delete mode 100644 drivers/net/intel/igc/base/igc_mac.h
 delete mode 100644 drivers/net/intel/igc/base/igc_manage.c
 delete mode 100644 drivers/net/intel/igc/base/igc_manage.h
 delete mode 100644 drivers/net/intel/igc/base/igc_nvm.c
 delete mode 100644 drivers/net/intel/igc/base/igc_nvm.h
 delete mode 100644 drivers/net/intel/igc/base/igc_osdep.c
 delete mode 100644 drivers/net/intel/igc/base/igc_osdep.h
 delete mode 100644 drivers/net/intel/igc/base/igc_phy.c
 delete mode 100644 drivers/net/intel/igc/base/igc_phy.h
 delete mode 100644 drivers/net/intel/igc/base/igc_regs.h
 delete mode 100644 drivers/net/intel/igc/base/meson.build
 delete mode 100644 drivers/net/intel/igc/igc_logs.h
 delete mode 100644 drivers/net/intel/igc/meson.build

-- 
2.43.5

