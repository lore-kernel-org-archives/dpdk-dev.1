Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD457FF885A
	for <dpdk-dev@archiver.kernel.org>; Mon,  4 May 2026 09:13:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E696F4026C;
	Mon,  4 May 2026 11:13:14 +0200 (CEST)
Received: from fhigh-a3-smtp.messagingengine.com
 (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
 by mails.dpdk.org (Postfix) with ESMTP id AEFA04014F
 for <dev@dpdk.org>; Mon,  4 May 2026 11:13:13 +0200 (CEST)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 3160D14000F6;
 Mon,  4 May 2026 05:13:13 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-03.internal (MEProxy); Mon, 04 May 2026 05:13:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1777885993; x=
 1777972393; bh=Qu/UnC+03JoQ9qeQ12tToyhV5PZ7zYQqHfchr5OZymQ=; b=X
 lXQJmFjEx1zVYw5/txNFDhL7Zp1Zh+8ma2Eyt0l9YKXYq3NAFyhh/HY+S0OefY/F
 SEeFTFyXzYUVoUST8TceDeb3zlvD9dtf0hi85d585D7BKUt/ybGj5WTqDAmCc6De
 +LueFn7QsZBcnC48rmZg4YV3yLP7vjBLtlSEx6Ka6QdPhaZWDF2EGkuFHGSAx7gW
 8PRWVYxYIXfSD1Cl7pKRUSvF5iW+J2nlU3uDIpNknu+/eQ1g39AFZoXwTXKKz905
 CA/72R1PGl4n4U+vV+1s7YZ2iuleaa+WynInzlB6WNf5rJoArUbME10QwiE+jdEw
 xnTba3IjV+VC599M/5OiQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1777885993; x=1777972393; bh=Q
 u/UnC+03JoQ9qeQ12tToyhV5PZ7zYQqHfchr5OZymQ=; b=Nn4fi1OT+84Z7hd9M
 9wgyNL96bwtWmU4AmSksVrEJOVF9pZDVgvmqtXLMGiLOEe6qAYyjRfZsqkEUEzcu
 N1asOeNqmTqNYbe7A/WP3BKhscLgu/pACtFk196Wha4P/Lxx68C23+fMzi4fEKcq
 qf5KgkZTgo7a8bYEZiU6g2mhybhVRoI9qVyMklhzAbClsvP7JwsgTzQrgci7SbFa
 daFXV2U4vwu9La0VGOgi6gqXezzdvYOLmRR09Ldj94ezhiT9nzZ8NfSSU3qmJU/o
 BcJul6KJEg5Jrn1GRciMgwrRnHMV8o6r4ym92uGAwzy7hnrMhytOJyG3+H8hLJK2
 Q+sag==
X-ME-Sender: <xms:KGP4aSVAoX2uHDRIUFLtbz7jjdeAfVTJNxZQEUdEUBCCBJUNUgWd4g>
 <xme:KGP4aa56EFfoUX6eryyHiNBHWCpw8BhnyHWwiDky059RkCY13iRfImW8eRcl7I6pl
 AnDLmmVvhXOoC3el6NQIDQprwYwW2nmyK84yBuZA83MyAt5Q0LH-w>
X-ME-Received: <xmr:KGP4aZKZo-us8OkMJIQ569JG2tCuSBaNzGJfu4tXlS3BpCOE-tqfLQaE3EzqBPk9VND459tXkLoRNK0P5XuSm3pl6O4W-90>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdelkeeghecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefvhhhomhgrshcu
 ofhonhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrf
 grthhtvghrnhepvdejhfdugeehvddtieejieegteeuudfgjeeukeeiledthfetveekhefh
 ieelhfdtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
 epthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohepvddpmhho
 uggvpehsmhhtphhouhhtpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpth
 htohepshhtvghphhgvnhesnhgvthifohhrkhhplhhumhgsvghrrdhorhhg
X-ME-Proxy: <xmx:KWP4abIuzVdeZloRSVMi_tGOryYkbOcifDC5gBJ2dAy1aV7cGavnSA>
 <xmx:KWP4afXDsVZC8FSI0lXcw04spBNP97wFbLof4YF5ZODPgF4Yv-DdyQ>
 <xmx:KWP4aVjWdOMXXXbKV3bNFCDP5H4bdqDIJotdRE2aGN6Vg5uanaIS7Q>
 <xmx:KWP4aS_ROKSIrCodq75alEBQKMAuZhOH5X5Uy6Sx_TEbwjaTfpsJFw>
 <xmx:KWP4aU0s0gpUk7xll1cKPSmdX6E64Yz-uC7C6RRgBJIH9MozkfTJ8yKH>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 May 2026 05:13:12 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH] spinlock: fix API comments
Date: Mon,  4 May 2026 11:12:51 +0200
Message-ID: <20260504091251.2926887-1-thomas@monjalon.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <6261630.31tnzDBltd@thomas>
References: <6261630.31tnzDBltd@thomas>
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

The user field stores the thread ID, not the core ID.

The implementation is architecture-specific in some cases only.

Reported-by: Stephen Hemminger <stephen@networkplumber.org>
Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
---
 lib/eal/include/generic/rte_spinlock.h | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/lib/eal/include/generic/rte_spinlock.h b/lib/eal/include/generic/rte_spinlock.h
index 19c0e34f0a..d9f255f8c4 100644
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
-	int user; /**< core id using lock, -1 for unused */
+	int user; /**< thread id using lock, -1 for unused */
 	int count; /**< count of time this lock has been called */
 } rte_spinlock_recursive_t;
 
-- 
2.54.0

