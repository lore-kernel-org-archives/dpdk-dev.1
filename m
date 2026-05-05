Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7463CD3430
	for <dpdk-dev@archiver.kernel.org>; Tue,  5 May 2026 09:31:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E4F9440659;
	Tue,  5 May 2026 11:31:20 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 50CE140272
 for <dev@dpdk.org>; Tue,  5 May 2026 11:31:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777973478;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dSHqhu9A1Os1tycvcGjdRyVN5p2GFxw13zaRkSDtLaE=;
 b=iKn+s4ebig3FECNrYiMnPZI71spppCJO5m/HB/TkvvaQSBZq1h02gGMx9P8vcmUURY/sPe
 pKHSRIY36M0WMYCH1+GBx0APpzvWLsk6/0o6i1LiEOu6PwlYOVyCo1gh1q6BzVyH8kuO3j
 xEe2ZS1X6g09sLKDDrEY0JyF9As7sKg=
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com
 [74.125.82.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-467-EXjj437FOCmezLuq9Z4hUA-1; Tue, 05 May 2026 05:31:15 -0400
X-MC-Unique: EXjj437FOCmezLuq9Z4hUA-1
X-Mimecast-MFC-AGG-ID: EXjj437FOCmezLuq9Z4hUA_1777973474
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-130a468d5cdso1243101c88.0
 for <dev@dpdk.org>; Tue, 05 May 2026 02:31:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777973474; x=1778578274;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dSHqhu9A1Os1tycvcGjdRyVN5p2GFxw13zaRkSDtLaE=;
 b=nv0BXiS5UchKXmy2ruV0fJKYn3lyrrjiGQJSsoBhfrjP2uiL1vB53bH2BgaBjszubR
 E5b3M9Pu3owAmYHaUFzporASGwi4uSBdGlATUtS9JV1y8DTCKIAhHnfgybFgnNzEUNF7
 TOro2cq/kIJdrP2DDmYCoywCq7eZUIHnNyJ2N0Bos/w/7AcDmilE0yWZQ4bnsODGfGxW
 +BxVrjJ0uz1sP2mOgrQEpnWvYPnsQ26O9wQsfaDK2+LZLk6Whs8AX6mP/2tVOCwr9CM/
 7hyfdA4dbLSCoUJ3TtHL8wleEBKOZmGxhPqHiQYDwcVuURfmqUouJVOcX0E5MdYwptfg
 aC4A==
X-Gm-Message-State: AOJu0YwojmAPP+marOAUeJfVJs6pEd0mEWspuovgG7vpyFPNGV7qhp0Q
 0MG434Fq9hA3NXRatlWamRXsn1JEiMZX8/1lFgF8sSRqRhMQQHg+0X5mi6klu6Qz6TwWUGDjibe
 fPcDL8unR4pINdKm3iLBLSWec6A1OisPVbLrVcyibEPeV9WMinxC7Y3kz5s6QVvSq0G6lnrYCLs
 HqfoX4hm4YsjTivn5V2S8=
X-Gm-Gg: AeBDiesAguGrx3vnBO3z0zdBuZ/Q0F90roEBVefmTyUHNz2rteCyb+gAPcBCZv41dhq
 tHu/Cv3VaRsbHNJEnBHxCYPc2y/Mv9OJ8b/jIzakbjLedvCmmDlnZnQvh3t783fGl2Rn8gMm+le
 iGfjVl8GspZCxBe+NCBtpU0IvoaZPdWfv9DC9AOFVkjTru3tb9jREf/hRIwKUz85s4Jsw9XKT5r
 +2oSAC/sNlY6/f9SHQkCPQ+uj2ghIY8UrTNu7oNsijMUrGLGNoTTmwlnvyNl9O7Ek78D7//HXhg
X-Received: by 2002:a05:7022:160a:b0:12a:6ab7:3f8a with SMTP id
 a92af1059eb24-130b15418b3mr1455866c88.3.1777973474240; 
 Tue, 05 May 2026 02:31:14 -0700 (PDT)
X-Received: by 2002:a05:7022:160a:b0:12a:6ab7:3f8a with SMTP id
 a92af1059eb24-130b15418b3mr1455844c88.3.1777973473677; Tue, 05 May 2026
 02:31:13 -0700 (PDT)
MIME-Version: 1.0
References: <20260505055251.818594-1-pravin.bathija@dell.com>
 <20260505055251.818594-3-pravin.bathija@dell.com>
In-Reply-To: <20260505055251.818594-3-pravin.bathija@dell.com>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Date: Tue, 5 May 2026 11:31:02 +0200
X-Gm-Features: AVHnY4JMJIaN-G7kTkHeWn6lcc8W60tw3t2Qp8fiJ6gX17rj0bwkT7DOdtH06Nw
Message-ID: <CAO55csxS2spSMb+iphwu6yet+Xgr+ui2dP7JpEyVy1aZ1Uievw@mail.gmail.com>
Subject: Re: [PATCH v11 2/5] vhost_user: header defines for add/rem mem region
To: pravin.bathija@dell.com
Cc: dev@dpdk.org, stephen@networkplumber.org, thomas@monjalon.net, 
 fengchengwen@huawei.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 2qoo3BM2cauJYpYd9uknGuT4g988tYYVsCIdVtUkCKU_1777973474
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="00000000000051aeb206510eb54f"
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

--00000000000051aeb206510eb54f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 5, 2026 at 7:53=E2=80=AFAM <pravin.bathija@dell.com> wrote:

> From: Pravin M Bathija <pravin.bathija@dell.com>
>
> The changes in this file cover the enum message requests for
> supporting add/remove memory regions. The front-end vhost-user
> client sends messages like get max memory slots, add memory region
> and remove memory region which are covered in these changes which
> are on the vhost-user back-end. The changes also include data structure
> definition of memory region to be added/removed. The data structure
> VhostUserMsg has been changed to include the memory region.
>
> Signed-off-by: Pravin M Bathija <pravin.bathija@dell.com>
> ---
>  lib/vhost/vhost_user.h | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/lib/vhost/vhost_user.h b/lib/vhost/vhost_user.h
> index ef486545ba..f8d921f7f1 100644
> --- a/lib/vhost/vhost_user.h
> +++ b/lib/vhost/vhost_user.h
> @@ -67,6 +67,9 @@ typedef enum VhostUserRequest {
>         VHOST_USER_POSTCOPY_END =3D 30,
>         VHOST_USER_GET_INFLIGHT_FD =3D 31,
>         VHOST_USER_SET_INFLIGHT_FD =3D 32,
> +       VHOST_USER_GET_MAX_MEM_SLOTS =3D 36,
> +       VHOST_USER_ADD_MEM_REG =3D 37,
> +       VHOST_USER_REM_MEM_REG =3D 38,
>         VHOST_USER_SET_STATUS =3D 39,
>         VHOST_USER_GET_STATUS =3D 40,
>  } VhostUserRequest;
> @@ -91,6 +94,11 @@ typedef struct VhostUserMemory {
>         VhostUserMemoryRegion regions[VHOST_MEMORY_MAX_NREGIONS];
>  } VhostUserMemory;
>
> +typedef struct VhostUserSingleMemReg {
> +       uint64_t padding;
> +       VhostUserMemoryRegion region;
> +} VhostUserSingleMemReg;
> +
>  typedef struct VhostUserLog {
>         uint64_t mmap_size;
>         uint64_t mmap_offset;
> @@ -186,6 +194,7 @@ typedef struct __rte_packed_begin VhostUserMsg {
>                 struct vhost_vring_state state;
>                 struct vhost_vring_addr addr;
>                 VhostUserMemory memory;
> +               VhostUserSingleMemReg memory_single;
>                 VhostUserLog    log;
>                 struct vhost_iotlb_msg iotlb;
>                 VhostUserCryptoSessionParam crypto_session;
> --
> 2.43.0
>
>

Reviewed-by: Maxime Coquelin <maxime.coquelin@redhat.com>

Thanks,
Maxime

--00000000000051aeb206510eb54f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, May 5, =
2026 at 7:53=E2=80=AFAM &lt;<a href=3D"mailto:pravin.bathija@dell.com">prav=
in.bathija@dell.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">From: Pravin M Bathija &lt;<a href=3D"mailto:pravin.bath=
ija@dell.com" target=3D"_blank">pravin.bathija@dell.com</a>&gt;<br>
<br>
The changes in this file cover the enum message requests for<br>
supporting add/remove memory regions. The front-end vhost-user<br>
client sends messages like get max memory slots, add memory region<br>
and remove memory region which are covered in these changes which<br>
are on the vhost-user back-end. The changes also include data structure<br>
definition of memory region to be added/removed. The data structure<br>
VhostUserMsg has been changed to include the memory region.<br>
<br>
Signed-off-by: Pravin M Bathija &lt;<a href=3D"mailto:pravin.bathija@dell.c=
om" target=3D"_blank">pravin.bathija@dell.com</a>&gt;<br>
---<br>
=C2=A0lib/vhost/vhost_user.h | 9 +++++++++<br>
=C2=A01 file changed, 9 insertions(+)<br>
<br>
diff --git a/lib/vhost/vhost_user.h b/lib/vhost/vhost_user.h<br>
index ef486545ba..f8d921f7f1 100644<br>
--- a/lib/vhost/vhost_user.h<br>
+++ b/lib/vhost/vhost_user.h<br>
@@ -67,6 +67,9 @@ typedef enum VhostUserRequest {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 VHOST_USER_POSTCOPY_END =3D 30,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 VHOST_USER_GET_INFLIGHT_FD =3D 31,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 VHOST_USER_SET_INFLIGHT_FD =3D 32,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0VHOST_USER_GET_MAX_MEM_SLOTS =3D 36,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0VHOST_USER_ADD_MEM_REG =3D 37,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0VHOST_USER_REM_MEM_REG =3D 38,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 VHOST_USER_SET_STATUS =3D 39,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 VHOST_USER_GET_STATUS =3D 40,<br>
=C2=A0} VhostUserRequest;<br>
@@ -91,6 +94,11 @@ typedef struct VhostUserMemory {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 VhostUserMemoryRegion regions[VHOST_MEMORY_MAX_=
NREGIONS];<br>
=C2=A0} VhostUserMemory;<br>
<br>
+typedef struct VhostUserSingleMemReg {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t padding;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0VhostUserMemoryRegion region;<br>
+} VhostUserSingleMemReg;<br>
+<br>
=C2=A0typedef struct VhostUserLog {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint64_t mmap_size;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint64_t mmap_offset;<br>
@@ -186,6 +194,7 @@ typedef struct __rte_packed_begin VhostUserMsg {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct vhost_vring_=
state state;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct vhost_vring_=
addr addr;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 VhostUserMemory mem=
ory;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VhostUserSingleMemR=
eg memory_single;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 VhostUserLog=C2=A0 =
=C2=A0 log;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct vhost_iotlb_=
msg iotlb;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 VhostUserCryptoSess=
ionParam crypto_session;<br>
-- <br>
2.43.0<br>
<br></blockquote><div><br></div><div><div><br></div><div>Reviewed-by: Maxim=
e Coquelin &lt;<a href=3D"mailto:maxime.coquelin@redhat.com">maxime.coqueli=
n@redhat.com</a>&gt;</div><div><br></div><div>Thanks,</div><div>Maxime=C2=
=A0</div>=C2=A0</div></div></div>

--00000000000051aeb206510eb54f--

