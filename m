Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97D32C7EE31
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Jun 2025 10:46:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E981C4026B;
	Fri, 27 Jun 2025 12:46:35 +0200 (CEST)
Received: from fhigh-b8-smtp.messagingengine.com
 (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
 by mails.dpdk.org (Postfix) with ESMTP id 075F04025D
 for <dev@dpdk.org>; Fri, 27 Jun 2025 12:46:34 +0200 (CEST)
Received: from phl-compute-03.internal (phl-compute-03.phl.internal
 [10.202.2.43])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 76EDC7A025E;
 Fri, 27 Jun 2025 06:46:33 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-03.internal (MEProxy); Fri, 27 Jun 2025 06:46:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1751021193;
 x=1751107593; bh=4WmOXrywMVG22HaXUp+OSO0nfV7grOideKJD/rWN3mA=; b=
 bpioXB+gwcJfUiD/dr5hhMYp5wN9Aj3bGKsqmgEDlZ75R9hwhUtkcVkDx5nJj+qo
 HbvxG56rofaMhLJ/tXQ6W1DUHyfXLvwbIUgJi37v4EL4FdcUNqdc42YuTFG3GNRL
 ZAjoxES3Ff5k30CQ7JJT3DFg8PLV1Q0X3NgghUsWmmiETIfpN+F+JaUZbJrdlxnc
 aOoXr2ZSNKhbp3V+u8asXasjshsTQ9Dg1t8eRIdQfC2zUfMA1WeSQ5SZ+EhKm36L
 GgcmiOTMPBHtaXXf7MYRwvpsEHGkqccC0WFTjf+RaskL6pHYJqfFtspWt4L5n2yK
 yyWqYGBP10ZYf6EZYNjheQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1751021193; x=
 1751107593; bh=4WmOXrywMVG22HaXUp+OSO0nfV7grOideKJD/rWN3mA=; b=c
 c22rgyDf7XZMzU7EJ8SfOamdey00656A/6TRbztsaSY/1C2LxCGGrbJfYChsv+PO
 84K/buiEMjFL9ajXO2XXWf/9UPuFaR+cgj7FvmFaebB9y9r1DmG6qMwnb2xVSJYc
 uevjOBt8utdzr2tmOWlfgzXKbGyQDtf/ZBibd4AkrU97RnSD40nD049lQIhCD+Vw
 eOuPZsftOLH7PEobAmr+Q9GjHsN08yWL2U1vupZVdHkg5ew6B7uaaw+ERyWPbu9t
 cWWWzD1nXtrUq1iZKENBE1vcL8KjlItIrubdvKUmC0Ccz7k3KW1lqaLXsaVJk55j
 ZOGzlqp4jHivFih4lPkCg==
X-ME-Sender: <xms:iXZeaGdwwqIvHMtPE7n8WkxJCtwtoUQE_nolFdqajt6MjBty_GfTzw>
 <xme:iXZeaAOCsDZbDSKu7Vq7Xyd4Kvo7oGawVFz6G-0ONvY38bZyQGu7iXVdtQ6lDMlb5
 RfFMreqlTMqhVGFVQ>
X-ME-Received: <xmr:iXZeaHhlGkqJvUyFeU2HVxnwLdrgICDuZdLOv49SIl5-sDV0HOXAFw7iyuzIQ2RM7VtpQZhb-Xd_wYQoyoC8LDCE5A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddvkeeiucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
 lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
 ephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghsucfo
 ohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtffrrg
 htthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdvuefg
 feekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
 hthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeefpdhmohgu
 vgepshhmthhpohhuthdprhgtphhtthhopegrnhgrthholhihrdgsuhhrrghkohhvsehinh
 htvghlrdgtohhmpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpthhtohep
 sghruhgtvgdrrhhitghhrghrughsohhnsehinhhtvghlrdgtohhm
X-ME-Proxy: <xmx:iXZeaD9w6iPvRmazwHJOFqP9B-a_-bkYmPKlamRWh9pOatcSlJFv1g>
 <xmx:iXZeaCspAkQMIsYWXD_i7oL0dWCyNhPlzt7ivACLyB5y3l3rVHtbsg>
 <xmx:iXZeaKHFcqQ_M6XAQSwEe0bHXJ8IW21cgXlpslU4i3s8siRSYjh_Cw>
 <xmx:iXZeaBNddmNHDeJVQkmEU-K8cCpuD-qUoXXKu_lJUdD_gbsj1QQSTg>
 <xmx:iXZeaKTQQkV6vBVAfa8oAfyP5cv3mcGMxwhdpgAVK4GU8XvouLvzXky2>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Jun 2025 06:46:32 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Anatoly Burakov <anatoly.burakov@intel.com>
Cc: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>
Subject: Re: [PATCH v1 1/1] memory: handle invalid socket ID's when allocating
Date: Fri, 27 Jun 2025 12:46:31 +0200
Message-ID: <3865806.FMhQkTaH9n@thomas>
In-Reply-To: <3956282.MyG8hOvIyE@thomas>
References: <4e785f17154922f775c56558947b2f967f25b23c.1750426216.git.anatoly.burakov@intel.com>
 <aFVkMQ6jc27mTJG2@bricha3-mobl1.ger.corp.intel.com>
 <3956282.MyG8hOvIyE@thomas>
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

27/06/2025 12:44, Thomas Monjalon:
> 20/06/2025 15:37, Bruce Richardson:
> > On Fri, Jun 20, 2025 at 02:30:23PM +0100, Anatoly Burakov wrote:
> > > This issue was reported by static analysis. It is a false positive,
> > > because both `rte_socket_count` and `rte_socket_id_by_idx` only report
> > > information about physical sockets, and these specific calls are made
> > > during EAL initialization, so no other sockets (i.e. external) could have
> > > been available, so it is pretty much impossible to get invalid return here.
> > > 
> > > Still, to avoid future false positives, we can fix it here.
> > > 
> > > Coverity issue: 470131
> > > 
> > > Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> > Acked-by: Bruce Richardson <bruce.richardson@intel.com>
> 
> Applied, thanks?

Sorry for this typo, it was not supposed to be a question mark.
Yes you absolutely deserve some thanks for your continuous maintenance
of the DPDK memory subsystem. Thank you Anatoly :)



