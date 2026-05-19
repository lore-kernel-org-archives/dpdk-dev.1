Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5AD7CD4851
	for <dpdk-dev@archiver.kernel.org>; Tue, 19 May 2026 10:36:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E6A61402C8;
	Tue, 19 May 2026 12:36:49 +0200 (CEST)
Received: from fout-b8-smtp.messagingengine.com
 (fout-b8-smtp.messagingengine.com [202.12.124.151])
 by mails.dpdk.org (Postfix) with ESMTP id 5613140296;
 Tue, 19 May 2026 12:36:48 +0200 (CEST)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfout.stl.internal (Postfix) with ESMTP id 5C09E1D000BB;
 Tue, 19 May 2026 06:36:47 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-03.internal (MEProxy); Tue, 19 May 2026 06:36:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1779187007; x=
 1779273407; bh=nfj4QN5X8p5rCPyMErvHW0goMC9aLOEBp+9HhG6ikyo=; b=a
 RKG/yA5oSBBexV8hjj9LMBCLTXbOoHpMzyYzRMH+pRzrp823ixGrLIHET6ywyQQF
 9u2r3xPCMisd2Rwqvgku/k9qaBgEMPJRVMnrSTDjPiMjkY8acfyb4JThqmxAyVtN
 L3eNXqKUnLaVfdIwdLLKZhzMEz2Zn70NQeqZyg3l9goxpZSF6VhcuZHoyfW5zNm3
 VuGSj13isOxNCgJuBO9iPGbKq/ce15spr4ZIkEmqKDLkHpQ+QB37LBezN3wRpnPH
 /9MrJHkSz2LF0B4+8nzZeMJ9Wk0JJPRa21Wbs2GLLGAXByc27OZESv/S4VET+RaK
 ZAhleHYw8eNoH591CP80w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1779187007; x=1779273407; bh=n
 fj4QN5X8p5rCPyMErvHW0goMC9aLOEBp+9HhG6ikyo=; b=B6v8OS1Xpqs/YM2+Q
 Ts6/KitYJtJ2bTopZylPKpvNi+Lh4ayc1SNELTbdRPna0aZ3lnLKuuLwdaJUuvZr
 +skWzLyATzuB3r5u4A4YD1yz142qkoJiJII1/mm6h+vevNujIvvpLb3/lQXuYolM
 S6J1Mq7yA12sOu3exb9APwcDRB8uNqGetHRBQqKkLyhNFi28EUtMARgyNl9JXHEB
 mNlYgNSO9gVoPzv8FC0vl9ZXUBDEx+KdOaXRoYR1lK35ICFa4BctoEwlKIrGHgNi
 tBylExRrDyT9zpxEbT/3tQLdApQuZDXRyiEd18UZKXQ6TbFTdDDO0beec1NNLTBr
 nO0+Q==
X-ME-Sender: <xms:Pj0MasdRh0dP42UBWrBUXGbKWlKGZrpdNedlkcBbYc_OrNygO5JPhw>
 <xme:Pj0ManL1hgH6ZeazfMW3eJNofD7_fsLDclSSrGyhX6TSD5dMskSuBD3MKa014EK_0
 0cPQKDiekPr4mup4sjtSoQ544vsjfNPXQ4d1CpgcXv0YlMKDULK>
X-ME-Received: <xmr:Pj0MapE1TF7d57Z-0aRaM-j24yt0mFgSw_kipmCY0xYXhePXNI6JgfUdOF0Qyxxes3TY7KesqQ9jvQQKa3mlrvU1Ho5qRFU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeduheefucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpedvjefhudeghedvtdeijeeigeetuedugfejueekieeltdfhteevkeeh
 hfeilefhtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeeipdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtph
 htthhopehsthgvphhhvghnsehnvghtfihorhhkphhluhhmsggvrhdrohhrghdprhgtphht
 thhopehkohhnshhtrghnthhinhdrrghnrghnhigvvheshhhurgifvghirdgtohhmpdhrtg
 hpthhtohepsghruhgtvgdrrhhitghhrghrughsohhnsehinhhtvghlrdgtohhmpdhrtghp
 thhtoheprhhjrghrrhihsehrvgguhhgrthdrtghomhdprhgtphhtthhopehsthgrsghlvg
 esughpughkrdhorhhg
X-ME-Proxy: <xmx:Pj0MaiBWsLXq8IBP8hLgyibVdXMU9ysKBfm6pw3OnduR6yBWiwKmXw>
 <xmx:Pj0Mak_GuDcInfz6NPWun4F5E8G3Nb29OouTp811vHggJqZLrIp3fw>
 <xmx:Pj0MamDZmPIeOM1sSFn6le1NEG4sR0r80I-SfjE1XyX4qpOUNfpw7g>
 <xmx:Pj0MahSdVqlth7IiHdPFhNOue3WPJTNK02BURBfDJNhrCrfBXejhbQ>
 <xmx:Pz0MasOnhS3bthZvlthpkyMzY2YTqNpoT9MmCswpP43pP0xKCzTO6stl>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 May 2026 06:36:45 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Robin Jarry <rjarry@redhat.com>, stable@dpdk.org
Subject: [PATCH v3 1/3] spinlock: remove volatile qualifier
Date: Tue, 19 May 2026 12:34:14 +0200
Message-ID: <20260519103640.3986710-1-thomas@monjalon.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260504083714.2904729-1-thomas@monjalon.net>
References: <20260504083714.2904729-1-thomas@monjalon.net>
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

When compiling with C++20 standard requirement (default in GCC 16),
the increment and decrement of volatile variables are rejected:

rte_spinlock.h:241:14: error:
	'++' expression of 'volatile'-qualified type is deprecated
rte_spinlock.h:252:21: error:
	'--' expression of 'volatile'-qualified type is deprecated
rte_spinlock.h:278:14: error:
	'++' expression of 'volatile'-qualified type is deprecated

The count field of rte_spinlock_recursive_t
does not need the volatile qualifier
because it is only accessed by the thread holding the lock,
which already provides the necessary memory ordering.

The user field can be accessed outside of the lock,
so it must handled as a C11 atomic variable.
The name is also changed from user to owner.
It will break if an application is accessing this field directly,
which should never happen.

Fixes: af75078fece3 ("first public release")
Cc: stable@dpdk.org

Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
---
v1: drop volatile keyword
v2: make user an atomic variable
v3: rename user as owner
---
 lib/eal/include/generic/rte_spinlock.h | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/lib/eal/include/generic/rte_spinlock.h b/lib/eal/include/generic/rte_spinlock.h
index c907d4e45c..ffdcb8fa3d 100644
--- a/lib/eal/include/generic/rte_spinlock.h
+++ b/lib/eal/include/generic/rte_spinlock.h
@@ -197,8 +197,8 @@ rte_spinlock_trylock_tm(rte_spinlock_t *sl)
  */
 typedef struct {
 	rte_spinlock_t sl; /**< the actual spinlock */
-	volatile int user; /**< core id using lock, -1 for unused */
-	volatile int count; /**< count of time this lock has been called */
+	RTE_ATOMIC(int) owner; /**< core id using lock, -1 for unused */
+	int count; /**< count of time this lock has been called */
 } rte_spinlock_recursive_t;
 
 /**
@@ -215,7 +215,7 @@ typedef struct {
 static inline void rte_spinlock_recursive_init(rte_spinlock_recursive_t *slr)
 {
 	rte_spinlock_init(&slr->sl);
-	slr->user = -1;
+	rte_atomic_store_explicit(&slr->owner, -1, rte_memory_order_relaxed);
 	slr->count = 0;
 }
 
@@ -230,9 +230,9 @@ static inline void rte_spinlock_recursive_lock(rte_spinlock_recursive_t *slr)
 {
 	int id = rte_gettid();
 
-	if (slr->user != id) {
+	if (rte_atomic_load_explicit(&slr->owner, rte_memory_order_relaxed) != id) {
 		rte_spinlock_lock(&slr->sl);
-		slr->user = id;
+		rte_atomic_store_explicit(&slr->owner, id, rte_memory_order_relaxed);
 	}
 	slr->count++;
 }
@@ -246,10 +246,9 @@ static inline void rte_spinlock_recursive_unlock(rte_spinlock_recursive_t *slr)
 	__rte_no_thread_safety_analysis
 {
 	if (--(slr->count) == 0) {
-		slr->user = -1;
+		rte_atomic_store_explicit(&slr->owner, -1, rte_memory_order_relaxed);
 		rte_spinlock_unlock(&slr->sl);
 	}
-
 }
 
 /**
@@ -266,10 +265,10 @@ static inline int rte_spinlock_recursive_trylock(rte_spinlock_recursive_t *slr)
 {
 	int id = rte_gettid();
 
-	if (slr->user != id) {
+	if (rte_atomic_load_explicit(&slr->owner, rte_memory_order_relaxed) != id) {
 		if (rte_spinlock_trylock(&slr->sl) == 0)
 			return 0;
-		slr->user = id;
+		rte_atomic_store_explicit(&slr->owner, id, rte_memory_order_relaxed);
 	}
 	slr->count++;
 	return 1;
-- 
2.54.0

