Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBE7DC02196
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Feb 2025 13:18:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 800F840265;
	Tue,  4 Feb 2025 14:18:48 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 2B9CF4025D
 for <dev@dpdk.org>; Tue,  4 Feb 2025 14:18:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738675126;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SRtp6PCaIVHCYN/GcVe0pdZTfBvuVC0RTzeoAhuTiOU=;
 b=P0vODH8yRH8w1oLtD9YQyR8WPYDc6x6UORqozl/2+JxgdOY4IX3karT7V1FDb0TQ9AZV32
 4QNhOFalaVAxSyvj9AfczRlAP6XgR51UmUItCe8d+WGaUgglkP8U3RIL/tNG/NgK3g5CL0
 ZSlLDDQG0yhn591RtG2TWyF3E2bOo/0=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-z9ZSvA04NFa-eI3Eo4SNaA-1; Tue, 04 Feb 2025 08:18:45 -0500
X-MC-Unique: z9ZSvA04NFa-eI3Eo4SNaA-1
X-Mimecast-MFC-AGG-ID: z9ZSvA04NFa-eI3Eo4SNaA
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-306007d101dso37258081fa.2
 for <dev@dpdk.org>; Tue, 04 Feb 2025 05:18:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738675124; x=1739279924;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SRtp6PCaIVHCYN/GcVe0pdZTfBvuVC0RTzeoAhuTiOU=;
 b=UYrZCOEuJN30u+V9ZGCuEchy8D+CBstJpQF/IIZH1TmMBaU3FJp2awkbH+ObUtiaPI
 2ztbrQwssvr+l82ZnhDixX1MoPcNbNCbZZghy6Dk37zureQsrUPSaOT4CYj1EXLxljGw
 lAIR1O3OqgniE0dHLQw7pLL9cNcVYKQO78gFpTIoMtTT9Wja24BnehICwuX3OipM5ijP
 Dh0TaCK0DLimexPxDLc0wzMqtkGdS0faCPt3FB7XUzIr06Q08D0zlQt1yX71XIMZjDqP
 jdmszHp/o25xR8WcyP66ImYomH6KXIdVWEJ82cjJsOrV6gDtBDrY7sxYBtc8tyioWGb4
 +X6Q==
X-Gm-Message-State: AOJu0YzDsEqXLjBbs6pd78dUAhSkGYAjTVOvQSSsRNF+wEtxvMD2jyc5
 2cMQYlZUdJ9Mrpp0yEXXEK2Zcz+A96qrLhdnB3yQt+PHzZPnnz0No8SdYpvu1zk/OmRKWyZuNhI
 6S75ji+NdZAxhpLRTq1g6zDbVxthj2MmuwdKxP8uhpAw8fCKPeLAvIMjUijm298We0jZXdK1lql
 t5BsSpABfrRnxYXlM=
X-Gm-Gg: ASbGncvPdcC7BsHfP0yyBl4sBoLHjPOWjgAoa3adQdTzEdjfVSnnqm+IM4CJuiruG8a
 unKJqg4taL5CPOR2Hn8NQhmnJAdh7wWHeXX5aNHX60cMkPdxJPOEZAMwpBoTULa3x
X-Received: by 2002:a05:651c:983:b0:302:1c90:58d9 with SMTP id
 38308e7fff4ca-307968eb3bcmr85197051fa.16.1738675123822; 
 Tue, 04 Feb 2025 05:18:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFC8Yb6vD002FvtCaPUum6/5EmVdET+ChjijMTuAlMz4b1vyM9eN2ouyVl3IP2QTrh5PjxduQVG6VSZUXgjT2Q=
X-Received: by 2002:a05:651c:983:b0:302:1c90:58d9 with SMTP id
 38308e7fff4ca-307968eb3bcmr85196951fa.16.1738675123415; Tue, 04 Feb 2025
 05:18:43 -0800 (PST)
MIME-Version: 1.0
References: <20241224154958.146852-1-maxime.coquelin@redhat.com>
In-Reply-To: <20241224154958.146852-1-maxime.coquelin@redhat.com>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 4 Feb 2025 14:18:32 +0100
X-Gm-Features: AWEUYZlwiAxpdf8YbL-4dZiHKq2X_4aZ4De6GIn4eDu_isf4KMUHlNXq5Wn98nY
Message-ID: <CAJFAV8zwCx+Xsa12TaLye3A9dSSSbt_T_-cc6Lc71oNyLv9=nw@mail.gmail.com>
Subject: Re: [RFC 0/3] Vhost: fix FD entries cleanup
To: Maxime Coquelin <maxime.coquelin@redhat.com>, chenbox@nvidia.com
Cc: dev@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 3S9DdBoRsjophqNh5QlOnRPwOA0qzVTXTM-I7irWE8k_1738675124
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

Hello vhost maintainers,

On Tue, Dec 24, 2024 at 4:50=E2=80=AFPM Maxime Coquelin
<maxime.coquelin@redhat.com> wrote:
>
> The vhost FD manager provides a way for the read/write
> callbacks to request removal of their associated FD from
> the epoll FD set. Problem is that it is missing a cleanup
> callback, so the read/write callback requesting the removal
> have to perform cleanups before the FD is removed from the
> FD set. It includes closing the FD before it is removed
> from the epoll FD set.
>
> This series introduces a new cleanup callback which, if
> implemented, is closed right after the FD is removed from
> FD set.
>
> Maxime Coquelin (3):
>   vhost: add cleanup callback to FD entries
>   vhost: fix vhost-user socket cleanup order
>   vhost: improve VDUSE reconnect handler cleanup
>
>  lib/vhost/fd_man.c | 16 ++++++++++++----
>  lib/vhost/fd_man.h |  3 ++-
>  lib/vhost/socket.c | 46 ++++++++++++++++++++++++++--------------------
>  lib/vhost/vduse.c  | 16 +++++++++++-----
>  4 files changed, 51 insertions(+), 30 deletions(-)

I tried this series, and it fixes the error log I reported.

On the other hand, I wonder if we could do something simpler.

The fd is only used by the registered handlers.
If a handler reports that it does not want to watch this fd anymore,
then there is no remaining user in the vhost library for this fd.

So my proposal would be to rename the "remove" flag as a "close" flag:

@@ -12,7 +12,7 @@ struct fdset;

 #define MAX_FDS 1024

-typedef void (*fd_cb)(int fd, void *dat, int *remove);
+typedef void (*fd_cb)(int fd, void *dat, int *close);

 struct fdset *fdset_init(const char *name);

And defer closing to fd_man.
Something like:

@@ -367,9 +367,9 @@ fdset_event_dispatch(void *arg)
                        pthread_mutex_unlock(&pfdset->fd_mutex);

                        if (rcb && events[i].events & (EPOLLIN |
EPOLLERR | EPOLLHUP))
-                               rcb(fd, dat, &remove1);
+                               rcb(fd, dat, &close1);
                        if (wcb && events[i].events & (EPOLLOUT |
EPOLLERR | EPOLLHUP))
-                               wcb(fd, dat, &remove2);
+                               wcb(fd, dat, &close2);
                        pfdentry->busy =3D 0;
                        /*
                         * fdset_del needs to check busy flag.
@@ -381,8 +381,10 @@ fdset_event_dispatch(void *arg)
                         * fdentry not to be busy, so we can't call
                         * fdset_del_locked().
                         */
-                       if (remove1 || remove2)
+                       if (close1 || close2) {
                                fdset_del(pfdset, fd);
+                               close(fd);
+                       }
                }

                if (pfdset->destroy)


And the only thing to move out of the socket and vduse handlers is the
close(fd) call.

Like:

@@ -303,7 +303,7 @@ vhost_user_server_new_connection(int fd, void
*dat, int *remove __rte_unused)
 }

 static void
-vhost_user_read_cb(int connfd, void *dat, int *remove)
+vhost_user_read_cb(int connfd, void *dat, int *close)
 {
        struct vhost_user_connection *conn =3D dat;
        struct vhost_user_socket *vsocket =3D conn->vsocket;
@@ -313,8 +313,7 @@ vhost_user_read_cb(int connfd, void *dat, int *remove)
        if (ret < 0) {
                struct virtio_net *dev =3D get_device(conn->vid);

-               close(connfd);
-               *remove =3D 1;
+               *close =3D 1;

                if (dev)
                        vhost_destroy_device_notify(dev);


Maxime, Chenbo, opinions?


--=20
David Marchand

