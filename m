Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64D2E606A31A
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 Oct 2026 16:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=P/MLq6RM
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8B54E4027D;
	Thu, 22 Oct 2026 18:52:11 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 964B94003C
 for <dev@dpdk.org>; Thu, 22 Oct 2026 18:52:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792687931; x=1824223931;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=kAVhaF4DIDmAn53TA7muGGAku6iPB2AnOL/JoZh6zZw=;
 b=P/MLq6RMUaJxVZwtcCTwk4RC7mqRuDb3x6gi8z2zqgjgIKRUMn5Puzyd
 l0M54a+gEoFvOMYFdls3Kmfyqs2IPnl4TzuzKkm8GkwqNt0MkjgbGpbaO
 WdcYqlL2RhxRVRRS199dSmVTo1IqqNMEnzTcB25LtFSam3XdWM5/YSPgF
 bxR6A6ZP3e/aaN0v+X/q6ZGqp9UmZuQpMbwQcLHsFB5TbvsbxFXuHjaZj
 bociqDDx2nagEhNdXk7gZskhi3ytwskbgAwAtTjOwNDcNRBZDbpDWB0h/
 GWipSHQqoiYIzjTX3oeHFEL1gFnADCNdxgc1c8eHOR1zzPIKd2gZvqG/U w==;
X-CSE-ConnectionGUID: sBJRMkzITbubeLsZVaikuA==
X-CSE-MsgGUID: 0oXPYIPUQGmCwEsq2gjHFg==
X-IronPort-AV: E=McAfee;i="6800,10657,11942"; a="1341022"
X-IronPort-AV: E=Sophos;i="6.27,172,1787036400"; 
   d="scan'208";a="1341022"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Oct 2026 09:52:10 -0700
X-CSE-ConnectionGUID: 6i8fyj1MSiiZIcFgUzPE4g==
X-CSE-MsgGUID: 1O0iILkHR2m2DXGb7fPHZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,172,1787036400"; 
   d="scan'208";a="3507799"
Received: from silpixa00401176.ir.intel.com ([10.20.224.212])
 by fmviesa003.fm.intel.com with ESMTP; 22 Oct 2026 09:52:09 -0700
From: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com,
	anatoly.burakov@intel.com
Subject: [PATCH 0/9] Update ICE base driver
Date: Thu, 22 Oct 2026 16:51:56 +0000
Message-ID: <20261022165205.1830735-1-vladimir.medvedkin@intel.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Update the ICE base driver to the latest shared code snapshot:

- Bounds check, integer overflow and type fixes
- New capability and NVM definitions
- New E835 10GBASE-T device ID

Chinh Cao (2):
  net/ice/base: add NVM definitions for Wake-on-LAN config
  net/ice/base: add E835 10GBASE-T device ID

Deepthi Kavalur (1):
  net/ice/base: fix loop counter type in recipe creation

Janardhanan Arumugam (1):
  net/ice/base: fix out-of-bounds accesses in DDP and NVM code

Krzysztof Galazka (1):
  net/ice/base: fix integer overflow in RL profile calculation

Przemyslaw Gierszynski (1):
  net/ice/base: add RDE WoL override capability bit

Stefan Wegrzyn (2):
  net/ice/base: add PQC certificate provisioning capability
  net/ice/base: add NVM write flags for eRoT minSREV update

Vladimir Medvedkin (1):
  net/ice/base: update version info

 drivers/net/intel/ice/base/README           |  2 +-
 drivers/net/intel/ice/base/ice_adminq_cmd.h |  6 ++++++
 drivers/net/intel/ice/base/ice_common.c     |  6 ++++++
 drivers/net/intel/ice/base/ice_ddp.c        | 19 ++++++++++++-------
 drivers/net/intel/ice/base/ice_devids.h     | 14 ++++++++------
 drivers/net/intel/ice/base/ice_nvm.c        |  4 ++--
 drivers/net/intel/ice/base/ice_sched.c      | 18 ++++++++----------
 drivers/net/intel/ice/base/ice_switch.c     |  2 +-
 drivers/net/intel/ice/base/ice_type.h       | 16 +++++++++++++++-
 drivers/net/intel/ice/ice_ethdev.c          |  1 +
 10 files changed, 60 insertions(+), 28 deletions(-)

-- 
2.43.0

