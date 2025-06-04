Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4828AC5B543
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Jun 2025 09:27:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0AF9C4042E;
	Wed,  4 Jun 2025 11:27:23 +0200 (CEST)
Received: from fhigh-b6-smtp.messagingengine.com
 (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
 by mails.dpdk.org (Postfix) with ESMTP id DE6B64029D
 for <dev@dpdk.org>; Wed,  4 Jun 2025 11:27:21 +0200 (CEST)
Received: from phl-compute-01.internal (phl-compute-01.phl.internal
 [10.202.2.41])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 283AB2540117;
 Wed,  4 Jun 2025 05:27:21 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Wed, 04 Jun 2025 05:27:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1749029241;
 x=1749115641; bh=e4AzhwKIbGvKsugWvwecSiEV9PjI4mw2bHqlLAQUDfg=; b=
 YTYbdwZKhPS0EK1TxHtkEVREcZHspFDdxAgtaqBUn7lorNUhdqnyGJhKn4zv92OG
 5LOYQo4zazy0GcIPDjLB4jdZNJvgJ7xSKz6QO2X3m16fUXrONp6AiBDFFYt5ZAmT
 rgXRM9jYX6GWiMmJK+TmMtnOYt5YcVX6m6y2dKfZMPiZoltMRrD/odoUP8mE5kJG
 gNH6bUj6eIFsZfxYpWAavv2YA6bisuKkKnjgSaMAObqiLQaYrZULz48r/pfIfVFo
 Zot5dLyQCkNBplv8I/kKsWDf4RAYFIvi5BLq2/kB8MVNK9d57OABdD+Bq0AcbDPZ
 etk+Z5wWRXKvKRwGPVIFdQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1749029241; x=
 1749115641; bh=e4AzhwKIbGvKsugWvwecSiEV9PjI4mw2bHqlLAQUDfg=; b=d
 RUkgOmlL+kzaQMIeq1p/vyL0lNL4uTo//w+WeCsOJwqByM4KAPEkM5GinNp/Szuz
 o2ykzjf46pRz7xOhBmMPUIpk0PgIrkxvqdsvHB5yunty2oXiBmT3yEnDYP7/1QPY
 KqmY/SHl0cqnXTCSsFqHl0Pkk54AMB1hzSCdnXfoHb1bBHaj9Fr/z3Wi0i2Y7nUC
 3YXBPl6vCnXK8uL90Q3STQdSL4wMuqpuLo6EN9HAGftFAVsbxZ5mqUtfCzcDEfC/
 s2wcFpGwjjWPNMeNY5Y/2KGsTYx6YuMJQEO7ccmCZtCpwaVByCFkf8zkIRPKEv/4
 aV+wUl0AtMLTBnD9NL+Yw==
X-ME-Sender: <xms:eBFAaP36wNmFelkPlAldeEkc5iDNJHPesAfg3GFkek585HvhmF35Hg>
 <xme:eBFAaOFH3Ceh9b8PbVzetrt_Te4oPXp2ELRKTmHqtC1nHIOaMf0DIilaQWvfkc8lq
 wCePpy0RCwOnIEEyw>
X-ME-Received: <xmr:eBFAaP4YKzo5vQf58UmHzc9PrjJX4vy7JB1lcCc20uOky7Eee2hqMZAGCcteVpqusbOI5WY-WOb4rZlAv5FD-snz3Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddukeelucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
 rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
 htshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeen
 ucfhrhhomhepvfhhohhmrghsucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrg
 hlohhnrdhnvghtqeenucggtffrrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeek
 ueevjeffjeegtdeggeekgfdvuefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurf
 grrhgrmhepmhgrihhlfhhrohhmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhn
 sggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsthgvph
 hhvghnsehnvghtfihorhhkphhluhhmsggvrhdrohhrghdprhgtphhtthhopeguvghvsegu
 phgukhdrohhrgh
X-ME-Proxy: <xmx:eBFAaE1E2Q_VWkbpiLDlHnpUxGWzxcaFgaRoKWPsr7-jGEZCwJM94g>
 <xmx:eBFAaCEHH-yJ_HCr-VkeVpYE17gD9NGJE0uSQY-biqiPD-pe1R7w9A>
 <xmx:eBFAaF9L8BrUtFBHS5ziGoTGPZrhCfTCu4oew2YcvvqgJtZgiP8-BA>
 <xmx:eBFAaPkCOax_gSuUePBfq5hRt7K2MvPvglrrRnTDNWLs31TZ8S3kQQ>
 <xmx:eRFAaHIVeXFNvoxwIHV05LpfCS1iTQjWncNQeqXdmMDhqPfk54nxkvxM>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Jun 2025 05:27:20 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org
Subject: Re: [PATCH] net/tap: do not force inline or unroll
Date: Wed, 04 Jun 2025 11:27:18 +0200
Message-ID: <5348112.44csPzL39Z@thomas>
In-Reply-To: <20250424160705.19655-1-stephen@networkplumber.org>
References: <20250424160705.19655-1-stephen@networkplumber.org>
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

24/04/2025 18:07, Stephen Hemminger:
> The BPF code in TAP device was using outdated advice on how
> to write BPF programs. Modern BPF verifier has to do less work
> if force inlining and unrolling is not done.

Why do you keep unroll in IPv6 parsing?


