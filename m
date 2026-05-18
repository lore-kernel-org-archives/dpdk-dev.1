Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A01DCD4F3C
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 May 2026 09:03:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B7DEA402D9;
	Mon, 18 May 2026 11:03:09 +0200 (CEST)
Received: from fhigh-b4-smtp.messagingengine.com
 (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
 by mails.dpdk.org (Postfix) with ESMTP id D06D440265
 for <dev@dpdk.org>; Mon, 18 May 2026 11:03:08 +0200 (CEST)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 1C2487A00D1;
 Mon, 18 May 2026 05:03:08 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-06.internal (MEProxy); Mon, 18 May 2026 05:03:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1779094987;
 x=1779181387; bh=EuMiRoGiYsxVNEwv7aTjqYGdu3waDr07JpZP6LdtM1g=; b=
 GxfH4ToSSsgsmWApjiqO2HrBWqhElMiogpr6PhSpAZvO3e8WhsUM/fsrJX5lqLi3
 25aFWSIXR9GnjoTqJO3Vs8+J1rgJJhVo7be85JHoJQGGDMQplBFbw9V67zg/zwYh
 lCvT1eOFhElvsKX8NSs46r7K9/uZdCNJmgGs78/+iNJWzsNRvL4CeYQqlRJS5kUT
 u3PVFXqscFL9AIOQsDREjs5wv/4XCYcs12HZ7C1MndrkwP8QJDzkmBzQDOoGMZth
 eJjSlubccK34GRNwrYIrnZjcScMysnxG1HmSz5ai1f78RMrCnaIKaBMkm74YV3wt
 DCfgbz91nxB+8krjZzDH8Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779094987; x=
 1779181387; bh=EuMiRoGiYsxVNEwv7aTjqYGdu3waDr07JpZP6LdtM1g=; b=O
 nSlrTXyMlC+HXbxsX4xjlKAHiwAl0tIZKCYozu9S5+ddcGE2AeF0j925I6R30kKT
 EFRQi6IQVxvY145OKQ8Xc+OzRsitaU5VYp2tj1M1TqIElSiCbUI2Obka8QJxmX3H
 2FF93zm0LvP/wMvpnfohA9uFadAG1j6Nqow+SK1niR1kYx0TSARDaWY6B1EmyhYz
 fNVjchvOC/59t0ebLNtHmw+q7DcM4o3u7OqOtO+9mfOn12tr63kjdLjhYlK2hPR9
 i1IEsnVEef8LcnOgrf2HsiaNGLeay2RzIKy/iJKKH2KjuvPrOoXQPniv7BtVcmtd
 uhra6w7H5LBjZEMGZGpVA==
X-ME-Sender: <xms:y9UKavEuDQhGXEYM_L-f2hvIrbKTobzGBn5fTkpc3qg1TPjfwYsmgg>
 <xme:y9UKaopvoEvoL3qbvrU9lECTmugpmqQktWvv_6gmptUhYLze0ZaYnKV64OUI4a7bo
 hLq04h-ywXYjP6oU_Rt60ZioTPmujXVGu6EcccZnlTWf_gqeVnzRw>
X-ME-Received: <xmr:y9UKaj6DvOVDXEa_gehoR5LKrnx7b5u3-9dF8R18HJD3zI470LDTkWDTPmsgK3DUAfiBzQpnFDBv6Uht67CJHeF23w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddufeekgeeiucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopedvpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopegsrhhutggvrdhrihgthhgrrhgushhonh
 esihhnthgvlhdrtghomhdprhgtphhtthhopeguvghvseguphgukhdrohhrgh
X-ME-Proxy: <xmx:y9UKau406ciaL-KQt1mNDPk2hudLQTMjZasBymWygRNb984XHdjAVQ>
 <xmx:y9UKaoFTinQVNs33F-ZV7oYnEvH_YQVfKBd3AZ7uhNKVXMMIWD4okQ>
 <xmx:y9UKavS8sebVbSkSpt7qUa4BQ7wads1tmvVXWbbkE4nCrpJt5qCi-g>
 <xmx:y9UKapspJ5xkRlFjWqoPwRp6Tr-iKx_2PzGd8P6IwYykEynou_Y1PQ>
 <xmx:y9UKakMKEXBonJo43gm-XRAher7Cv_eXtSonxdl2dXqTdWXRc6-HQ0Ck>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 May 2026 05:03:07 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH] buildtools/cmdline-gen: add more headers to generated file
Date: Mon, 18 May 2026 11:03:05 +0200
Message-ID: <E07FO5PfRW6TuYjxDq_Vmg@monjalon.net>
In-Reply-To: <20260430113053.2397113-1-bruce.richardson@intel.com>
References: <20260430113053.2397113-1-bruce.richardson@intel.com>
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

30/04/2026 13:30, Bruce Richardson:
> The generated cmdline header file output often uses uintXX_t types for
> parameters specified in the input file. Therefore include stdint.h so
> that the types are available for uses of the generated file without
> requiring the user to include the header in their C file.
> 
> Although not strictly required, also include cmdline_socket.h too, to
> provide the "cmdline_stdin_new()" function. The standard cmdline.h only
> provides the more generic "cmdline_new()" function, which is less useful
> for many cases. Therefore, having the extra header include just makes
> things a little easier on the end-user.
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>

Applied, thanks.



