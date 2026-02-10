Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7025EA3F2B
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Feb 2026 09:18:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 50F17402E7;
	Tue, 10 Feb 2026 10:18:03 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 8846F400D6
 for <dev@dpdk.org>; Tue, 10 Feb 2026 10:18:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770715082;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wW7GAFcibOFTAMTMxDDalIgcMF/tZ+T/nO8ZqOR1C4k=;
 b=Fph8wAZO6atxjZoKVAyh0Eq5hE2dMdPzQGeMrXKKRl2pxIFJBG+Q+faaBeiBQF/0Ysjc/n
 Og6sRoHD0JYNAqbXZbulb8MPxnawa6xvbe7sQzav33NiWg9cb/lXwXt7phMViSgpYhJoAX
 AJiwIH3Uss4cBO1RwFFRbqWX83spdVA=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-110-M0fd7MDHM5yAmcsxzWKgIg-1; Tue, 10 Feb 2026 04:17:58 -0500
X-MC-Unique: M0fd7MDHM5yAmcsxzWKgIg-1
X-Mimecast-MFC-AGG-ID: M0fd7MDHM5yAmcsxzWKgIg_1770715077
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-385bb7f429cso32239801fa.1
 for <dev@dpdk.org>; Tue, 10 Feb 2026 01:17:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770715077; x=1771319877;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wW7GAFcibOFTAMTMxDDalIgcMF/tZ+T/nO8ZqOR1C4k=;
 b=mXEY4W+CBTpciOpCQrgjYTxJrIi7gyCI3lDiXY38WkiNOC3uBOdU82DeOwLqE23hBx
 lzepSmAnLO2pGhIj5w8uFBO0c1cGsehBYbl/UxOso+Bsp63ALWTRdCv6SXr7DA8+2DUt
 NqDAYWA2Zbi8kEBpimdFm0Gd+kji3eTY7J9eDISeYdaco6FbF26xmD82CCiDQ1aid0NU
 8dZxs1gBo5QwwQYxq/kpbfylul35LB7ggZ114b4tSF1v95Jj/uPqPFw2LANQkKJTKk9a
 G+JGkQPaV3kIWgmnUJKF/A1P+hXKy0YlC9WCk0DaGwtu1QUNOkEgCzOe+fZQCYeAuRph
 EiLQ==
X-Gm-Message-State: AOJu0YyKy6yj3aZlQXar7GrlqMVsE0yvXyf4MFm1hsfZHKTYWymeDqHP
 3BU+2UHGJbNEzpKO8tRPVFJUrR0Dfth7i6Raj975eo/yFU3MqzPp3a+1FgTENXGaNWO4cZGlTAE
 dHEztcU+RaFuHwWYh6vn/JZPl1M5656jk03crrSTc0XyAU3vM1dVafe9LjagF7tK0Jkh5Jqrb7e
 kGnxBOPuKElQ1Z3MUzEgI=
X-Gm-Gg: AZuq6aLiPEPgh2BFXWHcOXA1+K1qaUmMoYkkrjHJ8Tp7DU7UGcCwh1duf01LezFS+hQ
 /tKrnibAkiffKWWVKiBpWemFjYq1Ls+ziHkjl7CJODF7TuT7iSb/D8XlTGQNIEay2ICqx4Mkn49
 SWF9tskZ/s1PNuvzGVp+z84GOifmHEsED0Vu56rABtDKTTpItrMAFYMXgmX4xCHV/2B4nfJxMh1
 59BCmaoLfqqW43RmSDYjXmXXUb+C1p28O4pDT0ogZRVJxwrN/ox44JD+KoXzOqp93tXEw==
X-Received: by 2002:a05:651c:b09:b0:386:e95f:edf0 with SMTP id
 38308e7fff4ca-386eefb584dmr4979321fa.27.1770715077104; 
 Tue, 10 Feb 2026 01:17:57 -0800 (PST)
X-Received: by 2002:a05:651c:b09:b0:386:e95f:edf0 with SMTP id
 38308e7fff4ca-386eefb584dmr4979181fa.27.1770715076566; Tue, 10 Feb 2026
 01:17:56 -0800 (PST)
MIME-Version: 1.0
References: <20260128122055.192104-1-ktraynor@redhat.com>
 <20260206172054.273858-1-ktraynor@redhat.com>
 <20260206172054.273858-3-ktraynor@redhat.com>
In-Reply-To: <20260206172054.273858-3-ktraynor@redhat.com>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 10 Feb 2026 10:17:45 +0100
X-Gm-Features: AZwV_QhHH_P4HWI0hKabx3M8oov0Ro3C3dKC8Ra5i-iDFihzLNLyaoQccMuAlCQ
Message-ID: <CAJFAV8w0ic1OzGHSmLecR4bGjPCxTWuYA_yCEoxqBSR28aKo5A@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] eal/linux: handle interrupt epoll events
To: Kevin Traynor <ktraynor@redhat.com>
Cc: dev@dpdk.org, thomas@monjalon.net, dsosnowski@nvidia.com, 
 viacheslavo@nvidia.com, stable@dpdk.org, Harman Kalra <hkalra@marvell.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: gANFOwNZQTlA59B3zzaiGsHx0ArKEj9F6jc89MIB9Ac_1770715077
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

Hello Kevin,

On Fri, 6 Feb 2026 at 18:21, Kevin Traynor <ktraynor@redhat.com> wrote:
>
> Add handling for epoll error and disconnect conditions EPOLLERR,
> EPOLLHUP and EPOLLRDHUP.
>
> These events indicate that the interrupt file descriptor is in
> an error state or there has been a hangup.
>
> Only do this for interrupts that are read in eal. Interrupts that
> are read outside eal should deal with different interrupt scenarios
> appropriate to their functionality. e.g. virtio interrupt handling
> has reconnect mechanisms for some cases.
>
> Also, treat no bytes read as an error condition.
>
> Bugzilla ID: 1873
> Fixes: af75078fece3 ("first public release")
> Cc: stable@dpdk.org

Cc: Harman.

>
> Signed-off-by: Kevin Traynor <ktraynor@redhat.com>
> ---
>  lib/eal/linux/eal_interrupts.c | 67 ++++++++++++++++++++++------------
>  1 file changed, 44 insertions(+), 23 deletions(-)
>
> diff --git a/lib/eal/linux/eal_interrupts.c b/lib/eal/linux/eal_interrupts.c
> index 9db978923a..68ca0f929e 100644
> --- a/lib/eal/linux/eal_interrupts.c
> +++ b/lib/eal/linux/eal_interrupts.c
> @@ -887,4 +887,26 @@ rte_intr_disable(const struct rte_intr_handle *intr_handle)
>  }
>
> +static void
> +eal_intr_source_remove_and_free(struct rte_intr_source *src)
> +{
> +       struct rte_intr_callback *cb, *next;
> +
> +       /* Remove the interrupt source */
> +       rte_spinlock_lock(&intr_lock);
> +       TAILQ_REMOVE(&intr_sources, src, next);
> +       rte_spinlock_unlock(&intr_lock);
> +
> +       /* Free callbacks */
> +       for (cb = TAILQ_FIRST(&src->callbacks); cb; cb = next) {
> +               next = TAILQ_NEXT(cb, next);
> +               TAILQ_REMOVE(&src->callbacks, cb, next);
> +               free(cb);
> +       }
> +
> +       /* Free the interrupt source */
> +       rte_intr_instance_free(src->intr_handle);
> +       free(src);
> +}
> +
>  static int
>  eal_intr_process_interrupts(struct epoll_event *events, int nfds)
> @@ -952,4 +974,16 @@ eal_intr_process_interrupts(struct epoll_event *events, int nfds)
>
>                 if (bytes_read > 0) {
> +                       /**
> +                        * Check for epoll error or disconnect events for
> +                        * interrupts that are read directly in eal.
> +                        */
> +                       if (events[n].events & (EPOLLERR | EPOLLHUP | EPOLLRDHUP)) {
> +                               EAL_LOG(INFO, "Disconnect condition on fd %d "

This is an anormal situation, I would make this log level the same as
other logs below.

The fact that the interrupt fd gets into this state should be
something to report and investigate.


> +                                       "(events=0x%x), removing from epoll",
> +                                       events[n].data.fd, events[n].events);
> +                               eal_intr_source_remove_and_free(src);
> +                               return -1;
> +                       }
> +
>                         /**
>                          * read out to clear the ready-to-be-read flag
> @@ -957,5 +991,7 @@ eal_intr_process_interrupts(struct epoll_event *events, int nfds)
>                          */
>                         bytes_read = read(events[n].data.fd, &buf, bytes_read);
> -                       if (bytes_read < 0) {
> +                       if (bytes_read > 0) {
> +                               call = true;
> +                       } else if (bytes_read < 0) {
>                                 if (errno == EINTR || errno == EWOULDBLOCK)
>                                         continue;
> @@ -965,27 +1001,12 @@ eal_intr_process_interrupts(struct epoll_event *events, int nfds)
>                                         events[n].data.fd,
>                                         strerror(errno));
> -                               /*
> -                                * The device is unplugged or buggy, remove
> -                                * it as an interrupt source and return to
> -                                * force the wait list to be rebuilt.
> -                                */
> -                               rte_spinlock_lock(&intr_lock);
> -                               TAILQ_REMOVE(&intr_sources, src, next);
> -                               rte_spinlock_unlock(&intr_lock);
> -
> -                               for (cb = TAILQ_FIRST(&src->callbacks); cb;
> -                                                       cb = next) {
> -                                       next = TAILQ_NEXT(cb, next);
> -                                       TAILQ_REMOVE(&src->callbacks, cb, next);
> -                                       free(cb);
> -                               }
> -                               rte_intr_instance_free(src->intr_handle);
> -                               free(src);
> -                               return -1;
> -                       } else if (bytes_read == 0)
> -                               EAL_LOG(ERR, "Read nothing from file "
> +                       } else { /* bytes == 0 */

"bytes_read == 0", or remove this comment as the code is quite compact
and leaves little space for wondering what this else block is about.


> +                               EAL_LOG(WARNING, "Read nothing from file "

I would keep this log at the same level than the < 0 condition.
It seems the same type of error.

>                                         "descriptor %d", events[n].data.fd);

And avoid splitting the format string.


> -                       else
> -                               call = true;
> +                       }
> +                       if (bytes_read <= 0) {
> +                               eal_intr_source_remove_and_free(src);
> +                               return -1;
> +                       }
>                 }
>
> --
> 2.52.0
>

Except those nits, the fix looks correct.

Acked-by: David Marchand <david.marchand@redhat.com>




-- 
David Marchand

