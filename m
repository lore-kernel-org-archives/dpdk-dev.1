Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E82BC71135
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Jun 2025 22:48:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 33B3E4021F;
	Thu, 12 Jun 2025 00:48:37 +0200 (CEST)
Received: from fout-a1-smtp.messagingengine.com
 (fout-a1-smtp.messagingengine.com [103.168.172.144])
 by mails.dpdk.org (Postfix) with ESMTP id 54DCE40156
 for <dev@dpdk.org>; Thu, 12 Jun 2025 00:48:35 +0200 (CEST)
Received: from phl-compute-12.internal (phl-compute-12.phl.internal
 [10.202.2.52])
 by mailfout.phl.internal (Postfix) with ESMTP id C23BB13804A0;
 Wed, 11 Jun 2025 18:48:34 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-12.internal (MEProxy); Wed, 11 Jun 2025 18:48:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1749682114;
 x=1749768514; bh=qlKXrX7viumg0+d8DDByZO98Zw4LftKc9s/3G+VFIFo=; b=
 al2yjYHdoQtcefgLMfXAnMBzDommpk/cum77A2Px3+25bIBb1v1zgmSfpVCjPdvt
 zaV2dzcD/Ty/098KoKtm7RuRIYSXXR2PLmVWaQpBbE1H+utTYKeiT6mquQ7tjbDi
 5Bu6vHt5Nctj3K0xJ7LENhCJyn8vFMQjkIRspsuxUW09ilo3yCypreCe2MGXM3Qc
 hJlYZH/G/nWByr3phQOW018zPas/7lvrIkrSpL/X6O3ZpaXqeN/gZR71rWAWKCbt
 k75K7TwGeNHKecqo02qBtZhxSRG6AoJ7BAs3dOqBocFjcLQvxZ7HWiDINSeNNt2F
 XkaShn1VFFPfSfAyhLaIaw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1749682114; x=
 1749768514; bh=qlKXrX7viumg0+d8DDByZO98Zw4LftKc9s/3G+VFIFo=; b=c
 AGusnJj5FQBuFxjiJJOCSXA8aIwPjU5VDFufI8opgbUKh45KVBBg4G8bJ3OqZoQc
 rtX5gZ3nDUO2F+rMV+v/10r6aWWswQmygRmRHbtS9AQKyOq2G8CrZBXaWZQ9lt/d
 ccB3JeiJ1TZjKdyaxtgOxmXhKy7WH3pYzSB7CV1R6WJuNVJqldThmmhrMdx/ogtQ
 EOcEqy9CNFooOq4Ng1mFNNPcjQ7Yv5hnJpI9vRo+Q/MUIfKPKEZrNJMSgzEhYyD2
 A7NQZFVJkoR7NeNS01spINNSPu1kau+rAvUGaejb3u6vNIN29rJqft0AFi7AizEy
 dodXs+dkTEbpwIBYtN+3Q==
X-ME-Sender: <xms:wgdKaBkiXque93hXx4psXrBZa9u_Pz3xUfdgBOl_XjHZ3XSlyeubGw>
 <xme:wgdKaM0Wue7ZiVQxVBjf8WyqYB2SVEjnCPhwkkTADmMfHlx0k-4ZaMQEzdFGr93bw
 EQoQlfc8HphfQNGLA>
X-ME-Received: <xmr:wgdKaHo7p7FlzX9QnfR7UZpBHyt2U3AIQZSszYDKns_451UBLSMP7i9aJ0DpEaHxcHX_4DLz3O2O5xpxL-bveqjKOw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddufeegvdcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
 uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
 hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdej
 necuhfhrohhmpefvhhhomhgrshcuofhonhhjrghlohhnuceothhhohhmrghssehmohhnjh
 grlhhonhdrnhgvtheqnecuggftrfgrthhtvghrnhepjeduveehieevuddutdevfffgtdeg
 keeuveejffejgedtgeegkefgvdeugfefkeejnecuvehluhhsthgvrhfuihiivgeptdenuc
 frrghrrghmpehmrghilhhfrhhomhepthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdp
 nhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhtvg
 hphhgvnhesnhgvthifohhrkhhplhhumhgsvghrrdhorhhgpdhrtghpthhtohepuggvvhes
 ughpughkrdhorhhg
X-ME-Proxy: <xmx:wgdKaBlb_8jxjXVTleutz_9WBXInlmYIKRHjWVhxix2Ik7imX0KCjQ>
 <xmx:wgdKaP0D4uXwBjB9TxTHTJCjOHgHKSZ9SQbZVSWpVhYZ9W2qPbHLGA>
 <xmx:wgdKaAud84QbBtkhmKZ3KxVr-ZNDVKsXmDEBH8qmqLuXuFvNpx5-eg>
 <xmx:wgdKaDVRkz0HvPbtbL1dYOxiSf4hLI46PcUMCo98ZA1XbCm3QkOZFA>
 <xmx:wgdKaG4wEOXGGp6vBbDNAUgLx7afMI3NI_5Wz1t0TtRUSLSrfCxpnxqa>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Jun 2025 18:48:33 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org
Subject: Re: [PATCH v8 0/7] latencystats: cleanup and floating point fixes
Date: Thu, 12 Jun 2025 00:48:31 +0200
Message-ID: <5143631.ktpJ11cQ8Q@thomas>
In-Reply-To: <20250610141355.91759-1-stephen@networkplumber.org>
References: <20240408195036.182545-1-stephen@networkplumber.org>
 <20250610141355.91759-1-stephen@networkplumber.org>
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

> Stephen Hemminger (7):
>   latencystats: handle fractional cycles per ns
>   latencystats: do not use floating point
>   latencystats: fix log messages
>   latencystats: update include files
>   latencystats: enforce that unused callback function is NULL
>   latencystats: add metric for number of samples
>   test: update to latencystats tests

You forgot Bruce's ack and patch-by-patch test.

Applied with above fixed, thanks.


