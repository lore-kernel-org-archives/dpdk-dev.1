Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBC88C282EC
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Mar 2025 15:28:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2210F402BB;
	Fri, 14 Mar 2025 16:28:49 +0100 (CET)
Received: from fhigh-a2-smtp.messagingengine.com
 (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
 by mails.dpdk.org (Postfix) with ESMTP id 4272D4029E
 for <dev@dpdk.org>; Fri, 14 Mar 2025 16:28:47 +0100 (CET)
Received: from phl-compute-03.internal (phl-compute-03.phl.internal
 [10.202.2.43])
 by mailfhigh.phl.internal (Postfix) with ESMTP id D39ED1140186;
 Fri, 14 Mar 2025 11:28:46 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-03.internal (MEProxy); Fri, 14 Mar 2025 11:28:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1741966126;
 x=1742052526; bh=bpL6PRqgKlp6Z5FgyNk5KUv96ZJsZ3UjkTfWTQQkUMU=; b=
 oWmRjDFBOxblWC2egkmmPUTHVxwNE27abBNzPjk/60MvNtGt5rl1GZ43a/gQLnNM
 hxMdUuLF6xL6bP5DDzNwLRuKp1gB5nHgKWLfb7ZW89IntJ+IxYNE35r3KRs6MK4f
 oTisQHCbzS9t3ZxgHe07lPqQLA3aNWAUWjPg1SWtrlZXCxQ9fFsRLQb9RvtY5C9k
 EeAwmyo6ebui+Je+/aG/7bAbk6DkTJYfJTKdY2m5mf88+ZyLRhxF8wZS/EkHd/Xq
 /6Kdbj+bP/ofVEPseRVLkiIJaGtk5XM41oiooleLHeae6jJfSkrLVuAJ4U4z0gjf
 8IqmKF5lT5a9vn7dDO7QOA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741966126; x=
 1742052526; bh=bpL6PRqgKlp6Z5FgyNk5KUv96ZJsZ3UjkTfWTQQkUMU=; b=1
 lbLo65MWQ+UZXs89yWuoMsDtFIpoY2MvncmowOKba7V5O40JuOeSxN82JbL8ocyy
 +MMzqXMMXZyPgf1hG5iXyL/jgMw9nH0pvcWwcdc1BHLRsszxRbHWFFlUG1dib5V+
 TM/c2EVeRiF60sVRA3xKrnUtbarigmknBcF75Q1CZGxs/W40p70HSK8DSADMFSn/
 bCShp/MLngPC0FBGcqv265MMRx1yDUHPDuuB03RT++0ua8VZuLx2iFKgSgqzNMl3
 y1b1uQhwv3ixfOyJsMD1S0vEK9t6QRmMKT2M+7CZHlpIvRdjWEf5IK7pcikhnQcs
 /RRxJTOE1+wtUG2kCwB1Q==
X-ME-Sender: <xms:LkvUZ_RyTtnwC2jzn-anEbmAVG0dCmkVZhBKfAWXPEdpSIu24R0ZUg>
 <xme:LkvUZwxGlNqnLD4kELeiI55zVLtesGMK8s-zAjqIkcKInzfP5hCmCkSC56RiFqpDl
 C3Als5sdjWyGMjqJw>
X-ME-Received: <xmr:LkvUZ03zgDpzFribXWXWz88bGnJlw3-y0HAzE9Zi1A5XxyoHhtArWICUB86R2Rkw3DWpblmc0VyFEHbvFnnsNRfj1g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddufeduudelucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
 pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
 gvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddt
 jeenucfhrhhomhepvfhhohhmrghsucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonh
 hjrghlohhnrdhnvghtqeenucggtffrrghtthgvrhhnpeekfeehfedtgedtjeehueeutdfg
 leefieevkeeikeelkefflefgtdevieehheffudenucffohhmrghinhepughpughkrdhorh
 hgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepthhh
 ohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohephedpmhhouggvpe
 hsmhhtphhouhhtpdhrtghpthhtohepphhrohgssgesihholhdruhhnhhdrvgguuhdprhgt
 phhtthhopehsthgvphhhvghnsehnvghtfihorhhkphhluhhmsggvrhdrohhrghdprhgtph
 htthhopeguvghvseguphgukhdrohhrghdprhgtphhtthhopehprghulhdrshiitgiivghp
 rghnvghksegrrhhmrdgtohhmpdhrtghpthhtohepmhgrgihimhgvrdgtohhquhgvlhhinh
 esrhgvughhrghtrdgtohhm
X-ME-Proxy: <xmx:LkvUZ_AxXhkySUHkW21drrQpynU-yXDFr9rQEI0Lcr7jZrP5P0LjqQ>
 <xmx:LkvUZ4infNM3lsbMxxtGWzCidzWlk5AKGzBQyNqIHlnPfDkpniSMKg>
 <xmx:LkvUZzoh3uy1VcpSBv6b9uctCLiHddtfbKrxTh6KJpmjYPQuT-GLzw>
 <xmx:LkvUZzjTg8yhKwVEmwnoFgHxJyCAjTJQjXbIPS1LVMGzIeAQb4RPTw>
 <xmx:LkvUZyYAssmvrdIRPCvC5HNQd3meBXJorpXCR_TELIqdpoEUW9OB7pe3>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Mar 2025 11:28:45 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Patrick Robb <probb@iol.unh.edu>
Cc: Stephen Hemminger <stephen@networkplumber.org>, dev@dpdk.org,
 Paul Szczepanek <paul.szczepanek@arm.com>,
 Maxime Coquelin <maxime.coquelin@redhat.com>
Subject: Re: [RFC] git: consolidate .gitignore files
Date: Fri, 14 Mar 2025 16:28:43 +0100
Message-ID: <5232183.som1txNFv6@thomas>
In-Reply-To: <CAJvnSUC+=QcAMwuxgiZpTG=LTyo7nv30QYSUbZOxBL+BwtfdSw@mail.gmail.com>
References: <20250207182634.168820-1-stephen@networkplumber.org>
 <3828431.VsPgYW4pTa@thomas>
 <CAJvnSUC+=QcAMwuxgiZpTG=LTyo7nv30QYSUbZOxBL+BwtfdSw@mail.gmail.com>
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

14/03/2025 16:18, Patrick Robb:
> https://git.dpdk.org/next/dpdk-next-dts/commit/?id=564f4abb42df0cdf7da8c53933705bc205642005
> 
> This commit on next-dts changes the name of this default config file from
> test_runs.yaml to test_run.yaml. However, it is not pulled to main yet.
> 
> I can send a patch equivalent to Stephen's which changes test_rund.yml to
> test_run.yaml. But, should it be applied to next-dts instead of main, so
> that it is "on top of" commit 564f4abb42df0cdf7da8c53933705bc205642005
> which necessitates it?

Please can you rebase next-dts on top of main?
It will force you to make the change in the root .gitconfig


