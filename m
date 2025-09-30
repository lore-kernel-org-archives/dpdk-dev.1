Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8168DCAC5B8
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Sep 2025 23:38:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1FD9B40670;
	Wed,  1 Oct 2025 01:38:53 +0200 (CEST)
Received: from fout-b1-smtp.messagingengine.com
 (fout-b1-smtp.messagingengine.com [202.12.124.144])
 by mails.dpdk.org (Postfix) with ESMTP id A17B74065D
 for <dev@dpdk.org>; Wed,  1 Oct 2025 01:38:51 +0200 (CEST)
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
 by mailfout.stl.internal (Postfix) with ESMTP id CA54E1D00135;
 Tue, 30 Sep 2025 19:38:50 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-11.internal (MEProxy); Tue, 30 Sep 2025 19:38:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1759275530; x=
 1759361930; bh=S8HZcsTbrH5lG1POubh+56/8oulOXfugHauOTy6xObA=; b=X
 xDNXRrkVHOI19k+IFjGV0U0IJUtvne7BQa8bbUZ8WPM2A4N9L9fhltJ6noXQtlqK
 k7w1PXJtfPXUyqFtyTUkbDd3UPorhRmlEvOE+gnmeTG/LYK7MnMo+Z4tOVqZ/RVs
 t5QnPv08j0cFK6FXB0EKZPNTHjtr96VxOftozUPeHzthMpV8OdmUJwDlS56AlR7A
 FslSaMgI/CSIp4DHOj5nde0EM/q8j5+Cu9z2aTTeDOsRmrnhZrCx/s0K4A0yJX6h
 38gFCD7ibIMIxWfmcIy1QuHp6ptpczumeMaEU9E2Uc64dEr5uEllowkRsr2b18W2
 SbD4rsOGksmJM5LeQIuwQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm2; t=1759275530; x=1759361930; bh=S
 8HZcsTbrH5lG1POubh+56/8oulOXfugHauOTy6xObA=; b=OSfOWzjf7/nDp1U2c
 bGxvzjPJwBlf9obrJzrctug80XCQ98P87n45yAG274b9uO5JgKIkzIMlHivT/MUA
 3actjA0WUB7CkLNPxTwvPSo237rzFuqXqOLUNNI9kMsnR6u/KYJdtNOEQC3/zAna
 PYy0GBPhjuRIJMWHNvMpH+tRgcASfByU7fhQWMPwtjkRTk7G1zvJrja0okHkNSez
 QsJoDlEzPKOYagopFxNawfazEF4hcQySJvDF82zdl90wnTI0UBSJKTU4TL9j5tA4
 Y4P/++qZ2fd2mNSl4NuvrGdNZzjEA1tczPALVc1wthDcRqAIJCTic4lr8i1b23fK
 WeyqA==
X-ME-Sender: <xms:CmrcaBy2up6M4UI4TLF_iNHFHiFhXrU8Gce53RC_GgFo7INzj232pg>
 <xme:CmrcaKML6YK4dbxK96Jl1Brkze4IVNvjIoyPs6Vo37CxUd4276DH9U1QLiHC-k_UJ
 PCLUJLgOm4-I-Se-0Q7QQoW3ecdz5RMSgBE1BTW-3-fMTpj6ZBtWQ>
X-ME-Received: <xmr:CmrcaG6uK4ignIfzjABJfQvEoRUi73spG5dtI9Z52VFGzP7pEXAg6cyV1ws6-MfDYVhJxMgSQl8JaT7mKodb41XipxN1Zak>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekudejjecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestdekredtre
 dttdenucfhrhhomhepvfhhohhmrghsucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhho
 nhhjrghlohhnrdhnvghtqeenucggtffrrghtthgvrhhnpedvjefhudeghedvtdeijeeige
 etuedugfejueekieeltdfhteevkeehhfeilefhtdenucevlhhushhtvghrufhiiigvpedt
 necurfgrrhgrmhepmhgrihhlfhhrohhmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvg
 htpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegu
 vghvseguphgukhdrohhrghdprhgtphhtthhopehshhhpvghrvghtiiesnhhvihguihgrrd
 gtohhmpdhrtghpthhtohepvhhirggthhgvshhlrghvohesnhhvihguihgrrdgtohhmpdhr
 tghpthhtohepsghruhgtvgdrrhhitghhrghrughsohhnsehinhhtvghlrdgtohhmpdhrtg
 hpthhtohepmhgssehsmhgrrhhtshhhrghrvghshihsthgvmhhsrdgtohhmpdhrtghpthht
 ohepshhtvghphhgvnhesnhgvthifohhrkhhplhhumhgsvghrrdhorhhg
X-ME-Proxy: <xmx:CmrcaDlaKWIMLg1Y5HWkq1fMKce0kf8ZOQ5gsWAZ7TrH_AHauehI6w>
 <xmx:CmrcaPT6-dVgO4Lzm7Nr6Tt_r_JBm2hojNVVCjJiw9l2PDqALXDF6Q>
 <xmx:CmrcaKGBxIcFaR3DD6Xf735_0Jk0swt_zfH44C7E5UA223_hlTZuzQ>
 <xmx:CmrcaMGmA-Ao9e0cxqv-i90Tkwpil0tBiXDi5uhAcQj4JtEFUMlwpA>
 <xmx:CmrcaCfm950lQhCfhwKDWLN8F-Ws7FH4fC55d5FsfDbcZ3QB6bEGHilq>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Sep 2025 19:38:49 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: shperetz@nvidia.com, viacheslavo@nvidia.com, bruce.richardson@intel.com,
 mb@smartsharesystems.com, stephen@networkplumber.org
Subject: [PATCH v3 1/5] mbuf: move header include for logs
Date: Wed,  1 Oct 2025 01:25:02 +0200
Message-ID: <20250930233828.3999565-2-thomas@monjalon.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250930233828.3999565-1-thomas@monjalon.net>
References: <20250616072910.113042-1-shperetz@nvidia.com>
 <20250930233828.3999565-1-thomas@monjalon.net>
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

The header mbuf_log.h depends on rte_log.h, so it should include it.
After this move, no need to include rte_log.h in addition of mbuf_log.h.

Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
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

