Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 205D7EC110C
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Feb 2026 17:08:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 62C4B4027D;
	Mon, 23 Feb 2026 18:08:47 +0100 (CET)
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com
 [209.85.167.169])
 by mails.dpdk.org (Postfix) with ESMTP id 4827A4025E
 for <dev@dpdk.org>; Mon, 23 Feb 2026 18:08:46 +0100 (CET)
Received: by mail-oi1-f169.google.com with SMTP id
 5614622812f47-45f194e9a98so1489643b6e.3
 for <dev@dpdk.org>; Mon, 23 Feb 2026 09:08:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771866525;
 x=1772471325; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d3iTXXppmZl5fLznDJYvfJjAeKsL8lDAvxqUqXrtO6s=;
 b=G9WbfLnxwSvwtyWzhKro5q0m9xKqUjoXaaw3BH4EMd/YkhqxLVS4P+m5BK4qTroKX6
 efstsml09wHjGvClGZAcNjQdKo9nIQcXnLp0n436XZij9gac2WrFIoxaffQ9A2v68xqr
 iYImRD510uXSiEnt2URZXw32r/d1oiWmhoUgtSGF07JQTqewWEfYWGCMKAqNuDqjWnda
 kZ/7dRfpcpGF/iVBrVCssH8E1/3c5oVkgNnbSJu6nPfgXK5yLXrEL0KGU5LkcKUjJgj6
 pQR6dUbCWievSvxIRxx5/jVYGniUNtRBT5NJT7kcGhqgilxLqwuzH666mbubZvKfdGaR
 yZNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771866525; x=1772471325;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=d3iTXXppmZl5fLznDJYvfJjAeKsL8lDAvxqUqXrtO6s=;
 b=BdfIzaVjnstW6mkC3hBwMZL0KoDRibw3g0JZsvhvQ8FuLmC2ZEp2I1l9Aw7qcn8VaO
 LytvLnO09JpU96yWUtQAfmymd50ZwG/4tRPNdgD4fdYcBge+MJopj+yJOBfN2TKQ8vts
 1s1XZTqSapHv48jdnA0CozEhquq+XtkXAVrb7goRTBfmFe849QJa9kJoJAX1cc9ERj16
 cp150Nf8PUeiaSRjWFTbA+Yo8KTPzvtw5IC8kuE1b+x3GnE0FKlYcYhHeKVLqEpkKCVc
 nbp75CPfST30HFH5AzD7RqWPjaj2vIYVceSAW4Y2b59kyje2g8sEsSZrF+jOPUwCcyrg
 vIsw==
X-Gm-Message-State: AOJu0YyTbsrHsFSsmTvsL4waeSw4d0CSlymTxnmvL7ALCikUcZazAkdB
 8Tu5EIRBgPwdfOHdiIB28efW19T6QXiFMPlcnAUGhN0yrt7T/Cayp0mlNdQXQ1tDUCk=
X-Gm-Gg: AZuq6aKvyQZSLLyHfoM9bW81s4f4Z/TsZve7ms9HGHte02DQBEGM1nU9jqqga8E6hfs
 KocmCc/+9S6O9tnReoJ3GKXVqX8ZTxr5J55Z9U1Mz6F9OYcUQXTMMVfBDAPnJVqVFN6O3ksWFdo
 ROjSkiTwBovF1hUn/Q/sj3pqUk5Wo9qCbwdspWnKwZKWqn+piunR74iuPxQmGpXGe2zdt8EmtUK
 kym/75Gm9soejGA8pN/qt1nYs/Uk7Y+ZSm272w5SMZ3+VpMpuSJPl6MJ+rveIa3YRyN6ROJj7bp
 FQwFfUiY429/ht+vUnrBXBUp+A6Ynp/p4f52vkF9alSxmVksH4KFrnAkKcutuo2C8JeJBPcQSXb
 g97sBFePJUzSMCet0T2IKg1B3dWmmmFxpNzZXPBub6qdKHHjcfe+Sg4EoI+8Mm/6DrS2ndSKHi8
 wiqIgee14FV9FBJyOjim11nsmIqq0WRxby6+cdPOR193p/GJXzwL9ScM6+XnOVTQav
X-Received: by 2002:a05:6808:138b:b0:44d:bcb0:1409 with SMTP id
 5614622812f47-464461d3e75mr5389289b6e.22.1771866525421; 
 Mon, 23 Feb 2026 09:08:45 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d52cf78e52sm7745116a34.2.2026.02.23.09.08.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Feb 2026 09:08:45 -0800 (PST)
Date: Mon, 23 Feb 2026 09:08:43 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Harsh raj Singh <singhharshraj215@gmail.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH] examples/l2fwd_acl: add ACL-based L2 forwarding example
Message-ID: <20260223090843.69ac3e1f@phoenix.local>
In-Reply-To: <CAN33txETfmQEj8j=W4-nkUk1rAq0_JLhZuR4R-c3YCrDY90y6A@mail.gmail.com>
References: <CAN33txETfmQEj8j=W4-nkUk1rAq0_JLhZuR4R-c3YCrDY90y6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Sat, 21 Feb 2026 00:13:33 +0530
Harsh raj Singh <singhharshraj215@gmail.com> wrote:

> diff --git a/examples/meson.build b/examples/meson.build
> index 25d9c88457..bce2982229 100644
> --- a/examples/meson.build
> +++ b/examples/meson.build
> @@ -24,6 +24,7 @@ all_examples = [
>          'ipsec-secgw',
>          'ipv4_multicast',
>          'l2fwd',
> +        'l2fwd_acl',
>          'l2fwd-cat',
>          'l2fwd-crypto

Should be named l2fwd-acl not l2fwd_acl for consistency
with other variants.
