Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0494FCE087
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Feb 2026 13:59:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 82DB940608;
	Thu, 26 Feb 2026 14:59:52 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id 7167A4021F
 for <dev@dpdk.org>; Thu, 26 Feb 2026 14:59:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772114392; x=1803650392;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=CsrXJyYiBNFK6LQGlu1AZSLlW7cNcrAtTHhs1C1BIWo=;
 b=akYMiIySoOkzupJV+EkuHj9SwRNOVJehE/Dd9SkhJkUpN9P5eLcCZTaz
 q6f5AYksfJvjjNttxRrsfe0PN2+UUtXO3pL7zQHFtok40QOyOJ6ZIfUGL
 ojO+mFIfN2YzXJ12bBm151jsRdfp4VHwUNMjSqftNfIBmUh6yqxbFawW5
 aidZJe6+20brduIkbt5uVP3BKT+83aYKbfb8ADxO2Q4OGUBB/pi/JA9AP
 UXLWYOcc5/sQp29bin3ezkEYbnA3s9MCyDUKsA9sI7YG6G6D4inc+Z23/
 lBuBlU87E9gnkKKAZmBAuKCtMAPhtJVNDn7BQl9VOO2u2WR4pqo391hfH g==;
X-CSE-ConnectionGUID: CXXBUtCoT/u8LdVfB2mPtA==
X-CSE-MsgGUID: eRtiCzeuSXaUuEzyU9aG3g==
X-IronPort-AV: E=McAfee;i="6800,10657,11713"; a="73219058"
X-IronPort-AV: E=Sophos;i="6.21,312,1763452800"; d="scan'208";a="73219058"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2026 05:59:51 -0800
X-CSE-ConnectionGUID: F4Nx2zOVRP6WKibbymNZHA==
X-CSE-MsgGUID: fGuLlEThQYiqW9WECvJbVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,312,1763452800"; d="scan'208";a="216588097"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa008.jf.intel.com with ESMTP; 26 Feb 2026 05:59:50 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v2 0/2] Deprecation notices for VFIO
Date: Thu, 26 Feb 2026 13:59:46 +0000
Message-ID: <cover.1772114309.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1763548356.git.anatoly.burakov@intel.com>
References: <cover.1763548356.git.anatoly.burakov@intel.com>
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

There's ongoing work to rework VFIO in DPDK [1]. These deprecation
notices originally were part of that patchset, but were split off
to easy review and acceptance.

v2:
- Rebase

[1] https://patches.dpdk.org/project/dpdk/list/?series=36765

Anatoly Burakov (2):
  doc: add deprecation notice for VFIO API
  doc: add deprecation notice for vDPA driver API

 doc/guides/rel_notes/deprecation.rst | 7 +++++++
 1 file changed, 7 insertions(+)

-- 
2.47.3

