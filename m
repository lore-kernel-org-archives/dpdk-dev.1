Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81980CDB46F
	for <dpdk-dev@archiver.kernel.org>; Mon, 22 Jun 2026 11:18:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A8EEA402E1;
	Mon, 22 Jun 2026 13:18:43 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id 80A7A4028B
 for <dev@dpdk.org>; Mon, 22 Jun 2026 13:18:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782127121; x=1813663121;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=POOSq1lreebBdLSFHahD+rIcNTXkQyE62WKTsao3BC4=;
 b=hbEoHf91H5DMXpZgC4JoCMZcO17mPKMvIgg2XXGtzxprP966C71OKDmM
 nD9bb0RX2gGhTB/bdOrMlnU1gtDom1gYyndTqzJXpyMhcjLuBqPmA9pK7
 rl5moLg9eUKG8QOAG/d5NaSJrzkrvKN/mW88PqpsoFXpLU4Ok99JAubHa
 amakNaRUIc1xUc+F3dMhmHUUZuHyUznB/+kjJupH3WagG42lv8X4YHDf3
 e/Ev0yZ0o7YEB3XS5euwxq7ggLw7A5mOkHuD1kOyP2Dg8lXPt8AeK4YBR
 RmD3UmfTIRPmPMQu0B7e3vq90XSGHOaxaoAVaa3pNzQ+HRF8HWZ8VatKb w==;
X-CSE-ConnectionGUID: wVrzxyVsS/K8pG49hYXoEw==
X-CSE-MsgGUID: 0erFgndGSOGPxoy+xig98w==
X-IronPort-AV: E=McAfee;i="6800,10657,11824"; a="93219297"
X-IronPort-AV: E=Sophos;i="6.24,218,1774335600"; d="scan'208";a="93219297"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jun 2026 04:18:40 -0700
X-CSE-ConnectionGUID: tm+veFXkQEiAxjrQ9nka1g==
X-CSE-MsgGUID: s985/DyaQPyzacrm5B1VsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,218,1774335600"; d="scan'208";a="246883927"
Received: from silpixa00401385.ir.intel.com (HELO
 localhost.ger.corp.intel.com) ([10.20.224.226])
 by fmviesa008.fm.intel.com with ESMTP; 22 Jun 2026 04:18:40 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH 0/3] Fixes for inline ipsec test cases
Date: Mon, 22 Jun 2026 12:18:31 +0100
Message-ID: <20260622111835.233554-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
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

A series of small fixes for the inline ipsec test cases, with the third
patch being the most significant - skipping tests where we don't have the
necessary HW support to run the tests. Previously this was leading to test
failures when the tests should never have been run due to missing HW
capabilities.

Bruce Richardson (3):
  test/security_inline_proto: remove fast-free Tx flag
  test/security_inline_proto: fix MTU calculation underflow
  test/security_inline_proto: check for capabilities

 app/test/test_security_inline_proto.c | 75 +++++++++++++++++++++++++--
 1 file changed, 70 insertions(+), 5 deletions(-)

--
2.53.0

