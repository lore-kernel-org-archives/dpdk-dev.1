Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ADA5CA5FCE
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 Oct 2026 10:10:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6CB9640290;
	Mon,  5 Oct 2026 12:10:25 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 968644028E
 for <dev@dpdk.org>; Mon,  5 Oct 2026 12:10:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791195023;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XMSHf4syNGWjic/gOo3q2Zv7548YFiQ+kKnMlw1sSRw=;
 b=bAe0scJkcbfqlpdp8Lkb86Jss+v1M83rn7N2pZykQQvgEDSPiOMpFguZ6R1G+uzXpUafzK
 Mgb4+U1opnWfAUAqx8ahjUeM1m6umJVnvm0eJLWz+T8iLbRVJ3W688bMTqXdeQIH+lJthJ
 fvWueJpoPoCn7SXBhcqr0iOLQELXLvM=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-22-AmtCKCg0OVm6URRMfdLP_Q-1; Mon, 05 Oct 2026 06:10:21 -0400
X-MC-Unique: AmtCKCg0OVm6URRMfdLP_Q-1
X-Mimecast-MFC-AGG-ID: AmtCKCg0OVm6URRMfdLP_Q_1791195021
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-86e8abd7136so17008667b3.0
 for <dev@dpdk.org>; Mon, 05 Oct 2026 03:10:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791195021; x=1791799821;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XMSHf4syNGWjic/gOo3q2Zv7548YFiQ+kKnMlw1sSRw=;
 b=XD9txlOJzV10u/fiMl+tzODbNcbncEZtjJb1c7mdiY1oit1KAnboXEPNXq/FvVcyxg
 Ur5P7cAZsvcZHkN+sFCnu99xDkEMgKzrgCx2ZRYulIDTGg8GIkURq2ExG6ItLCURFC3+
 t287PBq/qw8NlTuNvkjA27Jcl/w7CKGhKRldCj72ZPQmy5+yrmeo8ALPdJzzOzxPd4tO
 p+WyARyEhitURk8HpBpg7sxAIMEjYazevgnMYPRhNVWqWh7NOhzQYUp/kcPQxDKM6sUK
 ONP+65Fm+DvTgMB9+bzcjBGoZqUjfvPBYZstb8sPP71fgMLzg9JLh0e6mAcn0WYDFqOs
 2JCw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxy3QEvf0bdaRaNgxUPdppkmIP1PqYXJb5neNJMmC1xSAxLsTHGFETxtocI1m16IGuGHlQ=@dpdk.org
X-Gm-Message-State: AFq9FYLCNStu333qJoiiB4sDE1f2ZadSWsVMaEkUcbrdCwvta4rus7Mn
 PxbOl6TeRl4XFbKoD91741+h9PYZGRNPG/V+6J1lKkkHsqui+c+PYKVPdTW1ifYLBw/7LXTRBmZ
 Yyk8PStMSgM+6Ugpyuy1EzGq7U2hcXCexbrBl0QqlOMZTF8E/ITeMUpTztCQkQivfCeWq7taVcr
 Bb1jfU3UPUE/2dHb53Tl4=
X-Gm-Gg: AYBFou1U/3DbLRS0Iv2/Pyr3iSeWvCjucoH2U7dB5fYleX8XyetWx0gpYj0B7rYur5G
 1Eenvl1YJWPb7CXPI7WQq6VMBkgqQGKIoFa35iDvIjw/6ivJkK/nVeh36Y5ivIZJVoL1TwF5sgh
 vrBIHNQzFvgev30VpNJYYJx/ZAdWnwDI5h0N2T0dbD7edOsF+2d9KkH46KmeA2xsG4U6SM6p69P
 BK0E5XY6Gla2w8YXoPkrBJMEdirqIH97A6cBXkCc1wFrwvopfk6btiu0h8=
X-Received: by 2002:a05:690c:2612:b0:8ae:4420:211a with SMTP id
 00721157ae682-8ae95acc18emr28921577b3.65.1791195020989; 
 Mon, 05 Oct 2026 03:10:20 -0700 (PDT)
X-Received: by 2002:a05:690c:2612:b0:8ae:4420:211a with SMTP id
 00721157ae682-8ae95acc18emr28921437b3.65.1791195020525; Mon, 05 Oct 2026
 03:10:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260929105339.1554051-1-eperezma@redhat.com>
 <CAJFAV8yowsh_zf2CLWpVepRKzctrORUQ0a+JaOo4oDews2ANsw@mail.gmail.com>
 <CAO55csy=hwbA3iy4=Wzyz40Frh6=Vtwc+mkj8csehM-NMmA1_A@mail.gmail.com>
In-Reply-To: <CAO55csy=hwbA3iy4=Wzyz40Frh6=Vtwc+mkj8csehM-NMmA1_A@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 5 Oct 2026 12:09:43 +0200
X-Gm-Features: AclHuK_4OQwQmYyv1SyW2oF1Bmf2USPw0Cn9OxGqKhfDVitn-b5ftU9JD4OGKdQ
Message-ID: <CAJaqyWfGzyMRgabCYUXua+zgbYMhSDoPSt0YFbLe1xe6uFK04g@mail.gmail.com>
Subject: Re: [PATCH v3 0/9] Add vduse live migration features
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: David Marchand <david.marchand@redhat.com>, mst@redhat.com, dev@dpdk.org, 
 Yongji Xie <xieyongji@bytedance.com>, chenbox@nvidia.com, 
 Bruce Richardson <bruce.richardson@intel.com>,
 Stephen Hemminger <stephen@networkplumber.org>, jasowangio@gmail.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: WLhtm2zjkwZzSSbCjvi4icROI9MTeyDo5lhZPXU4Bp8_1791195021
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

On Mon, Oct 5, 2026 at 10:11=E2=80=AFAM Maxime Coquelin
<maxime.coquelin@redhat.com> wrote:
>
>
>
> On Sat, Oct 3, 2026 at 11:54=E2=80=AFAM David Marchand <david.marchand@re=
dhat.com> wrote:
>>
>> On Tue, 29 Sept 2026 at 12:53, Eugenio P=C3=A9rez <eperezma@redhat.com> =
wrote:
>> >
>> > This series introduces features to the VDUSE (vDPA Device in Userspace=
) driver
>> > to support Live Migration.
>> >
>> > Currently, DPDK does not support VDUSE devices live migration because =
the
>> > driver lacks a mechanism to suspend the device and quiesce the rings t=
o
>> > initiate the switchover.  This series implements the suspend operation=
 to
>> > address this limitation.
>> >
>> > Furthermore, enabling Live Migration for devices with control virtqueu=
e
>> > requires two additional features.  Both of them are included in this s=
eries.
>> >
>> > * Address Spaces ID (ASID) support: This allows QEMU to isolate and in=
tercept
>> >   the device's CVQ. By doing so, QEMU is able to migrate the device st=
atus
>> >   transparently, without requiring the device to support state save an=
d
>> >   restore.
>> > * QUEUE_READY: This allows QEMU to control when the dataplane virtqueu=
es are
>> >   enabled.  This ensures the dataplane is started after the device
>> >   configuration has been fully restored via the CVQ.
>> >
>> > It also enables the VIRTIO_NET_F_STATUS feature.  This allows the devi=
ce to
>> > signal the driver that it needs to send gratuitous ARP with
>> > VIRTIO_NET_S_ANNOUNCE, reducing the Live Migration downtime.
>> >
>> > Note that kernel headers are update to v7.3-rc3, not a stable version.=
  This
>> > would allow to ack the patches while the kernel uapi is published in 7=
.3.
>> >
>> > v3:
>> > * Include uapi/linux/stddef.h and revert the -D__counted_by from v2.
>>
>> FYI, the issue is now fixed in main.
>
>
> And I just re-aligned the next-virtio branch to latest main.
>

Should I re-send the patches with the reviewed-by to trigger the CI
etc or it is not needed?

