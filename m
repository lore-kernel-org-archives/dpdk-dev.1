Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C0F8CF2579
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Nov 2025 04:32:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DC4BC40265;
	Wed, 19 Nov 2025 05:32:00 +0100 (CET)
Received: from fhigh-b2-smtp.messagingengine.com
 (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
 by mails.dpdk.org (Postfix) with ESMTP id 9E2784021E;
 Wed, 19 Nov 2025 05:31:59 +0100 (CET)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 051D57A0091;
 Tue, 18 Nov 2025 23:31:58 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-02.internal (MEProxy); Tue, 18 Nov 2025 23:31:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1763526718;
 x=1763613118; bh=z95/50Z8QiryWP5epmyL93Oj4hEgXQiUK2cfIhaYhkM=; b=
 tYQ6toB8Ke71cNgn1HoJOnDTlfjJo1v426XgrJk+7tQSPciHq6fxUOfM/BKab8kd
 657Jt5JG9QaJOTiyqHqOc6FiQEXPuu7xo/w+erJEJGb5L5RjQ1SVIZXgqRUHAYkJ
 FJ1h7XXCCJjbDhWxIW9lGUDZv7Dsh9mMnW8sC/p5NVfy0JYOUiWrQOpOB3Cl06G/
 fjxF+rJNRVD4598/FfUglvsFOYAQ5LXgcNrFrnNI0I4J0VaIzcPvgHpcQlyDkhwk
 JwwB4xLOIJrzh0E/KQrk3tfR8PzB/7VA5KBoNYh8QFsCQQs5t2Kxv5/Wv2TvxC9F
 p0YhMz5dDRECnUpsWCB4cw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763526718; x=
 1763613118; bh=z95/50Z8QiryWP5epmyL93Oj4hEgXQiUK2cfIhaYhkM=; b=v
 Ms5JKehTAsh0jLsAQNrgGhO8ffxn9F5CmGmYd7LwLu3c3cDCiFPl0Br0s0IMsyEv
 cR6p049KBwNV8Xs/EmmOVAWoddqV4qIk4xqeELMjO5nuAyjn7wFC+eIXGirurGkB
 Mv3HfNaaAoI2rH0Pj1cXUyTZuzp3wHNRXxThXAHrRxl5A0hyWTeo4mv6q84b3Xbw
 6E6JxtcN1EiY5U81R34OTIP5Q3JqH6H7xqW/1szCV4QArRQh5tsNol9p1s8FR/SQ
 QM7q++bDeRAgwGPdredAcl5Yz/ATOScWRraKr5UchaKKhJ332AdMm+//Bn4/kIux
 bnD579bEALIIIXlckhnbw==
X-ME-Sender: <xms:PkgdaZrVprzgQrOyUOvgZcaxXtcjsk-la80DaaqKBmzKBgwavrH4IQ>
 <xme:PkgdaXGcf_sK-gi_c9I9FddT7U6D5wjwV9rnuqmJ5QUhWCAPcZMGu00GPGvMarcOV
 vtaPwy0Ep7uoOZ2lCXssN87ytIIAMkouyTBZTs8pweFigYO4GXNew>
X-ME-Received: <xmr:PkgdaZs1-nm6gdi0grGjamkDiC72OpbvlMW_UuDGX1OkR__ZyrT8VTSCggS3kWFHZJCNVCIVeo1uJZ_oNhdxbAF3VA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdefvdehucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeehpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehsthgvphhhvghnsehnvghtfihorhhkph
 hluhhmsggvrhdrohhrghdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtphht
 thhopehsthgrsghlvgesughpughkrdhorhhgpdhrtghpthhtohepmhgrgihimhgvrdgtoh
 hquhgvlhhinhesrhgvughhrghtrdgtohhmpdhrtghpthhtohepsghruhgtvgdrrhhitghh
 rghrughsohhnsehinhhtvghlrdgtohhm
X-ME-Proxy: <xmx:PkgdaZX7wquYP6uKsi34knAlhIrzYwJXWwQEc0uyl2UI3f7jpnHXZA>
 <xmx:PkgdaVGPexa-70DhL8IxfxEK0BhIdPW5Jqv5GIwVcJ9taW81An2fGQ>
 <xmx:Pkgdab31q3eMiy3uec4C49oiTGPbSa5fPB9z7c32X4dS4-waw-K60g>
 <xmx:PkgdaXMsURgZ6zdn9e1rjt2J15Y-vr_nWuSA8WUGjMChyuhtOsYwIA>
 <xmx:PkgdaZ35PtywupoT9fRGMW36JAHk76jXJsBzn46rWc6NhhRUwAVbyQTD>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Nov 2025 23:31:57 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, stable@dpdk.org, maxime.coquelin@redhat.com,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: Re: [PATCH v3 2/4] examples/vdpa: fix format overflow warning
Date: Wed, 19 Nov 2025 05:31:56 +0100
Message-ID: <5387340.ejJDZkT8p0@thomas>
In-Reply-To: <20251115193749.101355-3-stephen@networkplumber.org>
References: <20251110182209.104087-1-stephen@networkplumber.org>
 <20251115193749.101355-1-stephen@networkplumber.org>
 <20251115193749.101355-3-stephen@networkplumber.org>
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

15/11/2025 20:36, Stephen Hemminger:
> +#define stringify(x) (#x)
> +#define MAX_VDPA_STR_LEN sizeof(stringify(MAX_VDPA_SAMPLE_PORTS))

Can you use RTE_STR?



