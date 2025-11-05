Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 235D0CCFA04
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Nov 2025 03:20:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4123E40613;
	Wed,  5 Nov 2025 04:20:47 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id 372FC402E8;
 Wed,  5 Nov 2025 04:20:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762312844; x=1793848844;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=kkxWCoLo/DnsIddR1VSrU0LlqGsxhp/+ukVl/G3IatY=;
 b=hsYaUDaEaQ1c/wB+fj/9LaFp2iQrDOaFWIicTwBcJEnjqJnVt+FcDSkg
 7UUSn+ne/1lJGxATPRKxGiVJZnl41Ox/tj5rRYqpD+tox4EZy0fLPNAiD
 SLURhnLtO5gSQD6E0ipQhC1fXNPRbg7RNDTzNPsY3AOAI1IP9FbLXLL4v
 iW/xQxIIseMUAOHc28bBCnC6o7dxhaOCodCwG5FMKOavb/c4E/x8bd2PK
 cxruH1pAnzHlvhsoB9WI3NQ2A1g33Zg09xoOBUV3g0h4nGlzKwCUXgl9w
 DUrI8uJCFSwaTuPFO0QYEqWE7ymkhJi1a5ysPmiqiBpD60a7RjmbzWAvb g==;
X-CSE-ConnectionGUID: 98Y4baGpQASR7Cxun77+kg==
X-CSE-MsgGUID: FaEbNPIkRsCaXc1f5ZorTQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11603"; a="63624383"
X-IronPort-AV: E=Sophos;i="6.19,280,1754982000"; d="scan'208";a="63624383"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2025 19:20:44 -0800
X-CSE-ConnectionGUID: 6kXU4W/JQPy0p8L4U+2j+Q==
X-CSE-MsgGUID: ZFjBBPKmTUm1r/PJuXgWTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,280,1754982000"; d="scan'208";a="187277488"
Received: from unknown (HELO localhost.localdomain) ([10.239.252.253])
 by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2025 19:20:43 -0800
From: Mingjin Ye <mingjinx.ye@intel.com>
To: dev@dpdk.org
Cc: Mingjin Ye <mingjinx.ye@intel.com>, stable@dpdk.org,
 Aman Singh <aman.deep.singh@intel.com>
Subject: [PATCH 2/2] app/testpmd: fix the IPv6 extension offset
Date: Wed,  5 Nov 2025 02:47:24 +0000
Message-Id: <20251105024724.830304-3-mingjinx.ye@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251105024724.830304-1-mingjinx.ye@intel.com>
References: <20251105024724.830304-1-mingjinx.ye@intel.com>
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

The skip ipv6 extension must be offset after the IPv6 header.

Fixes: 76730c7b9b5a ("app/testpmd: use packet type parsing API")
Cc: stable@dpdk.org

Signed-off-by: Mingjin Ye <mingjinx.ye@intel.com>
---
 app/test-pmd/csumonly.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/app/test-pmd/csumonly.c b/app/test-pmd/csumonly.c
index d355dbd8c0..4b24bde190 100644
--- a/app/test-pmd/csumonly.c
+++ b/app/test-pmd/csumonly.c
@@ -559,6 +559,7 @@ parse_l4_proto(const struct rte_mbuf *m, uint32_t off, uint32_t ptype)
 
 		if ((ptype & RTE_PTYPE_INNER_L3_MASK) ==
 				RTE_PTYPE_INNER_L3_IPV6_EXT) {
+			off += sizeof(struct rte_ipv6_hdr);
 			ret = rte_net_skip_ip6_ext(ip6h->proto, m, &off, &frag);
 			if (ret < 0)
 				return 0;
-- 
2.25.1

