Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA336CCD185
	for <dpdk-dev@archiver.kernel.org>; Mon, 13 Oct 2025 21:20:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 058AC4064C;
	Mon, 13 Oct 2025 23:20:34 +0200 (CEST)
Received: from fout-b6-smtp.messagingengine.com
 (fout-b6-smtp.messagingengine.com [202.12.124.149])
 by mails.dpdk.org (Postfix) with ESMTP id 35C0740649
 for <dev@dpdk.org>; Mon, 13 Oct 2025 23:20:33 +0200 (CEST)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfout.stl.internal (Postfix) with ESMTP id 8AAD51D000CA;
 Mon, 13 Oct 2025 17:20:32 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-05.internal (MEProxy); Mon, 13 Oct 2025 17:20:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1760390432; x=
 1760476832; bh=S8HZcsTbrH5lG1POubh+56/8oulOXfugHauOTy6xObA=; b=F
 GyuYJAy+LwkI6vI9hovZ4hjvg3yjriY8fuHxupTPTJnB4LfEYNIp4oyqgqzHrFW2
 9Ut+9n4vWtGyQF7Rm2vktGXlv0M5fEk2tw5bYmBU21X/pquHOk6idJeevtq5YRiO
 6rbx21ojd7gU7qme7Lv8UYkhVZ+au8DFd3uK7I4bhKcgloup5+hgm+vPoVH7OsbG
 9iOYzg4McwZYo1yKZZLSgxYAAEeF/Rvga3qR85IjS7W7YLa+i7GYKc13NYwWfHk/
 4/sFAN99azfnbOwKGCg67GRaFyAOacuNxmaFExBKpUn4Pcwt4j5zTMuWE6WSRw6u
 fmjOPstPcPoUKqh5DrStQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm2; t=1760390432; x=1760476832; bh=S
 8HZcsTbrH5lG1POubh+56/8oulOXfugHauOTy6xObA=; b=JGb8OSY5ebYd084sE
 lBJ69k+GuNr66koZmM4iVZCnYAQUrpgXnP8XU/IF3WSYRx9gx1JSYM7mnGomDHO5
 HpsKMLV7vIGmYgfhAJlXMuaeIpnPpPcLLUwfM/9QCuFYN5XZV4TMRRYjVW0Xx7LA
 QPKQss8w6gefuAA9UmyhY6+Q6ZcRqlt66MIp8FR0yoAU3IlRxVuNHMZet/NZmIjG
 +03KbsyAuLkuVppIy6nluMCa7YmcT+vxVQOIafmzf6E9T9H9y8JrtG2oUWVqaz8W
 +LW/zvGOFE+sMBJXWzJIofWCWczRLNcrxmpxKR8fzl+ly1gl7j6xADKxxixgwVHP
 9iw8A==
X-ME-Sender: <xms:IG3taMHNXsXnoQYLDspHsSlAgxNumBRCPWE0xgH14EWNEPwVInClTA>
 <xme:IG3taORaIUZPkkbSi4PFEsu7RRBD_pIn38mKXBJxWuoF4Iz1LNcWuV3suSIHJqSgY
 2o4-sJMdF5lIQ32fkrOXfDKZbRwklciy17UUqozpLBwTwvGjmz8-w>
X-ME-Received: <xmr:IG3taBvTRazpAGSF62fqLrE9PYmBWkv4_OC0m6Fgtwp8ySC0sHc739LEb1mzk-QsKWfbeCCAoy6sETXLNMQN5Qz98eW8f-4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduudekjeduucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtkeertd
 ertddtnecuhfhrohhmpefvhhhomhgrshcuofhonhhjrghlohhnuceothhhohhmrghssehm
 ohhnjhgrlhhonhdrnhgvtheqnecuggftrfgrthhtvghrnhepvdejhfdugeehvddtieejie
 egteeuudfgjeeukeeiledthfetveekhefhieelhfdtnecuvehluhhsthgvrhfuihiivgep
 udenucfrrghrrghmpehmrghilhhfrhhomhepthhhohhmrghssehmohhnjhgrlhhonhdrnh
 gvthdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
 uggvvhesughpughkrdhorhhgpdhrtghpthhtohepshhhphgvrhgvthiisehnvhhiughirg
 drtghomhdprhgtphhtthhopehvihgrtghhvghslhgrvhhosehnvhhiughirgdrtghomhdp
 rhgtphhtthhopegsrhhutggvrdhrihgthhgrrhgushhonhesihhnthgvlhdrtghomhdprh
 gtphhtthhopehmsgesshhmrghrthhshhgrrhgvshihshhtvghmshdrtghomhdprhgtphht
 thhopehsthgvphhhvghnsehnvghtfihorhhkphhluhhmsggvrhdrohhrgh
X-ME-Proxy: <xmx:IG3taOJluhMc0WEw73RAqEdIi50A2JaYM4Hm8Qe4O6Z5HnyuejuqVg>
 <xmx:IG3taOnHAQ8Zwe6p1LX8oZk_ywjEPY1kYP1FNB88m1rJTVjW-Wt1TQ>
 <xmx:IG3taPLjFjqE88zXnN_O_XTXqmxiSrGls8LOqtaaOyx-BtsXcbDB6w>
 <xmx:IG3taD5JGLI6DnP_2EG0leCX1-wM0HkIOtza9wbqZl6yJOaOvEsFqg>
 <xmx:IG3taOSmpBCW6mZBCUd7OHjnZwfbJQHD1D0VpvVc6J-8GU9LZM_W2Nmi>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Oct 2025 17:20:30 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: shperetz@nvidia.com, viacheslavo@nvidia.com, bruce.richardson@intel.com,
 mb@smartsharesystems.com, stephen@networkplumber.org
Subject: [PATCH v4 2/7] mbuf: move header include for logs
Date: Mon, 13 Oct 2025 23:16:02 +0200
Message-ID: <20251013212019.892032-3-thomas@monjalon.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251013212019.892032-1-thomas@monjalon.net>
References: <20250616072910.113042-1-shperetz@nvidia.com>
 <20251013212019.892032-1-thomas@monjalon.net>
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

The header mbuf_log.h depends on rte_log.h, so it should include it.
After this move, no need to include rte_log.h in addition of mbuf_log.h.

Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
---
 lib/mbuf/mbuf_log.h | 2 ++
 lib/mbuf/rte_mbuf.c | 1 -
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/mbuf/mbuf_log.h b/lib/mbuf/mbuf_log.h
index 8feaf20747..f163cbd71c 100644
--- a/lib/mbuf/mbuf_log.h
+++ b/lib/mbuf/mbuf_log.h
@@ -1,5 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause */
 
+#include <rte_log.h>
+
 extern int mbuf_logtype;
 #define RTE_LOGTYPE_MBUF	mbuf_logtype
 #define MBUF_LOG(level, ...) \
diff --git a/lib/mbuf/rte_mbuf.c b/lib/mbuf/rte_mbuf.c
index 9e7731a8a2..22d7cfc475 100644
--- a/lib/mbuf/rte_mbuf.c
+++ b/lib/mbuf/rte_mbuf.c
@@ -12,7 +12,6 @@
 #include <eal_export.h>
 #include <rte_debug.h>
 #include <rte_common.h>
-#include <rte_log.h>
 #include <rte_branch_prediction.h>
 #include <rte_mempool.h>
 #include <rte_mbuf.h>
-- 
2.51.0

