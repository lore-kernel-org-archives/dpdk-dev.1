Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4AC1C83F1A
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Jul 2025 12:29:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D5E204021E;
	Mon, 21 Jul 2025 14:29:01 +0200 (CEST)
Received: from fhigh-a3-smtp.messagingengine.com
 (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
 by mails.dpdk.org (Postfix) with ESMTP id 13CD84014F;
 Mon, 21 Jul 2025 14:29:01 +0200 (CEST)
Received: from phl-compute-04.internal (phl-compute-04.phl.internal
 [10.202.2.44])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 7C13014001FB;
 Mon, 21 Jul 2025 08:29:00 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-04.internal (MEProxy); Mon, 21 Jul 2025 08:29:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1753100940;
 x=1753187340; bh=dklo+UPH9zEci2hpcANjhY9vzkeBgPIoUqdJwXf0zj8=; b=
 ghfDEKl5PYmtOQXxuSw6Sj6r+GdPpuQqyBm1P03x6dpLbhWPto+xf8QmKNIyZz4p
 lA4gLF8rt8F1gSuitovWVUwaMZgqDSuBn/faJgwHxc0HQd/fdEm2+2k5p2xEZJnd
 zm2sxCAlHaJVcsvQ63gIIKbD41wCuwAow8yEwhP0urtjqYxkPkrS+bUwCrLcAqlv
 b+rqIfpGj4Gg8twnTF9VdnMpTRLp6MKc/OZwOB6TH06X0IorZcPI/ypkFAQpN0FZ
 oe9xm7Ocdj0pk/PIQagBk4JL1IOcJlV2jxzg48iGghOD6o8TTedcY92/cBHSt0CC
 Osl3rNzTQ9HrvjPqxT++QA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1753100940; x=
 1753187340; bh=dklo+UPH9zEci2hpcANjhY9vzkeBgPIoUqdJwXf0zj8=; b=N
 vEU7YM9NDq4JXK4hDXRmU/YKP0hBJvLUYnTrgECCshxd2ZgHwnFogTHFAQ6Xu7if
 RagoidEFOLXW6sb+ztnCEiWt4i08b2+8Defk9o2eYLv+SpXuq8wFXLZJk+e721cE
 m9JaH+yiiLH3oolDvds/XQO+ui/6Qvlkgsb/9fOVPaHR4DGzdyaKxINFXs2h+8iC
 Gk6Abt/zpBwsci3/Q9QBBKlUWW6wXNt5oA2wJWZsvcyOe+pDr+ZVrjLHJAPpCvfq
 QY4WTWA0otcLzh9KquZyaqxPWysIxXEOEcZqpqsC36cJCyjin1I6g4PX3uPakTKP
 zxSh+5WF5vnSGhQb5QNuQ==
X-ME-Sender: <xms:jDJ-aLxh_a-eZZJlIPfKRpGf_NNPTxyiyarqQdtIyBNhAD7oDT8pCg>
 <xme:jDJ-aIqY7D2-cScLW8JqKR-V3EEHk8uo9mAkgRklQIpw48gJ6D8yBFQBwwhQG73NE
 UzhNkvAFQf-TDKUNg>
X-ME-Received: <xmr:jDJ-aFjVLVVn_SKUFdDk3qZ-4f5VUUtdVBZ9ZPsyZh7VwCvQ64WSGnsGN9UhBBpbdZFVbHp41Jvof__YgSHYFLQqlw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejvddtjecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpefvhhhomhgrshcu
 ofhonhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrf
 grthhtvghrnhepjeduveehieevuddutdevfffgtdegkeeuveejffejgedtgeegkefgvdeu
 gfefkeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
 epthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohephedpmhho
 uggvpehsmhhtphhouhhtpdhrtghpthhtohepshhunhihrghnghdrfihusehjrghguhgrrh
 hmihgtrhhordgtohhmpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpthht
 ohepfhgvrhhruhhhrdihihhgihhtsegrmhgurdgtohhmpdhrtghpthhtoheprghnughrvg
 ifrdhrhigstghhvghnkhhosehokhhtvghtlhgrsghsrdhruhdprhgtphhtthhopehsthgr
 sghlvgesughpughkrdhorhhg
X-ME-Proxy: <xmx:jDJ-aFh5YxKb6TwNCZ7Y_UzWxzY2TcYRRxpoiP5ccMiKHtaMmO1QYw>
 <xmx:jDJ-aLjkIOYh_4d4XqMfC5N7n1NPlXdEtzzVT58UJPKjchpRQ3Ni3w>
 <xmx:jDJ-aFJvNCg4eDBshH2yaXNoD0msLdjJO0rLz7riue89ZkW1SgNKCg>
 <xmx:jDJ-aKFr6_nT6Efyo6q9-Uyf_rJCJaOW-S7as2UY3FmPcF_WOGHArg>
 <xmx:jDJ-aB1DbGfb4TtwaXW6rojkfxvGWzYZCl4WjJ8r-ZfEP4XNc_esrJfX>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Jul 2025 08:28:59 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Sunyang Wu <sunyang.wu@jaguarmicro.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>,
 "ferruh.yigit@amd.com" <ferruh.yigit@amd.com>,
 "andrew.rybchenko@oktetlabs.ru" <andrew.rybchenko@oktetlabs.ru>,
 "stable@dpdk.org" <stable@dpdk.org>
Subject: Re: =?UTF-8?B?5Zue5aSNOg==?= [PATCH] ethdev: keep
 promiscuous/allmulti value before enabling
Date: Mon, 21 Jul 2025 14:28:57 +0200
Message-ID: <17193600.geO5KgaWL5@thomas>
In-Reply-To: <KL1PR0601MB556788BFC98F8A212F2F6921905DA@KL1PR0601MB5567.apcprd06.prod.outlook.com>
References: <20250721115139.46728-1-sunyang.wu@jaguarmicro.com>
 <3628442.V25eIC5XRa@thomas>
 <KL1PR0601MB556788BFC98F8A212F2F6921905DA@KL1PR0601MB5567.apcprd06.prod.outlook.com>
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

21/07/2025 14:13, Sunyang Wu:
> Hi, Thomas:
> Thanks for your note. The main purpose of this modification is to align the handling logic with the "disable" functions,
> aiming to enhance the overall consistency and maintainability of the code.
> 
> Previously, the handling of failure scenarios in the "enable" related logic differed from that in the "disable" functions. 
> With this adjustment, both will behave more uniformly in exceptional cases, which should reduce potential confusion
> during future development or maintenance caused by inconsistent logic.

In this case, please send a v2 explaining the intent is to align with disable functions,
and saying there is no behavior change.


> 21/07/2025 13:51, Sunyang Wu:
> > The values of the promiscuous and allmulticast variables are set after 
> > calling the driver, according to the return value.
> >
> > Fixes: 400d75818266 ("ethdev: check device promiscuous state") 
> > de5ccf0775ae ("ethdev:do nothing if all-multicast mode is applied
> > again")
> > Cc: stable@dpdk.org
> >
> > Signed-off-by: Sunyang Wu <sunyang.wu@jaguarmicro.com>
> [...]
> >       diag = dev->dev_ops->promiscuous_enable(dev);
> > -     dev->data->promiscuous = (diag == 0) ? 1 : 0;
> > +     if (diag == 0)
> > +             dev->data->promiscuous = 1;
> 
> I remember seeing this strange behavior of resetting the value if failed.
> And it is done differently in the "disable" functions.
> 
> But it is not so wrong, because if it was enabled, the function returns early.
> So the value changes only if it is successful.
> 
> What is the issue you observe?
> Is it a rework to make the code easier to understand?



