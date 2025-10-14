Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD292CCD18D
	for <dpdk-dev@archiver.kernel.org>; Tue, 14 Oct 2025 12:41:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 459F640674;
	Tue, 14 Oct 2025 14:41:01 +0200 (CEST)
Received: from fhigh-b7-smtp.messagingengine.com
 (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
 by mails.dpdk.org (Postfix) with ESMTP id 293AC40673
 for <dev@dpdk.org>; Tue, 14 Oct 2025 14:41:00 +0200 (CEST)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 803CB7A0149;
 Tue, 14 Oct 2025 08:40:59 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-05.internal (MEProxy); Tue, 14 Oct 2025 08:40:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1760445659;
 x=1760532059; bh=s8P6t6vUsHlFWb8FTm8Zb6V1JH918eR2R7BEQ1hzT0Y=; b=
 ZCYgioTMtvIAW0hJm5+dNDa62c1QinXGcTtB3n67R50HxhuBVI1DY6VDmjDa1zvS
 y6GmCXYakPvcAwCi5vdhiQnyT3E1mE/5Z2dGVwCvk2sb4sn+5oVn2+tHlhxf/ZvW
 KNEq4TzsRw35KMoaeNlMih8w7pZzWhLxgjHhO7zpxB55OSApzSg8967pTHd5ur5W
 6B3/VH1vbDh+pib6GaQ8fT/9OPEfnRpCQ4P6JIVnZ8bYN9UefBqPWVTFRL7Z5qFs
 ruK+bnV9mXKRpAyiFznYCaSECODD3i62ZxdeDE+AG43LvXjV5hArpCoPPz/bauMN
 OEjdysvzxox5+977U06nQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760445659; x=
 1760532059; bh=s8P6t6vUsHlFWb8FTm8Zb6V1JH918eR2R7BEQ1hzT0Y=; b=E
 6xq9FMF3JUoB0Z5FDY3tpPPv/MzoHuS86EYzPJ5kZW2wJQoA4SvnEz73fGiCd4vV
 WrtMZLu3VewwSZsFk2/bqpEpzAB07XYNJF1LUww/kBfv5lbutWoRcGyTZ7pWvB3J
 TeYlZvOG2Qy0Pie26+udmrYi37bfEbVJP/WJGUgcZSBcHHonynLKQsx3GN2z/SbZ
 bHstpGe3ThjCgkbRMUCYHpjzFLUIZa9GCUm9cBrEzD3KA5U5dH6IN1+efMozmV8w
 +FF9mHyN/04UoD/JyUixzb5RAcRz54i6kqWoGjeasGlftftRoA8WxY4x/vf72Z6B
 U2nTCsVEqRuSSUhnMiLSQ==
X-ME-Sender: <xms:20TuaMehKGTxh1wwTvDnfYz1RiINp4eMM0xenW0elcG1Y1U7DuXddw>
 <xme:20TuaHIFFuBXjEJyOtAlNvcP29HPjo4D7Z_E764UlZSrXKM2d8XWVs8fCI8yP3T6M
 1dwTvR1N5V7SjohTR5Kec6q9mkyfr8TR6Zlb_XMSGySmvImAVgG_Q>
X-ME-Received: <xmr:20TuaJEFlmn_hPYa6UaqDlE7buRonh_lG251lPRburxLKlHGz6ywyBTbh4hQA1UTa77CfTXnZYGQv7H1-nxoVTu0tpXmfI0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvddtheeiucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfgggtgfesthekre
 dtredtjeenucfhrhhomhepvfhhohhmrghsucfoohhnjhgrlhhonhcuoehthhhomhgrshes
 mhhonhhjrghlohhnrdhnvghtqeenucggtffrrghtthgvrhhnpedtieffffegfeetlefhke
 euteeuudffjefgleevtdeijedukefgveehteehheegjeenucevlhhushhtvghrufhiiigv
 pedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehthhhomhgrshesmhhonhhjrghlohhnrd
 hnvghtpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthho
 peguvghvseguphgukhdrohhrghdprhgtphhtthhopehshhhpvghrvghtiiesnhhvihguih
 grrdgtohhmpdhrtghpthhtohepvhhirggthhgvshhlrghvohesnhhvihguihgrrdgtohhm
 pdhrtghpthhtohepsghruhgtvgdrrhhitghhrghrughsohhnsehinhhtvghlrdgtohhmpd
 hrtghpthhtohepmhgssehsmhgrrhhtshhhrghrvghshihsthgvmhhsrdgtohhmpdhrtghp
 thhtohepshhtvghphhgvnhesnhgvthifohhrkhhplhhumhgsvghrrdhorhhg
X-ME-Proxy: <xmx:20TuaCDm_ZTUwj5IVJhttl7tv4YtWqQ3hTqbr5I9-cAa-psORhQmZg>
 <xmx:20TuaE8WH7tZ9x7dOEXUPrvUiTBwpXYPhgR3EJeNZ6IxNFoLKX3bfA>
 <xmx:20TuaGDpCJFSpr-OOHTMZfPyvkcVefidkgr6aa0OEyNYMTW1WUxkcQ>
 <xmx:20TuaBRtbY04f-OJ-SMmPjc4PbZBiq2EKGbRpjeETYJU0bYc-uFCPA>
 <xmx:20TuaDqyxgb1UNinQ4iN3Jw6nbaS9sNAqIZw6AaprLZiZYsD-cRsJoO4>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Oct 2025 08:40:58 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: shperetz@nvidia.com, viacheslavo@nvidia.com, bruce.richardson@intel.com,
 mb@smartsharesystems.com, stephen@networkplumber.org
Subject: [PATCH v6 2/7] mbuf: move header include for logs
Date: Tue, 14 Oct 2025 14:33:35 +0200
Message-ID: <20251014124046.1032293-3-thomas@monjalon.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251014124046.1032293-1-thomas@monjalon.net>
References: <20250616072910.113042-1-shperetz@nvidia.com>
 <20251014124046.1032293-1-thomas@monjalon.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The header mbuf_log.h depends on rte_log.h, so it should include it.
After this move, no need to include rte_log.h in addition of mbuf_log.h.

Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
Reviewed-by: Morten Brørup <mb@smartsharesystems.com>
---
 lib/mbuf/mbuf_log.h | 2 ++
 lib/mbuf/rte_mbuf.c | 1 -
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/mbuf/mbuf_log.h b/lib/mbuf/mbuf_log.h
index 8feaf20747..f163cbd71c 100644
--- a/lib/mbuf/mbuf_log.h
+++ b/lib/mbuf/mbuf_log.h
@@ -1,5 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause */
 
+#include <rte_log.h>
+
 extern int mbuf_logtype;
 #define RTE_LOGTYPE_MBUF	mbuf_logtype
 #define MBUF_LOG(level, ...) \
diff --git a/lib/mbuf/rte_mbuf.c b/lib/mbuf/rte_mbuf.c
index 9e7731a8a2..22d7cfc475 100644
--- a/lib/mbuf/rte_mbuf.c
+++ b/lib/mbuf/rte_mbuf.c
@@ -12,7 +12,6 @@
 #include <eal_export.h>
 #include <rte_debug.h>
 #include <rte_common.h>
-#include <rte_log.h>
 #include <rte_branch_prediction.h>
 #include <rte_mempool.h>
 #include <rte_mbuf.h>
-- 
2.51.0

