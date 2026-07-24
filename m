Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFB02C531FA
	for <dpdk-dev@archiver.kernel.org>; Fri, 24 Jul 2026 07:42:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 157E2402A7;
	Fri, 24 Jul 2026 09:42:28 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 870D84029B
 for <dev@dpdk.org>; Fri, 24 Jul 2026 09:42:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784878945;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JZus/PRSaziV8sRKg7l/I39hn2rcNlxpfGLQ/mlM5+k=;
 b=eYxz8ADSNO3+bNBeelm6LlWJCsNivvyJ6kCRCta9OY6+UKK/6LVxza45wuaZrGHjMR+gLv
 saZbJClFLJgqptUe16kUwQQf8g/0ChwaBzk/QpQ+nYFL5/pDOs6fCsK32GYhGlowlhrSUn
 aMv5a8lhsIn7/ZrRKPPvKpJCWtmegmc=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-541-Sm0V3OSWNwaZcIGjGlP9bw-1; Fri, 24 Jul 2026 03:42:24 -0400
X-MC-Unique: Sm0V3OSWNwaZcIGjGlP9bw-1
X-Mimecast-MFC-AGG-ID: Sm0V3OSWNwaZcIGjGlP9bw_1784878942
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-5b2a24ae6deso120960e87.0
 for <dev@dpdk.org>; Fri, 24 Jul 2026 00:42:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784878942; x=1785483742;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=JZus/PRSaziV8sRKg7l/I39hn2rcNlxpfGLQ/mlM5+k=;
 b=Nw/UHNcAb+po1DdmDyTvkfla3KmH64o3YYqWAm+0/DVFxnervOdZocpEAophHFzleb
 KdwNH9dEvCYVNlBMhlPleGu2PIT9J6h7KTIH7rD1+AnUaZTyETlHjFKAkMxkBi6vHSYZ
 s5jdPyR1DtKQEkZQbk8ispsffly2dnWWOR1xSzSYEFGproCUGqgJOgwnouLhRnW+ni0R
 n0WUcuN3EyYwtIrHuOZal4SwZ8jGveYV01UA76SEn6cmQOHf+KiqzaPpJJT13y++BVBX
 oXPmzrSYQQe3ndyPIXpsc5jaUKyWECDhFfJM9mlskkVIAUiTPGAFiTr9B9o0+pVT+DzG
 RJdA==
X-Gm-Message-State: AOJu0YzEn9iIO2kxqV0+2U5fC92pD1/07mW8bCCvNX7N1iGgMO4+1fLP
 NRR+Le69ymKHRzk+xWVcB7HVzZaP97hwy4pKZglIUyZku1hEPyJBfVibzls51wEyL9E/Mb8CJ5y
 3fin+fm9SVVWU5Ual+QGeo4MEdse+ZRK8FBlV+HMNjwl6W73XLKjSLvu0OY6QQUUdYI4SwrC3q9
 AkZ3qxCOJBBpYmPOxZ+MI=
X-Gm-Gg: AR+sD11qXZfRPW3jv4uzbejkKqx6P7LWoQbQMGDw+XRzdWTBBZWslhFkN1pS3k9HWIy
 yUZEsdnTlm0+EGQwuwnv28LGyllN33CA354mGY5JEUdKG9lrbHZgonqAIMK8a3uZgFtiHAhVMP4
 LLJ11/twNpwoHegtBXnYmcro+Tw5KhZv5bSebeSk5w9l4F6YQE8pnfv1pqi+UGxASpLCVJig/NZ
 6mxfCNfKPp7awL7uMhWleVA1LbcNI4UjM/aolJCPhVRrwmV
X-Received: by 2002:a05:651c:a11:b0:39b:d04:b778 with SMTP id
 38308e7fff4ca-39f07c42edfmr13102621fa.5.1784878942372; 
 Fri, 24 Jul 2026 00:42:22 -0700 (PDT)
X-Received: by 2002:a05:651c:a11:b0:39b:d04:b778 with SMTP id
 38308e7fff4ca-39f07c42edfmr13102541fa.5.1784878941896; Fri, 24 Jul 2026
 00:42:21 -0700 (PDT)
MIME-Version: 1.0
References: <20260530161151.873199-1-stephen@networkplumber.org>
 <20260723202936.378793-1-stephen@networkplumber.org>
In-Reply-To: <20260723202936.378793-1-stephen@networkplumber.org>
From: David Marchand <david.marchand@redhat.com>
Date: Fri, 24 Jul 2026 09:42:09 +0200
X-Gm-Features: AUfX_mxEdhH8r74rVhyUJBjNHtZ5qEDFySQB5ofSVwGXpptVf9RIpTOBLPRaSRM
Message-ID: <CAJFAV8zvhZ0vys=_2xHa-MT-rHKwmxXmOGe9spoUikPU8zxZkw@mail.gmail.com>
Subject: Re: [PATCH v2 0/9] Complete removal of queue stats mapping
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: QvxAe4aB5VUztZplzEHkkJpSNvgXBElki97jCWZxWkM_1784878942
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

On Thu, 23 Jul 2026 at 22:29, Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> The per-queue stats mapping mechanism (rte_eth_dev_set_{rx,tx}_queue_stats_mapping
> and the queue_stats_mapping_set ethdev op) was a workaround for hardware that
> could only expose a limited number of queue stat registers. It let an application
> fold many queues onto a small set of counters. Since 25.11 queue statistics are
> filled in directly by the ethdev layer indexed by queue id, so the mapping is no
> longer needed; the functions were deprecated then by commit 2863cbd9ee6d.
>
> This series finishes the job. The drivers that still implemented the op are
> converted to report queue stats directly by queue id (bounded by
> RTE_ETHDEV_QUEUE_STAT_CNTRS), and the op, the two public functions, their trace
> points, and the documentation are removed from ethdev. The leftover per-driver
> mapping tables, accessor macros, and init code go away with them.

Do you have plans to remove this RTE_ETHDEV_QUEUE_STAT_CNTRS limit in
the future?


-- 
David Marchand

