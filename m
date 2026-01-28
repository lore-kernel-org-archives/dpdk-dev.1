Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD935D25B47
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 Jan 2026 12:00:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3780F40670;
	Wed, 28 Jan 2026 13:00:26 +0100 (CET)
Received: from fhigh-a7-smtp.messagingengine.com
 (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
 by mails.dpdk.org (Postfix) with ESMTP id 0111640661
 for <dev@dpdk.org>; Wed, 28 Jan 2026 13:00:25 +0100 (CET)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfhigh.phl.internal (Postfix) with ESMTP id AD8821400183;
 Wed, 28 Jan 2026 07:00:24 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-04.internal (MEProxy); Wed, 28 Jan 2026 07:00:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1769601624; x=
 1769688024; bh=NJUNjwUoEjIN6nMijOx4/Jov/Z+VkknvbLGrbdejKTo=; b=Q
 VAQkJcmGYLvct7L0q6TA6jXWdU2zQBBqFpPcgZbTpj9eb92Nglcejk/UMsm244Ot
 2RZ99+1vu711xY4rT86DeM3m/E4ZXszBgFRJVyBrPML/rre31UQRmfFKNd6Vlr9i
 7uRgXnKZxz/Lof3uUMqDsd0TlAvOz8aDwUvBnii6zoYP65egUuxBwqOqSSBBH5Rb
 zmIOX41bK13ir3NYMYw8FfBvSoB769P39oy9I9RA64AjzhNmSBpwqgD2ChZ8JMcx
 qVQtY6paLIV1cVgoNeJYvrhl52gDwSzagwkJhdFG1ExrcgmAhjaEl0ZzjFVCK6ZY
 w3JUuqNyOaLmyNM0OzAdg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1769601624; x=1769688024; bh=N
 JUNjwUoEjIN6nMijOx4/Jov/Z+VkknvbLGrbdejKTo=; b=oNq4k8QRQbY0e5IqY
 FKxJAu/1sbKQ8j+3ai+wu0M8a9RoBqEeiWC5Yd9jMg10CCPj4ZY9ViGXPpkBIgC4
 f6VCyHbRVc+ihlhXpck0TMzofMoMjwLAZl+HrJT51LVkzhLiN8LgeBYbC5luKhdg
 4khsJL2N7gb3jlL/F3mFS9u3kjePVizY9nKt+9RTRu0XNlp+MQcbcV4Gea6XNOIk
 yQ11dGuifz9MR9BXOzHCtEkWtdxwWf2A4txcmBSAu8ohn6X0EwLQx6XlZUao/0jP
 3QeI6zTTgS+9yEQQKTYltVUFwlPKydA7njQQUtrwL85TBmuyPbMp/0bs8aXSGzDy
 MOR7w==
X-ME-Sender: <xms:WPp5aWQEppHgllMyVbGis9ivjshotBxjwUfYhv7LLaAzXVio84IW4Q>
 <xme:WPp5aQGiaY1hwS_eHd8tFX8qAPLGVot_po379Ph--BmOl_mCoHYCZqWAq4l5emskD
 jDU2ab8d2A10pnGTKMEzNfYNr2-yo1mycjGGUEDNN8rO2pQhdpeJQ>
X-ME-Received: <xmr:WPp5aS-TBzCEFAFXutER0oFiz3IO1OeuPN7aPcQBBG3R67AWcMOfpcsbnMnaSsTV4G2ewOXliT87feNKcuQfs4BMyqIhIF0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduieeffeduucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpedvjefhudeghedvtdeijeeigeetuedugfejueekieeltdfhteevkeeh
 hfeilefhtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeefpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtph
 htthhopegurghvihgurdhmrghrtghhrghnugesrhgvughhrghtrdgtohhmpdhrtghpthht
 ohepshihrghlrghvrghrthhhihesmhgrrhhvvghllhdrtghomh
X-ME-Proxy: <xmx:WPp5aaLcm2TNmKOa6MOwE_2EPbskl3eIBC0qrocgg3HNllc_-e5W_w>
 <xmx:WPp5aVaFbPSZjuaHIGNBAiUjHDuHel9Ac9LQJiPdlvWIaTkbHonzwA>
 <xmx:WPp5aUKNEvoR6HH1bkAOzns3vpmWGWjMiidzgrPWXvYAmI6CPRnthw>
 <xmx:WPp5abDsCAReEtmvkWXjzr4o0dAzND8Z1MTzAE-jQ7DM924TBEC0tQ>
 <xmx:WPp5adzp-b8tW5A3WI4JH_Skn0KWcFMIi9AL1aMPQm3a4_08g5X8FJEv>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Jan 2026 07:00:23 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: david.marchand@redhat.com,
	Srikanth Yalavarthi <syalavarthi@marvell.com>
Subject: [PATCH v4 3/4] mldev: fix minsize build
Date: Wed, 28 Jan 2026 12:58:32 +0100
Message-ID: <20260128120005.2777473-4-thomas@monjalon.net>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128120005.2777473-1-thomas@monjalon.net>
References: <20210412215339.2439530-1-thomas@monjalon.net>
 <20260128120005.2777473-1-thomas@monjalon.net>
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

This error is seen in build of type "minsize":

In function 'rte_ml_dev_pmd_allocate':
lib/mldev/rte_mldev.c:84:16: error:
'dev' may be used uninitialized [-Werror=maybe-uninitialized]
   84 |         if (dev->data == NULL) {
      |             ~~~^~~~~~

It looks to be a compiler issue because we are not supposed
to reach this point without finding a device to assign.

The variable is initialized to allow compiling with "minsize" option.

Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
---
 lib/mldev/rte_mldev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/mldev/rte_mldev.c b/lib/mldev/rte_mldev.c
index f5061f015c..7fae867882 100644
--- a/lib/mldev/rte_mldev.c
+++ b/lib/mldev/rte_mldev.c
@@ -55,7 +55,7 @@ rte_ml_dev_pmd_allocate(const char *name, uint8_t socket_id)
 {
 	char mz_name[RTE_MEMZONE_NAMESIZE];
 	const struct rte_memzone *mz;
-	struct rte_ml_dev *dev;
+	struct rte_ml_dev *dev = NULL;
 	int16_t dev_id;
 
 	/* implicit initialization of library before adding first device */
-- 
2.52.0

