Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83BB2C87FDA
	for <dpdk-dev@archiver.kernel.org>; Fri,  8 Aug 2025 21:08:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4C50C402ED;
	Fri,  8 Aug 2025 23:08:45 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id 2806C40270
 for <dev@dpdk.org>; Fri,  8 Aug 2025 23:08:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1754687325; x=1786223325;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=tEpeSjK9ncQODdF8Re+iev1IXHrV0ZvnlsTYoosWfx8=;
 b=anbfhG45LCblUDQFKOi9pqxAekdFO3Ge7xe23i2hMMcobPX0vmW80pEL
 a/JrCJsVQCT9kQYI+RKuk78H9UpTn0B898fX7LUQ9QqXbkXoU9GLVsDm3
 gttfIcQ3Y7O77exan2PbeUm/BNPbjeIdBbmsLCSbwcMFGjot68U0J6TA8
 NpPmVX4Y/vSDURMqurWwCUayOvktu38g0RX1E8Y8kHQe2TOTTAFV1fbNP
 l/N0Im+bfGxA2EOk3xHg4oxM/bXSSip2a41RtocMR6zFKqoRgP1Nz/WUP
 JI9yrmJ0AuKIyUeVwPLxunObLPnCchjgWFBpZhoHcXVoU96G5drYHawJF Q==;
X-CSE-ConnectionGUID: tABdPYI5TWeiPe5sfwuSAg==
X-CSE-MsgGUID: omd4OFv5SMGMJeB1jnt6qA==
X-IronPort-AV: E=McAfee;i="6800,10657,11515"; a="60887212"
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; d="scan'208";a="60887212"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Aug 2025 14:08:43 -0700
X-CSE-ConnectionGUID: wkvKVP9cSCKpYQd6dyLW8w==
X-CSE-MsgGUID: iGzJWs7JSeShA25kCQMzEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; d="scan'208";a="165416738"
Received: from silpixa00401385.ir.intel.com ([10.237.214.33])
 by orviesa007.jf.intel.com with ESMTP; 08 Aug 2025 14:08:42 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: marat.khalili@huawei.com,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2 0/2] Improve mailmap file
Date: Fri,  8 Aug 2025 22:08:32 +0100
Message-ID: <20250808210837.518507-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250808142721.408998-1-bruce.richardson@intel.com>
References: <20250808142721.408998-1-bruce.richardson@intel.com>
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

The mailmap file in DPDK is not always correctly sorted, and standard
cmdline sorting tools don't always do the job correctly. To improve
things, add a new script to devtools for working with the mailmap file,
to make it easier to add new entries in the correct place, to check the
file for correctness, and lastly to sort the file in place (hopefully a
one-off operation).

Once that is done, commit the changes to the mailmap file to ensure it
is correctly sorted in the repository.

V2:
* address multiple feedback items on V1.
* fix bug whereby adding an extra actually sorted the whole file

Bruce Richardson (2):
  devtools/mailmap_ctl: script to work with mailmap
  mailmap: sort mailmap

 .mailmap                | 354 ++++++++++++++++++++--------------------
 devtools/mailmap_ctl.py | 212 ++++++++++++++++++++++++
 2 files changed, 389 insertions(+), 177 deletions(-)
 create mode 100755 devtools/mailmap_ctl.py

--
2.48.1

