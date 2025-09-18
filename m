Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4692CAC59F
	for <dpdk-dev@archiver.kernel.org>; Thu, 18 Sep 2025 09:10:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 461EB40670;
	Thu, 18 Sep 2025 11:10:52 +0200 (CEST)
Received: from fout-a4-smtp.messagingengine.com
 (fout-a4-smtp.messagingengine.com [103.168.172.147])
 by mails.dpdk.org (Postfix) with ESMTP id 7AC9140665;
 Thu, 18 Sep 2025 11:10:50 +0200 (CEST)
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
 by mailfout.phl.internal (Postfix) with ESMTP id 2F662EC0343;
 Thu, 18 Sep 2025 05:10:50 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-08.internal (MEProxy); Thu, 18 Sep 2025 05:10:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1758186650; x=
 1758273050; bh=7U+IU+DHiVs3sky2ewwjrdaGxsyE+v5rZmcPgwii+FA=; b=B
 dqbtA7PW0NkJZ3AU1r1Y3lGG/k8gvmMiE9iKc1/J7Hkp/nBC3hTZ1IsEZClkJ4Uy
 2+i4t4h9By4umKrMq+wdvirBxz07afYQPQNlNLTMDhxWQLsoruUr3QN93N2E2fI+
 pdX66Xy/FHhV+ZyjunoMpgMv1zdsKCzcHf7xtLSxucWys2Ul4urpdy78SLyoIWjF
 fxGNH3AckEdd4KfsWbwEZ8VlGCvJ/iZrqp8a/6ri5SavT73E+F2ORQznphUydSnP
 Vs33EXxbj6S6KztdondsXdiwf9JIe7I7eRSiD3p0lrnFVFIg557usqW1/wBjXOWT
 5AfYptHzsU3aqDiCxk8qw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm1; t=1758186650; x=1758273050; bh=7
 U+IU+DHiVs3sky2ewwjrdaGxsyE+v5rZmcPgwii+FA=; b=DEX9G1TlkJxoCKX3n
 74pB9q7IGE+GJzQSlq1Afzfd0rz+yaUFChqOShgWomjmRmlg5qA75K6jeRrpWt2m
 XH8sS/L/V+Up4To8R9MK2yDzKLnPn0rwU1gghSsgeAw6bv9kbmuJpQmP54Cpx15t
 s/lWzSrQ0GTU47VkuDdGD7IS6DjzDe7QA4SmEV1WFiEPoSbnPamvxF09FOMS+Erd
 GGL/OCml+jj8B+DBdLTE/pjNNCUmdgFqS+fOiFlc3TNYcVa4yqjD1/twqW5rkoGM
 g+ePXYY842+NW97o+jZH6BQRvQm41BZdhv99sj9f5wmC+DUddmh15o0a/e0uEMAR
 XYLVg==
X-ME-Sender: <xms:mczLaP6Umq1Br6weJuxhh3dnK8D57CbH9uOWBNLwx2F4OYp9cAHNqA>
 <xme:mczLaLr0mO02pzjrrIi2uf9H0i-w-9j_aQuIHOIc8KfCgm-vsyolqv9DAjx35Q7qX
 XFnmuMZGbsPGnZudg>
X-ME-Received: <xmr:mczLaIMvK7D955jiMEiGbKFs1RwzPI9QHyy7vOGLMeFFyR2I_gDkHTmfNjRmvlfsoPT2610ILsXiaM-6mJ8sL64MEfd2yZ8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegheelfecutefuodetggdotefrod
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
 thgvlhdrtghomhdprhgtphhtthhopehhrghrrhihrdhvrghnrdhhrggrrhgvnhesihhnth
 gvlhdrtghomhdprhgtphhtthhopehluhgtrgdrsghotggtrghsshhisehmihgtrhhoshho
 fhhtrdgtohhmpdhrtghpthhtohepkhgvihhthhdrfihilhgvshesihhnthgvlhdrtghomh
 dprhgtphhtthhopehsvggrnhdrmhhorhhrihhsshgvhiesihhnthgvlhdrtghomh
X-ME-Proxy: <xmx:mczLaL3B9Lzb9p5lA86Lnp8V34pkw5Tr8SyA3JpZzufcw3827euD4w>
 <xmx:mczLaPAAD-hy3KpuXUJsVLWJ-IxJV9e9yz_bUvVG9k1wqB43OOBFeg>
 <xmx:mczLaAI2-8ck1sBFrSq6ioTB3wAGFvpQwPt-g4_fXRzpq9tXiklhzw>
 <xmx:mczLaAmB9W9PstKLMOJuZxwD8Gtu9FaFKvIwrNWTdKdYP6rwyD2fag>
 <xmx:mszLaB9N_hwxB8-9KAVlhukJS-1o0LwFGkhX_WZ2kdJMp5fRIpMuM2wM>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Sep 2025 05:10:48 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, stable@dpdk.org,
 Byron Marohn <byron.marohn@intel.com>,
 Yipeng Wang <yipeng1.wang@intel.com>,
 Harry van Haaren <harry.van.haaren@intel.com>,
 Luca Boccassi <luca.boccassi@microsoft.com>,
 Keith Wiles <keith.wiles@intel.com>,
 Sean Morrissey <sean.morrissey@intel.com>
Subject: [PATCH v2 1/4] efd: fix AVX2 support
Date: Thu, 18 Sep 2025 11:08:07 +0200
Message-ID: <20250918091039.1368875-2-thomas@monjalon.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250918091039.1368875-1-thomas@monjalon.net>
References: <20250918073135.1273767-1-thomas@monjalon.net>
 <20250918091039.1368875-1-thomas@monjalon.net>
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

AVX2 is assumed to be always supported on x86 with supported compilers,
so the check for AVX2 is simply removed, and the include is added back.

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

