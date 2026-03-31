Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 524D1FF60F1
	for <dpdk-dev@archiver.kernel.org>; Tue, 31 Mar 2026 09:15:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9B69C4042F;
	Tue, 31 Mar 2026 11:15:03 +0200 (CEST)
Received: from fhigh-a2-smtp.messagingengine.com
 (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
 by mails.dpdk.org (Postfix) with ESMTP id 569634026A
 for <dev@dpdk.org>; Tue, 31 Mar 2026 11:15:01 +0200 (CEST)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfhigh.phl.internal (Postfix) with ESMTP id EF0381400173;
 Tue, 31 Mar 2026 05:15:00 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-04.internal (MEProxy); Tue, 31 Mar 2026 05:15:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1774948500;
 x=1775034900; bh=QtDPWfR8VcijhIb5CQqoU4kVPDq0B2Z84u3YIVNOOo0=; b=
 Sl5Z5hHUQ6+/ThIQsFlStKdJEv6wMvlDEFZ7EXpvyx8sYbBS+3brKY1pNesqIpa+
 PxueMOXh7AUhbESf60Cw5KqqepFMOzyaOHm48lMrssz2ijHo0ZmKkXwsTdj7U9KO
 W0Io8YAeV/Z0Wf/MSQfnadV+yJWFK5NU8SwF2jJv004peZQasF4L5HfZ4fcy+Tds
 meS1PIk11KZjDLFQu/zbbWMV5dBbC6P87C40b0S61vMk4ie7r2vTNCxe6WPQIa5B
 7Y0fXCoCHBCro6EzIjGe+bmvV7I5e+mQK3IX/USRG4KT/bF02SD1y2KDYLeJd70o
 4zKSNdOCnA/59E6Hr/883A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1774948500; x=
 1775034900; bh=QtDPWfR8VcijhIb5CQqoU4kVPDq0B2Z84u3YIVNOOo0=; b=Y
 bCgTjpunsLDSmzvh5tTSoXomhkRozqhIo+1qECV3MXjamxH8Jz4ZrWTLffY8Huko
 Yu/hACnksBqBliXeiQSpAlhKPPBe/x/EgzL5nYAoEpsDbC+A/z4+xAJQLTZX4aD3
 m7XEiVY6lNpy6zCB+c5ot3ZaviPmZjYkev6fqR6neKmr2RG3aSyTfLa+8BtYINOy
 pfuDKKuIAwVQJyzdEwevmwKXGnHjBfZI7bVc1DDkqVKt0k4oWUiJTJHoK/6UMRTC
 NGsIAnb4EGQfhFBkG7zGknxEuFNMRODfgQp4GVEEMuTAf1a78EHVsdVUlKcuq7jL
 kKly2rgcbflWk0cl2WPeA==
X-ME-Sender: <xms:lJDLaaXXYzM1nKywBVt2NfeYJSuWtw9diKl26AV3C_rzVxarlmy4qQ>
 <xme:lJDLaS78BzkfpAqAor9sKfrTI8GH7U0Tcw2BepUIjXaP39yb1TrUx2dPvjyNhiaw5
 yPAeH_ublliIpiLMbjQkGatWAbL9D9FANcedWOsXqXsf1YgWo-Kig>
X-ME-Received: <xmr:lJDLaRK9XuKJgWd0eFkH4XJWTkd3N_ChkSaGTYuC0NuVYmlHuqzQ-uXqHGOy5IugqDZTB9Uj3qezUmFiYiCMYBATCw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefgedugeelucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopedvpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehrrghslhgrnhgusehnvhhiughirgdrtg
 homhdprhgtphhtthhopeguvghvseguphgukhdrohhrgh
X-ME-Proxy: <xmx:lJDLaTJMYEGPnoAiHRMc5V9gfPlsqDUP1ubLHAb6SHe4ic206bfIsA>
 <xmx:lJDLaXVT1iix886LVY_wpkKbHzS8ToRLGKTicxYMtq7m3gctUqTR-A>
 <xmx:lJDLadjv8n8TgiFCZfdLUt1ZJRGnMvULr5aAsaH8aHrYaovJJj-qSg>
 <xmx:lJDLaa-s0hLl6mpgmuWX5f7uf0r1MKeGxeBiL5aINMa-6cS9ozP40w>
 <xmx:lJDLacUGU2jR-8-0_pwrgXoDxibIEzKm_1uU8z2a6PDM-Po-y6RFgWp1>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 31 Mar 2026 05:15:00 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Raslan Darawsheh <rasland@nvidia.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH] doc: add tested platforms with NVIDIA NICs for 26.03
Date: Tue, 31 Mar 2026 11:14:58 +0200
Message-ID: <5113463.Y6S9NjorxK@thomas>
In-Reply-To: <20260330081451.16700-1-rasland@nvidia.com>
References: <20260330081451.16700-1-rasland@nvidia.com>
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

30/03/2026 10:14, Raslan Darawsheh:
> Add tested platforms with NVIDIA NICs to the 26.03 release notes.
> 
> Signed-off-by: Raslan Darawsheh <rasland@nvidia.com>

Applied, thanks.



