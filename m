Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A63C9CED617
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Nov 2025 12:13:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C6BDD40265;
	Tue, 18 Nov 2025 13:13:15 +0100 (CET)
Received: from fhigh-a3-smtp.messagingengine.com
 (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
 by mails.dpdk.org (Postfix) with ESMTP id BC0A540150
 for <dev@dpdk.org>; Tue, 18 Nov 2025 13:13:14 +0100 (CET)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 2EE26140030C;
 Tue, 18 Nov 2025 07:13:14 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-03.internal (MEProxy); Tue, 18 Nov 2025 07:13:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1763467994;
 x=1763554394; bh=B5d9vlY0ksSCzVrK9iVMZkuIi3+U40z+Og5uZYwX2Nc=; b=
 MeDqqqXWA+8oV3x/dlIuJj51C4mbo3VAYl8nAQVIXYLDKMYG98pGhlohyAxLCjh6
 ZOnERpO7t5SSxgsIs02RaeeFBEsvSyxDaCeqSDRB2NzbuSFg4LtU8Od3jJ+sDMOU
 eaFIZM4njM2npxeu2oako/IVqxf3UTWUGPpN3nKX+QbzbaiimSQi91ewksONZOkq
 6bIf6ybtukgJ2L5IU3plETL1ZMaZHR2qNaraf1ZWOsXGKaMoed8tPDTl9cvIiu5G
 R+jABH9PNBOIfjz+mm4h9Hwg/hqlwYHizi75vxEsTUDuOwekNI7YvUdxx3Uq+sXJ
 lMvNH9ShqBC1OSCbWcHSUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763467994; x=
 1763554394; bh=B5d9vlY0ksSCzVrK9iVMZkuIi3+U40z+Og5uZYwX2Nc=; b=A
 QlqMm3mi2YDF1Y9XETdXrpSIq+CKb0kry2Kb+9asI08zcdvlrO3nTrOc+XNbSpGN
 ajEW7dqyAd215ybhWjw4Ic4GYtHlWVLSjMxA3PDnjw21vveXTSx/ekBWmxztCh4n
 tr+wuuBs0xonBrN4Pwx3DWmSesrcJSo9UnuFja4KwtslrKUf8gvd6sZfNnk2YWoN
 yUSM+bpBCF2Bl6p8S1+nsOy60ZJ8Kl7M1RbxWQWgm75OvzAH28hXPC4nfG0yQ1/v
 zy5NyqkWI1s1SPs2qhgWUEjLIi1kU+hXqoOC7nrTqop77suJgOVln4fFUSSLPtEN
 T57bG6tFH1irDPGvgHQbA==
X-ME-Sender: <xms:2WIcaTiT2CXm9NmI0Thg3ifeGQ-kHhsHLaXVhsrcb0yqCWYt-I24Ug>
 <xme:2WIcaXf27Kpn4yLmFaC2a5YIkJd3PYXMOXAFpzZJeBH4LP875XocDZT1X1VhVzsZc
 casHKlAZnimm8t-_xZ6yuwR8tmqq0VPeY-_74stUgFVpbyCHnjxzu0>
X-ME-Received: <xmr:2WIcaQfjhUi1lOlTRsbmLqoKo1XUV5Ag0-0vupK6gX1OM5yDBpkeqfyVQcnmAqSzRFuLWuukSPyubYububnmQmMIIw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdduvdelucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeefpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehhvghmrghnthdrrghgrhgrfigrlhesoh
 hsshdrnhigphdrtghomhdprhgtphhtthhopegurghvihgurdhmrghrtghhrghnugesrhgv
 ughhrghtrdgtohhmpdhrtghpthhtohepuggvvhesughpughkrdhorhhg
X-ME-Proxy: <xmx:2WIcaZ93OHCvpEvyCm4nbD-WKFdcQisv_BrS7sgL36P9TaUReEVtng>
 <xmx:2WIcaUlEeRYvRbv4i6MO1DtSnri5urkD1TsRouQUleV6LzosVlrqAA>
 <xmx:2WIcaT8q2dD3O0VbCpWGxZ5NdBXjvPjrhko5pqXVaKQdIQYaO62F5A>
 <xmx:2WIcaamgUgp9-FQWUEwwyww6xw2gLYv-4rWmx8kZRr71_SWsHuJmJA>
 <xmx:2mIcaSNmSonO2MdnKxqnGdCqsD90omDL1wQloLtvJx0V6ZltAqTn3_yg>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Nov 2025 07:13:13 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Hemant Agrawal <hemant.agrawal@oss.nxp.com>,
 David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v2 0/5] Cleanup rte_dpaa2_device
Date: Tue, 18 Nov 2025 13:13:11 +0100
Message-ID: <5612790.LvFx2qVVIh@thomas>
In-Reply-To: <789c9484-a0d3-4d18-86d4-b0cb02c0682c@oss.nxp.com>
References: <20251108153207.1512863-1-david.marchand@redhat.com>
 <20251112091049.2669481-1-david.marchand@redhat.com>
 <789c9484-a0d3-4d18-86d4-b0cb02c0682c@oss.nxp.com>
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

13/11/2025 10:16, Hemant Agrawal:
> 
> On 12-11-2025 14:40, David Marchand wrote:
> > The rte_dpaa2_device object keeps track of a device class object
> > (cryptodev, dmadev, ethdev, rawdev) which is a layer violation.
> >
> > Make use of the device class respective infrastructure and remove those
> > back references.
> >
> > Disclaimer: this series is untested as I don't have the hardware.
> > I only based those changes on look at the code and other drivers.
> >
> Series-Tested-by: Hemant Agrawal <hemant.agrawal@nxp.com>

Applied on top of other fixes from Hemant, thanks.



