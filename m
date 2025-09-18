Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 568ABCAC597
	for <dpdk-dev@archiver.kernel.org>; Thu, 18 Sep 2025 07:32:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EEF494064C;
	Thu, 18 Sep 2025 09:32:16 +0200 (CEST)
Received: from fhigh-a2-smtp.messagingengine.com
 (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
 by mails.dpdk.org (Postfix) with ESMTP id E65274027A
 for <dev@dpdk.org>; Thu, 18 Sep 2025 09:32:15 +0200 (CEST)
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 7E149140023F;
 Thu, 18 Sep 2025 03:32:15 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-12.internal (MEProxy); Thu, 18 Sep 2025 03:32:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1758180735; x=
 1758267135; bh=fmyiU1tvCzC4qA/IaUGri1HFWGkWoFy7SOXNTogJY1I=; b=n
 9r186+T+s/ngFokoaYL2BAjYJShBmbxKjdbkO9C9CqiECNhbt7AR20ojPVzN+3ft
 8SJwGOYVn6yEBSmkQwZ9GIuZLekO3Q2GgJQqlS9gH9dy857t8NNgPwXo4G6AU+dU
 ZiFrxb9jkjS2fX/OZNzfEGx2o/HNHo/p21MrLQc7lrKID8NKcZQMa7pOuotu7ozN
 bPb6MxseBlCOgDpWs7ZlQIf2x27rwD1u5mynO8m54VS1S/2NY5VD58Pc+J1q4B7f
 GEjV601VIujAfTTPSkJ41iirR7kfAf36hTS4PTwiMBJlKlG5bLjHRHFhdqCcGg66
 +4obeNzADBN9ki+3gPUVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm1; t=1758180735; x=1758267135; bh=f
 myiU1tvCzC4qA/IaUGri1HFWGkWoFy7SOXNTogJY1I=; b=oE5RQkddHBAdI6mWN
 d+ZckUVoQIaPscIWkGjGONv7LoyOqAhkRrZzR2DJ9EAaCeYhrBfWA6HNFnVleAs2
 Fsg3Wgy+rCzAYZv2HQ5QK0Oe/Gs8omiTftSVGax+lMXICi3P4O+qU3yYRWvqHRVz
 lxRSgpx5NwmeFhgaf3lHQFnVD6KEI4feagwhVEoJ/zDvE583XwCq+jYT4d5bApYI
 zdl+BMcT752fASwaGGGDk6lOKg34qKMqhzwrUWCg7AxL5kRORWHoZQpI3tpMPPAy
 XXMvEl8eN7SKLOc44B4syGMngTvU4JYvGwqpvOGfGa1DFtKXowOCZA2cK5HMHGUw
 fJKeA==
X-ME-Sender: <xms:f7XLaNSn4SQYAT4dRnuhXjENJnWKnp76tdrbOuoAz-rGBsBSiYIZ-Q>
 <xme:f7XLaBr3H24aQN4rp72Agpqv8P1YLBBW4YGM34f5c_DShRXIemFFc3MNQaAktkrb_
 UAY0RhQkt7CdTqJWg>
X-ME-Received: <xmr:f7XLaKpSxFbTpPu1EwKBPWhtVmv5KeWgkqqBU92mW9qpY3QgExM19IiOOtAiyCyz1zSfsudYBUG4dfiQVcxA3dxAS9HFge4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegheejgecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefvhhhomhgrshcu
 ofhonhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrf
 grthhtvghrnhepvdejhfdugeehvddtieejieegteeuudfgjeeukeeiledthfetveekhefh
 ieelhfdtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
 epthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohepgedpmhho
 uggvpehsmhhtphhouhhtpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpth
 htohepsghruhgtvgdrrhhitghhrghrughsohhnsehinhhtvghlrdgtohhmpdhrtghpthht
 ohephihiphgvnhhguddrfigrnhhgsehinhhtvghlrdgtohhmpdhrtghpthhtohepshgrmh
 gvhhdrghhosghrihgvlhesihhnthgvlhdrtghomh
X-ME-Proxy: <xmx:f7XLaDP8fWKKOcLX8oZblUwwktrSk2NUBLRIqc8Wc2T-PAlviAPDLQ>
 <xmx:f7XLaLxBXrK762CADIPMR_CrvW2kHayL3XA2NK7Lvrp4yCS1UAaYGQ>
 <xmx:f7XLaMsawu_Fi2gBxqTYwgRVfzslimMKvB9JS-LRWyxTwlgTaULG_Q>
 <xmx:f7XLaE4YcoXoA_dGg4Kg8CL1TjG8VPCZ6gn4LpX8YF8wpYYor5FTHA>
 <xmx:f7XLaL5wDmra_qlm8WRiVYPPC-JcmT9QsNpFoN28XsCKR2OcwYUWBz5L>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Sep 2025 03:32:14 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, Yipeng Wang <yipeng1.wang@intel.com>,
 Sameh Gobriel <sameh.gobriel@intel.com>
Subject: [PATCH 3/3] member: hide internal macro
Date: Thu, 18 Sep 2025 09:28:05 +0200
Message-ID: <20250918073135.1273767-4-thomas@monjalon.net>
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

The hash function used by the library is not supposed
to be exposed and be part of the API.

Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
---
 lib/member/member.h     | 9 +++++++++
 lib/member/rte_member.h | 9 ---------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/lib/member/member.h b/lib/member/member.h
index 609b326a8a..96003f7543 100644
--- a/lib/member/member.h
+++ b/lib/member/member.h
@@ -10,3 +10,12 @@ extern int librte_member_logtype;
 #define MEMBER_LOG(level, ...) \
 	RTE_LOG_LINE_PREFIX(level, MEMBER, \
 		"%s(): ", __func__, __VA_ARGS__)
+
+/* Hash function used by membership library. */
+#if defined(RTE_ARCH_X86) || defined(__ARM_FEATURE_CRC32)
+#include <rte_hash_crc.h>
+#define MEMBER_HASH_FUNC       rte_hash_crc
+#else
+#include <rte_jhash.h>
+#define MEMBER_HASH_FUNC       rte_jhash
+#endif
diff --git a/lib/member/rte_member.h b/lib/member/rte_member.h
index 0235bb0a81..6d9740e0f1 100644
--- a/lib/member/rte_member.h
+++ b/lib/member/rte_member.h
@@ -87,15 +87,6 @@ typedef uint16_t member_set_t;
 /** For sketch, use the flag if to count packet size instead of packet count */
 #define RTE_MEMBER_SKETCH_COUNT_BYTE 0x02
 
-/** @internal Hash function used by membership library. */
-#if defined(RTE_ARCH_X86) || defined(__ARM_FEATURE_CRC32)
-#include <rte_hash_crc.h>
-#define MEMBER_HASH_FUNC       rte_hash_crc
-#else
-#include <rte_jhash.h>
-#define MEMBER_HASH_FUNC       rte_jhash
-#endif
-
 #ifdef __cplusplus
 extern "C" {
 #endif
-- 
2.51.0

