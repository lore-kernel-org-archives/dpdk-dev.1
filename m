Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 087B6F3D61C
	for <dpdk-dev@archiver.kernel.org>; Sun, 29 Mar 2026 18:14:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 31488402C3;
	Sun, 29 Mar 2026 20:14:57 +0200 (CEST)
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com
 [209.85.216.42]) by mails.dpdk.org (Postfix) with ESMTP id D6223400D6
 for <dev@dpdk.org>; Sun, 29 Mar 2026 20:14:55 +0200 (CEST)
Received: by mail-pj1-f42.google.com with SMTP id
 98e67ed59e1d1-3585ec417f6so1888320a91.1
 for <dev@dpdk.org>; Sun, 29 Mar 2026 11:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1774808095;
 x=1775412895; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=noo5DyJY3WNqQemTVb9cKfi9n71coNIj5IoSyyL5Xy0=;
 b=ovOPxTyC6nfgKvXICf3KByuH+l8VoieXbrUtC0G03u7lQ/BT3pKY6G0cP3KgitBTe0
 lXy2+iI6o/JUJtTa7aDxTG2+lw1CE1VXMtl51Y6QQWf6AkILmYlxGHd8U2UD3oU9C3AT
 lhECkFsJJJv9GILggrAaGp/2cOBSHx5n8x2KoeYOirUvU3eSoz/YBFIWqq8IgPXVarg2
 UeVA3g+G0LiGUOVlLxdjPeJeN32Qze+5uJPuRmIBB4YYR3GVVnh7IoOiPSUtH5KMMoO2
 p+y31XRD+W0FRT4nCKT0nPoagiLQ7tj11fVupx3PTTlyTcwE+Vt18FAGdDYISWyNRqvf
 xGOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774808095; x=1775412895;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=noo5DyJY3WNqQemTVb9cKfi9n71coNIj5IoSyyL5Xy0=;
 b=Myhua/8JcQmYSNzMG25f8Ptuv3N5Vi0w8Hsh2n2/MMflCGQI/CAouSZylFehdZLxo4
 7G3zR8Nd6kYpWGu4V6oMBf4CL9m0pnZ6jd5jEqGHRDL7JMF3GvkJR+0HBxm7WN4K/p0X
 qKmA+Yzo+dI3dD/dN19/WDFowzFLiGwey9S+rUhMcoXlCZzeZse8f2JtXKhnxtOUfmZs
 xAn8GwnFcPZB1H7utBIiltLBlxXUXJAOfQJaLzcvrAjlohV6pS9b+G3wzPvdo0ST4xj0
 ZY2qjl3vWTg6QMy6IVfz+18cMIpPA/WMNd1SJjFCFaIBhf+Hk9ale0Sd0jDq1nq3kK2a
 KLmA==
X-Forwarded-Encrypted: i=1;
 AJvYcCURtR5mhI1ots0QKVf4FrrJIh5pGtvn9GdyPLpp1Q9fNnhsu/zuvOabZRSdJNSqPGZICUU=@dpdk.org
X-Gm-Message-State: AOJu0YzVrkss2dMhLq3m1bKvyWFZ7Ou1f08ez3O2CTQvjWUvCuvnEUbK
 Nhv+GOXrWrs2UiTNLuOuVdXx1dygtcbS/LC1uQILY58VBKx8yAqfNQRMfau939+VqeY=
X-Gm-Gg: ATEYQzxCVXP76z8olPKCsund4PzDwjbX8T7F87d1KWSwK1Gz1n+IMVnDBkO+t2CzcBm
 yisefFwKvpzFxij57dmMMP1MB8ImBD0P0ceFO8LLpZWIskk5WvQJg4PX74xOllKJ29WWVzhlHX0
 2BbirZSrcA2gGiXhEJ2uiZ9tHCGxoTVzbTszawColaaCQFy81Kwe8TkXYHd5srTLJ1t+/1L9M0/
 bznbj8oFKXaN3HmS2ePYJ/D8x6/s3Hv8PwV729Aj2aoOTJLukta4Cuv4uN9SBiMNBbc2xhKQ9hD
 I6opfGbH4cLhfQDzG6BYRy0QcGVpnHJ5CvnKVgfQESMtzKXBjc6QnnW2sEkHI4TAbkEBJamgd5g
 xU/nqMjG51LrUNrLbEehXSXfF0CsYgtsRUavRF8luYkmsTaw2KPdRr0kunvYifqwUVKg/5vSlu1
 VmXFHCLxQbzB532zYcbCDNwtSd1b+cBrT9gcGaVZO7EdUqAw==
X-Received: by 2002:a17:90b:2884:b0:359:84a3:1942 with SMTP id
 98e67ed59e1d1-35c22902d8emr10699443a91.13.1774808094622; 
 Sun, 29 Mar 2026 11:14:54 -0700 (PDT)
Received: from phoenix.local ([104.202.29.139])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c769d8337d3sm1695582a12.8.2026.03.29.11.14.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Mar 2026 11:14:54 -0700 (PDT)
Date: Sun, 29 Mar 2026 11:14:44 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Eugenio =?UTF-8?B?UMOpcmV6?= <eperezma@redhat.com>
Cc: Maxime Coquelin <maxime.coquelin@redhat.com>, chenbox@nvidia.com,
 jasowang@redhat.com, david.marchand@redhat.com, dev@dpdk.org, Yongji Xie
 <xieyongji@bytedance.com>, mst@redhat.com
Subject: Re: [RFC v3 00/10] Add vduse live migration features
Message-ID: <20260329111444.01e857b4@phoenix.local>
In-Reply-To: <20260311065543.1354037-1-eperezma@redhat.com>
References: <20260311065543.1354037-1-eperezma@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

On Wed, 11 Mar 2026 07:55:33 +0100
Eugenio P=C3=A9rez <eperezma@redhat.com> wrote:

> This series introduces features to the VDUSE (vDPA Device in Userspace) d=
river
> to support Live Migration.
>=20
> Currently, DPDK does not support VDUSE devices live migration because the
> driver lacks a mechanism to suspend the device and quiesce the rings to
> initiate the switchover.  This series implements the suspend operation to
> address this limitation.
>=20
> Furthermore, enabling Live Migration for devices with control virtqueue n=
eeds
> two additional features.  Both of them are included in this series.
>=20
> * Address Spaces (ASID) support: This allows QEMU to isolate and intercep=
t the
>   device's CVQ. By doing so, QEMU is able to migrate the device status
>   transparently, without requiring the device to support state save and
>   restore.
> * QUEUE_ENABLE: This allows QEMU to control when the dataplane virtqueues=
 are
>   enabled.  This ensures the dataplane is started after the device
>   configuration has been fully restores via the CVQ.
>=20
> Last but not least, it enables the VIRTIO_NET_F_STATUS feature.  This all=
ows the
> device to signal the driver that it needs to send gratuitous ARP with
> VIRTIO_NET_S_ANNOUNCE, reducing the Live Migration downtime.
>=20
> v3:
> * Replace incorrect '%lx' DEBUG print format specifier with PRIx64
>=20
> v2:
> * Following latest comments on kernel series about VDUSE features, not ch=
ecking
>   API version but only check if VDUSE_GET_FEATURES success.
> * Move the start and last declarations in the braces as gcc 8 does not li=
ke
>   them interleaved with statements. Actually, I think the move was a mist=
ake in
>   the first version.
>   https://mails.dpdk.org/archives/test-report/2026-February/958175.html
>=20
> Eugenio P=C3=A9rez (1):
>   uapi: align VDUSE header for ASID
>=20
> Maxime Coquelin (6):
>   vhost: introduce ASID support
>   vhost: add VDUSE API version negotiation
>   vhost: add virtqueues groups support to VDUSE
>   vhost: add ASID support to VDUSE IOTLB operations
>   vhost: claim VDUSE support for API version 1
>   vhost: add net status feature to VDUSE
>=20
> Super User (3):
>   uapi: Align vduse.h for enable and suspend VDUSE messages
>   vhost: Support VDUSE QUEUE_READY feature
>   vhost: Support vduse suspend feature
>=20
>  kernel/linux/uapi/linux/vduse.h | 114 +++++++++++++++-
>  lib/vhost/iotlb.c               | 226 ++++++++++++++++++++------------
>  lib/vhost/iotlb.h               |  14 +-
>  lib/vhost/vduse.c               | 197 +++++++++++++++++++++++++---
>  lib/vhost/vduse.h               |   3 +-
>  lib/vhost/vhost.c               |  16 +--
>  lib/vhost/vhost.h               |  16 +--
>  lib/vhost/vhost_user.c          |  11 +-
>  8 files changed, 460 insertions(+), 137 deletions(-)
>=20

As an experiment tried Google Gemini with AGENTS file to review this patch.

Summary of Findings

  The patch series successfully introduces ASID support and VDUSE API versi=
on 1 features (virtqueue groups, net status, queue
  ready, and suspend) to the vhost library. However, there are a few correc=
tness issues, most notably a resource leak in the
  IOTLB initialization error path, and several style nits regarding pointer=
 comparisons.

  ---

  Correctness Bugs (High Priority)

  1. Resource Leak in vhost_user_iotlb_init (lib/vhost/iotlb.c)
  In Patch 02/10, the newly introduced vhost_user_iotlb_init function fails=
 to correctly clean up resources when one of the
  ASID IOTLB initializations fails.

    1 +int
    2 +vhost_user_iotlb_init(struct virtio_net *dev)
    3 +{
    4 +    int i;
    5 +
    6 +    for (i =3D 0; i < IOTLB_MAX_ASID; i++)
    7 +        if (vhost_user_iotlb_init_one(dev, i) < 0)
    8 +            goto fail;
    9 +
   10 +    return 0;
   11 +fail:
   12 +    while (i--)
   13 +    {
   14 +        rte_free(dev->iotlb[i]->pool);
   15 +        dev->iotlb[i]->pool =3D NULL;
   16 +    }
   17 +
   18 +    return -1;
   19 +}

  Issues:
   - Leak of iotlb structures: The loop only frees the pool member but does=
 not rte_free(dev->iotlb[i]).
   - Incomplete cleanup of the failed index: If vhost_user_iotlb_init_one(d=
ev, i) fails after allocating dev->iotlb[i] but
     before returning, the while (i--) loop will skip the current index i, =
leaking its resources entirely.
   - Zero-index failure: if i=3D0 fails, the while(i--) loop will not execu=
te at all, leaking all resources allocated for index
     0.

  Recommendation: The fail block should call vhost_user_iotlb_destroy(dev) =
or be rewritten to properly free both the pool and
  the iotlb structure for all indices up to and including the one that fail=
ed.

  2. Potential NULL Pointer Dereference in VDUSE_SUSPEND Handler (lib/vhost=
/vduse.c)
  In Patch 10/10, the VDUSE_SUSPEND case in vduse_events_handler accesses d=
ev->notify_ops without a NULL check, unlike the
  VDUSE_SET_VQ_READY handler in Patch 09/10.

   1 +    case VDUSE_SUSPEND:
   2 +        ...
   3 +        for (i =3D 0; dev->notify_ops->vring_state_changed &&
   4 +                i < dev->nr_vring; i++) {

  Issue: If dev->notify_ops is NULL, this will cause a segmentation fault. =
While DRIVER_OK is checked, it is safer and more
  consistent to explicitly check dev->notify_ops before access.

  ---

  Style and Process Compliance

  3. Implicit Pointer Comparisons
  The DPDK coding style (per AGENTS.md) requires explicit comparisons for p=
ointers (e.g., if (p =3D=3D NULL)). Several patches use
  implicit comparisons (if (!p)).

  Instances include:
   - Patch 02/10: if (!dev->iotlb[asid]) and if (!dev->iotlb[asid]->pool) i=
n vhost_user_iotlb_init_one.
   - Patch 09/10: if (!dev->notify_ops || !dev->notify_ops->vring_state_cha=
nged) in VDUSE_SET_VQ_READY handler.
   - Patch 09/10: if (!dev->notify_ops) in vduse_device_start.

  4. Confusing Log Message in VDUSE_SET_VQ_READY (lib/vhost/vduse.c)
  In Patch 09/10:

   1 +            VHOST_CONFIG_LOG(dev->ifname, ERR,
   2 +                "Unexpected ready message with feature %d",
   3 +                !!(dev->vduse_features &
   4 +                   RTE_BIT64(VDUSE_F_QUEUE_READY)));
  Since this is inside a !(dev->vduse_features & ...) block, it will always=
 log "feature 0". It would be clearer to state that
  the VDUSE_F_QUEUE_READY feature was not negotiated.

  5. Non-inclusive Naming in vduse_iotlb_miss (lib/vhost/vduse.c)
  Patch 02/10 and 05/10 modify vduse_iotlb_miss. While not introduced by th=
is patch, the function uses the term miss, which is
  generally acceptable but should be noted if a more descriptive term like =
iotlb_entry_fetch_failure is preferred in the
  future. (Note: This is a minor observation and does not strictly violate =
the prohibited terminology list).

  ---

  Additional Observations

   - UAPI Headers: The alignment with upcoming Linux kernel VDUSE headers (=
ASID, groups, suspend) is correctly handled in
     patches 01 and 08.
   - Experimental Tags: New internal logic is correctly added without expos=
ing new public APIs, so __rte_experimental tags
     were not required for these changes.
   - Static Linking: The use of supported_vduse_features as a static consta=
nt correctly avoids namespace pollution.

