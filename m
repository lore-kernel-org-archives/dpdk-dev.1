Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 181A61075286
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Mar 2026 09:27:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6297E4025D;
	Thu, 19 Mar 2026 10:27:10 +0100 (CET)
Received: from fhigh-a8-smtp.messagingengine.com
 (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
 by mails.dpdk.org (Postfix) with ESMTP id 310B74013F
 for <dev@dpdk.org>; Thu, 19 Mar 2026 10:27:08 +0100 (CET)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfhigh.phl.internal (Postfix) with ESMTP id AA2A81400233;
 Thu, 19 Mar 2026 05:27:07 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Thu, 19 Mar 2026 05:27:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1773912427;
 x=1773998827; bh=tN0cL+wjYUPytbjb3sEBARyd59j470PKps6OY3Z/Hok=; b=
 CauyowBGPkloiWxGp3gHTNJyp0Ya1ZC+2Auhg2swyJd3Q3hY99sR06Yono9DUJaN
 O/Hlph8XrmDIGlpszREHOiKng2pe44H4Opn66eVlWx05BFrCQTpI+VKOnSVozL/E
 2r3goOWdEW1a520icxzUGHiVNb6X11k6mnqMDWQdeUj4gJ02MGBpyiQtA0/Y3M/O
 30eXawvQOSvgkFaG1Mcoq36H099mV0D9Km+ihzDPhdkUcRBGKfw+xqHJ67GRluqV
 WTnnbPsSBsJxigAejukCw5d/UIG4/3TMzf+NNHskrNATqA/1sZ3epnsJMc7ZZBoc
 LJPgxySmREgFPv1X1ZsmWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773912427; x=
 1773998827; bh=tN0cL+wjYUPytbjb3sEBARyd59j470PKps6OY3Z/Hok=; b=5
 4v4dOusTAyPmU3sloD+0jW4KsOrBDbGm905S2u2ZjNfZ+pNoPODqhgzmUi6ojR1u
 Uyvy8GX4vnbAme/IxDq7TmmJR5J0jw/tP92uGtHn9YOvp/IBXFchd2N0wASOCDZu
 TiDodFaYvnM99a3XY7P5XKLS6xpH9+tDyGZDAi0cqjZMg/UGTuK3soQk0LKGDSCk
 oM4VRlKUP1a8sHJsOMjc1cxoESP52+O2ElDSC0ZW5NoUx+JNwAyFWt4RZAGFPC2Y
 jmcamCw/mT6ygcXyynzC2copQF8jZG/KLNxtnEb102PZsKGtS9KGX6FOZsineORL
 WVZTZIYiuvkht3u1oQkJQ==
X-ME-Sender: <xms:asG7aepd3pjFoZhfuFH3Qn4BaGkkgJx6iQAUXItVFc4Bk9g3M9Y96g>
 <xme:asG7aUEwmBBOuMLaJ2ovC8tNZ0vJj7-wRn9iTsWi_h5TiwSUfipKRO6c-DfnOeLKh
 vJWV_G8Vn-bjoNYYNEuD7aEnzx_l3zY6hvPz0sXnhmBtaAGzfMaD1E>
X-ME-Received: <xmr:asG7aQn6kNrePgIDOelRX3zs_8ZK2vXQawWCYw0rsgjcsdvf_nFZegfXB3QTXC50IoZdAWW8v-ytCUpC4Srx>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdeiieehucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeekfeehfedtgedtjeehueeutdfgleefieevkeeikeelkefflefgtdev
 ieehheffudenucffohhmrghinhepughpughkrdhorhhgnecuvehluhhsthgvrhfuihiivg
 eptdenucfrrghrrghmpehmrghilhhfrhhomhepthhhohhmrghssehmohhnjhgrlhhonhdr
 nhgvthdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
 epshhtvghphhgvnhesnhgvthifohhrkhhplhhumhgsvghrrdhorhhgpdhrtghpthhtohep
 figrnhhgrdhjuhhnlhhonhhgudesiihtvgdrtghomhdrtghnpdhrtghpthhtohepuggvvh
 esughpughkrdhorhhg
X-ME-Proxy: <xmx:asG7aXkPdYeSYB7oAghm8C8bnQIUgg1iZ-35Vly3NPpvGA21W40fhw>
 <xmx:asG7aRvIq3QGP7M_Cw0nA0BlMF0qTEmoInqivWpx65g4EtGoWX8N-g>
 <xmx:asG7aan2YfBqYuIQtMFL5AXslMuioqaO6WAcIZDjZ5_hMjJCvlYo7A>
 <xmx:asG7acvl8LwwruPUJ6Dwqj4BggUcbnjroPuKL_VP14sbFqwnAkeYeA>
 <xmx:a8G7aQwDqcvY5ir6OtPd0YKRPgfRSqVJnThzYSiyU3mhPef81QiYLv9f>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Mar 2026 05:27:04 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: stephen@networkplumber.org, Junlong Wang <wang.junlong1@zte.com.cn>
Cc: dev@dpdk.org
Subject: Re: [v3,
 5/5] net/zxdh: add support for GENEVE TSO and Rx outer checksum
Date: Thu, 19 Mar 2026 10:27:00 +0100
Message-ID: <2726644.9Mp67QZiUf@thomas>
In-Reply-To: <20260319055356.648384-1-wang.junlong1@zte.com.cn>
References: <20260131062208.2445121-6-wang.junlong1@zte.com.cn>
 <20260319055356.648384-1-wang.junlong1@zte.com.cn>
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

19/03/2026 06:53, Junlong Wang:
> > > 18/03/2026 03:21, Junlong Wang:
> > > > Sorry, I have a question.
> > > > Some time ago, I submitted this patch ([v3,5/5] net/zxdh: add support for GENEVE TSO and Rx outer checksum),
> > > > which was marked as accepted. However, when I fetched the latest dpd-next-net code, the for-main branch did not contain it.
> > > > 
> > > > Could you please let me know if I need to resubmit this patch?
> > > 
> > > It seems that the commit is merged but without its content:
> > >     https://git.dpdk.org/dpdk/commit/?id=2aa7e28b41
> > > 
> > > It looks like a mistake during a next-net rebase.
> > > Stephen, please would you be able to find the original commit
> > > that you modified in your reflog?
> > >  Or I could get it from the mailing list if you didn't change it too much.
> 
> > I've pushed a new commit with the content of the patch:
> >    https://git.dpdk.org/dpdk/commit/?id=af40a93fa21
> 
> Thank you very much for your reply and for pushing a new commit with the content of the patch.
> 
> I noticed that it has been merged into the dpdk repo, and i would like to know if it will also be merged into the next-net repo.
> I have been submitting patches using this repo, and i plan to submit new patches to the next-net repo.

I will be in next-net as soon as it will be rebased on main.

Stephen, please could you rebase next-net?


