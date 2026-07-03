Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3183C43602
	for <dpdk-dev@archiver.kernel.org>; Fri,  3 Jul 2026 13:19:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 116EB40647;
	Fri,  3 Jul 2026 15:19:49 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id 309AF4003C
 for <dev@dpdk.org>; Fri,  3 Jul 2026 15:19:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783084787; x=1814620787;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=TQp1Q66/nZ9IImaBm4xa2k+UwrCWcCR/ClitYBRtOTE=;
 b=NoirSJv7QmuXnG0W9NqMbwugvoRJFwpLruj/32s/fKucDUc8y3kb8YhA
 7ACv9HvLVDlTxES8ekp7UCeRHbsLifnP9wV3Rc8RCJd3xD4WzNbsTWCzh
 gCJN98QVb2JJitEgx4BPV0v7bg8We81ThwbF3MNJHAR8sUajNPyxsoisx
 u+bfEmqhh+PW1w3J+8blmzgyyOeIVSyHLtN3ibY8qyke8VEFBKouwZg2i
 RmsZnoadlDxRNSUH9GZ5Hu8fASZLwWSAziO2NMsIjv/9Z8OCL6e0vJiRS
 jC21/mGQHjMN4ICu7S8gyw+p7FKPfdWzVmnCciEgLoyhh+Omn6xKWKTj5 A==;
X-CSE-ConnectionGUID: KOfI+ruWSoqtOzMxzgGu9Q==
X-CSE-MsgGUID: +O+8OGZYQ4uMTzOgaXdCNQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11835"; a="94486669"
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; d="scan'208";a="94486669"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2026 06:19:46 -0700
X-CSE-ConnectionGUID: 7Wydu4iMRHmwa3vAmIYMcw==
X-CSE-MsgGUID: shG0RXgwRIqddiU+2ASl5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; d="scan'208";a="257439832"
Received: from silpixa00401385.ir.intel.com (HELO
 localhost.ger.corp.intel.com) ([10.20.224.226])
 by orviesa005.jf.intel.com with ESMTP; 03 Jul 2026 06:19:45 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2 0/6] Fix some small memory leaks
Date: Fri,  3 Jul 2026 14:19:14 +0100
Message-ID: <20260703131921.4102325-1-bruce.richardson@intel.com>
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

V2: expand from 2 patches to 6 to cover some more leaks

Bruce Richardson (6):
  net/iavf: fix local memory leaks in TM hierarchy commit
  net/iavf: fix leak of queue to traffic class mapping data
  net/iavf: fix memory leak on error when adding flow parser
  net/ice: fix buffer leak in config of Tx queue TM node
  net/iavf: fix leak of flex metadata extraction field
  net/iavf: fix leak of IPsec crypto capabilities array

 drivers/net/intel/iavf/iavf_ethdev.c       |  4 +++
 drivers/net/intel/iavf/iavf_generic_flow.c |  1 +
 drivers/net/intel/iavf/iavf_ipsec_crypto.c |  2 ++
 drivers/net/intel/iavf/iavf_tm.c           | 31 +++++++++++++++-------
 drivers/net/intel/ice/ice_tm.c             |  6 +++--
 5 files changed, 33 insertions(+), 11 deletions(-)

--
2.53.0

