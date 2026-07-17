Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19B95C44507
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Jul 2026 09:16:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 818E640B9B;
	Fri, 17 Jul 2026 11:16:07 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id 6EF89402F0
 for <dev@dpdk.org>; Fri, 17 Jul 2026 11:16:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784279766; x=1815815766;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=j0fkFW29aKjV2w2Sws/9gpXpZpgY4e52Nex2sC1ft6g=;
 b=IgP5pmMEsJ6RjOA9DC843g2vvQCQb3hgS9rXM+XA6Jlmgozu8ZLj9ld2
 aBRZ2n+QJc9ZH1pARDC2K+8Rt96UteE+EjANLboBtg6eIcXlXC12DIt85
 znn6PzJKJjaojiZoITKlQVaqQA+TuNEbnLPnCmsauhEPnPKMart0jhEMa
 dS7gblfPRhWoJ23XTLJ0KC2xlUanNBHgXZ4NKtQzIfYIX5BM4Ei8ifNLG
 4ayOkFOH0yHQatdU+YcWghTBcOLUUeKoCAFBosfMfFkIaPYaxxcgHq0Kz
 b3yIa0ioBz5cuYJkNVqp6GbB/UqWd/s1IGGjh1upS036cFTWi8wPNviD/ Q==;
X-CSE-ConnectionGUID: 2QQmBwOpS1iXwKhkB2MSrw==
X-CSE-MsgGUID: OWMWLiSOQ9CfXnlfOpIWvw==
X-IronPort-AV: E=McAfee;i="6800,10657,11848"; a="95550049"
X-IronPort-AV: E=Sophos;i="6.25,169,1779174000"; d="scan'208";a="95550049"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jul 2026 02:16:06 -0700
X-CSE-ConnectionGUID: e+jtWDmYSGSj9vBELNDUCQ==
X-CSE-MsgGUID: 2eyi70tyTzC7juPfdgzVXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,169,1779174000"; d="scan'208";a="260315204"
Received: from unknown (HELO tester12..) ([10.239.252.12])
 by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jul 2026 02:16:04 -0700
From: Hailin Xu <hailinx.xu@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com
Cc: manjunathgouda.hosamani@intel.com,
	Hailin Xu <hailinx.xu@intel.com>
Subject: [PATCH v1 2/3] updated ice latest recommended matching list
Date: Fri, 17 Jul 2026 17:12:32 +0800
Message-Id: <20260717091233.12102-2-hailinx.xu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260717091233.12102-1-hailinx.xu@intel.com>
References: <20260717091233.12102-1-hailinx.xu@intel.com>
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

Signed-off-by: Hailin Xu <hailinx.xu@intel.com>
---
 doc/guides/nics/ice.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/doc/guides/nics/ice.rst b/doc/guides/nics/ice.rst
index 5589ce934f..57e2c65169 100644
--- a/doc/guides/nics/ice.rst
+++ b/doc/guides/nics/ice.rst
@@ -61,6 +61,7 @@ are listed in the Tested Platforms section of the Release Notes for each release
 =====  =============  ===========  =========  ============  =======  =======
 DPDK   Kernel Driver  Default DDP  COMMS DDP  Wireless DDP  E810 FW  E830 FW
 =====  =============  ===========  =========  ============  =======  =======
+26.07     2.6.6         1.3.59      1.3.63       1.3.28      5.0      2.10
 26.03     2.4.5         1.3.53      1.3.61       1.3.25      4.91     1.20
 25.11     2.3.14        1.3.43      1.3.55       1.3.25      4.9      1.11
 24.11     1.15.4        1.3.36      1.3.46       1.3.14      4.6
-- 
2.34.1

