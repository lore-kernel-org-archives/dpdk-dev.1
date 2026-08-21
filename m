Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE02FC5DF7D
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Aug 2026 09:15:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 71AAB40292;
	Fri, 21 Aug 2026 11:15:37 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id 2D36E4027B
 for <dev@dpdk.org>; Fri, 21 Aug 2026 11:15:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787303737; x=1818839737;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=yC2EdQvmW+Mlun3IW4ZtBLMYYqju4RgKvWxyaTgV4fM=;
 b=fTY2frNu5cGed6dPM8w3ABx99hgDwz/+l8jljRBW/+ZOeyaDYNrS+l/L
 t7n1mmOeEw+NsuvqBlQpOXlh3lkKCJSVaTzxr+n5NrWipfmWPeYLg4SAX
 z39XcCMrnzU/51cmVp3+xjW+GY3iTcm+SsMMfCNSOAs6/asx2xFuqZfju
 jZS5kkaTPgBAJuO+QF4NxHVPGA6wLTYJwC9zLtjVvOi9ZDU4oxUE6jsbJ
 rWLnRl/qUXkW82FGLeX9wF2oQRY75jrddloz6OT1VX5KmhMBV8sYd6Bee
 OB7bi2JUqdNfslK37FeKf7K4I7cQxUxHZG5SZpmxht98qKgykg+zvq6/O g==;
X-CSE-ConnectionGUID: ank6pVWbRP6OpzIUF64krA==
X-CSE-MsgGUID: GbJrejUQQTSCOtF0t/McdA==
X-IronPort-AV: E=McAfee;i="6800,10657,11881"; a="87979119"
X-IronPort-AV: E=Sophos;i="6.25,234,1779174000"; d="scan'208";a="87979119"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Aug 2026 02:15:35 -0700
X-CSE-ConnectionGUID: 3ZlJsWuDQvW6+8EfaTU1GQ==
X-CSE-MsgGUID: lh8zx/zhT5eohDymfSBDCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,234,1779174000"; d="scan'208";a="269763850"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa003.jf.intel.com with ESMTP; 21 Aug 2026 02:15:34 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v2 0/2] I40E refactors
Date: Fri, 21 Aug 2026 10:15:29 +0100
Message-ID: <cover.1787303683.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1787149329.git.anatoly.burakov@intel.com>
References: <cover.1787149329.git.anatoly.burakov@intel.com>
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

A small amount of refactor in hash engine to prepare for future
code. Specifically, disentangling the mutable filter list metadata
from immutable RSS configuration supplied from rte_flow API, and
getting rid of embedded rte_flow RSS conf struct and replacing it
with direct values embedded in config struct.

v1 -> v2:
- Fix patch 1 returning non-NULL pointers to queue/key when lengths
  of either are 0

Anatoly Burakov (2):
  net/i40e: do not use flow RSS conf struct
  net/i40e: move mutable fields out of RSS config

 drivers/net/intel/i40e/i40e_ethdev.h |  18 +++-
 drivers/net/intel/i40e/i40e_flow.c   |  13 ++-
 drivers/net/intel/i40e/i40e_hash.c   | 125 +++++++++++++--------------
 drivers/net/intel/i40e/i40e_hash.h   |   1 -
 4 files changed, 83 insertions(+), 74 deletions(-)

-- 
2.52.0

