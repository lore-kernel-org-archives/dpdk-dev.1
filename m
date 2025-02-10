Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AA40C02198
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Feb 2025 16:51:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 74F16427A0;
	Mon, 10 Feb 2025 17:51:20 +0100 (CET)
Received: from fout-a7-smtp.messagingengine.com
 (fout-a7-smtp.messagingengine.com [103.168.172.150])
 by mails.dpdk.org (Postfix) with ESMTP id 45E544279E
 for <dev@dpdk.org>; Mon, 10 Feb 2025 17:51:19 +0100 (CET)
Received: from phl-compute-11.internal (phl-compute-11.phl.internal
 [10.202.2.51])
 by mailfout.phl.internal (Postfix) with ESMTP id 2C24C138004D;
 Mon, 10 Feb 2025 11:51:18 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-11.internal (MEProxy); Mon, 10 Feb 2025 11:51:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1739206278;
 x=1739292678; bh=TtPuk0CQbNNp5WYBWN2tQTJB6qoaInDAVkwiABMn8l4=; b=
 UhP5G0hu7yjtVl+N/TIpyewnB56/16pctTd0uF4HhahJ/XsT7Z2ZdceHeZRBWA2Z
 WZEtUQiJ/rdqIu7z8xL1BlTdemhJg0JwCGmqOEVzMucfA3OMdbkDoReR7R5PukuZ
 zvjlMiiNEGRke+YosGueOL2KNr3nn2jMpvHFJND5qXvHWUwWym54oVemuaC9h2bR
 ALlmqEuXJx6tGHWJsmHUdXE9LSCWZpykoxsWvv99jUCXPfe1y29wQeGSrsYyY3s+
 bzL5amobZJQ4Yur3qfX4K96Pm/neVL2vAfW8XH6en/JE6sL0dv8xgHE0jmUb8K+A
 4m9j/PhKDaohNlwzGfnVuQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739206278; x=
 1739292678; bh=TtPuk0CQbNNp5WYBWN2tQTJB6qoaInDAVkwiABMn8l4=; b=I
 Pt8rc2kPPCh2S3NoFauAbv4kvXSZEvu1GTlSnf09CtiKHZ+4+eMxgmufYeMV8TMy
 yYQm1CoAIDQ9bw3i13iZEGE694td1FNhl47sYzuCaNTICNColNbPKVm3NH0ITDs5
 NewqUsQLs3l+qlv8AeQMIstkoNvXADIoFavhTMZuUr4u+th1tMmBYMtNeTEmNuS9
 SQnlQhLD0WKPMzUw/LG5aSQ7kP+AYZrNo13TDooOKl+hBcDMMEaYW5dobysnl4mQ
 WvE6E1o7i7twRVg6ObKnVVFOHdtNxKqwSqW2sJd3SPGj7RlZdXYOKVZQ4ivyVBaY
 amPSRVboqxmw20XAjpe0A==
X-ME-Sender: <xms:hS6qZzY2gKmgx-POTHovPW12nOiCFP-0I2icSrJiqZdq8jCC411rOQ>
 <xme:hS6qZya1CXIDMWzEq_sb5dh_o_bur_gNhi0ZotGS4SNhSpzDfxEOBF1wjLZlMYDpH
 BxUDwghJmiUaXAIbQ>
X-ME-Received: <xmr:hS6qZ1-dSjF40M868I9lk4jPxebK4gTcGPalpqKyV8xiniRvQS_sSzFj0fOrLC8AvrzOhAs3S59fnPwrvEYbwHqDAA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefkeehlecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
 uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
 hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdej
 necuhfhrohhmpefvhhhomhgrshcuofhonhhjrghlohhnuceothhhohhmrghssehmohhnjh
 grlhhonhdrnhgvtheqnecuggftrfgrthhtvghrnhepjeduveehieevuddutdevfffgtdeg
 keeuveejffejgedtgeegkefgvdeugfefkeejnecuvehluhhsthgvrhfuihiivgeptdenuc
 frrghrrghmpehmrghilhhfrhhomhepthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdp
 nhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhtvg
 hphhgvnhesnhgvthifohhrkhhplhhumhgsvghrrdhorhhgpdhrtghpthhtohepuggvvhes
 ughpughkrdhorhhgpdhrtghpthhtohepnhhprhgrthhtvgesihholhdruhhnhhdrvgguuh
 dprhgtphhtthhopehluhgtrgdrvhhiiiiirghrrhhosegrrhhmrdgtohhmpdhrtghpthht
 ohepphgruhhlrdhsiigtiigvphgrnhgvkhesrghrmhdrtghomhdprhgtphhtthhopegumh
 grrhigsehiohhlrdhunhhhrdgvughu
X-ME-Proxy: <xmx:hS6qZ5rHn8CzDplFZu9P-fxkPQDtiYCCu4jk6I735iduC9mTDYuaqQ>
 <xmx:hS6qZ-ocmFvNCMzVgG-7qBThALA8qDdgR0tbF_BziIpLTZbQ_CA82Q>
 <xmx:hS6qZ_QnXb4ZQYyGScdjDLUpbbjsFKlT3SQDM9JRl4EJYreXWsAnRg>
 <xmx:hS6qZ2rMHJ8WCCrOTOB8PunXVh_Axo4vcvULaBrM1oRLzZ7gTwfUMw>
 <xmx:hi6qZ_eU34WRMjZ0qSWE_SxR2RN4DDYoNtn0pzV2-x6b4TP8PRODc6sV>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Feb 2025 11:51:16 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, Nicholas Pratte <npratte@iol.unh.edu>,
 Luca Vizzarro <luca.vizzarro@arm.com>,
 Paul Szczepanek <paul.szczepanek@arm.com>, Dean Marx <dmarx@iol.unh.edu>
Subject: Re: [PATCH] devtools: ignore .gitignore in SPDX check
Date: Mon, 10 Feb 2025 17:51:14 +0100
Message-ID: <3264645.NnENhoQgcM@thomas>
In-Reply-To: <20250207182634.168820-1-stephen@networkplumber.org>
References: <20250207182634.168820-1-stephen@networkplumber.org>
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

07/02/2025 19:26, Stephen Hemminger:
> New .gitignore file in dts was getting marked as error.
> Change to ignore all .gitignore files.

Actually I would prefer we don't create too much .gitignore files.
It is easier to manage if we have all in a single .gitignore.
We have already a line for DTS in the main .gitignore,
so it would be more consistent to move the recent additions
in dts/.gitignore to the root .gitignore.


