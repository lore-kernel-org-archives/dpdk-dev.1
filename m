Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDB7BCA0EFF
	for <dpdk-dev@archiver.kernel.org>; Wed, 27 Aug 2025 08:24:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F25EF4065E;
	Wed, 27 Aug 2025 10:24:42 +0200 (CEST)
Received: from fout-b5-smtp.messagingengine.com
 (fout-b5-smtp.messagingengine.com [202.12.124.148])
 by mails.dpdk.org (Postfix) with ESMTP id 191854065B
 for <dev@dpdk.org>; Wed, 27 Aug 2025 10:24:42 +0200 (CEST)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfout.stl.internal (Postfix) with ESMTP id 8C3A81D000CF;
 Wed, 27 Aug 2025 04:24:41 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-03.internal (MEProxy); Wed, 27 Aug 2025 04:24:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1756283081; x=
 1756369481; bh=ZAws+ra4PQdp6q/iLlNvZZZw8b/4flAkzOjNNwWld7M=; b=k
 TnIpOp5zErAF9mo3qnqCcB3oDPUB78HGolYdY2tI9RRZWQiSvdGXOsa/i1B14u96
 fxXD9MR57ejASAY3cEmvJUZtplOdzwHQT3ddlhiwzC6RHAo82K3AZzdILp63UPts
 szq2O6DS+1tmt0XYY3MIwJZp+nW6j9ppOfrN/Jcb21gH6CS5eRq/nYiGKns3jD51
 KVNKOVAGlpa/VBmq7ffrb0bHq4RKxILrOu7c3uub2FUgiOLdI/OxfIpEGpjZLx47
 a7K9p1EO6kfF/35OmNMOH1PLhaLjBlNy/aLPfoQ4EmIGvdsnZuC1CDuJ4Dj+atvm
 PyhycqS6BShj9WKi7dDiA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm1; t=1756283081; x=1756369481; bh=Z
 Aws+ra4PQdp6q/iLlNvZZZw8b/4flAkzOjNNwWld7M=; b=mUHeLqiPcuwHdm2+/
 trVnwHSSt1Al77/DbyJwSjM2KntBjdKewz7EpdPgty6JUF8B1Bg4lWvRnWydzgVZ
 fmU+00fluj1BHipJk/y2O35+aAgLbQuTjk86DN1nQga3F9/48CHZ2dBznRoHt1x+
 idMlqmG85iXkQTtiR7kX1bjc1ilY1UukZIA0l36bgmfkIgHh2U06F0DomKAnXgiR
 jFQWjxghH75Rt9mOrmxY5EA6EM4gblcAOaAvJHkT80HKv+KB9YRQn/yIkhUVBy/5
 5baRbxMy7uZtLZoK12eAjiKu4H6WMo3tecUGQg5VSkU8fJ+gwGo5Bqk5w631pnHF
 bETiQ==
X-ME-Sender: <xms:ycCuaI22BxfUyXz9cF11o-4Sm0FTAtY4CsSuS-rKpvl3b2nH4FcIIg>
 <xme:ycCuaIVxRlsEkt7FitX3BgeYA88wIIIbMyhKprCTqUgKqnZcJhHSuNS3LLbhL_jf8
 fxdIkdI-fMZhVeK_w>
X-ME-Received: <xmr:ycCuaClzK_zfi7dNfGbh5aNKG0RqAtJWAjNA59AiRVwu3gMb1PRWOl2rZdEjO5cGkp2ecifyi3Faf94RlQG0SzTuvtFYTrk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujeejieeiucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpedvjefhudeghedvtdeijeeigeetuedugfejueekieeltdfhteevkeeh
 hfeilefhtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopedvpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtph
 htthhopehmrgigihhmvgdrtghoqhhuvghlihhnsehrvgguhhgrthdrtghomh
X-ME-Proxy: <xmx:ycCuaKDUC1TYqiF1qnB1r-TQAhx6x2BpIHLeEgzOZrujobZBjeK4ug>
 <xmx:ycCuaCeRa1UyhjbLMTKd-n0u91H4HRfjPgv4jE_9ayv1oyweUCdSiw>
 <xmx:ycCuaFJV8I5-SxtYQP3hqkPp8HrtdULhdaN_VzUiyaQDR2laaF-cXw>
 <xmx:ycCuaFfrKypAPHqHHAzvTmv1WXiZzfpn0iKKgws52DfjQT1Yy08b0A>
 <xmx:ycCuaNDoeWcgZOp3ukZdkXlO8g7XwrXalS_15o-jcpD6Y0h-wXfNU68Z>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 Aug 2025 04:24:40 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: Maxime Coquelin <maxime.coquelin@redhat.com>
Subject: [PATCH 4/6] devtools: remove unused variables in uAPI script
Date: Wed, 27 Aug 2025 10:21:47 +0200
Message-ID: <20250827082413.1417226-5-thomas@monjalon.net>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250827082413.1417226-1-thomas@monjalon.net>
References: <20250827082413.1417226-1-thomas@monjalon.net>
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

Some local variables were not used in the function update_headers()
of the Linux uAPI script.

Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
---
 devtools/linux-uapi.sh | 2 --
 1 file changed, 2 deletions(-)

diff --git a/devtools/linux-uapi.sh b/devtools/linux-uapi.sh
index 05f3ddf87c..654c4a8c25 100755
--- a/devtools/linux-uapi.sh
+++ b/devtools/linux-uapi.sh
@@ -42,8 +42,6 @@ download_header()
 update_headers()
 {
 	local header
-	local url
-	local path
 
 	echo "Updating to $version"
 	for filename in $(find $base_path -name "*.h" -type f); do
-- 
2.47.1

