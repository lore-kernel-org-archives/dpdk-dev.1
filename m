Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10E55CCF9E3
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Nov 2025 13:16:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5F802402D7;
	Tue,  4 Nov 2025 14:16:44 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id C8C5540269
 for <dev@dpdk.org>; Tue,  4 Nov 2025 14:16:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762262202;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cgGdJsuj00t9Flqfjcqi3xFnS7KrIlweYub0EWB0+jc=;
 b=jDSpMbPNpupxnuDo+L94beuk+4dLlC0TqDkoornmN3DtcsG2QgIuSmk6Gk6jIh51CgRXy5
 iSlvZqTzQY1X70/66EI0/vY77bG+dEK+np3i8odmVSvRXjYTBYAcuGVuHxhQIHkcZq7OIL
 Jl5n2bIyR5bZCxIKWrz3S1KZ8gt3j2Q=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-9txT1-MnPi-Ii02xf6mUog-1; Tue, 04 Nov 2025 08:16:41 -0500
X-MC-Unique: 9txT1-MnPi-Ii02xf6mUog-1
X-Mimecast-MFC-AGG-ID: 9txT1-MnPi-Ii02xf6mUog_1762262200
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-37a17435230so24855951fa.0
 for <dev@dpdk.org>; Tue, 04 Nov 2025 05:16:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762262200; x=1762867000;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cgGdJsuj00t9Flqfjcqi3xFnS7KrIlweYub0EWB0+jc=;
 b=Qk6Tu7WnU5NWDZDrzL2HmWp7HlZw/91LAo4FMx6iiG9fVYqfnd3ZzslnEQ5d4glQ73
 9JKwL1kTvKGIdObVAwr74D24Gi3/k922m15IhbJ5azWrNd3J467jSg7BYf+8UqYKd0Lp
 vHYkfvqCWTapUTe8QYJqx7xmkbblekMJ0YzVwPo5z11gAF4z8DDxynkwCJaleSCWOfjF
 0q4aFGvhEPiNkxrcey9bfBacf4bzq0hdtntsPiQU1cvMV2F56Dyk3Y+bGpip6mZGnO1K
 Kd9aCHtm9IMu66vq/5q6uKOI08L8bFxzD8I/5z6jBuXuA8H+z0C1exvOUiMtY+eD1yH4
 bdZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVqYbGaNAtgeq24Cx7HhOeNBnIeQMt3gBSRWNQmYwGwGemYKK7g95dkzsZ8AOUmi25pGac=@dpdk.org
X-Gm-Message-State: AOJu0YwYvIzTCayMRAbfo4Ut0xKrFf5Wuos5zV0hkB86A2irukEOyc7E
 JEXSDluLXmeK7HWVfb9AIqyuw6wo9u0yEZG37ZsW7ZuQbqnzlQWsyQcDKkKA19JBlNviUQgH5/8
 vFP64dKUMQL7y7jEvnuW8v41dfEo0PJbhbEdrvDtgGIviYnRmjw0Rvb60cgcba3yf71i7KkuX5c
 qs9g5Oudt08FmEBB05uN4=
X-Gm-Gg: ASbGncuFREU67cblnFMJWdhtCz6qcPNFj2aap1Y4yQTfre7C1WsUeobgzU1klyGx6UR
 y/z1EjI5pF7p1TqZbGv192mio+89rFE55OKH29JS7kXEJ72nIIIXGmy9DSFv+Tv9WXoEdsKtA8L
 dSIGJoUDt68Xq3zEIcu2snlXeQfe1+tmMrGa/DCLewRJblVAtLxq/VudgYtg==
X-Received: by 2002:a05:6512:3d08:b0:594:2bc4:8284 with SMTP id
 2adb3069b0e04-5942bc484edmr2692797e87.49.1762262199654; 
 Tue, 04 Nov 2025 05:16:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF9lY86GDVgub+AJ5x67gyLPj6k9gaqWQD/fTZA9SkLzrk39sSvPtB0KKz2c4j++O23QvucQkoTjfaLMY9/gkw=
X-Received: by 2002:a05:6512:3d08:b0:594:2bc4:8284 with SMTP id
 2adb3069b0e04-5942bc484edmr2692784e87.49.1762262198966; Tue, 04 Nov 2025
 05:16:38 -0800 (PST)
MIME-Version: 1.0
References: <20251028172324.3149379-1-jerinj@marvell.com>
 <20251028172324.3149379-3-jerinj@marvell.com>
 <CAJFAV8y7X13JpLtidVD8TcEJfz1p+4OACDgzw5C4V51Qo2Z+8w@mail.gmail.com>
In-Reply-To: <CAJFAV8y7X13JpLtidVD8TcEJfz1p+4OACDgzw5C4V51Qo2Z+8w@mail.gmail.com>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 4 Nov 2025 14:16:27 +0100
X-Gm-Features: AWmQ_bmq0fNJrOJCGqveXzKVAOUZgeGc9VGJI6V8hXx521LaMY4Gkm0kmEvqenk
Message-ID: <CAJFAV8xPB6oSm1w3uOfoqbcC1aN2eyPoO=v-CZgCsRaDkk0H2w@mail.gmail.com>
Subject: Re: [dpdk-dev] [PATCH v1 3/3] app/test: fix issues with clang 21.1.4
To: jerinj@marvell.com
Cc: Amit Prakash Shukla <amitprakashs@marvell.com>,
 Sunil Kumar Kori <skori@marvell.com>, 
 Ankur Dwivedi <adwivedi@marvell.com>,
 =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>, 
 Ferruh Yigit <ferruh.yigit@amd.com>, dev@dpdk.org, thomas@monjalon.net, 
 bruce.richardson@intel.com, stable@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Rgw1kY498IToppiPpQoR5CzT6752BvOruo8zsJIE46g_1762262200
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

On Wed, 29 Oct 2025 at 14:19, David Marchand <david.marchand@redhat.com> wrote:
>
> On Tue, 28 Oct 2025 at 18:25, <jerinj@marvell.com> wrote:
> >
> > From: Jerin Jacob <jerinj@marvell.com>
> >
> > Fix the following errors seen with clang 21.1.4
> >
> > app/test/test_event_dma_adapter.c:532:32: error: variable 'event' is
> > uninitialized when passed as a const pointer argument here
> > [-Werror,-Wuninitialized-const-pointer]
> >
> > app/test/test_trace.c:201:29: error: variable 'tmp' is uninitialized
> > when passed as a const pointer argument here
> > [-Werror,-Wuninitialized-const-pointer]
> >
> > Fixes: 4925e15a1614 ("trace: add trace point emit for blob")
>
> I don't think this Fixes: tag is the right one.
> Instead, I would point at 9247e71dfb55 ("test/trace: add functional
> test cases").
>
>
> > Fixes: a276e7c8fbb3 ("test/event: add DMA adapter auto-test")
> > Cc: stable@dpdk.org
> >
> > Signed-off-by: Jerin Jacob <jerinj@marvell.com>
> > ---
> >  app/test/test_event_dma_adapter.c | 2 ++
> >  app/test/test_trace.c             | 2 +-
> >  2 files changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/app/test/test_event_dma_adapter.c b/app/test/test_event_dma_adapter.c
> > index 7f72a4e81d..4df5991285 100644
> > --- a/app/test/test_event_dma_adapter.c
> > +++ b/app/test/test_event_dma_adapter.c
> > @@ -144,6 +144,7 @@ test_dma_adapter_params(void)
> >         TEST_ASSERT_SUCCESS(err, "Failed to get adapter capabilities\n");
> >
> >         if (cap & RTE_EVENT_DMA_ADAPTER_CAP_INTERNAL_PORT_VCHAN_EV_BIND) {
> > +               event.queue_id = 0;
> >                 err = rte_event_dma_adapter_vchan_add(TEST_ADAPTER_ID, TEST_DMA_DEV_ID,
> >                                                             TEST_DMA_VCHAN_ID, &event);
> >         } else
> > @@ -528,6 +529,7 @@ test_dma_adapter_vchan_add_del(void)
> >         TEST_ASSERT_SUCCESS(ret, "Failed to get adapter capabilities\n");
> >
> >         if (cap & RTE_EVENT_DMA_ADAPTER_CAP_INTERNAL_PORT_VCHAN_EV_BIND) {
> > +               event.queue_id = 0;
> >                 ret = rte_event_dma_adapter_vchan_add(TEST_ADAPTER_ID, TEST_DMA_DEV_ID,
> >                                                             TEST_DMA_VCHAN_ID, &event);
> >         } else
>
> Same comment than for the eventdev test app, I would move those event
> variable declaration in the block where only needed.

I did those suggested changes and applied the series.
Thanks.


-- 
David Marchand

