Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0488CCA5FF0
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 Oct 2026 08:11:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D7CF2402B5;
	Mon,  5 Oct 2026 10:11:37 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 7003540290
 for <dev@dpdk.org>; Mon,  5 Oct 2026 10:11:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791187895;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nXRq2cYbraD0vc9ZMNCq52B9gUcge5WR6usfSvnotnY=;
 b=PQ4NoYxM7D7HSrfBg87+TZrLApTVcvu23VOoAqgum8sziPln0fPvAL3M6yykfiHcZBHwIw
 xJY71/Guy0TwXAohm6D3UaKzYEjLCNt9paPRW/eFjSs+FszufUtFwz8Vqn8StaP/+ldF4X
 Z9WyHz2DLka/mF2DLi40iHWCkh/C2h4=
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-674-k8op_URbMNGbFKNI3CFKfQ-1; Mon, 05 Oct 2026 04:11:33 -0400
X-MC-Unique: k8op_URbMNGbFKNI3CFKfQ-1
X-Mimecast-MFC-AGG-ID: k8op_URbMNGbFKNI3CFKfQ_1791187892
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-33713e5e6daso1710485eec.0
 for <dev@dpdk.org>; Mon, 05 Oct 2026 01:11:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791187892; x=1791792692;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=nXRq2cYbraD0vc9ZMNCq52B9gUcge5WR6usfSvnotnY=;
 b=LdAlgTOYhF/MVjoTkOu7sr1bUv2K0lhrZ35SNcO7g/0DZo+HynfowjuD6DZWfkCnjm
 5dSALlBMQTWhTACSka+rWhPqy2sCp+ixCIVrrCQUL5NSu3+meOLiaC128Y+u0ixyOyMg
 nkRiBHxsl/MIRYUluMTfT//0CLzXzY94mOImqnjvRDw6F373w0PleedU+8xiJRsk2mZ9
 zY9Ptj08N2wWK8H/fizq11k04duNgbOZb4oELOkf/Q0AOA2fMUdpujMVi7SjE/ZjIssk
 nMySM7KN9QmPpPo+b8jQmzg8NQr0ciDYa2Q5pFbFAgCfRBwh2zpoRGdM0bVXc1FURW7U
 zVhA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzvbzzcLxwSWK2WJJ0/GdNDZZdsiO/bHBr4l6EL+b3Fr0Wnf5YM7C/fuBYP5VIVhhwlVYM=@dpdk.org
X-Gm-Message-State: AFuF++mE1T9jJqIftDi34WAg6xGB/4XXpKIEC5V1I/U5o0RxbCELoV+U
 bZAzKVZQzexscLivLH9x6hYTykJWOJkXHkcN0kFuDGlihgTOMZXXiAk6wZvwzfMCABrdfPO5aUX
 7ZAhVPS0vdgvDvThQ5+Kw5bEB8QOSBhh+gVPulsFsxO7VG6Otzq3wg2t6bG0mryhncZPymVSBHF
 lgXoOGmWgEEd4S4nGibDw=
X-Gm-Gg: AYBFou3TcdxWU2PUpMvu3vqisBZixDw/Aw5Yzl0AOfbh/LulmVWv3XzHyy9HcnHc2mQ
 8m5yQNHfjfi5cHkAHdgEsston479xsqpqdC6+qY3PMGUH2zmTB2ygTqEeUrTJGDhprl8bBaeK2x
 NHhUBSHR65on6QL4WHgep8R0aMVPweHEhl6C4q4aS8ENynxFLJOhG3y29TmbSS934NP3hOFNwPT
 H1BVZyN5zpvIvjjeY0l2Lkg04ak5mvl+gX2pK8mWtRLONCpNY1H7HKkLA5pb5af5yp3XrWzkMQC
 Y6VhWQlYOAbJc3ORXZczWaoELVLkDiZn4MYpoUGmbnI=
X-Received: by 2002:a05:7022:e0d:b0:148:516e:516 with SMTP id
 a92af1059eb24-14f5bff9781mr19872863c88.20.1791187891960; 
 Mon, 05 Oct 2026 01:11:31 -0700 (PDT)
X-Received: by 2002:a05:7022:e0d:b0:148:516e:516 with SMTP id
 a92af1059eb24-14f5bff9781mr19872818c88.20.1791187891345; Mon, 05 Oct 2026
 01:11:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260929105339.1554051-1-eperezma@redhat.com>
 <CAJFAV8yowsh_zf2CLWpVepRKzctrORUQ0a+JaOo4oDews2ANsw@mail.gmail.com>
In-Reply-To: <CAJFAV8yowsh_zf2CLWpVepRKzctrORUQ0a+JaOo4oDews2ANsw@mail.gmail.com>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Date: Mon, 5 Oct 2026 10:11:19 +0200
X-Gm-Features: AclHuK_hbyd2JQo9MLYJiT7S79SCF_nVOaOGYu7dXNKyOtfve5kABJRvgSs-WSI
Message-ID: <CAO55csy=hwbA3iy4=Wzyz40Frh6=Vtwc+mkj8csehM-NMmA1_A@mail.gmail.com>
Subject: Re: [PATCH v3 0/9] Add vduse live migration features
To: David Marchand <david.marchand@redhat.com>
Cc: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, mst@redhat.com, 
 dev@dpdk.org, Yongji Xie <xieyongji@bytedance.com>, chenbox@nvidia.com, 
 Bruce Richardson <bruce.richardson@intel.com>,
 Stephen Hemminger <stephen@networkplumber.org>, jasowangio@gmail.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: jLBJ8QFGD_OwIPOkac4uFb_cs1RH_TCIxA1eDgYQUwE_1791187892
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="000000000000fd7086065d136d5a"
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

--000000000000fd7086065d136d5a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 3, 2026 at 11:54=E2=80=AFAM David Marchand <david.marchand@redh=
at.com>
wrote:

> On Tue, 29 Sept 2026 at 12:53, Eugenio P=C3=A9rez <eperezma@redhat.com> w=
rote:
> >
> > This series introduces features to the VDUSE (vDPA Device in Userspace)
> driver
> > to support Live Migration.
> >
> > Currently, DPDK does not support VDUSE devices live migration because t=
he
> > driver lacks a mechanism to suspend the device and quiesce the rings to
> > initiate the switchover.  This series implements the suspend operation =
to
> > address this limitation.
> >
> > Furthermore, enabling Live Migration for devices with control virtqueue
> > requires two additional features.  Both of them are included in this
> series.
> >
> > * Address Spaces ID (ASID) support: This allows QEMU to isolate and
> intercept
> >   the device's CVQ. By doing so, QEMU is able to migrate the device
> status
> >   transparently, without requiring the device to support state save and
> >   restore.
> > * QUEUE_READY: This allows QEMU to control when the dataplane virtqueue=
s
> are
> >   enabled.  This ensures the dataplane is started after the device
> >   configuration has been fully restored via the CVQ.
> >
> > It also enables the VIRTIO_NET_F_STATUS feature.  This allows the devic=
e
> to
> > signal the driver that it needs to send gratuitous ARP with
> > VIRTIO_NET_S_ANNOUNCE, reducing the Live Migration downtime.
> >
> > Note that kernel headers are update to v7.3-rc3, not a stable version.
> This
> > would allow to ack the patches while the kernel uapi is published in 7.=
3.
> >
> > v3:
> > * Include uapi/linux/stddef.h and revert the -D__counted_by from v2.
>
> FYI, the issue is now fixed in main.
>

And I just re-aligned the next-virtio branch to latest main.

Thanks,
Maxime


>
>
> --
> David Marchand
>
>

--000000000000fd7086065d136d5a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Sat, Oct 3, =
2026 at 11:54=E2=80=AFAM David Marchand &lt;<a href=3D"mailto:david.marchan=
d@redhat.com">david.marchand@redhat.com</a>&gt; wrote:<br></div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex">On Tue, 29 Sept 2026 at 12:53, Eugen=
io P=C3=A9rez &lt;<a href=3D"mailto:eperezma@redhat.com" target=3D"_blank">=
eperezma@redhat.com</a>&gt; wrote:<br>
&gt;<br>
&gt; This series introduces features to the VDUSE (vDPA Device in Userspace=
) driver<br>
&gt; to support Live Migration.<br>
&gt;<br>
&gt; Currently, DPDK does not support VDUSE devices live migration because =
the<br>
&gt; driver lacks a mechanism to suspend the device and quiesce the rings t=
o<br>
&gt; initiate the switchover.=C2=A0 This series implements the suspend oper=
ation to<br>
&gt; address this limitation.<br>
&gt;<br>
&gt; Furthermore, enabling Live Migration for devices with control virtqueu=
e<br>
&gt; requires two additional features.=C2=A0 Both of them are included in t=
his series.<br>
&gt;<br>
&gt; * Address Spaces ID (ASID) support: This allows QEMU to isolate and in=
tercept<br>
&gt;=C2=A0 =C2=A0the device&#39;s CVQ. By doing so, QEMU is able to migrate=
 the device status<br>
&gt;=C2=A0 =C2=A0transparently, without requiring the device to support sta=
te save and<br>
&gt;=C2=A0 =C2=A0restore.<br>
&gt; * QUEUE_READY: This allows QEMU to control when the dataplane virtqueu=
es are<br>
&gt;=C2=A0 =C2=A0enabled.=C2=A0 This ensures the dataplane is started after=
 the device<br>
&gt;=C2=A0 =C2=A0configuration has been fully restored via the CVQ.<br>
&gt;<br>
&gt; It also enables the VIRTIO_NET_F_STATUS feature.=C2=A0 This allows the=
 device to<br>
&gt; signal the driver that it needs to send gratuitous ARP with<br>
&gt; VIRTIO_NET_S_ANNOUNCE, reducing the Live Migration downtime.<br>
&gt;<br>
&gt; Note that kernel headers are update to v7.3-rc3, not a stable version.=
=C2=A0 This<br>
&gt; would allow to ack the patches while the kernel uapi is published in 7=
.3.<br>
&gt;<br>
&gt; v3:<br>
&gt; * Include uapi/linux/stddef.h and revert the -D__counted_by from v2.<b=
r>
<br>
FYI, the issue is now fixed in main.<br></blockquote><div><br></div><div>An=
d I just re-aligned the next-virtio branch to latest main.</div><div><br></=
div><div>Thanks,</div><div>Maxime</div><div>=C2=A0</div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
<br>
<br>
-- <br>
David Marchand<br>
<br>
</blockquote></div></div>

--000000000000fd7086065d136d5a--

