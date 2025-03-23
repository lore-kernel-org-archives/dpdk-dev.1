Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B94BC28B30
	for <dpdk-dev@archiver.kernel.org>; Sun, 23 Mar 2025 10:13:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3FCB9402CB;
	Sun, 23 Mar 2025 11:13:09 +0100 (CET)
Received: from fhigh-a4-smtp.messagingengine.com
 (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
 by mails.dpdk.org (Postfix) with ESMTP id 8DC974028F;
 Sun, 23 Mar 2025 11:13:05 +0100 (CET)
Received: from phl-compute-02.internal (phl-compute-02.phl.internal
 [10.202.2.42])
 by mailfhigh.phl.internal (Postfix) with ESMTP id E4A611140083;
 Sun, 23 Mar 2025 06:13:04 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-02.internal (MEProxy); Sun, 23 Mar 2025 06:13:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1742724784;
 x=1742811184; bh=g4zOC/3L+GeT1nFSrIqdm2ptvWJ1P2HtrMDjyN2MUWY=; b=
 mM0Ex2tQTmk/MoibgiCaoYqGaDKwiteLvv/yxZbb0GyDC3pXkTYrK3gYqAyOA3kE
 GYNRz7BGl3XOTxI+xGeRDYAmS6WV+3BO+jO/+CRnxL8i6ydYF46CDRftvilfCqpb
 JXFXpF8HfFkg6DreJiYX8zXWSXy+27ztdwO/J9IdEDlSQowuKS7BQVhnv6LzyH55
 cqI0573ckR+LnhffQKlwcIQizoSHCNXMXkqMgeWUGilXUg6edpm9Morxg6x7hHUW
 7SwENFycNJ9B/jqnbxhcYwXIsSg4SUjOT234Ghfq/UkRRl3gvKtq43GOUBB8mWKj
 I+pq4rJ+k4B9IMm26c27VA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1742724784; x=
 1742811184; bh=g4zOC/3L+GeT1nFSrIqdm2ptvWJ1P2HtrMDjyN2MUWY=; b=e
 M83E/vyY+pjtzAxQrU3vqFbgONVvgrdnLLBmOLKNpswjjW6IJWUmHiNNoYC0azy4
 KrLJIGnSCCF7xnhmb43eGp52vDxPpbL+U4Kf9ch+BQRBYeRsMbSuGU/oKVEDeYbj
 56nxiuPx0fKCPv1Rm6PAxIxtJAAAZ2II1EP+5UcF7VNgNAjsjZo7xh83ZxmugfY6
 0jdw4hpD5riZsiA8Z0MIdXRqgQ2dZI/20YTNWn6Arn1AmER6qr9WTvlC9oavowBq
 r3xXxtOwztYS4kfY2Df+jyeoDHQ7+WiT/JwRKaWGDcGGB7lI+kfWp7PRcLz2huzS
 tpkbTeIeJajlkJqAJmeLw==
X-ME-Sender: <xms:sN7fZ0kMmVamP8RgYLMjCXgWd3AoSvOqVm7yIUsHzwv4NL4OMFJtYw>
 <xme:sN7fZz3tdUk9u6fodfx5wLDRguiCuoL7-b8WPG9C0eOxjRofhRTOM8KtEInarkKO-
 crOPmskmt6XZvoz4g>
X-ME-Received: <xmr:sN7fZyop98sKYEb-naMnhq7rdoh54kQjalkio9S8MAqzNaFLu3zmqR29HpLWaOXrAVDMstZdVlpm0olbdRMGQso>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduheeiieduucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
 pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
 gvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddt
 jeenucfhrhhomhepvfhhohhmrghsucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonh
 hjrghlohhnrdhnvghtqeenucggtffrrghtthgvrhhnpeejudevheeiveduuddtveffgfdt
 geekueevjeffjeegtdeggeekgfdvuefgfeekjeenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvght
 pdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegsrh
 hutggvrdhrihgthhgrrhgushhonhesihhnthgvlhdrtghomhdprhgtphhtthhopeguvghv
 seguphgukhdrohhrghdprhgtphhtthhopehsthgrsghlvgesughpughkrdhorhhgpdhrtg
 hpthhtoheprghnrghtohhlhidrsghurhgrkhhovhesihhnthgvlhdrtghomhdprhgtphht
 thhopehvlhgrughimhhirhdrmhgvughvvggukhhinhesihhnthgvlhdrtghomh
X-ME-Proxy: <xmx:sN7fZwmv04qwCpW1y5C18JP1sE7dn_inXVsl_bh6ks2CYGpoLaEo7A>
 <xmx:sN7fZy1h87FPjGkGKZZt09aOrzFSqBnp4lYvzgor0Ynz4XrmT9VhYA>
 <xmx:sN7fZ3tqUYrMUYphvDPJSuML7hk6fs689W5SB_ttUBfYTIx8fc7TWQ>
 <xmx:sN7fZ-VpVlCtKa2ZVDA67j1WkC_qxsnisoOhfnZYgVuustfT7bCDlA>
 <xmx:sN7fZ-9BS8zzd3O_9YOBcmLYwn3WyahFfWfevomAYXfwNFL6jCwjJ32H>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 23 Mar 2025 06:12:59 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, stable@dpdk.org, Anatoly Burakov <anatoly.burakov@intel.com>,
 "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH] net/ixgbe: fix missing checks for E610 VFs
Date: Sun, 23 Mar 2025 11:12:56 +0100
Message-ID: <6322230.kQq0lBPeGt@thomas>
In-Reply-To: <a8d5bb3e-4a16-415f-8fda-6251d5101ec4@intel.com>
References: <20250321171211.386594-1-bruce.richardson@intel.com>
 <a8d5bb3e-4a16-415f-8fda-6251d5101ec4@intel.com>
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

21/03/2025 18:15, Medvedkin, Vladimir:
> Acked-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
> 
> On 21/03/2025 17:12, Bruce Richardson wrote:
> > A number of places in the ixgbe code check for a virtual function, but
> > these checks were missing the identifier for the E610 VF. Add them into
> > the conditionals.
> >
> > Fixes: f678f3dea8fd ("net/ixgbe: fix missing VF PCI ID")
> > Cc: stable@dpdk.org
> >
> > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>

Applied, thanks.



