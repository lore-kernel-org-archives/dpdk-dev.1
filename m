Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 497ACC5DF70
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Aug 2026 09:03:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1CF044027C;
	Tue, 18 Aug 2026 11:03:37 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 3B6D340269
 for <dev@dpdk.org>; Tue, 18 Aug 2026 11:03:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787043814;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PjbSjlwtPaILkh6QtbXaTX/F7E895j1kgn4tbiuUAjA=;
 b=VprJWrVojlUtMA/+e/zmh322hvbFao5cOPEwvuXUl6BILGvs8pFL9+Ao3NpI7Y2OUy32YM
 c60TT76qC9PjHWPBL/M/kio26qkLKw8n6+L0meq2ggv3xAkvmAbguc97UdQynRZ7n0XSv/
 2QlgOQ71l9+rjFGM9PAvARlTiMp4jxk=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-CGBNLH3XO52cyALoOPk9Xg-1; Tue, 18 Aug 2026 05:03:33 -0400
X-MC-Unique: CGBNLH3XO52cyALoOPk9Xg-1
X-Mimecast-MFC-AGG-ID: CGBNLH3XO52cyALoOPk9Xg_1787043812
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-cbb467e56aaso3148359a12.1
 for <dev@dpdk.org>; Tue, 18 Aug 2026 02:03:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787043812; x=1787648612;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PjbSjlwtPaILkh6QtbXaTX/F7E895j1kgn4tbiuUAjA=;
 b=Fb138bV49S4EVICqrUwIQ1XAoT53b2rZ1k5nJIyq4HW5tbZd83umX62rW6ksLng7/p
 ujFLfwXlGn2s/DWCu8pgfUbuAgdENL3NDwll/Mo2EIOpY0xW6/Z6ipVhYibFJYigCBPP
 sn58U8gVyTXeVNsEcj0Dphr1ioOgYqSyZxA2UL9BQJzcKwwU8VIXCxfPQUNLDvTJUjPZ
 Et3x3tlHaKVrYXANlFMnicxG0edEqQxcWtw16ntmr5OxNUZieRXHtodO25LSRjXQFSzy
 rCaS3r1elxzcFD3WV182SmbmAt/0oUOWyjJVwEDuILPNFbhgNDAm+r1Xk5dPALEe3+o/
 2sfw==
X-Gm-Message-State: AOJu0YweWFWH3fMJH92McXriJq+iKtXqt/J2fuMr+kBNZ0WoIoSXQNDN
 vGeAse4cGtu477R7xwMLDCdsnRdvv//a1/b1hQYiu10dYJXrx47fU1lH/g1gP9tDOP1KXnmWBn2
 H7TdwLm+qFJc9Yfp5pEXYRkeyPWrE7BHjXPkzUAc9kYWRV7cC/C3XCresMslYYcPgZoANbZEBPM
 yHzyFgN/Kjm5CQWs5vwbg=
X-Gm-Gg: AR+sD11WGEE3JQsY7H35nI6JsLem/8yWT2wRm5aIXEYxIaqcz4aYvfZ6eXwjTOeus5r
 R/5VRHCmMTI86EZSZU4pXksryRe7SXX1XmtCPv4CjX3v/ghFslhHtS/P0phyc6i6YSw+DTjPilt
 lNh+UTzXubBehix/jzxJXHNRgAvZK1QJcAdaIcOIoqx5E7v0tu7IKbVRdVNzruoplPV6JJ0/Sny
 nH1VVg90sMrE5JFZtodW36RwJIjuVz0rU69A1dBYNeb27p7C/Xmet4kNerIGMuwmaMFnqccMF9A
 +nbR6PPJaGY/I4WKB8vO3PbCTUaC0DJmdhGCrk+u6dY=
X-Received: by 2002:a05:6a21:9087:b0:3c3:9aff:7a67 with SMTP id
 adf61e73a8af0-3ccda66c136mr9862212637.17.1787043811850; 
 Tue, 18 Aug 2026 02:03:31 -0700 (PDT)
X-Received: by 2002:a05:6a21:9087:b0:3c3:9aff:7a67 with SMTP id
 adf61e73a8af0-3ccda66c136mr9862080637.17.1787043811337; Tue, 18 Aug 2026
 02:03:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260629120615.2701697-1-samaryadav5@gmail.com>
 <20260703102530.133813-1-samaryadav5@gmail.com>
In-Reply-To: <20260703102530.133813-1-samaryadav5@gmail.com>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Date: Tue, 18 Aug 2026 11:03:19 +0200
X-Gm-Features: AcwNN1X_ujeBRGzK7Jtu10AwDLTEvKIE0xJaYCnwaBSs_I1G3SF5sOKkkdo6_J0
Message-ID: <CAO55cswmCsfibO9hrAEX1VZGw6qOH+Pqa4NaTt8ghQLtj4RsTA@mail.gmail.com>
Subject: Re: [PATCH v3] net/virtio-user: fix eventfd sharing in secondary
 process
To: Samar Yadav <samaryadav5@gmail.com>
Cc: dev@dpdk.org, chenbox@nvidia.com, stable@dpdk.org, 
 stephen@networkplumber.org, tiwei.bie@intel.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: e9owfB4BPMby7pK2pc4_t4Wcr5fxbQYvh0qEutA1r3k_1787043812
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

Hello Samar,

On Fri, Jul 3, 2026 at 12:25=E2=80=AFPM Samar Yadav <samaryadav5@gmail.com>=
 wrote:
>
> virtio_user secondary processes cannot communicate with the vhost
> backend: the kick/call eventfds are opened by the primary and never
> shared, so a secondary's queue notification writes to an invalid fd
> and traffic stalls.
>
> Share the fds over a dedicated virtio-user multiprocess channel. The
> primary registers a process-wide MP action that returns a port's
> kick/call fds (looked up by port name); a secondary requests them at
> probe time, before the port is announced.
>
> The received fds are stored in eth_dev->process_private, which is
> per-process, instead of the primary-owned shared dev->kickfds and
> dev->callfds arrays; the secondary data path notifies the backend using
> its own kickfd. In the primary, the MP handler reads the fd arrays under
> dev->mutex, and the teardown path takes the same lock while closing and
> freeing them, so the two cannot race.
>
> Also fix the pre-existing pthread_mutex_init(&dev->mutex, NULL) call in
> virtio_user_dev_init(): POSIX requires PTHREAD_PROCESS_SHARED for a mutex
> stored in shared memory regardless of which processes actually lock it;
> use rte_thread_mutex_init_shared() as other multiprocess-aware drivers do=
.
>
> Fixes: 1c8489da561b ("net/virtio-user: fix multi-process support")
> Cc: tiwei.bie@intel.com
> Cc: stable@dpdk.org
>
> Signed-off-by: Samar Yadav <samaryadav5@gmail.com>
> ---
> v3:
> - Reorder new #includes: system headers first, then DPDK lib headers
>   (alphabetized), then local virtio_* headers, per project convention.
> - Name the "2" in eventfd count/index arithmetic (kick + call per queue)
>   as VIRTIO_USER_EVENTFDS_PER_QUEUE instead of a bare literal. Leaves
>   the pre-existing max_queue_pairs * 2 vring math untouched, since that
>   is a different multiplier (vrings per queue pair) and already matches
>   this file's existing style.
> - Name the 5-second MP reply timeout in virtio_user_sync_eventfds() as
>   VIRTIO_USER_MP_TIMEOUT_SEC with a comment on the rationale.
>
> v2:
> - Use rte_calloc() instead of rte_malloc() for the kick/call fd arrays
>   in virtio_user_sync_eventfds() so allocation failures are cleaner and
>   unset entries are zero-initialised before the explicit -1 sentinel loop=
.
>   (Stephen Hemminger)
> - Fix the pre-existing pthread_mutex_init(&dev->mutex, NULL) call in
>   virtio_user_dev_init() to use rte_thread_mutex_init_shared(), which
>   sets PTHREAD_PROCESS_SHARED as POSIX requires for a mutex in shared
>   memory. Add #include <rte_thread.h> to pull in the declaration.
>   (Stephen Hemminger)
>
>  .mailmap                                      |   1 +
>  .../net/virtio/virtio_user/virtio_user_dev.c  |  59 +++-
>  .../net/virtio/virtio_user/virtio_user_dev.h  |  23 ++
>  drivers/net/virtio/virtio_user_ethdev.c       | 276 +++++++++++++++++-
>  4 files changed, 350 insertions(+), 9 deletions(-)
>

The patch looks good to me.

Reviewed-by: Maxime Coquelin <maxime.coquelin@redhat.com>

Thanks,
Maxime

