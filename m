Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4120CCF2E6
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 Oct 2026 14:44:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1694240297;
	Mon, 19 Oct 2026 16:44:09 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id EF10B4028E
 for <dev@dpdk.org>; Mon, 19 Oct 2026 16:44:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792421047;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=58XS9jpeZdfARqQDgeehBGR42vQmxT+4E9ZvxONOIo8=;
 b=KRshoajic98W+ERYyDaDXNL1iPazXd13AewIiES2cAwtnicPvmdTRysF+i8iXO7hsSea/E
 SJMicbeWSTcVqcUfc7G9lArFR+PlOuQqKQhq5/iEZWQT2NjnOBoOXKOrcRUnXjDgOAXDvL
 V/Goq69B1YrVsQXGJe5jHCbge9XWpfI=
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-62-UIASlIaBOd22kYDng9vhTA-1; Mon, 19 Oct 2026 14:44:06 +0000
X-MC-Unique: UIASlIaBOd22kYDng9vhTA-1
X-Mimecast-MFC-AGG-ID: UIASlIaBOd22kYDng9vhTA_1792421045
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-35c3c370b17so4504819eec.0
 for <dev@dpdk.org>; Mon, 19 Oct 2026 07:44:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792421045; x=1793025845;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=58XS9jpeZdfARqQDgeehBGR42vQmxT+4E9ZvxONOIo8=;
 b=ApecpFRVPyGD1RX3CP52NjHmSwwh0hJvgLdfZ1bznu9k5veEmzMGLh1RzqoMj7UlFN
 a+6cOatQhNHmfuBfow1SOLcaPFYHsgPcp4t5/akeV6YELxoeZoEZoFKetKFHPs4/n+T7
 cabrbsuRyqFVFtg3uPvu78FY94r5ir+yrqKDVmnRloan5NE429FS+RQ52GLgnQUBAo24
 2HFDp/Eup4ByULT5p9u+MzEKPn7c3m6+nE1ft+rxUmwAEut97zT7b/pPbPYXzCyw8KNu
 TYTDD5EY+Y1QpTGU7A2mxWjcXCKhyRyTinZiYbxqbU+aZMVp6IlCXQBITb9BgJj42JsU
 kGqQ==
X-Gm-Message-State: AFq9FYKt4tEZbhfE2yj7MTWIYocRsFviUJjPbOlsTn/EprJs5m6A3+N2
 SUfISWbBXSS+jTcHxP/xPm2UFH8DYg+gZfO+qp7oevtLD8JtZYzs3EPutg/4w8xE43/dmphFg3h
 2fGEecsOKl/nZDWHJWLOVhlZXuX1INuyvZJZuHU2oGYA9XCGj1KhyrmbSiX8SQEiEKgcDGZNmVp
 Jy8UX5d0+hzCUPS9r+b5c=
X-Gm-Gg: AYBFou3Mo1rcUNKD4KI+F30KGiMANygzJThS28J8Tn1sXwhc0AQHcpyu3RS2EasPt+Z
 QgCVkkeH+VZ1tdzY3US+j/2UUvya+d3Uyo9/P9rmqvTjazw4gVh0nvRk2uhjKNU2GCNbdA0gNGN
 dnzo3Gt84a5st6Zlz9TUOzdybLgoPhkZwDM2/XgWIoqcxubEPw4ULapkXomonrYehg16jqlK+C+
 2ZoCp8svniqegal+19rxhg4oq/c51JRyJF8iXgSE7OcvOqeCtTWJqvOycHpeJ8GrknuAdrSvbxz
 pxstVfu5UQtCy0n4mLXCVIFJDFjINL0Ez5yx4YwZO4s=
X-Received: by 2002:a05:701b:4242:20b0:182:23da:b566 with SMTP id
 a92af1059eb24-18511eb6a73mr12040369c88.8.1792421044717; 
 Mon, 19 Oct 2026 07:44:04 -0700 (PDT)
X-Received: by 2002:a05:701b:4242:20b0:182:23da:b566 with SMTP id
 a92af1059eb24-18511eb6a73mr12040338c88.8.1792421044211; Mon, 19 Oct 2026
 07:44:04 -0700 (PDT)
MIME-Version: 1.0
References: <20261019134808.192525-1-eperezma@redhat.com>
 <20261019134808.192525-3-eperezma@redhat.com>
In-Reply-To: <20261019134808.192525-3-eperezma@redhat.com>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Date: Mon, 19 Oct 2026 16:43:51 +0200
X-Gm-Features: AclHuK9NIaA-ESeUAoXgNFLhdtNcuTyMwAWWCn3NZfOzRHRonAzJ2Y10l_u5CnM
Message-ID: <CAO55csx1RH3-teV13NCe6M1_orQYVLz4gmXVBKJVdnRyWzDb8w@mail.gmail.com>
Subject: Re: [PATCH v5 2/9] vhost: introduce ASID support
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: dev@dpdk.org, mst@redhat.com, jasowangio@gmail.com, chenbox@nvidia.com, 
 david.marchand@redhat.com, Stephen Hemminger <stephen@networkplumber.org>, 
 Yongji Xie <xieyongji@bytedance.com>,
 Bruce Richardson <bruce.richardson@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 98tco8wx65xEL4861ZMEaURacUEGmfBE5MouvsU3hjg_1792421045
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

On Mon, Oct 19, 2026 at 3:48=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@redhat=
.com> wrote:
>
> From: Maxime Coquelin <maxime.coquelin@redhat.com>
>
> Set all ASID =3D 0 as it is the default when not set explicitly.
>
> Reviewed-by: Maxime Coquelin <maxime.coquelin@redhat.com>
> Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> ---
>  lib/vhost/iotlb.c      | 233 +++++++++++++++++++++++++----------------
>  lib/vhost/iotlb.h      |  14 +--
>  lib/vhost/vduse.c      |   9 +-
>  lib/vhost/vhost.c      |  16 +--
>  lib/vhost/vhost.h      |  13 +--
>  lib/vhost/vhost_user.c |  13 +--
>  6 files changed, 177 insertions(+), 121 deletions(-)
>
> diff --git a/lib/vhost/iotlb.c b/lib/vhost/iotlb.c
> index f2c275a7d77e..e5e69d11cb65 100644
> --- a/lib/vhost/iotlb.c
> +++ b/lib/vhost/iotlb.c
> @@ -11,6 +11,16 @@
>  #include "iotlb.h"
>  #include "vhost.h"
>
> +struct iotlb {

I'm changing to struct vhost_iotlb, for consistency with vhost_iotlb
entry and also to avoid potential collision in the future.

> +       rte_rwlock_t                    pending_lock;
> +       struct vhost_iotlb_entry        *pool;
> +       TAILQ_HEAD(, vhost_iotlb_entry) list;
> +       TAILQ_HEAD(, vhost_iotlb_entry) pending_list;
> +       int                             cache_nr;
> +       rte_spinlock_t                  free_lock;
> +       SLIST_HEAD(, vhost_iotlb_entry) free_list;
> +};
> +

