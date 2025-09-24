Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 096A9CAC5AE
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Sep 2025 15:46:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2A51140B8D;
	Wed, 24 Sep 2025 17:46:55 +0200 (CEST)
Received: from fhigh-b5-smtp.messagingengine.com
 (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
 by mails.dpdk.org (Postfix) with ESMTP id 936BD40A8A
 for <dev@dpdk.org>; Wed, 24 Sep 2025 17:46:53 +0200 (CEST)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 040F57A01AE;
 Wed, 24 Sep 2025 11:46:52 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Wed, 24 Sep 2025 11:46:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1758728812; x=
 1758815212; bh=OlNwW43vz7u8c/rPwOemiQSIytQfPHMP2QwdNEBpSrY=; b=L
 buDZgkWXxD6mIb7gA2NVmlaj6698SwjoxfhxyPO3Fd2/oRhBL+V3kKTwwDZP0MlR
 0+aN5LcYo+nu1gmW/o/cRp+u1Z0QG00LhtcFJPYqn8aRcpXfmCPS0C4agmzDpYLN
 sDMSNS1VVH6GlVzHOCd0vtRMI+GmLOIW7qS/FxfL9DoVap0nDjZ2yWUONjUimbND
 bJF3ygFlBFlxw2XrHdllwDokC+F+a2uNNcLBWZtDkDMqAsUEpW/93g5fpakOIQtd
 QUrrDxL3a75s7wORNA6+iue96b5xRJENna265lQYOaWdMe/sZDdkLKDWQcqbAAYZ
 ZE0sXy+y5VnPGbzahIcng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm1; t=1758728812; x=1758815212; bh=O
 lNwW43vz7u8c/rPwOemiQSIytQfPHMP2QwdNEBpSrY=; b=XTFLJnxP5tkjy1C/7
 /47uBBh+QLFW4179ME+0HgDNI/ll9bq2V1SCJ12ddvjUYT/L7VZHq+ISgz+J8LXR
 hmsCe8NfBIBu/QTYpomebFmYvcY5vcxoiqsYLbxEJRCmRaEXebT9JO4nza+7YQtG
 Rr4IkSxEsTukG50qsTjdzcLJGYWYux6v22KFpSBVXMlJ2XJGNOuV+2kro+pE77ki
 BihnpqT8yb1JGTjiTxihjfewZ+R0UNO9AFkTWiYS7gBDhnPCaLvnEzy10VjX2Zdz
 qeaXSmCsU9Sq9hICV1Zsji4jyuy3HYoKjcJFonA+mcTTpIdENz61duex0B2raAHm
 S61wg==
X-ME-Sender: <xms:bBLUaMTZuVgdIB0J69Cv94xv5lydNlOOh1JDy6TjaoQ6wbbgJIn5_w>
 <xme:bBLUaJ5RCYTUa396lhYm-ao4p3mbVNeKsQJ4-DFbSmTQEaqxv_6b3uWk3XmqPmPC8
 P0tdjCa1sN-rIM8OtrBMLbzRDRPgK8ZADULWS0ooaxrk_RMlBOuXA>
X-ME-Received: <xmr:bBLUaBy-xkZ3rvfq4bBFVSLVjrMPLhpoFaCRK1VIYO03XjBdibVTk-R3eR7RQ3NcS53ZL3yB2fP-iJU5MfJnANn3hwSGzvI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeigedttdcutefuodetggdotefrod
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
X-ME-Proxy: <xmx:bBLUaITaap5QxICHgotI-s153cCeSnZWYDu73JgZiAOQlL5JyUzMIw>
 <xmx:bBLUaAWwa8twUTfWnqWbPjfseoPlT678AIuYIMz8dP4pfzHe87s6KA>
 <xmx:bBLUaCZ-utDka3HwmxAKCj-qsmIGiyO6OUYnvWMarAewryH_s0PIXA>
 <xmx:bBLUaO0PB1l7ihiDH1xlhe1A1Jli54_UD3QuT1TKBSpGhCrWYbdTMQ>
 <xmx:bBLUaKDBaEuv9-GBhx_Rrzzn8ZNNifQtjrJSsevsBJ6kIHt8ZJ9C4pR->
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Sep 2025 11:46:51 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, Yipeng Wang <yipeng1.wang@intel.com>,
 Sameh Gobriel <sameh.gobriel@intel.com>
Subject: [PATCH v3 2/2] member: hide internal macro
Date: Wed, 24 Sep 2025 17:43:18 +0200
Message-ID: <20250924154641.2684705-3-thomas@monjalon.net>
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

The hash function used by the library is not supposed
to be exposed and be part of the API.

Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
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

