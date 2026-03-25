Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A1B1109C024
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Mar 2026 14:40:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BE67B402CE;
	Wed, 25 Mar 2026 15:40:11 +0100 (CET)
Received: from fout-b7-smtp.messagingengine.com
 (fout-b7-smtp.messagingengine.com [202.12.124.150])
 by mails.dpdk.org (Postfix) with ESMTP id 09BB84028E
 for <dev@dpdk.org>; Wed, 25 Mar 2026 15:40:10 +0100 (CET)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfout.stl.internal (Postfix) with ESMTP id 2521C1D0018E;
 Wed, 25 Mar 2026 10:40:09 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-02.internal (MEProxy); Wed, 25 Mar 2026 10:40:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1774449609;
 x=1774536009; bh=+flJf7s3qnN0zxofpD4Se4QATg8gDpqhInRzv1opQCs=; b=
 cvmTPmPvIhA3ZH92E6MFjPgY0cgehrIb3VHjw+Kt5emT7lv57RtV34oPAC2RCS/c
 KqKrX8OiMCJxweVxm3ZOeS6K2/keltOBIpn1yaitxqi8g8+lBwBgEC4JR+S2aAZT
 EU15Gvn5DvB5PCDf2C7nuC688OFLZpmRyzQMPpTK1MbM75Urm/4WlxuwidEoGmek
 OeetcJgQu+qGTDHILDsJSPqXEpessk0r1tGjJL/BJapgApB/LtYy3VYq3LHn9x4R
 Gfce0S9Z/bwTRjn8gGkpBWeaE/ODEVQpQwIpF0j3D+DV83PhS0jTdVsVCRwm09sc
 rFxWd/zorFBtved8HFuvRg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774449609; x=
 1774536009; bh=+flJf7s3qnN0zxofpD4Se4QATg8gDpqhInRzv1opQCs=; b=x
 JgLW40sithMR8TKZd0aWo00JTTMZwlCelJDNUXu8355tfJcofNO7WnOotTXzquDI
 SE+NC3Sqo67H9r5Q2pO4xft2txyZjUBJV8KPerZDM14dPfarJXWfrel5s9SlXZql
 2tzX/VBDz6OVIqHDr7mVKEoTC97GPgqzRR3zB+qvpJnt5KWj4QYp00wkqcpNqpf8
 2O6eqREEa82v9JzI4y/8JHHHkdNbwng8LUzrs1Z0ybhJtX3fuYf00/1ffh+5CcIw
 1uU/Stw9NgSytcYDvaPLVgLTGNvd4HdZ4Zj3D/k+ot1LVQrfEOHobTBlgHJJxWew
 HoJg55smlgD5Sl47NrLdg==
X-ME-Sender: <xms:yPPDaYmVY5ipMfqcPa_soBWW6FLePen-XyZ7CJK08PsFDNyOlBS3lA>
 <xme:yPPDaR4hWVUrpl5vRpJWUaVeNjJ85KrI7KOgrtap5B-nMw7wNUzOzV7Acv1gKn2Ug
 LZmbu7gqAREAbbXQaG0izKI-PjHTAFVWu-d0cfj2u_qLlJl2U6JKQ>
X-ME-Received: <xmr:yPPDaWhpNmpuntSOeXMstKSjhVLCwAFM9MT2OUxe9T_MrKVVKA7q1ywViF_X9hAXap0ukk8BIeuacxgyxDfVQER0ZA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdegjedvucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthhqredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeegtddtleejjeegffekkeektdejvedtheevtdekiedvueeuvdeiuddv
 leevjeeujeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeekpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehmsgesshhmrghrthhshhgrrhgvshihsh
 htvghmshdrtghomhdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtphhtthho
 pehjvghrihhnjhesmhgrrhhvvghllhdrtghomhdprhgtphhtthhopegsrhhutggvrdhrih
 gthhgrrhgushhonhesihhnthgvlhdrtghomhdprhgtphhtthhopegurghvihgurdhmrghr
 tghhrghnugesrhgvughhrghtrdgtohhmpdhrtghpthhtoheprhhjrghrrhihsehrvgguhh
 grthdrtghomhdprhgtphhtthhopehsthgvphhhvghnsehnvghtfihorhhkphhluhhmsggv
 rhdrohhrghdprhgtphhtthhopehmrghtthhirghsrdhrohhnnhgslhhomhesvghrihgtsh
 hsohhnrdgtohhm
X-ME-Proxy: <xmx:yPPDaWFMJwYGqkAGSz1kL1Jwz-KKQVD_cbn4cBqeOHF5MuEQirKUFA>
 <xmx:yPPDaURpUwglwfRnFMCrgI1uMF1IaQjia8dNazhFCAukRR8rO7YUPA>
 <xmx:yPPDabwHsPPhO6rLzujN9W3omvHaXSt3mIG_dHZUDqTVw3J35F9RGA>
 <xmx:yPPDaYfBdDouy1yt72xrPOvLaWjbd7Aaz0ADDV2NVh1IgZixrZfnCg>
 <xmx:yfPDaQXJyAlVcTdaoPccedVTKvHCAzCWr7b-tMkysCG-Nbh7_ggc3UPa>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Mar 2026 10:40:07 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: dev@dpdk.org, Jerin Jacob <jerinj@marvell.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 David Marchand <david.marchand@redhat.com>, Robin Jarry <rjarry@redhat.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Mattias =?UTF-8?B?UsO2bm5ibG9t?= <mattias.ronnblom@ericsson.com>
Subject: Re: [PATCH] eal: fix cache guard for pedantic compilation
Date: Wed, 25 Mar 2026 15:40:05 +0100
Message-ID: <889384940.0ifERbkFSE@thomas>
In-Reply-To: <20260323081204.748909-1-mb@smartsharesystems.com>
References: <20260323081204.748909-1-mb@smartsharesystems.com>
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

23/03/2026 09:12, Morten Br=C3=B8rup:
> The cache guard macro uses __COUNTER__ to generate unique names.
> However, although most C compilers support __COUNTER__, it is not yet
> part of the C standard, so compilation fails when building in pedantic
> mode.
> The macro was changed to use __LINE__ instead.
>=20
> Fixes: 65f600c0f000 ("eal: add empty cache line macro")
>=20
> Signed-off-by: Morten Br=C3=B8rup <mb@smartsharesystems.com>

Applied, thanks.



