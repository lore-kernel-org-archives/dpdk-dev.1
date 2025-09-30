Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A88FCCCA468
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Sep 2025 12:21:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DB6DF40673;
	Tue, 30 Sep 2025 14:21:23 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 39992400EF
 for <dev@dpdk.org>; Tue, 30 Sep 2025 14:21:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759234881;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xJwCLACnOMU1yJwiC8gpGd/IqYVQPi6nxRg3Ol0lapI=;
 b=CeOqOjmHuuImJYoqU9Pa3QlDGJZ1s6FNihANqno0nq6dQ0Uu5l8hu8Zz+1PpGVl0FITKYq
 M87vh2u3rWlZQhj1BBzKV/9uDrYo8VYf/byDCu8qv7a/s+xTOa6BE3M1QYCwpFzhaJ0XuA
 zFFLSCNEbCyXGSrSGvsagIVKuGVs+og=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-533-Ux0HVdXqNcWob_FBW44zPg-1; Tue, 30 Sep 2025 08:21:20 -0400
X-MC-Unique: Ux0HVdXqNcWob_FBW44zPg-1
X-Mimecast-MFC-AGG-ID: Ux0HVdXqNcWob_FBW44zPg_1759234879
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-368348cf7d5so28511321fa.0
 for <dev@dpdk.org>; Tue, 30 Sep 2025 05:21:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759234879; x=1759839679;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xJwCLACnOMU1yJwiC8gpGd/IqYVQPi6nxRg3Ol0lapI=;
 b=jLf9yMZKah3QR0LyvFNDDHE1H2/IGj65X2qb1tR4gAEX3Aw1xnhIHK1PHfDiEdlNCR
 YB8rXiNz8WDdTrLzYM79UVpWJebJ/tdfV1paYP/0nLR/B/sgDp03oPqZxsVwywQ0UcDh
 COPOL7REJDgBVRJmrqvwfoASg2AyU3TEyajRcQdGiYjyynbmb+BuGZw7cm/lvqp8GNAO
 G06LqfMGnL7X7l9E76Gj38J+3y45LBmQZz5IaoO/zGtV9Ex5j+ZkKo3a+lZ60oKq0w3y
 LIgY/WLgXjlwUvBiWIuOsNg9LF9RHzTfaGHeR26pLtd+nj8p2jVmL/I4NFbQ+FNwlZjI
 yDAw==
X-Gm-Message-State: AOJu0YyOo+3/sDrsja0nuG0E2vtbwSSLkI8J8Zj1m+NnigHTkTszu+Gw
 hq+rgM3emD7DMLaTmMyJcW9opR1fc7oHOzsrd8vMmMMnE5MzuubOEcmQ8TW0mHAVdC7nTSjJ3YN
 7cHT7Hav/HhoVxj9YvNsVy57cpUgxXJ8TdiBZbTjTDrmPxqHWy35FbwHGT3xOPwmNWXqmNH6zOk
 QunvxCWndn6kEsJZb6hkI=
X-Gm-Gg: ASbGncvGlT2E5+eIpoYdfMXnQrowLFh/5sXTJ35EPkifjmtiv+XwLjGQDymimgTI7Be
 lXLZ1r0TeeoP9HY3JYLdWT5DLrufL0z40q633rtgtt6u4yOVFXonA46UanuRJdBknRqnOaQFU5y
 LyJwP7Wcjwz4IkZJ+CePVfdy1pzq1B
X-Received: by 2002:a2e:9a15:0:b0:36e:8b37:b43c with SMTP id
 38308e7fff4ca-36f7e78ad95mr75120971fa.22.1759234878781; 
 Tue, 30 Sep 2025 05:21:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEV3JZgK+uKpVWLNOlbE1IXxMiq3ow+g3Seaezu6snp7HNEBzvO7qs2qv6k5GFpJ9GQe/5IQC2EwTq9iL7mJJk=
X-Received: by 2002:a2e:9a15:0:b0:36e:8b37:b43c with SMTP id
 38308e7fff4ca-36f7e78ad95mr75120911fa.22.1759234878364; Tue, 30 Sep 2025
 05:21:18 -0700 (PDT)
MIME-Version: 1.0
References: <20250520164025.2055721-1-bruce.richardson@intel.com>
 <20250723162013.2392-1-bruce.richardson@intel.com>
 <20250723162013.2392-6-bruce.richardson@intel.com>
In-Reply-To: <20250723162013.2392-6-bruce.richardson@intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 30 Sep 2025 14:21:06 +0200
X-Gm-Features: AS18NWB4Se0vVnubiRtcW3FSp4wQjiGVsh8-qwOACFa_tUnZmTxu-OLYwSXHNBo
Message-ID: <CAJFAV8wj5-JOBm-Km-x_pf+iTLr8FK4By350kvkD-jZ1Pc50cg@mail.gmail.com>
Subject: Re: [PATCH v7 05/13] eal: add long options for each short option
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, Tyler Retzlaff <roretzla@linux.microsoft.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: z3b4r5jeww1B3E9rQtjfLVyJ4XoOpKKXcphZQ0UzH08_1759234879
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

On Wed, 23 Jul 2025 at 18:21, Bruce Richardson
<bruce.richardson@intel.com> wrote:
> @@ -109,6 +116,8 @@ eal_long_options[] = {
>         {OPT_NO_TELEMETRY,      0, NULL, OPT_NO_TELEMETRY_NUM     },
>         {OPT_FORCE_MAX_SIMD_BITWIDTH, 1, NULL, OPT_FORCE_MAX_SIMD_BITWIDTH_NUM},
>         {OPT_HUGE_WORKER_STACK, 2, NULL, OPT_HUGE_WORKER_STACK_NUM     },
> +       {OPT_VERSION,           0, NULL, OPT_VERSION_NUM         },
> +
>

Nit: one empty line is enough.

>         {0,                     0, NULL, 0                        }
>  };



-- 
David Marchand

