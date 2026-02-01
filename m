Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC4F4E6526B
	for <dpdk-dev@archiver.kernel.org>; Sun,  1 Feb 2026 20:17:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 883F9402B2;
	Sun,  1 Feb 2026 21:16:59 +0100 (CET)
Received: from fhigh-b3-smtp.messagingengine.com
 (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
 by mails.dpdk.org (Postfix) with ESMTP id 2B1B940150
 for <dev@dpdk.org>; Sun,  1 Feb 2026 21:16:57 +0100 (CET)
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
 by mailfhigh.stl.internal (Postfix) with ESMTP id CF0767A00F0;
 Sun,  1 Feb 2026 15:16:55 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-08.internal (MEProxy); Sun, 01 Feb 2026 15:16:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1769977015;
 x=1770063415; bh=sW5EQ9nooL92AxnfB1FmLNc8O2y3C1kag8sQo2wYGiM=; b=
 KCdEmh3vXgaiCaNNKqz3xt9uxO8pB/qz/pvw9y2gW/odNaZOkTh5wrcZUqlxsCCj
 7Pz0GiHEwiuXsGPyXXBEhW5blJ5O1zZxD2l4WaBWKVaRX6EH0vUNBbw76wgycmDG
 S3+AdaFhcAcstXKexFXhJkMkjXa+mzooUhKZozTfucGunmnOkbK6MVaxOoHLc7ef
 SGTcmJshFBz1wrHksyuskRevXmqYC2uNW5ti7JMbmlJO43zZSI3iq2WQWW9m+WKU
 ld0edCsTWAsSspCFTI+ZDjmFx6CNcgPd0EE46ke5+jZtyeCl95E90AjK9JfLAKiP
 BlfBhsIdWrEio+u9Rn3fnA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1769977015; x=
 1770063415; bh=sW5EQ9nooL92AxnfB1FmLNc8O2y3C1kag8sQo2wYGiM=; b=F
 p0Ck8GNLsuh+WQ4DGgnI6LdnMLpVoO5HDYmbQdJ6PGWzpMh7+pRtxdpybEu65u0P
 iaiEn5ioPDIfOSXo6YbdyzASWEvmOmSCR4PdIGlhLNBUonydWcu9W5c+9ItTa2aq
 a+j5npkt5GmFbHUAIqSBetkYwBAsNKVVBWwFFVMLXZvWfZfzjf/iC6Njekho/6Aw
 k5SVxmQcDj8NF4Ibk7y50pvveoDZIOsJFcMhsXRPq5uBWZTjD0LP3Pg6h9s/NV3D
 QwsyyrkvpTFxg+kGsUCWRcYt9XAtr56uhZ+BdFj4MmzypQRBOjizVCZnLW9iwXfH
 7GVnS6QLo1/E39Rvq+YAw==
X-ME-Sender: <xms:trR_aUgmIg69I-XzKPsglVKo1dagztSSAIK8W2yl51icy_e-yh7Gww>
 <xme:trR_aYdK5bsiEKahwcb1VMjYP_U_msFav-jJ94shzEsCdaP7o4i-Oo8XuVWJ3gzqY
 e20n8gRi7HoONb1sRV5x1gvItrh_twnh1dD-_TEzXoLeGqZYUnpk7Y>
X-ME-Received: <xmr:trR_afkY9U_JjpasF6Nqrg2MpvP1ugXsLoj6w6MJ8KcWqfRMLC8aEI_oDLadPrdlV4f_qKvEaNOtwqsYRwQucI_CgQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddujeehjeefucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeehpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehsthgvphhhvghnsehnvghtfihorhhkph
 hluhhmsggvrhdrohhrghdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtphht
 thhopegsrhhutggvrdhrihgthhgrrhgushhonhesihhnthgvlhdrtghomhdprhgtphhtth
 hopegrtghonhholhgvsehrvgguhhgrthdrtghomhdprhgtphhtthhopegurghvihgurdhm
 rghrtghhrghnugesrhgvughhrghtrdgtohhm
X-ME-Proxy: <xmx:trR_aZs-hE6XpxAWMrkZfzEu5--GI2mSzbi6cCn7ru-s2347lVXYHw>
 <xmx:trR_ad98hAKWUAbpzQDJHOJVA2F2dsSVVRYj04Gi5Oc34kdYSQVIjg>
 <xmx:trR_aTOvzh_526zfbI9TSrEPrgswsmwK7x2opDT6BsIw8xnm6qOu-A>
 <xmx:trR_abEngi5XF5IejTjPm4bIVE699BWJcGFRTZnuVbQTL7RqH-db_g>
 <xmx:t7R_aTPfbAuG4z9Cb_2JnH_u6saxnMIqAH5p-VEB-VOZcDlLpqpfwgt9>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 1 Feb 2026 15:16:54 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>,
 Aaron Conole <aconole@redhat.com>, David Marchand <david.marchand@redhat.com>
Subject: Re: [RFC] devtools: replace get-maintainer shell wrapper with Python
 script
Date: Sun, 01 Feb 2026 21:16:52 +0100
Message-ID: <5531059.31r3eYUQgx@thomas>
In-Reply-To: <20260201110108.5d80c3be@phoenix.local>
References: <20260131204823.29363-1-stephen@networkplumber.org>
 <3273409.mvXUDI8C0e@thomas> <20260201110108.5d80c3be@phoenix.local>
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

01/02/2026 20:01, Stephen Hemminger:
> On Sun, 01 Feb 2026 14:51:01 +0100
> Thomas Monjalon <thomas@monjalon.net> wrote:
> 
> > 31/01/2026 21:48, Stephen Hemminger:
> > > DPDK has been reusing the Linux kernel get_maintainer perl script
> > > but that creates an unwanted dependency on kernel source.
> > > 
> > > This new script replaces that with a standalone Python implementation
> > > created in a few minutes with AI. The command line arguments are
> > > a subset of the features that make sense in DPDK.  
> > 
> > Almost thousand lines for this new script.
> > Are you sure that's something we want to maintain ourself?
> 
> It really is less bad than the awk mess.
> And the kernel often changes the rules.
> 
> The bigger issue is that the python version is not detecting everything yet.

Our wrapper is very simple.
How much an issue is this dependency? What others think?



