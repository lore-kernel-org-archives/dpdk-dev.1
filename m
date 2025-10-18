Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1CEDCCD195
	for <dpdk-dev@archiver.kernel.org>; Sat, 18 Oct 2025 15:55:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4AAA74021E;
	Sat, 18 Oct 2025 17:55:15 +0200 (CEST)
Received: from fout-b4-smtp.messagingengine.com
 (fout-b4-smtp.messagingengine.com [202.12.124.147])
 by mails.dpdk.org (Postfix) with ESMTP id 92F2D4013F
 for <dev@dpdk.org>; Sat, 18 Oct 2025 17:55:13 +0200 (CEST)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfout.stl.internal (Postfix) with ESMTP id 857ED1D0008B;
 Sat, 18 Oct 2025 11:55:12 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Sat, 18 Oct 2025 11:55:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1760802912;
 x=1760889312; bh=KEjvbc9s4e9HSGjgSxPHRO5FFiZ44Gk8wE2VNWF0MAE=; b=
 buprsIcXFc51Zu5JoGx/psibeMZAzU1X1uomM8ufJELaxaOR9nxLFrsobJ6ZPG/I
 ng0H/dKYrSO8MxZXfnhMgIOTvLn41qTx4UE1p09q9AUUJ1i9KtxtlKQtEB6bWbU5
 UglVTQdP7uzJI02ZBgUa7RxNnxjodPdstis8UK3yoY4FWIowhn1m1NEUm7vcUwSz
 YwJxa45Rrat6mN9VIIBqAfgUkfa9NqwoG18o5BPEYfPomhTQL7BBAed/bWrJZMiv
 38/mGuytImYQy2w3qvE4JqVcgaXUVpKzFCNN7YfegHs1Blq10avP1bKXdQHnD4c3
 yv1o2DLOrz+FrVXndRxNiA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760802912; x=
 1760889312; bh=KEjvbc9s4e9HSGjgSxPHRO5FFiZ44Gk8wE2VNWF0MAE=; b=r
 P9UQ5VE9VoMstLuv6m+dcI9fUz8MjzJk1io/YZcPwSBMU4U77wSqBVyGO9kpIfYp
 bhcqFq7l0UKGwO3kwKH/dJSAqclq45Zru+s3nnoVovHpcJlUSEdslKWMLCxRw3sp
 m+V8FutE5GrBH00aha/bBKUWbGuUY8TR8JZxYJad4j9ax63Nu0HAKPhHrGUTsJ9z
 +ifTNu7jNkqRxvgDgIlE4emQRMfV4lKAGu39J9QP75GnmKXtfuYuIQUeGILzhQR7
 VEr92aYJ3yYl7cLP88McRoCOssdYGkbg+LrqP/RNTNBdsuYQXi3gyz/s/P79yV9J
 sM5AU10ohwcqVT8Wmve4w==
X-ME-Sender: <xms:X7jzaKM8YQqplUMryZtg4F1J3KTcXVJcm6uEe3VYD5FAcPAuC3nI8g>
 <xme:X7jzaDCjclou60PyqwL30MeD1ByveGRPVLw9M65H8qmaR7hbHYQaYrGRJdBStZou7
 NdDyYs-QbXzsVLhNZ3BGeaf4VnFicbLdqc8wsYEgef5CQKH_djr0A>
X-ME-Received: <xmr:X7jzaBL3hgWhhjxVOh9i9xyvzAhPiGbMkQZxGnR8FH4h0I7525OBHL__W_GBGlIr51gnKXBbIYOIlIQZsLf7eBDeRw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddufedvgeeiucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertd
 dttdejnecuhfhrohhmpefvhhhomhgrshcuofhonhhjrghlohhnuceothhhohhmrghssehm
 ohhnjhgrlhhonhdrnhgvtheqnecuggftrfgrthhtvghrnhepjeduveehieevuddutdevff
 fgtdegkeeuveejffejgedtgeegkefgvdeugfefkeejnecuvehluhhsthgvrhfuihiivgep
 tdenucfrrghrrghmpehmrghilhhfrhhomhepthhhohhmrghssehmohhnjhgrlhhonhdrnh
 gvthdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
 vhgrthhtuhhnuhhruhesmhgrrhhvvghllhdrtghomhdprhgtphhtthhopeguvghvseguph
 gukhdrohhrghdprhgtphhtthhopegsrhhutggvrdhrihgthhgrrhgushhonhesihhnthgv
 lhdrtghomhdprhgtphhtthhopegrnhgrthholhihrdgsuhhrrghkohhvsehinhhtvghlrd
 gtohhmpdhrtghpthhtohepkhgvvhhinhdrlhgrrghtiiesihhnthgvlhdrtghomhdprhgt
 phhtthhopehjvghrihhnjhesmhgrrhhvvghllhdrtghomhdprhgtphhtthhopehsthgvph
 hhvghnsehnvghtfihorhhkphhluhhmsggvrhdrohhrghdprhgtphhtthhopehfvghnghgt
 hhgvnhhgfigvnheshhhurgifvghirdgtohhm
X-ME-Proxy: <xmx:X7jzaMNZcovQ6bbu93J-lKX5RgWQKnRMbBLPYwAkTLYAeQsvnP42Eg>
 <xmx:X7jzaP4npolwlWvPQfmosCP1UEjf-fMLKr5tIRC9qSFin6znXtvV6w>
 <xmx:X7jzaO5YvnqFCRYSP7L_iOeQIgw5bccGi5T3IlxMVnWQYfT8bp8g8w>
 <xmx:X7jzaNE_mM5KgoOLiU7wmEzmR8qLoMp_UZ1si111xazZqrvGdtAWKQ>
 <xmx:YLjzaD-Z5X8IFi85Hl5IMERqtvjwnrQdbSF1x8dZl9vl7LCZuO_N11mV>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 18 Oct 2025 11:55:10 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Vamsi Krishna <vattunuru@marvell.com>
Cc: dev@dpdk.org, bruce.richardson@intel.com, anatoly.burakov@intel.com,
 kevin.laatz@intel.com, jerinj@marvell.com, stephen@networkplumber.org,
 fengchengwen <fengchengwen@huawei.com>
Subject: Re: [PATCH v4 1/1] lib/dma: introduce inter-process and inter-OS DMA
Date: Sat, 18 Oct 2025 17:55:09 +0200
Message-ID: <5076338.MSiuQNM8U4@thomas>
In-Reply-To: <b0ba957e-c147-2a55-283b-281063235bba@huawei.com>
References: <20251013042136.1727540-1-vattunuru@marvell.com>
 <20251017054210.3105218-1-vattunuru@marvell.com>
 <b0ba957e-c147-2a55-283b-281063235bba@huawei.com>
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

> > Modern DMA hardware supports data transfers between multiple DMA
> > devices, facilitating data communication across isolated domains,
> > containers, or operating systems. These DMA transfers function as
> > standard memory-to-memory operations, but with source or destination
> > addresses residing in different process or OS address space. The
> > exchange of these addresses between processes is handled through
> > private driver mechanism, which are beyond the scope of this
> > specification change.
> >
> > This commit introduces new capability flags to advertise driver support
> > for inter-process and inter-OS domain DMA transfers. It adds a mechanism
> > to specify source and destination handlers via the vchan configuration.
> > Until standardized control-plane APIs are defined for various categories
> > of DMA devices, these handler details can be exchanged through private
> > driver mechanisms.
> >
> > Signed-off-by: Vamsi Attunuru<vattunuru@marvell.com>
> Acked-by: Chengwen Feng <fengchengwen@huawei.com>

Added release notes and applied, thanks.



