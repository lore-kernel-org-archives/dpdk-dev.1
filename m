Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4B31EF99DC
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Feb 2026 20:13:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DACA2402C1;
	Fri, 13 Feb 2026 21:13:12 +0100 (CET)
Received: from office2.cesnet.cz (office2.cesnet.cz [78.128.248.237])
 by mails.dpdk.org (Postfix) with ESMTP id 182AE402C0
 for <dev@dpdk.org>; Fri, 13 Feb 2026 21:13:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cesnet.cz;
 s=office2-2020; t=1771013591;
 bh=ztP6f3gw+qxyC0cDAkiPb0G/+BkG5fvSzaHyUCBQwtU=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=k8QrCrjOpP/8Jutv9Q5a1t0+v1CHLdrjkdh8ltgEa1X9b7q7O3B7c1tmRhDfqvt4O
 qmadn8ihr5zLPfzUeSubT93iPlld84Z2hLslXGoZafTj91H9/DeKVS2KWD428F2zZS
 sqQM6LwP3lDBPZbhMgP46ya2eXunE850Wi0wbtQA2rN7X7s80uQDez5wSsCZNaTfzu
 JD0tYpZSMxyCTagfHBnLSjGg/LE9mgeHwYt5Z9x9tr954ujTgMsa/RAuEUOft+ugG1
 q2wZ9BNruLt1bC2TkrQugDdmkUqgqrrs5vznDss2FJhXGSESt6WrpDqRXqzvO3y/+b
 /0hR9jvFbAiSw==
Received: from [IPv6:2a00:1028:83a6:8aa::305]
 (dynamic-2a00-1028-83a6-08aa-0000-0000-0000-0305.ipv6.o2.cz
 [IPv6:2a00:1028:83a6:8aa::305])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits)
 server-digest SHA256) (No client certificate requested)
 by office2.cesnet.cz (Postfix) with ESMTPSA id 9C8DD1180072;
 Fri, 13 Feb 2026 21:13:11 +0100 (CET)
Message-ID: <14ad7e724e063013992ae338b3cab5d2bdfb173a.camel@cesnet.cz>
Subject: Re: [PATCH v8 0/8] net/nfb: rework to real multiport
From: Martin =?UTF-8?Q?=C5=A0pinler?= <spinler@cesnet.cz>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org
Date: Fri, 13 Feb 2026 21:13:06 +0100
In-Reply-To: <20260213113947.4cb4aa30@phoenix.local>
References: <20260115151656.393106-1-spinler@cesnet.cz>
 <20260213185317.1893353-1-spinler@cesnet.cz>
 <20260213113947.4cb4aa30@phoenix.local>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
MIME-Version: 1.0
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

> There is one copy-paste bug (found by AI review).
> I can fix that during merge.

Oh man, I didn't notice that.

> 2/8	Warning	__rte_internal / RTE_EXPORT_INTERNAL_SYMBOL
> misuse for driver-internal functions

The missing __rte_internal was an error for AI earlier (some drivers
use it too, but rarely).

So if your final verdict is no __rte_internal,
I will remove that, Okay?

> 5/8	Warning	err_map_inconsistent error path leaks
> already-opened MAC handles

Oh no, again, missed that.

I have to fix this and resubmit as v9.
