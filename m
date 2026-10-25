Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06C5606A31D
	for <dpdk-dev@archiver.kernel.org>; Sun, 25 Oct 2026 11:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=tMCBc6OM
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 957C9402B9;
	Sun, 25 Oct 2026 12:00:50 +0100 (CET)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by mails.dpdk.org (Postfix) with ESMTPS id B38C14025F
 for <dev@dpdk.org>; Sun, 25 Oct 2026 12:00:48 +0100 (CET)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4a59100fa83so1780915e9.0
 for <dev@dpdk.org>; Sun, 25 Oct 2026 04:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792926048; x=1793530848; darn=dpdk.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=4z0BGmrv2dEtQl6zlsDWBubFxu/Rg35c4jbHXPVa03w=;
 b=tMCBc6OMKoJz2YMqmuVexkvdb5iNuWy9DbDgdxLonM4l8vdXjNsZZ9u6m+08i9G8rA
 lhCYtQInhEa0nkQJQKZJDADT+qBQXq1AEOKjLIcc99iMGRPze/FmFuwKM5h81AvKhTvz
 iDI/zflc00vcQ0+UHkbRX/0DkufaTfU/M1Da1i3GtXoVucWyVxQnRom4l77Ehf0tvLZd
 QgJKIF8QBgO9ndcUB52wDcnj9dttaHPHk6sAAib5CPBR0G9UBBPOyx1k5MX+wAjw9O6R
 1jLJ9CJT1Hgog9BSaNm4iflPNd6BwWJWYwvNPXkdSkaTGkRSuG92rf/3FcU2Y3vPdipQ
 eRxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792926048; x=1793530848;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4z0BGmrv2dEtQl6zlsDWBubFxu/Rg35c4jbHXPVa03w=;
 b=E5pws5tGHe8UwXA87h58ygdIt8grDrgbYv+uCjbxv1HvmT2FKEgOKItFM25q6zfKh9
 oatJFdsKm3rYhvNtHLhWF/CImJldrFrdEX4qzK5aPZsQH5DZlBhJg+aFpJr80k9LwqwM
 Fth/YNQnoHr9I1yhTHKBD4Irnyr2dEyHvvgvKCUteHZt1YoFJQsqRvbrQY72hU80ojLT
 TEKqhYVNA9XVPf24bmMpDuXznvKl1jHYP0BllZmXKFMSIaG8vey54GFODRKroO9S7oot
 nxUgQXlz1G8LdWNRJgrQIbOyZK5rKS6yIZTUoPO4JNrn0eVzBqOIu3bRTA/XaXG/Gxr3
 pe5Q==
X-Gm-Message-State: AFq9FYKNwEopCN/jd6uv7T1K1wmSajWc6U92WBIJzW94E/vzEFOanmZb
 Ob15C1ExOmdQUC3FQSL5u8RSPVXdcgWiIrjlOcWORZg3PlNPP6jonJVo
X-Gm-Gg: AYBFou2Yu6+mEuQ6DHy0CPBcxIkV+F6QHqzWcjPt4try9NEhemNon2h0KPsWZdPKxp9
 z6bDFuUB+uMiPhUxJFrxoJ/hTMca+//ZXEGVy1ig1So5uZlm73CPJ1AWKn5IxsIjgZPKss/bQyL
 0sT/iGLJdI4uiC6vKGtbM7HfyP1O8urKskFapuQkwYuESbr7GL0OuGOGdRLYiSWAQeAXRa3LN7C
 koK5aIBshf79hcTlRj3Qxdpsih4O90btFoIXFuUFAgO5eZnDudGF6ZNxIT/VQRQJNyXuKVxfcsD
 9R8WOzgUs1G5nlsyjbdZnHtdCeraUCW7ww6cZJSO/Z9VJVp6Zg+x5MS1qdiL24JXBd1tSHs3VcH
 m16HcXFbEayvD7ozYheyOy4Kfx8JViSLZfNSoO3PETpXLwC76HAqIk8mAysjiM9e0/7oeyrzam+
 JHMJuU/SrCQX9t8Owm51gfoGgadpMiM3OYuYOUo7TY0KOozbGmzV5ZnqJUmzqFzRvJKE17IfxWz
 SinFdl1T8UcpBkaqfG4wFKQ6pOZOI0y1od/fj+JfG3tDvohYTw=
X-Received: by 2002:a05:600c:5397:b0:4a2:a9:ed56 with SMTP id
 5b1f17b1804b1-4a35ac99b8fmr65428355e9.8.1792926048180; 
 Sun, 25 Oct 2026 04:00:48 -0700 (PDT)
Received: from [192.168.0.78] ([80.233.35.34])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a35a5697a7sm110880415e9.7.2026.10.25.04.00.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 25 Oct 2026 04:00:47 -0700 (PDT)
Message-ID: <8f9739ce-ad47-48d4-9a62-e4280b42bfd8@gmail.com>
Date: Sun, 25 Oct 2026 11:00:46 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/9] bpf: simplify callback inuse tracking to boolean
 flag
To: Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Cc: dev@dpdk.org, stephen@networkplumber.org
References: <20261011182158.124246-1-qm2k21@gmail.com>
 <20261012210917.161343-1-qm2k21@gmail.com>
 <20261012210917.161343-6-qm2k21@gmail.com>
 <8f751b5c-941e-467f-b4d8-6d65e2b0db5b@yandex.ru>
 <f4539ddf-2893-4c36-b327-3eadd72ab057@gmail.com>
 <5b66ff13-47f0-46e6-82ed-df4034e31bcc@yandex.ru>
 <3b8e6fc9-b747-4d52-a4ba-f4803bea04ce@gmail.com>
 <e564b858-832e-492e-9e1b-3fd2a254c30b@yandex.ru>
Content-Language: en-US
From: Marat Khalili <qm2k21@gmail.com>
In-Reply-To: <e564b858-832e-492e-9e1b-3fd2a254c30b@yandex.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 25/10/2026 10:50, Konstantin Ananyev wrote:
>>>        /* in use, busy wait till current RX/TX iteration is finished */
>>>         if ((puse & BPF_ETH_CBI_INUSE) != 0) {
>>>                 RTE_WAIT_UNTIL_MASKED((__rte_atomic uint32_t 
>>> *)(uintptr_t)&cbi->use,
>>>                         UINT32_MAX, !=, puse, 
>>> rte_memory_order_acquire);
>>>         }
>>>
>>> Here, we are waiting when 'puse' will become not equal to 'cbi->use'.
>>> So, any value except current puse is good.
>>
>> If you look a the sequence diagram, there is no way to arrive here 
>> without the callback being removed and `cb` cleared in the DP thread, 
>> no matter how you move the arrows around.  So the DP thread will 
>> increment `use` once to make it even, and then will never ever reach 
>> the callback or increment anything again. We allow any value except 
>> current puse, but there are never any values except the current puse 
>> and the one after it. It's just these two values we can possibly see.
>
> DP can (and most likely will) call rx/tx_burst again.
> Just to give you an example:
> --- DP thread:
> cbi->use = 1;
>                          --- CP thread:
>                             read cbi->use (1)
By this time the callback is removed and `cb` is cleared.
> --DP thread:
> cbi->use = 2;
> ...
> next rx burst:
> cbi->use = 3;
How did we reach hear if `cb` is NULL?
>                 read cbi->use (3)
>
> So CP sees an odd value (3), but it is ok to proceed, as previoud RX 
> iteration (quiscent period) had already finished,
> and in new one rx_burst will not see removed call-back.
