Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFDB1C83F1A
	for <dpdk-dev@archiver.kernel.org>; Fri, 11 Jul 2025 12:38:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0C658402A9;
	Fri, 11 Jul 2025 14:38:27 +0200 (CEST)
Received: from fout-a6-smtp.messagingengine.com
 (fout-a6-smtp.messagingengine.com [103.168.172.149])
 by mails.dpdk.org (Postfix) with ESMTP id F34E2400D6
 for <dev@dpdk.org>; Fri, 11 Jul 2025 14:38:25 +0200 (CEST)
Received: from phl-compute-05.internal (phl-compute-05.phl.internal
 [10.202.2.45])
 by mailfout.phl.internal (Postfix) with ESMTP id 79494EC0479;
 Fri, 11 Jul 2025 08:38:25 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-05.internal (MEProxy); Fri, 11 Jul 2025 08:38:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1752237505;
 x=1752323905; bh=LcsglB6LlQvQ0VSvp/ZKV3Z+BP93WijVDNHV3Od2QjA=; b=
 skt7MCkj0aBs/T4g112dnYsRhOD9DXerWy3BuKCDGUkVbHsrsXG1aS3r74jeeA/x
 dYWjFbG5HshFG25Pa7nvNkl85SsXiffGErUeurJMYLyHN3+J1sx43/vAxoxj9IT+
 d2Xvnqb827S1I4khBCdYtUnG5OUOf0ZLWXIVWLb6Gjv5LSD4BDr256wIMnYJI5Hq
 qIDQZRdhaczMGc8l6qyuvVSZ8+ypfZ42Xs5pTjmW69aoKfYLe0DNZGqOsOx/VWX8
 30ztjdVdpkkvzlAXrLnAHD5r3U/lRuwHWFTQbE+/WmpzvGJLcsnP1EOhbSfIwFy4
 VbZZwvd3daMD2Fil4ATYrQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752237505; x=
 1752323905; bh=LcsglB6LlQvQ0VSvp/ZKV3Z+BP93WijVDNHV3Od2QjA=; b=h
 265rEYohuDoR4Z+pPg3VN3GsXArH5Ya+aStzYAnhfuICmlTeuIfxFrCCu3mPyHqq
 Je5CBOYtenoGAoIExwcnLDR8GgUiWv0npPV6jDx+g9NcZ8OgWI5BUP8BFd8GMOSi
 ST/ErYlkUxRwwUZnH/BAHCgYTc1DBbKJK4BxaRjY0YwQMUeBL50CW+kAd0RjIXdk
 1wMRFRyl1ddMma6PdbDr1pSsnOi7SJud/uaaCzZhacJ7nTBPFlqmT2/fZk+3DLOb
 1cq9J4hl6LE1dn/NTY7uc6p7Gl3ndeElNmWcw5KbJ5bz4S283HaN6l2atLVeL1Y/
 pkn1OqTpga17eH/ts6YPg==
X-ME-Sender: <xms:wAVxaBYL5QOOOYGTPOmt2l7C24GtgSabfnyEgQjd9iCcqwzbaMrkNQ>
 <xme:wAVxaA3XhgXXr7DOoOYC75fiqR0UMkRcnCB1yLlYVU1zyAb9nGnqw6UQSmY75bW09
 kETL6iko2W8GhqT2Q>
X-ME-Received: <xmr:wAVxaEauiOnJkL2CXZT26ZIHL8CZBzIj91hPeG-p529IE8_AsHNbWHf3epkZItB0yItQS0U-89UUzhtZ9AzTT0172w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdegfeefgecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpefvhhhomhgrshcu
 ofhonhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrf
 grthhtvghrnhepjeduveehieevuddutdevfffgtdegkeeuveejffejgedtgeegkefgvdeu
 gfefkeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
 epthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohepiedpmhho
 uggvpehsmhhtphhouhhtpdhrtghpthhtoheprghnughrvghmuhgvsehlihhnuhigrdhmih
 gtrhhoshhofhhtrdgtohhmpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghp
 thhtohepkhhonhhsthgrnhhtihhnrdgrnhgrnhihvghvsehhuhgrfigvihdrtghomhdprh
 gtphhtthhopegurghvihgurdhmrghrtghhrghnugesrhgvughhrghtrdgtohhmpdhrtghp
 thhtohepsghruhgtvgdrrhhitghhrghrughsohhnsehinhhtvghlrdgtohhmpdhrtghpth
 htohephhhonhhnrghpphgrrdhnrghgrghrrghhrghllhhisegrrhhmrdgtohhm
X-ME-Proxy: <xmx:wAVxaALnwv410HmHaIKHaEmImyxLyJBr5jjJA4K-CdAlmDF1spvzmg>
 <xmx:wAVxaLFGkNWs-HIOLKSvcGWOauKTzzgXF5TZ9AZY3mpwH-rZlPKQtA>
 <xmx:wAVxaPuVJUXO-cV1KaFFXEt7WIqdiJpiGFJrl6-ZwxzVUfjZ2j4olA>
 <xmx:wAVxaCti8iGptBWHD9hIY0k8EYItfLsyhsGP-ByCctwMDcS2xdZ7Wg>
 <xmx:wQVxaKYLdTlR8C3SIhVXQZlfGNL5BTVqu-LS7t83WpnHlnz9KY6gw4mf>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Jul 2025 08:38:23 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Andre Muezerie <andremue@linux.microsoft.com>
Cc: dev@dpdk.org, Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 David Marchand <david.marchand@redhat.com>,
 Bruce Richardson <bruce.richardson@intel.com>, honnappa.nagarahalli@arm.com
Subject: Re: [PATCH] rcu: add deprecation notice about limit on defer queue
 element size
Date: Fri, 11 Jul 2025 14:38:22 +0200
Message-ID: <5695570.h0BymrIErR@thomas>
In-Reply-To: <20250710143747.GA24344@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1747957021-2581-1-git-send-email-andremue@linux.microsoft.com>
 <4620749.daG60p0z9X@thomas>
 <20250710143747.GA24344@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
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

10/07/2025 16:37, Andre Muezerie:
> On Tue, Jul 01, 2025 at 04:17:20PM +0200, Thomas Monjalon wrote:
> > 23/05/2025 01:37, Andre Muezerie:
> > > The functions rte_rcu_qsbr_dq_create and rte_rcu_qsbr_dq_reclaim establish
> > > no limit on the size of each element in the defer queue.
> > 
> > Very good, we need more unlimited API in DPDK.
> > 
> > > With DPDK 25.11 a hard limit will be set (``RTE_QSBR_ESIZE_MAX``).
> > 
> > I think it is a step in the wrong direction.
> > I prefer having no limit.
> > 
> > > This will allow fixed C arrays to be used in the functions' implementations,
> > > avoiding VLAs and use of alloca().
> > 
> > I don't understand this justification.
> > Why trying to remove the 2 alloca() in the lib RCU?
> > 
> 
> Only because other developer expressed concerns that using alloca() allows
> ill-intended callers to cause a stack overflow.
> I personally also prefer to have no hardcoded limits.

Yes I vote for keeping alloca().



