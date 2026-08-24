Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 041C2C5DF81
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Aug 2026 15:47:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F37D440698;
	Mon, 24 Aug 2026 17:47:20 +0200 (CEST)
Received: from fout-a6-smtp.messagingengine.com
 (fout-a6-smtp.messagingengine.com [103.168.172.149])
 by mails.dpdk.org (Postfix) with ESMTP id 4A50640697
 for <dev@dpdk.org>; Mon, 24 Aug 2026 17:47:20 +0200 (CEST)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfout.phl.internal (Postfix) with ESMTP id BBFA7EC01FE;
 Mon, 24 Aug 2026 11:47:19 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Mon, 24 Aug 2026 11:47:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1787586439;
 x=1787672839; bh=kMkZ0Ip7qXQgpc3Uy5qp2O+0WkLRM/nTPeef75vWuBM=; b=
 JJIMHOMCYd/nlWBBs3A4+/bwDBcrOGCKiL3gzl3RuY+7Hv8GM1xfAMt4toeXcAEd
 U1i7SMI03BbWDcxxVtSIKGqEEbQkCBhYAvbc/HSIT2dcPLOcHkj+AVdJAFt8igqq
 t1zNWsWAhDNCgLWm2N7inb1+7/9ziTDBrdtsWsEK1fxsH3lppfg6XD2znlGV3mF8
 tBY5At31HMS0PDIN+t3VqORpSlcVli1HspO1nFRxIjdDeVj61Pgycb6a+PfeYG+4
 M2Zr4Zpyo+/zF/QRQaLew8IyCpkwBJFtzQr6oatcJZLtczqwr67LDxuOuf4bCb3g
 iKuE+wa7uYAXWGIg7z9kEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1787586439; x=
 1787672839; bh=kMkZ0Ip7qXQgpc3Uy5qp2O+0WkLRM/nTPeef75vWuBM=; b=J
 88ZkKd3T7kl0FbgE7eB2rnnMVmi/0gOH+eIpRt+L3zC/Az5XZriJy4kgCkec9gE9
 yTUEo9xySM62vX8EMXCOAYA8rMfoDTS+fF9faCNv5RxJAc+fzR9yUD7rZXzNjg9M
 ow1oalssKF/vmfcb5YQxdPtMU8RV7Be+Lr3n9A31fSTETefV8U66zP/6qJ+roemm
 BTH30yCVFZ1wB86+2QBcSt4Au0bcgNWDQNfGhjXdGkVz4spw1DX376pMteF4y0xv
 A9gonafl6EKsuBZ9iITBzPBD2m3NcZhntcuANVVhwn5a2tzMXkoKLb1PR71qg5AM
 WzzO/+ZuPBWIb22/8aJMw==
X-ME-Sender: <xms:h2eMah7gHYMA3nWr6dTe-Hbs_S36Fpr_UvXvAAisxntExAOPE0byXQ>
 <xme:h2eMavDhTFWGuqv2X1Xb0IovTAzINLpJuzzz9966j3Jxa0rp2Ljn0RinWq0j6lUHa
 zN1wcVVMnoIiW8wpRp2wsLrFIwxSkuCvIcbfM3UzhlLXGYj0R043ks>
X-ME-Received: <xmr:h2eMagbdzDtUh68DnsVeIq8fvWeNFiey2U8NrKL3kEWQQKDk-SxRDaHWnXqsBmcB>
X-ME-Proxy-Cause: dmFkZTEWlVx/WzgI1juU010AsNvLZsloRaV9dT4voYBkjRVRPX2WGbotf9CuiFbFrPN8eF
 omdFPEv+q7B/BCfvVoK/M6irC7ty9Ib6t1zghXbvWwVV2zsRxsX1aVzPfcQlw9tq9iKSK5
 dUyZPdu8XHnxF+LU5qFdwF0CC3uEjdKjYrpuPvPGRlqr8uTqCqcDhuRQwUJ0pkGN9YZ4jx
 IwoXxrk11wODZ4+LIXx+LZd6HQDhGmS1/oh6Gfvp+lOSxSzYyKlHT02w+kA++EjtmYo3uL
 rHFvH5AXmaB4WqjzPuPaoiqt72KS9I0y//ljYhH94HvJtuMrKhMleUb3fC+C/KYkqhOoXE
 /losuN/ZEC1Ju9hj1o8VPYB5DYQ/VxuKaFY3X4Wb9H42bKHfZs6X4qClVzLPbl3q9PEifW
 p0+FSJCzAAzgkR1OVbP8mPls69Sv/ITaNqEgvfr8xcliYCpl1ikwcpy4tKU/Oeqfm0fhXr
 /Qw929Kx9Mz3RI5XIvVDpw0UuwXSjAewUQHK8nPtcrUsatPImTfJUXlE+JeeRzEZzkuAcs
 Ic1Gmp5ikv13etBs3OFgi8wwF0lasDs+VIEAKtZB613rRF5tR8KQEEd22MC16FkbNEA7T3
 viHpSMyXN7IJOQ1lQ0iH083xR7XUphjtcrOZr5J51+7eCjn4cQXn5MpYNHDg
X-ME-Proxy: <xmx:h2eMaiZAhN04ezxvjh9sA4-W6Cja0fDOR-8YyxW9IFQ4GKQsN2Dvzg>
 <xmx:h2eMav-B46fm3ld4XZbKLVol6MKHN8qdI_rdUYlr33Rqb_J9x_gIlw>
 <xmx:h2eMapiB3bR5DIXfzWR7zAKNrHjd1nJehmpcWtu0zf9OPb4eqdHHVg>
 <xmx:h2eManfzH_oPj9nHP4OaRgnvm2rhft4cdh_U-xKQzqdKPtTvxql5_w>
 <xmx:h2eManvoAhXasc5TflJRDZnY4cYqjqytookIpPLvcldGqxuVVuwgc9XV>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Aug 2026 11:47:18 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, Chenbo Xia <chenbox@nvidia.com>,
 Gaetan Rivet <grive@u256.net>
Subject: Re: [PATCH 2/2] pci: remove deprecated catch-all flag
Date: Mon, 24 Aug 2026 17:47:16 +0200
Message-ID: <ZXWdfjrPRRuXz-Bm5UCJ1A@monjalon.net>
In-Reply-To: <20260727070210.1281566-2-david.marchand@redhat.com>
References: <20260727070210.1281566-1-david.marchand@redhat.com>
 <20260727070210.1281566-2-david.marchand@redhat.com>
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

27/07/2026 09:02, David Marchand:
> This flag got replaced by RTE_PCI_ID_ANY in v21.05.

Thank you for cleaning the place :-)

>  /** Any PCI device identifier (vendor, device, ...) */
>  #define RTE_PCI_ANY_ID (0xffff)
> -/** @deprecated Replaced with RTE_PCI_ANY_ID */
> -#define PCI_ANY_ID RTE_DEPRECATED(PCI_ANY_ID) RTE_PCI_ANY_ID
>  #define RTE_CLASS_ANY_ID (0xffffff)

Series Acked-by: Thomas Monjalon <thomas@monjalon.net>



