Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2D0FCCF9F8
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Nov 2025 03:20:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B4D1740281;
	Wed,  5 Nov 2025 04:20:36 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id A9D1940269
 for <dev@dpdk.org>; Wed,  5 Nov 2025 04:20:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762312836; x=1793848836;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=XJV5U4QKqkwyl3zlNZ3YETXGC3wJcy+xhISgscyKsUY=;
 b=lLP/jxQZ9/pExce3LKawexEyB/GNfZGeKWgpfU1DeVa6ZkRHB1HpjKNd
 RUcj5oCWtjM2aOFiAEmKoD6LMgmTdv2j0pQyqbsxlapu7sdcVgFTa2GEy
 vkOmNNZs/F+xVNlPpT3cc7sJ/Exkf2PdtDoaH5jPX0eb6jKj8lnuOmTos
 EUuHasftGUba2FSiOraMonvAKsSpfFSymLX17Vsa5Xqb+CZ5X9K1l0omr
 S6oPouqwEH46lwcf+hHHPM4G6xNQlcC8aUQnHl3TUqXo+7utNqrhzPWYW
 mvu8u0MyCXmm7PqXKj0y0XVorO08PoSMZ4lU9ODp1g1F87o9XpCHRgYBL Q==;
X-CSE-ConnectionGUID: TeVLOTW2TD+mMX+Cmvr/Jg==
X-CSE-MsgGUID: 3azN1/vmS0m/vx1yrsgxhQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11603"; a="51989629"
X-IronPort-AV: E=Sophos;i="6.19,280,1754982000"; d="scan'208";a="51989629"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2025 19:20:33 -0800
X-CSE-ConnectionGUID: 30Y2l0DjQtSwrYmjDymXQw==
X-CSE-MsgGUID: corBB4tAQ3CEwh1d++Pckg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,280,1754982000"; d="scan'208";a="187277466"
Received: from unknown (HELO localhost.localdomain) ([10.239.252.253])
 by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2025 19:20:33 -0800
From: Mingjin Ye <mingjinx.ye@intel.com>
To: dev@dpdk.org
Cc: Mingjin Ye <mingjinx.ye@intel.com>
Subject: [PATCH 0/2] L4 protocol retrieval from L3 header
Date: Wed,  5 Nov 2025 02:47:22 +0000
Message-Id: <20251105024724.830304-1-mingjinx.ye@intel.com>
X-Mailer: git-send-email 2.25.1
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

Mainly processed the IPv6 extension header without offsetting to the start
position of the extension header. The parsed inner protocol is incorrect.

Mingjin Ye (2):
  app/testpmd: revert L4 protocol retrieval from L3 header
  app/testpmd: fix the IPv6 extension offset

 app/test-pmd/csumonly.c | 40 ++++++++++++++++++++++++----------------
 1 file changed, 24 insertions(+), 16 deletions(-)

-- 
2.25.1

