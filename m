Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8140BCD98ED
	for <dpdk-dev@archiver.kernel.org>; Thu, 18 Jun 2026 13:09:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4FCEE4027F;
	Thu, 18 Jun 2026 15:09:30 +0200 (CEST)
Received: from fhigh-a5-smtp.messagingengine.com
 (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
 by mails.dpdk.org (Postfix) with ESMTP id 569984027F
 for <dev@dpdk.org>; Thu, 18 Jun 2026 15:09:29 +0200 (CEST)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfhigh.phl.internal (Postfix) with ESMTP id C1CE714000CB;
 Thu, 18 Jun 2026 09:09:28 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-03.internal (MEProxy); Thu, 18 Jun 2026 09:09:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1781788168;
 x=1781874568; bh=46y3BzmTG7K2AgFLuusU943Vkuw7A7Fbfc/quJauAYk=; b=
 CdcyLR4b4M5pHWCQf7/mv/6uHE/K2iEfpcdD03UZJTko31yZeGQXoSmZbPvK4TOE
 3prTiu4nSDwV/OvsJtuMkSYq8pgrtB4oSjS5kVBtbNsG9j37oUym1eVofLvH1HHQ
 pQxIcRuH2zOvtD1LAgLggHNn04lhQKFS4nL+e909VYeQw8m+qqXzdVYW7M3Q7fIS
 EfQk13ip77A6ZltUqZX+0ruh/wkM5tkzWwGvEvZOVbSqJoeStIE2e8bqA3n7oxKG
 v29TRnwYIuUj1sE/5Zfs0LurA4TOKfKnPC1NSH6Ss6/wULGbK1Ee/WlUMQgZ0Yj9
 4e9g5BwiTXo42WsvjNjtJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781788168; x=
 1781874568; bh=46y3BzmTG7K2AgFLuusU943Vkuw7A7Fbfc/quJauAYk=; b=P
 A5mm6TXrZGmEUlqQmUd8mRQ/WekB2hQBA3IsR4XzV4dLiiNoFHS2qQlii9D+X/jP
 jsPXyq0vFvqi7qAxND39hLiWxNYNQ5kn27W+3ao27jnV/pgTeNt1FYhgdVzSK1BD
 a6r3CUFuU31WV28IXgeugfWySNsVvSkE5HqaLHXsMARvhWXi445b0tFRPOW91sks
 UXIwDIxsGHLoLBO3im8qNIMsLfz3Rkn6rYMYDw0pSCIpRYG+zPHgEW/DLVQAXqtn
 64a40kLzWBO0IThokSQK+TjYi+PLfGBAhSGLKZlFaKR+1T5GARIBQ9y4u3OeH8rH
 eE/PAKaRfbQH+yhVJ9/7A==
X-ME-Sender: <xms:CO4zaqBjwDFHfqF4JWTbswGjpWsCi2Kp5MNlp8K0ztm81PHeLAboGQ>
 <xme:CO4zag0Yl2FGpFUHXOX6Lz5kUPYRDvhcxUhi1sQH3OTqiWeHGuRCnILeBnJO1W2px
 G2wI-U5KlVSRMI0GBWPDBDIRNWyjm61hv7tdOGTkmAqmZf5glOnUA>
X-ME-Received: <xmr:CO4zagX1682pNSNoPWNBVOY8A2qEQWgWnvwFPKv_1o4m6QoAqnEqBlJG5knys0NnJBzKz2Rq1nqSl_0IXdYXniHleQ>
X-ME-Proxy-Cause: dmFkZTG3nTaYaDz9zp6xpHBeaJSnrvy7IO4DzJq8tWJ04ZQ9Tme8TaXxP3Gc/3h2TCKet5
 I5c18kNkdWdeYCLzO4tSk6cPsbbOJrMUmG/mhDayy1ZDKw4EcyOYKQ/FbQ9+3x7AH1bbtv
 nf4R86iLrC2Q1d7sd6k4DjSLtP52zGGV8NCXTjgpAEz9sGKhxNLFdPj7KuCBIu90u/4Qfq
 0NWQKArMbjJbc8O5uutI4Fmpj+U9Q6yIfvOdMqPreBil4JBRSY6yBzacq4zmiFSbShEz+K
 pkKXw4VnPczustADgD0Rl7N38Cz7528NSyACpSq0SYgijWdKKFKY6fluWD3LrOpat8ISnI
 HSI2Qlb9W/69bD/5Fokza3nJJEnlLQkIWa7sqAVno+y1gvz/Jj7x3t+e8Dj1wuD4MFq/9u
 lokYfYvOkp8jKqnGoClxO5dRkB+FvFhwkn+PXWWxFHpk9YYALfJkZLgn0lu5Ru/XpzfRzy
 4LNqG1qj+B4h3FJwhdQIw3b1DOWynmKbz6/p4IvikSqnMrBx6Sa4jeOPTG9I9BgSklfMOY
 Ntuxj9T0NSnvy1ZtNpYY6vAptCigZZ53soSngVtHNuRe6wpq8vpzmofFUxFa2c3r34jqSv
 NzUWOzBeglXfsosm8C9Z/7FEX6P9+Vey54kWkjUr4KiltkMKhmuTM3tBr+wA
X-ME-Proxy: <xmx:CO4zaqlwybpv7TQuYyiztss4JpBKzcANf0SMficm7ryjcHdj2lZNag>
 <xmx:CO4zaiDEESEa5W-wHZiCo_KtcW0HOVzMCl67pydzoMM1zkLkxFaQKw>
 <xmx:CO4zaqeKH8A_KHpS7p5t-rVZlyBVYPLLe24tJKKlmi_RiS_LWhm6Mg>
 <xmx:CO4zatKQurHT9fkC0C0BHHoI5iPNAWeVfglo5gU0ponJWCJ_IPovvg>
 <xmx:CO4zamADKEONStn0LWvUz8H597LQfOcsygYZIkD-7MpwmKzlKtgdsHDq>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Jun 2026 09:09:27 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org
Subject: Re: [PATCH v2 00/23] examples: fix -Wshadow warnings
Date: Thu, 18 Jun 2026 15:09:25 +0200
Message-ID: <8O2RZEAQRFmFxuSLYQeVYg@monjalon.net>
In-Reply-To: <20260407151732.272195-1-stephen@networkplumber.org>
References: <20260407035209.650419-1-stephen@networkplumber.org>
 <20260407151732.272195-1-stephen@networkplumber.org>
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

07/04/2026 17:15, Stephen Hemminger:
> Several DPDK examples had -Wshadow disabled via no_shadow_cflag in
> their meson.build files. This series fixes all shadow variable
> warnings and removes the suppression flag, so that -Wshadow is
> enabled uniformly across every example.
> 
> The fixes fall into three categories:
>  - Renaming function parameters or local variables that shadow
>    globals (most patches)
>  - Removing unused function parameters that duplicated globals
>    (dma, bond, flow_filtering, ipsec-secgw, vhost, qos_sched)
>  - Simply removing no_shadow_cflag where there were no warnings
>    (vm_power_manage, bbdev_app, l2fwd-crypto, l2fwd-event,
>    l3fwd-graph)
> 
> v2 - fix additional shadow warnings only visible with clang

Applied with fixes noted in the thread, thanks.



