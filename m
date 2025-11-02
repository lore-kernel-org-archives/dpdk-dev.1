Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83E30CCFA02
	for <dpdk-dev@archiver.kernel.org>; Sun,  2 Nov 2025 15:56:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A6427402DE;
	Sun,  2 Nov 2025 16:56:50 +0100 (CET)
Received: from fout-a8-smtp.messagingengine.com
 (fout-a8-smtp.messagingengine.com [103.168.172.151])
 by mails.dpdk.org (Postfix) with ESMTP id 7C46F402D5;
 Sun,  2 Nov 2025 16:56:48 +0100 (CET)
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
 by mailfout.phl.internal (Postfix) with ESMTP id EA604EC011D;
 Sun,  2 Nov 2025 10:56:47 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-09.internal (MEProxy); Sun, 02 Nov 2025 10:56:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1762099007; x=
 1762185407; bh=wdIA9/9o1/+Im2ZLiAZ/OlwBwGaq3WMFnIoedkkfGNY=; b=r
 LH8vTPeCVkU0c0yU9T6S8rzTcrPZEeZI3va9s4egLUzTxYKAsx8mfOmHyroi/jCW
 ACx4562q1nLk78GA1MzyONqjqsqMPFPU7wTn+zCaiK4ROtkHrtUNG2TyqLsU4ezJ
 VSX7QuxYVELH4Eqxe9HOFQj2Q22yVUoaBP4+A/UxkFgcicum0vXpk4Kbh+mNssPA
 PjyWdJ5bQo/6mVTB2dr2cv/8lWqcDTEBuw+Vm5MeLXrFbvGgCF81XCpCQjHx5/KF
 /GivUKoFVBNSC3fPkZfJeshZyBkY4JGM878WAdwn7q8XDp7eiEfQtNF7wZM1bk1m
 wLTENWibevOp5Vtie8mcw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1762099007; x=1762185407; bh=w
 dIA9/9o1/+Im2ZLiAZ/OlwBwGaq3WMFnIoedkkfGNY=; b=MeUWXaaGznuubM5An
 2K6NdtGN2rcataTUBWWp/xQ41oDznj9hw48FTYPYjDkfyAjxSTN5+9PGOm2XZ7NE
 znyeWigog5IeW4YnqbcBqVGtrCb8YoqWAhsROhnmZBSs4p9XwpKsmK5Fg/uE3JhV
 EqIKNFNRTtV8cz4kf2lIsKJKRJkevxBziQta+9gz7E1zjfFXQ4IbVI3gFj/YnMdB
 Tuf4rt/d5uOvmpReZLI/jWH/8M3WGDyIG7tpzZQJiwqJxp+aXf2kC+hCJpVu1jub
 yxWEkufTnl/aIIZf3TN7DIhhC3Llj7+3I63Co7E5HNeDbuA7jJkIahc921x8F4Xo
 8bvog==
X-ME-Sender: <xms:P38HacCg1pGx2aKKMicDfERcz2ognH0Lh4jZIHZLK-7E2afzpAT1yw>
 <xme:P38HaXdLy6ET_CbM6QTCRi3myfhlJYaSv4kzPbmkmiXTGf3h7Pr29NfvDFJhmLw9i
 84PtALdp_hORoH3vHSEv42Pvf4QMpkTqH4WMYZZu4OvAosxEfGjKQ>
X-ME-Received: <xmr:P38HabJTSaOmITK3DXivxmo2GAlpRIoWtyZukyjNZZUbJ7Y_RqLYmImnfoYIEMQ0Ao-qDahTkRXFb137uiW0gaCQ1w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujeehieeiucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpedvjefhudeghedvtdeijeeigeetuedugfejueekieeltdfhteevkeeh
 hfeilefhtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeeipdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtph
 htthhopehsthgrsghlvgesughpughkrdhorhhgpdhrtghpthhtohepmhgrthgrnhesnhhv
 ihguihgrrdgtohhmpdhrtghpthhtohepvhhirggthhgvshhlrghvohesnhhvihguihgrrd
 gtohhmpdhrtghpthhtohepmhgrgihimhgvrdgtohhquhgvlhhinhesrhgvughhrghtrdgt
 ohhmpdhrtghpthhtohepgihuvghmihhnghhlsehnvhhiughirgdrtghomh
X-ME-Proxy: <xmx:P38HaS3Q8-LsKvYEGov1bwVpRnOM-Sgs8ML4kt-l1i4mmr3NwNJWnw>
 <xmx:P38HadhrF-cIuKk41CUziSTbvUI9kmYZW_8CwMIhU7sx8agl-vRW_Q>
 <xmx:P38HabVq6g4ILL6SgquGU8csFJrcRsK7_F-hL6f4pg4cSurlI4f4NQ>
 <xmx:P38HaUXc_7AsUAsnqqed_Kgjsvp2CPCZGAqOstdT6eSaZizLKKzlPw>
 <xmx:P38HaXxBKyrV2t7RB704zK-E-0WR425bg--tFO9wfwr9hXbU3j1t_Z9v>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 2 Nov 2025 10:56:46 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: stable@dpdk.org, Matan Azrad <matan@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 Xueming Li <xuemingl@nvidia.com>
Subject: [PATCH 1/5] vdpa/mlx5: remove unused constant
Date: Sun,  2 Nov 2025 16:53:00 +0100
Message-ID: <20251102155617.4001783-2-thomas@monjalon.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251102155617.4001783-1-thomas@monjalon.net>
References: <20251102155617.4001783-1-thomas@monjalon.net>
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

The constant MLX5_VDPA_DEFAULT_TIMER_DELAY_US is not used anymore.

Fixes: 99f9d799ce21 ("vdpa/mlx5: improve interrupt management")
Cc: stable@dpdk.org

Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
---
 drivers/vdpa/mlx5/mlx5_vdpa.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/vdpa/mlx5/mlx5_vdpa.h b/drivers/vdpa/mlx5/mlx5_vdpa.h
index a398aa22ce..06155d2405 100644
--- a/drivers/vdpa/mlx5/mlx5_vdpa.h
+++ b/drivers/vdpa/mlx5/mlx5_vdpa.h
@@ -38,7 +38,6 @@
 #define VIRTIO_F_RING_PACKED 34
 #endif
 
-#define MLX5_VDPA_DEFAULT_TIMER_DELAY_US 0u
 #define MLX5_VDPA_DEFAULT_TIMER_STEP_US 1u
 
 struct mlx5_vdpa_cq {
-- 
2.51.0

