Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D112CCD195
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Oct 2025 15:52:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A4D9842D92;
	Fri, 17 Oct 2025 17:52:06 +0200 (CEST)
Received: from fhigh-a8-smtp.messagingengine.com
 (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
 by mails.dpdk.org (Postfix) with ESMTP id 302B5400D7
 for <dev@dpdk.org>; Fri, 17 Oct 2025 17:52:05 +0200 (CEST)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfhigh.phl.internal (Postfix) with ESMTP id B4AC11400086;
 Fri, 17 Oct 2025 11:52:04 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-03.internal (MEProxy); Fri, 17 Oct 2025 11:52:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1760716324;
 x=1760802724; bh=6LqTSm0YHwinKhW1RAnEbbSRldo+CAwtG38VZZ0YAxU=; b=
 VM4xses7OsF/5hlrxt0db5bm29OQ/A4BaeFWWV4WMHrDPtDMwb4kDtouguxWtbvq
 MJwWIguoF30YPXOE9mtOp/Be+75s7gmnSRGL3o5WbfX45A7vwcCV8FbX9uDK6vVB
 AM9ryLzGT4dpg+c/GPtHK93LQf3y5HM6Cj68ODI60RISYKuAgHC1018AKQWbLlmW
 zFpfwxWvFLycreQls9czCwk4mkn+WFzk5wEKefZ6JfedGd3K96S7dUUbA7ErN36d
 uNigkAnRUp5sdd8ZVbIL1HXK/UHoBE9cKJ38KGpgbzhMfbOrc9A7vi/EpkvojYcN
 GgWoJi6pNKRmS7fscvgFBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760716324; x=
 1760802724; bh=6LqTSm0YHwinKhW1RAnEbbSRldo+CAwtG38VZZ0YAxU=; b=a
 ZTtRXgcyXKIfbM0qe8r+lFqGzA0NTDePFNQohbiTo5Bu/D2HJ5KX5L1T9gFAECMW
 9eBy+qOg46fy2mAUStp2PbKVVBah/r4fIV7AlDN9EK+5O2agcJWlcrwj11viX59D
 uVb0ciYfI7OErzY9/etjlASk9EuSW052D7uEL37I6gOBLpulaaqfHTsso0Q19XQ5
 Ms12D6GpPBczfFiJ45tsyQ3dqa+qfQ3c7jOIOimtQltFXQW7+8YrekVSUlPtRHod
 8y0rCZXMfShXH0tZ35x+ItYUpvn3ULfxPhqTY+DWqx1Pra9i4rB9eS9N8zn9SgYW
 mDM05CLH9iNqgKIht1Z9g==
X-ME-Sender: <xms:JGbyaHhD7CGjpd-Ed15lxF9U6uETItocSLVID9XWgaVZcq3GIGdfaA>
 <xme:JGbyaO-oBojxiP_iiryUJxYMLBMk8As-W5HJn2mP5X1DI7e7UyzGp5MDdmdmk6m_5
 cu3OrNShi7J-RLVDreAxK5kQ1ozLm4bkmCvhuZ_rrFhbkQ8sd6xDm8>
X-ME-Received: <xmr:JGbyaGEe-fJf9C1GinLbS8qkhnBa2A3h629fD7pLoIinfr0fyELTo_-jQl481lmDFHCt7unhoCURUl70UUc58Nbcqw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdelheekucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeejpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehnkhhishhhohhrsehmrghrvhgvlhhlrd
 gtohhmpdhrtghpthhtohepghgrkhhhihhlsehmrghrvhgvlhhlrdgtohhmpdhrtghpthht
 ohepuggvvhesughpughkrdhorhhgpdhrtghpthhtohepshgrtghhihhnrdhsrgigvghnrg
 esnhigphdrtghomhdprhgtphhtthhopehhvghmrghnthdrrghgrhgrfigrlhesnhigphdr
 tghomhdprhgtphhtthhopehjvghrihhnjhesmhgrrhhvvghllhdrtghomhdprhgtphhtth
 hopegrshgvkhhhrghrsehmrghrvhgvlhhlrdgtohhm
X-ME-Proxy: <xmx:JGbyaJkZl2OWilPwHvLCbZ-54ehv85aFU7tHgoItJ7rrI2bAoI3QSw>
 <xmx:JGbyaCY4pVrsxr2lyZaBuVpYsESqk0MxrPm8FwFeg7nwH2TV34oz-Q>
 <xmx:JGbyaGF6gk7fW0X1WSMHctYhIxzhRJolFZODHIlJNVSghnIgAa-FLQ>
 <xmx:JGbyaLIVot4Go38a0UOBzTae_jhtD7qY88d2jFCRPpe6T4TdBqisNQ>
 <xmx:JGbyaBd4oKtSWE2PnuwfiPVFUlAfiK-7j8kfY3NiNmzbrDYjTN24XSHs>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Oct 2025 11:52:03 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Nawal Kishor <nkishor@marvell.com>, Akhil Goyal <gakhil@marvell.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>, Sachin Saxena <sachin.saxena@nxp.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>, Jerin Jacob <jerinj@marvell.com>,
 Ashwin Sekhar T K <asekhar@marvell.com>
Subject: Re: [EXTERNAL] Re: [PATCH] rawdev: fix device ID retrieval function
 prototype
Date: Fri, 17 Oct 2025 17:52:01 +0200
Message-ID: <3699257.kC03pvyZki@thomas>
In-Reply-To: <CO6PR18MB4484E2A16377DE1CE297E953D8F6A@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20250924055654.1986682-1-nkishor@marvell.com>
 <3733472.U7HbjWM52l@thomas>
 <CO6PR18MB4484E2A16377DE1CE297E953D8F6A@CO6PR18MB4484.namprd18.prod.outlook.com>
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

17/10/2025 13:05, Akhil Goyal:
> Hi Thomas,
> > 16/10/2025 08:56, Nawal Kishor:
> > >
> > > >> Fixed rte_rawdev_get_dev_id() function prototype and its usage.
> > > >
> > > >What? Why?
> > >
> > > >[...]
> > > >> -uint16_t
> > > >> +int
> > > >>  rte_rawdev_get_dev_id(const char *name);
> > >
> > > >Other functions handle dev_id as uint16_t, so why changing this function?
> > >
> > > The spec says that rte_rawdev_get_dev_id() returns negative number in case of
> > failure.
> > > But in the definition it is returning uint16_t which will never be negative, hence
> > changed it to int.
> > >
> > > If this is not acceptable, what fix will you suggest?
> > 
> > You should change to int16_t for all rawdev id parameters.
> > 
> Wont that be an API/ABI break for all the APIs?
> We have a similar rte_cryptodev_get_dev_id() and rte_event_dev_get_dev_id() APIs which 
> return <0 value in case of failure and a positive value for valid ones.
> dev_id is defined as unsigned value which is being used everywhere in all APIs of cryptodev, eventdev and rawdev.
> The negative value here is just to denote that the API fails to retrieve dev_id and application should take action and not proceed further with that value.
> Changing dev_id to a signed value in my opinion is not necessary just because this API may return <0 value on failure.

OK but then it means that very high port IDs would be considered an error.
It is not realistic, but theoritically wrong.
OK to change only this function then.


