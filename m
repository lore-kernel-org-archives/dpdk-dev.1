Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EA6BFED9E8
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Mar 2026 15:52:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 47E6A402B0;
	Tue, 17 Mar 2026 16:52:46 +0100 (CET)
Received: from fhigh-b3-smtp.messagingengine.com
 (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
 by mails.dpdk.org (Postfix) with ESMTP id 445F040270;
 Tue, 17 Mar 2026 16:52:44 +0100 (CET)
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 1EF1D7A01C2;
 Tue, 17 Mar 2026 11:52:43 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-11.internal (MEProxy); Tue, 17 Mar 2026 11:52:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1773762762;
 x=1773849162; bh=frih9N7+az9lIcEnTSKTlWJCigJumH4wb/uN9cXm5Yg=; b=
 AstAOVgTDJ6mo6wGuXLdMg2MDTQ1kMoCmuh5EsrjFba4y+P4HW6a0hAxW+yLvnRY
 crG2FGz1/FxvV6bkk0xvrOtx7kgml3+SEHhjGt9HhxgYNxsOxkdT52kfJvBYV7tQ
 adi2raaKfZBicaYBAWuzrZ/f6iV+zs0JFpQQOzhEq62DYC57sz20APJxE5zROs+9
 CdtgZ0MXFJbVeCNBNN5MmjSBSt1zFXzz94jRHk3gQYZasjFDwuiH2EaDc6/FZHg8
 WRTBqbAGr4PJf8gDQp/9edMnL8FlJBvXz77+GAe4yhHGRbJ078SfZBZzOymwzBqJ
 aMEWnjEnioajn8ijlBlUzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773762762; x=
 1773849162; bh=frih9N7+az9lIcEnTSKTlWJCigJumH4wb/uN9cXm5Yg=; b=p
 pFEO4kHKAxrtXkWXky4pw97xnjzONHkrZb3EoJn+FUKBwngk9bV4Dn8KIH1lfC64
 S00k4RhuhEt/vBQAdHV+kV6un15AiKEJMEk0C5ZvtjPjnoYi5YJvBg2bFH91dX7t
 XXCmLbR2oVrHSrHbWxT3uJECE+aNYMK55rAr1NDrS7ficxpbQ0+Il5NwclJuVvZk
 vDD68EkT3F04kq5pH03UHi3pGfnyyY0UDRbYEgL9K6SGzsQAEttHdU5DZaXrNucG
 0/QtiKf1bmUkDe/ayVeBG/xAXx3kNwUj8iigTex/97qsOm1TfA1ajZrEdbHnw9J+
 CBJGnCSr3snjMROK/J6JQ==
X-ME-Sender: <xms:yni5aXuO2mVmyU67K3KTAhk7ZgCriQD987bmqIXb4O0hWfpPzl9nVQ>
 <xme:yni5aRaGccHNdF1fwy8h-_ir-Q6hjZsSmCG7ebICBcm_yXK5R42wdrAlYYSMQz9vs
 EX8Z918ozgfqlFo3DSmgPm3fei9dtFoJ-fXCtr5VLKLUzQh_7FqHw>
X-ME-Received: <xmr:yni5aWUjT2KgH1d9m4NkvcZYmQKGot1N_PbUwNQsBAQ9oam6GfGtswBiSP_9y-bn_yz0JaqlrIx4J6g2tmoeXfPVbw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdduieeiucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeeipdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehkthhrrgihnhhorhesrhgvughhrghtrd
 gtohhmpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpthhtohepshhtrggs
 lhgvseguphgukhdrohhrghdprhgtphhtthhopegrmhgrnhdruggvvghprdhsihhnghhhse
 hinhhtvghlrdgtohhmpdhrtghpthhtohepmhgssehsmhgrrhhtshhhrghrvghshihsthgv
 mhhsrdgtohhmpdhrtghpthhtohepshhhphgvrhgvthiisehnvhhiughirgdrtghomh
X-ME-Proxy: <xmx:yni5aWQRDCQ6WHqmNi_BW2rjp5o3SGiqheA8izDcGVJ5Rq0rOHLtZQ>
 <xmx:yni5aUOatjkx_ha-_IXZUBgTsPMfh-Mt1o36TlfcvgswLCz-Ze2Mvw>
 <xmx:yni5aURQCdWrAlgLKSTYU8fGG69SVhbZ7hvy-B5V4ApThaNjF1pjWA>
 <xmx:yni5aSgUOnA1EmEMfYd3GBoHoAQA0wgkGmWv4IXRNxquRhOcq3CU8Q>
 <xmx:yni5acxUTAuQGHI5v5DD5QMeXabeNv8H_NktmQrIsDQElBShyvCwKJVf>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Mar 2026 11:52:41 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Kevin Traynor <ktraynor@redhat.com>
Cc: dev@dpdk.org, stable@dpdk.org, Aman Singh <aman.deep.singh@intel.com>,
 Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>,
 Shani Peretz <shperetz@nvidia.com>
Subject: Re: [PATCH 4/4] app/testpmd: fix fd leak
Date: Tue, 17 Mar 2026 16:52:39 +0100
Message-ID: <2768921.Isy0gbHreE@thomas>
In-Reply-To: <20260312103606.702617-5-ktraynor@redhat.com>
References: <20260312103606.702617-1-ktraynor@redhat.com>
 <20260312103606.702617-5-ktraynor@redhat.com>
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

12/03/2026 11:36, Kevin Traynor:
> In error cases, the fd was not being closed.
> 
> Add label for error case that will close the fd.
> 
> Fixes: 1303b50a9c21 ("app/testpmd: add commands to dump mbuf history")

My bad

> Cc: stable@dpdk.org
> 
> Signed-off-by: Kevin Traynor <ktraynor@redhat.com>

Reviewed-by: Thomas Monjalon <thomas@monjalon.net>


