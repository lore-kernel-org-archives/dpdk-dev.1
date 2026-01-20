Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCD5FD2ECF7
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Jan 2026 13:55:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 968F840156;
	Tue, 20 Jan 2026 14:55:52 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id D58764013F
 for <dev@dpdk.org>; Tue, 20 Jan 2026 14:55:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768917351;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nsGhrAnSdjuAK9b4G4C1N/IjJYavTfuzb2pJMKJe6bA=;
 b=Hf93D5NKXw+fMN1uGgGTj9BxO40geSMHr1wnEeKProPeyWN3/lkEQMtaw8iN+GiNNFDX5U
 mSw0pccLgHlEUl2neCPBiH4d8SoScHd6J/zZIdlAuJ4ak8FS6NdVX+Puxdiu2+LwOBB2Eu
 BE2ldMjfm9P+r+B+FFxly0slxr2mgvk=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-597-mo0lKa-NORe9m58W4hADxg-1; Tue, 20 Jan 2026 08:55:50 -0500
X-MC-Unique: mo0lKa-NORe9m58W4hADxg-1
X-Mimecast-MFC-AGG-ID: mo0lKa-NORe9m58W4hADxg_1768917348
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-59b6849824dso4199409e87.1
 for <dev@dpdk.org>; Tue, 20 Jan 2026 05:55:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768917348; x=1769522148;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nsGhrAnSdjuAK9b4G4C1N/IjJYavTfuzb2pJMKJe6bA=;
 b=NdjOd0hoEWkfw+GHphWmxF6KMUBbKb/c+rd+1G8qR4lgZKMnytlpCpKwnKkBAQXzEf
 NEAjYmC3cxWOSD+cpxWtjOkdvh6lZVxcATLeyjEll6XYNT/vSea5szy0oGIBurs3TXX1
 wnhFafQgYS45anOjb9D/oqQXEBhnnuhw7Uo1dZYnbT197rQM4SibLg/UwICEuPQMD+ql
 oKDeCes01CE8F8PuPezqRmdH/5mbvFEgbTFIFln0Q1IUHY/Z6t1suzetRrjD/K/kZ92m
 Fe70+00Tw6CNX8m7AZl68hjFwAaw8EpXX2pTTtmiU7M3tW6FRm+lKX/h+tPfcIroAGmR
 x1XQ==
X-Gm-Message-State: AOJu0YznkC4V4+nzqFY/1oIlyR2vImSWL9OzS14N8j2cfGbC4tgfz4th
 LVSE9Bu6fllEvrSg9SaS64iC+8EcUfw93IOXJhczD2AWJi+BhEgi3nclIVe1D6wFFjAH1aIkF2C
 GU9yc2LFZEF/xiDzpGhu7eEmfI488yglA9UoWcblEWAWDu4kOqjg1mfy0DXakmd3IiJjD1j52Ua
 GdUzQ4PiNcXzJoY0AfTL8=
X-Gm-Gg: AZuq6aIIE/WWBkZaQnb6xBHGa3hsinga2KQqSdS8BXeap5NhOjKoOX7+XzXcQlf5o1S
 UhhYgKqya0EVDQBUm/REOXKdVdYCCAGLYea+OZgknmiBABUrzT4IEQn2fDm9pwcTgsw6UvhMMnL
 WztBhk0dENstF1pUGTxuAsiV96dWdbxkCkNED3iRmWq7tlMd4dXDy6bl3xzAYVUt7Nk+RXvAogN
 pz5ZFNF5leeNthjcScOwASE09sLwRq8xZE4iPnWtv1kOa8QoHtKiQ==
X-Received: by 2002:ac2:4bcf:0:b0:59d:cd2b:9733 with SMTP id
 2adb3069b0e04-59dcd2b9799mr267868e87.13.1768917348103; 
 Tue, 20 Jan 2026 05:55:48 -0800 (PST)
X-Received: by 2002:ac2:4bcf:0:b0:59d:cd2b:9733 with SMTP id
 2adb3069b0e04-59dcd2b9799mr267855e87.13.1768917347418; Tue, 20 Jan 2026
 05:55:47 -0800 (PST)
MIME-Version: 1.0
References: <20251104080931.8102-1-shperetz@nvidia.com>
 <20251109142636.225031-1-shperetz@nvidia.com>
In-Reply-To: <20251109142636.225031-1-shperetz@nvidia.com>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Date: Tue, 20 Jan 2026 14:55:36 +0100
X-Gm-Features: AZwV_QgQCXlkLL8ANzNTasZg8lRME0m3ML9AwpGdZ5bNv56owxhe527jDzH_WAo
Message-ID: <CAO55cszLU=D4oybHCXYYoAsZC32shk-vr9oCyiqAo3fH3vNTrQ@mail.gmail.com>
Subject: Re: [PATCH v2] vhost: fix use-after-free race during cleanup
To: Shani Peretz <shperetz@nvidia.com>
Cc: dev@dpdk.org, stable@dpdk.org, Chenbo Xia <chenbox@nvidia.com>, 
 David Marchand <david.marchand@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: mjTyjkplTfMCZUdsSpy4Ob6miPXV82kjdT1RZiXEsV0_1768917348
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

On Sun, Nov 9, 2025 at 3:27=E2=80=AFPM Shani Peretz <shperetz@nvidia.com> w=
rote:
>
> This commit fixes a use-after-free that causes the application to crash
> on shutdown (detected by ASAN).
>
> The vhost library uses a background event dispatch thread that monitors
> fds with epoll. It runs in an infinite loop, waiting for I/O events
> and calling callbacks when they occur.
>
> During cleanup, a race condition existed:
>
>   Main Thread:                    Event Dispatch Thread:
>   1. Remove fds from fdset        while (1) {
>   2. Close file descriptors           epoll_wait() [gets interrupted]
>   3. Free fdset memory                [continues loop]
>   4. Continue...                      Accesses fdset...   CRASH
>                                   }
>
> There isn't explicit cleanup of the fdset structure.
> The fdset structue is allocated with rte_zmalloc() and the memory would

structure

> only be reclaimed at application shutdown when rte_eal_cleanup() is calle=
d,
> which invokes rte_eal_memory_detach() to unmap all the hugepage memory.
> Meanwhile, the event dispatch thread could still be running and accessing
> the fdset.
>
> The code had a `destroy` flag that the event dispatch thread checked,
> but it was never set during cleanup, and the code never waited for
> the thread to actually exit before freeing memory.
>
> To fix this, the commit implements `fdset_destroy()` that will set the
> destroy flag, wait for thread termination, and clean up all resources.
>
> The socket.c and vduse.c are updated to call fdset_destroy() when
> the last socket/device is unregistered.
>
> For vduse, reference counting was added to track the number of devices
> using the fdset. The fdset is destroyed when the last device is removed.

I believe the vduse change is unrelated.
Currently, once a vduse device has been created, we never destroy the fdset=
.

We can support destroying the vduse fdset once, but it should be in a
dedicated patch.
And it might not need to be a fix, even though I don't have a strong opinio=
n.

> Fixes: 0e38b42bf61c ("vhost: manage FD with epoll")
> Cc: stable@dpdk.org
>
> Signed-off-by: Shani Peretz <shperetz@nvidia.com>
>
>
>
> ----------
> v2:
> - Extended the fix to vduse.c, added reference counting and mutex to vdus=
e
>   structure to track the number of devices using the fdset
> - Call fdset_destroy() when last device is removed in vduse_device_destro=
y()
>   and in error paths of vduse_device_create()
> - Added mutex protection when checking/setting the destroy flag to preven=
t
>   race conditions in both fdset_event_dispatch() and fdset_destroy()
>
> ---
>  lib/vhost/fd_man.c | 45 ++++++++++++++++++++++++++++++++++++-
>  lib/vhost/fd_man.h |  1 +
>  lib/vhost/socket.c |  7 ++++++
>  lib/vhost/vduse.c  | 56 +++++++++++++++++++++++++++++++++++++---------
>  4 files changed, 98 insertions(+), 11 deletions(-)
>
> diff --git a/lib/vhost/fd_man.c b/lib/vhost/fd_man.c
> index f9147edee7..b4597dec75 100644
> --- a/lib/vhost/fd_man.c
> +++ b/lib/vhost/fd_man.c
> @@ -387,9 +387,52 @@ fdset_event_dispatch(void *arg)
>                         }
>                 }
>
> -               if (pfdset->destroy)
> +               pthread_mutex_lock(&pfdset->fd_mutex);
> +               bool should_destroy =3D pfdset->destroy;
> +               pthread_mutex_unlock(&pfdset->fd_mutex);
> +               if (should_destroy)
>                         break;
>         }
>
>         return 0;
>  }
> +
> +/**
> + * Destroy the fdset and stop its event dispatch thread.
> + */
> +void
> +fdset_destroy(struct fdset *pfdset)
> +{
> +       uint32_t val;
> +       int i;
> +
> +       if (pfdset =3D=3D NULL)
> +               return;
> +
> +       /* Signal the event dispatch thread to stop */
> +       pthread_mutex_lock(&pfdset->fd_mutex);
> +       pfdset->destroy =3D true;
> +       pthread_mutex_unlock(&pfdset->fd_mutex);
> +
> +       /* Wait for the event dispatch thread to finish */
> +       rte_thread_join(pfdset->tid, &val);
> +
> +       /* Close the epoll file descriptor */
> +       close(pfdset->epfd);
> +
> +       /* Destroy the mutex */
> +       pthread_mutex_destroy(&pfdset->fd_mutex);
> +
> +       /* Remove from global registry */
> +       pthread_mutex_lock(&fdsets_mutex);
> +       for (i =3D 0; i < MAX_FDSETS; i++) {
> +               if (fdsets[i] =3D=3D pfdset) {
> +                       fdsets[i] =3D NULL;
> +                       break;
> +               }
> +       }
> +       pthread_mutex_unlock(&fdsets_mutex);
> +
> +       /* Free the fdset structure */
> +       rte_free(pfdset);
> +}
> diff --git a/lib/vhost/fd_man.h b/lib/vhost/fd_man.h
> index eadcc6fb42..ed2109f3c8 100644
> --- a/lib/vhost/fd_man.h
> +++ b/lib/vhost/fd_man.h
> @@ -21,5 +21,6 @@ int fdset_add(struct fdset *pfdset, int fd,
>
>  void fdset_del(struct fdset *pfdset, int fd);
>  int fdset_try_del(struct fdset *pfdset, int fd);
> +void fdset_destroy(struct fdset *pfdset);
>
>  #endif
> diff --git a/lib/vhost/socket.c b/lib/vhost/socket.c
> index 9b4f332f94..0240da8ff0 100644
> --- a/lib/vhost/socket.c
> +++ b/lib/vhost/socket.c
> @@ -1141,6 +1141,13 @@ rte_vhost_driver_unregister(const char *path)
>                 count =3D --vhost_user.vsocket_cnt;
>                 vhost_user.vsockets[i] =3D vhost_user.vsockets[count];
>                 vhost_user.vsockets[count] =3D NULL;
> +
> +               /* Check if we need to destroy the vhost fdset */
> +               if (vhost_user.vsocket_cnt =3D=3D 0 && vhost_user.fdset !=
=3D NULL) {
> +                       fdset_destroy(vhost_user.fdset);
> +                       vhost_user.fdset =3D NULL;
> +               }
> +
>                 pthread_mutex_unlock(&vhost_user.mutex);
>                 return 0;
>         }
> diff --git a/lib/vhost/vduse.c b/lib/vhost/vduse.c
> index 68e56843fd..f255f717ab 100644
> --- a/lib/vhost/vduse.c
> +++ b/lib/vhost/vduse.c
> @@ -30,9 +30,15 @@
>
>  struct vduse {
>         struct fdset *fdset;
> +       int device_cnt;
> +       pthread_mutex_t mutex;
>  };
>
> -static struct vduse vduse;
> +static struct vduse vduse =3D {
> +       .fdset =3D NULL,
> +       .device_cnt =3D 0,
> +       .mutex =3D PTHREAD_MUTEX_INITIALIZER,
> +};
>
>  static const char * const vduse_reqs_str[] =3D {
>         "VDUSE_GET_VQ_STATE",
> @@ -683,19 +689,16 @@ vduse_device_create(const char *path, bool complian=
t_ol_flags)
>         const char *name =3D path + strlen("/dev/vduse/");
>         bool reconnect =3D false;
>
> -       if (vduse.fdset =3D=3D NULL) {
> -               vduse.fdset =3D fdset_init("vduse-evt");
> -               if (vduse.fdset =3D=3D NULL) {
> -                       VHOST_CONFIG_LOG(path, ERR, "failed to init VDUSE=
 fdset");
> -                       return -1;
> -               }
> -       }
> +       pthread_mutex_lock(&vduse.mutex);
> +       vduse.device_cnt++;
> +       pthread_mutex_unlock(&vduse.mutex);
>
>         control_fd =3D open(VDUSE_CTRL_PATH, O_RDWR);
>         if (control_fd < 0) {
>                 VHOST_CONFIG_LOG(name, ERR, "Failed to open %s: %s",
>                                 VDUSE_CTRL_PATH, strerror(errno));
> -               return -1;
> +               ret =3D -1;
> +               goto out_dec_cnt;
>         }
>
>         if (ioctl(control_fd, VDUSE_SET_API_VERSION, &ver)) {
> @@ -845,6 +848,19 @@ vduse_device_create(const char *path, bool compliant=
_ol_flags)
>
>         dev->cvq =3D dev->virtqueue[max_queue_pairs * 2];
>
> +       /* Only allocate when we know device creation will succeed */
> +       pthread_mutex_lock(&vduse.mutex);
> +       if (vduse.fdset =3D=3D NULL) {
> +               vduse.fdset =3D fdset_init("vduse-evt");
> +               if (vduse.fdset =3D=3D NULL) {
> +                       VHOST_CONFIG_LOG(path, ERR, "failed to init VDUSE=
 fdset");
> +                       pthread_mutex_unlock(&vduse.mutex);
> +                       ret =3D -1;
> +                       goto out_log_unmap;
> +               }
> +       }
> +       pthread_mutex_unlock(&vduse.mutex);
> +
>         ret =3D fdset_add(vduse.fdset, dev->vduse_dev_fd, vduse_events_ha=
ndler, NULL, dev);
>         if (ret) {
>                 VHOST_CONFIG_LOG(name, ERR, "Failed to add fd %d to vduse=
 fdset",
> @@ -861,6 +877,8 @@ vduse_device_create(const char *path, bool compliant_=
ol_flags)
>         return 0;
>
>  out_log_unmap:
> +       if (vduse.fdset !=3D NULL)
> +               fdset_del(vduse.fdset, dev->vduse_dev_fd);
>         munmap(dev->reconnect_log, sizeof(*dev->reconnect_log));
>  out_dev_destroy:
>         vhost_destroy_device(vid);
> @@ -870,6 +888,14 @@ vduse_device_create(const char *path, bool compliant=
_ol_flags)
>         ioctl(control_fd, VDUSE_DESTROY_DEV, name);
>  out_ctrl_close:
>         close(control_fd);
> +out_dec_cnt:
> +       pthread_mutex_lock(&vduse.mutex);
> +       vduse.device_cnt--;
> +       if (vduse.device_cnt =3D=3D 0 && vduse.fdset !=3D NULL) {
> +               fdset_destroy(vduse.fdset);
> +               vduse.fdset =3D NULL;
> +       }
> +       pthread_mutex_unlock(&vduse.mutex);
>
>         return ret;
>  }
> @@ -899,7 +925,17 @@ vduse_device_destroy(const char *path)
>
>         vduse_device_stop(dev);
>
> -       fdset_del(vduse.fdset, dev->vduse_dev_fd);
> +       if (vduse.fdset !=3D NULL)
> +               fdset_del(vduse.fdset, dev->vduse_dev_fd);
> +
> +       /* Check if we need to destroy the vduse fdset */
> +       pthread_mutex_lock(&vduse.mutex);
> +       vduse.device_cnt--;
> +       if (vduse.device_cnt =3D=3D 0 && vduse.fdset !=3D NULL) {
> +               fdset_destroy(vduse.fdset);
> +               vduse.fdset =3D NULL;
> +       }
> +       pthread_mutex_unlock(&vduse.mutex);
>
>         if (dev->vduse_dev_fd >=3D 0) {
>                 close(dev->vduse_dev_fd);
> --
> 2.34.1
>

