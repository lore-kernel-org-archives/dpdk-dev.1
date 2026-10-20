Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE1DB606A319
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Oct 2026 09:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eRZlKhbq
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 40CB44060A;
	Tue, 20 Oct 2026 11:38:39 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 418D540270
 for <dev@dpdk.org>; Tue, 20 Oct 2026 11:38:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792489116;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jR1dCvbVJCC6BidN7hFhrg+SDQrGIgAdT0grDBOfZEo=;
 b=eRZlKhbqjmuEbGDBjbEj47EnvS70/t/G5E0nZ/cZETrEPtZrlqQbcINr68PivJR0klgr0U
 kxbOdAP5hEAWKAP5+vps/8HC8CMITT6Okn54zvANhE2Bc9u4DHa0b3AXiiBRORi40oUlvD
 B4uDogPtjnGNa1eSCnEE63AOZYz0bCk=
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com
 [74.125.82.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-60XHhkb9PxC-ZJ9b5fLQuw-1; Tue, 20 Oct 2026 05:38:35 -0400
X-MC-Unique: 60XHhkb9PxC-ZJ9b5fLQuw-1
X-Mimecast-MFC-AGG-ID: 60XHhkb9PxC-ZJ9b5fLQuw_1792489114
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-139b62317d0so11502577c88.0
 for <dev@dpdk.org>; Tue, 20 Oct 2026 02:38:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792489114; x=1793093914;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jR1dCvbVJCC6BidN7hFhrg+SDQrGIgAdT0grDBOfZEo=;
 b=PH3DNPnZxWbuDf2ZQcFsflvH3AxV/TXsolFszyUn+ZGuZ7wj99myZEsOmLd8jvz+jS
 wSTDy/dyoEJnLFhxh7heme4Lwto6MGITFQ0BMC6Ne/8OCHfBLsOf/bI4XhR7oIrKvA+I
 thMruS+gw/eCaKx3zZhNEHFL3PxgqhAsdANUOgdpfiE7ZdQR53ud6J147EjXJJqOma35
 4PY1kpIJEqb2XU+NjCy9vePlMHx+PwaiTtakFuzLC6HYzE8m6nmdCf/nBRxYVu+tF70D
 optYVv9QSfnmX+LVs/JYhY3EugmsWvxgQ/rqRkfFIqid0/ISvGa5MSQrsxkhr0lprvS8
 +tpg==
X-Gm-Message-State: AFq9FYKIrJb+Zt1KWRGKyvznZJWEZ8G1X4JkSqcrtcE35L2AIkgXf6yj
 1jEB/pwEh5G8pTWcL7iqiWRvZIMWOmp1o/XdQ5kKmOYYx9bRoRcFVnBZXU3sWh15C5k8wAKxGWw
 5it0ti5pePft+VtCcqgzQ91M/hXrRx8D6iibUnJouoeblw5qvenkpZI5c2n2NwJn3NoVMU5a0NY
 SvUn3H3cCZJNeIYEs91p0=
X-Gm-Gg: AYBFou29h7G1E50m6eLZB+vynHniNX5WTwxkrvQhW6OH9lGjw1Dq3+Iali/f62iBl0z
 FgzPoaagzyLfpRXNrl+tfaa+G+s+N4WyoxILY0jquKILzyqcpH7lBrfz4zsAndOBUe7bQG1SsSv
 GdQMW1qgz83yHwHDhQcWaabBKWhVCU4UR4rVxbNxAhaDGY0FqZy9eVJCzH2iAVE8892faUVYHhM
 8AV3DOXV1vV9JGO+ndPThf/zS09qy3Tckh6uEVjIl9UFCQ4jvyk3HqldpoimpxcXtysgsw+5Bea
 e7Ix+MIQCFxYMrv7TXFzFyjXkfYF6T86XKj62tvbcto=
X-Received: by 2002:a05:701b:4584:b0:158:1ed2:cb58 with SMTP id
 a92af1059eb24-18514634414mr13382042c88.39.1792489114129; 
 Tue, 20 Oct 2026 02:38:34 -0700 (PDT)
X-Received: by 2002:a05:701b:4584:b0:158:1ed2:cb58 with SMTP id
 a92af1059eb24-18514634414mr13382011c88.39.1792489113471; Tue, 20 Oct 2026
 02:38:33 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261019135643.3146303-1-mb@smartsharesystems.com>
In-Reply-To: <20261019135643.3146303-1-mb@smartsharesystems.com>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Date: Tue, 20 Oct 2026 11:38:20 +0200
X-Gm-Features: AclHuK-TqjDcFOHn2myfzyReilXJ1DmO9eFs55LRwQOk-SMx18xY_n3Ux7KlCdA
Message-ID: <CAO55cszwq=KAi9OugmZ96_yMAVgPg_N190DB7j38LJrx4WUffQ@mail.gmail.com>
Subject: Re: [PATCH] net/virtio: fix checksum offset check in Rx path
To: =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>
Cc: dev@dpdk.org, Chenbo Xia <chenbox@nvidia.com>, stable@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 8MKA6ut0uc4a6oO9rUK_WuGVV4j6rO5d-vHPDgEyPjA_1792489114
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
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Oct 19, 2026 at 3:57=E2=80=AFPM Morten Br=C3=B8rup <mb@smartsharesy=
stems.com> wrote:
>
> Writing the checksum in the packet needs room for 2 bytes, not 1 byte.
>
> Fixes: 96cb6711939e ("net/virtio: support Rx checksum offload")
> Fixes: 0eaf7fc2fe8e ("net/virtio: separate AVX Rx/Tx")
> Cc: stable@dpdk.org
>
> Signed-off-by: Morten Br=C3=B8rup <mb@smartsharesystems.com>
> ---
>  drivers/net/virtio/virtio_rxtx.c        | 2 +-
>  drivers/net/virtio/virtio_rxtx_packed.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/virtio/virtio_rxtx.c b/drivers/net/virtio/virtio=
_rxtx.c
> index edecd2011f..1afb68bc69 100644
> --- a/drivers/net/virtio/virtio_rxtx.c
> +++ b/drivers/net/virtio/virtio_rxtx.c
> @@ -955,7 +955,7 @@ virtio_rx_offload(struct rte_mbuf *m, struct virtio_n=
et_hdr *hdr)
>                         if (likely(csum !=3D 0xffff))
>                                 csum =3D ~csum;
>                         off =3D hdr->csum_offset + hdr->csum_start;
> -                       if (rte_pktmbuf_data_len(m) >=3D off + 1)
> +                       if (rte_pktmbuf_data_len(m) >=3D off + sizeof(uin=
t16_t))
>                                 *rte_pktmbuf_mtod_offset(m, uint16_t *,
>                                         off) =3D csum;
>                 }
> diff --git a/drivers/net/virtio/virtio_rxtx_packed.h b/drivers/net/virtio=
/virtio_rxtx_packed.h
> index f7cc60bb51..6501ede3f0 100644
> --- a/drivers/net/virtio/virtio_rxtx_packed.h
> +++ b/drivers/net/virtio/virtio_rxtx_packed.h
> @@ -185,7 +185,7 @@ virtio_vec_rx_offload(struct rte_mbuf *m, struct virt=
io_net_hdr *hdr)
>                         if (likely(csum !=3D 0xffff))
>                                 csum =3D ~csum;
>                         off =3D hdr->csum_offset + hdr->csum_start;
> -                       if (rte_pktmbuf_data_len(m) >=3D off + 1)
> +                       if (rte_pktmbuf_data_len(m) >=3D off + sizeof(uin=
t16_t))
>                                 *rte_pktmbuf_mtod_offset(m, uint16_t *,
>                                         off) =3D csum;
>                 }
> --
> 2.43.0
>

Reviewed-by: Maxime Coquelin <maxime.coquelin@redhat.com>

