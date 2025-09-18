Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF04CCAC597
	for <dpdk-dev@archiver.kernel.org>; Thu, 18 Sep 2025 07:32:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DB7D740612;
	Thu, 18 Sep 2025 09:32:07 +0200 (CEST)
Received: from fhigh-a2-smtp.messagingengine.com
 (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
 by mails.dpdk.org (Postfix) with ESMTP id A85B54027A;
 Thu, 18 Sep 2025 09:32:06 +0200 (CEST)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 43B101400234;
 Thu, 18 Sep 2025 03:32:06 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Thu, 18 Sep 2025 03:32:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1758180726; x=
 1758267126; bh=51fguQeFqArwy85wukflxmiVYLUMFSobjee5Kjxb720=; b=Z
 mnYqeqKq06C2gkH6oZtKnJoIf4XHohOywuaFpkCnlcSqpRcjYMXGFTPvdoReDRbm
 pcwxm4jyMYxcOMP311KhzXbCt8/c2xwWtGNHXOhX1OgP2740+Xnx1BsI8tO9sLds
 vf6ZA33RGubwbtoBq+2Ro9Mbtie1/bepcXUVbjTKRecgbjcq/VeZHiDGO4jYS03/
 MgngUm3/tggNZIvwGgNb60vzsNNZmvep1/xpXNPRsgqJKMroC8c1KboGlfu88evq
 CAgJMAa8Ash9xWRYjsvgcPLUWQ3M7yrftgbKYoAfxgyLYK7ZYC9KV2c5QN7eNDl8
 43jirpCHIg0gvpwOO1neA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm1; t=1758180726; x=1758267126; bh=5
 1fguQeFqArwy85wukflxmiVYLUMFSobjee5Kjxb720=; b=WniJxmdm9eFbrz3DK
 0RKfS7WWtngXYENnoeVRUpt00v4piW0v6dHUuVQ04kU8rjIbCWuS8oKwXL5AG+qp
 vyu3rsBVsxpkCAGBrQizjWCoyTh07vWfvM+/wNCaWffD4vEE/WrCTNbEcrCm61hc
 n6ZH/TGd2Bv4o1paap/fvKeSr9N1Qu7ti6QTU0mNP6jV4g7k0rmVHpIE3qmeRig5
 N6aTFn16/iUSs46sbosAivuhnDxfW4ZH19Z2oUtzyWIEhq9xsyxjgGGwmybhXFZK
 hA/XDb9wHs06TNp33cJwqtiuz8K7mGfR6tnSWPklbqJNmudstoq9NAjdToCv5DWK
 OiKGw==
X-ME-Sender: <xms:dbXLaOgjIddxzSn9LxN23yXFjyWyYClUleYDPJma9t03AVWrOS0anA>
 <xme:dbXLaFwKAixnL1FGLsNt2AxJdisZaNZfy_Y3k5jaooTkWaTNHwPwbLUtWHozbWTKY
 AZz7ENs0eowN10M0w>
X-ME-Received: <xmr:dbXLaH3xsBkdDIen7SukXCOGWzHmJrci8Jh5vawj-d8SAENfRABfEgj9NF6DEt2I3sHWVilwt2sSqovIlEJl8YLc-ytmB2A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegheejfecutefuodetggdotefrod
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
 hmpdhrtghpthhtoheplhhutggrrdgsohgttggrshhsihesmhhitghrohhsohhfthdrtgho
 mhdprhgtphhtthhopehhrghrrhihrdhvrghnrdhhrggrrhgvnhesihhnthgvlhdrtghomh
 dprhgtphhtthhopehsvggrnhdrmhhorhhrihhsshgvhiesihhnthgvlhdrtghomh
X-ME-Proxy: <xmx:dbXLaC_1pnXHemLyOgK6Imp02KNnAZvvYYJ0RUxh9iCMUOmb2-nXfA>
 <xmx:dbXLaHpUP--CtRYCMWPWnEPeogpES7DuiWLfcJ1-H_IlGf3EP7UtfQ>
 <xmx:dbXLaMTD1PEDtRDMhkrUYESCRfFkOPks7s1WuOwcHTExpyy2FXTmrg>
 <xmx:dbXLaKMoy6HwGwpS_cdLPePqpt6Jtd0I2hOIj7j-7iMTK1kU0JnUlw>
 <xmx:drXLaNF9IOfKjpOs5RU9qhoGinYNcrflOgpQ9OXHgjWmV4OzVIN5Fdeh>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Sep 2025 03:32:04 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, stable@dpdk.org,
 Byron Marohn <byron.marohn@intel.com>,
 Yipeng Wang <yipeng1.wang@intel.com>, Keith Wiles <keith.wiles@intel.com>,
 Luca Boccassi <luca.boccassi@microsoft.com>,
 Harry van Haaren <harry.van.haaren@intel.com>,
 Sean Morrissey <sean.morrissey@intel.com>
Subject: [PATCH 1/3] efd: fix AVX2 support
Date: Thu, 18 Sep 2025 09:28:03 +0200
Message-ID: <20250918073135.1273767-2-thomas@monjalon.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250918073135.1273767-1-thomas@monjalon.net>
References: <20250918073135.1273767-1-thomas@monjalon.net>
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
so the checks for AVX2 are simply removed, and the include is added back.

Fixes: 5b9656b157d3 ("lib: build with meson")
Fixes: 30a1de105a5f ("lib: remove unneeded header includes")
Cc: stable@dpdk.org

Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
---
 lib/efd/rte_efd.c     |  3 ++-
 lib/efd/rte_efd_x86.h | 10 ----------
 2 files changed, 2 insertions(+), 11 deletions(-)

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
diff --git a/lib/efd/rte_efd_x86.h b/lib/efd/rte_efd_x86.h
index e2f9dcca88..f7776db8a5 100644
--- a/lib/efd/rte_efd_x86.h
+++ b/lib/efd/rte_efd_x86.h
@@ -19,7 +19,6 @@ efd_lookup_internal_avx2(const efd_hashfunc_t *group_hash_idx,
 		const efd_lookuptbl_t *group_lookup_table,
 		const uint32_t hash_val_a, const uint32_t hash_val_b)
 {
-#ifdef __AVX2__
 	efd_value_t value = 0;
 	uint32_t i = 0;
 	__m256i vhash_val_a = _mm256_set1_epi32(hash_val_a);
@@ -45,13 +44,4 @@ efd_lookup_internal_avx2(const efd_hashfunc_t *group_hash_idx,
 	}
 
 	return value;
-#else
-	RTE_SET_USED(group_hash_idx);
-	RTE_SET_USED(group_lookup_table);
-	RTE_SET_USED(hash_val_a);
-	RTE_SET_USED(hash_val_b);
-	/* Return dummy value, only to avoid compilation breakage */
-	return 0;
-#endif
-
 }
-- 
2.51.0

