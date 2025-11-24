Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2102CFD369
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Nov 2025 23:38:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7EFDA402D2;
	Tue, 25 Nov 2025 00:38:41 +0100 (CET)
Received: from fout-b7-smtp.messagingengine.com
 (fout-b7-smtp.messagingengine.com [202.12.124.150])
 by mails.dpdk.org (Postfix) with ESMTP id 01C20402A1;
 Tue, 25 Nov 2025 00:38:39 +0100 (CET)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfout.stl.internal (Postfix) with ESMTP id 0EE7C1D001B8;
 Mon, 24 Nov 2025 18:38:39 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-05.internal (MEProxy); Mon, 24 Nov 2025 18:38:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1764027518;
 x=1764113918; bh=5x/P4KkVDBPMalRSvbb+wFldfqHwUwjU8+cxiCkkEI8=; b=
 adH+MrADo5WUD99xf1RvKojL9so88E5iilbCpSTjQiQuHIioJZTSo9a9eCYxD9L9
 PIaLHXlDTqpIHzQXUKDDIAzxnrCFTRxxLJ1H+Rs3GdzmrKbKYXh5w8FuK45jjkyS
 GfvbWmQ7fHczR7jNA3qel0VuMilnyvWxLetSvsp0r9mMHti7p+ncepgoXdwBCpcn
 aGjY1GFvjWL4Si7N1wyycbNxSptvg9LEhkJHW9WLneNiaj12ixLbKlKmnqCaa/r7
 iBefzA7HFmjT3Wnx+aQmQDtMlEJSy1bgtRsI+9N0rlHwTysa/fS42QmCiJ84TIrB
 5Uy6rojNna5inIwWZPBmLA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1764027518; x=
 1764113918; bh=5x/P4KkVDBPMalRSvbb+wFldfqHwUwjU8+cxiCkkEI8=; b=z
 16D41GDjEA/FJLp+PaGUkYzlo11QrGIiW4/YnNu3kGrHhGRTZvAybxhYIcLcuj2e
 Kc6BprV9ksoMLvdFRjndd+KLB/b5G51EPYbqpMKiEyMTvj9KwwnN+h+P0KhJxJ71
 62iYNNiK8z3ZZr+SDMlqFiVIzXYegd7lhts0OBueFCQOSzhFlAmqoZkNAMx+sRUd
 ERg3em+UlOjcUkOKSX5gRHABuHGjuB6GMHlZ8Lw+r7okuBuuLI8+G/DkdwRAJZMZ
 ACyhVLG1wHGic9cXC1JnisQcEvLuACVs7UwRic1jBJCQs0CslwxjTzLUu+uf9iT6
 zduKheJfnZgECjydL1uHA==
X-ME-Sender: <xms:fuwkadr-b1zsN0VuHq_78bdy0DhohKhW6uPXnl9M2sfxEoHSAupM_w>
 <xme:fuwkaT9KN5XCSXbcWrGERlXzTG94S3b0HxozSp6R9wWUyAWrJoaKQVeT49itLIzZ9
 I1WQnI4EF-NKrzBIa57Phb47lUCIW7Lyet1oW6R_Txb3FLO7AQ>
X-ME-Received: <xmr:fuwkaZXp5yQxRWbBN6eLgO0LWPZu2x-eRH6-Odz6CxOLiWNhmGdGfXi2A2XoVwKjq5P51ZExM5peyIpBDaXpCTDuSw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfeelleegucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeefpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopegrnhgurhgvfidrsghohigvrhesrghmug
 drtghomhdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtphhtthhopehsthgr
 sghlvgesughpughkrdhorhhg
X-ME-Proxy: <xmx:fuwkaRBKyE-r8Nf3lqPAFozeA3GjKMY5Vldo59eslbG73caB0k6xEw>
 <xmx:fuwkaSzxD0a-krWHjJkZk1I4hYC-2cp_crz26MCdVSkSHoFH7NNlZQ>
 <xmx:fuwkaWC70Yz9KSsENbmJmn1oyVB4p1-TtMgX8XBtiKxOIAKODOhIPA>
 <xmx:fuwkaXaDhsooTS6Q7-OtPNabBx2b5qHmjqPadeew8Uhzi8mGxNUzsA>
 <xmx:fuwkabpLc0VdF0NBMR7dncmrpWCO_72F82qqQK8Za8oa31aRruyEul2t>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Nov 2025 18:38:37 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Andrew Boyer <andrew.boyer@amd.com>
Cc: dev@dpdk.org, stable@dpdk.org
Subject: Re: [PATCH] doc: update supported ionic devices
Date: Tue, 25 Nov 2025 00:38:36 +0100
Message-ID: <4270016.AJdgDx1Vlc@thomas>
In-Reply-To: <20251120183936.8699-1-andrew.boyer@amd.com>
References: <20251120183936.8699-1-andrew.boyer@amd.com>
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

20/11/2025 19:39, Andrew Boyer:
> The Pollara 400 AI NIC is supported without any PMD changes.
> Add a link to the product brief.
> 
> CC: stable@dpdk.org
> Signed-off-by: Andrew Boyer <andrew.boyer@amd.com>

Applied, thanks.


