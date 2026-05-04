Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60B54FF885A
	for <dpdk-dev@archiver.kernel.org>; Mon,  4 May 2026 08:37:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5EA9540270;
	Mon,  4 May 2026 10:37:35 +0200 (CEST)
Received: from fhigh-a3-smtp.messagingengine.com
 (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
 by mails.dpdk.org (Postfix) with ESMTP id 9CBAE4026C;
 Mon,  4 May 2026 10:37:33 +0200 (CEST)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 10F91140004B;
 Mon,  4 May 2026 04:37:33 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-02.internal (MEProxy); Mon, 04 May 2026 04:37:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to; s=fm3; t=1777883853; x=1777970253; bh=cnL3rAR4W1DRYjG5Mcw5m
 egV9FnvUYoNJzp37tfEWhA=; b=jSan0xiGsCa1l+GRP+9u4fLwz+wI60xwTJ2PE
 CpGnqNg6t8X1ujFtz2/LyCdezI76l+zN+KKmGM2Xc8b6HIMRuWSGW+vRhKJWDbjq
 2aqw8+vBFiStVUA+/WIYfp6Oh/9LN2cg3Wws+DNwVIpwZlGcF8Sgd3YHJBF6Xj+F
 s9kFAmTiH8W66y2GjMc0ccOX15zI0ANMyb8wtgJ9SEl5ah6jKwahxX0sNHGqalYH
 jGBui60iuDQXvBOIGQh/94/TVnBjyC+/4/RQ2ff0nsMV/DdF0LRWXvL8X/JOQauB
 iwHNiqYSKHOLKSPe/AWKwaoJRL+bBlqNhW3pEb4D5vaZjzR/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
 1777883853; x=1777970253; bh=cnL3rAR4W1DRYjG5Mcw5megV9FnvUYoNJzp
 37tfEWhA=; b=qzx2DLkBeTnsCINYuAZAYTZbMTDOvY6naWhuB62IXWBs5RpWkbr
 hpQRyknGF/V3VOM5Dm9eplui680+yNWQY7jfBbDIKjO6HVSWpm+GSNqdodwr5Tp5
 K2qoPbpmbkRUs7NY153ccNRxfyz0c92D0f0aXoRcy3cCKcnCg0KR/B1qZCh0OD7T
 u1Acwtgh8QRwmmPpW0eGdeTrqtWxKS8pzwFga1wrSOzYsoMH+ItZS2p7Mre1qpvs
 rl/T3Bi9z02g2/Lew5RqTKBUNE8lXmSJaAoUgQ4qEUZ6S//BkXCm//DdRqoZENM+
 /9ggTVeQAVHkUvkJBfZjhOgCB5WzFquB1AQ==
X-ME-Sender: <xms:zFr4aYPSVkYOF1-KcWk2TOnvkH7MFV8q9kVKmdUQg7UUWJcXgL8rmQ>
 <xme:zFr4abRAiGAO55aLIudflEma60BpwRh-iHFyE5-piLki3jwa4p5qjBYEMNYu870AV
 4TaWqcMb4as_zY0AHBJYnjECndn7DD0OfCzv0BKxkRF_559JsmEWA>
X-ME-Received: <xmr:zFr4aSBOFFEI93SHe0lDB3OuTb6eMv31c6wDr9ownBq2G7Cy7GLGRpKhbHBK6kw6K8H9aH2DO4PeBEvjBbg5jtC3aCCeBxg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdelkeefkecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgggfestdekredtredttd
 enucfhrhhomhepvfhhohhmrghsucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhj
 rghlohhnrdhnvghtqeenucggtffrrghtthgvrhhnpeevveefveeiiefhtedukeegkeelie
 egffeukeevudetueffieduveetiedukeefleenucevlhhushhtvghrufhiiigvpedtnecu
 rfgrrhgrmhepmhgrihhlfhhrohhmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpd
 hnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopeguvghv
 seguphgukhdrohhrghdprhgtphhtthhopehsthgrsghlvgesughpughkrdhorhhg
X-ME-Proxy: <xmx:zFr4aSij6WFLoZpOZeFqEEDaFyQcAb1gHTFdEi6IArTli0OaQ6lusA>
 <xmx:zFr4aTNeOeYbKBk0nDR0lzfJVyt9wqlDrByMqfuuDqssjxbKIBlPog>
 <xmx:zFr4ab427cm_W3PbJO-w3KvfdNAOMDBmIjcal3FMGV-LGLQreOcWwg>
 <xmx:zFr4aZ2AHT5oOs1mPIrKRFaP-lDmJF5sgUkQh2w9uzB4OM45G1l5aQ>
 <xmx:zVr4aWKC2WNXECBvVcMmwthtkAXCPqrpz9SO4nQDEltCDpmO0ryfFZrk>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 May 2026 04:37:32 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: stable@dpdk.org
Subject: [PATCH] spinlock: remove volatile qualifier
Date: Mon,  4 May 2026 10:37:14 +0200
Message-ID: <20260504083714.2904729-1-thomas@monjalon.net>
X-Mailer: git-send-email 2.54.0
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

The user and count fields of rte_spinlock_recursive_t
do not need the volatile qualifier
because they are only accessed by the thread holding the lock,
which already provides the necessary memory ordering.

Removing volatile aligns with a C++20 deprecation
for increment and decrement of volatile variables.

This issue was seen with GCC 16 which changes the default C++ version
from -std=gnu++17 to -std=gnu++20.

Fixes: af75078fece3 ("first public release")
Cc: stable@dpdk.org

Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
---
 lib/eal/include/generic/rte_spinlock.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/eal/include/generic/rte_spinlock.h b/lib/eal/include/generic/rte_spinlock.h
index c907d4e45c..19c0e34f0a 100644
--- a/lib/eal/include/generic/rte_spinlock.h
+++ b/lib/eal/include/generic/rte_spinlock.h
@@ -197,8 +197,8 @@ rte_spinlock_trylock_tm(rte_spinlock_t *sl)
  */
 typedef struct {
 	rte_spinlock_t sl; /**< the actual spinlock */
-	volatile int user; /**< core id using lock, -1 for unused */
-	volatile int count; /**< count of time this lock has been called */
+	int user; /**< core id using lock, -1 for unused */
+	int count; /**< count of time this lock has been called */
 } rte_spinlock_recursive_t;
 
 /**
-- 
2.54.0

