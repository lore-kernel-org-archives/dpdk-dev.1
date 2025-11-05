Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAD9DCCF9F8
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Nov 2025 21:18:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BDCBD4066C;
	Wed,  5 Nov 2025 22:18:01 +0100 (CET)
Received: from fout-a7-smtp.messagingengine.com
 (fout-a7-smtp.messagingengine.com [103.168.172.150])
 by mails.dpdk.org (Postfix) with ESMTP id BE576402E6
 for <dev@dpdk.org>; Wed,  5 Nov 2025 22:17:59 +0100 (CET)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfout.phl.internal (Postfix) with ESMTP id 4211DEC0180;
 Wed,  5 Nov 2025 16:17:59 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-02.internal (MEProxy); Wed, 05 Nov 2025 16:17:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1762377479;
 x=1762463879; bh=JSnKW4bCY4pdFKKs8Iz3H7QbVnEUC1oXWFvniUza9t4=; b=
 ox6UlTT02b3ZyVQDzrbPEPPgj31xFvufIwzJcfHWDzZfAwMnI6PvkSvdNEFH95vz
 L0HLo3nfHZ+FNsd0Ytf0JHxmlFwKKVjqv3kDPNvYjYgPmmELK+pTmlXrC9bmyxAG
 NCUN5cnXZjn7/m3MK7FpvdaJnDKIVK+P3fh0+7smkAzoObW5ds3ap4HrTAMlh7Uo
 ye0OU+lzKOl5BJGsDRahplVcOTH+lZRCUFi8Xc1yztmoFHkGgSA3PdpkRiAZ+dR7
 ++IJojGIuOvvsA6vnCXVOiVlIrbohmlE6ltDVGgS7jLtAdZnA1FBF97DN6mtJrVi
 MIiIv8JwqF0Z6+KfxJce8Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762377479; x=
 1762463879; bh=JSnKW4bCY4pdFKKs8Iz3H7QbVnEUC1oXWFvniUza9t4=; b=q
 AYS5wTsj4HFrBpw8KftCmplZR99pq2tZrvHevrCRkubF/ZB+UQ3ITwt8CagRXpDr
 SvMUi47XFGouT6iT21i+8pe2ALhZLREPWYvwSDu1gBWG4b7XzXCd26wzj7KmRs7P
 JaowsOw5cDpnXJtwfa7s9i7ITldqkOQFumGKwdR8Q2Sk9TvsXz5RhxRCftPQkBRf
 M97YVMh2KFjluCr9jwHbQe95AeAwpWqlPnW/1oG7zC+yrXEW9NXF0LenazLTtVJc
 1yCRuyiZiUHk82fXLwR+F/gty2cd3oRbbQIXRopmtuuQvFgLJ14sxPs4kZfnelrj
 LB84eTjKMzgUOSDrenz4A==
X-ME-Sender: <xms:Br8LaToOhv3rfWdOnDKLpHoAACArE7bAFWUQsvEGzkR_evBmRbMHfg>
 <xme:Br8LaWmEUND6odH8e1TNodRdbWF11JFfahv-RjAfj2sc6zOo6Kdh_RRnkihAS8wAS
 hvEEBjxGLbxfzGqJy0QZAvbLf_E4iszdwwBT5L3avmvPQiGCzR8Hg>
X-ME-Received: <xmr:Br8Labz-Q37pUIsUurQP9oxhSFrVdOcecpvabQXc7SDPvcBLKnRs54exHOL2Kf6zv4LQGcTKZ1etQYaXKnEkBfYqIw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukeegleeiucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeeipdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehgvghtvghlshhonhesnhhvihguihgrrd
 gtohhmpdhrtghpthhtohepshhtvghphhgvnhesnhgvthifohhrkhhplhhumhgsvghrrdho
 rhhgpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpthhtohepmhhkrghshh
 grnhhisehnvhhiughirgdrtghomhdprhgtphhtthhopehrrghslhgrnhgusehnvhhiughi
 rgdrtghomhdprhgtphhtthhopegrnhgurhgvfidrrhihsggthhgvnhhkohesohhkthgvth
 hlrggsshdrrhhu
X-ME-Proxy: <xmx:Br8LaW-fka5mfSz9wHedUYC6-j-vPyX6OxafAXdk_PC-IGIMFpiXGw>
 <xmx:Br8LafL2Va7zmRYZXudDP2x1g60YkNJ8nNwFBrbtY-bMLaIV_yNTPg>
 <xmx:Br8LaccAfd2RxcmBzikz1-a4QXzVsIgugQLoSqTzvWPVsnWwW8uPLw>
 <xmx:Br8Lae_t1UzMZmrXEvJgYAW_uRng8V9-t33OaBLshiwG8ZmVggq0ug>
 <xmx:B78Lae93JW0yXL5z2sXlQSntyTjxQFae3RxM6YtN7XaGlRzCEhrRBMPJ>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Nov 2025 16:17:57 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Gregory Etelson <getelson@nvidia.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>, dev@dpdk.org,
 mkashani@nvidia.com, rasland@nvidia.com,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: Re: [PATCH v3 1/2] ethdev: make representor parameter more explicit
Date: Wed, 05 Nov 2025 22:17:55 +0100
Message-ID: <8735291.3yuU7cT3dn@thomas>
In-Reply-To: <20251105112039.1db64906@phoenix>
References: <20251028095831.53669-1-getelson@nvidia.com>
 <20251105174839.323085-1-getelson@nvidia.com>
 <20251105112039.1db64906@phoenix>
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

05/11/2025 20:20, Stephen Hemminger:
> Looks good as is, a couple of minor observations.
> 
> > +	/* pfX... or (pfX)... */
> > +	if ((str[0] == 'p' && str[1] == 'f') ||
> > +	    (str[0] == '(' && str[1] == 'p' && str[2] == 'f')) {
> 
> This is correct but seem like it is getting verbose.
> If there are more cases than this looking for prefix, might be
> useful to have helper function.
> 
> Looks like devargs could use some better pattern matching,
> lots of string handling already in this code.
> String processing in C is often an error trap.
> 
> > +		if (str != NULL && str[0] == ')') {
> > +			str++; /* advance past ")" */
> > +			eth_da->flags =
> > +				RTE_ETH_DEVARG_IGNORE_PF_REPRESENTOR;
> 
> Can't that go on one line, max line length in DPDK is 100.
> Is there a case where there could be multiple devargs flags?

It is the first flag.
I would prefer this flag to be named RTE_ETH_DEVARG_REPRESENTOR_IGNORE_PF.


