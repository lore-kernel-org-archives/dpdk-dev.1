Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E574CCFA18
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Nov 2025 17:02:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8C11D40280;
	Tue, 11 Nov 2025 18:02:35 +0100 (CET)
Received: from fhigh-b4-smtp.messagingengine.com
 (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
 by mails.dpdk.org (Postfix) with ESMTP id 5AB884026D
 for <dev@dpdk.org>; Tue, 11 Nov 2025 18:02:34 +0100 (CET)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 61FC57A0044;
 Tue, 11 Nov 2025 12:02:33 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-06.internal (MEProxy); Tue, 11 Nov 2025 12:02:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1762880553;
 x=1762966953; bh=LCXduk9WQZRLUZhY9SMZTO0nBKfzc+J7yUG8fQrsYgM=; b=
 QkZ4mCwPBd6szSzJ/oAaP5PkP73sHYJbOfWKT0Q7H38yzaHqEI1dty1Rer2sh5Lp
 kWReEfhhLLmhBlAsZWhwwuVNSZpwD5g/MhvcdHN106nLUn+HorFM08ak/0ggwo38
 5CiLQFLTYSHqDexzLlLQ9Vqkbe5xc8lAXolCZVIBndf4irV1pXgnNyBS8BYNvfp4
 NLi7j3Nvn0i+kZEl8IQH1EqyEvExJdSYKYJRfLP2Zgos6j00I0r0LwnaL/Fq0qvY
 5agI9CObRQbZRJ06sZmgMgfw5vHukyrIlOBRFWU4gJeSgnEl5yakfRoREaBHtDQX
 jiIuX6edu8A1vEhu5cGMcQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762880553; x=
 1762966953; bh=LCXduk9WQZRLUZhY9SMZTO0nBKfzc+J7yUG8fQrsYgM=; b=f
 sq/OYuMTQeP4XpoMiNECbYRDa34+y1012qAJoSr64e3Tc5c/elelL6XMnEVIqL2z
 l7JIW5TdL4/8F1Ea+SprDRpgWSghSE4T+E7cye6TneuiSRrkh+6uXpB8P0zZBQMW
 husgxnin8WzyMp/xr6Zn7cMmAx0tOe8aPtD0Qe9sFyIPluhcMDL1YOnwakxZ7Gj7
 K4b0QMJgtgTPydfx6ptGHg6aHqWP23DKOWfpK/ag93hicyYMi9GDiwsdQztQfoii
 ridTpE34OhqesiP8yEoVMC80KbHaJ9GXTDOVrMfr5uJ6MN5Ohxm9a2BJbGxN5x5l
 ks/S0NxSRFjwYOzGguvig==
X-ME-Sender: <xms:J2wTadKAv1G-k8QCXta8hpmTuWPWuSqFl63bpra5cDBHID61E6Gbbg>
 <xme:J2wTaQBsC9UVYbu3xUFTaw-Dw4M4V69PF8X6ZXehV8U_6MwP6KNEvyC2v0U-izyGc
 0OnbK4gYinkxbL1SQdu1Ejm_zr8sBtAR8HT24Miyp5OFMdLbfCi>
X-ME-Received: <xmr:J2wTaeCO9ytj74rF4IvuwZDq9kGR6KqvDF5ZlZZCMZgHRIE3KA6GG926Sh5IIHvGKNsNODmAxglMM1dSvXHEu_H4wA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtddujeegucetufdoteggodetrf
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
 hopedugehpfigtshgvuddvvdegsehuvghtphgvshhhrgifrghrrdgvughurdhpkhdprhgt
 phhtthhopehrvghshhhmrgdrphgrthhtrghnsehinhhtvghlrdgtohhm
X-ME-Proxy: <xmx:J2wTaaA_5p5WVuquXXi-7CxAKTeEM6rvz5D7boY4sCnsQuSGBC_8EQ>
 <xmx:J2wTaRqUyCEFvmaG3YogMiyeBZP1-cHlYJD4AO1WyjwyGyPDXKolEA>
 <xmx:J2wTacnEaq8v2tYUEyXj6r4aZEgQojkGfNaYy7w492kzq9fSo5OZQQ>
 <xmx:J2wTaZynx6pM5E4YtTEOgMVDdQtdHBHf6HQsd7QXCYH18FPXkOqekQ>
 <xmx:KWwTabVhUuJjZRtSjivhgFbHDL2w0G_i0MdVGqPk1K5fnuiLcAkZ2wOx>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Nov 2025 12:02:30 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>,
 Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>,
 Reshma Pattan <reshma.pattan@intel.com>
Subject: Re: [PATCH v6 8/8] doc: update documentation on pdump library
Date: Tue, 11 Nov 2025 18:02:29 +0100
Message-ID: <4135902.zog1K27m0d@thomas>
In-Reply-To: <20251104180927.403355-9-stephen@networkplumber.org>
References: <20250811213632.16023-1-stephen@networkplumber.org>
 <20251104180927.403355-1-stephen@networkplumber.org>
 <20251104180927.403355-9-stephen@networkplumber.org>
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

04/11/2025 19:07, Stephen Hemminger:
> +DPDK provides the following utilities that use this library:
> +
> +* ``app/dpdk-dumpcap``
> +* ``app/pdump``

Should be

* ``dpdk-dumpcap``
* ``dpdk-pdump``

Will fix while merging.


