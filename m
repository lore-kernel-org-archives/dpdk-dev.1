Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC490C44524
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Jul 2026 06:56:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A5DB94028A;
	Thu, 23 Jul 2026 08:56:39 +0200 (CEST)
Received: from fout-a2-smtp.messagingengine.com
 (fout-a2-smtp.messagingengine.com [103.168.172.145])
 by mails.dpdk.org (Postfix) with ESMTP id 2E2C44027C
 for <dev@dpdk.org>; Thu, 23 Jul 2026 08:56:38 +0200 (CEST)
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
 by mailfout.phl.internal (Postfix) with ESMTP id A5B18EC00A2;
 Thu, 23 Jul 2026 02:56:37 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-10.internal (MEProxy); Thu, 23 Jul 2026 02:56:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1784789797;
 x=1784876197; bh=huWHloMYo2cRFQerYLhzLW33YIAbzWeaoRaK7F0u9XE=; b=
 gaSUcV+etnTlvTXwl3TrjSZk1oMfeaTnwlLEk/nkji+jJDPs1D0OJUEvxWdFsgnL
 0EjpIimoS4Wu1P/I+KxRPGSteLZyamJxoY2pFeKRAzlnWu9jvczbvD/0KLa1te5X
 P4soVT3x8R0oZZrOvD9JGCCehoaZPfzC/zVMa+uQ4rW/EbLnY4PYoQvOzTm41sRH
 Ne7jkZztvoMPfr6PKDHpzpF5F+1B1xQN6Pd5gJZOzPBKyKdffTl4tE9Po+84TG/g
 d8yWpxNfbS1Ye2AFLOFfdFmOOn/+HmkVNHyyknKJVtF0DJqmjy8x0uf7u0RTBL1a
 0qpcsi/y/Mrt+5boL4TgrA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784789797; x=
 1784876197; bh=huWHloMYo2cRFQerYLhzLW33YIAbzWeaoRaK7F0u9XE=; b=L
 W+MkM8oO4J0yQOnihx/ew4QhaTrA7V/AuNYtoCX/FTN6Sh613licuQMP6XYMG7+/
 oBsLqFYoQ+cS/iL1nmG6Se491WT3ATqRBQxvhjyyk8ca//zY5csuJFJJbO3X7JoP
 UJEUXdCNJIT3MC6VHPvmRKDh5QBcT1CzA165meHShhtUhw92cF4oLk5f7223Z22k
 YJldtocJNu71ouQyyFc66/3/2zBLlulujCCM2bXp5oe0nNGK5WAZx6eD68wZeFla
 b96PUBYFHEPpvP5KZF7RSZ+EsFvvGrfgg3AIf633y66kl5pBd6KCSafxm85bzgyK
 bSRXUfopBFt7WMWuAWKpQ==
X-ME-Sender: <xms:JbthasVWWkHAvaMJDIkf6V-KDJhGVJypYTZIHKUg8YtvMh_PcNryYQ>
 <xme:Jbthak7bn26ft9q17RrMKscBHTVIcvcYmm5KlLifXOIZ9vhqjop4iTI4XyaDJo9e2
 nFLaWzFFgYP32uUEb-wzL3hO-wBouW-k_3j4MECxh_603obOBqE3Q>
X-ME-Received: <xmr:JbthavgmlWTC9Hrwlq-Zb1H9-FachWYEq5fWAJl-R6K2xDdFG_2i3wkxZoxXjxuBzhEz9N_CFc6fUDPjO_ZpZVyVwQ>
X-ME-Proxy-Cause: dmFkZTFaeK1P4E9O6mV0AUTQdviTowD+3FhdMKJjjsyHqqXVduciTlxhZpc4RMlYAi2p4Z
 O0/tScksPP92w8b5RhMUfCGPMtn+Gn7rx5nBdIIUSLbz+3HLEAVXWfRxs6g5MJhRHpWo+B
 R4iIC77zV5PVgn8WEVe5B5DZ0LIoyy8rT+o+HECgdYUxyT9YhioqfvlOmlmR3cvjvYM2v9
 mTUpmQ0SwLNLAMpZ6ryLX+nQy+ED0BW8JNaLhOFjM14WjzCiwmPNBHeRzAH57ls+YvMD3k
 7qkNqZvg5LsRVqAmFaf2Q7WXrhAqPmYQ6b0GGkeG6qrvUCO/vIu+o0M7oQsW1MSCakq2aa
 O1iOaiLJXZSKtwa6HIw9TV0IsV7/fQ/vm1Z7udIfpmcorzDHEYztLPT+RTunlD3z047ajA
 XDdlAVykTiqPyfIBJgTpn/4/yC7jOfGSyHVIg6W3CoDbS6aOO7kgBsy5KWXGtkk3qQW6zR
 JB8rw0yy3ddeVqddSIe/SuTq88LxghPuiLm0ByeJMWaz8srgjrLx31ZaanDp3W9bcsKYpq
 g4jQQesvQ6CNIH4rg1x8ZgB8yiiEbzkZ9o+ZUTdJ0qFuWZS1xTmGJZeQKEWFlH+y5b/bNw
 Yak9RpGsolq0Cs74ttF76QQqPkAxSfzyg1YFEQz4Xki2L89wQjlTv8Buk5jg
X-ME-Proxy: <xmx:Jbthajdf9oI8QBMeXKthlznWplA1rjzzlcLhUaoD0df__ZeZhQVvAA>
 <xmx:Jbthasf8o8nR_av4mdi-694l8cZlf1nwqyc5_FdBsIiFjKJHN24Uhg>
 <xmx:Jbthal_uK7ILh5Fo_Mq91MZOwOsakfErR2gNLq6R1mHVvSXZ8kf8Jg>
 <xmx:JbthaglU0-BYjrfXSKdRdP2kO95LwQBL-SbYo-pOkrti9fvhNUXLLw>
 <xmx:Jbthakuol8BArlAEjwUrnpif7JA-nalAtO9Gcz01dWWA3S_Oo0hQuCYI>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Jul 2026 02:56:36 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, Aaron Conole <aconole@redhat.com>
Subject: Re: [PATCH] version: 26.11.0-rc0
Date: Thu, 23 Jul 2026 08:56:34 +0200
Message-ID: <tOBZa6-IQjORkA4tX-aY-Q@monjalon.net>
In-Reply-To: <20260723062416.1340761-1-david.marchand@redhat.com>
References: <20260723062416.1340761-1-david.marchand@redhat.com>
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

23/07/2026 08:24, David Marchand:
> Start a new release cycle with empty release notes.
> 
> The ABI version becomes 27.0.
> The ABI exceptions are dropped and CI ABI checks are disabled because
> compatibility is not preserved.
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>

Acked-by: Thomas Monjalon <thomas@monjalon.net>


