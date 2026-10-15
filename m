Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAF5FC2D0A6
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Oct 2026 17:58:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 09DF04060F;
	Thu, 15 Oct 2026 19:58:56 +0200 (CEST)
Received: from fout-b4-smtp.messagingengine.com
 (fout-b4-smtp.messagingengine.com [202.12.124.147])
 by mails.dpdk.org (Postfix) with ESMTP id 0678A4027C
 for <dev@dpdk.org>; Thu, 15 Oct 2026 19:58:55 +0200 (CEST)
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
 by mailfout.stl.internal (Postfix) with ESMTP id 5EACC1D000E3
 for <dev@dpdk.org>; Thu, 15 Oct 2026 13:58:54 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-11.internal (MEProxy); Thu, 15 Oct 2026 13:58:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1792087133;
 x=1792173533; bh=BGLAGEqFJuNVYcGxNrXztIoDVfioIxdvE9BjLFkIvdI=; b=
 UMjpUpuznSWfCKt7LYYBLgwjPnykulmEy8TH7qMgY/KKOIkIx1nUnEoqpYiTcgxX
 RXNV0loXVYTjkfsdfh8IzwSy4Rx96eSclv5bhIi79d/m9U1lqpeynZk6R/YS18ea
 l6eLfKNeLlUEF0o9ZKHSIJKyn6wp9hRXi38DO60moyhh909YNyYPAvgb9ulGk6OR
 AAJ1Xeyd3zLEehIHb1zddDK4wjq2p1ke6xyRRVAIPvQbQsVMkAk7bQJpxjpDOYS4
 FbGJJJLc+uj6M8ofs8Bw1H5wnO5V9K2qsQJU3Z/N2XEfD4QDWAsRDKq6V3DrYTrk
 9+I8c89rxQV1qTJ3HOw9Ew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792087133; x=
 1792173533; bh=BGLAGEqFJuNVYcGxNrXztIoDVfioIxdvE9BjLFkIvdI=; b=b
 0AuhB/gL42Mn4g37ysQtlSPdakHFtn02xOLeUlfdNKMZm7/GVp3x0Qy+lZv0ln56
 PU/yDKgB25FBHg77250JO2KZwAhSX5OYksM04xFM7IhyoDTCtar5+SEXhqayr62O
 j5A7cqseMpbzcvhB0GqWSrKoDyDu8YZHzlQUeBToUBP/rMNnMGULkXI+lSWfuujV
 AO6jnrc5pwYxBXZOFtwHM3j6h1WVAhi+0e/psv9m78S/qnVII7AYm1AYul7vln9B
 IZonXiZeHYEPLGENK6VnapwTg8fsdCU3dD/3KhRzP4OtKtxQUNEgf5QhWVRMmkYk
 LrZOvDWgH7Erd3kk9c8cQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
 action=sign d=monjalon.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792087133; d=monjalon.net;
 mf=PHRob21hc0Btb25qYWxvbi5uZXQ+; rt=PGRldkBkcGRrLm9yZz4=;
 s=fm2:rsa-sha256:CXRYvH/IfZSnQUmif2HzM/uX50ogDHjT/P9CCi45+FIPHEx
 lk254GYCtSzWPYooX1bORF2pbsu/lHa9EnUkbhxOv7If7QjzFgwFutzBTlDchrat
 V2TfQuRHRaYanuEFzjZWBdDD5cbLzry7x4yfrMxLN2fK1GRu7JcB5GB1EyBO43UO
 eVzGWT7cX//NdzHA02Mn1Dg51igOgJ8trn2NG00+hFVAS32gVboU2xPK3dLTAW1q
 EyQL4ev/5OJzFWR1Bd4NJloAIYjS9Dt1a6EqmN2edXEhk1FOR16sjzPW25NY0IA3
 ZiVw7fLo3Ch1Pj7FxWJz2okEe5tt484OgWk37rQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:QXhRqoT4TSAShCtatTL/fbT1K4O6PWXBUDPPj60zDNQ=:Lx1Sk+k3MDpV4Ek1EcGy9bnW/txZVqj3XtwvxPiYwBo=;
X-ME-Sender: <xms:XRTRaiOyRMYMUm5iJDpSiXuID8wF7nPMdWwhTJyfwxdETcVFycxH8g>
 <xme:XRTRalQ2J1NMUQYitoPoSyWnZtWecI5EcbBA0iMRAsLnip7kAmV08qY8QIoBwbCey
 QPiVsTcYK4lk4IQ-_nXsB_E3WzLEvW0oaAZ_vjGxA0p1REOygrCww>
X-ME-Received: <xmr:XRTRaoZMhmtqwf1QTHouPmi2BbP_pc2eEMZA0OfDqw6n_1Af0-kojmMUAN__3p6v8yH6tJc3kcn1l3lhRrI6cWs>
X-ME-Proxy-Cause: dmFkZTFdBqqOIov0Pax6UyUilCIFCrv/yuZs7o9m3aAKiaKDxowFjvsUe1u4ppU7MaPxIt
 gd1fXFvzMlTcN8mkW6UEcFiVccBZAiqCx/+STUQ/EBLX3QvzFKTNDFVvpXhaUZPk1DRyva
 WkegBeupT6eBWvODbAFHH6WgiF6vXeYPE8reuMhoxT2jxQCm6kBjWahc46YW03zX52dFAO
 Xyx+jdnt6v3cF2POirjXTG+iAUWwyNZFxsU+MAvu62QXr/j6O/5UO32VdQt19OhG7sNj7S
 WRniBd690Ro42i8LaToJEq/lw6ZrQJTBLWWa+Z5j8RtdZIZUL0f8kLmVfKdcEdt4suo9b6
 Rh8m0zeMEo/IvSLZH+Cw1654qgzGqJNjj0hbVpd2wdK+u/0nAePc/JqyUHlwvIoEB5Q0oM
 X5ZDjUb7n3RUi1G9hyEnoPj5bC6YDisHaSKgcXnhNBSwfPcyHot0DC/128ZVcYJJA7YSDd
 Je389c7rIRBPeBoRam2mkixC2WxkToyOgtbeC2ohGDJCq6/wJ25wk58q19g+cUIhZOhh5L
 syR75WPa9aYDQiQ4zK91OH2iu6pDnpSDkBNZeAP5alZ8ngGhZINK+qW3AlPTP9srjWsQAc
 Zfv912t8Zn2gdlg+IMYWEECVBPnfRUDZzjAQQOlIcS1W3/HsCOge0L60ud0w
X-ME-Proxy: <xmx:XRTRaq3wSOLXoHIR3nKUDgU4OyYJnb5nNBBJinIkeXen6KjtskJK8w>
 <xmx:XRTRagXwQ_veg8iXrpzZwmHG3jXfxkHaFwot96Q1NHstL14D4t4GqA>
 <xmx:XRTRasUz-Ihf1YFDW8fI5GY_oMl1xzLgIrOEw99ALnF9QD8rF1RBZw>
 <xmx:XRTRaneELkr97ZT8WZLFiXfbtLMk_XMEKwtPSHewI0BmqROjL4ktow>
 <xmx:XRTRatiQHBFS01pbHIzIdB8sZorcGbhr6Nbb_7ELoGtBR_UoVF95u4OT>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Oct 2026 13:58:52 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Shreesh Adiga <16567adigashreesh@gmail.com>
Cc: Wathsala Vithanage <wathsala.vithanage@arm.com>, dev@dpdk.org
Subject: Re: [PATCH] net/crc: make NEON CRC folding logic similar to x86 SSE
Date: Thu, 15 Oct 2026 19:58:51 +0200
Message-ID: <GJFovAQ8QlWVWCchQGJUYg@monjalon.net>
In-Reply-To: <20261006151833.347561-1-16567adigashreesh@gmail.com>
References: <20261006151833.347561-1-16567adigashreesh@gmail.com>
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

06/10/2026 17:18, Shreesh Adiga:
> This patch includes the following minor changes:
> 1) Use TBL based shift left for variable len shift instead of using
>    vshift_bytes_left which adds a switch case for 16 len cases.
> 2) Align the fold constants to use PMULL and PMULL2 instructions
>    instead of using cross lane operands which requires additional shift.
> 3) Remove unnecessary static arrays used in crc32_reduce_64_to_32 by
>    adapting x86 SSE logic.
> 4) Use x86 SSE logic for processing partial bytes sequence to avoid
>    using multiple variable len shifts which inserts switch case.
> 
> Signed-off-by: Shreesh Adiga <16567adigashreesh@gmail.com>

Applied, thanks.



