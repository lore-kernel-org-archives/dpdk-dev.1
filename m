Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDE8FCA0FED
	for <dpdk-dev@archiver.kernel.org>; Wed, 27 Aug 2025 15:18:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A86B64066C;
	Wed, 27 Aug 2025 17:18:16 +0200 (CEST)
Received: from fout-a1-smtp.messagingengine.com
 (fout-a1-smtp.messagingengine.com [103.168.172.144])
 by mails.dpdk.org (Postfix) with ESMTP id 646B840671;
 Wed, 27 Aug 2025 17:18:14 +0200 (CEST)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfout.phl.internal (Postfix) with ESMTP id 18E1EEC00CA;
 Wed, 27 Aug 2025 11:18:14 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Wed, 27 Aug 2025 11:18:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1756307894; x=
 1756394294; bh=sPZODINQ5BaNQr1D1ZhIdJV48nsavBGoL84X55uqAn4=; b=v
 +iOmpcXoMUEurj3bg5fepboiEss8L8dEALcPPsYB3opOdA8sTLAme8ss7m753PWv
 okJA97A/jYHKliLJSipiUl7ozwljG7OTXYjcSr8QaZh9IOblb/Qu/sCsr4Xzck3z
 IZwSM5DXYXj+xbhybXMY1GswqpMYndr4TSNT05pH6npQBmMIH1XCOus3TO2YvUpi
 boMCk7jJuM4adPLkPCCKGg1c9UP2Ldnd2ShepcBhJAbhaUPTG2sGUqJnkmkVpR/0
 di2FnLUFiuW5OSGsHIb460BaL4QyN9OjQ7SQlLRb7fUBhc+tVC99AekgRz5kPQas
 cH5ZhWQWySK+uOrfBxJkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm1; t=1756307894; x=1756394294; bh=s
 PZODINQ5BaNQr1D1ZhIdJV48nsavBGoL84X55uqAn4=; b=i1MpBljL1Y3f2mF8O
 +MOLf8WQtIuhl59T+ofzfde5MnJXSKPOTaLcgxKs8PkEhM9tzClmqt8+Bj9x2Ydv
 ZQDiwPUOnGy2CstibXSut9WYktvnLRoH9gQLD58IXpdm8qDaFnxKXgiUApSxh2Pb
 yHr36+pI8FRDgghx2FQoUyFnEaY7JsyhzxcO4UZswIOlxU1npn0cevmfQCbfO5fb
 /3OAfQRF0L133owOkzJ3ccH1bgUhdBQN65f+vR1MvURb78jrYGMIFZXnrh/7xKGE
 k/2u0BtcygUGUSSO6BbPrPe+phARJ6ULm9UrS/x6z7cRagX1gb+6P9qm98XtmFpt
 oIofw==
X-ME-Sender: <xms:tSGvaKRDHRMRiSJ3OJTYzi3ql5NcYtq_2y262rzsLZYE50F-sqCWsw>
 <xme:tSGvaNtspFenw0-PZSAv5265l-hCx_6hkVIk0cEWA2QDrzy-0BJNYWoQEnZJ7TEFA
 caQxCJ_iQIjkxAUaQ>
X-ME-Received: <xmr:tSGvaKJcJEZ-HnRtjnkpox9XVZURFdOdmfbe7cpLyMleBuG67aoUyhT3mjtDnnviEqHDGEg-KaZZF6jjgrjVz_dgRYb-dTU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujeekgeelucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpedvjefhudeghedvtdeijeeigeetuedugfejueekieeltdfhteevkeeh
 hfeilefhtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeeipdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtph
 htthhopegsrhhutggvrdhrihgthhgrrhgushhonhesihhnthgvlhdrtghomhdprhgtphht
 thhopehsthgrsghlvgesughpughkrdhorhhgpdhrtghpthhtohepnhhitgholhgrshdrtg
 hhrghuthhruhesihhnthgvlhdrtghomhdprhgtphhtthhopehmrgigihhmvgdrtghoqhhu
 vghlihhnsehrvgguhhgrthdrtghomhdprhgtphhtthhopehhvghmrghnthdrrghgrhgrfi
 grlhesnhigphdrtghomh
X-ME-Proxy: <xmx:tSGvaKlX0LJosknwTFH2A0OA-uuNZA_2JykQkOEPAWUruuFo4amQ5w>
 <xmx:tSGvaLKYMJMIH3ITvlhIJ0RUOAv5EJs6yocwDRG-d0r0Yf-IMXS9QA>
 <xmx:tSGvaP6-btu4w0I7VXxvFon_WdGbxlGIUK7vANLAWLhlZW8DqkCRBw>
 <xmx:tSGvaP2kF9MoCyerKSCs46qXC1BorTXfVXdutnnneiEZwfPZpfGqRw>
 <xmx:tiGvaJTgKe0NKmHlAZr4oDNcakLjjXxlezc9nPkziWbELw510vAHVQsA>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 Aug 2025 11:18:12 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, stable@dpdk.org,
 Nicolas Chautru <nicolas.chautru@intel.com>,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>
Subject: [PATCH v2 3/3] bbdev: wrong fix for MinGW 13
Date: Wed, 27 Aug 2025 17:16:43 +0200
Message-ID: <20250827151759.1448018-4-thomas@monjalon.net>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250827151759.1448018-1-thomas@monjalon.net>
References: <20250813152829.457463-1-thomas@monjalon.net>
 <20250827151759.1448018-1-thomas@monjalon.net>
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

After an upgrade to MinGW version 13, compilation breaks:

In function 'rte_bbdev_queue_ops_dump':
lib/bbdev/rte_bbdev.c:1269:63: error:
	'%s' directive argument is null [-Werror=format-overflow=]
	fprintf(f, "  Enqueue Status Counters %s %" PRIu64 "\n",

The enqueue status string may be null if the index is too high,
because RTE_BBDEV_ENQ_STATUS_SIZE_MAX is defined to include
padding for future enum insertion.
This padding case must be checked
to avoid printing a dump of a non-existing status.

Fixes: 353e3639d458 ("bbdev: add queue debug dump")
Cc: stable@dpdk.org

Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
v2: make status_str variable local
---
 lib/bbdev/rte_bbdev.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/lib/bbdev/rte_bbdev.c b/lib/bbdev/rte_bbdev.c
index e0f8c8eb0d..e76124532d 100644
--- a/lib/bbdev/rte_bbdev.c
+++ b/lib/bbdev/rte_bbdev.c
@@ -1264,11 +1264,15 @@ rte_bbdev_queue_ops_dump(uint16_t dev_id, uint16_t queue_id, FILE *f)
 			dev->data->name, queue_id);
 	fprintf(f, "  Last Enqueue Status %s\n",
 			rte_bbdev_enqueue_status_str(q_data->enqueue_status));
-	for (i = 0; i < RTE_BBDEV_ENQ_STATUS_SIZE_MAX; i++)
+	for (i = 0; i < RTE_BBDEV_ENQ_STATUS_SIZE_MAX; i++) {
+		const char *status_str = rte_bbdev_enqueue_status_str(i);
+		if (status_str == NULL)
+			continue;
 		if (q_data->queue_stats.enqueue_status_count[i] > 0)
 			fprintf(f, "  Enqueue Status Counters %s %" PRIu64 "\n",
-					rte_bbdev_enqueue_status_str(i),
+					status_str,
 					q_data->queue_stats.enqueue_status_count[i]);
+	}
 	stats = &dev->data->queues[queue_id].queue_stats;
 
 	fprintf(f, "  Enqueue Count %" PRIu64 " Warning %" PRIu64 " Error %" PRIu64 "\n",
-- 
2.47.1

