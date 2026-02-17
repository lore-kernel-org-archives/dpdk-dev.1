Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F419EE909B1
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Feb 2026 14:31:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BF61640261;
	Tue, 17 Feb 2026 15:31:33 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id B435A400EF
 for <dev@dpdk.org>; Tue, 17 Feb 2026 15:31:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771338691;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HElKErFZfTUhhiPTb/G1bnGdHP3Kbzw8REOI7Sm3Y30=;
 b=EVNgNKvFMTjt+FqViqGh4X8Xa3tROW93IUld7T+GQyIQDvq6Zng6n+9HFTqJJQXC5fJ8ts
 ztpTDcheSwjigAjZOy9sHRjazlx1j2bzYoMKlfXH4cvIbecrzAJrmy5tOE34UVNf8ZmIjS
 tEA2MRKXG1KYfa5UCt+uvzwgFyqEALU=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-88-YlGsnHuXNmqPv6cY2yb54A-1; Tue, 17 Feb 2026 09:31:29 -0500
X-MC-Unique: YlGsnHuXNmqPv6cY2yb54A-1
X-Mimecast-MFC-AGG-ID: YlGsnHuXNmqPv6cY2yb54A_1771338688
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-59e6c268f6aso1864626e87.0
 for <dev@dpdk.org>; Tue, 17 Feb 2026 06:31:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771338688; x=1771943488;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HElKErFZfTUhhiPTb/G1bnGdHP3Kbzw8REOI7Sm3Y30=;
 b=qzmsZhqKO004HyJx9XDOoreQ3XmCn0tgWL3QaEXCyfl2gBlO3Eh729sfA43rNLR+Bs
 0c1GZoDrdHeHJKLXdLUkuR4Zx+evfuQt+Y2B8eXzTw49GMLQgp++Q8rtHgnGIw5efjaS
 Gnm2JCqBGWwGanFYri4ZbA8HMsFHoKEiBLqovUgIt59zCsPjyLaKFAmphfL5yflxgMLC
 7Y6qj7UuU9+eLlT4KSuFm8B1NzVDZeIYFKAakw3TDun9br/0TVzr58a/VwvPy8crYU83
 farrbjchXHE4JepWnKEAtYgR5bQvMhsxX4S3kJSPLAT4xmrBOiOgcCVV/DnQbhlbKjy5
 FYMg==
X-Gm-Message-State: AOJu0YylEjL6UResqCifD/JuIV5LsBrS679w1qU1JmBnB/YSmipSS/+P
 uVRV3Sr3/ew9oCm0xSPFGC0CMVNtYUtnyXdWYuLtiDT7Jdvk0RvZ4dO9AUls47JlPwzlt0VV8jS
 AunYyFRgE2rS7/BgRGrX+rA0A5b7p6lxcEgmVkMIsw04Q4KwvsOSZ22vDwa5RWjz+uxChE7htCO
 DAXfeSeplH31ElyYuSN2A=
X-Gm-Gg: AZuq6aLqOZS+BNQw5jFhf34YWc4uTonFYSdwfOyq/0Y6mmKKFeEjXD4JF7P585uNNYy
 PDvqH6j+Q8Z3FHG8a9bAl6ULfvp1DM5Jh54qWxRfwh8JY39LPCMLub2oU8o4kjoIjYYvRWtZTO+
 sACC34E1GHnYx9lZHXdJ6iGlw1OOhqLvE3GtWKifES+6SmOTr4CDOX1Jwe0Qr0hxNtu1phKR/v0
 zMWN4YbkfT0N58gggPSbd0FezFVbzPklZT6id4klSjJicHqyrIfpYnpLWHHHI2AMD2uIQ==
X-Received: by 2002:a05:6512:8002:10b0:59e:5928:db93 with SMTP id
 2adb3069b0e04-59f6d3759camr2277129e87.25.1771338688007; 
 Tue, 17 Feb 2026 06:31:28 -0800 (PST)
X-Received: by 2002:a05:6512:8002:10b0:59e:5928:db93 with SMTP id
 2adb3069b0e04-59f6d3759camr2277122e87.25.1771338687599; Tue, 17 Feb 2026
 06:31:27 -0800 (PST)
MIME-Version: 1.0
References: <20260205183004.66631-1-malikovyehor@gmail.com>
 <20260205183529.66909-1-malikovyehor@gmail.com>
In-Reply-To: <20260205183529.66909-1-malikovyehor@gmail.com>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 17 Feb 2026 15:31:15 +0100
X-Gm-Features: AaiRm50UPrlYnFImfq79tY9QtDVqY1aKHKhiz20rbJS2zxKXKSUIatQmyYas1Cs
Message-ID: <CAJFAV8zTzM5vXEckOvLsH54p50PGO9n5Uj0R5krHSmUmnzKFUg@mail.gmail.com>
Subject: Re: [PATCH v9] vhost: fix use-after-free in fdset during shutdown
To: Yehor Malikov <malikovyehor@gmail.com>
Cc: dev@dpdk.org, maxime.coquelin@redhat.com, chenbox@nvidia.com, 
 stephen@networkplumber.org, Yehor Malikov <Yehor.Malikov@solidigm.com>, 
 Tyler Retzlaff <roretzla@linux.microsoft.com>, 
 Andre Muezerie <andremue@linux.microsoft.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: fyHWilYwUPEWcRb82Kpa9ijWqQApIo5wK5PhGFBN4KI_1771338688
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
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

On Thu, 5 Feb 2026 at 19:35, Yehor Malikov <malikovyehor@gmail.com> wrote:
>
> From: Yehor Malikov <Yehor.Malikov@solidigm.com>
>
> The fdset_event_dispatch thread runs in a loop checking the destroy
> flag after each epoll_wait iteration. During process exit,
> rte_eal_cleanup() releases resources (like hugepages via
> rte_eal_memory_detach) while the fdset thread is still running.
> This race condition can lead to use-after-free errors if the thread
> accesses memory that has been freed.
>
> Standard destructors (RTE_FINI) run after rte_eal_cleanup() returns,
> which is too late to prevent this race.
>
> To address this, introduce a mechanism to register cleanup callbacks
> that run within rte_eal_cleanup() before memory is detached:
> 1. Add rte_eal_cleanup_register() API to EAL.
> 2. Implement fdset_deinit() in vhost to synchronously stop the
>    dispatch thread, close the epoll fd, and release resources.
> 3. Register the vhost cleanup handler during initialization to
>    ensure proper shutdown ordering via EAL.

As a first step, I suggest switching to libc allocations instead of
DPDK memory for the fdset objects (those are only for control path of
the vhost-user library).
This should avoid the UAF you noticed and restore the situation to
what it was before the vhost library change you pointed out.


Now, on this proposal for an EAL change, the fixed size for the
callbacks array makes little sense to me: in the case of fdset objects
in vhost, we only have two atm but this could increase.
On the other hand, this is control path stuff, not performance sensitive.
We can do some allocations and go with a list of callbacks.

The cleanup callbacks as you propose are really vague.
The problem here is linked to control thread objects, so maybe we
could add this cleanup notion in the control thread creation itself.
This notion has been skipped since the introduction of control
threads, maybe it is worth investigating?
The semantics must be sorted out, but it seems cleaner to me.


-- 
David Marchand

