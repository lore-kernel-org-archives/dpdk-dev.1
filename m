Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2628CD20680
	for <dpdk-dev@archiver.kernel.org>; Thu,  4 Dec 2025 13:16:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 366DD4021F;
	Thu,  4 Dec 2025 14:16:22 +0100 (CET)
Received: from fhigh-a6-smtp.messagingengine.com
 (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
 by mails.dpdk.org (Postfix) with ESMTP id B856C40144
 for <dev@dpdk.org>; Thu,  4 Dec 2025 14:16:20 +0100 (CET)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 2C4C814000CF;
 Thu,  4 Dec 2025 08:16:20 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-03.internal (MEProxy); Thu, 04 Dec 2025 08:16:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1764854180;
 x=1764940580; bh=ku0Ib5P7pPkh+EkdBBRoKHH/RwV/djfRXmep9ZNmqcI=; b=
 cHBiInC+NF+nFHoaIae3NkFceh5nEOMPLiSuA30/+aTY1Kpgkd5Xh2x3wVR26iI6
 ll9DQ51fKrfMwwSM6IduUEeaaEqL6xDOFNs4QL7uvpHafs1QfteQqnsV36kN1pK7
 5A5w4Wgtpr/60bsJpwYZ2jdrJgU/5mEUrzVSuUlkkE2J3ql/CZ02+tr7MJNeINdH
 HrATypXqQk0FoQejyUFehwvkB9wP+vvG6qT6M25iKXbwjYVGQsn6yZDlSAuR18vP
 jyaEm/KPDW+Yln1eny5iOZRN1HXlaaPK0P2zvKqx3GZDeqzH6Jfz8dDiYSjKm0Ik
 rAD8k2Pq8+Hf8zG0BaCPGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1764854180; x=
 1764940580; bh=ku0Ib5P7pPkh+EkdBBRoKHH/RwV/djfRXmep9ZNmqcI=; b=L
 tx5uPCtdNrLPmCbby+4wTiXo4aYeXrkhCRNZ8LrQ9B9WTT88/Yz8yZacUaOoEKfQ
 F+NlG8ajKLa9etj6EQLGifx3JA5yx7eII4jAxs6ZEYCqRmeT5cTBeTfpE/kWh2CY
 JJbGByIRkeWG5mIngXyvbW+hN46zbCZxhEh3wYGMzludAd0cTeHWqzXCNC6knPLg
 +U6jWVMHbmfE1rA/rGKRo2n7v+oujjxwqJJ/IlwoLj6028niSGIsaoV+oJyDBOv3
 0WUKk3YJ5PxmFWk0b48RktP3HTRByriULfKv0XpPbloBthrWyrG5R102CaX8rw8r
 t60dZ0RH+EdBNlpQg0FKQ==
X-ME-Sender: <xms:o4kxaan7JU2Fipe0lh-oitVFyUX-uoCGaMOpf5eF1W9TgSs2rrLURQ>
 <xme:o4kxaWLoqST3McYiGXgtMDK_K_z16EEIuH5iEGD--R-DeJakSIY-4wfqfKJg38BCx
 9vOJNsSW2Zxa9498tyrciMMO67VY_6jT6nrrl1DL9rWPJAv_aMb>
X-ME-Received: <xmr:o4kxaXywDFVlbpyzWBJxoNA-07mveFazPmwmexxNuzwULUhypLRJCToWyTdaYGI8FbqMDdST_54ByTHQL0g2GlqW0w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdehieejucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
 lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
 ephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghsucfo
 ohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtffrrg
 htthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdvuefg
 feekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
 hthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeefpdhmohgu
 vgepshhmthhpohhuthdprhgtphhtthhopegurghvihgurdhmrghrtghhrghnugesrhgvug
 hhrghtrdgtohhmpdhrtghpthhtoheprggtohhnohhlvgesrhgvughhrghtrdgtohhmpdhr
 tghpthhtohepuggvvhesughpughkrdhorhhg
X-ME-Proxy: <xmx:o4kxaWuEGIk2n0w-tz23rGH--lRWFW4-5uly_VYCS6BLLELJDsj-oA>
 <xmx:o4kxaeuLind9YcLZQVrCvF7_WA8a_QvVeqz4N0RSygfb9geJo-BOnQ>
 <xmx:o4kxabM4IQ_8Li0-FHOWFx7oAp-94cGccUCb28ZbAHn3vZBu7xvDgg>
 <xmx:o4kxac1xezPu_7diI7IqmuK_38ICr3G6wBh2V0aAv1RvsZnihIwd4w>
 <xmx:pIkxaT-s4IRM1UC-3U4AN2mhg2hbMlZocsxDMXjYQUDlWcBIRPpTsttF>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Dec 2025 08:16:19 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: David Marchand <david.marchand@redhat.com>
Cc: Aaron Conole <aconole@redhat.com>, dev@dpdk.org
Subject: Re: [PATCH] version: 26.03-rc0
Date: Thu, 04 Dec 2025 14:16:17 +0100
Message-ID: <6247294.lOV4Wx5bFT@thomas>
In-Reply-To: <f7tqztddntu.fsf@redhat.com>
References: <20251202130819.3805720-1-david.marchand@redhat.com>
 <f7tqztddntu.fsf@redhat.com>
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

02/12/2025 14:18, Aaron Conole:
> David Marchand <david.marchand@redhat.com> writes:
> 
> > Start a new release cycle with empty release notes.
> > Bump version and ABI minor.
> >
> > Signed-off-by: David Marchand <david.marchand@redhat.com>
> 
> Acked-by: Aaron Conole <aconole@redhat.com>

Acked-by: Thomas Monjalon <thomas@monjalon.net>


