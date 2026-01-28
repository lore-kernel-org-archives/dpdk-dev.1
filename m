Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A68B3D25B47
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 Jan 2026 12:00:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5A24640671;
	Wed, 28 Jan 2026 13:00:32 +0100 (CET)
Received: from fhigh-a7-smtp.messagingengine.com
 (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
 by mails.dpdk.org (Postfix) with ESMTP id EC57D40671
 for <dev@dpdk.org>; Wed, 28 Jan 2026 13:00:28 +0100 (CET)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfhigh.phl.internal (Postfix) with ESMTP id A4D75140015A;
 Wed, 28 Jan 2026 07:00:28 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-02.internal (MEProxy); Wed, 28 Jan 2026 07:00:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1769601628; x=
 1769688028; bh=QKtORE5ACAi9oCrumSvcD73103Wlg7Alnp4GAOQgUzI=; b=X
 bvAXd/7y1mAqT4P1KF5V+xDVViuI775+CpuwBVg0lH5FPj3b83MU/iNeFN+ofg+4
 X+hON0SlQaiIiIxvNbYxOxk/7zX/9BAnpGnnztCcJ0A/s4jcUz7azU/OaxKFYm3E
 aaP+y/QnHoetMSf8nX7mZFDaDkXyIhMu9TmtBocY/LWm+UobFWzBirZwp7nnkLUP
 G2Xrx3aQh9IGmDNrHNHFP9GiHmSsf4iSJXIadbX01umh2bNLSHcgis/6IAkS4bJI
 jSkF5OogpjqQjy5gX9bIXzwvfCx2ZkXKchFWE6AxOb7oI6lkd9Rw9r8ebS9gQDoj
 9UUki/zdNnv7NL0drXA1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1769601628; x=1769688028; bh=Q
 KtORE5ACAi9oCrumSvcD73103Wlg7Alnp4GAOQgUzI=; b=in3yAcPyczFaW9eVl
 0fSaQgaLf03CHCpmY/iBzs3AshLDeNSasx3ZEpFd9D0EWaltYtk5zQrTfwN+EzLk
 UAaVop6vMH89ulVgwM8NMVtqYe6SMWdwNM9xEKnkB4nLot2lTAZLNlxKTaB+lybm
 PqRfXjC9ZZA2ho9UCvBTPpzME4+NzH620SgBY8X6lw7/LADeJD/7C7I0elCbbDbA
 MxDHwrTPcCI8SrqqEJuCOJHzDbmlG7l6ZABryvsYMW3U9lIq5M4eoOVG/e7t/1zb
 7ghXh7h7h7b2EQv2AzrNVo+QICePTe7wOMKUpphbycS2cQ4YvwDd3UH+igujvuPk
 MWimA==
X-ME-Sender: <xms:XPp5aXSWF-6HGxe8MesDXVGvEHt-AYM61xIreYLOWiiuOwsYK_2fPg>
 <xme:XPp5aY7IuObnnl5N4L2PmzrvlCQR4omUr5DS6QPHAcmAnn_FfLDffKQCtmPfL-o7y
 imjosXyhBj_AKkXGhvqbKCsfBs3BfDYBtUhFie9d3coSmucPDyQ>
X-ME-Received: <xmr:XPp5aUwCmLWgsqLgEmqNrP_OyRSehYlIXtB61P1p6CAiI3y7lpXyzHK3diepNNcZvb8qhIPIf7ZmYI3r3XbYP8GNe4eTjHQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduieeffeduucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpedvjefhudeghedvtdeijeeigeetuedugfejueekieeltdfhteevkeeh
 hfeilefhtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeegpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtph
 htthhopegurghvihgurdhmrghrtghhrghnugesrhgvughhrghtrdgtohhmpdhrtghpthht
 oheprghnughrvgifrdhrhigstghhvghnkhhosehokhhtvghtlhgrsghsrdhruhdprhgtph
 htthhopegsrhhutggvrdhrihgthhgrrhgushhonhesihhnthgvlhdrtghomh
X-ME-Proxy: <xmx:XPp5afQCCE3tm9lJzpADFLy68Eo7bhHKgfX2ckRs3sFIuFW8GOUiWA>
 <xmx:XPp5abWH6r0SGnIYjPQNnQoy3vxgDtWbixq25prOBMRQFnxwO_WHgw>
 <xmx:XPp5aRZ0xHyhib1PbcudrENEbggWl6diaHGiD5ZCrD6bjd3hgf5THg>
 <xmx:XPp5aR1nemWZprtH6byxIC-wpge9jK5dKs5cOET7px4KWj7SyWG4fA>
 <xmx:XPp5acdieVUu6LBAgNtRA8uf7pIc3qUw0eADWl72NuMou0FYD3kBM1zd>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Jan 2026 07:00:27 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: david.marchand@redhat.com,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v4 4/4] devtools: test different build types
Date: Wed, 28 Jan 2026 12:58:33 +0100
Message-ID: <20260128120005.2777473-5-thomas@monjalon.net>
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

