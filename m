Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 417ABCCD18E
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 14:29:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3D64F40613;
	Wed, 15 Oct 2025 16:29:13 +0200 (CEST)
Received: from fout-b7-smtp.messagingengine.com
 (fout-b7-smtp.messagingengine.com [202.12.124.150])
 by mails.dpdk.org (Postfix) with ESMTP id 8942040273
 for <dev@dpdk.org>; Wed, 15 Oct 2025 16:29:11 +0200 (CEST)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfout.stl.internal (Postfix) with ESMTP id C46051D001AE;
 Wed, 15 Oct 2025 10:29:10 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-01.internal (MEProxy); Wed, 15 Oct 2025 10:29:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1760538550;
 x=1760624950; bh=YAzs3rqc1fWf4tQ76k7rxLd7jxqARBZvOaDbOsoQ980=; b=
 CxG6lP4nONp272jRBGOOIwu3FB4HmhgZUUt9xVru88WawduCKElhwuigDMMYvDV1
 lVsOPtPZFw3XrvYDgjAimFj3qka2+6hckcwyNVnO6HBnsHKmm4pqDw+bn8HBiu1A
 96+8Pn1ropbnUzIHVE1BSgDtJmFKO+OcUm+I8zTVKDwSQspMX3adRYO3rZOShCPA
 j41TJZn2u3iWJUcj0OV7doGWN61WreREEHvB/JZmgwa/wXb6imnVlwdvNeCgw7CZ
 iVIqF2tVQevFz2TBNvAzQvciDhAWrcRs0UvKstBoYUWIIyrulum1oWpbUxrBR0HC
 hU8lqoC6k06hsgGoELwqTg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760538550; x=
 1760624950; bh=YAzs3rqc1fWf4tQ76k7rxLd7jxqARBZvOaDbOsoQ980=; b=x
 fpJTnXoGcA4BIHPtK6UEVvOLIsrGVNd6QykGuK4EpBcGYOVKl5VWJyxGe+SAJOnM
 ThsCGUdDjQgIDO5mbnOU1ouQ/RSb9penYI7yuDBtFhD9wPzo4nX1cBJ6yl6Th1Bj
 2+IivbM1tAZ/LiApiDFKdgu+t051m0Vi4aWVs8sf5GEoxNZiiuRPOOy5uP/uOxzs
 Oum1CmwS5xNNbscITh98AMvCfQrQioDCZ8v/PKTsVzUKZy1/WDA1RMQ18gTU3vak
 iCbFVudeY7nQxIk2pR2SqVMjQOuZKi9GCtb43Rd+tOyEu+WsXbRr2sijuHKygQtu
 3D3lfVn9hy5IeBw+ADWiw==
X-ME-Sender: <xms:tq_vaChBNh34ml78_P8Y2G1QOpaHRCBhLWUUJfqFPompIOdmRqMb0w>
 <xme:tq_vaPWaLrHDmJSaGPL4xkBVZOwjRaVzqbNl75nj9-m_LlbUb7_-RbEJslAaFbIq_
 g_BmHouqgdWAkUbS4k2dKMo18njrCvOZ0hGxZqDvkDMC6kFGESQ>
X-ME-Received: <xmr:tq_vaM0h666M7XFdx5ou1yYBgGfg0juYOgVsyJnjXKrc6a7Kge9add0oJagMfWw9Q8n3Z_Kw4sbEI1FXGOhSNvOFFA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdefieehucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopedvpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopegsrhhutggvrdhrihgthhgrrhgushhonh
 esihhnthgvlhdrtghomhdprhgtphhtthhopeguvghvseguphgukhdrohhrgh
X-ME-Proxy: <xmx:tq_vaNExC4KnbTsjws7a4ug-lE9btgZo9LZFZE4YwAx00ZrQNT-1eQ>
 <xmx:tq_vaCjyeswSSLXIn_WNjAvpgAQEhRZ_p0QSAR5x_xr17rnoOACDaw>
 <xmx:tq_vaA9Uo5qN6mxUp6CbxAkPB9Sf0Jiag2Iny3wrxHfDSF9Nb7B0Vg>
 <xmx:tq_vaBrCqv6k_4jQWPeQfMQYkUsphxZqCh1oWvWQTiHp8DwZsXWN6g>
 <xmx:tq_vaHKFGHC0Kq-vekXLih215sXRQM_zFsy-7zHg_TATOZjlGG14EsiB>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Oct 2025 10:29:09 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH 0/3] Use cross-platform rte_basename function
Date: Wed, 15 Oct 2025 16:29:08 +0200
Message-ID: <4790695.6PsWsQAL7t@thomas>
In-Reply-To: <20250806133833.3236170-1-bruce.richardson@intel.com>
References: <20250806133833.3236170-1-bruce.richardson@intel.com>
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

> Bruce Richardson (3):
>   app: use cross-platform basename function
>   eal: use common basename function
>   dma/idxd: use DPDK basename function

Applied, thanks.



