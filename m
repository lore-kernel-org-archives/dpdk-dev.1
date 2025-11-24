Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95F17CFD31C
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Nov 2025 09:32:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 930EA402F0;
	Mon, 24 Nov 2025 10:32:50 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id 81EF4400D7
 for <dev@dpdk.org>; Mon, 24 Nov 2025 10:32:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763976768; x=1795512768;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=8tF/BFdOcByS/WwkKk4BAHBuxQEhNYZDVFB4/yUAtA0=;
 b=O5VEssjkbuOp/LBbhHiKZn634GbyfwbTq0zCIAGm0XhX90sIwCi9i71T
 yr8tX9xY3X1U7gSsei5h31uY1SyWi5DSRP/rAqpCr92yNB2oMHsTNg0df
 BgNkieWu8A36T5CK3J7D9sPjyGx7nZVvuCtLP5Zmk/EYQg0L3wxoAk3eF
 9dwqekWNzieFZheh43mpE26fR0GUyjC6VdNEc43AHmJ/ZjbVXQCj5OepF
 86aOsjT+LAU7W6sfYeMcaiWKOZvPtkSidcTmbgRf5QI3hvr5rZ9Yp4DYT
 ZUjuHneuQmhWcbREA0YWwXMnn0b6O2yz+C6ge3t6/dwSyw9DneuQ8nXqE w==;
X-CSE-ConnectionGUID: ht+Gon7lT0W5ea8Ltjlvzg==
X-CSE-MsgGUID: 40CziwZqTu6DPl8cZ7S5Cw==
X-IronPort-AV: E=McAfee;i="6800,10657,11622"; a="65864766"
X-IronPort-AV: E=Sophos;i="6.20,222,1758610800"; d="scan'208";a="65864766"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Nov 2025 01:32:47 -0800
X-CSE-ConnectionGUID: jskAH99nSqaJGW2vu0X6hg==
X-CSE-MsgGUID: 2RBuDv4XSFOFk695WIBx3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,222,1758610800"; d="scan'208";a="223251982"
Received: from unknown (HELO tester12..) ([10.239.252.12])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Nov 2025 01:32:45 -0800
From: hailinxx <hailinx.xu@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, rajesh.t.puttaswamy@intel.com,
 john.mcnamara@intel.com, hailinxx <hailinx.xu@intel.com>
Subject: [PATCH v1 0/2] updated latest recommended matching list
Date: Mon, 24 Nov 2025 08:50:08 +0000
Message-Id: <20251124085010.707091-1-hailinx.xu@intel.com>
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

1. Remove recommended versions before 21.11
2. Update 25.11 recommended matching list

Hailin Xu (2):
  net/ice: updated latest recommended matching list
  net/i40e: updated latest recommended matching list

 doc/guides/nics/i40e.rst | 72 +++-------------------------------------
 doc/guides/nics/ice.rst  | 13 +++-----
 2 files changed, 8 insertions(+), 77 deletions(-)

-- 
2.34.1

