Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A579AD61013
	for <dpdk-dev@archiver.kernel.org>; Thu, 29 Jan 2026 12:51:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7213A402C1;
	Thu, 29 Jan 2026 13:51:21 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id AD810402AF
 for <dev@dpdk.org>; Thu, 29 Jan 2026 13:51:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769691079;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=BuPNpUwlqVve+2CU4Ny+Tc58rLPBqa/eeCHTGWpBwBo=;
 b=LqIIxo3G9PmDCgaaFxKELrdlrRIMrZXMu8Wyl23mOUHTY1INr7KCibFULdQGcxYgW9VyZU
 XNBzZF9EupyECYQGY8OTyViom8dB3GwEyZDWcFlGbXNmL/72d4kz8NssLjviNiNed4e2r1
 VcnVI+0PDbsGaBCDyPhCLuh8diq1At0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-xtDOCq_HOseAeJVLksvpYQ-1; Thu, 29 Jan 2026 07:51:18 -0500
X-MC-Unique: xtDOCq_HOseAeJVLksvpYQ-1
X-Mimecast-MFC-AGG-ID: xtDOCq_HOseAeJVLksvpYQ_1769691077
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-480717a8ef9so7464555e9.1
 for <dev@dpdk.org>; Thu, 29 Jan 2026 04:51:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769691076; x=1770295876;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BuPNpUwlqVve+2CU4Ny+Tc58rLPBqa/eeCHTGWpBwBo=;
 b=DryQ8BGeyY/L+MOmTNmGuXCWScxW4wmhCkvkDjjIUMqycsRYCkZVycBTCxODEfZ8IB
 TpNK7ki46U6Js5g9OB/9LSw2rRED2c6cu0dUpOxnQC++0Ms2HROp1A0aL2JBjZA6ELPB
 hBq5cIYFqshK4aCMaUiiq8plMZmvch5YVPJv2Ed8vULKzTQggtQHG2QylydTkMdOUxYF
 pjJsl6JHgLq1rsi9BHhUiUnyBUSWSXYo3K+BOQCE5FVh4gz7KF8ulL/obv5VDXezbgIK
 85JsBv99LaBUKwzXTumh1BFuk0/1jfg4Tll34SHKANSB/UJxDFIvN1fdPO3WTrly+Q1d
 jWpQ==
X-Gm-Message-State: AOJu0YymjdiWphp84645o1ePFnf0WdrdEB29rQMeAy9RMXE+3jVByNiL
 0OpN/gpGHl5m24IMKWHiYxGFgWQ2HO/ALe15f8PvnL9DMSbOTO4/naTtHwNSwWqkSSYxuxlqTcZ
 8cpMJ0zdBPT6XS1JZBb2e3Oth7mrQb4zslKtq/I0TkmvVW3cREdSL+47r3wK8jUtCzWE41WpdDk
 gRZl6aX768vKyiQB0jIgc6NXXchK89
X-Gm-Gg: AZuq6aJq3FTztdgkoasKmk76n8aId42xCzr9LH3cp7LkQet1R0nX/lgh7+ZEGQEP+5S
 IdKHGJOOs/RzpdxoMRQKXr4VmGCxL8+3YBLjSMViEb/w5UtSSPpsv+oDzAipMWix8++28juNK4M
 9Rp7JM4xJYO2n/c5TK11n3LD6EEgNxlme8YjtR7dfADZcUZGgDRNXGUvPdEjGxbxisyuWmTGgH9
 aTAwYj0lmuSX2PL+7qWlOempek1Nw/Y0RByMCEnpiGKqbqKt3QxBTJ0LYRwkT/3XDJpNHsWkwhF
 H64ipfZJZ+zvJj4EiF0l/XuApI9zPN7vDu+qsNhVCzuiQ4Kv2nqo5fESlU9q3Akk5o1j7e85Qw1
 eUS0Ti+aIy+jJ
X-Received: by 2002:a05:600c:3b85:b0:46f:a2ba:581f with SMTP id
 5b1f17b1804b1-480829b8e0amr41217495e9.16.1769691075957; 
 Thu, 29 Jan 2026 04:51:15 -0800 (PST)
X-Received: by 2002:a05:600c:3b85:b0:46f:a2ba:581f with SMTP id
 5b1f17b1804b1-480829b8e0amr41217155e9.16.1769691075538; 
 Thu, 29 Jan 2026 04:51:15 -0800 (PST)
Received: from [192.168.0.56] ([78.16.128.210])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4806cdd79c7sm121190465e9.2.2026.01.29.04.51.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Jan 2026 04:51:14 -0800 (PST)
Message-ID: <6ab44b2f-8faa-444e-90d9-8da715234c8a@redhat.com>
Date: Thu, 29 Jan 2026 12:51:13 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] eal/linux: handle epoll error conditions
To: dev@dpdk.org
Cc: thomas@monjalon.net, david.marchand@redhat.com, dsosnowski@nvidia.com,
 viacheslavo@nvidia.com, stable@dpdk.org
References: <20260128122055.192104-1-ktraynor@redhat.com>
From: Kevin Traynor <ktraynor@redhat.com>
Autocrypt: addr=ktraynor@redhat.com; keydata=
 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
In-Reply-To: <20260128122055.192104-1-ktraynor@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ecu0RiwsA6EjGu5O76wwGOa_YgMejXQQKQK29TEE_V8_1769691077
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
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

On 28/01/2026 12:20, Kevin Traynor wrote:
> Add handling for epoll error conditions EPOLLERR, EPOLLHUP and
> EPOLLRDHUP. These events indicate that the interrupt file descriptor
> is in an error state or there has been a hangup.
> 
> This may happen when the interrupt file descriptor is deleted or for
> mlx5 devices when the device is unbound from mlx5 kernel driver or if
> the device is removed by the mlx5 kernel driver as part of LAG setup.
> 
> Previously, the interrupts were being read, but the condition was not
> cleared and that may lead to an interrupt continuing to fire and a
> busy-loop processing it.
> 
> Now when this condition is detected, an error message is logged and the
> interrupt is removed to prevent busy-looping.
> 
> Also cover the case where no bytes are read even though the epoll has
> indicated there is something to read.
> 
> Bugzilla ID: 1873
> Fixes: af75078fece3 ("first public release")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Kevin Traynor <ktraynor@redhat.com>
> ---
>  lib/eal/linux/eal_interrupts.c | 63 ++++++++++++++++++++++++----------
>  1 file changed, 44 insertions(+), 19 deletions(-)

I have reproduced the ci failure and need to investigate. I may have
been too aggressive in dealing with some event types. I will mark as
Changes Requested. Thanks.

