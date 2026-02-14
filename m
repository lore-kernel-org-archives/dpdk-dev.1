Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99F55EF99FF
	for <dpdk-dev@archiver.kernel.org>; Sat, 14 Feb 2026 07:12:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 754E3402C0;
	Sat, 14 Feb 2026 08:12:07 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id BF01240151
 for <dev@dpdk.org>; Sat, 14 Feb 2026 08:12:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771053126; x=1802589126;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=EaI+SGluYfRupYQgwyIKJML+pBVErToZYkZM+Wxylzo=;
 b=NcKSM0XSe4OiHy8+dFiP2XGCAlP/r+8+g4I+rRmiYINaMfucB5x9l/VF
 4lptJRLusqPgT+nm0t9JQnHw7gtM31WA8VGK6Q9kKu4WGz6PLVTF/8Dm2
 rSJxysPePyrXQ8Jjy1156eF9ET6tJdrzXRoAvD7UbZPVbhGGgC0D4Um2x
 f7RBdIbhOCX7b+EUZfHDH0nZgPL5DIQ99IO/bY/MBeHLn/uerkIaQ8edb
 PJEz1jAlNQMW7QLPkFK78wnzxzSWyhj0r61Kx6MbjFXRsVe/jRVi6RRXs
 VepWrFnvMSh/0QqbcLhseDtqdic5jPLRBITZ3v++AYgTTdr7FXiD4fMLe g==;
X-CSE-ConnectionGUID: TWBlbCj4TSCQyitZMJMXig==
X-CSE-MsgGUID: BTEAEbbkRIKs+atcqV9mow==
X-IronPort-AV: E=McAfee;i="6800,10657,11700"; a="71426337"
X-IronPort-AV: E=Sophos;i="6.21,290,1763452800"; d="scan'208";a="71426337"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Feb 2026 23:12:05 -0800
X-CSE-ConnectionGUID: 1lmMRfAVS2Wzt7jsn/NWrw==
X-CSE-MsgGUID: 35j25YKcQWWCJl6/l8koRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,290,1763452800"; d="scan'208";a="213137342"
Received: from fenlix-mobl.ccr.corp.intel.com ([10.239.252.5])
 by orviesa008.jf.intel.com with ESMTP; 13 Feb 2026 23:12:02 -0800
From: Soumyadeep Hore <soumyadeep.hore@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com
Cc: rajesh3.kumar@intel.com, aman.deep.singh@intel.com,
 manoj.kumar.subbarao@intel.com
Subject: [PATCH v6 0/4] Enable PTP feature for MEV
Date: Sat, 14 Feb 2026 14:49:16 -0500
Message-ID: <20260214194920.139066-1-soumyadeep.hore@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260123000449.188008-3-soumyadeep.hore@intel.com>
References: <20260123000449.188008-3-soumyadeep.hore@intel.com>
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

Enabling basic PTP feature in IDPF PMD using virtchnl messages.

---
v6:
- Addressed Bruce's comments
- Addressed AI comments
---
v5:
- Addressed AI comments
---
v4:
- Addressed Bruce's comments
---
v3:
- Fixed checkpatch warnings
- Addressed Bruce's comments
---
v2:
- Fixed essential checkpatch warnings
---

Milena Olech (1):
  net/idpf/base: add a new API for PTP support

Soumyadeep Hore (3):
  net/idpf: add PTP virtchnl2 support
  net/idpf: add timesync support
  doc/guides: add PTP IDPF documentation

 doc/guides/nics/features/idpf.ini             |   1 +
 doc/guides/nics/idpf.rst                      |  15 +
 doc/guides/rel_notes/release_26_03.rst        |   4 +
 drivers/net/intel/common/tx.h                 |   1 +
 drivers/net/intel/idpf/base/virtchnl2.h       | 324 +++++++----
 drivers/net/intel/idpf/idpf_common_device.h   |   4 +
 drivers/net/intel/idpf/idpf_common_rxtx.c     | 121 +++--
 drivers/net/intel/idpf/idpf_common_rxtx.h     |   7 +
 drivers/net/intel/idpf/idpf_common_virtchnl.c |  31 +-
 drivers/net/intel/idpf/idpf_ethdev.c          | 270 ++++++++++
 drivers/net/intel/idpf/idpf_ptp.c             | 504 ++++++++++++++++++
 drivers/net/intel/idpf/idpf_ptp.h             | 130 +++++
 drivers/net/intel/idpf/meson.build            |   1 +
 13 files changed, 1261 insertions(+), 152 deletions(-)
 create mode 100644 drivers/net/intel/idpf/idpf_ptp.c
 create mode 100644 drivers/net/intel/idpf/idpf_ptp.h

-- 
2.47.1

