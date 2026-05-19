Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23A53CD4F57
	for <dpdk-dev@archiver.kernel.org>; Tue, 19 May 2026 11:47:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6861040296;
	Tue, 19 May 2026 13:47:46 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 73F324025E
 for <dev@dpdk.org>; Tue, 19 May 2026 13:47:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779191263;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qrM+tONl9JVCwJThYnvpu5jZ7jPSdjBvI7fE8Y5aLjI=;
 b=hEpuGt6LyeX2VR4PsbMavPopP3CstNBQCeQSIP/YYJQ3GDSMDw3zMbF06LKC67o20R6IPk
 ICxwaJ3uhwO6oMoAg5ojFNkVD2HB12jvp4+z1bdO7/RnCKx0Tv1QSnGWvj1PfQ5MP2sc0H
 BjyO/Rgp/P43FpHkFF9yqLgurl3cXPQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-27-bvnhlmoOOhqM2Lv_4wGxug-1; Tue, 19 May 2026 07:47:42 -0400
X-MC-Unique: bvnhlmoOOhqM2Lv_4wGxug-1
X-Mimecast-MFC-AGG-ID: bvnhlmoOOhqM2Lv_4wGxug_1779191261
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-48fd64c32e8so23680515e9.3
 for <dev@dpdk.org>; Tue, 19 May 2026 04:47:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779191261; x=1779796061;
 h=in-reply-to:references:user-agent:subject:to:from:cc:message-id
 :date:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bnGTnrD30CUe6nCV9yj++z+oz9/WgIlRQ8iVDCBEAkU=;
 b=p0FyXyYMYE9zm37kRfai1qmFRB3pNXuHOHWopaA+OrhoKIllFPdY1LMgCSpTsgR5L1
 CZ2cqAG7WxTwU1e6D80X8bm/U5OWzla0ntiwY8qQ7+wN2A3gIBGjFLOLwhZcMZGFeMKa
 +5NrR1WckD9vqg3MkuYaHjljSPnla//3F7I373m4Q/8kozmYUm2qxFVvfpIu65e7k6uG
 M+2+vRAotFGr20Q8EnCQ9McpTaIkyVyoSc3rkljYPIXmHUDVJ7i1iJe/igMq0CBWDcPZ
 LE0f5kgNqSDKu2jHD93vkwc+KwSeFUaXju4Yoh9ovhlEzjpQKcVwKloqsgxwYHIor+Pg
 xxcw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/IIy7KYwtf6PG+0WQ1IVgFVAOXakW35j3UMnw+uGhxPSAMUwvxZuAgwfJukAs1pU6bySs=@dpdk.org
X-Gm-Message-State: AOJu0YzbxvIaSUJP9b0+ALXF4Hry3m479KlmWG8rw2MfzkgFw5Pzccrm
 ey7RyQObv1QdQvMM3Ep+0d/qPuqdhuzAi8DblfKqBlQ6vl0nYKMdwWt+QH1U18fDX1l+HiwXMcG
 zCsIFART+BVygUapLaycAOqfqvIgd9MK4p2fp9OL/AURA
X-Gm-Gg: Acq92OG+W8ds2ITbYm66psqKd8oRL82OvxGdBGJeCawwJZ+yE23Xd4ElMWtjwhVA/mO
 xWdah6gM2z5Epsy9vS+H1BglA5U+RpKxpsdGsRuUH44oFjkmIvFd1U/i+n48P9PeeQoMN7UmqU7
 rQ1rsD/9CPzsWtnQE4PDRLvn3wegJGlVS9KQq8T1XFeyCvcCsPA7UYA1ibbhknd4p21i1bM7EE3
 8+hErSS5fnK0z1BTB7JgjikfCISPVEug/6RT/yfJJzqphoSVP5sXEIZ2COUZOnKynSslAsfCzcO
 0ppISa9m2a8f5hV3ZmR6hnkoCPQBNMVmDcQmrSgz4O6WBeREEFphLzhDpv+WW5wZI4bBdwjMNmV
 IyrHBnEx1C0e5z3ZbaBJFHFbCoMFQe5fG10VszuWIBumuHvQJXhmbMJDO+cukZidykVxBczybLy
 dc5Ipu1no9p+11PQ==
X-Received: by 2002:a05:600c:c10b:b0:48f:d612:3c59 with SMTP id
 5b1f17b1804b1-48fe60eb0f6mr207804835e9.9.1779191261202; 
 Tue, 19 May 2026 04:47:41 -0700 (PDT)
X-Received: by 2002:a05:600c:c10b:b0:48f:d612:3c59 with SMTP id
 5b1f17b1804b1-48fe60eb0f6mr207804485e9.9.1779191260693; 
 Tue, 19 May 2026 04:47:40 -0700 (PDT)
Received: from localhost (2a01cb00021ec0002e23edbec21b0e73.ipv6.abo.wanadoo.fr.
 [2a01:cb00:21e:c000:2e23:edbe:c21b:e73])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fe537c516sm347218275e9.13.2026.05.19.04.47.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 May 2026 04:47:40 -0700 (PDT)
Mime-Version: 1.0
Date: Tue, 19 May 2026 13:47:39 +0200
Message-Id: <DIMMNX51I02T.DRHRXO9HTQCT@redhat.com>
Cc: "Stephen Hemminger" <stephen@networkplumber.org>, "Konstantin Ananyev"
 <konstantin.ananyev@huawei.com>, "Bruce Richardson"
 <bruce.richardson@intel.com>
From: "Robin Jarry" <rjarry@redhat.com>
To: "Thomas Monjalon" <thomas@monjalon.net>, <dev@dpdk.org>
Subject: Re: [PATCH v3 2/3] spinlock: add debug checks in recursive unlock
User-Agent: aerc/0.21.0-151-g204ee0bf378b
References: <20260504083714.2904729-1-thomas@monjalon.net>
 <20260519103640.3986710-1-thomas@monjalon.net>
 <20260519103640.3986710-2-thomas@monjalon.net>
In-Reply-To: <20260519103640.3986710-2-thomas@monjalon.net>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: i58XguUkWJRgSmwIXrw3brUqxzLWQ35wtVL5TNB_Fzw_1779191261
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
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

Thomas Monjalon, May 19, 2026 at 12:34:
> The recursive unlock assumes that the caller owns the lock.
> This behavior will be checked when RTE_ENABLE_ASSERT is on.
> There is an additional check for the count which should be positive
> if no corruption happened.
>
> Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
> ---
> v3: new patch in the series
> ---
>  lib/eal/include/generic/rte_spinlock.h | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/lib/eal/include/generic/rte_spinlock.h b/lib/eal/include/gen=
eric/rte_spinlock.h
> index ffdcb8fa3d..e7cd18a8e2 100644
> --- a/lib/eal/include/generic/rte_spinlock.h
> +++ b/lib/eal/include/generic/rte_spinlock.h
> @@ -21,6 +21,7 @@
>  #ifdef RTE_FORCE_INTRINSICS
>  #include <rte_common.h>
>  #endif
> +#include <rte_debug.h>
>  #include <rte_lock_annotations.h>
>  #include <rte_pause.h>
>  #include <rte_stdatomic.h>
> @@ -245,6 +246,8 @@ static inline void rte_spinlock_recursive_lock(rte_sp=
inlock_recursive_t *slr)
>  static inline void rte_spinlock_recursive_unlock(rte_spinlock_recursive_=
t *slr)
>  =09__rte_no_thread_safety_analysis
>  {
> +=09RTE_ASSERT(rte_atomic_load_explicit(&slr->owner, rte_memory_order_rel=
axed) =3D=3D rte_gettid());
> +=09RTE_ASSERT(slr->count > 0);
>  =09if (--(slr->count) =3D=3D 0) {
>  =09=09rte_atomic_store_explicit(&slr->owner, -1, rte_memory_order_relaxe=
d);
>  =09=09rte_spinlock_unlock(&slr->sl);

Acked-by: Robin Jarry <rjarry@redhat.com>

