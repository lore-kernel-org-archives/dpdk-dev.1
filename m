Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9735ECCD1BF
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Oct 2025 20:24:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B022D40151;
	Thu, 23 Oct 2025 22:24:45 +0200 (CEST)
Received: from fhigh-a3-smtp.messagingengine.com
 (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
 by mails.dpdk.org (Postfix) with ESMTP id C167540144;
 Thu, 23 Oct 2025 22:24:44 +0200 (CEST)
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 0E5E4140007F;
 Thu, 23 Oct 2025 16:24:44 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-08.internal (MEProxy); Thu, 23 Oct 2025 16:24:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1761251084;
 x=1761337484; bh=znAHgT/hx8Z6Lutmk6DcUPuhoCAzxFYDEaFLDrtR84g=; b=
 GxhsPWz+G+c26Aie4naVQSsTEfLdgEwR0+S8uy6RcWhdy2fOSWHWnCCSb71vkya6
 SmiYjmWIyd5gpsn5efxVvlMaieFPUXW8i6TqXiFPCAAymyyVP2jJy97LahmKd+sW
 H1xy7As9DzW5OoII4b4Tox3RpUtgT2ZAHfIY54ciDXGL5Z2DuuvQ5YSefieMpF0q
 iKMy+bXAQjf1+YdWQ0nHoziHpMRDNyOyFWfm4TjKr8oesQSpqZ+OtqGva4j9gpRX
 VeGYTI4//6lr0up4KdWRog286h4Xr0mFJaI19QwYkbsGj1mJe/v86NWJC+r3vsV4
 rQFOddBbhK3saYLPol2JmQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1761251084; x=
 1761337484; bh=znAHgT/hx8Z6Lutmk6DcUPuhoCAzxFYDEaFLDrtR84g=; b=D
 hRIqu8hBozPEO51+52ty4WsFl4p+Ndr6jMKbg4XR/GUldVoSnIduL0bew20En9s5
 NY1Pv0gkBNQadcRBXfZZ4qHfn5ANgxKrlZovnZvS8DWPNjb4u1BdGoBzloCniGiJ
 a88wmpfA8nj3iy8gK4SccRI9p8uB2W7l1h66VmKFFLDLQ86frPUtRBwTWIGHA6DF
 pfxEN/tKM1xvyv1nF5Ls65JHWPgAU3N/8SVu43uTctfhIDEtTf/TLIhP3mbM/TsS
 G616mTeWudQHarX5a33JzKbmVeikp2sXC/iNpmB6igRGcvgsBh7jmXsFGkBiULnL
 xGGmttHubHcOf1cy8jRFg==
X-ME-Sender: <xms:C4_6aL7aNSuCnXemC68gCcQz1hMFeupb1CxZ07unoGIXpeGw069nQg>
 <xme:C4_6aK826oW5GNq3SjMsF-tsz5sjBfNxcfQc1Vo5AQ-VT_SzW9f9BeLagt_8zXZKI
 nCsOcFdyP657W52VfHOAjYSgOPW1MAgkv1KVNUqOsfsrI3J46aw>
X-ME-Received: <xmr:C4_6aCXeCBFw7K6_cKhPAY1LEpSL6hdaPFQAXk0mZGXehKIsvNYQrF1RvKSiyHrmfAJmxGCLWX3RUqLi9TSmsqfs0A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeejgedtucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeekpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehthhhivghrrhihrdhhvghrsggvlhhoth
 esieifihhnugdrtghomhdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtphht
 thhopehsthgrsghlvgesughpughkrdhorhhgpdhrtghpthhtohepsghruhgtvgdrrhhitg
 hhrghrughsohhnsehinhhtvghlrdgtohhmpdhrtghpthhtohepfigrthhhshgrlhgrrdhv
 ihhthhgrnhgrghgvsegrrhhmrdgtohhmpdhrtghpthhtohepohhlihhvihgvrhdrmhgrth
 iiseeifihinhgurdgtohhmpdhrtghpthhtohepughouhhgrdhfohhsthgvrhesrghrmhdr
 tghomh
X-ME-Proxy: <xmx:C4_6aNrO4KZCZ72etxyb4bSml_DHu2G-mJQsI030xuSj67Tru1006A>
 <xmx:C4_6aMmsFFhuSkrxNFKsd8PTkRk2rMObZT48rESBLEohzQ4ophoiEg>
 <xmx:C4_6aF1FPyD3qI-7KLxjMrsSHt_Jgvhto9fv27DZatG8_H7voXEvsg>
 <xmx:C4_6aBSlPFMcsGwAU8i5yEjoYf5alPE8OezjGiWs11k1yy-yMOhRbA>
 <xmx:DI_6aMiHaOiK8127ZWdyGLiLS3gOOpgY7Iuna69k_V82LCaJ1METRODe>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Oct 2025 16:24:42 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Thierry Herbelot <thierry.herbelot@6wind.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>, stable@dpdk.org,
 Bruce Richardson <bruce.richardson@intel.com>,
 Wathsala Vithanage <wathsala.vithanage@arm.com>,
 "stable@dpdk.org" <stable@dpdk.org>, Olivier Matz <olivier.matz@6wind.com>,
 Doug Foster <Doug.Foster@arm.com>
Subject: Re: [PATCH] config/arm: fix inconsistency for Neoverse N2
Date: Thu, 23 Oct 2025 22:24:41 +0200
Message-ID: <17805354.0ZKypZ73Fx@thomas>
In-Reply-To: <AS8PR08MB7339DA678541942C52F92D3AE5F0A@AS8PR08MB7339.eurprd08.prod.outlook.com>
References: <20251016080533.535266-1-thierry.herbelot@6wind.com>
 <AS8PR08MB7339DA678541942C52F92D3AE5F0A@AS8PR08MB7339.eurprd08.prod.outlook.com>
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

> >Configuration for hex code '0xd49' enables two NUMA nodes.
> >Then, the corresponding 'soc_n2' should allow 'numa'.
> >
> >Fixes: ea85ed1f6882 ("config/arm: increase nodes and cores for Neoverse N2")
> >Signed-off-by: Thierry Herbelot <thierry.herbelot@6wind.com>
> Acked-by: Doug Foster <doug.foster@arm.com>

Applied, thanks.



