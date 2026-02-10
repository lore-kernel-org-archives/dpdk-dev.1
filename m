Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2DF4EB26F1
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Feb 2026 17:22:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0F5EB40658;
	Tue, 10 Feb 2026 18:22:01 +0100 (CET)
Received: from fhigh-b7-smtp.messagingengine.com
 (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
 by mails.dpdk.org (Postfix) with ESMTP id 082894064A;
 Tue, 10 Feb 2026 18:21:59 +0100 (CET)
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 817587A012F;
 Tue, 10 Feb 2026 12:21:57 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-12.internal (MEProxy); Tue, 10 Feb 2026 12:21:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1770744117;
 x=1770830517; bh=IDIz7kzeuprjEiC454rizOYbGOgixjkbVrG+Na7df7k=; b=
 QfvUJFIusghN42qI8z14GbOMPU8rqe8e+zBiwUvL7gifw8TA3gxsphhyxJZ/zbxl
 WlHcGrgwnKNy+baSO1EmYNg346+Bhs6RZepoYUx50gGkFhy30TmXYiNLjO1e5uqy
 Gp3um9kEFBERYpjo+Yks+60txUljs/SEODjoFUcsUVtDaOW509XALy2SiF1k5v+q
 AEWkB3eHGB/OdOrqsqUCGf2kp3lC3SK7z8kKO9PXfKwk3SpHwGke7Cl2rZuI8dRA
 FT1HJ3+ynQLy269EqNXk2N8L2mtYUIpUi5f+JtVaz9UooBdz5VH2W4s9FL28eU0D
 Va8odIlRdFZBVW0lcqxPHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770744117; x=
 1770830517; bh=IDIz7kzeuprjEiC454rizOYbGOgixjkbVrG+Na7df7k=; b=D
 IbSW8KbLAKBLtrBmJO8x6+7FzRbtcwmI6IUAaVDvpTQijoqbs7AUHzsZYHPu+uCS
 TpyqjK8bmsgxlu2oSkCciRcrc5q8VO0J3qjrqmw8JZZoWe326e2ax+Fmu8KN9z4L
 yLWUSgJbQ8xKt7ZJlQ7LSVHbPx8+dPNwkLw+Ddcljk8c7hRxF8/L7h0z4fkNfzHH
 bRbvEHBG20qZ+cWUbxwAYHTfcPQCpaIVVxY0BEV/9XU5/UfZH7LTPGyMQov+Ty+E
 MyW5EiQ5LDbjTWK3ygLMHu5svKvbsq1DsC/uu6ThQoqnNht/yXCfBUcQ1z+B0TQI
 m1/6D9OqWzCoIAKvDiLvg==
X-ME-Sender: <xms:L2mLafs_QU4sG6DUvSNLLT_7Ly-EnUra1yv-oNULIy0sY6XvwoWMFw>
 <xme:L2mLab4NPuXIgiWQSeBR8G0wVi-BuaBLrng_2JZDRTyVEmYaxPIHhlGzJH6Bzxb7Q
 X1L43T31vPS-3TkBJgLROPPDG4a2kH95loVoNk_tRw1bgtyFuyh1w>
X-ME-Received: <xmr:L2mLaWSh11JOSj0g78FSMOfmxOk4QjY1SPLXtPqcxul1rYaB0WH7m7GrfuNZ3y0c5vanSWzttCSqyuaYXF3q271HRA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtddtvdeiucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthhqredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeegtddtleejjeegffekkeektdejvedtheevtdekiedvueeuvdeiuddv
 leevjeeujeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeehpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehmsgesshhmrghrthhshhgrrhgvshihsh
 htvghmshdrtghomhdprhgtphhtthhopehsthgvphhhvghnsehnvghtfihorhhkphhluhhm
 sggvrhdrohhrghdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtphhtthhope
 hsthgrsghlvgesughpughkrdhorhhgpdhrtghpthhtohepkhhonhhsthgrnhhtihhnrdgr
 nhgrnhihvghvsehhuhgrfigvihdrtghomh
X-ME-Proxy: <xmx:L2mLaSp2LJxX3Ca-mqbPWJuXyBs30zHMFJjvr-v8wtCkijmWcQMNiQ>
 <xmx:L2mLacKe4m4KV1e0lpLWruLQlPs70Cq8pk1j9lsr4iOGR1lB1b-WRA>
 <xmx:L2mLadoOme0GuyYeVldLvl0R8EKKEkBYoLfFhtGfWc9KadFTGIszgw>
 <xmx:L2mLaczrkJ94sbeYXq0i9ibQg0yjLJJWYOm36X5atsI-ldUzscxnDA>
 <xmx:NWmLaWELABUGaepyX464n2IIo4lS68ingFaQZhsej37qAK5ICH0gwp-y>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Feb 2026 12:21:50 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>, dev@dpdk.org,
 stable@dpdk.org, Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: Re: [PATCH v3] mbuf: fix packet copy
Date: Tue, 10 Feb 2026 18:21:48 +0100
Message-ID: <9659693.EvYhyI6sBW@thomas>
In-Reply-To: <20260120072414.465240-1-mb@smartsharesystems.com>
References: <20251119120403.907511-1-mb@smartsharesystems.com>
 <20260120072414.465240-1-mb@smartsharesystems.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
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

20/01/2026 08:24, Morten Br=C3=B8rup:
> mbuf: fix packet copy
>=20
> Requests for copying the at the end of a packet incorrectly returned NULL,
> as if copying past the end of a packet.
>=20
> When allocating the mbuf for the copy from a mempool using pinned external
> buffers, the external flag in this mbuf was not preserved.
>=20
> Fixes: c3a90c381daa ("mbuf: add a copy routine")
>=20
> Signed-off-by: Morten Br=C3=B8rup <mb@smartsharesystems.com>
> Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>

Applied, thanks.



