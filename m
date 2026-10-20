Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B7AC606A31A
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Oct 2026 12:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kicTxn84
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BC17540283;
	Tue, 20 Oct 2026 14:11:15 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id 1CB5E40144
 for <dev@dpdk.org>; Tue, 20 Oct 2026 14:11:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792498274; x=1824034274;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=b8LEjEyqzYu63YeTgTTih841X8F9e97XBKqTwxhiqvU=;
 b=kicTxn84BOWuwXfGiWJDEk7NFDuZDs6kpxEQji0yO84ESQKkDJBUCWg+
 O6cOp/+eWx/vvr/PLR5nbYLrdkns9MTUpo9IgQUhgNbaD7ib9kwZ1Olde
 ZWJFNPiwrsx0UT6Q3euiq6V2WHjBtjTh+NCP9QJmMukE6zVW+h5PcmZfk
 1LOkWNSZ5RxE6/+jr4Z8dDsN+L/dCDhRP+gPA6HCmy9H32CysRCcc01Qn
 Yw25caj7trEnNFVUYhBbJunOa2Fv8VqgWJA0HHIjDo2D0TWJtDfk8YGc+
 lKfbdYVgvQ0AZ1Wg3/bHY4f86TzdeS+eAv9jaUZGKDn8gx8OOc2t6DOzU w==;
X-CSE-ConnectionGUID: /Sfrc2MZSBiug1ePOzYBbA==
X-CSE-MsgGUID: S+OQ47GqRR25f8S95nZfVQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11940"; a="1101782"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1101782"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Oct 2026 05:11:13 -0700
X-CSE-ConnectionGUID: tNz+UqH4RjWyVqelBlBmbA==
X-CSE-MsgGUID: pLzi/FcISwe1f27Mn+KFzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="3253891"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa010.fm.intel.com with ESMTP; 20 Oct 2026 05:11:13 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v1 0/6] Centralize flow memory management in ICE
Date: Tue, 20 Oct 2026 13:11:03 +0100
Message-ID: <cover.1792498154.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
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
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This patchset rolls in a few fixes for flow engines, but the
main point is to rework the flow engines to have more defined
memory management.

Anatoly Burakov (6):
  net/ice: release ACL slot on entry creation failure
  net/ice: fix inconsistent state on FDIR failure
  net/ice: standardize VOID handling in flow parsers
  net/ice: remove temporary flow pattern buffer
  net/ice: use caller-owned pattern match storage
  net/ice: centralize flow rule memory management

 drivers/net/intel/ice/ice_acl_filter.c    |  91 +++++---------
 drivers/net/intel/ice/ice_ethdev.h        |   2 -
 drivers/net/intel/ice/ice_fdir_filter.c   | 124 ++++++++-----------
 drivers/net/intel/ice/ice_generic_flow.c  | 141 ++++++----------------
 drivers/net/intel/ice/ice_generic_flow.h  |  25 +++-
 drivers/net/intel/ice/ice_hash.c          |  87 ++++---------
 drivers/net/intel/ice/ice_switch_filter.c |  97 ++++-----------
 7 files changed, 185 insertions(+), 382 deletions(-)

-- 
2.52.0

