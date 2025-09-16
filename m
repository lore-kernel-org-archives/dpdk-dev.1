Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 027D4CAC599
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Sep 2025 14:21:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DE75C402E5;
	Tue, 16 Sep 2025 16:21:19 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 3AB30402D1
 for <dev@dpdk.org>; Tue, 16 Sep 2025 16:21:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758032478; x=1789568478;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=NaN3I6ejs5AEuTJBwNKdmn6mXNQjMh2PORZXI6j/Gvk=;
 b=GtEWDgMTlJPgMrH5AT06bRqGIrxR3HGVMqEnfWe4CPh4HcYGq8RVzqtl
 fULX/JZmJu3zzdS5dXkaM7oPnVy3bvH9KbikSLsf916lF4yrFkIzc8ueO
 5tHqQ77WhRdL/RELIKzTjPXNcVsRAPw5Y6gx0kZ1BrTmKHSWMAiwlYAsy
 9qig9C+H821Ove1gXYDtXdQLo/wVZWZ4yOdKFzlg0REQIXs4wHTkFAIQw
 lNC4N0HnVlwFrSI9lNdGmz5jeyLskoKmbaNrVFM8NkaZCHAaalha9q+Fr
 33CdNvuKYLbl4cNR2jNlrM/vJQ0CO7NJCukq07JAYirznrYCQzCDJkWfI w==;
X-CSE-ConnectionGUID: dLVcSBOmSD6QSyv2kCFA/Q==
X-CSE-MsgGUID: 8j5+lwswQT+oXpCABY3V9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11555"; a="71681327"
X-IronPort-AV: E=Sophos;i="6.18,269,1751266800"; d="scan'208";a="71681327"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2025 07:21:16 -0700
X-CSE-ConnectionGUID: HPNoeaKyS4S/eBDQh20buA==
X-CSE-MsgGUID: 8t2I4/3tSVaZYy5D2/Zjhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,269,1751266800"; d="scan'208";a="212115189"
Received: from silpixa00401177.ir.intel.com ([10.237.213.77])
 by orviesa001.jf.intel.com with ESMTP; 16 Sep 2025 07:21:16 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH 0/8] Fixes for ice and iavf docs
Date: Tue, 16 Sep 2025 14:21:05 +0000
Message-Id: <20250916142113.3485738-1-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.34.1
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

This series is a collection of fixes to the documentation (specifically
the ini files) for the ice and iavf drivers.

Ciara Loftus (8):
  net/ice: document support for free Tx mbuf on demand
  net/ice: fix documentation of support for TSO
  net/iavf: fix documentation for speed capabilities
  net/iavf: document support for fast mbuf free
  net/iavf: document support for free Tx mbuf on demand
  net/iavf: document support for burst mode info
  net/iavf: fix documentation of support for TSO
  net/iavf: document support for extended statistics

 doc/guides/nics/features/iavf.ini | 7 +++++--
 doc/guides/nics/features/ice.ini  | 3 ++-
 2 files changed, 7 insertions(+), 3 deletions(-)

-- 
2.34.1

