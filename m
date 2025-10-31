Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04CEACCF9FA
	for <dpdk-dev@archiver.kernel.org>; Fri, 31 Oct 2025 11:43:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F13954029A;
	Fri, 31 Oct 2025 12:43:23 +0100 (CET)
Received: from fhigh-b7-smtp.messagingengine.com
 (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
 by mails.dpdk.org (Postfix) with ESMTP id 540CD40150
 for <dev@dpdk.org>; Fri, 31 Oct 2025 12:43:22 +0100 (CET)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 95D097A013D;
 Fri, 31 Oct 2025 07:43:21 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-03.internal (MEProxy); Fri, 31 Oct 2025 07:43:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to; s=fm3; t=1761911001; x=1761997401; bh=FBslBIqP0KXQql/p3bX6V
 eC6Jb9mGpVhEurVCvPaFC4=; b=Y/GOsJI7G7SYX2VaZQg/Pac7KxYFQ7Dbm6ZH7
 swFZX8baZGu2dcirHzWgDFXyz/Rs4kbkv+ox2lLHwXnuhGVROF5wrspxVazirnm7
 7eg4Vgf6Q3MpAfdJ6/nFbHf10LNvXyaOtdzauKk/v2iYnyhWzkEl1aSQJQF5NW8W
 5sV5rMix7j7s375VRGk7vnTCQwjrC0bI2KndjPp49sCqyvSUnQv5/b6rht/TZHWO
 dlUFANl17uHLXWRgOpS4Ecape20S8Tc5kCQHCprNEN0+sliuT3bbpD6dXURE95D1
 7Kh31yFGtLmikNmLTPF3NSj9jbaxi41VIVkau9ZrzTUKb2TEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
 1761911001; x=1761997401; bh=FBslBIqP0KXQql/p3bX6VeC6Jb9mGpVhEur
 VCvPaFC4=; b=xdClhVX1jAjMsV6JGlTVhnuTGaEfMaoEUKMYUuiASZKuo5znB7q
 pR+DSzdgNtxCJ1dpWFpr3w+cVQQz02u1VjpYBSeltEFt11D57RGa1mJQIogOGHJY
 Lddur5vIfMJ0jfHK7hP56FLsG/h9NZbOFiJ3CkY9n4UI3U8uxrR/xMtnLGe/OmsM
 REpE4W1O0q7UXeqb+MkGFVl5U4FQrUqeOpeTp7sBSNJUnN/n01t8bjMH32txEy/r
 Mwt0UfnlNNaH8FGbxVEmhJnrQl1KpsHtjvSL5cMBrQ793Q21aQec/51AuooFi09s
 i/yrspWP7PFrC3hXFLTfwx1a9/C37gdUsIA==
X-ME-Sender: <xms:2aAEaXsmyVyLO3Ux5jA3kXeXs_bKyPlbqTuZnTlvDaiTtj0WH8XKzw>
 <xme:2aAEaf7bbQ90wH4CBpVaCfP0zuql5K3gwSRQlbZ2DadgGs6eJGKmci9ghVQj4EfiW
 VVZICqOuU9okIlDckRx9KpeKCJRuPYMIuTkK-7MDHm51yjOQBBEkQ>
X-ME-Received: <xmr:2aAEaYLnEox8aRN-5Kd_A86tLFTer5nVvuYvspWu1TOCVvwkbT0sKNGTYxhsuzJfGtuGuJC-qUt5OGxz36L2BGTsBg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieelgedtucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertdertd
 dtnecuhfhrohhmpefvhhhomhgrshcuofhonhhjrghlohhnuceothhhohhmrghssehmohhn
 jhgrlhhonhdrnhgvtheqnecuggftrfgrthhtvghrnhepveevfeevieeihfetudekgeekle
 eigeffueekveduteeuffeiudevteeiudekfeelnecuvehluhhsthgvrhfuihiivgeptden
 ucfrrghrrghmpehmrghilhhfrhhomhepthhhohhmrghssehmohhnjhgrlhhonhdrnhgvth
 dpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuggv
 vhesughpughkrdhorhhgpdhrtghpthhtohepuggrvhhiugdrmhgrrhgthhgrnhgusehrvg
 guhhgrthdrtghomhdprhgtphhtthhopehrohhrvghtiihlrgeslhhinhhugidrmhhitghr
 ohhsohhfthdrtghomh
X-ME-Proxy: <xmx:2aAEaf7hrbAMpj8dkCPT3ud-8mStmxr3m1Pn-JufPICwtMV5jQygwQ>
 <xmx:2aAEabzonHeCt54-YgwlSCWJfl0TbFqPzN2xR0Mq93uXg_NiMHyp5A>
 <xmx:2aAEaTaByYasxdzxLSIdT8I-I4sgxp5bVWZrx6FIm-V6JLbiatu1qQ>
 <xmx:2aAEadSRfc2hA6mzlNLf2L834pzCfO4LGsv8HNxWRvPjorzU2mwpmw>
 <xmx:2aAEaXR1MYZshljlOdrjdN9aKE1o_YniT6Df6rGY0zX4pdKsyzzBbIlY>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 31 Oct 2025 07:43:20 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: david.marchand@redhat.com,
	Tyler Retzlaff <roretzla@linux.microsoft.com>
Subject: [PATCH 1/1] test/memcpy: reduce duration
Date: Fri, 31 Oct 2025 12:43:09 +0100
Message-ID: <20251031114310.4062899-1-thomas@monjalon.net>
X-Mailer: git-send-email 2.51.0
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

When running on limited platforms like GitHub Actions,
the functional unit test "memcpy_autotest"
may hit a timeout, especially when running with UBSan.

This change skips testing some alignment offsets (from 0 to 31).
It will test only every 3-byte offsets for the source buffer,
and every 2-byte offsets for the destination buffer.
So it is supposed to be 6x faster with a reasonably smaller coverage.

Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
---
 app/test/test_memcpy.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/app/test/test_memcpy.c b/app/test/test_memcpy.c
index 802dc4631b..ea9e76e9ad 100644
--- a/app/test/test_memcpy.c
+++ b/app/test/test_memcpy.c
@@ -105,8 +105,8 @@ func_test(void)
 	unsigned int off_src, off_dst, i;
 	int ret;
 
-	for (off_src = 0; off_src < ALIGNMENT_UNIT; off_src++) {
-		for (off_dst = 0; off_dst < ALIGNMENT_UNIT; off_dst++) {
+	for (off_src = 0; off_src < ALIGNMENT_UNIT; off_src += 3) {
+		for (off_dst = 0; off_dst < ALIGNMENT_UNIT; off_dst += 2) {
 			for (i = 0; i < RTE_DIM(buf_sizes); i++) {
 				ret = test_single_memcpy(off_src, off_dst,
 				                         buf_sizes[i]);
-- 
2.51.0

