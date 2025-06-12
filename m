Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A648BC71135
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Jun 2025 00:14:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BD4EB40A84;
	Thu, 12 Jun 2025 02:14:16 +0200 (CEST)
Received: from fhigh-b5-smtp.messagingengine.com
 (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
 by mails.dpdk.org (Postfix) with ESMTP id C618F40A75
 for <dev@dpdk.org>; Thu, 12 Jun 2025 02:14:14 +0200 (CEST)
Received: from phl-compute-02.internal (phl-compute-02.phl.internal
 [10.202.2.42])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 1E2D02540189;
 Wed, 11 Jun 2025 20:14:14 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-02.internal (MEProxy); Wed, 11 Jun 2025 20:14:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1749687253;
 x=1749773653; bh=22Q4l20ungCZ+qCv3Pi2JCbM2DkKELkW6gmpqC9RQHE=; b=
 dRURF39u0g33bc/upIU2mJKeMFCgPB/+j6u20tcaI3KXc+L5USdZWQoWaZGWSTut
 a0aj/AJ0UTzmwM/6IcjrrX3r/NgDUN2rqSTKNXHkfLNVXmfjS41cWtmrTxApszbf
 IaSYOM344fnhqCSqjDoXb/FCcL3r9m2yfLo9uOUaCd708FGFae6NOavnZfzE7zbF
 t9PllYgEIHWlaR+xCq52WarS9GBf9U+5j9VnPMUDTUerAk8KzxXEZJXcFJlTYv1a
 Du1ltw3DGat4jFnIJ7C7MsBgYPwBeoxl55SyaH28wLDpcui/c39//3o0XuEJBX4t
 vayIHo3FX2LGpYnrXLeqgg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1749687253; x=
 1749773653; bh=22Q4l20ungCZ+qCv3Pi2JCbM2DkKELkW6gmpqC9RQHE=; b=e
 ZllD+Q+4R+jSqAgDT3Dnv0G9N/772poszkVP0FX6qnIpf6j/sHCAsQK6wGG7xaV9
 rqOU9Dqt+Zc5Vw8lbgD0dWQ1aa68ET+ifPxcdwX9E1RvAhOCP7nQXKwGXFqtcEio
 JHoLvTliZGYXxrtgZfdUCVnLBuuq/DqSWsH9p39zTsI2qYwfzsw2pP9Tcq8CioCr
 d0dLCsZuR+XQ/MJh3HmJYMtDDdlqfQRGYPPKEQ6nfBa1CjD2ArA8pqvUDwt7HCdp
 fCgzd64/983dxp7QOZ5GBi9H1O6kxTxYyRUJ7g0dVcSMpjfTzc78wbdJDQzIdqWW
 SAcRhF76TVOIc/rNFy67g==
X-ME-Sender: <xms:1RtKaJs_opDgztAOkdoaX0xy_MWwdRSixd-jWoGtp99T8N3gSzwoYA>
 <xme:1RtKaCdzFK8bB5sBYxsUnQBS0Qg7PKIBnyEmfqQnd1gKH6BNEGp4lHBrGpWaDZMSF
 yglaAB4BI28vzRPaQ>
X-ME-Received: <xmr:1RtKaMxpftxexm6gqG2r3UdOS0F6DeGkZnzrLmWpRnwN9TKv4vzDX1G6OLCUbBg075haDdhu2qhJSyGiWXOcFiDDtg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddufeeitdcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
 uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
 hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdej
 necuhfhrohhmpefvhhhomhgrshcuofhonhhjrghlohhnuceothhhohhmrghssehmohhnjh
 grlhhonhdrnhgvtheqnecuggftrfgrthhtvghrnhepjeduveehieevuddutdevfffgtdeg
 keeuveejffejgedtgeegkefgvdeugfefkeejnecuvehluhhsthgvrhfuihiivgeptdenuc
 frrghrrghmpehmrghilhhfrhhomhepthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdp
 nhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepfigrnh
 hgrdhjuhhnlhhonhhgudesiihtvgdrtghomhdrtghnpdhrtghpthhtohepuggvvhesughp
 ughkrdhorhhg
X-ME-Proxy: <xmx:1RtKaAPA0yk4bebImgB8ofdU3dYX64n5b0YgCZe5MC9WmUo4p3q44g>
 <xmx:1RtKaJ83s-bRIoVaXV6cbqFQmEI279G996s96_g8HJ4GS3RIZTpemQ>
 <xmx:1RtKaAUlwudctg4-WiufcoCMLDWAMGXlPT2a1lSBxMdhbm1O87vmpQ>
 <xmx:1RtKaKfSJQSu8l-AayrveV9cUCUG3SkL0jNhURUlgP91YtfrA047Dg>
 <xmx:1RtKaPMhui2CE1Pb6q8VrM8vBJ7IZ98334FMxBAQvu6GkiPmGbzy-pCi>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Jun 2025 20:14:12 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Junlong Wang <wang.junlong1@zte.com.cn>
Cc: dev@dpdk.org
Subject: Re: [PATCH v1 1/3] net/zxdh: modify some MAC config issues
Date: Thu, 12 Jun 2025 02:14:11 +0200
Message-ID: <11989263.ag9G3TJQzC@thomas>
In-Reply-To: <20250607023020.3051575-1-wang.junlong1@zte.com.cn>
References: <20250607023020.3051575-1-wang.junlong1@zte.com.cn>
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

Hello,

07/06/2025 04:30, Junlong Wang:
> modify some mac config issues,
> which were discovered during the testing process.
> 
> Signed-off-by: Junlong Wang <wang.junlong1@zte.com.cn>

That's not how we fix issues in general in DPDK.
We want to provide tracking history, so:
- we split the fixes per issue
- we provide the cause origin (with "Fixes:" line)

Please could split and better comment these fixes?
Thanks


