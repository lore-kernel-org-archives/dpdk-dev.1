Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 706FFC369A1
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Apr 2025 07:47:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5BA5E40E43;
	Tue,  8 Apr 2025 09:47:32 +0200 (CEST)
Received: from fout-b2-smtp.messagingengine.com
 (fout-b2-smtp.messagingengine.com [202.12.124.145])
 by mails.dpdk.org (Postfix) with ESMTP id BDB494027F
 for <dev@dpdk.org>; Tue,  8 Apr 2025 09:47:30 +0200 (CEST)
Received: from phl-compute-03.internal (phl-compute-03.phl.internal
 [10.202.2.43])
 by mailfout.stl.internal (Postfix) with ESMTP id D3CBE1140124;
 Tue,  8 Apr 2025 03:47:29 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-03.internal (MEProxy); Tue, 08 Apr 2025 03:47:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to; s=fm2; t=1744098449; x=1744184849; bh=8v3QBvfalmmv6rF7YsuKT
 MemAc2WqkM1O0zl2ldTi3Y=; b=R5ti+ms40N3bQJQQCzAa8a8dTJ4RpiVQKkiRx
 yffg3aEnQi9ED3rIIG6/z4oV7ZAirrZH+0bjjwIivpZ3CpExqIUItsAMbCFeIPWr
 LRFDLF7iWHqjzt87o66NkE3f1LMTTrqHGWgbaN65DrmFU1v28TD3TK/LtXgnzPzD
 PMClY25e14Hz1NUDbHqq33f8DWDza3/gQ/DbK1tHCASLQQMTG0v1orMRMXw3kq2I
 jjt4WubAtxcp15mA90WvomfxBDKKBsI+3I+aQSq1SjG47LOYe8VZCpl1lWT3A3KG
 hrsWr7vizE6a/T8/q+t8fYalgVActFhd+9XR7ZzGOLIBA+qYw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
 1744098449; x=1744184849; bh=8v3QBvfalmmv6rF7YsuKTMemAc2WqkM1O0z
 l2ldTi3Y=; b=Ncg+E0E8qzDEFhp/eLycrGC4U/XTig3h65ycaQ/VrT8Aa2l1lkD
 4UCnNmVzyY87M18DO3c580IVHpIsWkXDf88bDEb4Y+r1UN1OhKG9wwcYRmNchmYu
 Itqx25HiJkusWWVHt8W41io+UFtVQlw8oc9B/pVY7pIeBtCXD3OjDQrpCf3RwbfX
 soUSdqiizp/aI58xuj0Gf3dQiFQSNvRqQ7aanNDHaFy2vlssdyRZFsGfMVPeU2e+
 d70G3bEcFe6Pmx684svmdF3/Zn+XSSbGT7NB31LgEfON7knbUNIKFSrzQPady7QP
 zJGt2vRUAjivm8H/ms39RC3qd7DNom6ryHg==
X-ME-Sender: <xms:kdT0Z2A2uEGWSJeNdfuiC4hk4ShvXis2frH7JXyo_4B37tbfPSdMlg>
 <xme:kdT0ZwiDvyRlXTdi8bKXU_clhwlNi1pU6TJ5JxPh__1FI1UBJNR7Xr1a11zoqx_i4
 ol71p0rP29MwqwOgA>
X-ME-Received: <xmr:kdT0Z5lSBGjHi1L9O_FDti5Aqy7cInyM40SpmYF2fb4AeyFNn3Q89rtywFO5sD1GVG39tO-bjLAXjzKwxFih9XnGwgUCn9s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtddvhedvucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
 pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
 gvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgggfestdekredtredttden
 ucfhrhhomhepvfhhohhmrghsucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrg
 hlohhnrdhnvghtqeenucggtffrrghtthgvrhhnpeevveefveeiiefhtedukeegkeelieeg
 ffeukeevudetueffieduveetiedukeefleenucevlhhushhtvghrufhiiigvpedtnecurf
 grrhgrmhepmhgrihhlfhhrohhmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhn
 sggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopeguvghvse
 guphgukhdrohhrghdprhgtphhtthhopegrlhhirghlnhhusehnvhhiughirgdrtghomhdp
 rhgtphhtthhopegushhoshhnohifshhkihesnhhvihguihgrrdgtohhmpdhrtghpthhtoh
 epvhhirggthhgvshhlrghvohesnhhvihguihgrrdgtohhmpdhrtghpthhtohepsghinhhg
 iiesnhhvihguihgrrdgtohhmpdhrtghpthhtohepohhrihhkrgesnhhvihguihgrrdgtoh
 hmpdhrtghpthhtohepshhurghnmhhinhhgmhesnhhvihguihgrrdgtohhmpdhrtghpthht
 ohepmhgrthgrnhesnhhvihguihgrrdgtohhmpdhrtghpthhtohepuggrvhhiugdrmhgrrh
 gthhgrnhgusehrvgguhhgrthdrtghomh
X-ME-Proxy: <xmx:kdT0Z0wN_EPGJHuWa7xalIm05UYOyeNNq93csJJHGyqQskfJ0NyiTw>
 <xmx:kdT0Z7S1l8zrTwoDRXrAQSeZqZAFhCPXc4AyX_eiZi7cWrOeOaMohQ>
 <xmx:kdT0Z_axroTGl3R8AyYp6BKuDUy8tJOQQYLtmQOm1rdQHkfp-bDHhw>
 <xmx:kdT0Z0RbqkeBfHvQ5U6u8A1axakiAK4WPfTFJ_VumvpSbDIvj0Iffg>
 <xmx:kdT0Z3Gvolxdt-Sc9K09JIho_DW6YAk-dfR1jInfw-UuFCpWjcZgmfx5>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Apr 2025 03:47:27 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: Ali Alnubani <alialnu@nvidia.com>,
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>,
 David Marchand <david.marchand@redhat.com>
Subject: [PATCH] common/mlx5: fix build on Linux in dlopen link mode
Date: Tue,  8 Apr 2025 09:47:17 +0200
Message-ID: <20250408074718.1322823-1-thomas@monjalon.net>
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

When using the Meson option "ibverbs_link=dlopen",
a glue library is built.

After the recent change requiring eal_export.h,
the build stopped because the internal EAL include directory
was unknown to this glue library:

	drivers/common/mlx5/linux/mlx5_glue.c:19:10: fatal error:
	eal_export.h: No such file or directory

Fixes: c7020bb20fc7 ("build: mark exported symbols")

Reported-by: Ali Alnubani <alialnu@nvidia.com>
Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
---
 drivers/common/mlx5/linux/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/common/mlx5/linux/meson.build b/drivers/common/mlx5/linux/meson.build
index 58d0328c6d..5548a56199 100644
--- a/drivers/common/mlx5/linux/meson.build
+++ b/drivers/common/mlx5/linux/meson.build
@@ -237,7 +237,7 @@ if dlopen_ibverbs
     dlopen_sources = files('mlx5_glue.c')
     dlopen_install_dir = [ eal_pmd_path + '-glue' ]
     dlopen_includes = [global_inc]
-    dlopen_includes += include_directories('../../../../lib/eal/include/generic')
+    dlopen_includes += include_directories('../../../../lib/eal/common')
     dlopen_includes += include_directories('..')
     shared_lib = shared_library(
             dlopen_lib_name,
-- 
2.47.1

