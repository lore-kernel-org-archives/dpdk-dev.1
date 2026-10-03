Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1FE9CA5FE3
	for <dpdk-dev@archiver.kernel.org>; Sat,  3 Oct 2026 09:54:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 82E364060F;
	Sat,  3 Oct 2026 11:54:36 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 70D0740431
 for <dev@dpdk.org>; Sat,  3 Oct 2026 11:54:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791021273;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u+UDsYOmFkVwWGl1GmOfwv47408xvflaCB0rwoX5rZo=;
 b=RBk3/C3gLIix3xj5oufcUb3fdqXV/uwgp4idnxoKn9gEpGL9uhJbOfKwpJU0ey1zNA29g6
 xtWNM/Hhx55HNrLhg4tkUadgJPyA7Ri7JkT2k7I0AzWW7zmLCPLKTHcY7RU0dU/rqWmpMm
 ECgOL6i4aRKmRD0Tgv8+OsNETICRnp8=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-146-eEyTlkn0PaqBJ0NY92y0zQ-1; Sat, 03 Oct 2026 05:54:32 -0400
X-MC-Unique: eEyTlkn0PaqBJ0NY92y0zQ-1
X-Mimecast-MFC-AGG-ID: eEyTlkn0PaqBJ0NY92y0zQ_1791021271
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-3a96f2563c1so2863851fa.2
 for <dev@dpdk.org>; Sat, 03 Oct 2026 02:54:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791021271; x=1791626071;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=u+UDsYOmFkVwWGl1GmOfwv47408xvflaCB0rwoX5rZo=;
 b=qzt/rGfEm67Ys7H6Y4nx24AqM3UkHU8+65SEdztynY90Yx9nMzehaPoH8+ky97zuud
 dSYowBfuUN5UmDYNw/xipqe+OSA22VzkzEaipHr3yL1ExfqpKCndCUieUCQiUIItCbSF
 YcWJ3UEylwjbrSWT9Er9OHF5UFxbFJBEISm/mgPolPgweyaooZF5DNehe1B0m0PxZjJn
 BwX6Hs/6/GMNpeQP958mnTH8VjHBCXJyGnCbTnqvw2C7w98ytQYDNx6PuyZUyetuFGui
 +OHJzDlHNPa4+GK9Rd4UoCmV5XtsPA2euN6OJOyNWLxuydHFeLBHuAJMM0beikyFiI5f
 51VA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxshF/xvkdREnx2yMcC4nA3cQus1xWHJUtQlwV2G/sltSQHVXM7Gya2C1McYRsNBrr+0Cs=@dpdk.org
X-Gm-Message-State: AFq9FYIjfdlK5BvOtzx95TnyiZ4IEqsm0lDbwXHwS6d7qLBQ1Y7BqtTP
 tFZkcPzYhP0/GGciHIgT3jHuhTcQyE+hrTJnWxzDLYWaLcGQkLZNYh6iYOInVQvYHCaEFprcGv8
 NBfqxB8IaAkgqfv2B2NvJ3Z5h4Ih1UwwFX57xNBNoJStSst8+amb4I9ZBYzPKZ2+Hph1d7qpWtQ
 zv4CY+AurNk+LNpMSSEm0=
X-Gm-Gg: AYBFou2epUejqtaSVF7P5s686liM0dUh8Ww78njbyOVAwlqUwdku7UTvZl6R0EKXQgE
 p5Iq5Z/ySUA8y5s5tOS8dBAD4Exbu+pna1ZKXxJfF4Y1rYG3Gm2Xh6C+rYX6SRbHVQ5nFsgZpoR
 92dVq7PHlRjm5E4fxAzKuvkR8II+Rs74zSswI65S5wAsGWBk7M3PdR0kSri+FHI1v593yq9GWX4
 Y0XjaLbbX6PtTvvH5i//s4xG9MPb4fS1RM+l/0/w2PVkxkJ
X-Received: by 2002:a05:6512:401d:b0:5ba:343a:f7c2 with SMTP id
 2adb3069b0e04-5bb9bb1767emr2043167e87.22.1791021270997; 
 Sat, 03 Oct 2026 02:54:30 -0700 (PDT)
X-Received: by 2002:a05:6512:401d:b0:5ba:343a:f7c2 with SMTP id
 2adb3069b0e04-5bb9bb1767emr2043162e87.22.1791021270584; Sat, 03 Oct 2026
 02:54:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260929105339.1554051-1-eperezma@redhat.com>
In-Reply-To: <20260929105339.1554051-1-eperezma@redhat.com>
From: David Marchand <david.marchand@redhat.com>
Date: Sat, 3 Oct 2026 11:54:19 +0200
X-Gm-Features: AclHuK9JrDF96zQijQHaZYhJGjvmbWz70UkKHHBnuoWphfz3CKLQYF1kFleEeX0
Message-ID: <CAJFAV8yowsh_zf2CLWpVepRKzctrORUQ0a+JaOo4oDews2ANsw@mail.gmail.com>
Subject: Re: [PATCH v3 0/9] Add vduse live migration features
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: mst@redhat.com, dev@dpdk.org, Yongji Xie <xieyongji@bytedance.com>, 
 chenbox@nvidia.com, Bruce Richardson <bruce.richardson@intel.com>, 
 Stephen Hemminger <stephen@networkplumber.org>, jasowangio@gmail.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: cdMyuhlagBcbqHKKCkhnzrWBCgV_zpar2vSd-mptxyQ_1791021271
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

On Tue, 29 Sept 2026 at 12:53, Eugenio P=C3=A9rez <eperezma@redhat.com> wro=
te:
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
> Note that kernel headers are update to v7.3-rc3, not a stable version.  T=
his
> would allow to ack the patches while the kernel uapi is published in 7.3.
>
> v3:
> * Include uapi/linux/stddef.h and revert the -D__counted_by from v2.

FYI, the issue is now fixed in main.


--=20
David Marchand

