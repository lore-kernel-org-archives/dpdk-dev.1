Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98A80CD98C7
	for <dpdk-dev@archiver.kernel.org>; Wed, 10 Jun 2026 23:21:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8CCEA42E81;
	Thu, 11 Jun 2026 01:21:48 +0200 (CEST)
Received: from fhigh-a5-smtp.messagingengine.com
 (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
 by mails.dpdk.org (Postfix) with ESMTP id F108040298
 for <dev@dpdk.org>; Thu, 11 Jun 2026 01:21:46 +0200 (CEST)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 814021400010;
 Wed, 10 Jun 2026 19:21:46 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-05.internal (MEProxy); Wed, 10 Jun 2026 19:21:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1781133706;
 x=1781220106; bh=6oPxeBAwFxrd8KBkvLYfJ0M98GSTa83R/cxZdqvO04U=; b=
 Ne2nQHPTcjTdud+mSvaFtQDEu7R/vubAXpORr3X0LNIDPYG50W6BUn+JTkvM9fDd
 Yeg8RJ91FosRRrR+MKdMBx2m/pUHtRT1c9ldN/XQMi7ptA8Y+ZpnFKwGQpCpDkjK
 tNalzbRnjjlt941359XS/EyOz2UBuUkmW2GwbCS8hPKBoa18M3I2smKOrh6iuUtP
 4L/xPUpdvyuc6hb92DmTEMVU1Blq9vP0A3t2bfeJb2U8zn3tk0qPpU7w94FnPrdg
 FEzlSE0Dyh2ye2/MOFNHVvGmRleDSY2Sf8maSv0Wk86NNz6qMtGUoU4ykgws9x2t
 hrSQfPMl4+Eh36M1zgAFUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781133706; x=
 1781220106; bh=6oPxeBAwFxrd8KBkvLYfJ0M98GSTa83R/cxZdqvO04U=; b=L
 /W1HOmvRbFH7ZL9FE8tULlhAB48ygqQVFgFMHhbOa2upAT2rkAoouTkNzQo72olg
 2i42xA3hpCnSiNSOJzlC30vV5KPqIAq2xcRx2vOoE78OnLfnhb8kwu+HWiRYsiqX
 P/VMEwuElQxa0FX+RUbamf2vbEgos0/GRllLXbgAk6VoIotUFWWYGOGN1fa7eHhE
 wLdY1ptmVvtmNGgui6bz4E4FFTlx/5JaRd+f1+cGslvp6HFJeQ0rYwcuEam7Txnu
 3IYPQGHTxTkLZSJa1Gd0HoFwsAILytEumr1wNjaPdHLPKE2UdcLVNiwRuyRRrZn/
 UBRY0VKKE099h+Oij3vmQ==
X-ME-Sender: <xms:ivEpalUSiu7dX5ABQTSPCnrEQaXKa4P9IisUGKeyIqUIvhkUhvFeqw>
 <xme:ivEpatOHeK0fa7L0CrYWH6W-WtcKHLBoTH-VVKKbfbnfb0nTVpRqhqHH4SoG5agLw
 SdhrQ4bWje2fClJjzGBeXXaH7JtSeFQkPnwb0jErKby8MfyZzE>
X-ME-Received: <xmr:ivEpavBhRuUURXRW_-CqrSrqejXaKzwWucF0XMrlsDgpjMyDQNCAHEtU1i-Zy-XKpLvQONAZKBznl3mLGptsAumDLw>
X-ME-Proxy-Cause: dmFkZTFXUolHDcUwr+vhI/BEGBG0FpQEF5c9tBZm1+gLkWV5KUuGMr0QMC6FYWFw1GoGNL
 I2sYFNAiEjnSUQs2Me3pTYg74nOBzFOEb9VhfYKRjg1tdmNyNu/GJtEyaPT4u3PwevI1Gs
 Us+Ab+p/264f0ncx7YuXAockE9kZfMnpByQRMfPzhjIzQudVXEpjjMShgRohC0RfwQ8bd+
 PUjdO7FtPTG9wE6QqEh8SUFzYl3ralIwQz8ZrvzmIXseTv74tIlL3KNyGazFY9OWXMNplL
 jPp3pobf4WEgXyOUxRM/5zxPKOAJHyJrciPJweO2F1A56WsNx6LvwXDrOmYPubEgtjKcac
 09nyoIx5rYVV9AwRUFfQeKL2/r2v/5bFARq3+0KuiMKYEJE++FBgoN3tjGSX+i8A+9mT5T
 mKHzRK51JdJ9viHJC0SgUYUxdD3pk6b5B+htarX9v4MuHxO91+AEva2rZCxdQKq1/jJhOA
 mQc4kZoCoBJvabUEvJN36xhNXhWLBzZgnXpplHrYOO7AGYvXcK+fgWAUHAcpC6zJLtOQUX
 Osr2lLpP7MTYAM7Uej7LndhURUBPDILeIwMNLwFJuD3y+e/pJ4B9tD8BF5QKaUUMpOPXTa
 P/SPVm+uyQCr8uxe4phMQlOCiFHxVb1kh31eeBBuq2QbXaVH52gZge7/sKSQ
X-ME-Proxy: <xmx:ivEpaicRwtcKOw3V9KjUa_CYiyu12nbCi6e9lWwppEscHLSJ_Mqh0w>
 <xmx:ivEpamN1508wEv6RFfx4ChgdrOjKYOvfvQsLUHI_zItkI1TR_mABQw>
 <xmx:ivEpaqJ7hjK3w3FavA5gnIS24L2vnx1eO6CDb29jqxXlL7MGfLSyiQ>
 <xmx:ivEpauItZqwN1bqQmQFAmeMiUv_D_9LtzrH9ecrrL1yeM9miIfcSwg>
 <xmx:ivEpak5ZUZLVlnKNPJFY6rkZgKmsLTI6-DwE0OoO-FbwZmEv0bzMaJ-r>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Jun 2026 19:21:44 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: anatoly.burakov@intel.com, sivaprasad.tummala@amd.com
Cc: dev@dpdk.org, stephen@networkplumber.org, fengchengwen@huawei.com,
 yangxingui@huawei.com, zhanjie9@hisilicon.com,
 Huisong Li <lihuisong@huawei.com>
Subject: Re: [PATCH] power/intel_uncore: reduce log level for dependency
 missing
Date: Thu, 11 Jun 2026 01:21:43 +0200
Message-ID: <dQ0rmtYnStWh1Y25AHZRlg@monjalon.net>
In-Reply-To: <20260512013047.375535-1-lihuisong@huawei.com>
References: <20260512013047.375535-1-lihuisong@huawei.com>
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

12/05/2026 03:30, Huisong Li:
> When run dpdk-l3fwd with '-u' on non-X86 platform, user would
> happen a noisy print as the following:
> "POWER: Uncore frequency management not supported/enabled on this
> kernel. Please enable CONFIG_INTEL_UNCORE_FREQ_CONTROL if on Intel
> x86 with linux kernel >= 5.6".
> 
> The root cause is that intel_uncore driver's .init() will be called
> on any platform when use automatic detection mode. The function in
> intel_uncore driver will print above log on non-X86 platform.
> 
> But the existing uncore core cannot solve this problem unless break
> ABI to add new callback. So reduce its log level to avoid this
> incorrect prompt.

Any comment please?
What would be the right solution?


