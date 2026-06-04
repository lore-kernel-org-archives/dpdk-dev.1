Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74756CD6E4A
	for <dpdk-dev@archiver.kernel.org>; Thu,  4 Jun 2026 10:08:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AB0FD402E0;
	Thu,  4 Jun 2026 12:08:33 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 0620C402CC
 for <dev@dpdk.org>; Thu,  4 Jun 2026 12:08:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780567712;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=66PyazUVyGpU/ttyy5J8AD6PlmO9+8uAJU+XVcvenvQ=;
 b=XtVinomCUqjQ1bbKRbtEmptnwtPwFCxIf/sqdY22aQxX0bKmt+2lHC0UouFIVvY4oCtOEY
 SVIPFy2rKhGWQgPRGd3nmYpN0bjvlGuI+VHZCfqjZRsBor4KgxOFV7s7RTwecJrPpgD/rX
 vfczzDSCFGK3Kvq+rJwPBlHpVra8pAE=
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-ixsMm2tMPzeGtHpetNPY_A-1; Thu, 04 Jun 2026 06:08:28 -0400
X-MC-Unique: ixsMm2tMPzeGtHpetNPY_A-1
X-Mimecast-MFC-AGG-ID: ixsMm2tMPzeGtHpetNPY_A_1780567707
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-304d8613efbso447720eec.1
 for <dev@dpdk.org>; Thu, 04 Jun 2026 03:08:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780567707; x=1781172507;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=66PyazUVyGpU/ttyy5J8AD6PlmO9+8uAJU+XVcvenvQ=;
 b=UzUP+TbEK4ZlPaChUd/XPG0FYWy65kyiBlx8IRvA6diLsEKS4/I86RjrEM5LpdDk1i
 7+q64JDt850EaIEHAq7mDhMGcnYxEU7mfFJMYiBS0Yq/yDCjXQnHmp3sCFF5A4SK+tbJ
 rnNB5Cvg8XdFR068cTB0mIh1mhVGwaEhN1BiJe3N22+BDkDL1LZUMhWtGyYWraj3UuRd
 hbqjXjPZtm+mIRVs/IoQYDAl9nlrkM/1P73uGYYdyrQlXCluQ0Aasyap7/JxATbWvBhb
 vmIScHFhlPh6SOQP0n7EwIeze71CzKiwb83+389yonalm5tI/UabPzG+zJgmdB1MqMB3
 Ms+w==
X-Gm-Message-State: AOJu0Yx7Gj9U/KgHzaaTefTajXL2iP9gXDv9MPVBWK8dkGh9YqpOKAEL
 dwFo74CVMHa6Nivns+PrYnO6wvvPIowwn8fk6XBzuP52kSE+i4ti64DdAZUTS65IjN/G0eIg2vo
 Mjxk/xedWOSzQrmtPB0CmTi0yl76zg0+Zvq6oOd9Tne63sWoJ6fXVKTjQzwIZaGIYvBg8ENI1r+
 mWyVbSIwEJjp9t2BlK2+I=
X-Gm-Gg: Acq92OFGN30F2rISLylmCaJ2rJQJ0y5c1vaTpGsnuEKrbWX9553c5iS8ESwk7ZJg7R6
 xwX+jlj5yekM/JgWDmHlfCEepsRzqXkMxBY0Jdc+gQtPqu0Q/Oj7Alhim6eaPPdKhIuYyhYSacI
 m4w5ne4PIRSn7RznrL+UxdIyHjqb1y81kqGQIWXhzFuDDoW6QsWFM1iwKfdwqqeHpc/slI/yst7
 gmRf79CLzSzw15Xf/1UCtOlR8ZiTbuKvhXQmkWRi0ok9mJjlb7/YaL3bEYJ7bprv66dYPzshTKi
X-Received: by 2002:a05:693c:68ca:b0:304:5db8:da95 with SMTP id
 5a478bee46e88-3074fb8754bmr1912743eec.23.1780567706733; 
 Thu, 04 Jun 2026 03:08:26 -0700 (PDT)
X-Received: by 2002:a05:693c:68ca:b0:304:5db8:da95 with SMTP id
 5a478bee46e88-3074fb8754bmr1912736eec.23.1780567706194; Thu, 04 Jun 2026
 03:08:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260520022012.243619-1-pravin.bathija@dell.com>
 <20260520022012.243619-4-pravin.bathija@dell.com>
In-Reply-To: <20260520022012.243619-4-pravin.bathija@dell.com>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Date: Thu, 4 Jun 2026 12:08:14 +0200
X-Gm-Features: AVHnY4LGE4YJgVggD_05wWVGWO3cC_FJ5ujc8FDxXb7P6WKBIByv7xA_jSODp8Q
Message-ID: <CAO55csxV2O5-CgQethafvrtNeQygq=+HL=9h3ztO0Yf15VWH0g@mail.gmail.com>
Subject: Re: [PATCH v14 3/5] vhost: refactor memory helper functions
To: pravin.bathija@dell.com
Cc: dev@dpdk.org, fengchengwen@huawei.com, stephen@networkplumber.org, 
 thomas@monjalon.net, Stephen Hemminger <stephen@networkplumber.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 12upKTRD51ciEbuLNJDA4LYBqIoew23cCbXfQ5EWrhE_1780567707
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="000000000000a06a2f06536ab9b8"
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

--000000000000a06a2f06536ab9b8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 20, 2026 at 4:20=E2=80=AFAM <pravin.bathija@dell.com> wrote:

> From: Pravin M Bathija <pravin.bathija@dell.com>
>
> - Extract reusable helper routines for vhost-user backend memory
> operations.
> - Split DMA map/unmap into per-region logic.
> - Decouple and rework memory region free routines.
> - Iterate over VHOST_MEMORY_MAX_NREGIONS uniformly
> across related functions to simplify code reuse
>
> Signed-off-by: Pravin M Bathija <pravin.bathija@dell.com>
> Acked-by: Fengchengwen <fengchengwen@huawei.com>
> Reviewed-by: Stephen Hemminger <stephen@networkplumber.com>
> Acked-by: Maxime Coquelin <maxime.coquelin@redhat.com>
>

I did not Ack this one AFAICT.


> ---
>  lib/vhost/vhost_user.c | 172 ++++++++++++++++++++++++++---------------
>  1 file changed, 110 insertions(+), 62 deletions(-)
>
>
>
The change looks good though:
Reviewed-by: Maxime Coquelin <maxime.coquelin@redhat.com>

--000000000000a06a2f06536ab9b8
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
- Extract reusable helper routines for vhost-user backend memory<br>
operations.<br>
- Split DMA map/unmap into per-region logic.<br>
- Decouple and rework memory region free routines.<br>
- Iterate over VHOST_MEMORY_MAX_NREGIONS uniformly<br>
across related functions to simplify code reuse<br>
<br>
Signed-off-by: Pravin M Bathija &lt;<a href=3D"mailto:pravin.bathija@dell.c=
om" target=3D"_blank">pravin.bathija@dell.com</a>&gt;<br>
Acked-by: Fengchengwen &lt;<a href=3D"mailto:fengchengwen@huawei.com" targe=
t=3D"_blank">fengchengwen@huawei.com</a>&gt;<br>
Reviewed-by: Stephen Hemminger &lt;<a href=3D"mailto:stephen@networkplumber=
.com" target=3D"_blank">stephen@networkplumber.com</a>&gt;<br>
Acked-by: Maxime Coquelin &lt;<a href=3D"mailto:maxime.coquelin@redhat.com"=
 target=3D"_blank">maxime.coquelin@redhat.com</a>&gt;<br></blockquote><div>=
<br></div><div>I did not Ack this one AFAICT.</div><div>=C2=A0</div><blockq=
uote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1p=
x solid rgb(204,204,204);padding-left:1ex">
---<br>
=C2=A0lib/vhost/vhost_user.c | 172 ++++++++++++++++++++++++++--------------=
-<br>
=C2=A01 file changed, 110 insertions(+), 62 deletions(-)<br>
<br><br></blockquote><div><br></div><div>The change looks good though:</div=
><div>Reviewed-by: Maxime Coquelin &lt;<a href=3D"mailto:maxime.coquelin@re=
dhat.com">maxime.coquelin@redhat.com</a>&gt;</div><div>=C2=A0</div></div></=
div>

--000000000000a06a2f06536ab9b8--

