Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1673F33A62
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Mar 2026 13:51:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 11B0340A70;
	Thu,  5 Mar 2026 14:51:32 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 057C040A6F
 for <dev@dpdk.org>; Thu,  5 Mar 2026 14:51:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772718690;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nyk7GIEak8nVLPgAVSzrUSArY6H0tm4ChsNodIZL62Y=;
 b=DDtkpdE01i1ImMr2AP6dvDRPmlgV12SfKMXPSF0ccqoHwn6NzMC/5AmrP2NBvtSujT+XWl
 qFDL6qCByMhS4QTZc2CziZQDbmaapYOzMTDcCDUiCxc2ZztgsS2b8jBnwrU7ZWK9KqOCaG
 yum4uuMtGmpdWGKHcJfXFr0ADv+NgqI=
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com
 [74.125.82.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-455-NjcWWjB6MMOsrXvBZAEF5A-1; Thu, 05 Mar 2026 08:51:29 -0500
X-MC-Unique: NjcWWjB6MMOsrXvBZAEF5A-1
X-Mimecast-MFC-AGG-ID: NjcWWjB6MMOsrXvBZAEF5A_1772718688
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-126e8ee6227so13563612c88.0
 for <dev@dpdk.org>; Thu, 05 Mar 2026 05:51:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772718688; x=1773323488;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nyk7GIEak8nVLPgAVSzrUSArY6H0tm4ChsNodIZL62Y=;
 b=l9qBxpOH3bl8rjRIfOH+yyFE7NRVKp723GANAOB7g1Qkv4x3/GorjjqD1IXWHIkPRe
 Pds+hWeBhzeK3JTiVFpb+62flLKuFhaDTsBIboaEJkT7ctck+VuDNnVGZiFBtkwxznHS
 UZ+LE/YugtiS+RQIyHCQhwb2v60MBcvSshqaklgNVxVdlosCzL3EWU7k64/8IQY0ZVD6
 JCKtomL8BtUg5qFcFUSTUZUup1mApMmS0Ek2SGoA4zhigkGlDpW1fegA+754c+Ly78j8
 usmNhVPHRf6lvlfEJRnQPCmQdXJ7lWDbWdwF4ypRBNQV8A9+OB7VJoI/g9O9VTAsRH3c
 kYBg==
X-Gm-Message-State: AOJu0YxoLozBYlm1g4MIEIoB2Xjzz7zpmgzspkvKAZOaj6ZG28b4BlUv
 K5wHfgggiPjwaPaTjtkjsspRkmHLD1MdK57QHUzb5vqa9OddDC+luZ1mKl1aH6Hkra0hbDlUMkX
 Gw8p0+s1qzty3KbdknWIP4/2eQMEvW1VAglT6t7DXNWDREK58oss7dmeAKShFlI/l9P1ShQexL9
 NGJxFMooFUt9QRIs0llN0=
X-Gm-Gg: ATEYQzwxvzElzo90luUn/vgN3OKP12Dbx4GhPwMLpMdVA2RbjNmOndD2OA2kcAxNawn
 M/AU4UtbVKYCbV0AyUHVaSZ1T84/IKAZUmA6s6epumHVXgbWtlypqVGurLrk6smta1io+QjTJah
 Klmy8xlC83ab4vLE/1NS8W3SmsLOO/Y631BSiykoAyaLv6NEht2FG6dcvxz0io7c9BmGE6WUGHU
 EjBtBvuqvKO/1/Cc+zvi+yUwEXjjmmFP/Gb5eRuIs713QD4ZLRUFkOO3UIaJRmuhQ==
X-Received: by 2002:a05:7022:926:b0:119:e55a:9c03 with SMTP id
 a92af1059eb24-128b70d24e3mr2123125c88.31.1772718688119; 
 Thu, 05 Mar 2026 05:51:28 -0800 (PST)
X-Received: by 2002:a05:7022:926:b0:119:e55a:9c03 with SMTP id
 a92af1059eb24-128b70d24e3mr2123099c88.31.1772718687569; Thu, 05 Mar 2026
 05:51:27 -0800 (PST)
MIME-Version: 1.0
References: <20251104080931.8102-1-shperetz@nvidia.com>
 <20260129083435.5054-1-shperetz@nvidia.com>
 <CAO55csyz16vSNQdnsqan+q+KHKyrEA_D-6qgdQACQLmDODV5iA@mail.gmail.com>
In-Reply-To: <CAO55csyz16vSNQdnsqan+q+KHKyrEA_D-6qgdQACQLmDODV5iA@mail.gmail.com>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Date: Thu, 5 Mar 2026 14:51:15 +0100
X-Gm-Features: AaiRm51T9-4fWklzr0qJXIblgdBo9f1jgspNct25KhsU303ksZpF0Pca0gTBob0
Message-ID: <CAO55csz7GxodnKK0qYjY+MeruPm0_BG+BBGgkyuGmpiYsCT0DA@mail.gmail.com>
Subject: Re: [PATCH v3] vhost: fix use-after-free race during cleanup
To: Shani Peretz <shperetz@nvidia.com>
Cc: dev@dpdk.org, stable@dpdk.org, Chenbo Xia <chenbox@nvidia.com>, 
 David Marchand <david.marchand@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: eBEFH-ZjcmvmMoJ9DY8M5uwfrJ72g8MN3qFshOWiSDs_1772718688
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Applied to next-virtio/for-next-net.

Thanks,
Maxime

On Thu, Mar 5, 2026 at 11:47=E2=80=AFAM Maxime Coquelin
<maxime.coquelin@redhat.com> wrote:
>
> On Thu, Jan 29, 2026 at 9:35=E2=80=AFAM Shani Peretz <shperetz@nvidia.com=
> wrote:
> >
> > This commit fixes a use-after-free that causes the application to crash
> > on shutdown (detected by ASAN).
> >
> > The vhost library uses a background event dispatch thread that monitors
> > fds with epoll. It runs in an infinite loop, waiting for I/O events
> > and calling callbacks when they occur.
> >
> > During cleanup, a race condition existed:
> >
> >   Main Thread:                    Event Dispatch Thread:
> >   1. Remove fds from fdset        while (1) {
> >   2. Close file descriptors           epoll_wait() [gets interrupted]
> >   3. rte_eal_cleanup()                [continues loop]
> >   4. Unmap hugepages                  Accesses fdset...   CRASH
> >                                   }
> >
> > There was no explicit cleanup of the fdset structure.
> > The fdset structure is allocated with rte_zmalloc() and the memory woul=
d
> > only be reclaimed at application shutdown when rte_eal_cleanup() is cal=
led,
> > which invokes rte_eal_memory_detach() to unmap all the hugepage memory.
> > Meanwhile, the event dispatch thread could still be running and accessi=
ng
> > the fdset.
> >
> > The code had a `destroy` flag that the event dispatch thread checked,
> > but it was never set during cleanup, and the code never waited for
> > the thread to actually exit before freeing memory.
> >
> > To fix this, the commit implements fdset_destroy() that sets the destro=
y
> > flag with mutex protection, waits for thread termination, and cleans up
> > all resources including the fdset memory.
> >
> > Update socket.c to call fdset_destroy() when the last vhost-user socket
> > is unregistered.
> >
> > Fixes: 0e38b42bf61c ("vhost: manage FD with epoll")
> > Cc: stable@dpdk.org
> >
> > Signed-off-by: Shani Peretz <shperetz@nvidia.com>
> >
> > -----------------
> > v3:
> > removed vduse implementation from this fix
> >
> > ---
> >  lib/vhost/fd_man.c | 45 ++++++++++++++++++++++++++++++++++++++++++++-
> >  lib/vhost/fd_man.h |  1 +
> >  lib/vhost/socket.c |  7 +++++++
> >  3 files changed, 52 insertions(+), 1 deletion(-)
> >
> Reviewed-by: Maxime Coquelin <maxime.coquelin@redhat.com>
>
> Thanks,
> Maxime

