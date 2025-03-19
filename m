Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F511C35FFB
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Mar 2025 04:14:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8CF85402C4;
	Wed, 19 Mar 2025 05:14:48 +0100 (CET)
Received: from fhigh-b3-smtp.messagingengine.com
 (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
 by mails.dpdk.org (Postfix) with ESMTP id F2A824025A
 for <dev@dpdk.org>; Wed, 19 Mar 2025 05:14:45 +0100 (CET)
Received: from phl-compute-05.internal (phl-compute-05.phl.internal
 [10.202.2.45])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 20D312540211;
 Wed, 19 Mar 2025 00:14:45 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-05.internal (MEProxy); Wed, 19 Mar 2025 00:14:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1742357684;
 x=1742444084; bh=vdC2MbNdVNSJCAiBWElFaX05z0Q2jf5dVSvCaNEoles=; b=
 TcKqZ5V3OOu5WIGF4elXpBoVArTzB5LVtpR+DDwEI1vmoUt421GzT5rmFmB4QpYm
 jgdaUtEb58msNlNe55aMZSnOtqAorSjaxnOG5mWNy5S2X95iNiX2p+rgLpO7EqXV
 qiMCGTFTseTnl62/ShlJ5aBruiNSe5vPuTAh1FqkOVnpdY8PhlElOKUEIEj7Erwv
 96jEoOj7F4D6By26n1UnsT3p2dmqj7RZA3NzK3sNwBEC0owQ72yWVz+zqzS/5wyL
 gZZetG8BDcNZQGBNB24kqmtYQyx1nJpP67gUI6I8HYX1KAOMlppP6HPLUhOhFv54
 R/PJSVWTuxPEUdY3Vxq8ww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1742357684; x=
 1742444084; bh=vdC2MbNdVNSJCAiBWElFaX05z0Q2jf5dVSvCaNEoles=; b=Q
 x996O0ybYOAjus83cORInfMd56hDxauXSqWz/Gfx6okTiaQtpMwARqE83PD1zgWM
 a69IFFR4CAArY7xmrRNouVwdgP59D5JxCeHKN6Y6kNz8YISbIWJdTS8+gejDmlnd
 bCl9MfAzKRdAvrSvHtiLBQsHJST5ocMpfjul5OTSRuF8sbOH4eMdkSnZryf6StSz
 hic9Amj2EScMB2HnMmDV2imwKC3hNQvxK1Llnqh7t2jbqhmfeLLNQSw4sW2sT237
 GmmPA8tRamfQCz4l6tgr4jEeGcfI8/KvbyTgtR/6J+DWLG7HyRA1Ncm373s33MCJ
 yuVXtgfq4tKiMUQOVBSeg==
X-ME-Sender: <xms:tETaZ8eSo3j--Sy4fAjwQ_ptRlx3fiSauh9SIudXvYgwCLZ1q_ptnQ>
 <xme:tETaZ-Nk7nxOjxJOnhOzzGWm_SgxnY03JJswaOOv69tgOJ-HTk_gtgbxiJ3-i-CJL
 aNMnguyVg13Xzka5A>
X-ME-Received: <xmr:tETaZ9g-yTJTKsty8uuhb7ADn_Mqx4zIQBeBpBppiMfuh4y642rbzgR0S51ASTeBLvk4o4PYisLdvAyqeGW_SbQJzg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeegfeegucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
 pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
 gvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddt
 jeenucfhrhhomhepvfhhohhmrghsucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonh
 hjrghlohhnrdhnvghtqeenucggtffrrghtthgvrhhnpeekfeehfedtgedtjeehueeutdfg
 leefieevkeeikeelkefflefgtdevieehheffudenucffohhmrghinhepughpughkrdhorh
 hgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepthhh
 ohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohepfedpmhhouggvpe
 hsmhhtphhouhhtpdhrtghpthhtohepsghruhgtvgdrrhhitghhrghrughsohhnsehinhht
 vghlrdgtohhmpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpthhtohepkh
 gvvhhinhdrlhgrrghtiiesihhnthgvlhdrtghomh
X-ME-Proxy: <xmx:tETaZx8-KfLMo5ft66XgTTm12fOYmH9UsnPhIPa7CR77c_ZYJFdy2w>
 <xmx:tETaZ4sRN4xjy54qrCDSXBVWr3SMFujR5x6ee-djSawKlQng87a4uQ>
 <xmx:tETaZ4H2P2Th9ykHYSf7eIISV0EDP2UTZqI4S66loblMTykLcu5oYg>
 <xmx:tETaZ3NsPbYUjFo4fK9LAkbaWyYam-nqb_uIHqvIxG_0WRHeSxC7pw>
 <xmx:tETaZ0JLpktIJXkaT22pChz3qorml32Rh2OesaKiTyQhxccOqSyUBqzi>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Mar 2025 00:14:44 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, Kevin Laatz <kevin.laatz@intel.com>
Subject: Re: [PATCH] doc/dmadevs: clarify naming constraints for idxd devices
Date: Wed, 19 Mar 2025 05:14:42 +0100
Message-ID: <45228823.doPnVEEUbh@thomas>
In-Reply-To: <e0f6beea-80d1-47e1-a519-e8d3a6a8183a@intel.com>
References: <20250131144915.2129736-1-bruce.richardson@intel.com>
 <e0f6beea-80d1-47e1-a519-e8d3a6a8183a@intel.com>
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

18/02/2025 16:44, Kevin Laatz:
> On 31/01/2025 14:49, Bruce Richardson wrote:
> > The requirement to have DPDK in the DSA wq name is given in the idxd
> > chapter section 5.3.3 [1]. However, that information should also be
> > given in section 5.3.1 [2] where we list out the fields to be set and
> > what values they should have.
> >
> > [1]https://doc.dpdk.org/guides-24.11/dmadevs/idxd.html#device-probing-and-initialization
> > [2]https://doc.dpdk.org/guides-24.11/dmadevs/idxd.html#intelreg-dsa-devices-using-idxd-kernel-driver
> >
> > Signed-off-by: Bruce Richardson<bruce.richardson@intel.com>
> 
> Acked-by: Kevin Laatz <kevin.laatz@intel.com>

Applied, thanks.



