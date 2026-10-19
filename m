Received: from smtp.lore.kernel.org (ip-10-30-226-214.us-west-2.compute.internal [10.30.226.214])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F390606A319
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 Oct 2026 14:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eLp7u3V8
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19BBECCF2E6
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 Oct 2026 14:46:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EC5B440297;
	Mon, 19 Oct 2026 16:46:02 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 177004028E
 for <dev@dpdk.org>; Mon, 19 Oct 2026 16:46:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792421160;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V1G3Fy1vDAeiGXJG8rdLOCL5JKdCPN1v8NmpyZU1vdE=;
 b=eLp7u3V8ABmTPUG29Eul5+5jq8p0sTtfBYt3n29tTaAKTZCKWFg/rTnwmUBXppfwzF2rHs
 yLiBS++/M5yuh2u/LxAmvU3WgKtDyjaRys+J4FgklG2ia6pFjcEL4SGkh/F9cBn9ocaCO3
 YNnIlz8DXytc6GmVKJVQ/wgY+6OOU1I=
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com
 [74.125.82.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-HYxbJwsHNGGkOZ35SZ1qUw-1; Mon, 19 Oct 2026 14:45:59 +0000
X-MC-Unique: HYxbJwsHNGGkOZ35SZ1qUw-1
X-Mimecast-MFC-AGG-ID: HYxbJwsHNGGkOZ35SZ1qUw_1792421158
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-1383723dfddso4340721c88.0
 for <dev@dpdk.org>; Mon, 19 Oct 2026 07:45:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792421158; x=1793025958;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=V1G3Fy1vDAeiGXJG8rdLOCL5JKdCPN1v8NmpyZU1vdE=;
 b=HiaK5MLoeZI3oANo8pThQmS70ny0vGeso43hhpjyeqhRNy1ftKTcKZUMqO+ZkF0YVn
 ZscRyRiw6Fk3sq2XpSutbkIUnp6qqT3kEN9CVX7ZErvmwb4sydJgPhLJiYok9aqV3wiB
 gv7O1O16IUPXkPZaRRaBw+esehEPJas9qIHmH5XTf6/w2HuAcymTA2GDBZQEUKtGxF6O
 X5h94kv/YDnv5bRcD7t62tATnB63gN5Y+Rb366wvSl4G7+jt65eLfJKn3kcKZlcS6dlX
 EzVxLANbmo2Uc90PONI4oNQPtG3NQnNRosXunSd0zHCujaxIieBHlAceFIgexrhxnBNg
 se6w==
X-Gm-Message-State: AFq9FYJghoMxsfOWxxPLt/BAVpxp+Yuuw5gyx7zf0TrmhBX2+vC4Q00A
 UL/m6Wq6HSsrEeLI3AbpNJBEDB3JKt/1mC30NLsd88/Nndx2eYG77cBOa5BeA7LWSoiUENFQA46
 rF8bNK46JK52Bhku1fGiOLtBcw1EggBC3Ar/mxa7HcG1ud1S/0E6D+TO7pTVu+BKbE7wJCqWwpk
 oj90BnToy25ZZD+KLPJig=
X-Gm-Gg: AYBFou2ZU/E/eS2fZ3NFpvjfMraRBj2K+ZGRMMTD21090MEKtYVxC1htezWshUmA5wa
 O+PyLK6QCmTr6P4V0EUXCBhpEdMydjziFZfvh2IZjh2U6XHOv7LRJl+uERUfzSqyR+W7BqbN0RQ
 +SLi5mdqQKPykm631JScKX8xmcKooitv5RmiC4ftrDDDShx/WhRpDYfM1OQ5HIyVW0SpEVzCVb1
 halhPgihHF4Za1VyU2+ZYFKUKmmpz5clMHNIvTXfSp9GxVf8MzIq/8+M0JT20B3H8glTr+ft5A9
 0ZkKLXLeBBkmsAS1khmhBidB2FC5Zp9i0rH37j4l+Hc=
X-Received: by 2002:a05:7023:a4d:20b0:144:fb42:52 with SMTP id
 a92af1059eb24-18512f1ed6amr10552755c88.28.1792421157748; 
 Mon, 19 Oct 2026 07:45:57 -0700 (PDT)
X-Received: by 2002:a05:7023:a4d:20b0:144:fb42:52 with SMTP id
 a92af1059eb24-18512f1ed6amr10552643c88.28.1792421155294; Mon, 19 Oct 2026
 07:45:55 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261019134808.192525-1-eperezma@redhat.com>
In-Reply-To: <20261019134808.192525-1-eperezma@redhat.com>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Date: Mon, 19 Oct 2026 16:45:42 +0200
X-Gm-Features: AclHuK-Ly937jrt0AVpKJz_8YXlfGS6knRRfafvud00iGy6tHSoPvgA6gAUzQtU
Message-ID: <CAO55cszV7sK9VOK-1RBoog_yvOGXQUkBig3HaZ95Nb2VTULHNA@mail.gmail.com>
Subject: Re: [PATCH v5 0/9] Add vduse live migration features
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: dev@dpdk.org, mst@redhat.com, jasowangio@gmail.com, chenbox@nvidia.com, 
 david.marchand@redhat.com, Stephen Hemminger <stephen@networkplumber.org>, 
 Yongji Xie <xieyongji@bytedance.com>,
 Bruce Richardson <bruce.richardson@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: D_Sr09vDbT5Sp-RpiRwmf7jN24ViS8BsQbrI1OGVIeg_1792421158
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_ZEN_BLOCKED_OPENDNS,SPF_HELO_NONE autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Oct 19, 2026 at 3:48=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@redhat=
.com> wrote:
>
> This series introduces features to the VDUSE (vDPA Device in Userspace) d=
river
> to support Live Migration.
>
> Currently, DPDK does not support VDUSE devices live migration because the
> driver lacks a mechanism to suspend the device and quiesce the rings to
> initiate the switchover.  This series implements the suspend operation to
> address this limitation.
>
> Furthermore, enabling Live Migration for devices with control virtqueue
> requires two additional features.  Both of them are included in this seri=
es.
>
> * Address Spaces ID (ASID) support: This allows QEMU to isolate and inter=
cept
>   the device's CVQ. By doing so, QEMU is able to migrate the device statu=
s
>   transparently, without requiring the device to support state save and
>   restore.
> * QUEUE_READY: This allows QEMU to control when the dataplane virtqueues =
are
>   enabled.  This ensures the dataplane is started after the device
>   configuration has been fully restored via the CVQ.
>
> It also enables the VIRTIO_NET_F_STATUS feature.  This allows the device =
to
> signal the driver that it needs to send gratuitous ARP with
> VIRTIO_NET_S_ANNOUNCE, reducing the Live Migration downtime.
>
> v5:
> * Update headers to 7.3
> * Rebase on top of main, merge conflicts.
>
> v4:
> * Rebase on top of origin/main, which already includes the __counted_by e=
rror
> fix.
> * Add VDUSE_SUSPEND to lib/vhost/vduse.c:vduse_reqs_str (Maxime).
>
> v3:
> * Include uapi/linux/stddef.h and revert the -D__counted_by from v2.
>
> v2:
> * Add -D__counted_by(X)=3D if the compiler does not support it. It is
>   pulled by the kernel headers.
>
> PATCH v1:
> * Move to VDUSE_SET_FEATURES ioctl instead of config space field.
> * Add a few bounds control.
> * Update kernel headers to v7.3-rc3.
>
> RFC v4:
> * Sync headers with Linux's latest existing and proposed UAPI.  Both
>   files constants and new ioctl VDUSE_SET_FEATURES.
> * Check for more error conditions and clarified some error messages in
>   ready message processing.
> * Add relevant release notes.
> * Fix cosmetic whitespaces & checkpath errors.
> * Fix error path of vhost_user_iotlb_init and vhost_user_iotlb_init_one.
> * Fix commits author.
>
> RFC v3:
> * Replace incorrect '%lx' DEBUG print format specifier with PRIx64
>
> RFC v2:
> * Following latest comments on kernel series about VDUSE features, not ch=
ecking
>   API version but only check if VDUSE_GET_FEATURES success.
> * Move the start and last declarations in the braces as gcc 8 does not li=
ke
>   them interleaved with statements. Actually, I think the move was a mist=
ake in
>   the first version.
>   https://mails.dpdk.org/archives/test-report/2026-February/958175.html
>
> Eugenio P=C3=A9rez (3):
>   uapi: import VDUSE and VFIO header from v7.3 kernel
>   vhost: Support VDUSE QUEUE_READY feature
>   vhost: Support vduse suspend feature
>
> Maxime Coquelin (6):
>   vhost: introduce ASID support
>   vhost: add VDUSE API version negotiation
>   vhost: add virtqueues groups support to VDUSE
>   vhost: add ASID support to VDUSE IOTLB operations
>   vhost: claim VDUSE support for API version 1
>   vhost: add net status feature to VDUSE
>
>  kernel/linux/uapi/linux/iommufd.h | 105 +++++++++++-
>  kernel/linux/uapi/linux/stddef.h  |   4 +
>  kernel/linux/uapi/linux/vduse.h   | 113 ++++++++++++-
>  kernel/linux/uapi/linux/vfio.h    |  51 +++++-
>  kernel/linux/uapi/version         |   2 +-
>  lib/vhost/iotlb.c                 | 233 +++++++++++++++++----------
>  lib/vhost/iotlb.h                 |  14 +-
>  lib/vhost/vduse.c                 | 259 +++++++++++++++++++++++++++---
>  lib/vhost/vduse.h                 |   3 +-
>  lib/vhost/vhost.c                 |  16 +-
>  lib/vhost/vhost.h                 |  16 +-
>  lib/vhost/vhost_user.c            |  13 +-
>  12 files changed, 676 insertions(+), 153 deletions(-)
>
> --
> 2.56.0
>

applied to next-virtio/for-next-net.

Thanks!
Maxime

