Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6FDFCD98C7
	for <dpdk-dev@archiver.kernel.org>; Wed, 10 Jun 2026 21:38:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D3A4442B71;
	Wed, 10 Jun 2026 23:38:58 +0200 (CEST)
Received: from fout-a7-smtp.messagingengine.com
 (fout-a7-smtp.messagingengine.com [103.168.172.150])
 by mails.dpdk.org (Postfix) with ESMTP id 1A2D14013F
 for <dev@dpdk.org>; Wed, 10 Jun 2026 23:38:57 +0200 (CEST)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfout.phl.internal (Postfix) with ESMTP id 8D8D0EC0104;
 Wed, 10 Jun 2026 17:38:56 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-04.internal (MEProxy); Wed, 10 Jun 2026 17:38:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1781127536;
 x=1781213936; bh=smpLm12Y35YZs0PrMi3ju05WFO1WsXgwceldcvt1LGc=; b=
 c9/J2C71nBmJncTlkRgTsP5iFxpT0VP8MSYmvKTMswwOSJRw3JjqT0TLwc+Qmp52
 /PA6/8c27M4wLz9aUOfN9IP0k6hHyw8drpQEs8sWUMoJH8AwTPgkECslfKRIyX2F
 33PYcw9ELwNPfpdi3ZpjtYmCbFJljs57hu6KWAqVeSAS8CcnNiVm9x/eQF7Vv0dq
 9DN5s7eX2MVtJ2rINoiVT6kXckaq3j0bUok//DqXAulgbEGDAEUptIGHiEo7cRoU
 ZjquDMX6WDO2q47146do/Ybs6UqsX/LpkpEcLT7/8D2FACUexxycpJiAnh/pTHqN
 KEzZcAoSnfl6b4w+r2S7Aw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781127536; x=
 1781213936; bh=smpLm12Y35YZs0PrMi3ju05WFO1WsXgwceldcvt1LGc=; b=E
 vfSUcyrobbASEhi0Jv12BAKYs3SsFf0p2QVVRJ9lJntK0EsZCifDZlOKLk87uZZ/
 /he2XIP+CRKAU2jZuJ4Fjr6O1xxuk/KswTKnU3VWeScfiWR8r4d5mcFsRSUo/0Ks
 IyCNVU3X5Xb4cAl28RfFOdcp8SQwX/xlgWNusWm5bWNyaTxx5KExmF/IDBbm3iC+
 zglKwe/ZboRDmPWZVtEY9YS0x/mi0vrnf38I5WqEcLNyll8yNBq/ep3zg/D0EV62
 0IF/i81NjBc5iBv7oXZNmY06n2wdQtoqHZrqYzn2KXX6O6SpIFin86/TrTHjYPzd
 dmxkG7udGYjGf3W6Iy6vQ==
X-ME-Sender: <xms:cNkpauRxNMthpYCgKXP8wgLNEtXdffltXFgDwicP7_oflXFRtAH9kQ>
 <xme:cNkpagFDght6BQ59tVRChn4HXwEGPX0tbRv8o4QMbq3j6YVgRd7siJdXzwJze-knx
 OTRZ_ScRg195FpZU4ACuwwx7rjI-ywYGwwAKJcY10UZToDQmTxN>
X-ME-Received: <xmr:cNkpaul2lHDL0OLW8Pxqk-R5-oAPdnRalfc9Yd4h7UHglK6TdNjOPkeIsMzNk3w94IrTNcVzAvA_dkCPwLDHz3bDtQ>
X-ME-Proxy-Cause: dmFkZTFW3PNnYtFemClkE0kevWYcyHgQF09bapC3dmL5oiICuMEp+cFyJvGNSNuJQcPrb1
 kuNA+b3omm1LtooSd/OY8DOP+4iAeqiPQltSSH+NNoTe1GIuhsVzqsRUo7vr3yyiAJRXWg
 MHA/XQo+1A+C/c0sAh7fitFCk+f7FAcbuKgVC3EJ5pseW3pNao/rHrnbIG50R/2sxCLW9r
 XDWKjzZWqwaCH508hCHO0E3sN2dtB9+DTIZx8nhxDu7rmVz9D2xLDzaWQ4js83lZT/KrEK
 l/vcVhNaenTM/THuimqaxkHvUgjvbicTt/Rrnz3173hYmOn/mP6OqT7iODbMlqesKqhlhb
 clCQxDqDo4QOkD8pSvOaqis60pdB4dCSFOBI+ixPDV6rbktLOuSTkF8UiNT4pZRclKCJ32
 0aqBanKyJgs6H6cBq+dhdO7DQ3eHYBxgqAxSBnAZu2SNKqfsFtvmAiEoFqwE7/mWhGQakc
 lrxO0dU+Myl+NzjxRxZQP740kQVfMyA8XNJyOILUBjQTR+KAeZMeQaqiJhFX/7ZN8qqMnY
 GGPsMY0kPq97P6RSSfXEimrASx2TYoPZ/q3SGO30jyXOsrW++ZBNiHNbbOapUGV4zozzDo
 lJyrB0N3098Wp3NgJ1Fiu74SzSljYxjynGX3Q4jNaYOPOh3AQyWSw/Rs0Wdg
X-ME-Proxy: <xmx:cNkpar2Wa9dffj1VplwlKxdUBtFrZx4PJwR2m_-qczHxMDgKfBSXWQ>
 <xmx:cNkpaqTywXJm-oY6joCeb-NrxskJzpVc4j9zCkP_RU4pIsbafa8qUw>
 <xmx:cNkpatvwnStctNMlp0IFFIxfearKUdqWN1KgxTNM2rxLIobY1CkOVA>
 <xmx:cNkpavbMTlZbVR3gjrbw1lj8AcfYAXzUAtii9m5JCzZkmfyQTWa7Tw>
 <xmx:cNkpasRAcuC8Od54XAQeDlwyNhVjqrqatYFftz9BupQeE9kPV_uym-EE>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Jun 2026 17:38:55 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org
Subject: Re: [PATCH v3 0/2] ring: replace use of rte_atomic
Date: Wed, 10 Jun 2026 23:38:53 +0200
Message-ID: <Id9SztE5QbOa15kPgbPqLg@monjalon.net>
In-Reply-To: <20260610184701.657769-1-stephen@networkplumber.org>
References: <20260602171552.686349-1-stephen@networkplumber.org>
 <20260610184701.657769-1-stephen@networkplumber.org>
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

10/06/2026 20:43, Stephen Hemminger:
> v3:
>   - rebase and squash patches
>   - keep original code for x86 single thread case
> 
> Stephen Hemminger (2):
>   ring: split single thread vs multi-thread cases
>   ring: replace rte_atomic32 with __sync builtin

Applied, thanks.



