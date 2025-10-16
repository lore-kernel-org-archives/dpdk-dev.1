Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47964CCD199
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Oct 2025 20:36:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E2555427AE;
	Thu, 16 Oct 2025 22:36:09 +0200 (CEST)
Received: from fhigh-a4-smtp.messagingengine.com
 (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
 by mails.dpdk.org (Postfix) with ESMTP id DDDCA427C7
 for <dev@dpdk.org>; Thu, 16 Oct 2025 22:36:08 +0200 (CEST)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 871D6140019B;
 Thu, 16 Oct 2025 16:36:08 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Thu, 16 Oct 2025 16:36:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1760646968;
 x=1760733368; bh=s8P6t6vUsHlFWb8FTm8Zb6V1JH918eR2R7BEQ1hzT0Y=; b=
 VeUCZ2pBEekSnviDPWNsY7qNzJwVcbfXs3dhhFz3pUtFz10YefvlOUE3/GbHJtcu
 Z7lUP2hBx++xNGBHal4VQqnHP4KffDFVwtqPiu/6+V3/FeDQxCaqlR/QByuBizXO
 psA+cuzo7WXR6BxP3DOCCCU6qIMfO+yzHjwIaWH7rQ7ENmyEreUR+miidScLvZJE
 lGJf4GBLrrL5r/R0O/GQooSWMkngQrvCW5uhOTBMkFNjysdMn9oq0lfSdEkCziVd
 RRSadDdvL64lW7m71Ldr7nJIoCXZBKBIzu/MGfsdknOJ3jjW6edi3rwqg7G422kZ
 4ByQ77gScR7fHBExnZA06g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760646968; x=
 1760733368; bh=s8P6t6vUsHlFWb8FTm8Zb6V1JH918eR2R7BEQ1hzT0Y=; b=g
 Bkaw8JU3ASzeDvxg/zQkL989HoPwJNtB2yCfaonFtwy+4eLoTRl+kyvLk4Q14mEa
 IZyCTD6laYd9sEjfcjFKnPPhDQx2Z02ytH4xL2W+AnLBlF1Py2HGT4ednzE4dSxe
 TkVSgj/ITsi2pNVUH2bgKD0AtPvdV/7jwdvdr08+lLeCSp0hwvF9QoTkBDacp9mC
 Mc6xqSEFKSs3oooryw2t73SImsz22KRssj/BQqZLyYooYoHFyU2fYfMabsbl+Msa
 rzceAmxlW0szc0QnOfYKT4dPD8S7qGE07AOtMurqkqf+UFA97pMnQLbastyfoTja
 83OqicrW+yYoywM3QxKyA==
X-ME-Sender: <xms:OFfxaNW-MyVRnC3xzQ3ysD_gPWrNCYHXpPdIH1WwJhm_TGrbGRf67A>
 <xme:OFfxaGj40_qzKPk_wqRFz7b40PeFEHHRaimaX0ds9G1mKSwAZd12OhfkIbkLQp9Fo
 qyMjQNC36AGtIOwA3O9g_cKU-8VuieihCrY5h8_VEWnvs79KY08DbQ>
X-ME-Received: <xmr:OFfxaE98h8PxeFeHd7yU0tia06IG-ms17-GDNGyCshAP5O1Q-_YFb5TyCJsmIJGUYDCk_FHdW_OxBzxPuTZob_77KvDsPU4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdejvdeiucetufdoteggodetrf
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
X-ME-Proxy: <xmx:OFfxaAYppAypiusMTe8oeGY4t9x--HRPkHYaqCfwSdUFKWh8Yx7tXg>
 <xmx:OFfxaD02DC0VNXktI2hGKr26-AmbYDXnETIuKrq6_Y1t0KDxcvhuGg>
 <xmx:OFfxaLZVF_GSZMPtxu8o0aZD7bioB89gKJ2ptOm62fmv2d3NM0c0zw>
 <xmx:OFfxaLLRLtxN5CSmP14VvTN5sXnqGe4W91hj8TRJbgxUzfkZaT5_Fg>
 <xmx:OFfxaFjIGgyxJC8yFYgiYgSOw8xDwgY_pKxro4etNIfI5nifhn9qsx_6>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Oct 2025 16:36:07 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: shperetz@nvidia.com, viacheslavo@nvidia.com, bruce.richardson@intel.com,
 mb@smartsharesystems.com, stephen@networkplumber.org
Subject: [PATCH v7 2/7] mbuf: move header include for logs
Date: Thu, 16 Oct 2025 22:34:40 +0200
Message-ID: <20251016203557.2554678-3-thomas@monjalon.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251016203557.2554678-1-thomas@monjalon.net>
References: <20250616072910.113042-1-shperetz@nvidia.com>
 <20251016203557.2554678-1-thomas@monjalon.net>
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

