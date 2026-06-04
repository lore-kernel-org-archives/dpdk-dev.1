Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDF3BCD6E6B
	for <dpdk-dev@archiver.kernel.org>; Thu,  4 Jun 2026 11:52:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F09C9402CC;
	Thu,  4 Jun 2026 13:52:32 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id BF089402B6
 for <dev@dpdk.org>; Thu,  4 Jun 2026 13:52:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780573950;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Lcuwa/dBBG5bZML+0kW/mZKY/tNufGomlhQW/QC9AdI=;
 b=FVH7mRpA5FfKzNHjopINcSjgKdWWmBFQK4KLKvWWAYhdQ30oEkvxUqfkj6WXywMkbhGxX0
 BN/nbVHWJfCumn0vLu/9WQ9z0G+Aqk33IEvxZo1ENacwvkgoSEgA0d2Rj2rMugg5j8TVof
 /1dE0rMoNmqXqanUNBA0yIX07ZVZkTw=
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com
 [74.125.82.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-385-4fvMgauQPLqyOnrx1OQl2g-1; Thu, 04 Jun 2026 07:52:28 -0400
X-MC-Unique: 4fvMgauQPLqyOnrx1OQl2g-1
X-Mimecast-MFC-AGG-ID: 4fvMgauQPLqyOnrx1OQl2g_1780573947
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-137ea73393cso2803519c88.0
 for <dev@dpdk.org>; Thu, 04 Jun 2026 04:52:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780573947; x=1781178747;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Lcuwa/dBBG5bZML+0kW/mZKY/tNufGomlhQW/QC9AdI=;
 b=bkSOG8me1qQftf5PIeHLJT2KoTtM25Sy+djBzsUUp5NmY0eE1n+7haUpO9ZDfjN+Qv
 oRfNmLuI/iCb0JZssTxYbGHPZa9FT2kpW4flmEw4j13lVdGieU5iJOd3nkLDh/2OphaX
 F40fAQ2/7fX8k5JnUO9/PHtfYb9vXu78/DpRk7wqLbcwJD5UJxkDKtyv+t2FT+kmullp
 wG4gy0TmbzhAeT34Rou8mSfEzcZAU2/WL1jL6Ireu4XGpWrGyrmor4vYvwP3CvMdbgQ0
 kIkCG0+blqat32Lpy5yg9Eah91DglVSxwmaHEfYfr9NnGxVwATA8KQnHSTktxzjVFvIS
 zHIg==
X-Gm-Message-State: AOJu0YxPOsrGixqs1chis8rFv0mkQNi2EZUN0aXAO9OIOu7lM8EafSHd
 UsjXyGUw/dvT9PoGwmx7HNSw+lpNlfIE7dwa+BgnpYzJpS+kfJYHcBXaLzEUXEjbXpycL+UUUO1
 nGNL8CNh3cwAXH00NhSUOCXQma0Q7kxcACdmDOVsMeWJQfEbTyqpbcVvPNGWX2iwh47w7amttgK
 7AT/QkBQ21YuMWHuMQzys=
X-Gm-Gg: Acq92OH4Mirz5ynoxMkr6TDJLvPtC3DQ9Hwf7IK8vcVoZKEPzXY/5hqqxAyaQVN9wQx
 oCVouEz+Re6y3D7cyi8Kk6OAeBcIie0qt1TkyDnHdKCuv7oa8BMNvooKFlHanDvrLsINrZoEigQ
 PwOZQNIlPrmSsJTu+23g8kEF2Dr9MXcz+XnJ/q9VRf/QzPoAB/XncDniKlBOvq2dylx9MJCGu4F
 /lsc9B7EhWy+2j3Tq+MRA+4OKV71BgX173UH3jHzVpdz87i6WdIPd1rhigasCdHyX3VvKBU4q/J
X-Received: by 2002:a05:7022:661e:b0:137:f58c:3cb5 with SMTP id
 a92af1059eb24-137f6bbb081mr3427302c88.26.1780573947222; 
 Thu, 04 Jun 2026 04:52:27 -0700 (PDT)
X-Received: by 2002:a05:7022:661e:b0:137:f58c:3cb5 with SMTP id
 a92af1059eb24-137f6bbb081mr3427282c88.26.1780573946662; Thu, 04 Jun 2026
 04:52:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260520022012.243619-1-pravin.bathija@dell.com>
 <20260520022012.243619-6-pravin.bathija@dell.com>
In-Reply-To: <20260520022012.243619-6-pravin.bathija@dell.com>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Date: Thu, 4 Jun 2026 13:52:14 +0200
X-Gm-Features: AVHnY4InhTlqiMaXSdDj-U0Cy5WRm9IlYOzCYV4i-ze97pxfZj3xhmYHjWEEs1U
Message-ID: <CAO55csz3EORg=F++8h4mvoY525wZyPfcGNbZ+4VO8pa_DAj2qA@mail.gmail.com>
Subject: Re: [PATCH v14 5/5] vhost: enable configure memory slots
To: pravin.bathija@dell.com
Cc: dev@dpdk.org, fengchengwen@huawei.com, stephen@networkplumber.org, 
 thomas@monjalon.net, Stephen Hemminger <stephen@networkplumber.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: aErZtCXrZMRpL-kzU8VaGdidYJdvvEmvvlA3Zzi0U6c_1780573947
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="0000000000009665fe06536c2d70"
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

--0000000000009665fe06536c2d70
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 20, 2026 at 4:20=E2=80=AFAM <pravin.bathija@dell.com> wrote:

> From: Pravin M Bathija <pravin.bathija@dell.com>
>
> This patch enables configure memory slots in the header define
> VHOST_USER_PROTOCOL_FEATURES.
>
> Signed-off-by: Pravin M Bathija <pravin.bathija@dell.com>
> Acked-by: Fengchengwen <fengchengwen@huawei.com>
> Reviewed-by: Stephen Hemminger <stephen@networkplumber.com>
> Acked-by: Maxime Coquelin <maxime.coquelin@redhat.com>
> ---
>  lib/vhost/vhost_user.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/lib/vhost/vhost_user.h b/lib/vhost/vhost_user.h
> index 6435816534..732aa4dc02 100644
> --- a/lib/vhost/vhost_user.h
> +++ b/lib/vhost/vhost_user.h
> @@ -32,6 +32,7 @@
>                                          (1ULL <<
> VHOST_USER_PROTOCOL_F_BACKEND_SEND_FD) | \
>                                          (1ULL <<
> VHOST_USER_PROTOCOL_F_HOST_NOTIFIER) | \
>                                          (1ULL <<
> VHOST_USER_PROTOCOL_F_PAGEFAULT) | \
> +                                        (1ULL <<
> VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS) | \
>                                          (1ULL <<
> VHOST_USER_PROTOCOL_F_STATUS))
>
>  typedef enum VhostUserRequest {
> --
> 2.43.0
>
> Reviewed-by: Maxime Coquelin <maxime.coquelin@redhat.com>

--0000000000009665fe06536c2d70
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
This patch enables configure memory slots in the header define<br>
VHOST_USER_PROTOCOL_FEATURES.<br>
<br>
Signed-off-by: Pravin M Bathija &lt;<a href=3D"mailto:pravin.bathija@dell.c=
om" target=3D"_blank">pravin.bathija@dell.com</a>&gt;<br>
Acked-by: Fengchengwen &lt;<a href=3D"mailto:fengchengwen@huawei.com" targe=
t=3D"_blank">fengchengwen@huawei.com</a>&gt;<br>
Reviewed-by: Stephen Hemminger &lt;<a href=3D"mailto:stephen@networkplumber=
.com" target=3D"_blank">stephen@networkplumber.com</a>&gt;<br>
Acked-by: Maxime Coquelin &lt;<a href=3D"mailto:maxime.coquelin@redhat.com"=
 target=3D"_blank">maxime.coquelin@redhat.com</a>&gt;<br>
---<br>
=C2=A0lib/vhost/vhost_user.h | 1 +<br>
=C2=A01 file changed, 1 insertion(+)<br>
<br>
diff --git a/lib/vhost/vhost_user.h b/lib/vhost/vhost_user.h<br>
index 6435816534..732aa4dc02 100644<br>
--- a/lib/vhost/vhost_user.h<br>
+++ b/lib/vhost/vhost_user.h<br>
@@ -32,6 +32,7 @@<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(1=
ULL &lt;&lt; VHOST_USER_PROTOCOL_F_BACKEND_SEND_FD) | \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(1=
ULL &lt;&lt; VHOST_USER_PROTOCOL_F_HOST_NOTIFIER) | \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(1=
ULL &lt;&lt; VHOST_USER_PROTOCOL_F_PAGEFAULT) | \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (1ULL &l=
t;&lt; VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS) | \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(1=
ULL &lt;&lt; VHOST_USER_PROTOCOL_F_STATUS))<br>
<br>
=C2=A0typedef enum VhostUserRequest {<br>
-- <br>
2.43.0<br>
<br></blockquote><div>Reviewed-by: Maxime Coquelin &lt;<a href=3D"mailto:ma=
xime.coquelin@redhat.com" target=3D"_blank">maxime.coquelin@redhat.com</a>&=
gt;=C2=A0</div></div></div>

--0000000000009665fe06536c2d70--

