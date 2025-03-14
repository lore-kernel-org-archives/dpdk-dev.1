Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 752ADC282EC
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Mar 2025 13:57:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AE4AA40289;
	Fri, 14 Mar 2025 14:57:25 +0100 (CET)
Received: from fhigh-a1-smtp.messagingengine.com
 (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
 by mails.dpdk.org (Postfix) with ESMTP id 521EF400D5
 for <dev@dpdk.org>; Fri, 14 Mar 2025 14:57:24 +0100 (CET)
Received: from phl-compute-03.internal (phl-compute-03.phl.internal
 [10.202.2.43])
 by mailfhigh.phl.internal (Postfix) with ESMTP id D3F1311400A4;
 Fri, 14 Mar 2025 09:57:23 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-03.internal (MEProxy); Fri, 14 Mar 2025 09:57:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1741960643;
 x=1742047043; bh=7paG3sA7GCgVCEvHCc+wuphAW2aRuorqB3C9VxCPgK8=; b=
 f9eZ80UDa7HwvuBH3pV+7+X+kxWUSQ8sX3yJVPiEUaIbI0KxK55fm0VFsQ31mWDc
 p5qWOAJOm2owK3LOhzAa8tU/cQbeHMKYrzP49elbwkN35PNOGpp2U5LlIravKNZE
 EFGKSDol/Ge3ScftgFEljx1ZVZEarFp0pJaqiK6sDfCJ5Kip6M1YTnSlilVZeQje
 Q9U32215MBCHH72bcahSbihmVR80rYBS1duPUhv0CqASqgibWen0k3zRim/3P+0b
 JSy0FAp7Z37KMjjp0vY6WzXIn1ONvsBvb0GJLgmcdsIbx14xAdS7yc9t6daGci0t
 9hW1G66M2UxsTKyN2w5sVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741960643; x=
 1742047043; bh=7paG3sA7GCgVCEvHCc+wuphAW2aRuorqB3C9VxCPgK8=; b=s
 pdXnsCRVC+MZb0ZgMSIKeAdIRKHfd4aTS+Ut9hdJxW4Jlr6iR66+T4+upZiACzL+
 oyRtEyZ86R9rBMukzIADt38Dq81I1RXjJ9z2guWsx5zmvdS1kNPJ1OJRrYe7NqiI
 vR8egc4YsfDs0qqL359XL/BmoyyI+e8F23bJ1w0s+cr0lL/JpIbm5Jw2pu/j/phP
 UaaDIXEn6rt3QePKFMnBb0LSpR+HHTTa2aBt4Gtbo5nPMbVNsNsDqTPgdIYF8HpH
 3Oqt95LLCTbyBkeNR/jSi9QOZKsGFQWN9xpJscHD7nlhrUJ2XcWqjke68NRYXjT+
 NE/dGTCybfD7WVsXco7UA==
X-ME-Sender: <xms:wzXUZ-p0ST6Z-1FmCckwgsxNaP07nooeDcMSumrlbp64PKz6WILIbw>
 <xme:wzXUZ8of_3-Vo8m-RlYFFmzLx-YteoNOTEzizF0R1GiNrAZJ6RwrmX4hnIBovCTvW
 k-7DM0GxnP_m6BPOg>
X-ME-Received: <xmr:wzXUZzNdyCcbpdqimNDyMiz73RNSwh-QjkHZOgk_uHeU90VMGAG5CJv1zYnB4Wbk7TaKsi0z9raqNnGYQpE7Gv4FRw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddufedutdduucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
 pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
 gvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddt
 jeenucfhrhhomhepvfhhohhmrghsucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonh
 hjrghlohhnrdhnvghtqeenucggtffrrghtthgvrhhnpeejudevheeiveduuddtveffgfdt
 geekueevjeffjeegtdeggeekgfdvuefgfeekjeenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvght
 pdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehluh
 gtrgdrvhhiiiiirghrrhhosegrrhhmrdgtohhmpdhrtghpthhtohepuggvvhesughpughk
 rdhorhhgpdhrtghpthhtohepphgruhhlrdhsiigtiigvphgrnhgvkhesrghrmhdrtghomh
 dprhgtphhtthhopehprhhosggssehiohhlrdhunhhhrdgvughupdhrtghpthhtohepnhhp
 rhgrthhtvgesihholhdruhhnhhdrvgguuh
X-ME-Proxy: <xmx:wzXUZ97s8l0Ce4270N3wgXzh8E8l1xS0VWy-JN0LSVdbXxv8Ns8u4A>
 <xmx:wzXUZ94SKl4hjdAXKPC7IuUds-JUcDrLJUuFm_KOKhz7wkeB4EjBwQ>
 <xmx:wzXUZ9gYbE5DzQMqoWP8WbBGVqNYjkeL760i4rY8vygCvogXjgIL7g>
 <xmx:wzXUZ341Fiwqv8ixBr75Vne7-jvHWVY3OlcIKj4HAwX0zxfYuIqJvA>
 <xmx:wzXUZ7QnG7aCqfltAhRlwveeCGK47Fa1whUu69SCnzONK-mnnOnmheSA>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Mar 2025 09:57:22 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Luca Vizzarro <luca.vizzarro@arm.com>
Cc: dev@dpdk.org, Paul Szczepanek <paul.szczepanek@arm.com>,
 Patrick Robb <probb@iol.unh.edu>, Nicholas Pratte <npratte@iol.unh.edu>
Subject: Re: [PATCH] dts: fix SPDX tag
Date: Fri, 14 Mar 2025 14:57:21 +0100
Message-ID: <4289370.otXNkdZ6W1@thomas>
In-Reply-To: <20250314134346.3321517-1-thomas@monjalon.net>
References: <20250314134346.3321517-1-thomas@monjalon.net>
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

14/03/2025 14:43, Thomas Monjalon:
> The license in the SPDX tag was incomplete.
> 
> Fixes: d77a4a27bd24 ("dts: remove node distinction")
> 
> Signed-off-by: Thomas Monjalon <thomas@monjalon.net>

Reviewed-by: Luca Vizzarro <luca.vizzarro@arm.com>

Applied, thanks.


