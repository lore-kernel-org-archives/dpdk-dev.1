Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D1EECA5FA2
	for <dpdk-dev@archiver.kernel.org>; Mon, 28 Sep 2026 14:28:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 33F1640E21;
	Mon, 28 Sep 2026 16:28:34 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 8736140E1B
 for <dev@dpdk.org>; Mon, 28 Sep 2026 16:28:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790605712;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ER8YaNmuPLK4sEc0hYl2a+USHebaQGg7A1osuXfYcYg=;
 b=hyRG7LWuMLe3uWAZSgH9Vl7cdCY3rJ/oyDahIMYwfn9uqLh/sfXhT+mVltI/+WJZzoaDda
 GpyoukhI5UgUuzenWkm688453sXClI9ONTXIScnZST/wfLIornNjoTB5oB9ZmngdbzcH2A
 awT4cNlq7UOYL7XBlhDKKlfCeFtK1h8=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-312-48j3c902PTqCr1ram_U9CQ-1; Mon, 28 Sep 2026 10:28:29 -0400
X-MC-Unique: 48j3c902PTqCr1ram_U9CQ-1
X-Mimecast-MFC-AGG-ID: 48j3c902PTqCr1ram_U9CQ_1790605708
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-5b8ee32b66aso1603222e87.0
 for <dev@dpdk.org>; Mon, 28 Sep 2026 07:28:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790605708; x=1791210508;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ER8YaNmuPLK4sEc0hYl2a+USHebaQGg7A1osuXfYcYg=;
 b=TmBSaHKfJogSaLPeTzFhydjG+CTdYR3s3meCckJu5Up73q0IWgU9Vw3DLg8zh9ElQc
 Yvu6qcd4NQP7e1EJa1rA9ofApnb20+cPon4MHTgYA8uvMFv17xv8mWuQN9GlQSaIIWt1
 Ryn3bl2z9S2trbzwIt5p/GX8bISSv8mJ1S0DaKWP3LBvNxEgAe13IGVd9qJuUZ45n6Sx
 BBX5/vl8sNsJznd3AhOpkzEpunb9cN9BAUqf6WYV9Tb+KwDbEs9isHmdXwllSnXPVoP8
 /RVK9qrHbbpzFT6mmNySKYmdHfCRrH9Ogj1D78wCCv++a6bDzyy8uWodGyP9EOoG8cN7
 M5lw==
X-Gm-Message-State: AFq9FYJ2/vrLQ9FEWjkAziGk5QeK8h1FEfL4OdqA+p0FumuWFFS5SfVa
 zms+nS3guz7IlRcNZV/dqtz+ZIwIrw8RL6w8Lu8bpY+4X8skQMnc9MfrA9gAZFh96sCDNRHHKrW
 RpWfY1htbgavtbu8XkcfH7DmASO+1XOkVJeLOmgB7ULgCckMkwTpkCijs1mIgUyUR6m22ArvQVi
 NQHV7o5NM46Jp81MHBuK0JHmuYu0uZJA==
X-Gm-Gg: AYBFou2DuOiN+95aON5KLFdjJiQ6xD53hRdm74f9/BD17SlH4oubhvuPdb2fADcSQ3I
 albPb0pzQLnXlYQU4BQmJYJP2tVKmBFV650xkrjuvQaeDzsirHefUdhIQfBtQAOXPHiCQen0NGR
 ZxeIzevB8fBIytsgT1ebtR80haHmn21IPH0lIejYJTWmFTNUrJfNftovd4tjbN8j1FXm5gBq+It
 HgS44zDEd5+979LWW4EaOnf4ifTEgKPLSdzue+MeJPx6ofx2k4eSVZBQQ+gB/Fr7aEfxwBFrOCF
 zoMndfqYeCpke6qImjcxSbK23fsY3vaosrR+bZiT8dk=
X-Received: by 2002:a05:6512:3090:b0:5b6:1ae0:eacf with SMTP id
 2adb3069b0e04-5b8df0c6c10mr4948751e87.36.1790605708006; 
 Mon, 28 Sep 2026 07:28:28 -0700 (PDT)
X-Received: by 2002:a05:6512:3090:b0:5b6:1ae0:eacf with SMTP id
 2adb3069b0e04-5b8df0c6c10mr4948738e87.36.1790605707513; Mon, 28 Sep 2026
 07:28:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260731081031.3648665-1-pravin.bathija@dell.com>
 <20260731081031.3648665-2-pravin.bathija@dell.com>
In-Reply-To: <20260731081031.3648665-2-pravin.bathija@dell.com>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Date: Mon, 28 Sep 2026 16:28:13 +0200
X-Gm-Features: AclHuK8cZcLQS8knWY5B9ha5I4x1dMqgouALdc04PovqKtpV_YRHcSvhBXUwpZg
Message-ID: <CAO55cswsLVwgKUrVfpcNsZ9J9UqAypbhhJJ8sm4PRMwmMk2=yg@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] vhost: tolerate file descriptor in REM_MEM_REG msg
To: pravin.bathija@dell.com
Cc: dev@dpdk.org, david.marchand@redhat.com, stephen@networkplumber.org, 
 fengchengwen@huawei.com, stable@dpdk.org, thomas@monjalon.net
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: gNSFViJ2tdIwlRw7cBvmVxfZkgWoRCoPOpRwDkDTeG8_1790605708
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="00000000000021240f065c8be1cb"
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

--00000000000021240f065c8be1cb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 31, 2026 at 10:10=E2=80=AFAM <pravin.bathija@dell.com> wrote:

> From: Pravin M Bathija <pravin.bathija@dell.com>
>
> The vhost-user specification (vhost-user.rst) states that no file
> descriptors SHOULD be passed with VHOST_USER_REM_MEM_REG.  However,
> it also says: "For compatibility with existing incorrect
> implementations, the back-end MAY accept messages with one file
> descriptor.  If a file descriptor is passed, the back-end MUST close
> it without using it otherwise."
>
> Some front-ends, notably libblkio, reuse the same message-building
> helper for both ADD_MEM_REG and REM_MEM_REG and unconditionally attach
> the mapping fd.  The previous implementation rejected any
> REM_MEM_REG carrying a file descriptor with the error:
>
>         expect 0 FDs for request VHOST_USER_REM_MEM_REG, received 1
>
> This broke teardown and memory region hot-swap with these front-ends.
>
> To reproduce, run any libblkio (v1.5.0) application using the
> virtio-blk-vhost-user driver against a DPDK vhost back-end.  The
> connection is dropped during cleanup or whenever a memory region is
> unmapped and remapped.
>
> QEMU's libvhost-user reference back-end (vu_rem_mem_reg) already
> tolerates zero or one fd in this message.  Align DPDK's behavior
> with both the specification's compatibility clause and the reference
> implementation by accepting the message and closing any unexpected fd.
>
> Tested with:
>  - QEMU VM bring-up with runtime add/remove memory regions via
>    QEMU monitor
>  - QEMU post-copy live migration between source and destination
>  - SPDK vhost-blk with libblkio (fio libblkio engine, write + md5
>    verify)
>  - libblkio alloc-mem-region and map-mem-region tests exercising
>    ADD_MEM_REG / REM_MEM_REG / ADD_MEM_REG cycles against SPDK
>    vhost-blk
>
> Fixes: 1d730eea6a42 ("vhost: add memory region handlers")
> Cc: stable@dpdk.org
>
> Signed-off-by: Pravin M Bathija <pravin.bathija@dell.com>
> ---
>  lib/vhost/vhost_user.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/lib/vhost/vhost_user.c b/lib/vhost/vhost_user.c
> index 020c993b29..82c62f2f64 100644
> --- a/lib/vhost/vhost_user.c
> +++ b/lib/vhost/vhost_user.c
> @@ -73,7 +73,7 @@ VHOST_MESSAGE_HANDLER(VHOST_USER_RESET_OWNER,
> vhost_user_reset_owner, false, fal
>  VHOST_MESSAGE_HANDLER(VHOST_USER_SET_MEM_TABLE, vhost_user_set_mem_table=
,
> true, true) \
>  VHOST_MESSAGE_HANDLER(VHOST_USER_GET_MAX_MEM_SLOTS,
> vhost_user_get_max_mem_slots, false, false) \
>  VHOST_MESSAGE_HANDLER(VHOST_USER_ADD_MEM_REG, vhost_user_add_mem_reg,
> true, true) \
> -VHOST_MESSAGE_HANDLER(VHOST_USER_REM_MEM_REG, vhost_user_rem_mem_reg,
> false, true) \
> +VHOST_MESSAGE_HANDLER(VHOST_USER_REM_MEM_REG, vhost_user_rem_mem_reg,
> true, true) \
>  VHOST_MESSAGE_HANDLER(VHOST_USER_SET_LOG_BASE, vhost_user_set_log_base,
> true, true) \
>  VHOST_MESSAGE_HANDLER(VHOST_USER_SET_LOG_FD, vhost_user_set_log_fd, true=
,
> true) \
>  VHOST_MESSAGE_HANDLER(VHOST_USER_SET_VRING_NUM, vhost_user_set_vring_num=
,
> false, true) \
> @@ -1811,6 +1811,13 @@ vhost_user_rem_mem_reg(struct virtio_net **pdev,
>         struct virtio_net *dev =3D *pdev;
>         uint32_t i;
>
> +       /*
> +        * The specification says no file descriptor should be passed wit=
h
> +        * this message, but some front-ends send one anyway. Tolerate it
> and
> +        * close it without using it, as the specification requires.
> +        */
> +       close_msg_fds(ctx);
> +
>         if (dev->mem =3D=3D NULL || dev->mem->nregions =3D=3D 0) {
>                 VHOST_CONFIG_LOG(dev->ifname, ERR, "no memory regions to
> remove");
>                 return RTE_VHOST_MSG_RESULT_ERR;
> --
> 2.43.0
>
>
Reviewed-by: Maxime Coquelin <maxime.coquelin@redhat.com>

Thanks,
Maxime

--00000000000021240f065c8be1cb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Jul 31,=
 2026 at 10:10=E2=80=AFAM &lt;<a href=3D"mailto:pravin.bathija@dell.com">pr=
avin.bathija@dell.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,20=
4);padding-left:1ex">From: Pravin M Bathija &lt;<a href=3D"mailto:pravin.ba=
thija@dell.com" target=3D"_blank">pravin.bathija@dell.com</a>&gt;<br>
<br>
The vhost-user specification (vhost-user.rst) states that no file<br>
descriptors SHOULD be passed with VHOST_USER_REM_MEM_REG.=C2=A0 However,<br=
>
it also says: &quot;For compatibility with existing incorrect<br>
implementations, the back-end MAY accept messages with one file<br>
descriptor.=C2=A0 If a file descriptor is passed, the back-end MUST close<b=
r>
it without using it otherwise.&quot;<br>
<br>
Some front-ends, notably libblkio, reuse the same message-building<br>
helper for both ADD_MEM_REG and REM_MEM_REG and unconditionally attach<br>
the mapping fd.=C2=A0 The previous implementation rejected any<br>
REM_MEM_REG carrying a file descriptor with the error:<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 expect 0 FDs for request VHOST_USER_REM_MEM_REG=
, received 1<br>
<br>
This broke teardown and memory region hot-swap with these front-ends.<br>
<br>
To reproduce, run any libblkio (v1.5.0) application using the<br>
virtio-blk-vhost-user driver against a DPDK vhost back-end.=C2=A0 The<br>
connection is dropped during cleanup or whenever a memory region is<br>
unmapped and remapped.<br>
<br>
QEMU&#39;s libvhost-user reference back-end (vu_rem_mem_reg) already<br>
tolerates zero or one fd in this message.=C2=A0 Align DPDK&#39;s behavior<b=
r>
with both the specification&#39;s compatibility clause and the reference<br=
>
implementation by accepting the message and closing any unexpected fd.<br>
<br>
Tested with:<br>
=C2=A0- QEMU VM bring-up with runtime add/remove memory regions via<br>
=C2=A0 =C2=A0QEMU monitor<br>
=C2=A0- QEMU post-copy live migration between source and destination<br>
=C2=A0- SPDK vhost-blk with libblkio (fio libblkio engine, write + md5<br>
=C2=A0 =C2=A0verify)<br>
=C2=A0- libblkio alloc-mem-region and map-mem-region tests exercising<br>
=C2=A0 =C2=A0ADD_MEM_REG / REM_MEM_REG / ADD_MEM_REG cycles against SPDK<br=
>
=C2=A0 =C2=A0vhost-blk<br>
<br>
Fixes: 1d730eea6a42 (&quot;vhost: add memory region handlers&quot;)<br>
Cc: <a href=3D"mailto:stable@dpdk.org" target=3D"_blank">stable@dpdk.org</a=
><br>
<br>
Signed-off-by: Pravin M Bathija &lt;<a href=3D"mailto:pravin.bathija@dell.c=
om" target=3D"_blank">pravin.bathija@dell.com</a>&gt;<br>
---<br>
=C2=A0lib/vhost/vhost_user.c | 9 ++++++++-<br>
=C2=A01 file changed, 8 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/lib/vhost/vhost_user.c b/lib/vhost/vhost_user.c<br>
index 020c993b29..82c62f2f64 100644<br>
--- a/lib/vhost/vhost_user.c<br>
+++ b/lib/vhost/vhost_user.c<br>
@@ -73,7 +73,7 @@ VHOST_MESSAGE_HANDLER(VHOST_USER_RESET_OWNER, vhost_user_=
reset_owner, false, fal<br>
=C2=A0VHOST_MESSAGE_HANDLER(VHOST_USER_SET_MEM_TABLE, vhost_user_set_mem_ta=
ble, true, true) \<br>
=C2=A0VHOST_MESSAGE_HANDLER(VHOST_USER_GET_MAX_MEM_SLOTS, vhost_user_get_ma=
x_mem_slots, false, false) \<br>
=C2=A0VHOST_MESSAGE_HANDLER(VHOST_USER_ADD_MEM_REG, vhost_user_add_mem_reg,=
 true, true) \<br>
-VHOST_MESSAGE_HANDLER(VHOST_USER_REM_MEM_REG, vhost_user_rem_mem_reg, fals=
e, true) \<br>
+VHOST_MESSAGE_HANDLER(VHOST_USER_REM_MEM_REG, vhost_user_rem_mem_reg, true=
, true) \<br>
=C2=A0VHOST_MESSAGE_HANDLER(VHOST_USER_SET_LOG_BASE, vhost_user_set_log_bas=
e, true, true) \<br>
=C2=A0VHOST_MESSAGE_HANDLER(VHOST_USER_SET_LOG_FD, vhost_user_set_log_fd, t=
rue, true) \<br>
=C2=A0VHOST_MESSAGE_HANDLER(VHOST_USER_SET_VRING_NUM, vhost_user_set_vring_=
num, false, true) \<br>
@@ -1811,6 +1811,13 @@ vhost_user_rem_mem_reg(struct virtio_net **pdev,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct virtio_net *dev =3D *pdev;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t i;<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * The specification says no file descriptor sh=
ould be passed with<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * this message, but some front-ends send one a=
nyway. Tolerate it and<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * close it without using it, as the specificat=
ion requires.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0close_msg_fds(ctx);<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (dev-&gt;mem =3D=3D NULL || dev-&gt;mem-&gt;=
nregions =3D=3D 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 VHOST_CONFIG_LOG(de=
v-&gt;ifname, ERR, &quot;no memory regions to remove&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return RTE_VHOST_MS=
G_RESULT_ERR;<br>
-- <br>
2.43.0<br>
<br></blockquote><div><br></div><div>Reviewed-by: Maxime Coquelin &lt;<a hr=
ef=3D"mailto:maxime.coquelin@redhat.com">maxime.coquelin@redhat.com</a>&gt;=
</div><div><br></div><div>Thanks,</div><div>Maxime=C2=A0</div></div></div>

--00000000000021240f065c8be1cb--

