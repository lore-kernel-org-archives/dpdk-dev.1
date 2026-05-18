Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BD13CD4F49
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 May 2026 15:08:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2C3124064F;
	Mon, 18 May 2026 17:08:35 +0200 (CEST)
Received: from fhigh-a4-smtp.messagingengine.com
 (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
 by mails.dpdk.org (Postfix) with ESMTP id E42BE40652;
 Mon, 18 May 2026 17:08:33 +0200 (CEST)
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 6D436140009C;
 Mon, 18 May 2026 11:08:33 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-09.internal (MEProxy); Mon, 18 May 2026 11:08:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1779116913; x=
 1779203313; bh=V/Uw+a6/gfPv5OK+QnjDswmJPZDHcYYEEKg+wKP8YuY=; b=g
 MSLLCFeuvZ0UrcQDuQXtqc4jVRtuqAYMpddFQNM7oNM9yuFV9spLjgErciUhQrg5
 FAEA2RxiZaY5j5weM9ED7DNtir9AWyG+7UHKpM8Dfhjpy6nujzxLEp1RMsVWOB1W
 zQvLC1uR5L+H2KxAwqKSxnRnVenFVhnARdW8/4XCBe6sJNgngiLOWvyODoxpzOmL
 BmgYyQMYmNp6UaQpKnsZE35/UZ/TLX04ko6IGPyAfW+wxffDX+OuKFrrdtD0BdGJ
 j96/lghP7Yrn/7abVaeT3VCnNiykDrzS1TERaZzC1/YTrd0BE9aZmaGWYmxjujrT
 iY2D0ihDGKre+JAFB406w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1779116913; x=1779203313; bh=V
 /Uw+a6/gfPv5OK+QnjDswmJPZDHcYYEEKg+wKP8YuY=; b=Xi4X03AYMz2tbLTf1
 x+jPaETfri95MKXH7NXHkwFAbb2KJb/KUMbgb4OHl52uIL7xI4ByuC75qdAAjNpn
 gs5siFF5Jcgq9hVjZkj8TAcY6M9m7sqbY7TTTMiQZiIj8T3G7ih9XWmawzhZBOar
 w6W1qeI2EeuTYMOB4h9DIF88qeklhaxi7Wsve6UF3B7eqPksK7hrJPbwgQ2OWIRy
 +g/K79/Ur2UXJUXPu8y4vBVrwRS9RcrGcP1cozxOS1uxNoIHSCvoXGBmCUBZ8UV6
 uvoRhp1aihM+4kJYkwZwDu00MWm8suQ4tu9+J/wvL/ctF8tWxJS4TtXREsFtH750
 k42Mg==
X-ME-Sender: <xms:cSsLamyTw4JASyPuHk2UTmU26N273yRFf7waBFoQTXlN8Q4S43ECSg>
 <xme:cSsLasUslkUCW7EPEJS-Fk1IbL1LlRSJysW-M2HpsLOyQLl6clElYm6hmLVK7DfJC
 IB2fO7xoD0oPGBZcOu0n19ZPEwlDCdFDU-V-YLNHKkvfnPBk_iY_Q>
X-ME-Received: <xmr:cSsLaoNpoBwoOwsPrgW9ndtedJn3A9QiEN8xCqfdLUyb6KOyw_xtSgbdCh_FFocTjHFvPWcK31UzprHZ6Iy9VYLnS1o6OEE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddufeeludelucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpedvjefhudeghedvtdeijeeigeetuedugfejueekieeltdfhteevkeeh
 hfeilefhtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeekpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtph
 htthhopehsthgvphhhvghnsehnvghtfihorhhkphhluhhmsggvrhdrohhrghdprhgtphht
 thhopehkohhnshhtrghnthhinhdrrghnrghnhigvvheshhhurgifvghirdgtohhmpdhrtg
 hpthhtohepsghruhgtvgdrrhhitghhrghrughsohhnsehinhhtvghlrdgtohhmpdhrtghp
 thhtoheprhhjrghrrhihsehrvgguhhgrthdrtghomhdprhgtphhtthhopehsthgrsghlvg
 esughpughkrdhorhhgpdhrtghpthhtohepohhlihhvihgvrhdrmhgrthiiseeifihinhgu
 rdgtohhmpdhrtghpthhtoheptghunhhmihhnghdrlhhirghnghesihhnthgvlhdrtghomh
X-ME-Proxy: <xmx:cSsLauCZRbyqjeU9J3WMkODxGRDAFzUI53oyF6fpI77-THJhWKSjUQ>
 <xmx:cSsLaleC7l-lCCRTe1a2eo9ScFhq6cpcmEw9eNe_9fO4co5T6ZjLkg>
 <xmx:cSsLatPGxDC_miv-kbAUNXlIcsxxRSrx8QmGGW2E23y0QS3wIkEqAQ>
 <xmx:cSsLalLILPvihvf9HdTiWCywn7SWACot5ze_0nu0FqyXBaVGZSyDYQ>
 <xmx:cSsLasxBrLZXCKMyFYFaAKQIOiNxDoyu9FW033nedGILOtChRa9cdSU0>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 May 2026 11:08:31 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Robin Jarry <rjarry@redhat.com>, stable@dpdk.org,
 Olivier Matz <olivier.matz@6wind.com>,
 Cunming Liang <cunming.liang@intel.com>
Subject: [PATCH v2 2/2] spinlock: fix API comments
Date: Mon, 18 May 2026 17:07:36 +0200
Message-ID: <20260518150819.3332628-2-thomas@monjalon.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260518150819.3332628-1-thomas@monjalon.net>
References: <20260504083714.2904729-1-thomas@monjalon.net>
 <20260518150819.3332628-1-thomas@monjalon.net>
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

This is not a read-write lock.

The user field stores the thread ID, not the core ID
since a change in DPDK 2.0.0.

The implementation is architecture-specific in some cases only.

Fixes: ca2e2dab079a ("spinlock: support non-EAL thread")
Fixes: af75078fece3 ("first public release")
Cc: stable@dpdk.org

Reported-by: Stephen Hemminger <stephen@networkplumber.org>
Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
---
 lib/eal/include/generic/rte_spinlock.h | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/lib/eal/include/generic/rte_spinlock.h b/lib/eal/include/generic/rte_spinlock.h
index 5d810b682a..5c46a7a90f 100644
--- a/lib/eal/include/generic/rte_spinlock.h
+++ b/lib/eal/include/generic/rte_spinlock.h
@@ -7,12 +7,16 @@
 
 /**
  * @file
+ * DPDK spinlocks
  *
- * RTE Spinlocks
+ * This is an API for spinlocks.
+ * This kind of lock simply waits in a loop
+ * repeatedly checking until the lock becomes available.
  *
- * This file defines an API for read-write locks, which are implemented
- * in an architecture-specific way. This kind of lock simply waits in
- * a loop repeatedly checking until the lock becomes available.
+ * Some functions may have an architecture-specific implementation
+ * if RTE_FORCE_INTRINSICS is disabled.
+ * The hardware transactional memory (lock elision) functions have _tm suffix
+ * and are implemented in architecture-specific files.
  *
  * All locks must be initialised before use, and only initialised once.
  */
@@ -197,7 +201,7 @@ rte_spinlock_trylock_tm(rte_spinlock_t *sl)
  */
 typedef struct {
 	rte_spinlock_t sl; /**< the actual spinlock */
-	RTE_ATOMIC(int) user; /**< core id using lock, -1 for unused */
+	RTE_ATOMIC(int) user; /**< thread id using lock, -1 for unused */
 	int count; /**< count of time this lock has been called */
 } rte_spinlock_recursive_t;
 
-- 
2.54.0

