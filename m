Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50DA8106ACDC
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Mar 2026 18:56:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B632C402AC;
	Thu, 12 Mar 2026 19:56:28 +0100 (CET)
Received: from fout-a8-smtp.messagingengine.com
 (fout-a8-smtp.messagingengine.com [103.168.172.151])
 by mails.dpdk.org (Postfix) with ESMTP id 9213340275
 for <dev@dpdk.org>; Thu, 12 Mar 2026 19:56:27 +0100 (CET)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfout.phl.internal (Postfix) with ESMTP id 19747EC009E;
 Thu, 12 Mar 2026 14:56:27 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-04.internal (MEProxy); Thu, 12 Mar 2026 14:56:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1773341787;
 x=1773428187; bh=GiLttIolOZ8XreknHz1JHV98wfl8tDTRd2Z56ThetjM=; b=
 epsBIez+jXoP3Y1vmrYhYv3shrt/NxARQG0VVg10VYYOkwbVMvsuWWxxr8BE6kBi
 iu8IPM9Ux8cZ57a1DCWA3ssv1mjfhfhb4K5AhH3wgSR1Q86VdIfrIi9YV/5LPL5a
 KRO8OSN/5dAf1qqQAzLQWWTpTg2ufgd8uMC8ITIiEcSTR+ez1D3qscpFijHHmvGZ
 2HaqXrHZHinxzwkhjV5LK/n+NQR4CskhoFJfz5TvUX6amrLleEqXSd3W+/PAklkl
 +qG5RdMvdxRU7RDXcY53h2Y/zPtqZfKs1yJyaH3OqfmRtZqEXCe9Ono2/Orq9itk
 EF3fHTyPY+CkyDjsxTuq1g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773341787; x=
 1773428187; bh=GiLttIolOZ8XreknHz1JHV98wfl8tDTRd2Z56ThetjM=; b=c
 0k/QHTQKv1MT/guC1sGL0KmQeT85cwOrkBX3ecaGW9FiC6nDx/Fv2H5DgdDETljq
 yfTRIDkbzifRMmsOomxu7cavyesOBE5DzCGDCT3hsOQUQGt5D8rC0xgf3HirYt88
 bmfmtQRcfi2oQku+1HfUHbBuZBGxA/0kJ4AIStu5yiVLrMwfWEwq9SNi3REI2ydu
 eoOcyrh13rtJ/w51FXMkRXu7kzy6o+nMR3IJ5L0PTUEEs56MKWB3CGyKV9daCERS
 tPHuAos5TYnGkwwEKESZ3ERh1Wfc/UQZWbpbZqQlGWAdsqIPBdWU9+WcD3SprN2N
 Kq7t6oHttF4KUH1LAFV2Q==
X-ME-Sender: <xms:WgyzadtMZV9LDlNZLASXixyH9WAgcr2mFkrx0raSXR-adgndjTh0Ug>
 <xme:WgyzaSxovSYkqSd-eHJCb-NHBmhONsiS7fkKndogC6M6icM0C9xO6zwrurhroF8VT
 hoh1WiaepzELrwCa1t-ecF4lJ9okuzec2CPvJkXYWPE4AGr9rsrTw>
X-ME-Received: <xmr:WgyzaTjsy-mQRvLOMmZGimrknIoXePNTGjbOanxo8sWAazLbUlO3rPw4rKkMbYpRU5hDkCbc7yKODhMiyG7xPBEnag>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeejheeiucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopedvpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehsthgvphhhvghnsehnvghtfihorhhkph
 hluhhmsggvrhdrohhrghdprhgtphhtthhopeguvghvseguphgukhdrohhrgh
X-ME-Proxy: <xmx:WgyzaWCDQe7DgzP6GdUoCJbOh8SvspEzpgqhFEiPsRtEw6fZykmIgQ>
 <xmx:WgyzaQsmtt6vmjJj1_IIX1iHnGyZbR3F5NHKr_ZBSvWkOKQ43PaB2A>
 <xmx:WgyzabZduj1vZULmvtPmiVoyKXBJQerf01wi0EJhtnMnrPfinr37IQ>
 <xmx:WgyzaTXoGdrvP5xcE1YOco42CPDPO7YSLAFOVyQWXLxDXrRGyoVOAA>
 <xmx:WwyzaTN-7l2pNoB5wU0ALRWK-2vhd5nSo7-OmTgB8f-qydEaDA_hai8C>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Mar 2026 14:56:26 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org
Subject: Re: [PATCH] devtools: add Co-developed-by to commit log check
Date: Thu, 12 Mar 2026 19:56:25 +0100
Message-ID: <23032153.EfDdHjke4D@thomas>
In-Reply-To: <20260312185403.1051832-1-stephen@networkplumber.org>
References: <20260312185403.1051832-1-stephen@networkplumber.org>
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

12/03/2026 19:54, Stephen Hemminger:
> Add Co-developed-by to the recognized tag pattern and tag
> sequence order in check-git-log.sh.

Why using such tag? Signed-off-by is not enough?


