Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BEDEC5AE59
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Jun 2025 13:28:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E651C4069F;
	Tue,  3 Jun 2025 15:28:13 +0200 (CEST)
Received: from fout-b3-smtp.messagingengine.com
 (fout-b3-smtp.messagingengine.com [202.12.124.146])
 by mails.dpdk.org (Postfix) with ESMTP id 8611B40697
 for <dev@dpdk.org>; Tue,  3 Jun 2025 15:28:12 +0200 (CEST)
Received: from phl-compute-01.internal (phl-compute-01.phl.internal
 [10.202.2.41])
 by mailfout.stl.internal (Postfix) with ESMTP id 72DCD1140137;
 Tue,  3 Jun 2025 09:28:11 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Tue, 03 Jun 2025 09:28:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1748957291;
 x=1749043691; bh=PuGLySanmEArVySMvBgvcc4IIKzptBSxNNnhjD31fUg=; b=
 MFVXwqZ5ajr2Vopxgu0wAoC31+B0ieYg16embrdsPrXhaaVCMVYMDM/Vf8tGEnk9
 npf8NI2phzxBv8tWr4vgldqZyPiAtGCJcZ648dXZeGII3+Gi5Uyjs5beNnVsDSsl
 A44GT1TCLgpsyXLLBgYxxzTzoS0QJqBGqwMnRYzdT32OVHFFbnlFSQanKULl8vwb
 TmopYObpYNOFepMsBIEtRTwCu401zw0dopkpCO+QwilceDNBxiJZfmWoNrriX0C4
 ndvFkPtz+Dr4Sc64zTJlJMdAptwutSiPHs1iNg2mZUcIndqiR4HGB+2C8F4zsON6
 VNHqKpWskoMmgX9iZpWNVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748957291; x=
 1749043691; bh=PuGLySanmEArVySMvBgvcc4IIKzptBSxNNnhjD31fUg=; b=Y
 9e4BaFAEWsR5HjxI24l9Qrn8uBuyV4CDmNyvu+LyEMPqHwFfy51R80VW2Imp6onN
 M6OsBqFrxYR2JApYU2ErCItnoJyczjracolBfeKBap6Y2vTv2Vn2TugMhNztqvx9
 VqeGoaUBkacb/Cll3vj2LpBOMPPepCdKra0nOOPtb2efyXiC9xfuU7OWpVWYfgdS
 TdsET0djuD/1UohRd7/tId7sDc3wI9p77LD3hAvmHa7pYhdYVDRwMNFrQRglw4gl
 bhpbx1a/Hp73kl5VGizsNPGikjTRjQrBhmGfE73cA1ndquoSzpG7jYw7JFl5gKts
 j/ZG0Le9UnGoTAlPKAFhQ==
X-ME-Sender: <xms:afg-aE9wTROPyvdxvRnQMYfdNhCMDVIfWTR1RvPpFVb3BCevV9vNOg>
 <xme:afg-aMvnqR1b4dmWsCQeXL2b_BFu5GZ_2z9q6yZfgG0VYMNkojFaO6va72D1I9PW4
 q8CeNGv5UIfD0Ptow>
X-ME-Received: <xmr:afg-aKBrHPhzO8PGrkFDqJPDv2HfWJs7kQJlOvMUdZzlC5VBIRdhXS-MEnZ8LotUWyGbDjj8CLgiZ_nAa79wHVIQRQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdefiecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
 tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
 hsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecu
 hfhrohhmpefvhhhomhgrshcuofhonhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlh
 honhdrnhgvtheqnecuggftrfgrthhtvghrnhepjeduveehieevuddutdevfffgtdegkeeu
 veejffejgedtgeegkefgvdeugfefkeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
 hrrghmpehmrghilhhfrhhomhepthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgs
 pghrtghpthhtohepuddvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehtughush
 iihihnshhkihesmhgrrhhvvghllhdrtghomhdprhgtphhtthhopeguvghvseguphgukhdr
 ohhrghdprhgtphhtthhopehruhhifhgvnhhgrdifrghnghesrghrmhdrtghomhdprhgtph
 htthhopegsrhhutggvrdhrihgthhgrrhgushhonhesihhnthgvlhdrtghomhdprhgtphht
 thhopegurghvihgurdhmrghrtghhrghnugesrhgvughhrghtrdgtohhmpdhrtghpthhtoh
 epjhgvrhhinhhjsehmrghrvhgvlhhlrdgtohhmpdhrtghpthhtohepkhhonhhsthgrnhht
 ihhnrdhvrdgrnhgrnhihvghvseihrghnuggvgidrrhhupdhrtghpthhtohepmhgrthhtih
 grshdrrhhonhhnsghlohhmsegvrhhitghsshhonhdrtghomhdprhgtphhtthhopehmsges
 shhmrghrthhshhgrrhgvshihshhtvghmshdrtghomh
X-ME-Proxy: <xmx:afg-aEf_Lmlx9qi24NY5zJxrC7_9kx8-eVJC4DmgJkfhyGuaEa9U8g>
 <xmx:afg-aJM_FCYiROm_UxpdA1nkUKdQrvyfmmrcLRhrN_GPfIaFiVVRpg>
 <xmx:afg-aOm_J_5uJZFY4AQplRqFZ0Qg3LKlDswd4HzY2nWZD9X9XmGm_A>
 <xmx:afg-aLudwViWbIAtzO7FtYm-X0WJ-H3Sc9Hhau3Q24OixlEvA3oTDw>
 <xmx:a_g-aHAYqk3foQPWBVui4Uei0gzFRZuoqLT6j628eCCuYrvb4rb1mVgO>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Jun 2025 09:28:07 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Tomasz Duszynski <tduszynski@marvell.com>
Cc: dev@dpdk.org, Ruifeng.Wang@arm.com, bruce.richardson@intel.com,
 david.marchand@redhat.com, jerinj@marvell.com,
 konstantin.v.ananyev@yandex.ru, mattias.ronnblom@ericsson.com,
 mb@smartsharesystems.com, roretzla@linux.microsoft.com,
 stephen@networkplumber.org, zhoumin@loongson.cn
Subject: Re: [PATCH v17 0/4] add support for self monitoring
Date: Tue, 03 Jun 2025 15:28:06 +0200
Message-ID: <15762368.uLZWGnKmhe@thomas>
In-Reply-To: <20250117090033.2807073-1-tduszynski@marvell.com>
References: <20241118073706.3129423-1-tduszynski@marvell.com>
 <20250117090033.2807073-1-tduszynski@marvell.com>
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

Hello,

17/01/2025 10:00, Tomasz Duszynski:
>  lib/pmu/meson.build                      |  22 +
>  lib/pmu/pmu_arm64.c                      |  94 ++++
>  lib/pmu/pmu_private.h                    |  32 ++
>  lib/pmu/rte_pmu.c                        | 537 +++++++++++++++++++++++
>  lib/pmu/rte_pmu.h                        | 251 +++++++++++
>  lib/pmu/rte_pmu_pmc_arm64.h              |  30 ++
>  lib/pmu/rte_pmu_pmc_x86_64.h             |  24 +

Reading it again, I wonder why it is a separate library.
In general we give access to the hardware in EAL.
Why not having PMU in EAL?


