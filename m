Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0274FCCF9E3
	for <dpdk-dev@archiver.kernel.org>; Sun,  2 Nov 2025 16:14:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1464840270;
	Sun,  2 Nov 2025 17:14:21 +0100 (CET)
Received: from fout-a8-smtp.messagingengine.com
 (fout-a8-smtp.messagingengine.com [103.168.172.151])
 by mails.dpdk.org (Postfix) with ESMTP id 63B5840261
 for <dev@dpdk.org>; Sun,  2 Nov 2025 17:14:19 +0100 (CET)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfout.phl.internal (Postfix) with ESMTP id 07FFBEC0204;
 Sun,  2 Nov 2025 11:14:19 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-02.internal (MEProxy); Sun, 02 Nov 2025 11:14:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to; s=fm3; t=1762100059; x=1762186459; bh=Ak1nGAOrkdRBJBNUja9bN
 /MqP+5p4mrGSwY0ih+zJ/Y=; b=pD2706mdL965dSdH2smFd3/vW5VeCk4vwoD7K
 G7ycetOCUB+w/JhiQq5d0Ali+A5TH52A+x4DO6s/0pNtWy3Ordn3LBJ62frBdCNf
 g00AMGP1boSLcVcISblTsM0KrPlfePStckvIj74aD59WgKZkq6hS5/j69fq5ZlIc
 UjOE86c8PIvdqCbu922uKDK7aDfpFvzJcBr5KTYJvedNOKbgLkNkVx+H/SNMcWIw
 QfEswLzuLP/uCCvhbMwY3HxMmjohY711DLWlnniLG7RfSx1/+ZDKyizMKwsy8C9a
 lNxGpl05CqLiNi3bmycvhs1RgFKoZpBhIOIXaFPe07jQMl7kQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
 1762100059; x=1762186459; bh=Ak1nGAOrkdRBJBNUja9bN/MqP+5p4mrGSwY
 0ih+zJ/Y=; b=WIBaY0NWXJaoPNsSFb8j7b+HKPx4RUClKtB7L9ZD6FNoIfEgA6f
 CMDJ2jrwgnL6blBwtASzIj4w5VCdYjw1Lv2oWTvfG3YxF2b0k/qwR7juHQ98kQfO
 byGz5QrU3jLJSMRO/OWRPVrNZImYiaxpNqTimxK1gvQwlL/CLgEkW6HS0XOaG65m
 GeLRG6DKgTWaHSnuYnvYgwf8TBu/ci3M0q/ueSAyftR8BjcFvIlGgaVHGlqra+yb
 83jyWqM2U1vQ6Td6itJ/LnOeoW5AOzZgP3WqcmoTL5sR/GA3IFJpIQhStclc63VU
 mLvSu30FaWeIEVc5z7uOPZI4yg/7KtVLK9g==
X-ME-Sender: <xms:WoMHadaP4GkF_5Ukgp8RBtbvguTLjNVuUSghgc-DMyP1B6a4SsOTSQ>
 <xme:WoMHabZCTmYQLE9Uf3bNaOcqqHSomUE7epGfGttAoq7Qigh932wPp_S3D3OauERxF
 YJRwGijChQKFxeTrts7rT5lvx1sICFw5fHLmajtFEwnYG2-QDghDg>
X-ME-Received: <xmr:WoMHaU_586BIfHQEFSsgXI-VepY6IfPjrjXmfqNu7dQ4zWaReNT76rctGLOs2Vvbz1Pym90B6q65UwE6Rl3adn7K5Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujeehjedtucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucgoufhushhpvggtthffohhmrghinhculdegledmnecujf
 gurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepvfhhohhmrghsucfo
 ohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtffrrg
 htthgvrhhnpedvtefgffdvueeugeefheekteeflefhhfdtjeefteejtedttefgtdehvdet
 teehueenucffohhmrghinhepughpughkrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
 enucfrrghrrghmpehmrghilhhfrhhomhepthhhohhmrghssehmohhnjhgrlhhonhdrnhgv
 thdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepug
 gvvhesughpughkrdhorhhgpdhrtghpthhtoheptghhrhhishhtihgrnhdrvghhrhhhrghr
 ughtsegtrghnohhnihgtrghlrdgtohhmpdhrtghpthhtohepmhgrihgtohhlghgrsghrih
 gvlheshhhothhmrghilhdrtghomhdprhgtphhtthhopehrohhrvghtiihlrgeslhhinhhu
 gidrmhhitghrohhsohhfthdrtghomh
X-ME-Proxy: <xmx:WoMHaagu0umcWLpEeiKoGCcUuco0_Ky2Xk3sWa5L5IqYwpRgr-GtbA>
 <xmx:WoMHaUcDisQrncsfCFs9DwVs5RtgrXI68b4Y1pwMXioYVcKUrs9FTw>
 <xmx:WoMHaRp9v5O5emdDecVu1Ri6X3AtueJaXSDlfdJiQpzGb7VF2Alo9w>
 <xmx:WoMHaZCz0FpHZLUhquOg1xrrXtiDIN67tRwnRn5HWoxIzvBs5p8DaQ>
 <xmx:W4MHaf7ZQY5lvvp9HLhtJjNeILSwDRb0E0i6DEpI6HVmrVQKUtTtb5MN>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 2 Nov 2025 11:14:17 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: christian.ehrhardt@canonical.com, maicolgabriel@hotmail.com,
 roretzla@linux.microsoft.com
Subject: [PATCH] maintainers: remove some inactives
Date: Sun,  2 Nov 2025 17:14:10 +0100
Message-ID: <20251102161410.4004823-1-thomas@monjalon.net>
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

Some maintainers known to be inactive for at least a year
are removed to make clearer where help is needed.

Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
---
 MAINTAINERS | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 15a47d5ad8..316d21cd47 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -72,7 +72,6 @@ T: git://dpdk.org/next/dpdk-next-dts
 Stable Branches
 M: Luca Boccassi <bluca@debian.org>
 M: Kevin Traynor <ktraynor@redhat.com>
-M: Christian Ehrhardt <christian.ehrhardt@canonical.com>
 M: Xueming Li <xuemingl@nvidia.com>
 T: git://dpdk.org/dpdk-stable
 
@@ -139,7 +138,6 @@ F: devtools/check-meson.py
 
 Public CI
 M: Aaron Conole <aconole@redhat.com>
-M: Michael Santana <maicolgabriel@hotmail.com>
 F: .github/workflows/build.yml
 F: .ci/
 
@@ -160,7 +158,6 @@ Environment Abstraction Layer
 T: git://dpdk.org/dpdk
 
 EAL API and common code
-M: Tyler Retzlaff <roretzla@linux.microsoft.com>
 F: lib/eal/common/
 F: lib/eal/unix/
 F: lib/eal/include/
@@ -392,7 +389,6 @@ F: kernel/freebsd/nic_uio/
 
 Windows support
 M: Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>
-M: Tyler Retzlaff <roretzla@linux.microsoft.com>
 F: lib/eal/windows/
 F: doc/guides/windows_gsg/
 
-- 
2.51.0

