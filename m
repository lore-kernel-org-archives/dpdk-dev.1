Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D223C02194
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Feb 2025 12:45:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 593E042DAC;
	Fri,  7 Feb 2025 13:45:48 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id A6A5E42798
 for <dev@dpdk.org>; Fri,  7 Feb 2025 13:45:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738932347; x=1770468347;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=g/gGT/rKm8yeQBWhxZB65JW2FbJhoTBJ/lMxQ2Nw9zc=;
 b=asPQ8cq7J6MH921tgoo69xaj2i+D5a1qVtfa/5zaq/HLvNn1rkjpcKW/
 pE7a+0Xyn/u6yzt5vTm0Klfx0sPfvYzHyihA+FM4RdV4CIYk2nCeoyNti
 5lyW7yqjk3J8O/NErZvjedjHmyaDT2u1AKlJnqGkXJWeGe9QCPsd2zMbs
 fDxas7zGt886PfgpZWubX90tHxdMxZWYA83fGXY7gcBn73fLJr+8qPsZN
 4sGdd54EUR5rNw3dPVuqnW68PWz2hOf+h98AdXaZXuocnYNJgEM6IBHqv
 VvTzIxUr0gJglx1GOmNhDwi2lDMKWhpdx39M6qk+4Mnfxbbeyk326D8AV A==;
X-CSE-ConnectionGUID: ScNbTMUARxOo7zPjwvgukQ==
X-CSE-MsgGUID: LGGbXRiLRVSW+zQ2FZTcsA==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="43331710"
X-IronPort-AV: E=Sophos;i="6.13,267,1732608000"; d="scan'208";a="43331710"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Feb 2025 04:45:46 -0800
X-CSE-ConnectionGUID: zGvxazKXSJeBMYVt6HDhJw==
X-CSE-MsgGUID: PpflmJjyT5aDL1jAsmhUmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="111953365"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by orviesa007.jf.intel.com with ESMTP; 07 Feb 2025 04:45:45 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v3 00/36] Merge Intel IGC and E1000 drivers,
 and update E1000 base code
Date: Fri,  7 Feb 2025 12:44:52 +0000
Message-ID: <cover.1738932113.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1738328106.git.anatoly.burakov@intel.com>
References: <cover.1738328106.git.anatoly.burakov@intel.com>
MIME-Version: 1.0
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

v2 -> v3:
- Fixes to drivers were separated out as a separate patchset [1]
- Fixed signoffs and authorship
- Fixed check-git-log and check-meson warnings
- Added libabigail ignore for the removed driver
- Added release notes
- Updated MAINTAINERS file

v1 -> v2:
- igc code is now a direct copy from IGC rather than a rebuild-from-source
- i225-related fixes are now separate, not squashed
- removed unused args warning workaround

Adam Ludkiewicz (1):
  net/e1000/base: add WoL definitions

Anatoly Burakov (9):
  net/e1000/base: copy i225 code into e1000
  net/igc: merge with net/e1000
  net/igc: remove the driver
  net/e1000/base: remove unused parameter workaround
  net/e1000: add missing i225 devices
  net/e1000: add missing hardware support
  net/e1000/base: correct formatting differences
  net/e1000/base: add missing definitions
  net/e1000: update e1000 documentation

Dima Ruinskiy (4):
  net/e1000/base: read PCIe bus info in i225
  net/e1000/base: make PHY wakeup access non-static
  net/e1000/base: make debug prints more informative
  net/e1000/base: hardcode bus parameters for ICH8

Evgeny Efimov (2):
  net/e1000/base: add PHY reset support for i225
  net/e1000/base: add EEE common API function

Marcin Jurczak (1):
  net/e1000/base: remove non-inclusive language

Menachem Fogel (1):
  net/e1000/base: add LED blink support for i225

Nir Efrati (8):
  net/e1000/base: remove unused function
  net/e1000/base: make i225 set LTR non-static
  net/e1000/base: workaround for packet loss
  net/e1000/base: add definition for EXFWSM register
  net/e1000/base: use longer ULP exit timeout on more HW
  net/e1000/base: remove redundant access to RO register
  net/e1000/base: introduce PHY ID retry mechanism
  net/e1000/base: add PHY read/write retry mechanism

Piotr Kubaj (1):
  net/e1000/base: rename NVM version variable

Piotr Pietruszewski (1):
  net/e1000/base: improve code flow in ICH8LAN

Sasha Neftin (6):
  net/e1000/base: rename VLAN PQF macros
  net/e1000/base: add PHY power management control
  net/e1000/base: add queue select definitions
  net/e1000/base: add profile information field
  net/e1000/base: add LPI counters
  net/e1000/base: improve NVM checksum handling

Vitaly Lifshits (2):
  net/e1000: add support for more I219 devices
  net/e1000/base: correct disable k1 logic

 .mailmap                                      |    3 +-
 MAINTAINERS                                   |    8 +-
 devtools/libabigail.abignore                  |    1 +
 doc/guides/nics/igc.rst                       |    2 +-
 doc/guides/rel_notes/release_25_03.rst        |   14 +-
 drivers/net/intel/e1000/base/README           |    8 +-
 .../net/intel/e1000/base/e1000_80003es2lan.c  |    8 +-
 drivers/net/intel/e1000/base/e1000_82571.c    |    4 +-
 drivers/net/intel/e1000/base/e1000_82575.c    |   16 +-
 drivers/net/intel/e1000/base/e1000_82575.h    |   29 -
 drivers/net/intel/e1000/base/e1000_api.c      |   77 +-
 drivers/net/intel/e1000/base/e1000_api.h      |    4 +-
 drivers/net/intel/e1000/base/e1000_base.c     |    4 +-
 drivers/net/intel/e1000/base/e1000_defines.h  |  261 +-
 drivers/net/intel/e1000/base/e1000_hw.h       |   95 +-
 drivers/net/intel/e1000/base/e1000_i210.c     |   14 +-
 drivers/net/intel/e1000/base/e1000_i210.h     |    4 +
 drivers/net/intel/e1000/base/e1000_i225.c     | 1371 +++++
 drivers/net/intel/e1000/base/e1000_i225.h     |  117 +
 drivers/net/intel/e1000/base/e1000_ich8lan.c  |  222 +-
 drivers/net/intel/e1000/base/e1000_ich8lan.h  |    3 +-
 drivers/net/intel/e1000/base/e1000_mac.c      |   50 +-
 drivers/net/intel/e1000/base/e1000_mac.h      |    2 +-
 drivers/net/intel/e1000/base/e1000_nvm.c      |    8 +-
 drivers/net/intel/e1000/base/e1000_osdep.c    |   11 +-
 drivers/net/intel/e1000/base/e1000_osdep.h    |   41 +-
 drivers/net/intel/e1000/base/e1000_phy.c      |  431 +-
 drivers/net/intel/e1000/base/e1000_phy.h      |   21 +
 drivers/net/intel/e1000/base/e1000_regs.h     |   53 +-
 drivers/net/intel/e1000/base/e1000_vf.c       |    2 +-
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
 drivers/net/intel/igc/base/igc_defines.h      | 1671 -------
 drivers/net/intel/igc/base/igc_hw.h           | 1059 ----
 drivers/net/intel/igc/base/igc_i225.c         | 1380 -----
 drivers/net/intel/igc/base/igc_i225.h         |  110 -
 drivers/net/intel/igc/base/igc_ich8lan.h      |  296 --
 drivers/net/intel/igc/base/igc_mac.c          | 2102 --------
 drivers/net/intel/igc/base/igc_mac.h          |   64 -
 drivers/net/intel/igc/base/igc_manage.c       |  547 --
 drivers/net/intel/igc/base/igc_manage.h       |   65 -
 drivers/net/intel/igc/base/igc_nvm.c          | 1324 -----
 drivers/net/intel/igc/base/igc_nvm.h          |   69 -
 drivers/net/intel/igc/base/igc_osdep.c        |   64 -
 drivers/net/intel/igc/base/igc_osdep.h        |  163 -
 drivers/net/intel/igc/base/igc_phy.c          | 4418 -----------------
 drivers/net/intel/igc/base/igc_phy.h          |  337 --
 drivers/net/intel/igc/base/igc_regs.h         |  732 ---
 drivers/net/intel/igc/base/meson.build        |   19 -
 drivers/net/intel/igc/igc_logs.h              |   43 -
 drivers/net/intel/igc/meson.build             |   21 -
 drivers/net/meson.build                       |    1 -
 70 files changed, 3296 insertions(+), 18247 deletions(-)
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

