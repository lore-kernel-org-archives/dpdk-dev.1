Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6154DFC5915
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Feb 2026 11:58:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 829734028F;
	Thu, 26 Feb 2026 12:58:08 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id 051BD4021F
 for <dev@dpdk.org>; Thu, 26 Feb 2026 12:58:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772107087; x=1803643087;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=nXwAL81S/Pyqpo/nzNbKRNPT3OFqNgqHvcQe0y++jdk=;
 b=YOekWMgxAdD0AuW58JvWf1+c6+GH6tfxXMCaIj9zhPAkm13/4Lf51K3N
 yJ9pE1ZPEp7Zdc32Af89GIAQ41b937fKt6N4jxsFdGmyXu8gtBu5u22Ck
 JEzb6I21UsJgedpj+7PjnTk2+vtB2GZsiL0l8X34O5vcK+h6A/u0zqSKf
 bKWQdi6gM8VRqPv9FmTOISjBjatoNtV3tFU3gHklG60XcVv4xB9leOxir
 MQbvzvzfyKubvphbXMDvAVm+K7uOb3X9VNxoHalSL/MjxEHq8DN6w41+6
 D9PRC1+MT5WD3Jd7HI79eccOtgR+2D3TM7UVMil+bpZiiWlVZmJqaOZ6S g==;
X-CSE-ConnectionGUID: u8sqccE8TBmV2oR7TAQ6zQ==
X-CSE-MsgGUID: O2d6FIHEQCS8bcy8+IpWig==
X-IronPort-AV: E=McAfee;i="6800,10657,11712"; a="77033339"
X-IronPort-AV: E=Sophos;i="6.21,312,1763452800"; d="scan'208";a="77033339"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2026 03:58:06 -0800
X-CSE-ConnectionGUID: yxCK69UjTwOnqBXvhNBMVg==
X-CSE-MsgGUID: nYnQ79KcRTypEIPF6/271A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,312,1763452800"; d="scan'208";a="244135124"
Received: from fenlix-mobl.ccr.corp.intel.com ([10.239.252.5])
 by fmviesa001.fm.intel.com with ESMTP; 26 Feb 2026 03:58:04 -0800
From: Soumyadeep Hore <soumyadeep.hore@intel.com>
To: dev@dpdk.org, bruce.richardson@intel.com, rajesh3.kumar@intel.com,
 aman.deep.singh@intel.com, manoj.kumar.subbarao@intel.com
Subject: [PATCH v7 0/4] Enable PTP feature for MEV
Date: Thu, 26 Feb 2026 19:33:10 -0500
Message-ID: <20260227003314.439267-1-soumyadeep.hore@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260214194920.139066-5-soumyadeep.hore@intel.com>
References: <20260214194920.139066-5-soumyadeep.hore@intel.com>
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
v7:
- Addressed Rajesh's comments
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

