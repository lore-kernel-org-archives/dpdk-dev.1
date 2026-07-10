Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01F21C43458
	for <dpdk-dev@archiver.kernel.org>; Fri, 10 Jul 2026 10:34:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B07974026A;
	Fri, 10 Jul 2026 12:34:10 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id 20E7B400D5
 for <dev@dpdk.org>; Fri, 10 Jul 2026 12:34:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783679649; x=1815215649;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=3XintohId2J2/CnNOKRYmFgOdoTbJ8V5R1Cqr7bIh+I=;
 b=Yotr6z6t1uum2Cg+ZtVkMGkQTpQgGWGFnh5zBWfXwABeMed/LfgCTTge
 fvh7jDmsGI0PkG61LZSdFOZ7Hq69YNbDIykmvPbyaOo1C0gOiMzwIYoqL
 6rT0GeEpzTNZGVyVH+JGwNn4QjGNH4odY7x4p8eqaLhq0dOGjSTvJum+A
 1XsEYbO93RkvXAgMBhh3lhgBHfZaSH36lsk2l+wzMyaWIqMHYLYqzjVw4
 4Svb7dh84b5UBeRBkf9xzot8UseDesknYlu+m7Dkio4BfxNR8CBCs16dE
 9Ri+/bF6Xie/jaKy6839rpRrjg1ta5n1yEUKI2cFgrnHX+DzEfAUNA7MX Q==;
X-CSE-ConnectionGUID: 0Ua1l30oSYeYB1mp9w5zkQ==
X-CSE-MsgGUID: 2x6XAKlKSeKx83XvYm+Oog==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84428979"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="84428979"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jul 2026 03:34:08 -0700
X-CSE-ConnectionGUID: GPCTceUCTfOlvPnVgTRT3w==
X-CSE-MsgGUID: OguBAG2iSgqdNxX8NGOuhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="259163162"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa005.jf.intel.com with ESMTP; 10 Jul 2026 03:34:07 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: ciara.loftus@intel.com,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v3 0/6] net/intel: fix some small memory leaks
Date: Fri, 10 Jul 2026 11:33:57 +0100
Message-ID: <20260710103403.1548864-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260703083335.4058936-1-bruce.richardson@intel.com>
References: <20260703083335.4058936-1-bruce.richardson@intel.com>
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

AI review of a patch to traffic management code identified a couple of
small memory leaks in that function. When fixing those, I then asked AI
to identify other similar leaks other Intel drivers, leading to this
patchset.

V3: update based on feedback on v2:
    - fix log message on patch 3,
    - add additional free on close in patch 5
V2: expand from 2 patches to 6 to cover some more leaks

Bruce Richardson (6):
  net/iavf: fix local memory leaks in TM hierarchy commit
  net/iavf: fix leak of queue to traffic class mapping data
  net/iavf: fix memory leak on error when adding flow parser
  net/ice: fix buffer leak in config of Tx queue TM node
  net/iavf: fix leak of flex metadata extraction field
  net/iavf: fix leak of IPsec crypto capabilities array

 drivers/net/intel/iavf/iavf_ethdev.c       |  7 +++++
 drivers/net/intel/iavf/iavf_generic_flow.c |  1 +
 drivers/net/intel/iavf/iavf_ipsec_crypto.c |  2 ++
 drivers/net/intel/iavf/iavf_tm.c           | 31 +++++++++++++++-------
 drivers/net/intel/ice/ice_tm.c             |  6 +++--
 5 files changed, 36 insertions(+), 11 deletions(-)

--
2.53.0

