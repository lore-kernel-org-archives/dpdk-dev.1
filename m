Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DD59CCF9EB
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Oct 2025 13:20:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 089694028E;
	Wed, 29 Oct 2025 14:19:59 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 309AA40288
 for <dev@dpdk.org>; Wed, 29 Oct 2025 14:19:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761743996;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LpLFgQa+4sDaPs7kIteGAQhYhywtL045fHSMMHtRl0U=;
 b=S34YgEPBP56T7KOWvulbbd4ou+aQelHgYhOyJ2kWW1IcWJYu76LkkktTL4wW6wy8RnR3OG
 J7r+f5Pv9/fBdKy/B/Xn/GKUe1C1SZpoaMwK+RZWja4N2RmLIGreq/o/6Cj0rgJAkrTy59
 2IPvfwa5qtvEUfTA9sUdJCbw2nWPvnE=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-373-YckgsA_8OdiuM206FinPmg-1; Wed, 29 Oct 2025 09:19:55 -0400
X-MC-Unique: YckgsA_8OdiuM206FinPmg-1
X-Mimecast-MFC-AGG-ID: YckgsA_8OdiuM206FinPmg_1761743994
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-36ac8376c1fso30426391fa.1
 for <dev@dpdk.org>; Wed, 29 Oct 2025 06:19:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761743994; x=1762348794;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LpLFgQa+4sDaPs7kIteGAQhYhywtL045fHSMMHtRl0U=;
 b=e9M07Vad+ZgNl/5XDRDVTC0vzegp8s8/IkJ9EjAeUhaL7WE1sC/+IqBZMc9Hni60w5
 nCqyVO+k/IotlgX/mVKsawMSOHxyjdW7+OnZWELUoJlfS0ZAXdijIjEP0b85T0t/60zR
 OYopFOyKanvGaLoTARqqsk7sf3wdfHsV+PJBIHAsp5O0FTJNonBs5IBYsaZJ60BX47mF
 Gr7HMfCeJy42iV7KgqRbtagdtoRsfHGNl/G0HnXu8LKsCh+qiG7lZveEcsK+XIo1MDMV
 GNockMJIDXhR3PuP5QR5pgmPGE0xRNTA5ZdHs4YSAMfi+APKNAoVejvaUfZn/gY6HdZn
 BvBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUFZ5vPgCWsmJx6FbHNKUZ+IFKV81SOayYyB6fnMdqeQeKNbqeJcYKFQT+h25Rtgp1VwBI=@dpdk.org
X-Gm-Message-State: AOJu0Yy/x0CzD9x6A9DnQFx900tLw78Lsjh6tV3A+5IkdJR7Tmz4pE/j
 d+B8PfpU8CrVC8X5oi//TrC0iL8H08t0sfUI1DetFVbBoxj6aYvX1ELn9R8jKtIXfjR0ZA8wF+i
 FN0sXuC/18TlvTW8KrYKt2teZcIu4hSErpymDnmZ1KKDVe6ZXxVz356flRTvWkFudLlDAHUXPFo
 X3zyzwhFGG9pLQxziIgw8=
X-Gm-Gg: ASbGncto3CXFrC3RXoLGcpEHarQbz0ybO/tMt1j9y8gV9UQq8tvqsXZf1Z2vbaRNvmJ
 3aKJV1PmrbY50vDtqgp0DmkHL915p1Qu+ftXzgwLhvi6IdshUW3OBVZR9lZBFgQ4CW7VmGjo6FN
 PPuwwq4HdGKxB3Srb/Q3NkCW2MHOKSM+PHFjIfsd2JuTzRyUno5TxTZjEFBw==
X-Received: by 2002:a05:651c:439b:20b0:373:a675:cd5f with SMTP id
 38308e7fff4ca-37a02403657mr8096821fa.39.1761743993822; 
 Wed, 29 Oct 2025 06:19:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENkkq66+KCd91xlg3oeJozjp1Pg41ZI4j2wP7fpBTaFqPb1vdQL/ytuhxPl9bCYNL7w5hy2OZENdcVInI1cYg=
X-Received: by 2002:a05:651c:439b:20b0:373:a675:cd5f with SMTP id
 38308e7fff4ca-37a02403657mr8096711fa.39.1761743993346; Wed, 29 Oct 2025
 06:19:53 -0700 (PDT)
MIME-Version: 1.0
References: <20251028172324.3149379-1-jerinj@marvell.com>
 <20251028172324.3149379-3-jerinj@marvell.com>
In-Reply-To: <20251028172324.3149379-3-jerinj@marvell.com>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 29 Oct 2025 14:19:41 +0100
X-Gm-Features: AWmQ_bmyiqdCrkfOTmiyjK4445q7wFpATjRjY5iNT8Cl3jOOMnz52sEmCM8yFFU
Message-ID: <CAJFAV8y7X13JpLtidVD8TcEJfz1p+4OACDgzw5C4V51Qo2Z+8w@mail.gmail.com>
Subject: Re: [dpdk-dev] [PATCH v1 3/3] app/test: fix issues with clang 21.1.4
To: jerinj@marvell.com
Cc: Amit Prakash Shukla <amitprakashs@marvell.com>,
 Sunil Kumar Kori <skori@marvell.com>, 
 Ankur Dwivedi <adwivedi@marvell.com>,
 =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>, 
 Ferruh Yigit <ferruh.yigit@amd.com>, dev@dpdk.org, thomas@monjalon.net, 
 bruce.richardson@intel.com, stable@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 6rmb8lCab86SKAptEyGzu6D4TvSHvpVq3ERq3-NVVBk_1761743994
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

On Tue, 28 Oct 2025 at 18:25, <jerinj@marvell.com> wrote:
>
> From: Jerin Jacob <jerinj@marvell.com>
>
> Fix the following errors seen with clang 21.1.4
>
> app/test/test_event_dma_adapter.c:532:32: error: variable 'event' is
> uninitialized when passed as a const pointer argument here
> [-Werror,-Wuninitialized-const-pointer]
>
> app/test/test_trace.c:201:29: error: variable 'tmp' is uninitialized
> when passed as a const pointer argument here
> [-Werror,-Wuninitialized-const-pointer]
>
> Fixes: 4925e15a1614 ("trace: add trace point emit for blob")

I don't think this Fixes: tag is the right one.
Instead, I would point at 9247e71dfb55 ("test/trace: add functional
test cases").


> Fixes: a276e7c8fbb3 ("test/event: add DMA adapter auto-test")
> Cc: stable@dpdk.org
>
> Signed-off-by: Jerin Jacob <jerinj@marvell.com>
> ---
>  app/test/test_event_dma_adapter.c | 2 ++
>  app/test/test_trace.c             | 2 +-
>  2 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/app/test/test_event_dma_adapter.c b/app/test/test_event_dma_adapter.c
> index 7f72a4e81d..4df5991285 100644
> --- a/app/test/test_event_dma_adapter.c
> +++ b/app/test/test_event_dma_adapter.c
> @@ -144,6 +144,7 @@ test_dma_adapter_params(void)
>         TEST_ASSERT_SUCCESS(err, "Failed to get adapter capabilities\n");
>
>         if (cap & RTE_EVENT_DMA_ADAPTER_CAP_INTERNAL_PORT_VCHAN_EV_BIND) {
> +               event.queue_id = 0;
>                 err = rte_event_dma_adapter_vchan_add(TEST_ADAPTER_ID, TEST_DMA_DEV_ID,
>                                                             TEST_DMA_VCHAN_ID, &event);
>         } else
> @@ -528,6 +529,7 @@ test_dma_adapter_vchan_add_del(void)
>         TEST_ASSERT_SUCCESS(ret, "Failed to get adapter capabilities\n");
>
>         if (cap & RTE_EVENT_DMA_ADAPTER_CAP_INTERNAL_PORT_VCHAN_EV_BIND) {
> +               event.queue_id = 0;
>                 ret = rte_event_dma_adapter_vchan_add(TEST_ADAPTER_ID, TEST_DMA_DEV_ID,
>                                                             TEST_DMA_VCHAN_ID, &event);
>         } else

Same comment than for the eventdev test app, I would move those event
variable declaration in the block where only needed.

Otherwise, this lgtm and was tested on Fedora 43.


-- 
David Marchand

