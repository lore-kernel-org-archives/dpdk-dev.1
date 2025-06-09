Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2AB7C61CE8
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Jun 2025 21:44:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C471C40E34;
	Mon,  9 Jun 2025 23:44:11 +0200 (CEST)
Received: from fhigh-a4-smtp.messagingengine.com
 (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
 by mails.dpdk.org (Postfix) with ESMTP id B1FA2402C8
 for <dev@dpdk.org>; Mon,  9 Jun 2025 23:44:09 +0200 (CEST)
Received: from phl-compute-05.internal (phl-compute-05.phl.internal
 [10.202.2.45])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 2DA0111402E2;
 Mon,  9 Jun 2025 17:44:09 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-05.internal (MEProxy); Mon, 09 Jun 2025 17:44:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1749505449;
 x=1749591849; bh=M3BlN76xgFSzmctDFzA3v8CFWGpCOoq5WptZW1tCYU4=; b=
 oh5179Xz20CixKWI6a932cIhkXjG51ZXDywBku9+A3a3cR+pWz+gXK4reF26WXDX
 qTEearcT2lS4SxlBJNgYcOyVbxctikwzgPwQS4nYDzrkh1ZQgJbgS/GbkSlXvhUx
 znJjwXXZ+MbHp+tosLJg+4qOK2EKWSnA6ISd2sy8rlQvb1ka7vi+wC1UaqiiL2Eg
 t+Oow/0N+uqXuOWJ0ssnkEA8R7ffCPLYCOhRA5I7Fzih6U1Y6oSkBCBwGlh+Jm95
 jGVs4jy0E2Iq7FhhzgKWugwNr7UlXi/BnCnYxul1HwWOqqhll0AXVk7MxBDyJ9v2
 wuR9nJhoni602Xe/jEOmMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1749505449; x=
 1749591849; bh=M3BlN76xgFSzmctDFzA3v8CFWGpCOoq5WptZW1tCYU4=; b=h
 L563VR8Zd1H8EVEGJiMHbHqyZ2l12MgSqmqwz7KEKGdbiRcKfJpgKd4gt/shkIUV
 yxi0F2QTKgbzuxhy4wUGy56WGrCJ6R5Rzd2SLP9FeQkAa64Qe7qOgvNaBu9uhiya
 Zn1COBbFoT6FW0QOgAd4eLhako4QZOYSgokDavrd72aDCxG0NuqvBeOGHXs0lKVS
 1XGLGCSg1ayrmb7qAzJYackoozR7v97CvSKAG0Nb2A5rGjXOHmDKi2w/Va6bxVp0
 ZOT2j5geqxGY4DrQstN2hHwZ2DAOlGW1yx5sqsdH8c5Xyc97zWHq9hU+HxuTaHuu
 VXoswMq3YAlOqQ0lA5Neg==
X-ME-Sender: <xms:qFVHaKTQPMQ7PUk7rwT6OlM30wv4AV1TFhNznk4REHI51NIG2AY6tQ>
 <xme:qFVHaPxJfgjQi5YUdZ_NK3LATorA5ELwwb44Ctg7eaIcqCXyKkHABUbAKoZSa8pGH
 P2G7XCuEIplaW7MEQ>
X-ME-Received: <xmr:qFVHaH1A7scdJjDYhw1WGTub_6miC5IAYpldQW-xNOizQVbOGD6iVzgtJ3HoQWXEpC22OQjEO_V1L0AVosHScZrNnQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdelkeehucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
 rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
 htshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeen
 ucfhrhhomhepvfhhohhmrghsucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrg
 hlohhnrdhnvghtqeenucggtffrrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeek
 ueevjeffjeegtdeggeekgfdvuefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurf
 grrhgrmhepmhgrihhlfhhrohhmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhn
 sggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrnhgrth
 holhihrdgsuhhrrghkohhvsehinhhtvghlrdgtohhmpdhrtghpthhtohepuggvvhesughp
 ughkrdhorhhg
X-ME-Proxy: <xmx:qFVHaGAvgUw3TPFYxHJLIoKZOgWAZY1cXAwsdQWW_kmEx1f8YBJChA>
 <xmx:qFVHaDgwVcyF3OTdfHZ2AjQDnO60llFJ7wgh7AE8npDDg08uijlpAA>
 <xmx:qFVHaCp0Hg4j6iubJJMdN9qdqkeHmAFs1uEQu1R7Q0JgkU1D6YQoSg>
 <xmx:qFVHaGjDqlTk2DzJSAauoiADca-FcekuXsomifZI-91gLI7CT1WMwQ>
 <xmx:qVVHaCTQYuJuzdob65RjgIHbpWARNtcsFxNwEr6R58qL_OSmqSeOtOk1>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Jun 2025 17:44:08 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Anatoly Burakov <anatoly.burakov@intel.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v1 0/4] Adjust wording for NUMA vs. socket ID in DPDK
Date: Mon, 09 Jun 2025 23:44:06 +0200
Message-ID: <4737527.KRxA6XjA2N@thomas>
In-Reply-To: <cover.1732626792.git.anatoly.burakov@intel.com>
References: <cover.1732626792.git.anatoly.burakov@intel.com>
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

26/11/2024 14:14, Anatoly Burakov:
> While initially, DPDK has used the term "socket ID" to refer to physical package
> ID, the last time DPDK read "physical_package_id" for socket ID was ~9 years
> ago, so it's been a while since we've actually switched over to using the term
> "socket" to mean "NUMA node".
> 
> This wasn't a problem before, as most systems had one NUMA node per physical
> socket. However, in the last few years, more and more systems have multiple NUMA
> nodes per physical CPU socket. Since DPDK used NUMA nodes already, the
> transition was pretty seamless, however now we're faced with a situation when
> most of our documentation still uses outdated terms, and our API is ripe with
> references to "sockets" when in actuality we mean "NUMA nodes". This could be a
> source of confusion.
> 
> While completely renaming all of our API's would be a huge effort, will take a
> long time and arguably wouldn't even be worth the API breakages (given that this
> mismatch between terminology and reality is implicitly understood by most people
> working on DPDK, and so this isn't so much of a problem in practice), we can do
> some tweaks around the edges and at least document this unfortunate reality.
> 
> This patchset suggests the following changes:
> 
> - Update rte_socket/rte_lcore documentation to refer to NUMA nodes rather than
> sockets
> - Rename internal structures' fields to better reflect this intention
> - Rename --socket-mem/--socket-limit flags to refer to NUMA rather than sockets
> 
> The documentation is updated to refer to new EAL flags, but is otherwise left
> untouched, and instead the entry in "glossary" is amended to indicate that when
> DPDK documentation refers to "sockets", it actually means "NUMA ID's". As next
> steps, we could rename all API parameters to refer to NUMA ID rather than socket
> ID - this would not break neither API nor ABI, and instead would be a
> documentation change in practice.

I agree with this direction.
Less confusion is always better.
Please continue.

Nobody complained about this path in 6 months,
so it is applied with removal of some old useless messages in docs:
	EAL: Detected lcore 0 on socket 0

Thanks.



