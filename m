Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 381E9C28B28
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Mar 2025 17:20:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6CAEC40663;
	Wed, 12 Mar 2025 18:20:00 +0100 (CET)
Received: from fhigh-b5-smtp.messagingengine.com
 (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
 by mails.dpdk.org (Postfix) with ESMTP id 25708402D3
 for <dev@dpdk.org>; Wed, 12 Mar 2025 18:19:59 +0100 (CET)
Received: from phl-compute-12.internal (phl-compute-12.phl.internal
 [10.202.2.52])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 41F3925402BD;
 Wed, 12 Mar 2025 13:19:58 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-12.internal (MEProxy); Wed, 12 Mar 2025 13:19:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1741799998;
 x=1741886398; bh=R2K2TVlp7dU7+xDFPo9faKJn3Due0pI3u/ouwQRD59o=; b=
 ZCQ4zrfYXG9DM4Qd4+Qxv0xEWwpUb4AAVRWf2BIV1gJg1z0bm65Hp/IZrRpbXQsH
 X2n3TUMU0IDM1cXyiWRkFXSLZBRcZXFURwdcP5ZvPHF31eIa5QsHxwlsqusgZKIj
 pY8PTBTS2V72VdIwKarHvDNI7rFcqHYYOuiYub2eFlW0TDCnrKKQXJ5zm73SGRH1
 oYGiLBFgf/1Ij0tWutZdaTzZh+epj5Sdlo5o43g6seznnrm8i/+RDflWgXIBURtG
 UtpjdS1QWuQoWXUUxNX5HyVFnK7vtvsD6ZbPh+aL8ucXWbPhXE4nxLjxceXlrWQY
 UWYHbXVj87uRpkpuXE8/Mg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741799998; x=
 1741886398; bh=R2K2TVlp7dU7+xDFPo9faKJn3Due0pI3u/ouwQRD59o=; b=o
 wG15G3MixzedoCwNUjznauQLQSgKar8W6gx7QDqZyYGqx+8H/p0VlNNFnbWzrZvj
 0tK/EdYhBef7ZaSxK0bdBeHiyGW7mr9aP/B85KuXtVEIkfSma7Ce2jy2Ta4xOaou
 78tSzP2PRP9qsAdvNi+9csLW/mGAbUWzo72i6sGW5+peOyvX/cmgGnjNgZqnL2CE
 IME4EbzWbqtg9J94HRMVOyL8JN2djXVs9Zm1Jq1H9XNEjrV+UMwrJICbQbsuCH1N
 T7xo9H8D2xRGuicXbKwGJryW4giKnOPBKADfo76WUCrWaRN/oj3g/TyYXYCPFyl3
 2jwlqwj4VFzchYYDTd4Jg==
X-ME-Sender: <xms:PcLRZ4yU67ZgwUGRu1DL02iMD17GX0w3sGqZBUPetwdQzMGb1UQvxw>
 <xme:PcLRZ8QjyioqpvdHGWjuOtDNbC5Ij39sqLc2tWYyeK0vXGoodCLX2t1qu-Xy-maUv
 k4DLsdVPmp_NvGsVg>
X-ME-Received: <xmr:PcLRZ6WqQ7zrTjfsFoSbLK6Zbgtpju8_LyOiLP3aaiQihKTHZ5eW9sO-kdO2-_lFo6nXwS0b5Jb6HwUQmYXg7UEtpA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvdehieehucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
 pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
 gvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddt
 jeenucfhrhhomhepvfhhohhmrghsucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonh
 hjrghlohhnrdhnvghtqeenucggtffrrghtthgvrhhnpeejudevheeiveduuddtveffgfdt
 geekueevjeffjeegtdeggeekgfdvuefgfeekjeenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvght
 pdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehhrg
 hrrhihrdhvrghnrdhhrggrrhgvnhesihhnthgvlhdrtghomhdprhgtphhtthhopegsrhhu
 tggvrdhrihgthhgrrhgushhonhesihhnthgvlhdrtghomhdprhgtphhtthhopehgvghtvg
 hlshhonhesnhhvihguihgrrdgtohhmpdhrtghpthhtohepuggvvhesughpughkrdhorhhg
 pdhrtghpthhtohepmhhkrghshhgrnhhisehnvhhiughirgdrtghomhdprhgtphhtthhope
 highhoohhtohhrohhvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhtvghphhgvnhes
 nhgvthifohhrkhhplhhumhgsvghrrdhorhhg
X-ME-Proxy: <xmx:PcLRZ2hSH5-VUZJeFcloiEEav4RiFUrTch4hixPBi0BWZdvv-Ib5wQ>
 <xmx:PcLRZ6BKg0gbdN9D15B3uZVKdZ9d-vU4VMJSfgDaCe5qfA8zaMSncQ>
 <xmx:PcLRZ3IiWeHpsb2Cb3trh51fEu9V2yOgAmwQHa3kuiPIGIGUY4VwVw>
 <xmx:PcLRZxComxf1cQ7yleB5RGMLrI-aD-EQs3zJOkgQ10PI3w8e5ONHsQ>
 <xmx:PsLRZwAn1Bi-ZfWTPJDtnMW4tuYgghsX1Huu4YiRdZ7cJCvURck1kTv2>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Mar 2025 13:19:56 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: "Van Haaren, Harry" <harry.van.haaren@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Gregory Etelson <getelson@nvidia.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>, "mkashani@nvidia.com" <mkashani@nvidia.com>,
 "igootorov@gmail.com" <igootorov@gmail.com>,
 Stephen Hemminger <stephen@networkplumber.org>
Subject: Re: [PATCH v2] rust: support raw DPDK API
Date: Wed, 12 Mar 2025 18:19:55 +0100
Message-ID: <3618203.GKX7oQKdZx@thomas>
In-Reply-To: <Z88SZddtUfSpTBhE@bricha3-mobl1.ger.corp.intel.com>
References: <20250306133713.393057-1-getelson@nvidia.com>
 <PH8PR11MB680333949B01E4316CF44E29D7D62@PH8PR11MB6803.namprd11.prod.outlook.com>
 <Z88SZddtUfSpTBhE@bricha3-mobl1.ger.corp.intel.com>
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

10/03/2025 17:25, Bruce Richardson:
> On Mon, Mar 10, 2025 at 04:13:21PM +0000, Van Haaren, Harry wrote:
> > Looking at the above parts of "Port abstraction in Rust", I'm not sure it really adds anything.
> > It feels a bit "middle of the road" (aka, adding some "abstraction", but not going far enough).
> > 
> > What if we took an even smaller step: remove the Rust struct concepts, and just call the "dpdk::raw::*" unsafe
> > functions directly, as if they were C code. No "struct Port, impl Port", and no "Iterator<DpdkPort" concepts at all.
> > That would show "correct" usage of the raw generated bindings, and provide raw API unit-tests.
> > 
> 
> Yes, definite +1 for this. Let's not try and have a half-C, half-Rust set
> of APIs, but instead let's have a clean low-level mapping directly to C
> functions, and then build a proper, safe API on top of that.

+1 about limiting this patch to a low-level unsafe binding,
while allowing a safe high-level API to be created later.



