Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A136C43458
	for <dpdk-dev@archiver.kernel.org>; Wed,  8 Jul 2026 15:48:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E269F40268;
	Wed,  8 Jul 2026 17:48:09 +0200 (CEST)
Received: from fhigh-b1-smtp.messagingengine.com
 (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
 by mails.dpdk.org (Postfix) with ESMTP id 29DAF40265
 for <dev@dpdk.org>; Wed,  8 Jul 2026 17:48:09 +0200 (CEST)
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 5332B7A0097;
 Wed,  8 Jul 2026 11:48:08 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-12.internal (MEProxy); Wed, 08 Jul 2026 11:48:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1783525688;
 x=1783612088; bh=q8pCio9tYe//Kmw9nc91kUQwJ/XaVfQnPY1p2UTWzFk=; b=
 aajFtUurlYKAKAUuiHzskiX+ov9Eyz5luiJhC5fQudOM95ViyepQxevwWK05z/io
 /EI2BqFTym4bc1cAEpOwnOuTD/jFxKXdA0IYE9MdVYUr87t0U+8wM7fVLjPLVRUJ
 tR4H88rZFFnvO+dq1oC/qabv1QQGaCBXIaDgeMqVOdvmlc5jp2PpuMUW/lwN96Ib
 x8RG6S0/n4KiL6bC8kIt2L/LfvZEM53+doKq/AJcQdUMwKozGaevdiIyKvH93dor
 wNkE8acvldrJHwx4c6PdcdM2QP0z8Mj27CrHmy2FnxP0H3jRT9Dt7AM/os3KlelB
 /hs643a9mAgU+fP5TmvWiQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783525688; x=
 1783612088; bh=q8pCio9tYe//Kmw9nc91kUQwJ/XaVfQnPY1p2UTWzFk=; b=T
 D178um0OxclEYj6nBLCAa0PIv4DOhwl1sBCsB5E+LNyyWweealz7yvp+HJ4pLBdw
 BvLipQJHCQqHlxuv4c18cbJmrARuf93AmeVEuYRHZzAWGSE6/Z6qJvhJEZ3gJ8OO
 5+DTbqHJXHHnjmkEMrs9fyurJpnjoj5xRcpa4v2mhUqf8QNgB3Pz4Kpt5OsEGUKg
 Y1MYnCM2tWITUktUIISG+NktP8Fq07/s+1DwVwhKTP07Y/Pl/T/XT4N1WU3+DN85
 eePnyPFn0wDFHBsYKuPLIFFbnYCrGMMG0QROnE6D2qRRAF7PoUgHCnf6wxCB+pQJ
 h4IrF7fWM/j50IXVO/FcA==
X-ME-Sender: <xms:N3FOaptcXPctotj1sJmNKgNdYP6bYgTXHwjpA56BtoY0s_b3-wPOsg>
 <xme:N3FOaodP_u4vcpTONJYyQ0W999-7bw99VcDC3xWTISlqQ6p6srawK8m3t_v5Qi0gL
 nXIJEUgRhTfYfFQ5hfxw25kGtw1G11hoQPYJi47Pou-fmSZjX9n>
X-ME-Received: <xmr:N3FOaqYceNRzlQyny84xt0qTrO4FV8ldJazyc8jMELqIfFoNLZ1XDaFcw7Gad2pbjFxF_88IOxq6cCEZmu6YEEAp8w>
X-ME-Proxy-Cause: dmFkZTGEmIb1D1SONjXPFEAdQZBFugedA4vvxwrIgryjvk8hbr4xdGl1f7N8BFxz6akgQ8
 GSIG45UA0i790PwLyZCRnYCqDpC/0SWh4n7viiCMdAbZ/+Mb7EEkhk8HuXu8Rw35VVd2jD
 wY8L4W9y5wNfrs0bqXrfPYQmP8ACSEVqZVL+TB2gwWCZWHwON3UnyMws54SUeDkPTDEhZv
 cYWIpYqoWa4qBhSH0cQParKjuQISmvDVMPCTArQZs9pTk1iRlWSgwmFEJL+N60gyO1VYfZ
 47QzPy3nu/inqS3IiuF+/5mezZhm6V9C3+8mdzt5Ix3gGhLqsRYlqVYdESD0UcEfHUGObG
 1QszEDBn0YIiEsbPzjuPJ2N/zXznc+4SF/3BzeO0T12i8dUlJYNnA5yG23DoCb1j26k/RS
 uArxaA8ZnhlHbRtLpWha0YrI+pnJCqs3muxMUHXkB6OnU/DulLiji5Tp5d/o3nibsqsydg
 NlOGMEfEskDg8thmRTtPK3nkAGsV0CeZmVYWax1JxH7PUQSLlAeAVBppXLTjfLhoMVsDLJ
 Ma2AvRJJ3NCPx8zKsvGpuEP33g07OiVXJZxLFdT+Mr/msN3t9nbRDc6ynGMNOoyeczEaX9
 0050sH7SSdhS0YwqHoQnSiZPHZCLku28HUWO3zMed7/aTFV8B8lZjEfSdBKQ
X-ME-Proxy: <xmx:N3FOarWfw-VkdAOaXOsNTXmzaI2WnXCR39aR2v0pcYzWQcAAx0E1Cg>
 <xmx:N3FOasgbarBF410OFNHMmGnfCrsKt0qcxo0azb3nChR_HcEJ6NORkA>
 <xmx:N3FOapVvGxx7g2IXRPBy8yM2sYAKMumTSAEy6W9tRVphCUOoFoFgdQ>
 <xmx:N3FOajMT34yQZbpRP0HMTEV7RkG62CRf0fgD_grdHk-dHqYvvPnV_A>
 <xmx:OHFOaroZH6jXhOsn-T_VgxVlacCpzmqayAdUAV9QzzkLxD02nXiqWEdu>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Jul 2026 11:48:07 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Lincoln Lavoie <lylavoie@iol.unh.edu>
Cc: dev <dev@dpdk.org>
Subject: Re: DTS code coverage question
Date: Wed, 08 Jul 2026 17:48:03 +0200
Message-ID: <py5Ntr2DSbud_I-983p8ug@monjalon.net>
In-Reply-To: <CAOE1vsNCkhZ8q7ieRAGbJZTFg+xUsjBXXOmegXdoG6L24-Y2HQ@mail.gmail.com>
References: <CAOE1vsNCkhZ8q7ieRAGbJZTFg+xUsjBXXOmegXdoG6L24-Y2HQ@mail.gmail.com>
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

11/06/2026 16:29, Lincoln Lavoie:
> Hello All,
> 
> We have a patch into the 26.07 release that will enable generating
> code coverage reports when DTS is run. The community lab can then
> generate coverage reports, like we do for unit testing
> (https://lab.dpdk.org/results/dashboard/code-coverage).
> 
> The question is, with DTS, tests can run on combinations of NICs, etc.
> So how should those be factored into the reporting.  We can do 1 of
> the following:
> 
> Option 1: Collect coverage reports per NIC / PMD
> Option 2: Aggregate (combine) reports from multiple NICs / PMDs into a
> single report
> Option 3: Only run it on one NIC / PMD, assuming specific PMDs don't
> change the coverage much.
> 
> Is there a specific direction the community would prefer?

As discussed today in the techboard meeting,
we have limited number of NICs in the lab at the moment,
so it's probably better to start small
and focus on the libraries coverage.
If some NICs help to cover more library features, let's combine them.


