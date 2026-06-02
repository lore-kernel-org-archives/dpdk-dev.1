Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0C17CD6E60
	for <dpdk-dev@archiver.kernel.org>; Tue,  2 Jun 2026 16:21:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D9715402AB;
	Tue,  2 Jun 2026 18:21:53 +0200 (CEST)
Received: from fhigh-a1-smtp.messagingengine.com
 (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
 by mails.dpdk.org (Postfix) with ESMTP id 3088E402A9
 for <dev@dpdk.org>; Tue,  2 Jun 2026 18:21:52 +0200 (CEST)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfhigh.phl.internal (Postfix) with ESMTP id ADF481400111;
 Tue,  2 Jun 2026 12:21:51 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-02.internal (MEProxy); Tue, 02 Jun 2026 12:21:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1780417311;
 x=1780503711; bh=mPMTK2CVTPp7cWaF1N1gMnDX74fvEzNwjLkrO7H8g18=; b=
 MrzrnLXDRgr0yulAOR7m2hnQHokrboRGINDRVKQaelo7yzdy5hsRy37udm5d/1ra
 +y6YL1U054Of7bQ/vyP4TrhTb8lDYkS2jFLwW8Q2dMZj0BxPPtSVYOp+Cvo3nPad
 WaAcalqOmwvVMtttinzlSq0t3oebZ6sWfkknEaHtQfMUmuXxvFDr//FzH+r1Rp5G
 N9M26nksj/hexE9NVERSeYkLNqDqCE+NBZu9Nds1+8XLiXSrEHsc3RDcATuwcVot
 1fuCeOk+Et5iiUB2tJZ/KGmWg/mTyNI6pM8Y4gXMxnG4fXBCEf9f7xRufl62Qvpf
 7ipG3H7C1RjyYyTAviJ8Jg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780417311; x=
 1780503711; bh=mPMTK2CVTPp7cWaF1N1gMnDX74fvEzNwjLkrO7H8g18=; b=Y
 sBTd1nTgpOEoF/JihYMWh3VcGwljv+GDUhwu1PTZYUz/IDEa54Pxb2RdttD4/l2w
 RUbkhVB3rQUe265abaij0vG9VyBC+xjsjySeMfY3QS7ifTR2IigiBcY4F9TP22vc
 5RCCKi4T3J7dew7PBQkuhAxgKXCVyfKJeoPi9mxQTe3haz8X7l2Y//sDt9vQ15Aj
 R1XD05Trp/ab4MLa/cDTRwHyT3Vg4FzuIRoc4kNJKnqnJsaY0kJasiwDk/1XyGGF
 zujg6ziD02NGWUV4IFLbWxFvuv3XkwN22vnAOZJIxBbUx2rV0PvuyNV4kuoBRKjy
 EN8ZHbJuzKN1FGwLij8Sw==
X-ME-Sender: <xms:HwMfanNbwUKTY3nasimfItQQlz-5Hke3MkdQlMXKcpPBjn7STVyLzA>
 <xme:HwMfao8CsI-rnTXWDGf1xxSUEbjsqgEBJL4lZb3lfc67c8tHIvnxpe_OjZ9lMykkZ
 jyMKEph9t7o4X7ZpAylAeovXUFZ-BwVpKN47R2lwY5wAW4d4WOdsII>
X-ME-Received: <xmr:HwMfarSe-xsM80ilmphv_KjhzJd3UKg4ED9lkDP0k-VK6cQaovaOQadbTn_Jl_-lvvcA_pU13HxzhR5XlZiUffs1Kw>
X-ME-Proxy-Cause: dmFkZTESHeOHBYsvIp5udD6b9Jj90v5/sOvcd65T3p541vZqDEjPPaPqLuuuqt9A8ocBdu
 HUK7yi2XQrifotSfzDMJTqNCJUOSMrbj8mT6DymtxN/y8OIwRJyNpO48jXoE5IrRVA9CsN
 tR/OST2emNrOLLE0Z6JqM2mOLB71MEhooC+j9ZuYp/1TGJYGlFNVddI2HonQ2kgh37TFQj
 SxV96BoAXF+PHLjcSm0u54UoHtm5EexnQsze/hfVGIeyUhzy+FrDVd/hPfXmcbYNJfs26x
 iXZ3i3G+hvAk2zpEyakusmhCFkwPDDQ3tri3izkZZiuMggPQ6JMTM3yy+PwTlKa3YIIHVK
 Df0H+zaqlvMdI5f5tdNMs20ryRcLd8AuScbPu6KGnEdzgAAWVbirSuAhsP5tDZzgUoGyRa
 qaag/vsbDmAZz9+AuWAhocQMsfM23CPBby67uj0CmuEQfCdBAj2NM2MeNCty1TSDgS+cUe
 VS3tQGLZLXhcAXUGdpyylcMoe985boWHeMPV6ZRqOzL/agcrTbZb5wQKcj29pINRz7mHN+
 Wf22WqKoc78d52xD5FRZP61BrSOrTUvvgBjxGx8JX1BqemOzip1sv3NCFJ9XLlwXm7gB8F
 yMv+N7PndjzhJSjG49HTO43CCmymwELn0f0FXm+lnz57NQy1nyZTwfW3v8rw
X-ME-Proxy: <xmx:HwMfaqlYyDlfREbFK0EFFZ7NDJnX2h2r1zHJL1_0CBfkgwSAODLWrw>
 <xmx:HwMfarTLApHIhKf1JqbnFeB_AjqX8ovPDqSCoqJv06VdIRv3Y6G5ug>
 <xmx:HwMfaoPBunGaz_k1mRKK30N5j4pBKvADc7VuUgjsQFE2R4ekUmazKQ>
 <xmx:HwMfakUqD71OEu-tAd38GD8HSDueyxEMrz1DAWzb_0jEx6cR32bmgg>
 <xmx:HwMfauytoDJqAxwt0HAGB20hF8gjxjWX1Hvnr_ny73eTZJH8XAvYtxjq>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Jun 2026 12:21:50 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Sun Yuechi <sunyuechi@iscas.ac.cn>
Cc: dev@dpdk.org,
 =?UTF-8?B?U3RhbmlzxYJhdw==?= Kardach <stanislaw.kardach@gmail.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: Re: [PATCH] eal/riscv: optimize memcpy for small copies under 64 bytes
Date: Tue, 02 Jun 2026 18:21:49 +0200
Message-ID: <zD756IrtRq2zW5FJnS7F7g@monjalon.net>
In-Reply-To: <20251009063030.2776794-1-sunyuechi@iscas.ac.cn>
References: <20251009063030.2776794-1-sunyuechi@iscas.ac.cn>
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

09/10/2025 08:30, Sun Yuechi:
> Improve rte_memcpy implementation on RISC-V platform for sizes under
> 64 bytes, based on the ARM implementation.
> 
> Enhanced handling for cases smaller than 64 bytes shows very significant
> performance benefits, while the impact is minimal after 64 bytes.
> 
> This optimization is disabled by default as a conservative measure,
> since future glibc versions may include similar improvements that
> could conflict with this implementation.
> 
> Use RTE_ARCH_RISCV_MEMCPY to enable this optimization.
> 
> Signed-off-by: Sun Yuechi <sunyuechi@iscas.ac.cn>

Applied, thanks.



