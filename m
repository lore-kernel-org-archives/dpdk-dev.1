Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 280C4C36002
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Mar 2025 17:31:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 65CAB40C35;
	Mon, 24 Mar 2025 18:31:29 +0100 (CET)
Received: from fhigh-a7-smtp.messagingengine.com
 (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
 by mails.dpdk.org (Postfix) with ESMTP id 90A2D40B99
 for <dev@dpdk.org>; Mon, 24 Mar 2025 18:31:28 +0100 (CET)
Received: from phl-compute-07.internal (phl-compute-07.phl.internal
 [10.202.2.47])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 2FBBD1140177;
 Mon, 24 Mar 2025 13:31:28 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-07.internal (MEProxy); Mon, 24 Mar 2025 13:31:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1742837488;
 x=1742923888; bh=hpTNVpmWyDTFf4qc82ibyK4V62MkNEqiPD9au87EshU=; b=
 bXTQBECPwvaKm+y0RJZndg8iG41pPVO01phiRn8KnKblI2sys9TUxez5T+/ojsBC
 vUm0BLDpPnqy5tmEdZLkXacwnfZM9s81h5x/UFI85QXvpwtmYyYz5nNXQO3Kskp/
 TxthMw/0n9oHmbLKdmOfwW1pvEfFJBzRSWNfMJy4HNKBcvYdDGzyZ1wGmwj7d7uN
 MMQOBsqGgnsDZ0DsIqQHQA2CBJE/CTQBYST2k9Dalohc8/OVsFPXLbIHqa5qCWvK
 0NJFacHsxbBgc5muDykaXNetrwaCdporkYtsuU8+NBjIWu9zzLoLShmHjridpOBO
 eeQ7OjJkPl240bljgvMZFg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1742837488; x=
 1742923888; bh=hpTNVpmWyDTFf4qc82ibyK4V62MkNEqiPD9au87EshU=; b=N
 67vOpPaMfbyGGtdah13C80ERGs/JAYCvxwPkUHmhJRHqtZgbqFGY9NmA0C43eSp6
 oOmgQOmd2HleDt4KKkdzf03Sp8HltHicCePL2BinETmhLZUOOiZfnX0DzW2l1IjN
 sK0Y9xvRndNp0SJpvnWDhyps6YAtmXHLDERzK20FGYgUUJtQOnV9I3UOlps1sEbm
 C/upst3p5I8kaKIliRfVgOvHqxAL0pHrbV6ksm3kVzvvfXG4UQxR0uESDrLVu5Lq
 LRXx6FT1KzychMg9O426dVUSVQpoQvSV4sw+YCoJ0V3VAeUBNS48y7bleVKP6dQA
 iV0oLXYnW41OBExQZdG2Q==
X-ME-Sender: <xms:75bhZydoQREy8HLmGSmhJWpNsGbqKuXtbCEROFSOJTVRzvh_220jgQ>
 <xme:75bhZ8N-VjoLmLRsLLDmVL0WOCFmvKnVCLGUCwfr86g1SrbhVgwyVr4MLUApubXgk
 MpJvZZoAHG9Xl2C-Q>
X-ME-Received: <xmr:75bhZziD23lipfrB2eY5xjUOkhZyMwIDWO2wQ7uw0G71KYEVUvQAxd1r9995Kp0FsmsgL3zSnR6IDVP88Km-afCbWA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduiedtfeejucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
 pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
 gvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddt
 jeenucfhrhhomhepvfhhohhmrghsucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonh
 hjrghlohhnrdhnvghtqeenucggtffrrghtthgvrhhnpeejudevheeiveduuddtveffgfdt
 geekueevjeffjeegtdeggeekgfdvuefgfeekjeenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvght
 pdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkrg
 hirdhjihesihhnthgvlhdrtghomhdprhgtphhtthhopegsrhhirghnrdguohholhgvhies
 ihhnthgvlhdrtghomhdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtphhtth
 hopehgrghkhhhilhesmhgrrhhvvghllhdrtghomh
X-ME-Proxy: <xmx:8JbhZ_-a3uayjR6MGzz2kb2s_RtjlBKo9LfmI62hz8Id9ZBzSVB8Vw>
 <xmx:8JbhZ-vcYI1v96M9N7Q0yjGaw8NLrazxZP6DcKE2G32oAFgy5FM0zA>
 <xmx:8JbhZ2HOQyzDWIvPQCXLXbA5CphUCsuh5yuAeiS6YLFuwZxZAn-ijg>
 <xmx:8JbhZ9OWU5bISGA745T4MKyyW5GTBqc5VnC7MSg0qB4dElwlAAVR6w>
 <xmx:8JbhZwIN5Hka_dS1oEwfEY3GHMhuseYXuJ62atzpQaZXsd12GMfiyyU8>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Mar 2025 13:31:27 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: kai.ji@intel.com, Brian Dooley <brian.dooley@intel.com>
Cc: dev@dpdk.org, gakhil@marvell.com
Subject: Re: [PATCH v1 1/2] maintainers: update for crypto performance test
Date: Mon, 24 Mar 2025 18:31:25 +0100
Message-ID: <4344283.atdPhlSkOF@thomas>
In-Reply-To: <20250320142113.1130872-1-brian.dooley@intel.com>
References: <20250320142113.1130872-1-brian.dooley@intel.com>
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

20/03/2025 15:21, Brian Dooley:
> Replacing myself as Crypto Perf App maintainer with Kai Ji.
> 
> Signed-off-by: Brian Dooley <brian.dooley@intel.com>
> ---
>  Crypto performance test application
> -M: Brian Dooley <brian.dooley@intel.com>
> +M: Kai Ji <kai.ji@intel.com>

Series applied, thanks.



