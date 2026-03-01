Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E204EFEE4F8
	for <dpdk-dev@archiver.kernel.org>; Sat, 28 Feb 2026 20:34:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 07DFC402C5;
	Sat, 28 Feb 2026 21:34:47 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id 1E89C4013F
 for <dev@dpdk.org>; Sat, 28 Feb 2026 21:34:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772310886; x=1803846886;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=x/v/iYof5TW0IDCYj3CepOz3E0aHDNzpeE/Tk2NhETk=;
 b=dwneTeYodnhLhfR6XyZ4pru+Sx9XgijhG6eTeI9mtH59GF//sQbZGAt3
 4I3EgTxSfwXRtei2K4SqMEockCcywUM6E91LhZa8ZoDT7BHtPhVB8fZ85
 IKay/lx2KxAgGubrB1dgnBTsItUQ1ggEYoVgopGT/xKWZFMHkdLAns7jS
 DkU/7FTLZSYp7irmXmcjTSSUbgIrhFEiAfySz4TzFOONOdx4biIvc/Eyj
 yF0tT1LyrlJHubUu4C5Dt6rkGdvshgODbV2WtQicaLPwyIc8wOLkMCT0K
 LQUKa1iOfzPvIDSjwQjBh9TbDjBfu4HoPs37rSTmzPyKxZTMvaUTnAvwi A==;
X-CSE-ConnectionGUID: 8UMZ801ZRvm5k/odnO5L8Q==
X-CSE-MsgGUID: rBI0lejwQymT36j1hoKYmQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11715"; a="84002130"
X-IronPort-AV: E=Sophos;i="6.21,316,1763452800"; d="scan'208";a="84002130"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Feb 2026 12:34:45 -0800
X-CSE-ConnectionGUID: QBhRW86KRKaCBX4z1n0Byw==
X-CSE-MsgGUID: PPzBbEb0QaK0U5GKbseUTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,316,1763452800"; d="scan'208";a="220401518"
Received: from fenlix-mobl.ccr.corp.intel.com ([10.239.252.5])
 by fmviesa004.fm.intel.com with ESMTP; 28 Feb 2026 12:34:43 -0800
From: Soumyadeep Hore <soumyadeep.hore@intel.com>
To: bruce.richardson@intel.com, manoj.kumar.subbarao@intel.com,
 aman.deep.singh@intel.com, dev@dpdk.org
Subject: [PATCH v8 0/4] Enable PTP feature for MEV
Date: Sun,  1 Mar 2026 04:10:36 -0500
Message-ID: <20260301091040.10647-1-soumyadeep.hore@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260227003314.439267-5-soumyadeep.hore@intel.com>
References: <20260227003314.439267-5-soumyadeep.hore@intel.com>
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
v8:
- Refactored code based on Bruce's commit 025b898
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
 drivers/net/intel/idpf/idpf_common_rxtx.c     | 126 ++---
 drivers/net/intel/idpf/idpf_common_rxtx.h     |   7 +
 drivers/net/intel/idpf/idpf_common_virtchnl.c |  31 +-
 drivers/net/intel/idpf/idpf_ethdev.c          | 270 ++++++++++
 drivers/net/intel/idpf/idpf_ptp.c             | 504 ++++++++++++++++++
 drivers/net/intel/idpf/idpf_ptp.h             | 130 +++++
 drivers/net/intel/idpf/meson.build            |   1 +
 13 files changed, 1252 insertions(+), 166 deletions(-)
 create mode 100644 drivers/net/intel/idpf/idpf_ptp.c
 create mode 100644 drivers/net/intel/idpf/idpf_ptp.h

-- 
2.47.1

