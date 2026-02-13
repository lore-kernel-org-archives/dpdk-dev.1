Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86AD0EF99C5
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Feb 2026 18:54:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C52DF40687;
	Fri, 13 Feb 2026 19:53:52 +0100 (CET)
Received: from office2.cesnet.cz (office2.cesnet.cz [78.128.248.237])
 by mails.dpdk.org (Postfix) with ESMTP id 1A7EA40687
 for <dev@dpdk.org>; Fri, 13 Feb 2026 19:53:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cesnet.cz;
 s=office2-2020; t=1771008831;
 bh=UDx7c9Ejs1dEWGxraVG+v1tj2BR69LZXcDGiTWInJt4=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=LwtFSuwnK4CxfsEVGVsS8DEnc2dzQH8IV7hm0s2UpVE52rQZCLDxBG1HuvgZqR0go
 z3D0Y/de3nQEk11J98dlA1kfAatKivBzUBoNUxgUnZMgsyk5X2CK8yGl3cXfUpFcpf
 ClrIrtQvQf59CwiA3sePMER9J7tN7+HGOnCCOp1xXMfn/Im+kyml13d0UN5rHtm6UZ
 od0ri97Npy8ElVaDl6cy/n5FICWlmvFf0q8ZlhQgsv/42UMvdDxGLHSyp0mci/bMaG
 5tXHe+ww3o5d5q3Uf5+pUA1HfuM9ZF6o6K0VkxwwEPAE/6U+UTyWO5fpsUCu1hR0Kn
 biEanCB6utY9Q==
Received: from [IPv6:2a00:1028:83a6:8aa::305]
 (dynamic-2a00-1028-83a6-08aa-0000-0000-0000-0305.ipv6.o2.cz
 [IPv6:2a00:1028:83a6:8aa::305])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by office2.cesnet.cz (Postfix) with ESMTPSA id DAD641180078;
 Fri, 13 Feb 2026 19:53:51 +0100 (CET)
Message-ID: <cafad66feae8a56023c6a0a46ab70a7baf887354.camel@cesnet.cz>
Subject: Re: [PATCH v7 0/8] net/nfb: rework to real multiport
From: Martin =?UTF-8?Q?=C5=A0pinler?= <spinler@cesnet.cz>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org
Date: Fri, 13 Feb 2026 19:53:51 +0100
In-Reply-To: <20260212103554.25cdeb4e@phoenix.local>
References: <20260115151656.393106-1-spinler@cesnet.cz>
 <20260204123137.123171-1-spinler@cesnet.cz>
 <20260212103554.25cdeb4e@phoenix.local>
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

> Improved the AI review process and it saw this.
> I think you should fix and retest before merge to next-net.

I've retested patch v8 on hw.

> Patch 3/8: net/nfb: add vdev as alternative device probe method
> Warning: nfb_default_dev_path() used without NULL check

This is false.


The main problem from this thread: Double TAILQ_REMOVE is fixed.

Other issues were yet reported by AI in prev thread (also fixed).
