Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 648C5CD6E4A
	for <dpdk-dev@archiver.kernel.org>; Thu,  4 Jun 2026 10:00:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9C55D4042C;
	Thu,  4 Jun 2026 12:00:00 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 6D8E7402CC
 for <dev@dpdk.org>; Thu,  4 Jun 2026 11:59:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780567198;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2+dl5Nw9N9FghLaWjkjJVjufNjMpYLIBvQtazikByNI=;
 b=ZheBqINGa4+Aq3jvjM+NMWRu7pwYoGDsYerstqpi1ik5cT40A+HuwP1XVdCJd14XFDtJ55
 WCxTGRUQr2eGjgFZM4fpevUiTrSWn0JSgUhPGtyCBIHPlyjZuXKktG1fhbA0OXpjWlENJf
 a5ArWRjp8sGNX1vuXjrkMn0NOqhKhSE=
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com
 [74.125.82.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-FabfwFFVOOG5eyi-SQhT7Q-1; Thu, 04 Jun 2026 05:59:53 -0400
X-MC-Unique: FabfwFFVOOG5eyi-SQhT7Q-1
X-Mimecast-MFC-AGG-ID: FabfwFFVOOG5eyi-SQhT7Q_1780567193
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-137f8f21861so723522c88.0
 for <dev@dpdk.org>; Thu, 04 Jun 2026 02:59:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780567192; x=1781171992;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2+dl5Nw9N9FghLaWjkjJVjufNjMpYLIBvQtazikByNI=;
 b=fsPFNJg/dUYQPWI8+o4DGLlAnldIGpOqgeZdxgvInwqSC+1cJ+0hdObiCjfUFVo08e
 6A+i1B9pY18ccQ5rszOzwCMrCEUIQPM19mcQgRL+/R8Nctm8mj5XQWC1Si9+i/dUg6ZU
 SDvd5mfiWg8P/FMJ3EkoIR0PRJDxNbZySPPtuWnWVLn06OWsyMG00aoHLp5N78wducaT
 THLSRVxg9ZtfjXTufei79N4o8s/kdnKAcQRWaTDn6RUNKy919xR1mT3jVcMLskmvpK9i
 ehHjztFdGAxaweXwZW4CP/7zwbK1biQDbUumlhuVIM5d9ooVC2h/btpGydNHAuk6wc47
 z/VQ==
X-Gm-Message-State: AOJu0YwOhk6gbD4mHdEXd6aIpvcFMPKRUKiPZMcu++/D9pi8KU+L22pP
 dX0pfV7fK3yhMpl4H+hUQM57schQt91jdRIdQVg/tY3+qMUVrmcwIBSbgRldb0HGEUOv/v0sfLB
 3eJ2i1AB+YEREJyfxE0sQToHru9oqjzCJioOSn83LLsUq0KaNp4bnz31kF8CKxpz/Ps/tP3URiA
 joFpk3rcQI5LSMHOdafvs=
X-Gm-Gg: Acq92OGjga2o4H1zGrfGlMkewUZbFrwmFDC9Q2mfC33yTY240HOG5y5NKMOoFFiQaBJ
 CCPvio6miGrRNVhwnNIBU8Q2UGq61SL/Y2DmpcPSFtLrIjUjRn81HIg4kLet0JzK02mZZRzDPPJ
 Zfu7wJxbw7k5ZUfIMk0/uWdy2fOFBi8LLxWwHC2jqi8YpksmhEnEKe5hMyxSVUYo3cNZG0Od662
 xJuVG2OdgdJA9ECEsHrammvL4fpofchxM7eh4DBAZd+zx/rHv0bc/Kv/BnqC7fZ9U8yGu9OvMwJ
X-Received: by 2002:a05:7022:41aa:b0:137:f532:e345 with SMTP id
 a92af1059eb24-137f6bb2364mr2654380c88.26.1780567192437; 
 Thu, 04 Jun 2026 02:59:52 -0700 (PDT)
X-Received: by 2002:a05:7022:41aa:b0:137:f532:e345 with SMTP id
 a92af1059eb24-137f6bb2364mr2654371c88.26.1780567191933; Thu, 04 Jun 2026
 02:59:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260520022012.243619-1-pravin.bathija@dell.com>
 <20260520022012.243619-3-pravin.bathija@dell.com>
In-Reply-To: <20260520022012.243619-3-pravin.bathija@dell.com>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Date: Thu, 4 Jun 2026 11:59:40 +0200
X-Gm-Features: AVHnY4JrpZxwQ1Pr17ZTxGhYgoy3XP5coMv4qZZmjSPx9BuQ6BH2igdwMpToYuE
Message-ID: <CAO55cswrWG7QV_geuWuX5o0nDs8+GTgiqjoeKp8+pDcSqqQQYw@mail.gmail.com>
Subject: Re: [PATCH v14 2/5] vhost: header defines for add/rem mem region
To: pravin.bathija@dell.com
Cc: dev@dpdk.org, fengchengwen@huawei.com, stephen@networkplumber.org, 
 thomas@monjalon.net, Stephen Hemminger <stephen@networkplumber.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: OlVC2JWa9YVjbf0yfMZBTY_0nvxe1_r0fWjphp8gb5o_1780567193
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="000000000000f9695106536a9a3a"
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

--000000000000f9695106536a9a3a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 20, 2026 at 4:20=E2=80=AFAM <pravin.bathija@dell.com> wrote:

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
> Acked-by: Fengchengwen <fengchengwen@huawei.com>
> Reviewed-by: Stephen Hemminger <stephen@networkplumber.com>
> Acked-by: Maxime Coquelin <maxime.coquelin@redhat.com>
>

Same here:
Reviewed-by: Maxime Coquelin <maxime.coquelin@redhat.com>


> ---
>  lib/vhost/vhost_user.h | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/lib/vhost/vhost_user.h b/lib/vhost/vhost_user.h
> index ef486545ba..6435816534 100644
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
> +typedef struct VhostUserMemRegMsg {
> +       uint64_t padding;
> +       VhostUserMemoryRegion region;
> +} VhostUserMemRegMsg;
> +
>  typedef struct VhostUserLog {
>         uint64_t mmap_size;
>         uint64_t mmap_offset;
> @@ -186,6 +194,7 @@ typedef struct __rte_packed_begin VhostUserMsg {
>                 struct vhost_vring_state state;
>                 struct vhost_vring_addr addr;
>                 VhostUserMemory memory;
> +               VhostUserMemRegMsg memreg;
>                 VhostUserLog    log;
>                 struct vhost_iotlb_msg iotlb;
>                 VhostUserCryptoSessionParam crypto_session;
> --
> 2.43.0
>
>

--000000000000f9695106536a9a3a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, May 20,=
 2026 at 4:20=E2=80=AFAM &lt;<a href=3D"mailto:pravin.bathija@dell.com">pra=
vin.bathija@dell.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex">From: Pravin M Bathija &lt;<a href=3D"mailto:pravin.bat=
hija@dell.com" target=3D"_blank">pravin.bathija@dell.com</a>&gt;<br>
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
Acked-by: Fengchengwen &lt;<a href=3D"mailto:fengchengwen@huawei.com" targe=
t=3D"_blank">fengchengwen@huawei.com</a>&gt;<br>
Reviewed-by: Stephen Hemminger &lt;<a href=3D"mailto:stephen@networkplumber=
.com" target=3D"_blank">stephen@networkplumber.com</a>&gt;<br>
Acked-by: Maxime Coquelin &lt;<a href=3D"mailto:maxime.coquelin@redhat.com"=
 target=3D"_blank">maxime.coquelin@redhat.com</a>&gt;<br></blockquote><div>=
<br></div><div>Same here:</div><div>Reviewed-by: Maxime Coquelin &lt;<a hre=
f=3D"mailto:maxime.coquelin@redhat.com" target=3D"_blank">maxime.coquelin@r=
edhat.com</a>&gt;</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex">
---<br>
=C2=A0lib/vhost/vhost_user.h | 9 +++++++++<br>
=C2=A01 file changed, 9 insertions(+)<br>
<br>
diff --git a/lib/vhost/vhost_user.h b/lib/vhost/vhost_user.h<br>
index ef486545ba..6435816534 100644<br>
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
+typedef struct VhostUserMemRegMsg {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t padding;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0VhostUserMemoryRegion region;<br>
+} VhostUserMemRegMsg;<br>
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
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VhostUserMemRegMsg =
memreg;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 VhostUserLog=C2=A0 =
=C2=A0 log;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct vhost_iotlb_=
msg iotlb;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 VhostUserCryptoSess=
ionParam crypto_session;<br>
-- <br>
2.43.0<br>
<br>
</blockquote></div></div>

--000000000000f9695106536a9a3a--

