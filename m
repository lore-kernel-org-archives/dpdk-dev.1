Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDEEEEB7ECA
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Mar 2026 11:09:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D2F90402E4;
	Wed,  4 Mar 2026 12:09:55 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id EBDC6402A9
 for <dev@dpdk.org>; Wed,  4 Mar 2026 12:09:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772622593;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gltW7gUk8XHR7SKbRUSEZEbF3xYCZbZLy2Sicbapq1c=;
 b=DFraUb1dl3cgMrclFqZr9BPThL9xY/uParVC1fPGhLczHO9NyEhLQ8jnTaEAwQVvB+YY63
 1NvlylRLh1a1LChE6V0QwcLunWChpBdUZMDqgYJm4lokShdRWl1W+rR4oILaeZB7tE3CXr
 vdMk4AjCtyYag34dIcTRjWt2QiyrjkM=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-183-JwSz21oFP-ip9lEDmf-3Xw-1; Wed, 04 Mar 2026 06:09:51 -0500
X-MC-Unique: JwSz21oFP-ip9lEDmf-3Xw-1
X-Mimecast-MFC-AGG-ID: JwSz21oFP-ip9lEDmf-3Xw_1772622590
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-389fef1b721so55623891fa.2
 for <dev@dpdk.org>; Wed, 04 Mar 2026 03:09:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772622590; x=1773227390;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gltW7gUk8XHR7SKbRUSEZEbF3xYCZbZLy2Sicbapq1c=;
 b=ZKxQZw3Lz0zqFX5Q83ZnFWeMafp9q7ySS5+JxMzizb3wN6+aS/1RDI8ytQ3dNBHYUG
 ayTWl05WrW4GhbQAmHG8L0W0tAyyQZryFt/IuphDbTA5jr4BU+0SeznkiBURzbZkcbH1
 ZYbiorgXPM2aET1RugTBnC35mQpo6omy5cJKS7VUbg+xOeNg++3z40Wh2sAALOilbbKk
 PiPc1+AuPVx+nT/dhBe0h4ci+wiYq126birDlVp5gUdXC/O2w7O4S3JdOTcVgehViIWs
 jsJmYIGgyhbpulxODK9F2R/KR6SFmsJb5ylDPfSSgOPd+A+mJqQv3A7yo/Z2RFtVfEsK
 ukCg==
X-Gm-Message-State: AOJu0YyliW/cWi9tZWdl2eP23QqQqAUaYwg+RGld71T/JBZa5QhBb8z2
 q4a8fEUUBWB+9E5p+GccNcLQRIN9dORUsTQmHEVHSTZT2upSyyliQadLqY+6QS7O4wxE7rZuOrI
 epip+Uzmd808nbThyubw8h7HC1RPksgROmQrbnrebZYB7IceERoszCtdfm9ZXyyzXfPBImgFUhD
 r2ke4EalAJdqbSvH6KZmE=
X-Gm-Gg: ATEYQzzcmUyJz3SYx/54u9akklAKtJ2LImjfSTkdpuvI4BsjFaA0GymKUexojCrF3OD
 YPGw3psLouUVpiOYe+ZY1GVWpjJ84OdMKU3ng71ReVn8K+WuPx1ds8O4QYY7E0w8SXss3bKCl1D
 0PjyaZL2Et3HIPxcd9dCuUgY6o50YaDbncxLmct8nPSesVsdDiwJiOcZdmCG4K8LJSUANUolYaC
 DdfM/OODG+j0tfhfNAVcA30f45irqwx2i00BguBzChuCNfRT6AHKBggU8l5snPKlNZpWA==
X-Received: by 2002:a05:651c:1545:b0:386:91a1:f207 with SMTP id
 38308e7fff4ca-38a2c55f9cfmr13947171fa.2.1772622590191; 
 Wed, 04 Mar 2026 03:09:50 -0800 (PST)
X-Received: by 2002:a05:651c:1545:b0:386:91a1:f207 with SMTP id
 38308e7fff4ca-38a2c55f9cfmr13946901fa.2.1772622589730; Wed, 04 Mar 2026
 03:09:49 -0800 (PST)
MIME-Version: 1.0
References: <20260128122055.192104-1-ktraynor@redhat.com>
 <20260303185818.28689-1-ktraynor@redhat.com>
In-Reply-To: <20260303185818.28689-1-ktraynor@redhat.com>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 4 Mar 2026 12:09:38 +0100
X-Gm-Features: AaiRm51rY7cK-PEjKI02EEIhZ4AGDFJL6yWlzB1jn8QjoyaAEfTxloAqbz2-pYg
Message-ID: <CAJFAV8xJgahk5n7AZUvJo7YHUJ+Ax1sxYYX7+Jjc8oK1gFw=Jw@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] interrupt disconnect/error event handling
To: Kevin Traynor <ktraynor@redhat.com>
Cc: dev@dpdk.org, thomas@monjalon.net, dsosnowski@nvidia.com, 
 viacheslavo@nvidia.com, hkalra@marvell.com, stephen@networkplumber.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: oIrSsS4g7ePXkdMbSZqgwsbmCZm39E0vDE7Alsh23kg_1772622590
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

On Tue, 3 Mar 2026 at 19:58, Kevin Traynor <ktraynor@redhat.com> wrote:
>
> These patches are to fix some issues with epoll event handling for
> EPOLLERR/EPOLLRDHUP/EPOLLHUP.
>
> 1/3: handles these disconnect/error events for interrupts that are read
> in eal
>
> 2/3: provides an internal API for interrupt callbacks to get the interrupt
> events for the active interrupt
>
> 3/3: deal with the observed issue as reported in
> https://bugs.dpdk.org/show_bug.cgi?id=1873 where mlx5 devx interrupts
> cause a busy-loop and 100% CPU of dpdk-intr thread.
>
> v5:
> - 2/3 changed API to rte_intr_active_event_flags() and made internal.
>   used RTE_BIT32() for defines. Added Cc: stable. Kept Acks as no
>   functional changes.
>
> v4:
> Updated to allow for case where devx interrupt handler may handle
> multiple completions during one interrupt call, leading to no data being
> read in a subsequent call as flagged by Slava.
>
> - 1/3 No change
> - 2/3 New API rte_intr_active_events() to get interrupt events
> - 3/3 Use new API in mlx5 devx interrupt handler to detect if
>   disconnect/error events and if so unregister the callback
>
> v3:
> - 1/2 and 2/2 fix some coding nits (Stephen/AI/David)
> - 2/2 Make log level consistant (David)
>
> v2:
> - Only handle disconnect/error epoll events when the read is done in eal
>   interrupt code. This is to allow interrupt handlers like virtio deal
>   with disconnects in an appropriate
> - Detect if not data is read in the mlx dex interrupt and if so unregister
>   the callback
>
> Kevin Traynor (3):
>   eal/linux: handle interrupt epoll events
>   eal/interrupt: add interrupt event info
>   net/mlx5: check devx disconnect/error interrupt events
>
>  drivers/net/mlx5/linux/mlx5_ethdev_os.c |  20 +++++
>  lib/eal/freebsd/eal_interrupts.c        |   7 ++
>  lib/eal/include/rte_interrupts.h        |  21 +++++
>  lib/eal/linux/eal_interrupts.c          | 103 +++++++++++++++++-------
>  lib/eal/windows/eal_interrupts.c        |   7 ++
>  5 files changed, 131 insertions(+), 27 deletions(-)

Series applied, thanks Kevin.


-- 
David Marchand

