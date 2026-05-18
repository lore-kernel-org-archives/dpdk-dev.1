Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3926CD4F3C
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 May 2026 10:30:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A811B402D9;
	Mon, 18 May 2026 12:30:48 +0200 (CEST)
Received: from fhigh-b5-smtp.messagingengine.com
 (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
 by mails.dpdk.org (Postfix) with ESMTP id A6B78402B8
 for <dev@dpdk.org>; Mon, 18 May 2026 12:30:47 +0200 (CEST)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfhigh.stl.internal (Postfix) with ESMTP id BB5BB7A010F;
 Mon, 18 May 2026 06:30:46 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-01.internal (MEProxy); Mon, 18 May 2026 06:30:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1779100246;
 x=1779186646; bh=4WVEy7sjYK8Z5ordO4hKllqRTl+Oind8R0jyJ2WjImY=; b=
 syJzTs0NLQUwBSF+I6/3G+DGqSsEi1PSG9ER1qwsuPduTyMn26lwgudJBudG+ce7
 nY/cihp+WulAODgALn9qMfVEdnDFQxuJG+bZpAgJhE1VeUjOxvjDQQlGo/a1Y0wR
 PG0xFzSY9ffFimfFcOvIhO9+43AiCCMIHdIi5KhiUZfg3rw6uV08S7himGvSa1uQ
 ZE3OxJyJQyqXmeAr6xfitcD1AJM2NW0g5UJXlKt0qd08RBZZkr0j3F3i8dQRfG3h
 yWxdIBR/IwBRtWHw/lEmqQptBBRyWJ820fzfDvuw/Kh4QuwqvRi3mrKMKQrJh1Kc
 WDrf6KxUzrfTIXEcN/lmfw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779100246; x=
 1779186646; bh=4WVEy7sjYK8Z5ordO4hKllqRTl+Oind8R0jyJ2WjImY=; b=v
 dtQdKonz5j4VvlmKwO5Dp6WsD52XyBIml1Fn+yEnQk3vEOqGs5BZAHsH93XwojwB
 iVSNNYAC6vSFuh86/0T2SmOqJjOa/OkFLJTj4wKJz258f+aB2TIHEMnjdCWWEGs8
 Ojl01YeKyndBycIlYs0K+M+KW1DYs19wqARbfBTDZwzKBr0UdCpEcVJpTkXtwgi5
 SknYKF5TLC+Pd64TwDtOcJDXibkkh1vjIP2fHIZ/QBYCFXghG/yZLGJ29RJmRbQ1
 FXsSObudeyigaw8vdzG7IJuoR1XXit8NXTdyUJdQf6PjRPGODevOR6RUh/xw026O
 dypE0Nn6t5fLrDBjSGM1Q==
X-ME-Sender: <xms:VuoKas5A5ALhiudY_aEnR6noa0Z5f0mTMBtJmVRayic_Tvfpj4tJig>
 <xme:VuoKaqOY-3A2REYXNPBhNLaVKtXJXcQZ-a0KdqhB4XGrEaHcVHiNd-sEPFRg9EfdQ
 OvQPJ-tylTKIJrIFcqAvhu8gT78alxNl3VHUhCt0mAs4D_Wx3cPqg>
X-ME-Received: <xmr:VuoKauN4hUVDAqgI-1naK9EOHjCgL_ze7vwXzSyCiW-lvC-faWQ7nnXfVxZHlDfVuCn9cT4GT1McMj-NpdR-AJV3DQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddufeekieefucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopedvpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopegsrhhutggvrdhrihgthhgrrhgushhonh
 esihhnthgvlhdrtghomhdprhgtphhtthhopeguvghvseguphgukhdrohhrgh
X-ME-Proxy: <xmx:VuoKai8KSKi1bDIoTSBrHXNyfNJiohX9vhJi4cfh0hx1aLFRhirGxg>
 <xmx:VuoKai6Gb7lflus1NgtzyVueRl5EOA9wC8vb171TUJgrWVSaX42oxw>
 <xmx:VuoKap2-S-WZzwIx8zwh9V1nxf6kck3nSg5G4vejrGxWWfQq4hvHmA>
 <xmx:VuoKapC0A3e4tVEO2AdLjL9qdF2g2SJqM68TvedRkQ7KU4QdlRpwyQ>
 <xmx:VuoKasgKe1Hf6bR07KFfUSplGEPlxIVNbotVb4ZzJabGO0wBzVCnUEB1>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 May 2026 06:30:45 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH 0/6] add hardening checks to cmdline and cfgfile libs
Date: Mon, 18 May 2026 12:30:43 +0200
Message-ID: <ommzVyU8QbmUSqpwi_tg5w@monjalon.net>
In-Reply-To: <20260507145950.197753-1-bruce.richardson@intel.com>
References: <20260507145950.197753-1-bruce.richardson@intel.com>
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

07/05/2026 16:59, Bruce Richardson:
> Using AI tools to review the cmdline and cfgfile libraries throws up a
> couple of places in the libraries where additional hardening could help
> prevent future issues. A number of these are purely defensive, e.g.
> adding NULL checks to input parameters where a well-behaved app should
> never call the function with a NULL value, and so those are not
> explicitly marked for backport.
> 
> Bruce Richardson (6):
>   cfgfile: add null checks to public APIs
>   cfgfile: prevent issues with overflow on resize
>   cmdline: harden parser result buffer handling
>   cmdline: add explicit help function for bool type
>   cmdline: guard zero-size destination buffers
>   cmdline: add null checks for invalid input

Applied, thanks.



