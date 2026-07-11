Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6834CC43458
	for <dpdk-dev@archiver.kernel.org>; Sat, 11 Jul 2026 12:43:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 474784027A;
	Sat, 11 Jul 2026 14:43:20 +0200 (CEST)
Received: from fout-a5-smtp.messagingengine.com
 (fout-a5-smtp.messagingengine.com [103.168.172.148])
 by mails.dpdk.org (Postfix) with ESMTP id DCA904026F
 for <dev@dpdk.org>; Sat, 11 Jul 2026 14:43:18 +0200 (CEST)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfout.phl.internal (Postfix) with ESMTP id 46E07EC009D;
 Sat, 11 Jul 2026 08:43:18 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-04.internal (MEProxy); Sat, 11 Jul 2026 08:43:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1783773798;
 x=1783860198; bh=u+ahP11zawgapAnTsGUlPR7M2OWmS5ZKig6rg2x/nes=; b=
 IzomGalvApdMfi3/bpdiGKkgPVmipWOsXXh96Z9ltQlak8bC0mOX/P0UBLCvSfiy
 vFOxZQz2zKzt1Hj7HI2q+SXJ/Be5qq4HZ62p2MbMbHUe4os2waoMFV7cvweWuWnv
 bb02Wn9DPxWzfSsrM1Lk8l+aDxDsLoVS+G98xyiIBlEMbup77fyoQpq1U4ZTB7fs
 KqM1YIXljudHYfBrZFE5r6b9eF44ZQLNqOySot9iHdU35Urc1seBJ0D0T4qlXfv2
 K+s7PrFaJZ+jWYNDjwKBfDiQ4U1gZZ926gCxPf0Pw9QmTEgVy+tUTZ/Y6z5+WCcj
 mN/g0YbgYhqO3nPmCSK/jw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783773798; x=
 1783860198; bh=u+ahP11zawgapAnTsGUlPR7M2OWmS5ZKig6rg2x/nes=; b=J
 WKpg4V5cWggJHVHTS6/Pf3H6lwJ8h7mpD8Ky9h1PYulwvk05P2oQXk/+88S2TV9o
 9N9ueiGIbfjcnKIBMB8Xh31Ill6etgc+2vWr7kFEBGsyhqGr56KNszJmHCBh6x0S
 l5nilwEN59bHCNcgmAXbyH87H426whG4WVPu/xI3/B1gS/khSN0fC4zwNvM+T0B6
 PKV3CQUXgP0oLlSFnQntiEp5MlD90/CjAPOvFqXKDomBfD43RT2zu6zVczBgPrB9
 vxD/KdgY+hdw4S+MAWNsoJ6jKQ/5ko5qNOd51GtbnbDHyId/YgQ2YD+u6vFGGAUt
 KcXVHN5ogdFlTcQPpSRrw==
X-ME-Sender: <xms:ZTpSanSMhOE3kSI_TTaHdg4FzJJp084jCTxNi2EuMOfLd4YG25QLRg>
 <xme:ZTpSao6GITkVlQy4GMvDRPVTQBZ0YFgt89HD0QKt1YKcLbgT7zz-867ZH1QhW_v4r
 D0cD8ZQf9nbaqiUn66Xoo3NhYlwwShpgLXAX9tqYDPb_TwlcLb50tA>
X-ME-Received: <xmr:ZTpSakzo5A43_LsO686wfdOCk0zJiRrtNgTyQocwVMw5wUUx8Jduo3RM9_9sBuYc0zTX8Pz7e6Mc92TFIw>
X-ME-Proxy-Cause: dmFkZTFUkrlksw9gmf6T+JAqjgHdHjs1zzat/LRqr9mWVbN6YF551Te4SdAD1VUPLplnyp
 YfzwC6hdLJEjESCZLmUtnmyE/QxQ2E0L0TA6bFfZb1YNvEtdW82pojNZyIYz6r6T374rss
 kFiSEJJS/xTtnVTA4wAoOsAzvhHXXEUJbluSwyTNK0bYzWa/nwqRP4ieB7QyhX4suitkFL
 ZzIzGepUzgzYkEXfs39W8iONdZsVqVv1nVSDbQm5RfijZPdIhBYhotzGaRqF/qydptj04V
 93IcCuAzkr9wxPNaMPzTcC4bySu+0dD2wZNaMJi5GtLcpVu0YFWwKGIh3+8U3V+PsnZ/ZD
 Scaw15WT1pOEQRhT91Dw8LScUlm+cB+XYjRpLygQIS1JJ7yksfyPYks2Mq4sVDx+GkKLpk
 KzIJx3Kky6dKu/Q7olLeFiZDz72B35N/+korzWxcUvF/bInyw1fTf6SwgfRbV5skSivxsI
 KY9qqr4sS/me61WQy6868ruwyNK1VY5dj3J1ZskIRUH/ldVP+TdVv69kYV1czSow3p5jKm
 ELbJ3SiEzYa0HqIyXnLsJKuH8sAAFSOig69lMGNi9Na5TfaLUxR3woucnWuCyL0od0uotM
 MVSJo9FU2zqGfDMl389FZQ3/FnqXD2N279aprTVs1h2TrcSCD2edBnS76sVg
X-ME-Proxy: <xmx:ZTpSavTwaXHC8dl3pyGruWVBd8Wd9XSrReSpgM8ho6i3nPhxggxv-Q>
 <xmx:ZTpSarXdcJ9hA-vE40AInalbt2aX4NWQKkbjajLLYcPrRY500LBekQ>
 <xmx:ZTpSahYSO3wKsU690-MMhARlOyj2Z2Lhs2oTl-EAjBoG191Y8uYVAg>
 <xmx:ZTpSah2t72R3PuBfEmsdW2ExWiuv8UC7QZEK-yOFqXRnl5BvgJYIuQ>
 <xmx:ZjpSar4SDn6QQ5VRp55F1fmILZ58ih3-LfyL9_29a1N0s2JsRIAw-qs0>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 11 Jul 2026 08:43:16 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: "dev@dpdk.org" <dev@dpdk.org>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Marat Khalili <marat.khalili@huawei.com>
Subject: Re: [PATCH 1/2] bpf: default log level should be NOTICE
Date: Sat, 11 Jul 2026 14:43:14 +0200
Message-ID: <wo2ssBMRTh-FiqoEB7SO_w@monjalon.net>
In-Reply-To: <35e932e0908a4326bc4430ad947fbcfb@huawei.com>
References: <20260701223453.104660-1-stephen@networkplumber.org>
 <35e932e0908a4326bc4430ad947fbcfb@huawei.com>
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

> > BPF is used by other services now and the default log
> > level should match other libraries.
> > 
> > Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> 
> Acked-by: Marat Khalili <marat.khalili@huawei.com>

Series applied, thanks.



