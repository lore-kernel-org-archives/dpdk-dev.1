Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 681E6CD98D2
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Jun 2026 09:17:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9E08642F63;
	Thu, 11 Jun 2026 11:17:44 +0200 (CEST)
Received: from fout-a5-smtp.messagingengine.com
 (fout-a5-smtp.messagingengine.com [103.168.172.148])
 by mails.dpdk.org (Postfix) with ESMTP id 73EA84026A
 for <dev@dpdk.org>; Thu, 11 Jun 2026 11:17:43 +0200 (CEST)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfout.phl.internal (Postfix) with ESMTP id E70DFEC01B1;
 Thu, 11 Jun 2026 05:17:42 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-04.internal (MEProxy); Thu, 11 Jun 2026 05:17:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1781169462;
 x=1781255862; bh=cUdK3yrktgoyT1kZqAxQXptVojTIGZSx+s1RGfIMHos=; b=
 FpHtJGc6DYfEh6zo5VQ8N1tTfX5c8o2LeabNG+KbuwryDgQXbvkzDLQQ23U8ilqy
 ykToBLif34l8s/FSymip9xjL+FuPZ8iiGL4bvAImNOGxFff0q853dMaDxf7+OJS9
 URCRefpS4r+Kd+d9Qp4zPDiPoliQ9S4CPvmJGbO9lVHNvZFfYCILQFWD8jPSqzL/
 mPMHxFqwG9U7UxhYCBg4o9opA2apsKD62GB20Y+OTsEOHm7LqUC3QkDACA3HrK5g
 XxCBioRndL4WdHmhwDWsAgWp39/6x653IW/6C59vFcZe28ouc1BzGFGfcCh+yl7n
 7cfjTlwpV3uha9mbc3wZTA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781169462; x=
 1781255862; bh=cUdK3yrktgoyT1kZqAxQXptVojTIGZSx+s1RGfIMHos=; b=f
 efp/MaXoYpHid1psI60VIBD4hAPwVJ7cXnzw7DE3IDL88ITUPooNFh1PKnyob/OV
 /aQyxCkrDWhk6ogSu3QT0qZJO3q2pQ8UsrB5RWylqXmqc9fvBePg5FSfMfRLvZkK
 8uYj8i/rpL4CI6x9609kXUzsZwvUSi+YEir6E0FkCj5MV+CjirI78EpoVKcUhQGd
 M9Ol5jljrcPjrDRLOgsdNr36qdFHSI3rcQizes2lh/uxn7xuf/B+SqtTkLMcdYhi
 Lr0lPac0jiqb0qtWTXVkiQOTccH8y9N5NuNLtjBKJs2J4bJWazNTv467reBE1Saz
 YiU2kX2WzpBaEochD2sOg==
X-ME-Sender: <xms:Nn0qavdPsxoODAnuKIM8U42zTAnyvHY1qv71DYPCezjv1aHdixcXPw>
 <xme:Nn0qalV3dmyzqqrniFfjReKAxHgDZkID4X7XddzifNrbMfQ9jInJV8Tvd7bc5h9qf
 sAxoJPNMgECrbtKNZUPYM77kd6esP09oO5riBmAkqcKGmwEC54O>
X-ME-Received: <xmr:Nn0qagc31sPbnlxwM50DcgB9Uvp64CT3kFPHCvkMNTRIqpRMT_aVKrmzgPiTf6uMI6kFjN3d6lfHz7m7DbgZTIcNeQ>
X-ME-Proxy-Cause: dmFkZTE2d9o8LAQuoGdlLtmEPwCSFmKW+f0M/2X8cXdno3RQnD+ugCh9uoMYSiwcUX6cm8
 5qboCCwcHZpzdsOpclWkaNH1nTviOPhhW5yqehTVfzv9VtT+hg/X++d0y6CIffbwjFdy9w
 ofDwbUOMYiKp9P1NBGioigCpIHFzGLzPIeL5S6qfSa7haDyKlmGUZbVjPSL1QXspY3WZtP
 nX4yjk0V4KgTPeS84rPFQcfI3UYsgE0vc+BthDgUEblYZASw3/lCAzRAuy8Vw5oL9zirr1
 AuXko3jsBKR/XvtN0I/M1J7p6SXw2GEEFY27k3pIbuE32wfMSTDzj5w5R3UQQKln97FyK8
 pCw6m5SQlQK15/PH1CpIyo6cnUymrrHEV4Uib3TGIFHEUvLLuiUwM3/5vBM//Kf43Xt0Nd
 5Eni41VI1PrjCUalnX5PhKQLcQOBNsqso2bcHt1Y0KTBCfsXJgO6Q88WypTEuSuMZWtnUn
 bGWk1ABMuEDiyLRkJkh13l2/etWBrMQuHT6jrWrDFYK1I2e6frJ4uRc4RrK/H5WLGnIbj+
 pXR1WNKQRUVrxLID9Hs1vvDYtQrMOI4clft18cwRlRaV+W4UhXKgTkr8/J77JjTrPRZj4D
 lv3GCR6pC4vyS6Is9UV0DadK0dJkIyczFVy5qw9g2fJS/wJl+0EMyYtz5hyQ
X-ME-Proxy: <xmx:Nn0qapN4SAfrO1JuhL60InX8CDT6hYHowoGLfBSKLO_l_HuwCLTwjg>
 <xmx:Nn0qamh2nUU9KWayDvE-nFn6f1rNRwt5Ry1RMgatru1-AfxiueeN_w>
 <xmx:Nn0qak3obE2BP0O4g8XS867a7pT9SsBH_oqoCt8dVYLJRrp16DfLuw>
 <xmx:Nn0qaohMUWqir-B176Ljm7FM5RefAZ7YfXOBCJEhcXsEGmpPxH_mbw>
 <xmx:Nn0qaikBJsLBfYLFld1Zn4-6Kv9a5cKnpPBuESB0BfngLVJm9bUYxG7r>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Jun 2026 05:17:41 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: =?UTF-8?B?6K64546y54eV?= <lingyan.xu@metax-tech.com>
Cc: dev <dev@dpdk.org>, eagostini <eagostini@nvidia.com>,
 =?UTF-8?B?546L5Yas5Yas?= <dongdong.wang@metax-tech.com>
Subject: Re: [PATCH] gpu/metax: add new driver for Metax GPU
Date: Thu, 11 Jun 2026 11:17:40 +0200
Message-ID: <CNjXKdTGQx6A6BPVH44M4w@monjalon.net>
In-Reply-To: <f4c779a6-8bff-4fda-bf76-6ddc3df6d4af.lingyan.xu@metax-tech.com>
References: <6c18e957-c1c2-4b43-9b2c-b36424c1e9af.lingyan.xu@metax-tech.com>
 <J2c1Ke4gRXqOUlr2bqZFPg@monjalon.net>
 <f4c779a6-8bff-4fda-bf76-6ddc3df6d4af.lingyan.xu@metax-tech.com>
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

11/06/2026 09:10:
> Both libmcruntime.so and the corresponding gdrapi libraries
> are proprietary user-space libraries provided by Metax.
> They are not upstreamed to the DPDK mainline repository.
> However, please rest assured that the current patch interacts
> with them via standard dlopen (dynamic loading) at runtime.
> We do not link directly against their source code
> or require them as hard build-time dependencies.
> Therefore, this approach will not introduce any additional
> compilation dependencies or licensing issues to the DPDK main tree.

What about the kernel dependency?

Are libraries and kernel module freely available for download?
Can you provide a link?


