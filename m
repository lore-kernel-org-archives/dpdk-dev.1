Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2C6C10BA43D
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Mar 2026 08:29:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 65351402C5;
	Fri, 27 Mar 2026 09:29:54 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id AD8C740280
 for <dev@dpdk.org>; Fri, 27 Mar 2026 09:29:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774600192;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9/TcoavSL3SZs83kIryBG9vmh6tYbL0yhkB5rMea6xo=;
 b=BdYf7bueBSegX9wbH+qilSSJMvuz/2mN7MOroRp6oXWJ4OUsQ6aJ6tI17ME9JwtUVZeyos
 xEGZRiNh1eNs3Zu8wYPU7+kjWRjHt9bnzNHU2FsHPITZQ2HkTasPpG6/5b1QCHSFZXaJns
 TLjsB2Lej3DTLG7NM1wYed1k1ClJM3c=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-505-ruyxaQyRNPKrQhn78lVBPg-1; Fri, 27 Mar 2026 04:29:50 -0400
X-MC-Unique: ruyxaQyRNPKrQhn78lVBPg-1
X-Mimecast-MFC-AGG-ID: ruyxaQyRNPKrQhn78lVBPg_1774600189
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-38abf1618easo9244321fa.0
 for <dev@dpdk.org>; Fri, 27 Mar 2026 01:29:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774600189; x=1775204989;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9/TcoavSL3SZs83kIryBG9vmh6tYbL0yhkB5rMea6xo=;
 b=ox9SlKlmvRgLKCuOCpuDSHM3FlxqbleGIwNpX+RfuWDFNmeGIIEBZOXPYe4EUOs8z3
 DpDz5SnpvfMSsYwNZnLOcZi68Oqt9h5UpzX5P3pM4u5PPMzK9D3EL4kxqZ9W6BWBBqdN
 hdqG3RR1f1/mtXZjmFi2t/tYb6Rbb0LFQdFV1epuYqu1lF3SssPXkyywBxnk6cgrgRwQ
 UqIU1cp9/tAFdtRrVDq/dIMaNogAqhZ1DZikMcieVtM9nhj//4YCJacAWf+W8SCY0LVD
 gIgYQZmVyXP1JmvIjbB9Xa1sQGiAxcgbQOGqx9oM3+/fjhSMbAzEZLgieQV7i1lu9mxT
 iazg==
X-Gm-Message-State: AOJu0YwGvChdzGs3hT6ZsROI+zvjQe32xkOgWz9hNezLD0mAgiNdcZXw
 gknMopu01lfzzh0vGs3aQMo3lZzlgx4tOHXzupRk5ypJvVyy0lIma5/9geJMFKqwzdM8kad05od
 JojGD4iw9Eklk8bm2ESNPw3FKkJw9E8b6Bhac/zbWoLjpwsu/Bw1BoiYC8GyKpUyS37VFDypPzI
 PPQunBfOGHoFrHDCn3spk=
X-Gm-Gg: ATEYQzw40PQy+6P3HkhtHiPnfXkePgBo8CnuSYbRXUp9v42HH2H6wqLcWDtDkdle+84
 e+5iUEZrCrh2OGaiyoBY1WUb8UdR3KXU0zJzexCvQNWheiH+BjQhvON4pS3v61WobFgBqeVtldN
 a0H/UePkajMm50aaWxu5ccYH+NslFSYyELb51S1Rq8riSPv2Fq8BMByvHfjfwVRuyhbV24HxLrL
 ZtshhJe4IrSnfF/7FFeWnBExM9myCQkwfoTQ6Ncy7yQaercYTwrJT31L+7Y7mq9tYq1Uw==
X-Received: by 2002:a05:6512:3a8e:b0:5a2:a0b0:43 with SMTP id
 2adb3069b0e04-5a2ab803c42mr580094e87.14.1774600189026; 
 Fri, 27 Mar 2026 01:29:49 -0700 (PDT)
X-Received: by 2002:a05:6512:3a8e:b0:5a2:a0b0:43 with SMTP id
 2adb3069b0e04-5a2ab803c42mr580072e87.14.1774600188488; Fri, 27 Mar 2026
 01:29:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260326124612.2580985-1-david.marchand@redhat.com>
 <20260326113153.2bb2ef02@phoenix.local>
In-Reply-To: <20260326113153.2bb2ef02@phoenix.local>
From: David Marchand <david.marchand@redhat.com>
Date: Fri, 27 Mar 2026 09:29:36 +0100
X-Gm-Features: AQROBzAna_B-gOrV9Fq6_3JiVySG4i4LLXKC8uLs7Yi9XNIVMW6I4WDYChVeu1s
Message-ID: <CAJFAV8wAgFa-7voKtqwEARCo5tVxurWuoJd7J2zLi9P-ienujQ@mail.gmail.com>
Subject: Re: [PATCH] net/tap: fix close for partially configured port
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: iJKR1gxQn-Wg9f7EKMc_PNMHbADhHm6oGCsbpDIH7ww_1774600189
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

On Thu, 26 Mar 2026 at 19:32, Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> On Thu, 26 Mar 2026 13:46:11 +0100
> David Marchand <david.marchand@redhat.com> wrote:
>
> > In case no rxq has been set up (like when starting testpmd with no mempool
> > drivers), a crash happens in tap_dev_close:
> >
> > Thread 1 "dpdk-testpmd" received signal SIGSEGV, Segmentation fault.
> > 0x00007ffff7fad68b in tap_dev_close (dev=dev@entry=0x4c4a80
> >       <rte_eth_devices@INTERNAL>) at ../drivers/net/tap/rte_eth_tap.c:1111
> > 1111                  struct rx_queue *rxq = dev->data->rx_queues[i];
> >
> > (gdb) p dev->data->rx_queues
> > $4 = (void **) 0x0
> >
> > Fixes: 23e2387b49a1 ("net/tap: allocate queue structures dynamically")
> >
> > Signed-off-by: David Marchand <david.marchand@redhat.com>
> > ---
>
> It looked ok, but then the AI review spotted some stuff...
>
>
> Two issues:
>
> The txq variable is declared as struct rx_queue * but should be
> struct tx_queue *. Works by accident since it comes from a void *
> array and is only NULL-tested and passed to rte_free(), but the
> type is wrong.

Ah yes, will send a v2 quickly.

>
> Pre-existing: the loop runs to RTE_PMD_TAP_MAX_QUEUES but the
> rx_queues/tx_queues arrays are allocated with nb_rx_queues /
> nb_tx_queues entries by ethdev. If dev_configure() was called
> with fewer queues, the arrays are non-NULL but the access is
> out-of-bounds. Since these lines are being reworked anyway, worth
> adding a bounds check against nb_rx_queues/nb_tx_queues. The
> tap_queue_close() call is fine -- process_private fds are sized
> to RTE_PMD_TAP_MAX_QUEUES.

Indeed, and that makes the fix even simpler.


>
> Also missing Cc: stable@dpdk.org for a crash fix.

No, this is a fix for a 26.03 regression.


-- 
David Marchand

