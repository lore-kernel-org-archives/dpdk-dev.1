Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A076FF3382F
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Mar 2026 09:55:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D621F402D1;
	Tue, 17 Mar 2026 10:55:46 +0100 (CET)
Received: from fout-a4-smtp.messagingengine.com
 (fout-a4-smtp.messagingengine.com [103.168.172.147])
 by mails.dpdk.org (Postfix) with ESMTP id AAB1140270;
 Tue, 17 Mar 2026 10:55:45 +0100 (CET)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfout.phl.internal (Postfix) with ESMTP id 245B5EC0183;
 Tue, 17 Mar 2026 05:55:45 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Tue, 17 Mar 2026 05:55:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1773741345;
 x=1773827745; bh=eRKEUtT2izeAj9P9iPctE62P5P8W+2EXggzdMXXdvZE=; b=
 KLs2DqYqmNa9uS3T8qO4JnqYN6MNEQT/cnfXt8pmq/etHVoDS26s6uOf3hAnl+XS
 rk6vU5Orw6iidykK2wD0+lLgkQr6AtCaedKBQ932jfWJkgnU8sianxPd71clDVJN
 xWl9TWwSRldg2VhyS+vi0Jwjw0y7+ZifpxleeV7HtCDQpEV49HfjvkKcqjC+djfu
 zjjf3qVbj4oYpUvrUCEPm59/+4t5ZbApNtZKFM/ct4mtqEqQOWTClAzOV1Gk+XQi
 wZ+uq4NyuajmxBGA5dEG8btkAet5gGsMuIOn4L94pXUIA9JmZchn6xCyAFqPbf3b
 h9qGqs2VNiQHsgEdarn6Bw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773741345; x=
 1773827745; bh=eRKEUtT2izeAj9P9iPctE62P5P8W+2EXggzdMXXdvZE=; b=L
 +sRcrN3J3kgfk/RrlA+bqMbfhI7MnvXHK69fHLGsT91WNRa6TM086CNLHWBKXD7o
 ZyOnfhLh16w13nzsS3uDAeBBx0JAjYoDm5R5HoH+gIGXsrXD4SkuufB78+4jdHwr
 ALk1M6vKYKx4W3E6GGM62Wyk2uyNTHDEArp/2Q9WqLe6T8yvVSS87jEQ47bgb+zd
 nrhSGRSgxNpXJojLhYVqePbnK6e/UulVsY+EITVhf2+tGsrEKlBFX+OSEp9oTBwl
 1fu1ikB3oJFfAj6r1cMVOf5yJl0Zu5Fqpp7jn0hP9ajFDKzRYBTXY5/IwwweqYQC
 DJSRI9uLW3wdV8AqI+pNw==
X-ME-Sender: <xms:ICW5aemzL-7m9ay_CkRwn0PM971a_dC4YB8r3XDGAuXbEBWaraHj7Q>
 <xme:ICW5aQwP770ClHOGt6SjgvKrV6al7D_o4viXg7YtagO1cWlAn51wknIufpXlz_0jz
 5SzDgmJBE_CGCYqOU4Ra3C08XioNMsn3mZyFUgR7YqnawTJOKV6nw>
X-ME-Received: <xmr:ICW5abqmZvvI9T_RxqcgAfaKMqc3ccQPt_n5s5tWoXc87w4L1vLtn07O3h33M86ml2SZr8huEmAinHL3zlbwXmRWJg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftddtleegucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeejpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopegsihhnghiisehnvhhiughirgdrtghomh
 dprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtphhtthhopehsthgrsghlvges
 ughpughkrdhorhhgpdhrtghpthhtohepfigrthhhshgrlhgrrdhvihhthhgrnhgrghgvse
 grrhhmrdgtohhmpdhrtghpthhtohepsghruhgtvgdrrhhitghhrghrughsohhnsehinhht
 vghlrdgtohhmpdhrtghpthhtohephhhonhhnrghpphgrrdhnrghgrghrrghhrghllhhise
 grrhhmrdgtohhmpdhrtghpthhtoheprhhuihhfvghnghdrfigrnhhgsegrrhhmrdgtohhm
X-ME-Proxy: <xmx:ICW5aX4dxkK6dh8Z9S8k_5WmQlOOpzcj9GOTTZOS9ClZsIFEOjD0Lg>
 <xmx:ICW5aaeeRcxhvJHpaXrIaD7eXgwWsL_FvLpryAMtAdN08DpIaTyWwg>
 <xmx:ICW5aU4F0ijGTqR1c2s8-8l4cITWR-sLogdjSvi2bTMyYoMfImgtdg>
 <xmx:ICW5aZsqzeEpL1AO9HQQJ5683PR54dpnWezb9-TE5VdBe6yPmfaK3A>
 <xmx:ISW5aR8ys8MUG1goo5jDMKX5a9d8RMu-IUhKZg_ZcLdJ4lTOuH9seODp>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Mar 2026 05:55:43 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Bing Zhao <bingz@nvidia.com>
Cc: dev@dpdk.org, stable@dpdk.org, wathsala.vithanage@arm.com,
 bruce.richardson@intel.com, honnappa.nagarahalli@arm.com,
 ruifeng.wang@arm.com
Subject: Re: [PATCH] config/arm: fix the cacheline size for Grace CPU
Date: Tue, 17 Mar 2026 10:55:42 +0100
Message-ID: <2191545.bB369e8A3T@thomas>
In-Reply-To: <20260317091732.289777-1-bingz@nvidia.com>
References: <20260317091732.289777-1-bingz@nvidia.com>
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

17/03/2026 10:17, Bing Zhao:
> The Nvidia Grace platform has a cacheline size with 64B, unlike the
> 128B size on other arm64 generic platforms. In the meson file, the
> cacheline size is missing to be defined explicitly. So it will choose
> 128 for building and it will impact the performance.

Grace has
	'implementer': '0x41',
which is implementer_arm with
	['RTE_CACHE_LINE_SIZE', 64],
so I think this patch is not required.


> @@ -535,6 +535,9 @@ soc_grace = {
>      'implementer': '0x41',
>      'part_number': '0xd4f',
>      'extra_march_features': ['crypto'],
> +    'flags': [
> +        ['RTE_CACHE_LINE_SIZE', '"64"'],
> +    ],



