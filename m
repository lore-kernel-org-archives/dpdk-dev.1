Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 861B0109E52C
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Mar 2026 22:53:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C605340FB5;
	Wed, 25 Mar 2026 23:53:14 +0100 (CET)
Received: from fhigh-a1-smtp.messagingengine.com
 (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
 by mails.dpdk.org (Postfix) with ESMTP id 09E0F4067B
 for <dev@dpdk.org>; Wed, 25 Mar 2026 23:53:13 +0100 (CET)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 8EC681400223;
 Wed, 25 Mar 2026 18:53:12 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-02.internal (MEProxy); Wed, 25 Mar 2026 18:53:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1774479192;
 x=1774565592; bh=N2QJgVou3sdF+FVQvMPeQp3LXiS5/nAAZGRjNLRzXvA=; b=
 LxpgBm9/KVMqaJTjy36jhN2biHjOo1IaodsrSvuCFL+L8kz1GcP49ZY26fojbgen
 QFR6xvq5Qtg3Y2F8YuOlpSFGN6Ar6PQeLAGzi4xbqyVVFIiCvt8pcM6Z/BXVryJ7
 OI7gBikc4pqt1GStI1NPyqESnHANB12mF7O+BGUDULYN9SCQeuD/x4NIucH6Un9b
 jfXGb0u2opUGh85n7oSebDI1iepWg55qR7n18VC9YjCLKZ9KZ1YtW5x3tf0xFbN6
 VozwMO3XvUFxZGnF+F9cL8yNLmkWifU6DGMY4uY15JPpJmV5UkYTOwDuwDdsRzbZ
 HVb5TPyq3RquQgxk+6XvAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774479192; x=
 1774565592; bh=N2QJgVou3sdF+FVQvMPeQp3LXiS5/nAAZGRjNLRzXvA=; b=S
 bif9E5qYXQG9vqtOQUXtihNu0RI4fksqhiJFSCvXLWV2aVkTVXKx+M+/e2Ak9Rg5
 +IEY4b189CV4Ewyi7ZxO1S8blCCjpLfNbIwHRgNWhYjy4EUvxtBkL1pveOEU4mrF
 5bDQXuxnLDzTnnmC2SD3p8CIYTfrX9Bpc2xlGr7gyigpyseO8emXjIv3mIe1uhdJ
 k3t3DZbKqDBwac5Y+HhiQhZmSskgAGrmdm7cqQNR3nl6NbiKLpuALzLm7YTj7INY
 YJBM7l4XfnOHWMkC2SNhzDQvHEvhRMEwFXLuY5fzpWqmW7jkn+TokRBDbMStPBVz
 qv9F+dOyOxc8J6UtAwFdQ==
X-ME-Sender: <xms:WGfEabmzeRGy8B4OC3Ow9Zh04hjzxkmcKaVd4i2nhbpj2bl02afgvA>
 <xme:WGfEaaQJbDMeLmcHtEIG9vJxWCR0uDp2oLc8uij2hupq2TgViiGskIvKdoEgnpsJI
 NbQjpVifSE2zS2qtO2iF4euN9TUAt-8-FKYMZp3gqO3ZkK_JFw>
X-ME-Received: <xmr:WGfEaVKGxJjpIj4ZFzXS3bd_wXFKHNpEpxeguLvbq9gVJRQDzkPjotkA3FP5LtSeaCfjNiVHan7qGOS4ERBP97p5hQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdehjedvucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeekfeehfedtgedtjeehueeutdfgleefieevkeeikeelkefflefgtdev
 ieehheffudenucffohhmrghinhepughpughkrdhorhhgnecuvehluhhsthgvrhfuihiivg
 eptdenucfrrghrrghmpehmrghilhhfrhhomhepthhhohhmrghssehmohhnjhgrlhhonhdr
 nhgvthdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
 epshhtvghphhgvnhesnhgvthifohhrkhhplhhumhgsvghrrdhorhhgpdhrtghpthhtohep
 sghruhgtvgdrrhhitghhrghrughsohhnsehinhhtvghlrdgtohhmpdhrtghpthhtohepug
 gvvhesughpughkrdhorhhgpdhrtghpthhtohepphhrrghvvggvnhdrshhhvghtthihsehi
 nhhtvghlrdgtohhmpdhrtghpthhtohepshhhrghiqhdrfigrnhhisehinhhtvghlrdgtoh
 hm
X-ME-Proxy: <xmx:WGfEaYDDH6d2kEmpDAloauJ4nR9eAWx1S5Cejl6mxd92cbH_XdcQ_g>
 <xmx:WGfEaWDQPY8glwlVMmRaKpAHEIf7y9oysxntWMDOHtaG6cC5YyOSJA>
 <xmx:WGfEaSAjqWTliajLzwLwAOsWS8qN5TnK_WOZzc5T76-ie7NarXbsUg>
 <xmx:WGfEaZpxKChdrTAxfL4g-3AfvgTp-4UczhR78fSl2EF2UvY1gzeuIQ>
 <xmx:WGfEaR_TNrJKZ5Wc9ILmxMdG2Iyd1KdPuGHM12Hfd7N_sJSjgRMr64wA>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Mar 2026 18:53:11 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, Praveen Shetty <praveen.shetty@intel.com>,
 Shaiq Wani <shaiq.wani@intel.com>
Subject: Re: [PATCH] net/idpf: fix comma operator warning
Date: Wed, 25 Mar 2026 23:53:10 +0100
Message-ID: <5357397.CbtlEUcBR6@thomas>
In-Reply-To: <abLwiikMS-apNzCP@bricha3-mobl1.ger.corp.intel.com>
References: <20260312164344.957967-1-stephen@networkplumber.org>
 <abLwiikMS-apNzCP@bricha3-mobl1.ger.corp.intel.com>
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

12/03/2026 17:57, Bruce Richardson:
> On Thu, Mar 12, 2026 at 09:43:44AM -0700, Stephen Hemminger wrote:
> > Fix comma operator misuse warnings with clang compiler in idpf that
> > was missed in previous change. Shows up  when -Wcomma enabled.
> > 
> > Fixes: 57560a92167a ("net/idpf: add AVX2 Tx path for split queue config")
> > 
> > Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> > ---
> 
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>
> 
> Yep, this was missed because the previous commit [1] was on your tree but
> not applied to main, so missing in mine. :-(

Sorry I missed this patch and did a similar one:
https://git.dpdk.org/dpdk/commit/?id=b3b8301dee7f1fd3e6bc8c2d79fd6f6cc04a7d58




