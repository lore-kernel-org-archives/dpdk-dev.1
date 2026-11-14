Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58EF606A883
	for <dpdk-dev@archiver.kernel.org>; Sat, 14 Nov 2026 00:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=j0p6ACmt
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 77EB0402A4;
	Sat, 14 Nov 2026 01:55:43 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTPS id E70654025F
 for <dev@dpdk.org>; Sat, 14 Nov 2026 01:55:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794617742; x=1826153742;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=/DamSRV7cj/1kZgfX7yTVYxb6UdHn7eMYDWrMiVLReE=;
 b=j0p6ACmt5bxrRoP5/1BC509MnvoDc87rCkAU5tiuC+ZHf9Zf02LNq/+M
 ERbR1BMgX9sWXMFNQrEJluljSOzHjQBOEmjRNhMcR4F1gvXKuPLePpxCY
 +rzlVbY1BIfCdM/TOXRraR3+KPZxiHG1/hNUJXSrUN0XUPQ5R5BmNkfP8
 UnWQpME2gUao4xV37JrKGRwKrnwRTXh40+yIu3vlLU2gOPWHynnt+GSq1
 Z64W4SigIZerLMbXUyqR8tUW7qYrc5YRHZz1ywUjv8Jk4ez5wqErGUkFc
 XUPXbAhQ/u5EszLbIAFRoTewit9Zqh9HTx2+bZfnhfbpNqNoN2/JNRoJj g==;
X-CSE-ConnectionGUID: Ev5FHrnhQ4mhc+N7/4suLg==
X-CSE-MsgGUID: +t7Is8uVR6uUgELHD6e6GA==
X-IronPort-AV: E=McAfee;i="6800,10657,11965"; a="3471588"
X-IronPort-AV: E=Sophos;i="6.27,212,1787036400"; 
   d="scan'208";a="3471588"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Nov 2026 16:55:40 -0800
X-CSE-ConnectionGUID: 2TMPju3sS8SFRACaFiB03A==
X-CSE-MsgGUID: ElxwIiG3T7GMSqmxtVxICQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,212,1787036400"; 
   d="scan'208";a="9315570"
Received: from pae-31.iind.intel.com ([10.49.105.68])
 by fmviesa008.fm.intel.com with ESMTP; 13 Nov 2026 16:55:39 -0800
From: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, anatoly.burakov@intel.com,
 vladimir.medvedkin@intel.com, brian.johnson@intel.com,
 Sandeep Penigalapati <sandeep.penigalapati@intel.com>
Subject: [PATCH v2 0/4] doc: fix Intel NIC driver guides
Date: Sat, 14 Nov 2026 07:57:28 +0000
Message-Id: <20261114075732.183996-1-sandeep.penigalapati@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261113205034.173313-1-sandeep.penigalapati@intel.com>
References: <20261113205034.173313-1-sandeep.penigalapati@intel.com>
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

v2:
- add the full set of Fixes: tags to each patch.
- i40e: fix remaining grammar in the queue region flush description.
- intel VF: remove a stray double space before "Qemu".


Sandeep Penigalapati (4):
  doc: fix ice guide
  doc: fix i40e guide
  doc: fix ixgbe guide
  doc: fix intel VF guide

 doc/guides/nics/i40e.rst     | 20 ++++++++++----------
 doc/guides/nics/ice.rst      | 26 +++++++++++++++-----------
 doc/guides/nics/intel_vf.rst | 18 +++++++++---------
 doc/guides/nics/ixgbe.rst    | 24 +++++++++++++-----------
 4 files changed, 47 insertions(+), 41 deletions(-)

-- 
2.34.1

