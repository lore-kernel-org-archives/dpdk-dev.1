Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61921D116F1
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Dec 2025 11:46:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6060140684;
	Mon,  1 Dec 2025 12:45:16 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id F31264065A;
 Mon,  1 Dec 2025 12:45:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1764589513; x=1796125513;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=fYeYCG5mt6l94wJgGOLrcEN3COoaXIlpKp3scsfWXCk=;
 b=DyvgQfRRDPfVZvt9MslicLgKxZMVLfomoO6s3giRIB0gc8Dn0+Xg4Z68
 SSam7ALwIS8dHfRBe+nRpd2bEBebNYoiWesBwswwsn0A1otcRjGuPNG2G
 Dk1O4/a2U0EBmPhAqEB8q/AsCXKjJRc3vBtD6TMg7CV7pdfX31RAVzG7m
 gpTyNGJsu/cyJP7y93Av11dEvbXbjrYFet0+KLfMcsMLj65M9GCh+6WXR
 QhzL4JpgnQjx1vgmry7LI7MqVOaCzHkFZbqN4TUZRRlSgw/LcLpXujRYl
 BW3aCnEqQzpej2pYDYK6cqsPSMpkOoWwF+eZ1XSp5toSNNYSLubj9cr/L Q==;
X-CSE-ConnectionGUID: hYZ1bqadRTKeQ1nKYBeXxg==
X-CSE-MsgGUID: J+H/eF/iT9qzIELrAb1SYQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11629"; a="77991718"
X-IronPort-AV: E=Sophos;i="6.20,240,1758610800"; d="scan'208";a="77991718"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Dec 2025 03:45:13 -0800
X-CSE-ConnectionGUID: Tg0zlemSSnWbQGxVYoP/Jg==
X-CSE-MsgGUID: AAohw6GSTZu4OtvpCMIKdQ==
X-ExtLoop1: 1
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa003.fm.intel.com with ESMTP; 01 Dec 2025 03:45:12 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>, stable@dpdk.org,
 Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v3 09/31] pcapng: rename variable to fix shadowing
Date: Mon,  1 Dec 2025 11:44:26 +0000
Message-ID: <20251201114448.1441377-10-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251201114448.1441377-1-bruce.richardson@intel.com>
References: <20251106140948.2894678-1-bruce.richardson@intel.com>
 <20251201114448.1441377-1-bruce.richardson@intel.com>
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

The "len" variable is shadowed within a function, so rename inner use to
the more descriptive "filter_len" to fix the issue.

Fixes: d1da6d0d04c7 ("pcapng: require per-interface information")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
Acked-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/pcapng/rte_pcapng.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/lib/pcapng/rte_pcapng.c b/lib/pcapng/rte_pcapng.c
index 21bc94cea1..2cc9e2040d 100644
--- a/lib/pcapng/rte_pcapng.c
+++ b/lib/pcapng/rte_pcapng.c
@@ -296,16 +296,15 @@ rte_pcapng_add_interface(rte_pcapng_t *self, uint16_t port, uint16_t link_type,
 		opt = pcapng_add_option(opt, PCAPNG_IFB_HARDWARE,
 					 ifhw, strlen(ifhw));
 	if (filter) {
-		size_t len;
+		const size_t filter_len = strlen(filter) + 1;
 
-		len = strlen(filter) + 1;
 		opt->code = PCAPNG_IFB_FILTER;
-		opt->length = len;
+		opt->length = filter_len;
 		/* Encoding is that the first octet indicates string vs BPF */
 		opt->data[0] = 0;
 		memcpy(opt->data + 1, filter, strlen(filter));
 
-		opt = (struct pcapng_option *)((uint8_t *)opt + pcapng_optlen(len));
+		opt = (struct pcapng_option *)((uint8_t *)opt + pcapng_optlen(filter_len));
 	}
 
 	opt = pcapng_add_option(opt, PCAPNG_OPT_END, NULL, 0);
-- 
2.51.0

