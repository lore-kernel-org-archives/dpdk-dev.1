Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 239DDECD9A6
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Feb 2026 21:31:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 231134067C;
	Thu,  5 Feb 2026 22:31:14 +0100 (CET)
Received: from fhigh-a4-smtp.messagingengine.com
 (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
 by mails.dpdk.org (Postfix) with ESMTP id 0FA8F4066C
 for <dev@dpdk.org>; Thu,  5 Feb 2026 22:31:13 +0100 (CET)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfhigh.phl.internal (Postfix) with ESMTP id A6DB11400135;
 Thu,  5 Feb 2026 16:31:12 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-04.internal (MEProxy); Thu, 05 Feb 2026 16:31:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1770327072; x=
 1770413472; bh=IPfgPZE/f//FEtuR0//uxUEgj62p3E/ViF9o4jr+kuQ=; b=i
 670gZOvf3hdbFn+Oy4N+SbW8kejztN5PuNNXrWUJdjIFqmjuPWrOUvhPfdw5MgqB
 dyIxb4b/Ku6z11Zu/NmGiF0c3VY5tJ4wV+CGUsrzR2B9Wo5pEItkkxWY9DofcJZv
 m1t95Di3OnSz10aP8mh22iGyZNsppF34FHTjf4+3JclRezboyphC4lnRXvGO5I+4
 4BSBxcFDJSSPHoVYIV9JVu1hdFFTGwGoBbzTxF8M3kdwOild222VEgR60+6deFzt
 1I5/yib5Fd/oLONQA0CnMDfXsscTDXpRM4fNWsJRnjXk7zo4oX0qwRODdN2Ix1Nc
 cWY7P/jaRpoDg0zMyC1zg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1770327072; x=1770413472; bh=I
 PfgPZE/f//FEtuR0//uxUEgj62p3E/ViF9o4jr+kuQ=; b=Mnix2tqsuZgZQrn9m
 tpe2rr0+/P+7uumef+BsC4eEAT1FwaT+fDJtfl65RUoUnhrP396L4Z9SeexVXemM
 p9dOADkyOPL3NzzBZF/7z4vZR4CXO6FmByJTBo4RhKvmPCwal4jiXhdFBTfKId00
 JMf1I3iaHvOZh6BQkBnq6ixz4zkiKTOhTvLpqOpfMkLUJ4bwY3WxlA1RST9fPUzu
 MTWgWZtrvXgONuYuU0j+baoe8qAKokyrFE+sP5BeaDnXy2UMRbkxLvyW50XxTRQA
 9rLL+vMBw+uTGg3EkabyQxgJT15SKLBWwbf9WUrrxCfZtVIUNnw6lNO2k3aAAv8c
 VHd9Q==
X-ME-Sender: <xms:IAyFaZ27vessu1JEqFydflGdlW2IaMAPCIZGT1qrcq1Qc3v6J8Ou-Q>
 <xme:IAyFaUbbq46mjjVo3Z3OBFShA_DoDUiEfzWc1dNLHSJREgsZByNF431C3M6cHW3Qk
 XV8j4146j7bndvLGF6u4EQjraEQaAgENc3eGfThhZdgyGwiAC79ew>
X-ME-Received: <xmr:IAyFaZDzSdq-ZLcD_VSHnAGUSoGCNtTa7OJm9xGpalJQvf3_O4SZrow1Vk2WEBX-Cp-TTqQMIFIxTjXr0-y9f8tHjaTTONg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeeifeelucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpedvjefhudeghedvtdeijeeigeetuedugfejueekieeltdfhteevkeeh
 hfeilefhtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeefpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtph
 htthhopegurghvihgurdhmrghrtghhrghnugesrhgvughhrghtrdgtohhmpdhrtghpthht
 oheprggtohhnohhlvgesrhgvughhrghtrdgtohhm
X-ME-Proxy: <xmx:IAyFae8L4ny--tGREqM0D2H-vpbUip2zwmdPyqYnRsXQ_zS5zhlzVA>
 <xmx:IAyFaR_XybkaZ1vqv7Vd8_UspAElskJFJLWrUkMKHPUYeZm1g338Ew>
 <xmx:IAyFadf1lI0DLsKNBmgRaHfM_VA_0pDHbSW9QPXC2Zg-EraDO8z08g>
 <xmx:IAyFaSFS4ZsiDj5_61NSS-hRuQkY9TtnvjXoxq0ZGGE-OeHUoc4plg>
 <xmx:IAyFaYN1KxDoHdRk2cYpKPz2KAC97Khc6YC43BCmpY0w7OGCXgN0GjVa>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Feb 2026 16:31:11 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: david.marchand@redhat.com,
	Aaron Conole <aconole@redhat.com>
Subject: [PATCH v4 11/11] ci: check minsize build type in GHA
Date: Thu,  5 Feb 2026 22:27:43 +0100
Message-ID: <20260205213044.702908-12-thomas@monjalon.net>
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

In GitHub Actions, the build for Fedora with GCC is updated
to use the Meson build type "minsize".
This type may have some different requirements (or bugs),
so it is better for its maintenance to test it regularly in the CI.

Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
---
 .ci/linux-build.sh          | 2 ++
 .github/workflows/build.yml | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/.ci/linux-build.sh b/.ci/linux-build.sh
index aac0bd3dc5..e0b914a142 100755
--- a/.ci/linux-build.sh
+++ b/.ci/linux-build.sh
@@ -85,6 +85,8 @@ buildtype=debugoptimized
 
 if [ "$BUILD_DEBUG" = "true" ]; then
     buildtype=debug
+elif [ "$BUILD_MINSIZE" = "true" ]; then
+    buildtype=minsize
 fi
 
 if [ "$BUILD_DOCS" = "true" ]; then
diff --git a/.github/workflows/build.yml b/.github/workflows/build.yml
index ab140f885e..f0142efd3b 100644
--- a/.github/workflows/build.yml
+++ b/.github/workflows/build.yml
@@ -325,6 +325,7 @@ jobs:
         config:
           - image: fedora:43
             compiler: gcc
+            checks: minsize
           - image: fedora:43
             compiler: clang
 
@@ -362,6 +363,7 @@ jobs:
         echo CCACHE_DIR=/root/.ccache >> ~/env
         echo DEF_LIB=${{ matrix.config.library }} >> ~/env
         echo STDATOMIC=false >> ~/env
+        echo BUILD_MINSIZE=${{ contains(matrix.config.checks, 'minsize') }} >> ~/env
     - name: Load the cached image
       run: |
         docker load -i ~/.image/${{ matrix.config.image }}.tar
-- 
2.52.0

