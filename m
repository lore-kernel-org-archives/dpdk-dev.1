Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CC77CCD184
	for <dpdk-dev@archiver.kernel.org>; Tue, 14 Oct 2025 13:00:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7A658402CC;
	Tue, 14 Oct 2025 15:00:45 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 16922402A8
 for <dev@dpdk.org>; Tue, 14 Oct 2025 15:00:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760446843;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FBx9oQNSC/Hv3iFoSVHOjfsTsDhzBV4E257n0YuJ3dk=;
 b=AAqdggNcc9U27sok1Dqgfn6x0dB5kBGMYIk9KAAmjJfY3aonQiveKESCK0rLYg85SY8o32
 g+cCo5Oi5RwsPGX/K4LZ1TgWOuevlRFselwmFCxyomFBlR5gFneZ+aexP953zbZjo1Qt+M
 H7xYphy23QFXzOMELUvfE5QE2Ms3QQU=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-ssdpBSynPh-5ti5TqlEDCQ-1; Tue, 14 Oct 2025 09:00:42 -0400
X-MC-Unique: ssdpBSynPh-5ti5TqlEDCQ-1
X-Mimecast-MFC-AGG-ID: ssdpBSynPh-5ti5TqlEDCQ_1760446841
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-58175ebd87bso3118089e87.0
 for <dev@dpdk.org>; Tue, 14 Oct 2025 06:00:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760446840; x=1761051640;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FBx9oQNSC/Hv3iFoSVHOjfsTsDhzBV4E257n0YuJ3dk=;
 b=bt+ntKAevTOf6AS62fnYB//tSDDEKtlJIKGncZZnsn8nsy1gZRcsso4GifyAd/DLqn
 Eww6Qvp3jbVlBqWajHawHhIhT3cvVAXqMHMX8scRtPsQxnQ1OkC28LEsx/R6WPF5Gz6k
 Amkc3OmaohV/x/Dji2ZfWJMubObi7wUwdQNQMGtZgIbyba4GlU/FPqjWIxoNk2f4xJ0q
 wuiGcFlBnizzWhlTVtP4ojIWhY1HpLbpMvrLATeG/AKRZKV296LVWwv2t19d+6P+vq+c
 xtc8/+Lxni0gMuW3tL3i9ocgEofNK6iaFa8ZJu+jKu8ppR9ZlT1nKdFg5LTu8a/Ixyu6
 3ICg==
X-Gm-Message-State: AOJu0Yzeg6t5CFPVRtQy2J+/DwIySjsPnDs4nd2TziqHaFs/CEw+K1nJ
 Tr3DixfRTSN++v5X8yDZYWs3iHiUao5pZUpQz33G8RCHv6WMPeDyfHAa3PAojSxZcwRvYer3VzU
 KBZIC00Asi6n8YKX39Y/7FCmIQUJwWI8OHveTYKdndIPHbT2bCHoG2VZVClYKGMtSXxL6+CrL0V
 LzKKpQjrfPlkGY96aqaqk=
X-Gm-Gg: ASbGncvA2c+BHUGCuVlSXx0uJQGm2/G7E+mBAtwrWoFXzN9XvAatWa4YZYvXlOP9jzJ
 qHcqgqjdTSBV7evz6+XmNA3f/vk3+x2Ry33JWIBAQnIp3q/TXvyEqfHQ100aA6MYUWvHmNMPH1M
 WT5I98MSERWmxp05m+dXQ=
X-Received: by 2002:a05:6512:3082:b0:57b:e70c:8431 with SMTP id
 2adb3069b0e04-5906d77e013mr7170361e87.2.1760446840267; 
 Tue, 14 Oct 2025 06:00:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG3V26+GVQ6EJM244ZLVjoUyQqud7MuTIEz+AW1ovQ/rrmG0WfKWXNtUwa5UwrNhoMvUbBp9el8AxGcr4Pd/ew=
X-Received: by 2002:a05:6512:3082:b0:57b:e70c:8431 with SMTP id
 2adb3069b0e04-5906d77e013mr7170342e87.2.1760446839734; Tue, 14 Oct 2025
 06:00:39 -0700 (PDT)
MIME-Version: 1.0
References: <20251007145617.2888818-1-sil-plv@napatech.com>
 <20251007150630.2895365-1-sil-plv@napatech.com>
 <CAO55cszP6B5aUnRtydZ170WOGCRs1iFe-zgSX2PyJSU4i2HKxA@mail.gmail.com>
In-Reply-To: <CAO55cszP6B5aUnRtydZ170WOGCRs1iFe-zgSX2PyJSU4i2HKxA@mail.gmail.com>
From: Maxime Coquelin <mcoqueli@redhat.com>
Date: Tue, 14 Oct 2025 15:00:28 +0200
X-Gm-Features: AS18NWAtomsTZZuY9eRsHmgcxozex9sztOWKktC4kwI8v8EqmyzyUEw_0sMngf0
Message-ID: <CAO55csx-CUrS=eFtHhA+Y9nJygPmV-8segingRU5MDBc5taGDw@mail.gmail.com>
Subject: Re: [PATCH v2] vhost: always lock all QPs if handlers request it
To: Serhii Iliushyk <sil-plv@napatech.com>
Cc: dev@dpdk.org, mko-plv@napatech.com, ckm@napatech.com, 
 maxime.coquelin@redhat.com, Chenbo Xia <chenbox@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: BrrQdpCSVV_ie-aBjn2mMo-i1tciLmGGqn7y1oWyyac_1760446841
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

On Tue, Oct 14, 2025 at 2:54=E2=80=AFPM Maxime Coquelin <mcoqueli@redhat.co=
m> wrote:
>
> Hi Serghii,
>
> On Tue, Oct 7, 2025 at 5:06=E2=80=AFPM Serhii Iliushyk <sil-plv@napatech.=
com> wrote:
> >
> > The check for the VIRTIO_DEV_VDPA_CONFIGURED flag is not needed
> > since each handler has its own lock_all_qps flag
> > to indicate whether it needs all queue pairs.
>
> Hmm, I think this is needed because lock_all_qps is only effective
> with the SW datapath.
> With vDPA, once the device is configured, we would end-up with
> virtqueues modifications
> without the HW being stopped or even notified.
>
> > Checking the VIRTIO_DEV_VDPA_CONFIGURED flag caused certain handlers
> > (for example, SET_MEM_TABLE for memory hot plug) to run without holding
> > the per-vq access_lock and trigger vq_assert_lock failures.
>
> In this specific memory hotplug case, we do the right thing in the handle=
r:
>
>     if (dev->mem) {
>         if (dev->flags & VIRTIO_DEV_VDPA_CONFIGURED) {
>             struct rte_vdpa_device *vdpa_dev =3D dev->vdpa_dev;
>
>             if (vdpa_dev && vdpa_dev->ops->dev_close)
>                 vdpa_dev->ops->dev_close(dev->vid);
>             dev->flags &=3D ~VIRTIO_DEV_VDPA_CONFIGURED;
>         }
>
> Maybe we should also lock all the queue pairs once the vDPA is closed.
> The problem is to handle the unlock properly.

Maybe a generic solution would be in vhost_user_msg_handler() to close
the vDPA device,
clear CONFIGURED flag and lock all queue pairs as we do in
vhost_user_set_mem_table?

I have no hardware to test, could you have a try if you think it makes sens=
e?

Thanks,
Maxime
> Maxime
>
> > Signed-off-by: Serhii Iliushyk <sil-plv@napatech.com>
> > ---
> > v2
> > * fix typo in commit message
> > ---
> >  lib/vhost/vhost_user.c | 6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
> >
> > diff --git a/lib/vhost/vhost_user.c b/lib/vhost/vhost_user.c
> > index 4bfb13fb98..9288da9322 100644
> > --- a/lib/vhost/vhost_user.c
> > +++ b/lib/vhost/vhost_user.c
> > @@ -3171,10 +3171,8 @@ vhost_user_msg_handler(int vid, int fd)
> >          * would cause a dead lock.
> >          */
> >         if (msg_handler !=3D NULL && msg_handler->lock_all_qps) {
> > -               if (!(dev->flags & VIRTIO_DEV_VDPA_CONFIGURED)) {
> > -                       vhost_user_lock_all_queue_pairs(dev);
> > -                       unlock_required =3D 1;
> > -               }
> > +               vhost_user_lock_all_queue_pairs(dev);
> > +               unlock_required =3D 1;
> >         }
> >
> >         handled =3D false;
> > --
> > 2.47.3
> >

