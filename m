Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D0C9ECD9A6
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Feb 2026 21:31:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F317F40654;
	Thu,  5 Feb 2026 22:30:59 +0100 (CET)
Received: from fout-a8-smtp.messagingengine.com
 (fout-a8-smtp.messagingengine.com [103.168.172.151])
 by mails.dpdk.org (Postfix) with ESMTP id 864FB4042C
 for <dev@dpdk.org>; Thu,  5 Feb 2026 22:30:58 +0100 (CET)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfout.phl.internal (Postfix) with ESMTP id 3E6A6EC00AE;
 Thu,  5 Feb 2026 16:30:58 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-01.internal (MEProxy); Thu, 05 Feb 2026 16:30:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1770327058; x=
 1770413458; bh=NJUNjwUoEjIN6nMijOx4/Jov/Z+VkknvbLGrbdejKTo=; b=E
 QOvhAtTm0e+Lt7l0LYCJcSVdBKxzW2ehddDeWwTBPmPyAw+r+3g0HO6DisjVnvgo
 eK8DC02hrjK/VLqWeqeoaaiycx7PP7GzTfgHeY1GI1WRT+m5EUV2gJPnxAVMAXVx
 5JdD58Rfnr25xdhWOVoHKvjylxXtmKBltsP/KaxoZ3XdDCuFgWS4NCufm6RVtgzk
 o4a+/2D3R3usUPCIzsQHEbc/Gzx64Y5ulKL3mfN89kLJbG0YP5M0qtD6ttURsl5M
 QDpJCgqXe/q29HrvZbBPyiaCSmtzWYLyqtqQuW58gIfMRI7jBoSScLubRphSQ9T2
 8mnQ9Cbri8yEuqdbdGpKQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1770327058; x=1770413458; bh=N
 JUNjwUoEjIN6nMijOx4/Jov/Z+VkknvbLGrbdejKTo=; b=KYMOhVDJvDsPWur7h
 UNv9AQ+1mh7P6lkIlNqMHIO/c96cRgBKjklKF6UDtFN8QaPHNSRxiSEQZRI4pFjt
 dBWPbB8dfOw5rYOm9PBHPIs6SQ6AfvuBmyX1MOk0doNnT8TrEywMrAsqZdnPUAch
 YGNIKttYmSVqhpnNCiECS0ZzjX3totkJU0mn3kEmwYNl3UQn4xAlgJkxh0APRCf+
 oAa7ZD1poFOSMKmlWAWledYhj64W+CsBdSs6Y3qIhg4Ba1rKQhXHlcYtwIUNCxFL
 48UraTGhC9312CuOzpYIEguxstWY0nuBgphG5/OXMHdmGR/S6Auy9dtoVhgrym7P
 LiVzw==
X-ME-Sender: <xms:EgyFaXKmjf4U3WVeBLPLPrZBgmoNzh7CKls_GVyq08fAuvfRxrm1rQ>
 <xme:EgyFafc1ipB1xQTmbGLaaaekmYMBS8h58k3JtdwcitbFAqYG9O6Z1vk1hZy7Xe6Lj
 0FKfsfulmO1sDM5vBzdu-7gNWOvwRhBhc2oUwyya_tAy580xGX98QI>
X-ME-Received: <xmr:EgyFae2WnYRkLdZhNsRCoLVGRyw1IQcJ8EVn7sQjsINtpXvbiSoaLB754-2fFToNWIzXRZQnTRMjcQRCiofxU0kjzluhgvM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeeifeekucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpedvjefhudeghedvtdeijeeigeetuedugfejueekieeltdfhteevkeeh
 hfeilefhtdenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeefpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtph
 htthhopegurghvihgurdhmrghrtghhrghnugesrhgvughhrghtrdgtohhmpdhrtghpthht
 ohepshihrghlrghvrghrthhhihesmhgrrhhvvghllhdrtghomh
X-ME-Proxy: <xmx:EgyFaYgoAGeYLZu4JXE5dFCAgoqemc2vdIwFzesKlCxx8didia_kNQ>
 <xmx:EgyFaUR6WYGxQREkjos7OORAIOJuRh5L8d2CTWO1dxKs8GzQHazvNA>
 <xmx:EgyFaZiqbA5WefGbsagiqFCNVt658GGt0-GvhB0_O7jFN4Qnj_9_aA>
 <xmx:EgyFaU6uCkTkBkgPnFExxJpW-qR1txHPDHY5lqdxZugyBsNvWyU0ow>
 <xmx:EgyFaeJLddyKU67ER537PBawa4uVO0SqHHqr4D8eS5ylInxNa7g_Onsf>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Feb 2026 16:30:57 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: david.marchand@redhat.com,
	Srikanth Yalavarthi <syalavarthi@marvell.com>
Subject: [PATCH v4 04/11] mldev: fix minsize build
Date: Thu,  5 Feb 2026 22:27:36 +0100
Message-ID: <20260205213044.702908-5-thomas@monjalon.net>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260205213044.702908-1-thomas@monjalon.net>
References: <20210412215339.2439530-1-thomas@monjalon.net>
 <20260205213044.702908-1-thomas@monjalon.net>
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

