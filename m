Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E602C282EC
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Mar 2025 11:00:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4A46A40289;
	Fri, 14 Mar 2025 12:00:30 +0100 (CET)
Received: from fout-b7-smtp.messagingengine.com
 (fout-b7-smtp.messagingengine.com [202.12.124.150])
 by mails.dpdk.org (Postfix) with ESMTP id AB30B400D5
 for <dev@dpdk.org>; Fri, 14 Mar 2025 12:00:28 +0100 (CET)
Received: from phl-compute-09.internal (phl-compute-09.phl.internal
 [10.202.2.49])
 by mailfout.stl.internal (Postfix) with ESMTP id D51F511401EA;
 Fri, 14 Mar 2025 07:00:27 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-09.internal (MEProxy); Fri, 14 Mar 2025 07:00:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1741950027;
 x=1742036427; bh=1ZXuI5KJ2RIl1Ao0nBUUK6dYFee4Rv7UbqR2ZzJg+QQ=; b=
 DCL4rqBfD7D0RjkpD7CxzVsjKCiMrE+ORGY+1dFqwr+iz8FOncO3Zb7uQYFQUduJ
 GT5ETOUq53CrKj/UIA2vmofCXjSzK1TQgFTSKBzwQiDiX+PdVPVoPgz2gJeznJ35
 y2osrukMpNjmz7kJgw/wqChNnWOWJE+loKjDR81yKHr8aT96r4FbRkNmRHOOHycr
 KqQWuqJffcE4A1b+UsOjU1Vzce7MzfXdVUjFHl1mYfhLXo6jZyUCK3Gyxgtx/YJk
 cwoeq0eCbM+KYaYgxOer8yXSQEM/ES8wPDma+hnmIpmn3mTqaYC2xTguHi9AFw94
 v8BCDIELqpVdlaHQ5cM78g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741950027; x=
 1742036427; bh=1ZXuI5KJ2RIl1Ao0nBUUK6dYFee4Rv7UbqR2ZzJg+QQ=; b=I
 +r5ufUoynPjMw3elyztCIAc3zHyqj3Zl4UV78ztKLaGeJVoI/5pHs+zfFnGPT0Qj
 X0uBU0yRCuqpk/s/vMplBP13fPYnyyvq5Ks5ao1EpqZoyQ/iC2Fy+wW/zjCRGVu4
 eBV+Sazs++n1BZ97id26duNmh2ab2q25duYktHKwZXhnz0rkBYEUV8RTF4KW9glD
 8/QBXCwogDiNrvGPYjyq6Dod0POQqRAAPEIYaCtf6RPyRbKZX3XyyIf1f2SX5z8t
 Vadj36k1Z5X/FnOHnzQdPDviA8CQSmeg/1m3v3JnV+vhgbhDgazbRlGB6q9DMVss
 i/p2bHXM+a+qKoAJDLpcg==
X-ME-Sender: <xms:SgzUZ2HoFnWsHUIoYp_0gmnrAtQxGSQCt2NzobrZoN18ae4pWPqI2w>
 <xme:SgzUZ3Uz6g4t6l2LMPrm8S36EDCBKx-VpWoIjPcR8g6J8-mH_RsMxvPL5gas8qyL9
 vbH0YcIqbi6hbaKgA>
X-ME-Received: <xmr:SgzUZwJfL6Gkxu1qQkTnzWUavD1XPGgEexjiqhJYJFNfwzDFqdtRB7XafuP7ggy1MiHBEDFKLmK9THldH9ckn4RYig>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddufedtieehucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
 pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
 gvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddt
 jeenucfhrhhomhepvfhhohhmrghsucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonh
 hjrghlohhnrdhnvghtqeenucggtffrrghtthgvrhhnpeejudevheeiveduuddtveffgfdt
 geekueevjeffjeegtdeggeekgfdvuefgfeekjeenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvght
 pdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsth
 gvphhhvghnsehnvghtfihorhhkphhluhhmsggvrhdrohhrghdprhgtphhtthhopeguvghv
 seguphgukhdrohhrghdprhgtphhtthhopehprghulhdrshiitgiivghprghnvghksegrrh
 hmrdgtohhmpdhrtghpthhtohepphhrohgssgesihholhdruhhnhhdrvgguuhdprhgtphht
 thhopehmrgigihhmvgdrtghoqhhuvghlihhnsehrvgguhhgrthdrtghomh
X-ME-Proxy: <xmx:SgzUZwGsQsek_jtZ043_pUoYcg9Ee27Euz92q2Hz8fjobDfyim6HQw>
 <xmx:SgzUZ8XmG2kwbfaO7X_AurC8GABS2zFe4EffaoMsWerC8W7oWPbmMQ>
 <xmx:SgzUZzPcuOYJXrFw8XyfDPnxJIbKeL9qnTTulDsIlgXuPVvUI5tLPg>
 <xmx:SgzUZz0lLf49tp5kaJ2G87L3b2PHo8HZWY1ZDKkfPsWthqM-UH3k5w>
 <xmx:SwzUZ2ctUyHxgL5wei4s5ZmbmgVA9LUbdphNp1l7BwFEjixaoVAFW4S_>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Mar 2025 07:00:26 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, Paul Szczepanek <paul.szczepanek@arm.com>,
 Patrick Robb <probb@iol.unh.edu>,
 Maxime Coquelin <maxime.coquelin@redhat.com>
Subject: Re: [RFC] git: consolidate .gitignore files
Date: Fri, 14 Mar 2025 12:00:23 +0100
Message-ID: <3828431.VsPgYW4pTa@thomas>
In-Reply-To: <20250210172050.8884-1-stephen@networkplumber.org>
References: <20250207182634.168820-1-stephen@networkplumber.org>
 <20250210172050.8884-1-stephen@networkplumber.org>
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

10/02/2025 18:20, Stephen Hemminger:
> Lets have only one .gitignore at top level.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

Applied with uAPI rules dropped and these explanations added:

"
Some generated DTS files must be ignored.

The Linux uAPI files should not be ignored.
"


