Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22EF1CCD1BE
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Oct 2025 14:52:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4DDDC4025E;
	Thu, 23 Oct 2025 16:51:59 +0200 (CEST)
Received: from fhigh-a7-smtp.messagingengine.com
 (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
 by mails.dpdk.org (Postfix) with ESMTP id DD77E40151
 for <dev@dpdk.org>; Thu, 23 Oct 2025 16:51:57 +0200 (CEST)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 849EF14000BB;
 Thu, 23 Oct 2025 10:51:57 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-04.internal (MEProxy); Thu, 23 Oct 2025 10:51:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1761231117;
 x=1761317517; bh=sIBJ9l6me2LcxROF8TALDDU2bCczsNiVNHtNw094M+A=; b=
 FJKZSNYZXK9DbXsfRUSyxLNltksnMUH1H4fNwt3akvDvxymtNRHKPSOPJsseT83K
 cNxXBEj7FPwP3qoPrtwtdKzelE9f97NdpodBJfW2TiDgq/V0UtSmPpSi6TGNYSg7
 mc2YryJsD5uXOUHj1rLjqgmiv1kwxCXLO8wm+fpcKCVjttqZRd1q2Ib0birp/PpV
 DJuT4ieCLTZs5fVDf+beUirAkvqt853uEPgZNHGBYJ8ZlywOye9Y4p5SPEdTfO4G
 tnD5ktGSakWvS+v08aR5ijWQDGFZqnbd7Hjo2Qjw2vNZLo1ptDRQCvabrTVa6H06
 0Fpa4kCYXG07ZI2xEcm8lA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1761231117; x=
 1761317517; bh=sIBJ9l6me2LcxROF8TALDDU2bCczsNiVNHtNw094M+A=; b=x
 tYsTvYpYnjIl0aETATP+7epJpbE8GLTW1XLcwIadCs8lP4A0bK8H7yzvQhglb5Cx
 fZbe0ut6BSK/DNsN4iQ3xuR8fL79q9QWRd1ouYCe8tcwiMEqGnv839fxyOdvKSCj
 VfNrMFGdcl8ghyqBdcS89+4ZtwRyoNqOYoGzUK1Yz05Q3wMERMcbBnUx5vs9vv1N
 ZIlOBDnOY7ETljV9CbCL1VDbydwELr/5MsD1Z4O2aUfy0oPGgFOJe0EUOKYS2q/J
 lam54FOzI2ca9ozjGtHMcKWKEu3zrC6Eosd8BEUbfoyDHGhion8Dce2V682P0fIr
 EH/1qGKMDTwt6HOx/zzOg==
X-ME-Sender: <xms:DUH6aNBjZXNhGpQPp41s2NQV3w59-eginMZSLVqdRRNp8CSgVs8AWA>
 <xme:DUH6aH1MQ181DL9WeqovIIPhwRTMdccfU0efiEB_vV0j5iMhS7d1GoxFX24e-HD9P
 BlkzqIXZWRDYGBoppFT8Kzogs_Rp0T3ra03ZL4T_OGfSQvQ8rIC2fs>
X-ME-Received: <xmr:DUH6aLXomv7RzN-cg-mDuIg6QFS9HMO558vxodQSPOFCGPN60kxQEKucpYaPO6o0KAhLkf3wdBumYVNxTKkLnu-VCA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeeijeegucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopedvpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopegrlhhirghlnhhusehnvhhiughirgdrtg
 homhdprhgtphhtthhopeguvghvseguphgukhdrohhrgh
X-ME-Proxy: <xmx:DUH6aJlSd-ofGa4Vd6ewcG9HHLmgZt9KBQ35U1fNKrVH15-39XJl9w>
 <xmx:DUH6aFCXWBC-9ToubmwPLsx0-GwpuVRB7DfW-HmVQqhjsgKFOVa7bQ>
 <xmx:DUH6aBeWRJOAeI426TBkkTHnQyGszXqDf0Fwpaw1g9rH20XdxAc5kA>
 <xmx:DUH6aIIPB4wQj7cSeb2p3csV-CdzHBaDGiTpBRoe7FrPnLD0v_Tneg>
 <xmx:DUH6aMBP3xmjjno4a3vqgtKNAwPkXE8TaK8Dhd-To565f8aaOr2FhV5_>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Oct 2025 10:51:56 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Ali Alnubani <alialnu@nvidia.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH] devtools: honor -n flag regardless of stdin state
Date: Thu, 23 Oct 2025 16:51:54 +0200
Message-ID: <26063275.kmuVQn2iE0@thomas>
In-Reply-To: <6805909.NeCsiYhmir@thomas>
References: <20251014074340.2364328-1-alialnu@nvidia.com>
 <6805909.NeCsiYhmir@thomas>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
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

23/10/2025 16:33, Thomas Monjalon:
> 14/10/2025 09:43, Ali Alnubani:
> > The checkpatches.sh script was checking if stdin is a terminal before
> > honoring the -n flag, causing it to incorrectly attempt to read patches
> > from stdin when run without a TTY (e.g., in Jenkins/CI pipelines).
> > 
> > Reorder the conditionals to check for the -n flag before checking stdin
> > state. This ensures the -n flag takes precedence and the script checks
> > git commits as intended.
> > 
> > Signed-off-by: Ali Alnubani <alialnu@nvidia.com>
> 
> Applied, thanks.

After a second thought, I did not push it
as I think we should improve the check to make
the option -r a priority as well.
Then the title would become "check patch from stdin only if nothing else".


