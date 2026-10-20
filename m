Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC4B9606A323
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Oct 2026 09:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=iqzGJ6+i
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 40D8F4060A;
	Tue, 20 Oct 2026 11:39:09 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 45EC140144
 for <dev@dpdk.org>; Tue, 20 Oct 2026 11:39:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792489147;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e1qmBbK1oCpPEHSj/1vxZDOU1PM9K7U5yzbMME7884w=;
 b=iqzGJ6+istCou5DsUOIkISo+It2e+HZM+990yEMPIrLKrt4aOkj7jNsp5Alvc2qqWygvNk
 R/2RHF5MyhzMTjt018Fk+h9eDx2olnYhFh0ptp8bP+di+AWwKqJqt9nBMm7Bs7Y+KrK5sC
 +RkVPQXHzRpoHUFkIkkEwtv0fiA0FGA=
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-LUaXPopQOLGKexN_TWMnoA-1; Tue, 20 Oct 2026 09:39:06 +0000
X-MC-Unique: LUaXPopQOLGKexN_TWMnoA-1
X-Mimecast-MFC-AGG-ID: LUaXPopQOLGKexN_TWMnoA_1792489145
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-33c35f5ca6cso6260639eec.1
 for <dev@dpdk.org>; Tue, 20 Oct 2026 02:39:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792489145; x=1793093945;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=e1qmBbK1oCpPEHSj/1vxZDOU1PM9K7U5yzbMME7884w=;
 b=r/FSaeqI9BoQ3llOCxId2KnvXygBQgpov2yktybi/fNCwLZY6Ih/LwxVIxcqDhCc+s
 yv/ODKM6cZUqiRlXxNO3zJ0KNkGAue9cV8rFXYC9Zq60Eb03JHiQDgpKmHVwI+292M54
 wYXGgY3uW5UgVXp0D1TNjX5dseEhVWRjYs/k1TkIulu8BtRuWN81XhQ0kvp+jECEYg6Q
 o5ZmC01Zb8Io0h8b+ldJykxvzx4UsRLMNki2JYI2vVFzzmZwrOsPgF22EW1FAFI10Jje
 NoJSLrkP9vUjkYFgYFWCtuSFuVQyqauPbx9xHew117FacFSBmcx3L+21Uw+V0GmbF371
 cJHw==
X-Gm-Message-State: AFq9FYJs9HNSVUOVTftsge4/IwrDZQhbG0OloZ3blKLZs3tQjB/ERCN4
 y6JcperQb/pkE+0DGz408HtcstB676r0XDLmPBGHJdGnELpuen5udxI8sBzQnvl226F1Q4WQi5q
 EhYNXDR4uiq/wLF2qPHpFClLnJdXtSyssLV67mVaBt50rD4+XQtLzq0NCrPbluTmLDD+fwzS9Mf
 eX5wQLCWFvnnvQWFZptj2Gsa0r4312Ug==
X-Gm-Gg: AYBFou113zoEkw8w2GnVVOktAzkY6tsZKvvVT96/fTPD8PEnspHWCJ7+n1h/0n0jAZg
 yVaPUu812qhWWMFmVpBG7miU920RH9nlliY9o7kByL+MpkCRo/8r+dBRO54UxLSSBCD6T630ps9
 cWEET4N6L9Ox4ykC18KE+fnTDnuXa5ZTNxpIotaiEl/rgSvU8oj7TxBcjY93ptC1Lw3i1UsOWuV
 8Rh8lNEefTn8qFx95mNbHyy+oTUynVQGC7rL6pyKkFNfa6CBevmHRfNOlg/lrQSkay96PVSHR4h
 dExW2tm07gq0eU4wZlAmzMA+fW8vO8YIog4BLn/idhc=
X-Received: by 2002:a05:701b:42c4:20b0:182:94d7:f76a with SMTP id
 a92af1059eb24-18515c54aa2mr15675967c88.43.1792489144778; 
 Tue, 20 Oct 2026 02:39:04 -0700 (PDT)
X-Received: by 2002:a05:701b:42c4:20b0:182:94d7:f76a with SMTP id
 a92af1059eb24-18515c54aa2mr15675926c88.43.1792489144047; Tue, 20 Oct 2026
 02:39:04 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261019135814.3146545-1-mb@smartsharesystems.com>
In-Reply-To: <20261019135814.3146545-1-mb@smartsharesystems.com>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Date: Tue, 20 Oct 2026 11:38:52 +0200
X-Gm-Features: AclHuK8G4WnPKnqgmi4mvFcUyw7uOMgP36t2kp6ck520qQc1M91KjJ7ByV27VOw
Message-ID: <CAO55csw9OTh8QYDWF9Lxq_VDoSZ0q65prhG33bJUmhuoz-GEBg@mail.gmail.com>
Subject: Re: [PATCH] vhost: fix checksum offset check in Rx path
To: =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>
Cc: dev@dpdk.org, Chenbo Xia <chenbox@nvidia.com>, stable@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Rv7OVkMCRpt6-tHmnIsO641xnN5SS4Lz80Xuy8cQipM_1792489145
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

On Mon, Oct 19, 2026 at 3:58=E2=80=AFPM Morten Br=C3=B8rup <mb@smartsharesy=
stems.com> wrote:
>
> Writing the checksum in the packet needs room for 2 bytes, not 1 byte.
>
> Fixes: ca7036b4af3a ("vhost: fix offload flags in Rx path")
> Cc: stable@dpdk.org
>
> Signed-off-by: Morten Br=C3=B8rup <mb@smartsharesystems.com>
> ---
>  lib/vhost/virtio_net.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/vhost/virtio_net.c b/lib/vhost/virtio_net.c
> index 8bdddedccf..eb099d206b 100644
> --- a/lib/vhost/virtio_net.c
> +++ b/lib/vhost/virtio_net.c
> @@ -2848,7 +2848,7 @@ vhost_dequeue_offload(struct virtio_net *dev, struc=
t virtio_net_hdr *hdr,
>                         if (likely(csum !=3D 0xffff))
>                                 csum =3D ~csum;
>                         off =3D hdr->csum_offset + hdr->csum_start;
> -                       if (rte_pktmbuf_data_len(m) >=3D off + 1)
> +                       if (rte_pktmbuf_data_len(m) >=3D off + sizeof(uin=
t16_t))
>                                 *rte_pktmbuf_mtod_offset(m, uint16_t *, o=
ff) =3D csum;
>                 }
>         }
> --
> 2.43.0
>
Reviewed-by: Maxime Coquelin <maxime.coquelin@redhat.com>

