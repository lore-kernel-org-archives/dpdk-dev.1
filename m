Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27CB5C54F30
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 May 2025 13:16:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 229194028D;
	Tue, 27 May 2025 15:16:06 +0200 (CEST)
Received: from fhigh-a1-smtp.messagingengine.com
 (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
 by mails.dpdk.org (Postfix) with ESMTP id B17BA4027A
 for <dev@dpdk.org>; Tue, 27 May 2025 15:16:04 +0200 (CEST)
Received: from phl-compute-12.internal (phl-compute-12.phl.internal
 [10.202.2.52])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 219AE114017C;
 Tue, 27 May 2025 09:16:04 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-12.internal (MEProxy); Tue, 27 May 2025 09:16:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1748351764;
 x=1748438164; bh=qIyvPANSFKaMezJM/g20GpmWvUZjl7n9nyJM9KbMcLg=; b=
 P+EtMnM6VuP3T8ivFBazzUQyT6f3YjYnA1FfZg1UxAcFqC/2Fjt1KwRcuHOZg+ZP
 3M4sFi6bVJowy6d0deL8RniiBc5uFZNIfE/6ZBIYe63m8POn7otMf3AbpNGmz+FC
 ak5Wuq7/6nKrQSlNNFdZAyT6+CEIcWzbYp+QBLBMbwsR7wxZtz4/KyvcD9AxANXA
 qqqkva3kPBq7sBCT9Mtwr5UO16TTQJZKhDZwIVveJ7ou/780LCk3/9NWixM5SUnl
 jTr2JYOylcTi0sq1Tt0SK37+jD8hKKt6iJNximf1DrvLHBTKC9DgdOP8IpoY1Yh2
 P/QziSHFrpyKs5th16OZ0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748351764; x=
 1748438164; bh=qIyvPANSFKaMezJM/g20GpmWvUZjl7n9nyJM9KbMcLg=; b=n
 4PokDl8O1P+qcZPK3q6BfNpL5UKw4t7x29p9xvRKemnwiqg8YiMBergBBA/8jb63
 YSKNK+gur/F4LRa5SE4pVn+gT8ZcTvssYvhfU3YmFPGYqH7yXKMXZxhVwMtpvdx3
 ZkrETx+bhwlsL4A8BEd4x/xk1g2OjnQN320qtN5xWigBB/uWdreR1sZHX4QiCqNf
 TQUHFoe/m6qRWH4nZ68xmjNvjjzCF7eMxRRNIfFgI2J/OuEuVjVmpWeaefGXY4nk
 7rnzwgSTFHJpbqyAocNqXlbuik1I566n6RhgW59/2pi3ypfmFuKwubHvGpC8Feae
 /riYRmDrAjKA/Uk6UF75Q==
X-ME-Sender: <xms:E7s1aLK2QJKVgXhWCAahxRRXYSzK5DXTZo6OeAtpvrOoD3tv0ob7YQ>
 <xme:E7s1aPLRv3nzpKpDGrUSyeM8II6CHLsC9EZ3-NeGP307dzL5HHexqs-5iJQz59bIg
 ZU_ZaXL_d78Zc3EBg>
X-ME-Received: <xmr:E7s1aDsoxIsdLmvuQUtuMBuPiFZCaUUWzBaz1aMlPsv-RY3bCCcCv3uFW3EtAqXsmgtNM2RwAkan1Y6mN3yQa3bI7Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvtdegkeculddtuddrgeefvddrtd
 dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
 fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
 dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgj
 fhgggfgtsehtufertddttdejnecuhfhrohhmpefvhhhomhgrshcuofhonhhjrghlohhnuc
 eothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrfgrthhtvghrnhepjedu
 veehieevuddutdevfffgtdegkeeuveejffejgedtgeegkefgvdeugfefkeejnecuvehluh
 hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepthhhohhmrghssehm
 ohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohepledpmhhouggvpehsmhhtphhouh
 htpdhrtghpthhtohepphhrrghvihhnrdhprghthhgrkhesihhnthgvlhdrtghomhdprhgt
 phhtthhopehjvghrihhnjhesmhgrrhhvvghllhdrtghomhdprhgtphhtthhopeguvghvse
 guphgukhdrohhrghdprhgtphhtthhopehmihhkvgdrgihimhhinhhgrdgthhgvnhesihhn
 thgvlhdrtghomhdprhgtphhtthhopegsrhhutggvrdhrihgthhgrrhgushhonhesihhnth
 gvlhdrtghomhdprhgtphhtthhopegurghvihgurdhmrghrtghhrghnugesrhgvughhrght
 rdgtohhmpdhrtghpthhtohepnhhiphhunhdrghhuphhtrgesrghmugdrtghomhdprhgtph
 htthhopegthhgvnhgsohigsehnvhhiughirgdrtghomhdprhgtphhtthhopehtihhrthhh
 vghnughurdhsrghrkhgrrhesihhnthgvlhdrtghomh
X-ME-Proxy: <xmx:E7s1aEaP8UPNuencIO-kIrC5ruH5ZasRSikqQy243cxLXNWNN3Ob1A>
 <xmx:E7s1aCapXvli0B0EvyTLTHqLSCXn2haSQ3KG8pB-SVVSaI24_qDdrw>
 <xmx:E7s1aIDFNJ2zLdk4khC5yNIsz5XS-TN6o0b2zJdJNQsweRrAeaS4OA>
 <xmx:E7s1aAapht0dvihNvqW6CFLppTLcD299Qw4s13ZEJN4lme-ri2zP6A>
 <xmx:FLs1aLkAMxErOT7WqRPMWFDh0WETR9DNU5jyzpGFHJjsUtnZzjJp7Bla>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 May 2025 09:16:02 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Pravin Pathak <pravin.pathak@intel.com>, Jerin Jacob <jerinj@marvell.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>,
 "mike.ximing.chen@intel.com" <mike.ximing.chen@intel.com>,
 "bruce.richardson@intel.com" <bruce.richardson@intel.com>,
 "david.marchand@redhat.com" <david.marchand@redhat.com>,
 "nipun.gupta@amd.com" <nipun.gupta@amd.com>,
 "chenbox@nvidia.com" <chenbox@nvidia.com>,
 "tirthendu.sarkar@intel.com" <tirthendu.sarkar@intel.com>
Subject: Re: [EXTERNAL] [PATCH v1 4/7] event/dlb2: support managing history
 list resource
Date: Tue, 27 May 2025 15:16:00 +0200
Message-ID: <21670295.0c2gjJ1VT2@thomas>
In-Reply-To: <BY3PR18MB4785C4D398C95857C86D67F2C864A@BY3PR18MB4785.namprd18.prod.outlook.com>
References: <20250509042401.2634765-1-pravin.pathak@intel.com>
 <20250509042401.2634765-5-pravin.pathak@intel.com>
 <BY3PR18MB4785C4D398C95857C86D67F2C864A@BY3PR18MB4785.namprd18.prod.outlook.com>
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

27/05/2025 07:57, Jerin Jacob:
> From: Pravin Pathak <pravin.pathak@intel.com>
> > --- a/drivers/event/dlb2/version.map
> > +++ b/drivers/event/dlb2/version.map
> > @@ -7,4 +7,5 @@ EXPERIMENTAL {
> > 
> >  	# added in 20.11
> >  	rte_pmd_dlb2_set_token_pop_mode;
> 
> Add added in 25.07

There is no .map file anymore.



