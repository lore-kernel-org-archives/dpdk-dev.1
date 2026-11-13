Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75A8606A898
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Nov 2026 13:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=UmOb/ZFm
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C55B74028E;
	Fri, 13 Nov 2026 14:48:33 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTPS id 6F26540268
 for <dev@dpdk.org>; Fri, 13 Nov 2026 14:48:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794577713; x=1826113713;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=ns4O71frgz4Zd7FZAnj33yAKixlFwtodIHHo2cMwrCg=;
 b=UmOb/ZFmbkTEhl0npOXqOWykH26djsxA0yKc66EAEx34gbnr6rdu0/m9
 3d6rWnbjo5HPUYk2HwlWjaC5o0663eGPEjF//suhi2cHGBHR92ovt/bhu
 D2EwndaiJa2b0hu61SHAcaJBevsbEmH2LLwpqjRaUR6l4nqEbe8SyYyN1
 u/tJUf9vt94Ca0KrBlgIAqPSu8ah6tsNdcdvmKX5VdNp+2P21lZV7LRWO
 qreIUGWc3dr7T/V806aLV9NtMQ0K9Ke/IxiQ9gyOe6JME/kOpzVHBUBT4
 gFJPyf4PKh4LBt/yVUT0d0XaGzUZeCC4OvL6wUbXKG2pg1/WdO3/9HYXE g==;
X-CSE-ConnectionGUID: Vibrx5NpSK2TvAPl9T4YmA==
X-CSE-MsgGUID: qlI0/A4QRJijKsDaLQLanQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11965"; a="3375493"
X-IronPort-AV: E=Sophos;i="6.27,211,1787036400"; 
   d="scan'208";a="3375493"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Nov 2026 05:48:30 -0800
X-CSE-ConnectionGUID: 3hPghR0mRQCn/xOZUe8TBw==
X-CSE-MsgGUID: Zhb1lDXcSfWoPJ67eM6KPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,211,1787036400"; 
   d="scan'208";a="8819730"
Received: from pae-31.iind.intel.com ([10.49.105.68])
 by orviesa004.jf.intel.com with ESMTP; 13 Nov 2026 05:48:28 -0800
From: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, anatoly.burakov@intel.com,
 vladimir.medvedkin@intel.com, brian.johnson@intel.com,
 Sandeep Penigalapati <sandeep.penigalapati@intel.com>
Subject: [PATCH 0/4] doc: fix Intel NIC driver guides
Date: Fri, 13 Nov 2026 20:50:30 +0000
Message-Id: <20261113205034.173313-1-sandeep.penigalapati@intel.com>
X-Mailer: git-send-email 2.34.1
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
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	DATE_IN_FUTURE_06_12,DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series corrects a number of documentation errors found while
reviewing the Intel NIC driver guides: wrong feature and attribute
names, stale macro names, broken or incomplete command examples, a
missing "set bypass event" option, and assorted grammar and spacing
issues.

Each patch is self-contained and touches only its own driver guide.


Sandeep Penigalapati (4):
  doc: fix ice guide
  doc: fix i40e guide
  doc: fix ixgbe guide
  doc: fix intel VF guide

 doc/guides/nics/i40e.rst     | 16 ++++++++--------
 doc/guides/nics/ice.rst      | 26 +++++++++++++++-----------
 doc/guides/nics/intel_vf.rst | 16 ++++++++--------
 doc/guides/nics/ixgbe.rst    | 24 +++++++++++++-----------
 4 files changed, 44 insertions(+), 38 deletions(-)

-- 
2.34.1

