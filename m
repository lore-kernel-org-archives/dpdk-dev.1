Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12FBBC9832F
	for <dpdk-dev@archiver.kernel.org>; Mon, 28 Sep 2026 09:39:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EEF124028C;
	Mon, 28 Sep 2026 11:39:49 +0200 (CEST)
Received: from fout-a2-smtp.messagingengine.com
 (fout-a2-smtp.messagingengine.com [103.168.172.145])
 by mails.dpdk.org (Postfix) with ESMTP id 8877E40041
 for <dev@dpdk.org>; Mon, 28 Sep 2026 11:39:48 +0200 (CEST)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfout.phl.internal (Postfix) with ESMTP id F1834EC00EF;
 Mon, 28 Sep 2026 05:39:47 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Mon, 28 Sep 2026 05:39:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1790588387;
 x=1790674787; bh=6t2prxiBiMl1xHqSR3NM3hkUBcHj8aTFnbMq+BpGikA=; b=
 Mwc/o/hd1W/lcroFZIWtn9jtXbGZ9u/TW4S8j0KSh4rBicYdSgkxZF7rUdYA2F6A
 ofgEfLESsoAIyDagqqNv3fZN6FWbvWtUl51XvSklAl7XmVoQiIfZiHwPifIC3qle
 ERLS0qHU99mInWisb7wD6KwHSmKTxx9s7MNAsTJqB4T2VO10lMuc1D4sNm0wh66s
 4g70f/CBC/7SszKFUWod9IaF6U+L+lY0MBBtUO/z82E0IpmU4zUPu2Ks0v5X5Nk7
 PjKJDF1P99egf/RBW6Ji7A6LYsUBtUt28Ua1TDnh0iYfxFgnwFQ5yYgqLRTb+Zhe
 IJu/C+oygU+6/c67NF4rnA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790588387; x=
 1790674787; bh=6t2prxiBiMl1xHqSR3NM3hkUBcHj8aTFnbMq+BpGikA=; b=A
 bjx0PKLw1vOUVra8E/WMXEkpMC6yFTdqtBVhK++Q/kdQfxyNvjw9IlR5O4X17BLI
 GJ9G9WtnYU+KNqz9BU2O6YSyNDiKDQoKJtl3eya/YoxiW2dOzRi+xI2qdHAc1RMK
 QIBX3bzjwFccBojsZTbMdGg19v23YRXwxaR9ulVBGMBxHi2zpfh44eZK4Nq4ZgqI
 jjJOjrSHaCnL/URHly0m2jAiAt8iPSUQY2mhaE4BvICi9IJaQbokP9mSznSp7VOc
 D6uag+z0ksOyhtyOXUf2y2zKyEPjcuRNqyWY4r60evEVWKLwXkaGkrowDiUk4lDL
 ArYLWNk5pPBHQlYa1QZ8Q==
X-ME-Sender: <xms:4zW6av0hW39NRss4rDrS4tuZjKbvUrsE0X0He-80U1iWRdGbvQvN0g>
 <xme:4zW6auNHJOBie1X8JVyc1o_n9Jm7VakPm0m5ABXzcZvxmrOUzA_2Wb0h1mWi1kdfj
 Xu9UZZKR47rQmmXxVpB4i_feP6fwf8dJvHqraVxIkwW0LUV1TjnWWY>
X-ME-Received: <xmr:4zW6an2XH5UT8OK342Lme6nD5fLElpYcHwTr3gBez2sXNf4p_NCfCyc_5vdvJMbqaIVNkSx4O9pShd3HK_byebSq26dPdp8>
X-ME-Proxy-Cause: dmFkZTGa8ePKbO0kpwCc3BS6eRQ+JETcut5HcmFhB4najUVcfKhfihRqOAq8xI2YcCwKSJ
 maAxDvsUJDKWDa6AbnFtIkqyiz3Tgzanh+zLiq03HySpidgUxjEo9fIPHvP2gWSPegVof7
 hUVhyAjhXOWR4iG5qfsAFKif9tJ7v0viiP1JzDnIDqYH3ifZg/xXHm6cBpqFOxYnAnhOEf
 HviY4eku3SWuj+r/sFhhxXj4Ou4o+gC1WKdVFPeVvh+oRUa7bSOoN4D1DFJSKpPlMKkoh2
 xd53ioaM0Xw5x+xrscdFomm7tbaNyt/eEQIuhwDaSEgI7nIRgrxfbZVhcmF8MJpx5LflQv
 KupnmZ409scp/WANy4mXjYRLsHxYDKRzsTp0ry4E2VMABpYS1i4YQ/MSv9p7DG7xv4CIjw
 N46t/cR7FUFwx6AoOXbbGiZ7pEukIt2Vy2BwUKUDkSqd90ADd3w0Fjvqm+CgVF8VRXwctK
 RngJIeP7O9hgWBef3l4GbfAxCMtKFk9fZURl/qPwdoiQOxklXd1Yx6ttqodnRgoUBL0pLK
 LiEpPuQ6pJeS5wW2iurkPvkSllyY7Wae1HNPSCvvfy90AjQYoVVaTBc1oKTNRUjyHnL65E
 Pows1WSWVfJyZ3ZUtW95ihlbhUbbZIRY1k/if6gO4X1d+c9mPZ2BHx7vMhsg
X-ME-Proxy: <xmx:4zW6atGO-FDaKmH5c-450ccfO44OyATuiv_0Ktz7jlPRBwLaP3cdHQ>
 <xmx:4zW6as6iuh4u7mwkaPd4TmT1FMRRXudOgePBIKJzVodbCevE9T8CDA>
 <xmx:4zW6artzxFY0YTwNnhFzuTjHoy0lD5YU9SrwwSUCRFBKgLbnwR4QXQ>
 <xmx:4zW6al5-RPmaoiGbDb__9FEhF9zA9iTpsjHdvp0j5SMCm8G9D55_FA>
 <xmx:4zW6apD3j9L819kibdM0bSfwRgm2uVu_cVol_xScaNROwPNcHJ8fQqvA>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Sep 2026 05:39:47 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Su Sai <spiderdetective.ss@gmail.com>
Cc: stephen@networkplumber.org, marat.khalili@huawei.com, dev@dpdk.org
Subject: Re: [v5] net/cksum: compute raw cksum for several segments
Date: Mon, 28 Sep 2026 11:39:45 +0200
Message-ID: <-qRgDz-RQ6O5ylFSYw-3nQ@monjalon.net>
In-Reply-To: <20260708071742.94924-1-spiderdetective.ss@gmail.com>
References: <20260703074132.2a718abe@phoenix.local>
 <20260708071742.94924-1-spiderdetective.ss@gmail.com>
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

08/07/2026 09:17, Su Sai:
> The rte_raw_cksum_mbuf function is used to compute
> the raw checksum of a packet.
> If the packet payload stored in multi mbuf, the function
> will goto the hard case. In hard case,
> the variable 'tmp' is a type of uint32_t,
> so rte_bswap16 will drop high 16 bit.
> Meanwhile, the variable 'sum' is a type of uint32_t,
> so 'sum += tmp' will drop the carry when overflow.
> Both drop will make cksum incorrect.
> This commit fixes the above bug.
> 
> Signed-off-by: Su Sai <spiderdetective.ss@gmail.com>
> Acked-by: Marat Khalili <marat.khalili@huawei.com>

Applied, thanks.



