Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8254CD3427
	for <dpdk-dev@archiver.kernel.org>; Tue,  5 May 2026 14:04:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D57344027F;
	Tue,  5 May 2026 16:04:00 +0200 (CEST)
Received: from fout-b8-smtp.messagingengine.com
 (fout-b8-smtp.messagingengine.com [202.12.124.151])
 by mails.dpdk.org (Postfix) with ESMTP id 756B64026C;
 Tue,  5 May 2026 16:03:59 +0200 (CEST)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfout.stl.internal (Postfix) with ESMTP id 8D63A1D0003C;
 Tue,  5 May 2026 10:03:58 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-03.internal (MEProxy); Tue, 05 May 2026 10:03:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to; s=fm3; t=1777989838; x=1778076238; bh=GUsze8l16/wXR+ubQMjIh
 8jUyLk2kcPU8KKol5HKpO0=; b=Jyf+Zc+X5BuXuT7XuACSqDe8e7DSyDSFsZA2J
 lM1PZor0pUUcd3Q5PsnHHsFoNU+z7bpsRTYJVNLk1qx6b0KcaFE8AupnXXQHT+BQ
 0buq80UqQimamhzTKRCFF38tV+Pn3LyRZYOjdYbSPeGGz703dMb311d2/AblEf1/
 riz7T8FCo7xkrF3bnboQE5zxkZ7BMC3wAJs7E4kyxbikJ7O0tFmHXybg+z6GUmfX
 h6Qbw2QfxxmzRzy2/O4m/4vPo7iaLpKDT3CWHxe0859LJuYAjCr2dlFEymYN4C5W
 2BWrEtz+thaFg7/pK+Omm/z6D41ehO10VYZMFMcWZ3DV8MYug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
 1777989838; x=1778076238; bh=GUsze8l16/wXR+ubQMjIh8jUyLk2kcPU8KK
 ol5HKpO0=; b=okoZBLh4mG6ZWaxCnzvtAO6OSg2X32tGD+lpbKj/9Yan4m8eQei
 mWjS62qB0Qs3b5OZhnfKbYZgCr82Awv9M6MNPl0YzJafXN4Oc4icYpJDiKWBWvHa
 j6sFVzAvGoVq8N+e8/vFAFdmpss+DTwTIVrGt+O5J9llWK18RchVj3weqficMplM
 UA9mqmWFZABSwQjo+g0cyh2Q7a8K6mQjf/FxLNTXdQ+9Y6m9JrhBjNVm1ycGzkBd
 iM0t0OkK79P4cEDbvLhjH9TY0+4Ziurzl3et1ZEf6sAdlFayvLZRfpRAR1Ht2MpA
 oWq/4LPDfDf5GXrky+n+5OFlDPNF8LMWEZg==
X-ME-Sender: <xms:zfj5aU16BjkZ3Dha2EOElF6GQFnDnCOEwynq7Ow7JAT5zBkKxhK7GQ>
 <xme:zfj5afPBMKm90ICVFIs1qTm11oEMkZ-mZZAmaN8wC_zeN1Xi_6KuQToKwmHWBHRsV
 mtAjm6MlJ3bI7tNeWzpjSsfDZU6BZRpSDEtRV44wwTHvePWYU7->
X-ME-Received: <xmr:zfj5aU3w2cvBVPIsOKYTRoRgvgVurars27faAq-rh7xgutmwkV5fSJ3u6P6pJ72Kpit2SQt5XlHRaeu0-F_JKfJ1KN7vtIw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddutdduledtucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepvfhhohhmrghsucfo
 ohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtffrrg
 htthgvrhhnpeevveefveeiiefhtedukeegkeelieegffeukeevudetueffieduveetiedu
 keefleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
 hthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeegpdhmohgu
 vgepshhmthhpohhuthdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtphhtth
 hopegurghvihgurdhmrghrtghhrghnugesrhgvughhrghtrdgtohhmpdhrtghpthhtohep
 hhgrihihuhgvrdifrghnghesihhnthgvlhdrtghomhdprhgtphhtthhopehsthgrsghlvg
 esughpughkrdhorhhg
X-ME-Proxy: <xmx:zfj5aWE_20kHYyKAuRkSofCwCcccWDkgm21uJpHGZhtqnkkleghgQA>
 <xmx:zfj5aR4woWYY1hlD5QFL-QZTuiHvUwuK3S4DODFf8esj58wHsZIu5w>
 <xmx:zfj5act-pLwWu-5Kyk_Tx0TvjzeAlbFvw39oZP45j5Y-yBWYNinpUQ>
 <xmx:zfj5aS6UWbb4sAk3_ZxyHwHerGc2x4fU2zGKg1tM1ZaVUSU9uOW-ig>
 <xmx:zvj5aWwbF1DvmgU38NuDN4dEJBm9I_Btt-cjfv_vNUw9uF_gPI55BnWQ>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 May 2026 10:03:57 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: David Marchand <david.marchand@redhat.com>,
 Haiyue Wang <haiyue.wang@intel.com>, stable@dpdk.org
Subject: [PATCH] devtools: fix regex matching literal plus in patches
Date: Tue,  5 May 2026 16:03:52 +0200
Message-ID: <20260505140352.3995590-1-thomas@monjalon.net>
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

In Extended Regular Expressions (ERE) as used in awk,
'+' is a quantifier, not a literal character.
The pattern /^+/ matches the start of any line
instead of only lines beginning with a literal '+'.
As a result, check_experimental_tags and check_internal_tags
were matching context and removed lines in diffs, causing false positives.

Use [+] character class to unambiguously match a literal '+'.

Fixes: cfe3aeb170b2 ("remove experimental tags from all symbol definitions")
Fixes: fba5af82adc8 ("eal: add internal ABI tag definition")
Cc: stable@dpdk.org

Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
---
 devtools/checkpatches.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/devtools/checkpatches.sh b/devtools/checkpatches.sh
index 1c6099ac82..f5dd77443f 100755
--- a/devtools/checkpatches.sh
+++ b/devtools/checkpatches.sh
@@ -321,10 +321,10 @@ check_experimental_tags() { # <patch>
 		current_file = "";
 		ret = 0;
 	}
-	/^+++ b\// {
+	/^[+][+][+] b\// {
 		current_file = $2;
 	}
-	/^+.*__rte_experimental/ {
+	/^[+].*__rte_experimental/ {
 		if (current_file ~ ".c$" ) {
 			print "Please only put __rte_experimental tags in " \
 				"headers ("current_file")";
@@ -351,10 +351,10 @@ check_internal_tags() { # <patch>
 		current_file = "";
 		ret = 0;
 	}
-	/^+++ b\// {
+	/^[+][+][+] b\// {
 		current_file = $2;
 	}
-	/^+.*__rte_internal/ {
+	/^[+].*__rte_internal/ {
 		if (current_file ~ ".c$" ) {
 			print "Please only put __rte_internal tags in " \
 				"headers ("current_file")";
-- 
2.54.0

