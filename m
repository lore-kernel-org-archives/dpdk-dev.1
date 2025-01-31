Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFE94C0218F
	for <dpdk-dev@archiver.kernel.org>; Fri, 31 Jan 2025 12:59:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 83F63411F3;
	Fri, 31 Jan 2025 13:59:22 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 25728400D7
 for <dev@dpdk.org>; Fri, 31 Jan 2025 13:59:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738328362; x=1769864362;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=mkYoA6mvfihsChse5MBGeO7fYWQk0p+fJlO04Qbzibc=;
 b=PfguERVLxcMHtQ2uJbb8PTfqyy5xvBC+g5p+8FiZ5n3J1BxQMlyeDsbF
 IyFc3byZJCpXm8pq8gg+iC5SMp9bts3DhX0ndd9494lrtqEGPBVZxOH0/
 m0bEYQWDxSOfV/N+82lmT2Xarotz5L3G80WOr4ZvQR4tTV7OQqeHNsU+q
 U36ugsEMf0xCNYpq6n/M55tLHcR8+TLpKjX/BRh+5t9/ArHbe9WtWBg5g
 hDvRqAPA6cGk6WyyNtkJdsH/cZcyV1Mp4MnRbjvPHPzHAONzJpVI36hu5
 bnjRiEQiq0WBcCKxFWRZizoxZdcWXtXfqBX/RJID3EdLhW5/Ds0zH/Kbf Q==;
X-CSE-ConnectionGUID: L//8RLyvTXe/3hup6D7ckg==
X-CSE-MsgGUID: FjUhbIlpRYS0EPxhIuNHrQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="50315593"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; d="scan'208";a="50315593"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jan 2025 04:59:20 -0800
X-CSE-ConnectionGUID: b/kwqpd4Tx+F341UStTetg==
X-CSE-MsgGUID: y8w8Eu8cSzSLuDwqrmpm3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="140503327"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa001.fm.intel.com with ESMTP; 31 Jan 2025 04:59:19 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v1 00/42] Merge Intel IGC and E1000 drivers,
 and update E1000 base code
Date: Fri, 31 Jan 2025 12:58:13 +0000
Message-ID: <cover.1738328106.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.43.5
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

Adam Ludkiewicz (1):
  net/e1000/base: add WoL definitions

Aleksandr Loktionov (1):
  net/e1000/base: fix mac addr hash bit_shift

Amir Avivi (1):
  net/e1000/base: fix iterator type

Anatoly Burakov (13):
  net/e1000/base: add initial support for i225
  net/e1000/base: add link bringup support for i225
  net/e1000/base: add LED blink support for i225
  net/e1000/base: add NVM/EEPROM support for i225
  net/e1000/base: add LTR support in i225
  net/e1000/base: add eee support for i225
  net/e1000/base: add misc definitions for i225
  net/e1000: merge igc with e1000
  net/e1000: add missing i225 devices
  net/e1000: add missing hardware support
  net/e1000/base: correct minor formatting issues
  net/e1000/base: correct mPHY access logic
  net/e1000/base: update readme

Barbara Skobiej (2):
  net/e1000/base: fix reset for 82580
  net/e1000/base: fix data type in MAC hash

Carolyn Wyborny (1):
  net/e1000/base: skip MANC check for 82575

Dima Ruinskiy (4):
  net/e1000/base: make e1000_access_phy_wakeup_reg_bm non-static
  net/e1000/base: make debug prints more informative
  net/e1000/base: hardcode bus parameters for ICH8
  net/e1000/base: fix unchecked return

Evgeny Efimov (1):
  net/e1000/base: add EEE common API function

Jakub Buchocki (1):
  net/e1000/base: fix uninitialized variable usage

Marcin Jurczak (1):
  net/e1000/base: remove non-inclusive language

Nir Efrati (6):
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

Przemyslaw Ciesielski (1):
  net/e1000/base: fix static analysis warnings

Sasha Neftin (4):
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
 drivers/net/intel/e1000/base/e1000_api.c      |   76 +-
 drivers/net/intel/e1000/base/e1000_api.h      |    4 +-
 drivers/net/intel/e1000/base/e1000_base.c     |    3 +-
 drivers/net/intel/e1000/base/e1000_defines.h  |  259 +-
 drivers/net/intel/e1000/base/e1000_hw.h       |   86 +-
 drivers/net/intel/e1000/base/e1000_i210.c     |   14 +-
 drivers/net/intel/e1000/base/e1000_i210.h     |    4 +
 drivers/net/intel/e1000/base/e1000_i225.c     | 1384 ++++++
 drivers/net/intel/e1000/base/e1000_i225.h     |  117 +
 drivers/net/intel/e1000/base/e1000_ich8lan.c  |  224 +-
 drivers/net/intel/e1000/base/e1000_ich8lan.h  |    3 +-
 drivers/net/intel/e1000/base/e1000_mac.c      |   62 +-
 drivers/net/intel/e1000/base/e1000_mac.h      |    2 +-
 drivers/net/intel/e1000/base/e1000_nvm.c      |    7 +-
 drivers/net/intel/e1000/base/e1000_osdep.h    |   33 +-
 drivers/net/intel/e1000/base/e1000_phy.c      |  447 +-
 drivers/net/intel/e1000/base/e1000_phy.h      |   21 +
 drivers/net/intel/e1000/base/e1000_regs.h     |   48 +-
 drivers/net/intel/e1000/base/e1000_vf.c       |   14 +-
 drivers/net/intel/e1000/base/meson.build      |    1 +
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
 64 files changed, 3300 insertions(+), 18218 deletions(-)
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

