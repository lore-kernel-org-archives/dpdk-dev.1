Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CE45CAC5AE
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Sep 2025 15:46:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E0A0340A7F;
	Wed, 24 Sep 2025 17:46:51 +0200 (CEST)
Received: from fhigh-b5-smtp.messagingengine.com
 (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
 by mails.dpdk.org (Postfix) with ESMTP id 783DE40A6D;
 Wed, 24 Sep 2025 17:46:50 +0200 (CEST)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfhigh.stl.internal (Postfix) with ESMTP id A31BB7A01AE;
 Wed, 24 Sep 2025 11:46:49 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-04.internal (MEProxy); Wed, 24 Sep 2025 11:46:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1758728809; x=
 1758815209; bh=qiIIuHij3QXWxQJJGdQTZHk/cAAB2xt2xIVoOy9+RDg=; b=F
 nUQzxd2ShbWuYkOIG8UeP+GaDDaOkMlefU8eacmZuI8PROKmhy10h3vMxfApr4hC
 SqsKWQ57J2MOzgetzMELWVWmaLd3sZcHZ/tG+Vsl/b6zUL/5w8TvWu9pfM71yaH9
 /EFGOBDqfLRP78P9kgXgfoFHHmleLqzRQEhgt0qHDdHJlnyP9R3j0GtB7tGit6aN
 ZwKvb8cDVR5fBp8jYqW7nlcPLzcdGSZa8jI3bPx8uywrvBXe41qZbJA9fHHo36W3
 CMnvjmht5IHCuR5El1eti2z/YBG6xuiipPi7iE2yDrWi35nYNWsDI/8iwfd59Od5
 EfoXNQgcbbaHEZ11WYlTA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm1; t=1758728809; x=1758815209; bh=q
 iIIuHij3QXWxQJJGdQTZHk/cAAB2xt2xIVoOy9+RDg=; b=PDoHpIqcdZCB4q5oY
 I8qaGudxTpFfOk/WaOQeyJ28r/arYIkkqTgoEYYDgGK8JE4ch8v/19+A3y23kdZC
 YpuOFbi6A35NK0/MD7ZzIStBmRfU4Ejqed+WOahMSHc5o6ZoEqcwn6onlUChpRwo
 nuCrRlNznFnz/fUhJd52tyrafevoV4ZHGRuvEQd1GRpjUu4mZogM7glddxQO0Bzk
 2NWVq6ly7XAuS3qQG68Ur0ttWx9akBicjjfSngrrPtZVDnHJg5jHoIGQLseE757F
 tezJ2gwX2X2y12KcPkz/s0tI/TiVpvH6BsL5JmOjnSPo/wQ6X1kpnAiHvq6iBNzU
 fYv8A==
X-ME-Sender: <xms:aRLUaAcILFNtJDa56mKXpLaW0E0WghrFiVEPumgeBDnw9vaK7K1sIg>
 <xme:aRLUaOOyIVK-74FcNI96yVf8XNamqXPdl4qKncYgCVtOUd6AkX4uPLXoyGkrBvBbE
 RnP17QkdPjMblII2I9wXvG3Gq2katyG0pISr5EKGigc3bJLSifwNg>
X-ME-Received: <xmr:aRLUaDttGIWAJWcRxKY25DNvgYZMIYZHgJWanhLPvbimrWA1f2l0ek-013qrCryIbuyfJjrSZzdqEYXwbUK6X3Lb_rnJW3A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeigedtudcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefvhhhomhgrshcu
 ofhonhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrf
 grthhtvghrnhepvdejhfdugeehvddtieejieegteeuudfgjeeukeeiledthfetveekhefh
 ieelhfdtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
 epthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohepledpmhho
 uggvpehsmhhtphhouhhtpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpth
 htohepsghruhgtvgdrrhhitghhrghrughsohhnsehinhhtvghlrdgtohhmpdhrtghpthht
 ohepshhtrggslhgvseguphgukhdrohhrghdprhgtphhtthhopegshihrohhnrdhmrghroh
 hhnhesihhnthgvlhdrtghomhdprhgtphhtthhopeihihhpvghnghdurdifrghnghesihhn
 thgvlhdrtghomhdprhgtphhtthhopehkvghithhhrdifihhlvghssehinhhtvghlrdgtoh
 hmpdhrtghpthhtohephhgrrhhrhidrvhgrnhdrhhgrrghrvghnsehinhhtvghlrdgtohhm
 pdhrtghpthhtoheplhhutggrrdgsohgttggrshhsihesmhhitghrohhsohhfthdrtghomh
 dprhgtphhtthhopehsvggrnhdrmhhorhhrihhsshgvhiesihhnthgvlhdrtghomh
X-ME-Proxy: <xmx:aRLUaHBkoaxc9UP1uvxR45yr03VRIcrHB_svMRR7A_bSkQjnkRB_5Q>
 <xmx:aRLUaKY4Ur9hNH0stD4zOEeR0AQNwi-GP4bbrkNKBDEjQybIt7cFjg>
 <xmx:aRLUaCX4e4-xTxT3DGC0dQvtYqNzmxMdQUmJ1gepdCFSJcZzeVf1ag>
 <xmx:aRLUaJMVVtK2zb5v8bS4H8mORxjJ-ZRp4ehLsvadaIwMOOiWZfmb0w>
 <xmx:aRLUaDXT48ddM0bSK8pRvfjDhWqO1UStAyVgVdjIc25joI4ShGdeRk7F>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Sep 2025 11:46:47 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, stable@dpdk.org,
 Byron Marohn <byron.marohn@intel.com>,
 Yipeng Wang <yipeng1.wang@intel.com>, Keith Wiles <keith.wiles@intel.com>,
 Harry van Haaren <harry.van.haaren@intel.com>,
 Luca Boccassi <luca.boccassi@microsoft.com>,
 Sean Morrissey <sean.morrissey@intel.com>
Subject: [PATCH v3 1/2] efd: fix AVX2 support
Date: Wed, 24 Sep 2025 17:43:17 +0200
Message-ID: <20250924154641.2684705-2-thomas@monjalon.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250924154641.2684705-1-thomas@monjalon.net>
References: <20250918073135.1273767-1-thomas@monjalon.net>
 <20250924154641.2684705-1-thomas@monjalon.net>
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

When switching to Meson build, the compilation check on CC_SUPPORT_AVX2
became obsolete, thus the case EFD_LOOKUP_AVX2 became dead.
The function efd_lookup_internal_avx2() was never called,
and its header include rte_efd_x86.h has been removed later.

EFD_LOOKUP_AVX2 is chosen at runtime after checking AVX2 availability,
so the obsolete build-time check for AVX2 can be simply removed,
and the missing include added back.

Fixes: 5b9656b157d3 ("lib: build with meson")
Fixes: 30a1de105a5f ("lib: remove unneeded header includes")
Cc: stable@dpdk.org

Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
---
 lib/efd/rte_efd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/efd/rte_efd.c b/lib/efd/rte_efd.c
index b0e44e5c51..ebf1e0655f 100644
--- a/lib/efd/rte_efd.c
+++ b/lib/efd/rte_efd.c
@@ -26,6 +26,7 @@
 
 #include "rte_efd.h"
 #if defined(RTE_ARCH_X86)
+#include "rte_efd_x86.h"
 #elif defined(RTE_ARCH_ARM64)
 #include "rte_efd_arm64.h"
 #endif
@@ -1279,7 +1280,7 @@ efd_lookup_internal(const struct efd_online_group_entry * const group,
 
 	switch (lookup_fn) {
 
-#if defined(RTE_ARCH_X86) && defined(CC_SUPPORT_AVX2)
+#if defined(RTE_ARCH_X86)
 	case EFD_LOOKUP_AVX2:
 		return efd_lookup_internal_avx2(group->hash_idx,
 					group->lookup_table,
-- 
2.51.0

