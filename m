Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A5EDC44520
	for <dpdk-dev@archiver.kernel.org>; Mon, 20 Jul 2026 12:06:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 54C3B40290;
	Mon, 20 Jul 2026 14:06:50 +0200 (CEST)
Received: from fhigh-b7-smtp.messagingengine.com
 (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
 by mails.dpdk.org (Postfix) with ESMTP id 73DF04028E;
 Mon, 20 Jul 2026 14:06:48 +0200 (CEST)
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 3BED17A0012;
 Mon, 20 Jul 2026 08:06:47 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-10.internal (MEProxy); Mon, 20 Jul 2026 08:06:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1784549207;
 x=1784635607; bh=AmgEMIt1nI+CRYbrw8lxXWJ2n9z27YOutGb3Sq51nDQ=; b=
 ip2e/NHLhK/mSMVZrlhGNg2Nv05LvQPJr29/Scv1EKrCAukbeqyv3JZhe3/QJJzy
 SYmL+9tBix2NdDEXMHr/07hvz2Vmwx093hPkkB3c4BNgUi4aNk8Mm0djgQLHCWlL
 DSpqBOTuspOTjJiT+DJz/zmbe/8HZrNwQhswfm/C588IKQ4YCTuMktzMIY7JweRn
 iMme1ZFg1Vk5/tlPQ28BJCF2czdKGBZAYCbH/wBasVG+eEfuVOEtXcfZG1JZC9eW
 k9Uy2NZJHv1dAkl373t7bffp6sSXU6GO+rVQsVCgUFgaDKNZmUyl6cfFW7vR93Ep
 v0xOtYMPCKSKUCc3ujIycA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784549207; x=
 1784635607; bh=AmgEMIt1nI+CRYbrw8lxXWJ2n9z27YOutGb3Sq51nDQ=; b=D
 k1Q8k/AqYMLNX8gTKgKhsRsx31i9KuIpxHorqLqD8aTQ6kexmx3i0I0qAgqWQDkx
 47FULJt1Aeh7C8y/oW/oZtBqjTQ1K1NeigeMh91rzGBA36S0mn9bUVcN/3MkgMpY
 1QJq1R2ZSqAB0IT1LpgrrcjId3+fRHBBsj28PND3zOM/mCXt4BZE4slpeObEgxja
 njVL4+f1FCI7jT0Akflw21P9HttYZFd+XqMbD8x0I6F1l8k087qAyOfqgSHYsumX
 ztagdQfQLq8p4NhebOUkIiPaBgWM8TqSwrBvp9rKCIsgI2LneJLg4pLQx2KZvt0w
 iMWQI+aomOXeKAMsgJpCQ==
X-ME-Sender: <xms:Vg9earAbRUmUrkwN8NOBLlZL4M0__4VMVyP4IrFXhXwophfwdOq_oA>
 <xme:Vg9eah-gLoHZ14mCH0cNmC2OdwLkViNWmQjPBMEFGEyqrvkxaIICMXPqSSuQDS2RI
 Eh3nFaSpS5MIAxkrF55D_ohqcu3KUwITXWs4zKAznhYWUDlLu8SJao>
X-ME-Received: <xmr:Vg9eanQDUSzpu-5p8d-yhqzALRubT8f2G-BsiSTRI4IFtWDBpl2Yev06jLPUvpZ_CB-S2aiBBss3YRrDF58zkrb_4-GuxsmY3EIM1JxDvHKc1bKJa_NPGQ>
X-ME-Proxy-Cause: dmFkZTFesTqZQPecyTQXzGIkohPtfjp3Bxm2/6jqthv0xQpqn04HUNB/ntagmt3yMKbdhQ
 CP7UTlBk+yIb4rXgiozrXcOuT5RGDUFYiZ75ggYtY1qyx+wF9uEdGgzxPl3PpwSPjpgFVt
 8xgjvQaZGHTAfbQ53H9IWkKE4vkox4KMG3zbgXW/chb4vo9XCoEWAv4S72Sa4dj+KkYT4B
 56S1aNTSKTonqwWdKduHwi3A1GlQtv2OgN45GJI6J0oNtBsAi8kCVuxxI0zRw3r8Vattrb
 +ZHLicIeZDsiBrXMTe5kHktOY/DVEwRZYAl263L/DfkBdonTja8V7D4QAgAm9o4sOnRYV2
 nf8G/VnDs8tzxzUSXPfQJZep5BxksciZ7qOxDsKKXdq7iGo44K49PgIyYJphlKSVuJrBm9
 MWMBUAgJNt0L3/Up165RLr6mFrotzJTPxU8cThraKn7nOg0LIbg7Ys+oRWARolPpWOjFSK
 Ui91N+eVPcMDXpZtavgjHVFfNelOjqGRKdqgfzDD5vxVASf5mZuY13fzSL8ecCXJtseVsy
 pOPn1PxUggxtYO3COrbgG139rfpeUzX4gGV1oGhbC+MG8RAwu5sB4j8Hi2/mVu0tMtd+Wa
 zHPEsQUS51fUF14bfMUlm7mpoVpM5hLBcXPxgg+KiDyHZAvt9b8Fv6q+oPag
X-ME-Proxy: <xmx:Vg9ealWXVOZ4T4JwKmuZgYEPH1__D00pCbn_o8lDqFDIWV7jpH_7QA>
 <xmx:Vg9eahQG_b1MWV395kmk8ceINllxtnBl30e_vjQ0FKhSPQLVKnUSDA>
 <xmx:Vg9eat2PFltOVHe_5rMFzLPps0rYStRqjfMIaHafL3YNclSWjIj8Bg>
 <xmx:Vg9eahenta_llmCb4yeq3uVVKBs2yMzNwjMDtinqkznbYmDtPKR3ZQ>
 <xmx:Vw9eap8sZ8xVM4IhBhfSxR8TtTYW8YPP2SV1b0fH8-QpVvwo0ZYEMVU6>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Jul 2026 08:06:45 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Pier Damouny <pdamouny@nvidia.com>
Cc: dev@dpdk.org, stable@dpdk.org,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>,
 Matan Azrad <matan@nvidia.com>, Banoth Saikumar <banoth.saikumar@oracle.com>
Subject: Re: [PATCH] net/mlx5: revert fallback to Verbs Tx allocation
Date: Mon, 20 Jul 2026 14:06:38 +0200
Message-ID: <pqH0lM66SsCC0zN2jRaFcw@monjalon.net>
In-Reply-To: <ekuco7abfynbgdovhotzbvbgynu3ldld65jlh7cpxwl4iz2amj@bzdg33appnnl>
References: <20260720114929.2998238-1-thomas@monjalon.net>
 <ekuco7abfynbgdovhotzbvbgynu3ldld65jlh7cpxwl4iz2amj@bzdg33appnnl>
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

20/07/2026 14:04, Dariusz Sosnowski:
> On Mon, Jul 20, 2026 at 01:49:29PM +0200, Thomas Monjalon wrote:
> > On Windows, DevX CQ creation was failing because
> > of a different allocation fallback behaviour.
> > 
> > Fixes: 4abc12b9331c ("net/mlx5: fall back to Verbs Tx allocation without DevX")
> > Cc: stable@dpdk.org
> > 
> > Reported-by: Pier Damouny <pdamouny@nvidia.com>
> > Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
> 
> Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>

Applied



