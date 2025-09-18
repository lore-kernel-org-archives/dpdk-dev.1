Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09863CAC59F
	for <dpdk-dev@archiver.kernel.org>; Thu, 18 Sep 2025 09:11:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CA50B40691;
	Thu, 18 Sep 2025 11:11:01 +0200 (CEST)
Received: from fout-a4-smtp.messagingengine.com
 (fout-a4-smtp.messagingengine.com [103.168.172.147])
 by mails.dpdk.org (Postfix) with ESMTP id CBF4F4067D
 for <dev@dpdk.org>; Thu, 18 Sep 2025 11:11:00 +0200 (CEST)
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
 by mailfout.phl.internal (Postfix) with ESMTP id 83F92EC034D;
 Thu, 18 Sep 2025 05:11:00 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-07.internal (MEProxy); Thu, 18 Sep 2025 05:11:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1758186660; x=
 1758273060; bh=OlNwW43vz7u8c/rPwOemiQSIytQfPHMP2QwdNEBpSrY=; b=A
 yDwIYBFOAV+9AJQarKNxATvj5NfPiQ++CVjDJqQSh7kyL4ZqTGBTDXim9hGr6CAv
 GgcT1ZKOD0iHBb9xcOAmH1b5sp0laoixT5RfY9LiPJvv092PMvE69uyH3ISnbgKK
 HlSkda5YhjGzXxUdLiWlwl7Qdme7LPRsEVgQ7JNzzqyR+b1pk85wj3+iwE6QNWUl
 e3Ylf6qCXZ/BicU5un9k+XF2/54VPfUFFYj5EwQXUHGPwsw0q45JYonDlabO/NhH
 5bc1BjOcaRuJvKWt/fBzwIRJPjn5kXckUW2C8DPz9xSoXbjwkSpb+L23/NkkLV9C
 uwrH0F+oLM08lxUysL8+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm1; t=1758186660; x=1758273060; bh=O
 lNwW43vz7u8c/rPwOemiQSIytQfPHMP2QwdNEBpSrY=; b=BpIod0C0jSNHIZvwB
 lKRZHmSEcwYL+EeZ+F62jQwjoHyhDdX841REEYrkeUR+OFfZKSRMYXusA7kmGlqq
 RnB4I4/SKr6l71//j//wdLpDl5vlKRdoxGiUBSIZZYk946wpgf8wSQfFVbLYN4Rx
 taARdHRNk9qOFxQtkuIqtO7qWJaX0bcJJyj0/qcpEfJWS9mkcbelh2gUyeot2g6r
 lxV3ZQ4IbWW0Pr9bsO6lBZ28Xnki1JECEpj7xFlQR93XgioxdiLR/aPOQ9rsLBQf
 ESdQaQIfkn0qjAFBHzY/X4zRMea7jAjX6F1P9i1WsHcUxCRuvQmUyiXg0sxfMTad
 SqLJg==
X-ME-Sender: <xms:pMzLaGZRfjl0TejxGUmHVR4I-S28FS69ZJHiN5UkefdpKTAP19qKiw>
 <xme:pMzLaAYNIdmBdnpUFSsW9SGYmXj9iDgQzkvtKHmgmjYjCPJ_Dgr0rMk5oZjr826cj
 nj5eyf5vuCZvsmvIw>
X-ME-Received: <xmr:pMzLaF_9N8jRURIGSs6V_m_NUhvqz7TidIwD5dYED9s3dpoOkiWKM3FGPhzh6y-coViTX3RIzOhg8iPx8y4SUM9WsC0GTEM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegheelfecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:pMzLaHhJLlysLx9-qI7TTJ5T5lRRHwlNSYX4p6A2Fojc1-Y7I0ZzLw>
 <xmx:pMzLaNdNmE3IVyOhbFi8pxT5awa5o78bliWaRazXRlxRQZ3vW7yKtA>
 <xmx:pMzLaGqckmLCPgwoKtfgSvOMIo0CLPJtO_k4ZJG83YYIEbu3KArX6Q>
 <xmx:pMzLaKDollZHNzvpUfVxmr41OdcQZUviIn41BwDlKFw154lRHrmgpA>
 <xmx:pMzLaO2GpzCX--seNPXYGzXNhGcADbZLCk06pESdEy97H3YZ9v8U2fgC>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Sep 2025 05:10:59 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, Yipeng Wang <yipeng1.wang@intel.com>,
 Sameh Gobriel <sameh.gobriel@intel.com>
Subject: [PATCH v2 4/4] member: hide internal macro
Date: Thu, 18 Sep 2025 11:08:10 +0200
Message-ID: <20250918091039.1368875-5-thomas@monjalon.net>
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

