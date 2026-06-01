Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCA79CD6E55
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Jun 2026 13:31:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2DFAB40649;
	Mon,  1 Jun 2026 15:31:29 +0200 (CEST)
Received: from fhigh-b6-smtp.messagingengine.com
 (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
 by mails.dpdk.org (Postfix) with ESMTP id 57DE24025A;
 Mon,  1 Jun 2026 15:31:27 +0200 (CEST)
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
 by mailfhigh.stl.internal (Postfix) with ESMTP id C69B77A047E;
 Mon,  1 Jun 2026 09:31:25 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-10.internal (MEProxy); Mon, 01 Jun 2026 09:31:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1780320685;
 x=1780407085; bh=d0cBVSkOCj482DiW+rKPivSUc31/JGvxLDZPIQcqIYc=; b=
 Tih/JSwkv4ykM9zXggejTMt7zPV4sIQy7fNOeD2E/hQeu56JN0//b4MIUTGhOuHA
 ZaNfrb4QLy8pwssjbWPeB1TtRElol1/GVJ7um8inzllNothQUQrCvW7aT5NrNcnY
 sl+7wVVRg3KrChiUCJ8zGs7sMVtNrGFAL6hA0/XfT7YiVKtA7yYno+2h3VwTIVjt
 sQnm5CL0BcINsOgNTiLmxNdM1S1sT3wLoj3Tex464aHMIYtb14UXm24PoViNaUlr
 W1mI3BXf88oV44yfOW3S4OOzoAX7gRAk5STlAAKwDtHS+dyo+deA9UouE2Fc305v
 O19IcthxIPFP7keKnGujSQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780320685; x=
 1780407085; bh=d0cBVSkOCj482DiW+rKPivSUc31/JGvxLDZPIQcqIYc=; b=Z
 W2OorbLVG+hiTuXr600vHp3MAm7oBA41w8tbnAU/waQzPtiP2FIeNxQagGhcOLoe
 YYNt4+FBe7mzE6+10PtdV06RYb7ZQNfvKzIaUU+FM52JyiaLAgdp6W+FMGoBITkO
 w3wB+MxCMW+RBPob71fjkccP0uapoAGoyO7Qun1HixTiOIVf/J3DkxFbtF5xRF1n
 MEhOBoUwiHpW76oaRv3NYfbdCzicmgXGCQzxUZ2cO097wHVGcS1OLa2Jg7WjvtWr
 XwVA0WuLgstsN5G27+TB9N+EgDx9FitKRsornK9sgkAAkUPX15Gs2SXNQT++bpY4
 5l2PM94tWGZfHoMFpL6fw==
X-ME-Sender: <xms:rIkdapojAfPhn94_5DLCOpGjLizm_mj5Hrts5uSrYf8uCb4OI8Yy6g>
 <xme:rIkdanHSBioteMhNx04hbfdJp3CDifnAr_LHwM0Lbj-7p4hE8z2ryPFgOFORw2SRZ
 xJx3Ir-PnimXtrWJ0Mx7Tns847PExqZ8ReRvn_KReZEyJjdntlFpR0>
X-ME-Received: <xmr:rIkdapszEIwaH4sgl3Yazsq2AI0daRDPD2DFi1GDHa5i7-QI0WzwyMXElsZGiaa8D-ADC0Ph4iYTSb-8F8Xhgnuw0g>
X-ME-Proxy-Cause: dmFkZTECxi292P3i2Xi/YCg4Qs07j/NdJTCIOd61h6VCm7d7EWFMlQx/0rVsH5RLqTohPY
 Wvidy4qa7N+bnzsV2cgAS2DT779+pgIzW8eT/Va9xju4dB0lPfVUi2tzYjyG4CldZ1G3Kw
 ukaWLQAEB6f5tzhdxi62z0OftDKjqgKylJ4JYE6Hn8l1FWVuvahbo9Lf6If1eCHuZ2nV5t
 w8VOFRhUJ80KHLKXtKJO2STA28uWarvtGzOjlr1eGGJgggSm/TjnvzZS3YdxlSBArFJ8PU
 4NInRYQYxwXoOI5Vh3eVThVUauRw8kUXQ9HR3J0bHO2579xjjrAYaAXa5sU5icnmH3scgD
 k96PKlodYeh/IITqk4tg6rRQUl8lEPEVzgJU12FK3KeYp3YKlK2toRuPXT3D89bL93a2ol
 pKfDAH6MjamJrDGrdeLTxBacZlTyXlpGfQqNVPWcDE7H3lKK7DdzWwgvMt9cowyx+0BRdI
 gsSE26m82N4T/cHdi5xRiDcGxNLsIxyFMKOq0zYLat0zfLnpku2CmYbron2g0PWW5rD9mw
 qShHLehAuQKWce3JYoOShpjs2PWdI44Vn07cZL712JcIqRylJYI289SYY0oXWJTFtDp7n1
 nhcgcX13seWAmFo6Hpi0You2XDYztppKH0kWZ+L5J7tM0B48YpKagyW4v4yQ
X-ME-Proxy: <xmx:rIkdapUhVEkmVjEx9kHayBU7fSwlDniehXd3uCg318ET0dUUFLqBwQ>
 <xmx:rIkdalG9bJ2AQhiXPh9L5SMMy239EekpVJqGAYiEIHsFOULJ6TFlfg>
 <xmx:rIkdar2LsAPD6QqT5EtLkDF-551a2YXhLSjmaO8IZL-qSYehAds1tg>
 <xmx:rIkdanMKCR02fiWerbwSVC7EvQe7-05uXyikrPJG70qjXekDanQJxQ>
 <xmx:rYkdagIDAbdNq-DOJc5aw9glYOTv-qGof5xYztaMNzWoKmIVL747kZaE>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Jun 2026 09:31:24 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: dev@dpdk.org, Shani Peretz <shperetz@nvidia.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>, stable@dpdk.org
Subject: Re: [PATCH v2] mbuf: fix mbuf operations history recording
Date: Mon, 01 Jun 2026 15:31:22 +0200
Message-ID: <yptfuIayTIumsvli3EeZ0A@monjalon.net>
In-Reply-To: <20260511133952.65539-1-mb@smartsharesystems.com>
References: <20260419221220.86455-1-mb@smartsharesystems.com>
 <20260511133952.65539-1-mb@smartsharesystems.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
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

11/05/2026 15:39, Morten Br=C3=B8rup:
> This addresses two bugs in mbuf operations history recording.
>=20
> 1. With mbuf operations history recording enabled, when allocating mbufs
> from a mempool failed, the array of fetched mbuf pointers was not set, but
> it was dereferenced for mbuf operations history recording anyway, which
> would trigger a segmentation fault or cause undefined behavior.
>=20
> This was fixed by changing how the return value from the mempool
> allocation is checked, so the function returns early on failure, and only
> proceeds on success.
>=20
> 2. When allocating a bulk of mbufs using rte_pktmbuf_alloc_bulk(), two
> mbuf library allocation operations were recorded on the mbuf, because the
> function calls rte_mbuf_raw_alloc_bulk() for allocation, and both
> functions record a mbuf library allocation operation.
>=20
> This was fixed by not recording a mbuf library allocation operation in
> rte_pktmbuf_alloc_bulk().
>=20
> 3. When freeing a bulk of segmented mbufs, the free operations were only
> recorded on the first segments.
>=20
> This was fixed by freeing the pending bulks of segments using
> rte_mbuf_raw_free_bulk(), which records the free operation on the mbufs,
> instead of calling rte_mempool_put_bulk() directly.
> The bulk operation recording at the start of the function, which only
> affected the first segments of segmented packets, was removed.
>=20
> Fixes: d265a24a32a4 ("mbuf: record mbuf operations history")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Morten Br=C3=B8rup <mb@smartsharesystems.com>
> Acked-by: Thomas Monjalon <thomas@monjalon.net>
> Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>

Applied, thanks.



