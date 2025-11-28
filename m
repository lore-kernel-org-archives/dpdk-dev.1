Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9176BD116E2
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Nov 2025 10:56:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A8DA44013F;
	Fri, 28 Nov 2025 11:56:04 +0100 (CET)
Received: from fout-a3-smtp.messagingengine.com
 (fout-a3-smtp.messagingengine.com [103.168.172.146])
 by mails.dpdk.org (Postfix) with ESMTP id D954B400EF
 for <dev@dpdk.org>; Fri, 28 Nov 2025 11:56:02 +0100 (CET)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfout.phl.internal (Postfix) with ESMTP id 4A0B0EC0178;
 Fri, 28 Nov 2025 05:56:02 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-02.internal (MEProxy); Fri, 28 Nov 2025 05:56:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1764327362;
 x=1764413762; bh=/D64RKSKCfoKA0Y0bM0rugtjrcFDcgwf/PizgCc2TuY=; b=
 OyvzGO6DMGpV3tyUFgR8P+KbRwBPZcv96Xbf8HkGEkllGVGK9BHS/GY+KTmhDPb8
 c0czrWVNv/79yLSCGjXMsVI+wtR7MUxkWi6bnujGNGo8Y1RpeWT6O30fhT4eNGfU
 DmvRqeoqXLuZ3CIsmyoeG5Cp7lGnvCG8oq+X5ZqiA1SN9PGILpxFk4yKkEH14jbQ
 UsU2nCo0eD9hP0gGCUEUC7058X4nltVW4LtrIIzHyfGK65kOus5BUuMXdczWbYlI
 ynydtxdWI/GI0d1Q4wYTRjcsS2B45aRTbu6IJiHpiPTZXN7vLsiSgk6mQ9eY/Fic
 vmYZMatPcjb/22XRTz2DBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1764327362; x=
 1764413762; bh=/D64RKSKCfoKA0Y0bM0rugtjrcFDcgwf/PizgCc2TuY=; b=d
 4YYNqfwyvVKP1seYoxYksWRUX52kRiCbd948u5Vjepz6FgWUzOPN1WNU8iMRy9sV
 hJB2y4PwVPayBUSMifF14Wvqqeqmrq1foT8DabzeWXe0J+xuBtNUn0V/7GPYa+59
 yKH6iPQX4InIYGrZ+yNNlVG6HQ+4wD2wtC+2XIyD1dANndtiPrKH4HknGbZIoM8D
 GNjCJB2UBVCRUtojqys6q3wYXekuqSNVlkOgW3R4k2dKE0rbJs4UWrmGEh4o+5VW
 p4NuGgqUlHQw3j990G1KeBFw5r8g6JER0x1nnYmRz6zeIlKbuPUn9SMjn065ZYBN
 ci3T0odVzwiteaY/1B/Dw==
X-ME-Sender: <xms:wX8paUwqH-T61OKdkjL3iTn482AeCgtYIVilNzvdHksSje7Qh9UmIQ>
 <xme:wX8paYbL5hEYbEmvY1C3iQ3J6RnXBiBtzHPNhI5S3yrK9fAYxEMQFaHc5kQ3X_7UG
 1PkxcY93x6Nn9q1nVspu8cFyEkMEQU2kiHMIVsgJdea4kc3U_xgwLg>
X-ME-Received: <xmr:wX8paeQVejvaX8z2AjFwcx9xCg0bwQnzkDsJ3IYGrKBC3QY0NmyAmi60mftJtwDefgyh54VUPMCNxoA_zY3VliIMzQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvgeeljedtucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeegpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopegsrhhutggvrdhrihgthhgrrhgushhonh
 esihhnthgvlhdrtghomhdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtphht
 thhopehjrggtohgsrdgvrdhkvghllhgvrhesihhnthgvlhdrtghomhdprhgtphhtthhope
 hsohhumhihrgguvggvphdrhhhorhgvsehinhhtvghlrdgtohhm
X-ME-Proxy: <xmx:wX8paazqBEwncI2ax-SeGIIxUUOyWKMjrxoVtrJzQrY-2SlCn0LjvQ>
 <xmx:wX8paQ2BaLXaQxxlG2WWzLOaJVBduPZmwYjwPdySymBMahRKBw_L1A>
 <xmx:wX8paY6ujDixUlkT_A41qBDfZfObW6zo-lD3ODWvGKkSer-o92_HRQ>
 <xmx:wX8paTUc4zSROagWSJtiXoYEO8wbGpCqHaf3Xkrslox08p93JcIhTA>
 <xmx:wn8paag9Kj-1h31MyrpY9ah2v209dRaSDJIlYWB5EiAimOukV_tr6KZu>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Nov 2025 05:56:01 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: "Richardson, Bruce" <bruce.richardson@intel.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>,
 "Keller, Jacob E" <jacob.e.keller@intel.com>,
 "Hore, Soumyadeep" <soumyadeep.hore@intel.com>
Subject: Re: [PATCH] Revert "net/iavf: fix check for PF Rx timestamp support"
Date: Fri, 28 Nov 2025 11:55:59 +0100
Message-ID: <3833052.e9J7NaK4W3@thomas>
In-Reply-To: <CY8PR11MB7747612256CC34D33443EEABF9DFA@CY8PR11MB7747.namprd11.prod.outlook.com>
References: <20251126165943.1536164-1-bruce.richardson@intel.com>
 <CY8PR11MB7747612256CC34D33443EEABF9DFA@CY8PR11MB7747.namprd11.prod.outlook.com>
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

27/11/2025 10:25, Hore, Soumyadeep:
> This reverts commit d21c2fe6e5a1ef1e7cc9490f54f359db1cfd5283.
> While fixing an issue with enabling Rx timestamping on PFs which don't report Rx timestamping, the offending commit broke PFs which do support Rx timestamping.
> 
> Fixes: d21c2fe6e5a1 ("net/iavf: fix check for PF Rx timestamp support")
> 
> Suggested-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> 
> Acked-by: Soumyadeep Hore <soumyadeep.hore@intel.com>

Applied, thanks.


