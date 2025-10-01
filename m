Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39DCFCCA470
	for <dpdk-dev@archiver.kernel.org>; Wed,  1 Oct 2025 12:29:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2223740B94;
	Wed,  1 Oct 2025 14:29:16 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id 246F2406A2
 for <dev@dpdk.org>; Wed,  1 Oct 2025 14:29:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759321754; x=1790857754;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=7uJqb2rryfFT03ByhvVZBHOn5DJ1ASvrbUNvgeyxVmg=;
 b=IifZ4+WmUvRMRZDo5XMQVq1y/VppfmJ4MC4+PyMUjAdHmX7H64EDVsN4
 aObyJgqPW7YU7h35Ks6/4eY+wTWWlL47NZwQjlOja6v0JG2uRq8rOmW2n
 A8S5gLMr/MeqInV+sSex1Y3f+kKRjNzJNN4SL5bwESGGJwKvc9l9NuzoW
 uFYVxlixrA3RxdLK01Pa+B8bdXyJLAjQWh4OQv0mc1CizCTzX4Yu9Xg/c
 g7pG4ENojXgp7xx+viXxXALzOv/7K+BQW9rz1yOBz79FVYAWfTDJNb/N9
 +T/4L1SBQxv55zgJj/CwFwE5xFd9ISb5b6XHr14lB0nk0KMjXrx1cQpkT Q==;
X-CSE-ConnectionGUID: JK9hYo6VRBCseuyOiPNUMw==
X-CSE-MsgGUID: bYG4ugMoQ5alTiTPz9ciKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11569"; a="60807862"
X-IronPort-AV: E=Sophos;i="6.18,306,1751266800"; d="scan'208";a="60807862"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Oct 2025 05:29:13 -0700
X-CSE-ConnectionGUID: PJQqoS5iQrio6b9JLdVPWw==
X-CSE-MsgGUID: 23ly8KQ6TXOVfLSbtaB6Tw==
X-ExtLoop1: 1
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa003.fm.intel.com with ESMTP; 01 Oct 2025 05:29:12 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com,
	vladimir.medvedkin@intel.com
Subject: [PATCH v2 0/5] Update ICE base driver
Date: Wed,  1 Oct 2025 13:29:03 +0100
Message-ID: <cover.1759321681.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1759231103.git.anatoly.burakov@intel.com>
References: <cover.1759231103.git.anatoly.burakov@intel.com>
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

A few more changes for the ICE base driver:

- Integer overflow fix
- DCB/PFC changes that were submitted earlier by Vladimir [1]

The intent is to merge these as base driver changes, with
successive work to be built on top.

v2:
- Fix setting MAC config when no TC's were specified

[1] https://patches.dpdk.org/project/dpdk/cover/20250817130152.682972-1-vladimir.medvedkin@intel.com/

Anatoly Burakov (1):
  net/ice/base: update README

Chinh Cao (1):
  net/ice/base: fix integer overflow on NVM init

Vladimir Medvedkin (3):
  net/ice/base: add utility functions
  net/ice/base: make set MAC config TC aware
  net/ice/base: add support for asymmetric PFC

 drivers/net/intel/ice/base/README       |   2 +-
 drivers/net/intel/ice/base/ice_common.c | 221 ++++++++++++++++++++----
 drivers/net/intel/ice/base/ice_common.h |  11 ++
 drivers/net/intel/ice/base/ice_dcb.c    | 105 +++++++++--
 drivers/net/intel/ice/base/ice_dcb.h    |  16 +-
 drivers/net/intel/ice/base/ice_type.h   |  17 +-
 6 files changed, 318 insertions(+), 54 deletions(-)

-- 
2.47.3

