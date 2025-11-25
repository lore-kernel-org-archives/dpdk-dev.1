Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59B13CFD36B
	for <dpdk-dev@archiver.kernel.org>; Tue, 25 Nov 2025 00:31:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3402B4068E;
	Tue, 25 Nov 2025 01:31:33 +0100 (CET)
Received: from fout-a8-smtp.messagingengine.com
 (fout-a8-smtp.messagingengine.com [103.168.172.151])
 by mails.dpdk.org (Postfix) with ESMTP id 0701F402A1
 for <dev@dpdk.org>; Tue, 25 Nov 2025 01:31:31 +0100 (CET)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfout.phl.internal (Postfix) with ESMTP id 821A4EC0218;
 Mon, 24 Nov 2025 19:31:30 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-05.internal (MEProxy); Mon, 24 Nov 2025 19:31:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1764030690;
 x=1764117090; bh=LFG2xEpSq6hHQTlHiM8t++PWQfoSSj4xaz9mBl+GsKE=; b=
 J8JX+MTkARRo1y4F++DJVtl3olZF5Ofuz32g52Eu6XAyFCee/GhBv3uYCpBYwSAc
 QTfkCcwjn07VG/pnuO9yW943nEkyiEFG6TJrdibqbnfrQ4c3Ge246TnPZTkdhVuG
 71QTp6xaq0TsF9yu7L2vhm08/LchtWrg1w2pKemw9EHiNPi9JKGrG0KnTQXlYiP0
 A8ptNO32vdZEZJskhDif95zldJ2eZURh1Hv4W7wgENuUhG9cHY2MYHepQgd62t+x
 id0Puu5egWlN6OZGAnp2u/q3DqANjmGqD35XE+EryL0sNXYw/ctPe0oPMCnggmIf
 X0faWyM2PrGJ5qvSmURReQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1764030690; x=
 1764117090; bh=LFG2xEpSq6hHQTlHiM8t++PWQfoSSj4xaz9mBl+GsKE=; b=e
 p+WCIVn10fdt/j92GOvIczXAQ8k6J/kpJNlavdybXZLmXAs68s7J7jjOW2IcfM7r
 7XiAW6yCP+tGTT/8fneVH/mi2Iq9zrmwaR7chhf2PTjRcan+yQlJcEWBZWjksB5B
 +jmkwMdJjw9a4gS/uMtdqJNwgTZ4j5ANvFYIzUwT69N9XC6DNA0CSezb5J6fn7/B
 ckCK10iYs8g1a6imyLKZjWpCrsJQHQ4wq6ISoiyL5RDsRPWRg75KLDUsCtqE7kc0
 OPYAr7m12u8qspGucLYJoUWeAToYO2+rOE0hU84IDDVQCee7xWAS6fubTlvOsMTq
 rboGWV4WP4cmNrEwZPOyg==
X-ME-Sender: <xms:4vgkaYlJMRvJVfUIbcED-fwrvNzxABtxMSTdl-C9t8xsHD3a6GYv8w>
 <xme:4vgkaVpzeU3jx_TEDyEyeFH_wNidGY9BAIcokFh-p5YDj_Sf8OJouEV8I8esKITBa
 1ZFMM9if1ENI6tbL1wazuKYnUIviBdtgZimSUtCCaSIaIRsHMx0>
X-ME-Received: <xmr:4vgkaREvkircgZ-r9QgxCMxkEHNcgvmz2dkjZ_Npogk1zp5xn0-HlXQVFdxYoX3zeGyz39C-Q1FwuHSuCwaZ93SXFQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvgedttdehucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeegpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopegrnhgurhgvmhhuvgeslhhinhhugidrmh
 hitghrohhsohhfthdrtghomhdprhgtphhtthhopegumhhithhrhidrkhhoiihlihhukhes
 ghhmrghilhdrtghomhdprhgtphhtthhopehrohhrvghtiihlrgeslhhinhhugidrmhhitg
 hrohhsohhfthdrtghomhdprhgtphhtthhopeguvghvseguphgukhdrohhrgh
X-ME-Proxy: <xmx:4vgkaRyeyealgCLF9Dd5ze0LWrLBZlT8NFkm-Gco02NEHWzVCaCbvg>
 <xmx:4vgkaWqNoPkZwHSw_inJMD3pemMDaq_Oged8cyEggL46hw13h2ID8w>
 <xmx:4vgkabhYTu1aOoXENu6TIPwTgejJyaNLvVNGxQJy3Y2kRDNbz7Zm4g>
 <xmx:4vgkaTipw2ooQ8H00GNVZcA2fyRTMu7dx619xRLZ9O9hL2dGCjuITA>
 <xmx:4vgkafi37L1X7w3jDaRdvCpZ-cWHcJWal99-RzZXA7_1zzk6bLVfTxHb>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Nov 2025 19:31:29 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Andre Muezerie <andremue@linux.microsoft.com>
Cc: Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>, dev@dpdk.org
Subject: Re: [PATCH] doc: update instructions for Windows builds
Date: Tue, 25 Nov 2025 01:31:28 +0100
Message-ID: <41014322.10thIPus4b@thomas>
In-Reply-To: <1762915315-6610-1-git-send-email-andremue@linux.microsoft.com>
References: <1762915315-6610-1-git-send-email-andremue@linux.microsoft.com>
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

12/11/2025 03:41, Andre Muezerie:
> Updated some external links and removed a note which does not
> apply to MSVC builds anymore.
> 
> Also reworded a sentence clarifying how to open a Visual Studio
> Developer Command Prompt from CMD and Powershell, as the
> original text could induce people to run VsDevCmd.bat from
> a Powershell prompt, which does not work.
> 
> Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>

Applied, thanks.


