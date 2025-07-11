Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70FB1C83F1B
	for <dpdk-dev@archiver.kernel.org>; Fri, 11 Jul 2025 14:43:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 484854025D;
	Fri, 11 Jul 2025 16:43:42 +0200 (CEST)
Received: from fhigh-a8-smtp.messagingengine.com
 (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
 by mails.dpdk.org (Postfix) with ESMTP id B924D400D6
 for <dev@dpdk.org>; Fri, 11 Jul 2025 16:43:40 +0200 (CEST)
Received: from phl-compute-04.internal (phl-compute-04.phl.internal
 [10.202.2.44])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 1E2511400248;
 Fri, 11 Jul 2025 10:43:40 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-04.internal (MEProxy); Fri, 11 Jul 2025 10:43:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to; s=fm2; t=1752245020; x=1752331420; bh=4wYAB7Typo5UA1qM0uY8F
 s+JhC69yu1FkKeo56GG8Ho=; b=fVH9IF7x2OEIHx0q2cfjExxOzBAJAYLv0ZqES
 eYShURRChW8MrTtaY/CEAVmDJyEsxUdnfs1igfpLya3wQQcr8hXeS4oU+G9irBqu
 B2j6GwQcTppbMCrBku/R668lJtirmwkr43tIuVQfhTeSzXwz+kRPNokK4PQ4tULw
 5+5AEaoPIJBIYtcWuq2Ui55jxrQRpuRaGOKwnwbgIsOBhO55BT/CVGhvOgvBUgbv
 juBgRLhK+1wzUV8fnpV022PuyI+S5SHOZErgqGQO/4mZdAmaSJ4wg+6AgPs3Ej+H
 M56HwqjVTjgCJ3Axqkz2OjWTLcLLXpGr9wQj6QyXvtqGNbxLw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
 1752245020; x=1752331420; bh=4wYAB7Typo5UA1qM0uY8Fs+JhC69yu1FkKe
 o56GG8Ho=; b=h2Vk/EhtoYlL+fOD/fcsC7S3vfsO06gPeze0ucr/YWAYydFZVsX
 pMFb6bM8/kLazLmkDT4qEaK7q18sX5aO6b304pCArLwYsXC8Y/SD27wldS8fDCrT
 +yHl4iQKDBYQfBe3n7ktugDo9+51OLQAbwaq80qeim7sPx9A05cJ9og61ReMTcjB
 eyKyM6KfOVL6h6juh22Q9DIRnjDhfHSdqGOMYIoj2/HKFvn74jCr4yTnyCJsWEv9
 LT5uSk+4tXOKlFhvmtybBcqNg7TOzljK1rwb1vSZ4dQ69YkYCjk0oNn8eLL90eZV
 9e8XkRgeKxDXX3ZWd64cY1+5wNRJvuGBlxQ==
X-ME-Sender: <xms:GyNxaMULwSLQl9qFtBQ_fbe24dqiMcwK7r5BMOsVMb6xip8Y1z-XFA>
 <xme:GyNxaKOz9cfPbmEwFFGeKY_AY5WOcAFMXjy1GIeLKhSlvx1oCY86f482t9vrJxa7T
 VtUPFZClcnVcm04vA>
X-ME-Received: <xmr:GyNxaAbmF4mkA1mR2t8BlZPz7eGgg3dvxtDpPD4xr1EGdGSGijbUCfJte0XEn5LjVXErP_ytwhcbwZSjI5fd0NQZN9d_m1E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdegfeehkecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefvhhhomhgrshcuofho
 nhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrfgrth
 htvghrnhepvdetgfffvdeuueegfeehkeetfeelhffhtdejfeetjeettdetgfdthedvteet
 heeunecuffhomhgrihhnpeguphgukhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvght
 pdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopeguvg
 hvseguphgukhdrohhrghdprhgtphhtthhopehfvghrrhhuhhdrhihighhithesrghmugdr
 tghomhdprhgtphhtthhopegrnhgurhgvfidrrhihsggthhgvnhhkohesohhkthgvthhlrg
 gsshdrrhhu
X-ME-Proxy: <xmx:GyNxaOpc3E0QCBg_kfmIFEDOVY_T-Gf-2xbbAX-KAczD0nVFaDv4TA>
 <xmx:GyNxaEZP0J5C74XODfHPIiXWJAr6YeNcgzhR-z_hGKFS-ZA9V4FOhg>
 <xmx:GyNxaGQg1PhQrsnu5nG7J4BHUCtc1JECjyTqS1YPWTqkCtOo81hmzA>
 <xmx:GyNxaL4jLSZ6WEGOkUFBI18EiHbwxeNtQ6zJCsX1fK9sH3hXgtx6mg>
 <xmx:HCNxaP7PqiVsXTCz1CpgslKZDAyAXpNMTE6ivQBwDZ7FROEeH-A0LLDa>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Jul 2025 10:43:38 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: Ferruh Yigit <ferruh.yigit@amd.com>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH] maintainers: update for ethdev library
Date: Fri, 11 Jul 2025 16:43:25 +0200
Message-ID: <20250711144326.1288907-1-thomas@monjalon.net>
X-Mailer: git-send-email 2.47.1
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

Ferruh Yigit has no time this year for ethdev maintenance.

Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0e9357f3a3..b96496adb7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -435,7 +435,6 @@ F: app/test/test_mbuf.c
 
 Ethernet API
 M: Thomas Monjalon <thomas@monjalon.net>
-M: Ferruh Yigit <ferruh.yigit@amd.com>
 M: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
 T: git://dpdk.org/next/dpdk-next-net
 F: lib/ethdev/
-- 
2.47.1

