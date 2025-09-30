Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52C39CCA470
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Sep 2025 11:21:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5F95D400EF;
	Tue, 30 Sep 2025 13:21:23 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id 79658400D7
 for <dev@dpdk.org>; Tue, 30 Sep 2025 13:21:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759231281; x=1790767281;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=bhovvrYLdnMaeNo1jxyYgCaL5jLnFgQ86kat0NnDP7g=;
 b=a05JL/tz54qy8T1JO9s3BYIB+g+SIYJiYd43PQODzc8pCOlmmWTI0wAZ
 V4urqmx8c66gaiv1l+rwM/ymJHwPrEsO366lM59V6+6nKlu/L6xBfcBr+
 pGhqSOXOex6ITgPR5YgzHmIzF53g1nZ7dkLVO4HhOchbcIQwe+6GTpGs9
 vDKDho8eOyDeH0n6U+kUIg2+YDxsKG2ghaTFGhgb8l+0TwMclnF17HZl+
 PCLTKhkfMZp3tH9i14JFLK+AlAADe7hLxJlnMem8jJ8ag9TxLJnNzfi3Y
 6plZ5JXd5r73MTQTgBQv/TQTdQbOe2xe8H8b1+2zVgBHC7hb3tKD9fx4I A==;
X-CSE-ConnectionGUID: B6EhchPBSW6yDj08Sfi3/Q==
X-CSE-MsgGUID: cBDj/BcESR6g0CCBJj38bA==
X-IronPort-AV: E=McAfee;i="6800,10657,11568"; a="86927959"
X-IronPort-AV: E=Sophos;i="6.18,304,1751266800"; d="scan'208";a="86927959"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Sep 2025 04:21:20 -0700
X-CSE-ConnectionGUID: VmLaNTU9RriqtIo0yyPkdw==
X-CSE-MsgGUID: 3QTsGUPlRaq2zJdJYnzUPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,304,1751266800"; d="scan'208";a="179265235"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa010.fm.intel.com with ESMTP; 30 Sep 2025 04:21:19 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com,
	vladimir.medvedkin@intel.com
Subject: [PATCH v1 0/4] Update ICE base driver
Date: Tue, 30 Sep 2025 12:21:13 +0100
Message-ID: <cover.1759231103.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
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

[1] https://patches.dpdk.org/project/dpdk/cover/20250817130152.682972-1-vladimir.medvedkin@intel.com/

Chinh Cao (1):
  net/ice/base: fix integer overflow on NVM init

Vladimir Medvedkin (3):
  net/ice/base: add utility functions
  net/ice/base: make set MAC config TC aware
  net/ice/base: add support for asymmetric PFC

 drivers/net/intel/ice/base/ice_common.c | 220 ++++++++++++++++++++----
 drivers/net/intel/ice/base/ice_common.h |  11 ++
 drivers/net/intel/ice/base/ice_dcb.c    | 105 +++++++++--
 drivers/net/intel/ice/base/ice_dcb.h    |  16 +-
 drivers/net/intel/ice/base/ice_type.h   |  17 +-
 5 files changed, 316 insertions(+), 53 deletions(-)

--
2.47.3

