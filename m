Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD8E606A321
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Nov 2026 11:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=monjalon.net header.i=@monjalon.net header.a=rsa-sha256 header.s=fm3 header.b=qog/lC0U;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=PHTC6QBK
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4358D402B2;
	Wed, 25 Nov 2026 12:38:09 +0100 (CET)
Received: from fout-a2-smtp.messagingengine.com
 (fout-a2-smtp.messagingengine.com [103.168.172.145])
 by mails.dpdk.org (Postfix) with ESMTPS id 4C6A94027A
 for <dev@dpdk.org>; Wed, 25 Nov 2026 12:38:07 +0100 (CET)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfout.phl.internal (Postfix) with ESMTP id 86E08EC0C66
 for <dev@dpdk.org>; Wed, 25 Nov 2026 06:38:06 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-01.internal (MEProxy); Wed, 25 Nov 2026 06:38:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1795606686;
 x=1795693086; bh=TqMRK8/mKl541Qv4zHplAJXoLaTw5gzYfo3f4+ah1SQ=; b=
 qog/lC0UobYhtxshCDbwqfK/y32ixyr3iEtbtVpN+Thnh0MRCz0ENW9d7gqWm3mq
 VmuETmbVrUgHDNPy2XFqumBTNES4jgI56vLR0pPVspLUQxx2mr16/NlDGPOhJVT8
 U/1Pw0knMvCRDqFA18MDjxo3IZCEFUndr7ijdv7R2bP6ATKB+si0amhQqQNM4LzT
 1h98sOiZC/T/fLTmnrdfciRlYV0U5kKq4q9EBhmE2qvffhyqTY1X720INhXoeI8w
 hfqeP/RGwrtrVlD4Cac0N4YlFsr2y30PYw8zGlf6A9cHm+P5fiqAAYsqXw9DgnUR
 1X9wJ5Lpe+sjEIUr1wv52A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795606686; x=
 1795693086; bh=TqMRK8/mKl541Qv4zHplAJXoLaTw5gzYfo3f4+ah1SQ=; b=P
 HTC6QBKf/HJrH1dpI9kAi4I1ei4ORqIGAmQGrs7vT3HcLw3vtPwki2Q+lPy6yTTq
 aVUXZpn+8CpQnsGKiuOkXCs/q5PoJLf6eJe/ZuVrGdUr8l5BnTQtUKxNmYl1hoQ4
 mVk3PMnrQHdN3b96FwPWP3+14tz7LMO6CKmddPkSt+qGJnjVkOWdvbL9q+cnQ8OA
 tSFLc51NikKn2LCIwZoqhNt4QEg+wwC3HDYTo09pNLd1+2Iwut7/hBNb+ogfnvzq
 9nKZ98z8L70SwBleIPplteROm6nnMMPWSXcv4aKM8IR7c6Aswa0J1oPtvmaumvVZ
 2MyU0dJU5xj+sAPXPOy2g==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=monjalon.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795606686; d=monjalon.net;
 mf=PHRob21hc0Btb25qYWxvbi5uZXQ+; rt=PGRldkBkcGRrLm9yZz4=;
 s=fm3:rsa-sha256:YWkLlZvuwbnKJb7RhNBG3oJM7jrONqLaBEWMha4piGJpfZe
 hs+1rkMNwayLJeyukgw+t+2o76PQF2VrVsGXIUr1qI4hEyTtiI4iLQSTlDfh7KZg
 bIRBAQ0l4LQAFLRS/OnIshjo1JR/e9sCgWUYht2t33smFvBFvgqrrjUkBsU1OVbu
 Oxd9CUdqvyxE6MeLcYirilK1Umw6AppZkN2zRvAUqCjyAAkryq8rXvWO8XgNWTPU
 mt6Nsrlrg+ovB1BytA1wsm9bHGmnAq3yK2fEEbZZOgiGLD8aoItYB4LY8SAWDjeI
 6xrLMO2IW9E9kFxj4mftDNt1sdXFByBbS0vcgQg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:g/cok1zS3g3G15e4ikaWYKiCLPQRUQxnJ63Iv5Cs11o=:xf5vHN6CaaVfyWXcsBdgUFrU85NHM4gawLGKMd6PAMo=;
X-ME-Sender: <xms:nsgGa76MGEZmjd2NPVJ8OopZ_kzyVIUu5t1ZW4YSY-uXWEgyTK8I4g>
 <xme:nsgGa4WY4BtOd4fTwzWUvXcPtck71auxS3j_-Fvb6AFAVjTyYlvagt0jQD3XjzLVt
 -axqnE9c6YKkEPVj5c6A2fFMzfrM8FLxeLkowfvNu6cCdRZKu6w6Is>
X-ME-Received: <xmr:nsgGa_12wsz7F33g4gxJOyyOdpFKqrfneiwy_3RH68DzJWSW85r8B0ZuOHtPHeLq8rVGXy7U-u4GfHFFUhy3sMA>
X-ME-Proxy-Cause: dmFkZTEEzPwXM6/u5Q2/X/mXPZNgpqj0vxf7CkHcPT4O9QbiEOIiXEgnpCouyinzqBNLjY
 S/su1AeXsLYnXMjo4EVOVX4nWKdZQPVOm8EchlME4fEh4f+y53owFI17PEiqIp6RtKZz4Y
 JciZ/DRo31HAw8hjYt68o9Jgbxa3OFyFhz7pi4wgvWIPOgTI+YWAZvAbTWL6lrJwAVnSQp
 0rUix6ZIfd0DC63iue3tHxcPYPGXXljNGXiMZjzqKirT74HKvVECHVYd+VlSYUPg8X4jzU
 nyGoRgKfqcJ1T0CfEUvdKP+4v2uTCeWQ4BWuephopRjkrYJH97wottgOVZhrpgkEij0OXo
 9O0QB4L+nnjk1Sr4RZAJu5HIzV1E8XEdz/T8EI0g+B/Mrf0k/Mwb3Rg2vvmiw97aWHJYjq
 LIIlOObkAjFODIA/nRaHPIo/vYZqwSNFaPpYT7tP5NG/g6ZtWRepdMY8ZNvSyVCTJUGWOz
 q8If1sWzk46Vddwyymfh4qbI+hTr1SLUf2e4mALdmg4cTzy0qZm9QzoJgV7+tIWK5A23BC
 jngIHP91EscvMNCQC2GcVTk7MVlhzByHmzmuByZ6fafyGxHKjeCZajfx9Xbgky2Re5fBj1
 b6tCbEXeE6V97cOZt6t5Kx2vqT0tDGyRxpJ6ZXo8EFt2vyM7ulBYZyGH4nKA
X-ME-Proxy: <xmx:nsgGa117uuWgtMywoXnvhHf6-kwHOVlSkhLbVxRHY91wtfUjEbLYJA>
 <xmx:nsgGay-QWSUF3qh5OcyixrNYV-n5aI0loiOJCG7tHUKBa82qQcM5MQ>
 <xmx:nsgGay0fkhbTL-pdGIyOPAOTIhWTcw0dRL9D2Y1ByMFEPKeA2sAzLw>
 <xmx:nsgGa_-9iBXT_GT0Wyb6H3hL5ymgCSuvgSZrxI0CuUIgg5D7l7Frmw>
 <xmx:nsgGa_H6E-r7vk-0Aajh3U2q-WlZoZdLQ4r2S54vm46sQJF_SborsXU5>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Nov 2026 06:38:05 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Riley Fletcher <rileyf@linux.ibm.com>
Cc: dev@dpdk.org, Raslan Darawsheh <rasland@nvidia.com>
Subject: Re: [PATCH] doc: Power11 results for tested platforms
Date: Wed, 25 Nov 2026 12:38:04 +0100
Message-ID: <VSX3fm76Tay7ulpGwoykjg@monjalon.net>
In-Reply-To: <uilMAV5USPmM8LBSVcEv1g@monjalon.net>
References: <20261119154604.281229-1-rileyf@linux.ibm.com>
 <uilMAV5USPmM8LBSVcEv1g@monjalon.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

19/11/2026 18:28, Thomas Monjalon:
> Hello,
> 
> I have a question about the wording.
> 
> Should we write Power or POWER?
> With a whitespace before the number or not?

Looks like the new branding is IBM Power11.
So I'll adopt that form consistently.


> 19/11/2026 16:46, Riley Fletcher:
> > Power11 testing results for 26.11 release notes
> [...]
> > +* IBM Power 11 platforms with NVIDIA\ |reg| NICs combinations



