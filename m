Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E967CD5BA3
	for <dpdk-dev@archiver.kernel.org>; Tue, 19 May 2026 10:36:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4D54B40613;
	Tue, 19 May 2026 12:36:53 +0200 (CEST)
Received: from fout-b8-smtp.messagingengine.com
 (fout-b8-smtp.messagingengine.com [202.12.124.151])
 by mails.dpdk.org (Postfix) with ESMTP id 972B740669
 for <dev@dpdk.org>; Tue, 19 May 2026 12:36:51 +0200 (CEST)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfout.stl.internal (Postfix) with ESMTP id E97201D00085;
 Tue, 19 May 2026 06:36:50 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-02.internal (MEProxy); Tue, 19 May 2026 06:36:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1779187010; x=
 1779273410; bh=Pdrnu7d44uhLB80M3M2ShodVHCNFYlt5Ddvq1KDUfXQ=; b=A
 We8vK5kkV4d0Vp78sEZkx7StzmB1TG9DQ2g77hzYkMbX3hxflYp0lTwxTUirA83D
 IVhNRnn1RcQIlVm4UQIZCne/TJxUWd9fDpYXX69BmZarOod2Tx3M8Ke1tDtqCpOH
 WqrfjYQTmPP3gVDugRDFbdnZF+/hUUVkZVQvvY/u1MyQOzmmbL6+iKxGCI9K4wAp
 Y/Vhn5pQEVjoou9+AGfILtAOWAfFSRSWv6UC2z+HQvIl63bBYYdv1Ec6+WpuH/xd
 UaqocUkBdMpIFo4UHI1PIGqdSEnuhFDagWslyiOsL3U8yVeG64JB+hpnQKbcGCWd
 rjxAQ3k8sM638VFyzxz1g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1779187010; x=1779273410; bh=P
 drnu7d44uhLB80M3M2ShodVHCNFYlt5Ddvq1KDUfXQ=; b=PuvfNc+6NRb4Pq2MB
 b4vFkryGe4T8WPvyzLF2evortZcLXyEyOEFjJZ8qH59han/G4HNBgcniwVuYf5AB
 Zg/MCPTH9F+TM/QoTIWwBt5TXg5cnQmcnS+kfdAkhQlfzcI5gu9mX1p0vNlcqJm4
 ENT0Cc39woJb1VyYu1dAXw5Lm88Q9L3A2WugyGlf9PKqVNNjNRyr0B2msrYkwGp6
 0zW3m8ylWM3LfvnzRGs1vCaVyWiIkZYYD8v5RnWcfToSvDTzEJqNwb4RaEC04wfk
 QegrCMgs/4FyD5GBxM8R7+e2Zvff6V4W3oB0AxD7LAi13GeY8gkt06RD3rkHNW9N
 yjZjQ==
X-ME-Sender: <xms:Qj0MavzNJQJjFqElgY9of1zEkgV5tYTDomZEbkQoLzg1nntg-ZlTVw>
 <xme:Qj0MaitqD5xBSWu3PIaAblNOjCMRTro3IH3xZAk0vdh6nT2jyCTScqTYPsMdX4Ia7
 OhdxYui9fLMRUBNM4ePIgmTovvG2dH87hwFS0Eb9BoGTFK8QYAg>
X-ME-Received: <xmr:Qj0Mas3pgf2r7KmwgotnKq2VD7KZ1VQUk2N50LYjc6zGQvBuZjjpt_MaJzBc3a81lkbxHGGXL7-4qM3YZTydo6OURSClvGk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeduheefucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpedvjefhudeghedvtdeijeeigeetuedugfejueekieeltdfhteevkeeh
 hfeilefhtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeehpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtph
 htthhopehsthgvphhhvghnsehnvghtfihorhhkphhluhhmsggvrhdrohhrghdprhgtphht
 thhopehkohhnshhtrghnthhinhdrrghnrghnhigvvheshhhurgifvghirdgtohhmpdhrtg
 hpthhtohepsghruhgtvgdrrhhitghhrghrughsohhnsehinhhtvghlrdgtohhmpdhrtghp
 thhtoheprhhjrghrrhihsehrvgguhhgrthdrtghomh
X-ME-Proxy: <xmx:Qj0Mat-ghxK0felVMAAQEoLofG2MZe9ORyqF6EF5U1AqfyQSlyff8g>
 <xmx:Qj0MatNr7hAB-lQh1gMQASEDX8WDQUmkAFAybprvckOYOdIo2moQAw>
 <xmx:Qj0MaheliFAoQ4V7aq-7e2bEpTlCcZO2wiK7dN0nVicXUg2fUoSXMw>
 <xmx:Qj0MasWxymYoWpxpYldr0isHYK-agq0qNPkvwodADy00n08wKDL6fg>
 <xmx:Qj0Mai6EttjknYn2KuqWrqhDKDveT7VYyDfgypybI88XtAlDO96K6Pmd>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 May 2026 06:36:49 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Robin Jarry <rjarry@redhat.com>
Subject: [PATCH v3 2/3] spinlock: add debug checks in recursive unlock
Date: Tue, 19 May 2026 12:34:15 +0200
Message-ID: <20260519103640.3986710-2-thomas@monjalon.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260519103640.3986710-1-thomas@monjalon.net>
References: <20260504083714.2904729-1-thomas@monjalon.net>
 <20260519103640.3986710-1-thomas@monjalon.net>
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

The recursive unlock assumes that the caller owns the lock.
This behavior will be checked when RTE_ENABLE_ASSERT is on.
There is an additional check for the count which should be positive
if no corruption happened.

Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
---
v3: new patch in the series
---
 lib/eal/include/generic/rte_spinlock.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/eal/include/generic/rte_spinlock.h b/lib/eal/include/generic/rte_spinlock.h
index ffdcb8fa3d..e7cd18a8e2 100644
--- a/lib/eal/include/generic/rte_spinlock.h
+++ b/lib/eal/include/generic/rte_spinlock.h
@@ -21,6 +21,7 @@
 #ifdef RTE_FORCE_INTRINSICS
 #include <rte_common.h>
 #endif
+#include <rte_debug.h>
 #include <rte_lock_annotations.h>
 #include <rte_pause.h>
 #include <rte_stdatomic.h>
@@ -245,6 +246,8 @@ static inline void rte_spinlock_recursive_lock(rte_spinlock_recursive_t *slr)
 static inline void rte_spinlock_recursive_unlock(rte_spinlock_recursive_t *slr)
 	__rte_no_thread_safety_analysis
 {
+	RTE_ASSERT(rte_atomic_load_explicit(&slr->owner, rte_memory_order_relaxed) == rte_gettid());
+	RTE_ASSERT(slr->count > 0);
 	if (--(slr->count) == 0) {
 		rte_atomic_store_explicit(&slr->owner, -1, rte_memory_order_relaxed);
 		rte_spinlock_unlock(&slr->sl);
-- 
2.54.0

