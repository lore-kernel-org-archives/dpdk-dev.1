Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3450FCCF9E9
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Oct 2025 13:12:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 169E940431;
	Wed, 29 Oct 2025 14:12:15 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id C0AC540288
 for <dev@dpdk.org>; Wed, 29 Oct 2025 14:12:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761743533;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zUuCyc7AiNHGebEom88YzQV2lzSaA5RAZf4p2BquDNA=;
 b=GNym9BtmCb3HLKlfVdjDJhxAC3f9oaSInxuheDmRZ5jMGc4+aq6eJI53josfTvqVy0VbRA
 FpP8UE/p6NHR62qQbbEJwBivhqirj8/+/yWQMx3jdpPNL0DA0Atzfk9I7Ez8b+lpkid8+d
 De+LMblQa8CTr+KcPrjqFhgRkihecqE=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-583-qwHZ-jbdNLyCKxpoGpc76g-1; Wed, 29 Oct 2025 09:12:10 -0400
X-MC-Unique: qwHZ-jbdNLyCKxpoGpc76g-1
X-Mimecast-MFC-AGG-ID: qwHZ-jbdNLyCKxpoGpc76g_1761743529
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-377c5a52433so53876561fa.3
 for <dev@dpdk.org>; Wed, 29 Oct 2025 06:12:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761743529; x=1762348329;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zUuCyc7AiNHGebEom88YzQV2lzSaA5RAZf4p2BquDNA=;
 b=V2qIUj2tsc3h/Cd5bTWQ61GwRs/ogI38PR+8ZVHcwHauDL6osioUjIzfnGGVrJSUVF
 bNZ60o7MU26gNG46AWULOvevSK/5Bj5c4It0oL9xof1ZA4RJFq25ng5s0T9Xw8IYhJ3T
 GVXIOXx54wyJw/TxYd/u/YfrvcYmg2rBzFbXrVclPW4gi2szeHUiVkchQjqb3oJFSD4m
 xTzcW5WKKfTk5bVj1ieJ+0aGr+wDpNEYgTHMPg8F0FoC9q+Hw0xJGPB+5gDp91X/Cu37
 tuXBakzD/+SMPJGCift5keX3f3LPiZ4dcHD+4Ae0JN1cntnnRvWdvESEFLIT8wftOeTH
 b2NQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQR2KaEzOWFuWipxX0hfd61CU4cC1kS/YktIC0ls3lYGjAPSwTtYDCO0+to4aXglG0ELQ=@dpdk.org
X-Gm-Message-State: AOJu0Ywr/6DOH7ms4cj2woEDWcSv69C14WQjHZocGkHWocePoqraVc6H
 zntKZKC0mCx86spIvrrjJz7irRCM72906ZwRaaoZ6jJIg35ZeZ6I3C7mz7RqZibwBcTGav+Pdu4
 Iz9h1WtT1Fua9KBwMHS/dycOg3sKStTJnV1dOmgmqeU77QDwgmcndjVmhagHoNtQ8LwBnsGJcCf
 5s0yehU/VVK26tDHS+baw=
X-Gm-Gg: ASbGncuoBcxuqCXOD8XQdhIVfcFhFY3p3i/oaehiBM+Qe0g50p9G1Ann8QENETmFV6H
 WE/MswMFAs7bobjysgg7KecC/GmbjjBRfbKBBioxqc3P3sp4rJQ7gmYJaZW26tJaL0my4VOhn0t
 LZ+4URKRHpj3UjAvhB5FuaeVyz7ZoOCBjm+KOr7JsDazy4Iv9Bq05iv7Q1/g==
X-Received: by 2002:a05:651c:25d5:20b0:36e:21a0:f212 with SMTP id
 38308e7fff4ca-37a023fad09mr8092031fa.29.1761743528762; 
 Wed, 29 Oct 2025 06:12:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHYMbF4W0tQHM+biPvrroOZoCo7O9Jnw4Vf48xG+WPtTemNzGei91h8jlbtEPYVswDJo1Z/ctSbwSGZzTNlJMk=
X-Received: by 2002:a05:651c:25d5:20b0:36e:21a0:f212 with SMTP id
 38308e7fff4ca-37a023fad09mr8091931fa.29.1761743528161; Wed, 29 Oct 2025
 06:12:08 -0700 (PDT)
MIME-Version: 1.0
References: <20251028172324.3149379-1-jerinj@marvell.com>
In-Reply-To: <20251028172324.3149379-1-jerinj@marvell.com>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 29 Oct 2025 14:11:56 +0100
X-Gm-Features: AWmQ_bkADt6H1-OnXbX3WZ0quAZPo0wxfEqNfL-N1_alfIQCrvrKgpJNIQ-BGkU
Message-ID: <CAJFAV8xgt1EjHNZKGsTk1-H=3rNrrNFqJmUA=5aOK1guvESF5Q@mail.gmail.com>
Subject: Re: [dpdk-dev] [PATCH v1 1/3] app/test-eventdev: fix issues with
 clang 21.1.4
To: jerinj@marvell.com
Cc: Amit Prakash Shukla <amitprakashs@marvell.com>,
 Pavan Nikhilesh <pbhagavatula@marvell.com>, dev@dpdk.org, 
 thomas@monjalon.net, bruce.richardson@intel.com, stable@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 14mUayPXDSdhIiLqoogiUO_ely4NN3Ju9IO10-rSDwI_1761743529
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

On Tue, 28 Oct 2025 at 18:24, <jerinj@marvell.com> wrote:
>
> From: Jerin Jacob <jerinj@marvell.com>
>
> Fix the following error seen with clang 21.1.4
>
> app/test-eventdev/test_perf_common.c:1340:30: error: variable
> 'event' is uninitialized when passed as a const pointer argument
> here [-Werror,-Wuninitialized-const-pointer]
>
> Fixes: b25a66c49e8d ("app/eventdev: add DMA adapter performance test")
> Cc: stable@dpdk.org
>
> Signed-off-by: Jerin Jacob <jerinj@marvell.com>
> ---
>  app/test-eventdev/test_perf_common.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/app/test-eventdev/test_perf_common.c b/app/test-eventdev/test_perf_common.c
> index 2ad451e457..2bbc17ae96 100644
> --- a/app/test-eventdev/test_perf_common.c
> +++ b/app/test-eventdev/test_perf_common.c
> @@ -1335,13 +1335,14 @@ perf_event_dma_adapter_setup(struct test_perf *t, struct prod_data *p)
>                 return -ENOTSUP;
>         }
>
> -       if (cap & RTE_EVENT_DMA_ADAPTER_CAP_INTERNAL_PORT_VCHAN_EV_BIND)
> +       if (cap & RTE_EVENT_DMA_ADAPTER_CAP_INTERNAL_PORT_VCHAN_EV_BIND) {

struct rte_event event declaration can be moved in this block.

> +               event.queue_id = p->queue_id;
>                 ret = rte_event_dma_adapter_vchan_add(TEST_PERF_DA_ID, p->da.dma_dev_id,
>                                                       p->da.vchan_id, &event);
> -       else
> +       } else {
>                 ret = rte_event_dma_adapter_vchan_add(TEST_PERF_DA_ID, p->da.dma_dev_id,
>                                                       p->da.vchan_id, NULL);
> -
> +       }
>         return ret;
>  }

Otherwise, this lgtm.
I tested with Fedora 43.


-- 
David Marchand

