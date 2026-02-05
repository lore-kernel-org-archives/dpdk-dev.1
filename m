Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D051AECD9A6
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Feb 2026 21:31:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 347FE40684;
	Thu,  5 Feb 2026 22:31:13 +0100 (CET)
Received: from fout-a8-smtp.messagingengine.com
 (fout-a8-smtp.messagingengine.com [103.168.172.151])
 by mails.dpdk.org (Postfix) with ESMTP id 3D0F040671
 for <dev@dpdk.org>; Thu,  5 Feb 2026 22:31:11 +0100 (CET)
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
 by mailfout.phl.internal (Postfix) with ESMTP id E7241EC04F2;
 Thu,  5 Feb 2026 16:31:10 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-08.internal (MEProxy); Thu, 05 Feb 2026 16:31:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1770327070; x=
 1770413470; bh=QKtORE5ACAi9oCrumSvcD73103Wlg7Alnp4GAOQgUzI=; b=l
 VRnvEHZLUQ4Plu6V04ZpIUZULuhP0ZSb1zs4pdG7wCFfVR/lxZxStkj+6jBrrqc7
 WaDU7PPRm8JKqXgPXFZP7lguATkLp/ST8YnvxEGabhQbM02PdPV+sNqhvpw2U6LP
 68naOK66ttnbuOKv1RpA6FZd24w8e/rK1P25vlLrytxJ6Ie33fOSudjgMtBvKprx
 aiTJ7AjymhNIPFd7vyDJln7QdJI/ftAnS0YQgjK0jiAR6ev/V28GejJDSiwEMhl8
 xaUUajpKCiEmMrpxxbTJGvDZlDucWQWU1P38c1GALh8JNYMj+y2xogFpM3YcwLJE
 +lzOswqAYH54lXtT0W9Zg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1770327070; x=1770413470; bh=Q
 KtORE5ACAi9oCrumSvcD73103Wlg7Alnp4GAOQgUzI=; b=OdbWrckGaT5g+tBy9
 CZlFTcRS1xcSrYbfdWmtIcIRAZiIuzLvr7GbA3npz0MmAf1TRSCRkhwFSDqWoEdc
 H47HrDwroEZ2pTknpfxYIJEMF9m6d37LBtEnz9aHJN+evW73TqjkGnGwMpvxgxZM
 afs3iDkNKQF3CMmXDtJ79BW0rehFkXK0pJka5x610YlvYQZO07lRrZXeBHbOIazq
 1JR5RkgVuA1ukwXbS236+tj1roDV9fP61RIQ8gGnao8dbepyGjZ0wBKlfqnB5/1V
 93B+UCfKOyQP1cbkZ9eSlhkCO41YGyJZJgv1n0iTJjapaSS98s4oOJbAAdG5lAg5
 dq40Q==
X-ME-Sender: <xms:HgyFaSfWynY4y5rLif0LrKRT_iBmlHMarEyWezs8wkqY5M0Ty45Dww>
 <xme:HgyFaXFCi3ydEHMncWlPQrBuOOw-40oAf6FeMSb1zB8YSV8AJcTFhNEMeEqZb7ZLG
 1AdcSCp67BwIqj8HXf3uqftSt4ETtHpEg_tQ7FU3dG6OF1ijcNuxcI>
X-ME-Received: <xmr:HgyFabWQV8bzzWhWMQz3KvAZ-wva7x0QkGila89vq9cd3KavyGgGoUWi1dohcAgUw9XCEgGrfSNvtI_nms5GMOujyIFJ83o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeeifeelucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpedvjefhudeghedvtdeijeeigeetuedugfejueekieeltdfhteevkeeh
 hfeilefhtdenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeegpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtph
 htthhopegurghvihgurdhmrghrtghhrghnugesrhgvughhrghtrdgtohhmpdhrtghpthht
 oheprghnughrvgifrdhrhigstghhvghnkhhosehokhhtvghtlhgrsghsrdhruhdprhgtph
 htthhopegsrhhutggvrdhrihgthhgrrhgushhonhesihhnthgvlhdrtghomh
X-ME-Proxy: <xmx:HgyFaeJIEeqxszqUg1KFHXXphQCmnTUFYFQEi5PKPfrNDqwlQruojA>
 <xmx:HgyFaT8iTzZVb1mHK06AA5wa43vhjGvLE3WDvJjmSiqH_VhxUUo9QA>
 <xmx:HgyFaZJkyxkUDu5E0CZe-sKn6tMZJ577SCO0XIW8UUzovH3vz349XA>
 <xmx:HgyFaQlMI1lr5pzYPLykIMhalaYtRWVwPBrT2ghjQluGDm-wf6PyRQ>
 <xmx:HgyFaey7EgH71UofWu7kgQuglGm9KRDC7tGCWxH-7ZOHkD__xfFXyHU_>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Feb 2026 16:31:09 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: david.marchand@redhat.com,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v4 10/11] devtools: test different build types
Date: Thu,  5 Feb 2026 22:27:42 +0100
Message-ID: <20260205213044.702908-11-thomas@monjalon.net>
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

All builds were of type debugoptimized.
It is kept only for builds having an ABI check.
Others will have the default build type (release),
except if specified differently as in the x86 generic build
which will be a test of the non-optimized debug build type.
Some static builds will test the minsize build type.

Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
Acked-by: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
---
 devtools/test-meson-builds.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/devtools/test-meson-builds.sh b/devtools/test-meson-builds.sh
index 867a0a9c0c..11e4be3f88 100755
--- a/devtools/test-meson-builds.sh
+++ b/devtools/test-meson-builds.sh
@@ -233,13 +233,15 @@ for c in gcc clang ; do
 	for s in static shared ; do
 		if [ $s = shared ] ; then
 			abicheck=ABI
+			buildtype=
 			stdatomic=-Denable_stdatomic=true
 		else
 			abicheck=skipABI # save time and disk space
+			buildtype='--buildtype=minsize'
 			stdatomic=-Denable_stdatomic=false
 		fi
 		export CC="$CCACHE $c"
-		build build-$c-$s $c $abicheck $stdatomic --default-library=$s
+		build build-$c-$s $c $abicheck $buildtype $stdatomic --default-library=$s
 		unset CC
 	done
 done
@@ -254,7 +256,7 @@ generic_isa='nehalem'
 if ! check_cc_flags "-march=$generic_isa" ; then
 	generic_isa='corei7'
 fi
-build build-x86-generic cc skipABI -Dcheck_includes=true \
+build build-x86-generic cc skipABI --buildtype=debug -Dcheck_includes=true \
 	-Dlibdir=lib -Dcpu_instruction_set=$generic_isa $use_shared
 
 # 32-bit with default compiler
-- 
2.52.0

