Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCC73C9832A
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 07:26:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EA09240276;
	Tue, 29 Sep 2026 09:26:54 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 905FE4013F
 for <dev@dpdk.org>; Tue, 29 Sep 2026 09:26:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790666813;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NW+V3OTxkuVzVPmum/CZMYrqP3vlEXgP8/UPWrkWUKI=;
 b=f5cXQFo+V2J5Q2XjtR2aSoX4Tyle5KvFFRLR0wS814RfK1JUbesqtamKnn4KPGYx7L39ll
 Nq3vuRJXZWY+d6tBbLCfTsCGFk+B4a8I34I9xDlmHpjp2auZkgPHCQZKLkKPvSyZeYi5Ik
 E1+8REVshYtDeznNlXaIXz2vPu66K6c=
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com
 [74.125.82.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-228-pATNU7NENOSPjrJMZ_VOmQ-1; Tue, 29 Sep 2026 03:26:51 -0400
X-MC-Unique: pATNU7NENOSPjrJMZ_VOmQ-1
X-Mimecast-MFC-AGG-ID: pATNU7NENOSPjrJMZ_VOmQ_1790666810
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-1431ba79941so3768637c88.1
 for <dev@dpdk.org>; Tue, 29 Sep 2026 00:26:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790666810; x=1791271610;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=NW+V3OTxkuVzVPmum/CZMYrqP3vlEXgP8/UPWrkWUKI=;
 b=0GrVvIfnxoO2Vq5Arq2M1mMNa+ujuOwzhxaufRuldh2rqmoIdwQKp2R+vGgAhVXKSX
 +acC3jzFRGDYp/IALDabdOFZxqgac4LswH1806ZxfkN8roPpYlex0QGMMe7TBjqz1ogN
 wqBmvHzBKP/vFNVacBmOobNOkpDYSdxPzrP6XcNYOILLIe7K+VBZiGJEmLfkn9egKwze
 xR1xRQ/3COlzHbwhiRr4Cn2f9AOilso+14CLC1uC7jsWRtjOCQT5Ero2/YOxJFoZJi9m
 EGnMvbrOP6isyagEMqCtW7oYghI0khXZu1w2CWnD4+1V7ESy0UVPO1Cuz+nBs5MSmme8
 EI3A==
X-Forwarded-Encrypted: i=1;
 AKwUvBw2OzLRI3WhHHpQrDDL3BxoqvuMzrxHg8uufS45sZvsWc6Bw+2x0JXrHfp2xgP8xsYeU7E=@dpdk.org
X-Gm-Message-State: AFuF++lPrlZ613BwUAIsU8T9URfvgY+Qq9FITiGVUAvsm2jCGH7YxbwH
 Ncv/p3aKjmpDhiJzMGbBFqvATZLaRL0a2wxxhCoa5117hrrco+rgnrRiChVeVpuhB3Twmo1zM1u
 L6vhekCnRVeXSbsx4PO3QjA8qdcHPmlm1p92VtkkSNaE4isRGqg0Q4O8uil8SAIFhf8emkqrSlX
 GKaQz4NOGiYTSpsGe6m2g=
X-Gm-Gg: AYBFou0RC6RH8Do081X69N3ev3yWI8vqcvKxaA5XF2x69iegFPUh/howW6m4xfzCJiO
 S4lfCIP6AanBF4hafIIple+cnu63kU0V3BfObu/wtKnyEjaNUlm/1bjhRdnBO9mGPAsSIfCCT3k
 JztV7VreaX4FfeNa7FNnK1D6KZf/ethy0LQYuQqWqhLv+ZibsmadCs/lKysBiopLBF1F4zdePrE
 WJkZUqggEY6Bur5Kffx97EUFfh9zruJGzgvnTctzPwJU+5v/eay9WSQd4mdfBXdNhRJT8CEmVTv
 QqAsufaHjjmjSLpQNO6F5JJkDtPeE59Rc1l0GVK+vXw=
X-Received: by 2002:a05:701b:231c:b0:148:bbae:ad2b with SMTP id
 a92af1059eb24-148bbaec1a9mr9517686c88.11.1790666810075; 
 Tue, 29 Sep 2026 00:26:50 -0700 (PDT)
X-Received: by 2002:a05:701b:231c:b0:148:bbae:ad2b with SMTP id
 a92af1059eb24-148bbaec1a9mr9517642c88.11.1790666809417; Tue, 29 Sep 2026
 00:26:49 -0700 (PDT)
MIME-Version: 1.0
References: <20260928132913.1376278-1-eperezma@redhat.com>
 <20260928132913.1376278-2-eperezma@redhat.com>
 <20260928164205.103049f3@phoenix.local>
In-Reply-To: <20260928164205.103049f3@phoenix.local>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Date: Tue, 29 Sep 2026 09:26:37 +0200
X-Gm-Features: AclHuK9BO1jvrOoNOywxQtuokzmm0XZw5CUGWH-uWtGSgRcuOw1CCKfZKrNppGs
Message-ID: <CAO55csy_q82L+d42AmO_ded6TKWc_L3UK-pGmwKA2MhfbXYbbw@mail.gmail.com>
Subject: Re: [PATCH v2 01/11] build: define __counted_by as empty on
 unsupported compilers
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, dev@dpdk.org, 
 mst@redhat.com, Yongji Xie <xieyongji@bytedance.com>, jasowangio@gmail.com, 
 chenbox@nvidia.com, david.marchand@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: A25_-89ufm0m4U-K1Hkyak7WhwGRoN0Q5MewWijFoGc_1790666810
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="000000000000163cde065c9a1b4d"
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

--000000000000163cde065c9a1b4d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 29, 2026 at 1:42=E2=80=AFAM Stephen Hemminger <
stephen@networkplumber.org> wrote:

> On Mon, 28 Sep 2026 15:29:03 +0200
> Eugenio P=C3=A9rez <eperezma@redhat.com> wrote:
>
> > __counted_by is a GCC 14 / Clang 18 extension used in imported kernel
> > uapi headers. Older compilers reject it with an error. Define it as an
> > empty function-like macro when the compiler does not support it.
> >
> > Co-Authored-By: Claude Sonnet 4.6 <noreply@anthropic.com>
> > ---
>
> NAK
>
> Missing Signed-Of-By and the right way to handle counted_by is to
> introduce and a new macro in rte_common.h (aka __rte_counted_by).
> There are lots of places in DPDK that could use it.
>
> If the problem is in vhost, then get it from stddef.h
>
>
To me the solution is to import stddef.h, I have not tried but it is quite
small and self-contained.

Regards,
Maxime

--000000000000163cde065c9a1b4d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Sep 29,=
 2026 at 1:42=E2=80=AFAM Stephen Hemminger &lt;<a href=3D"mailto:stephen@ne=
tworkplumber.org">stephen@networkplumber.org</a>&gt; wrote:<br></div><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1=
px solid rgb(204,204,204);padding-left:1ex">On Mon, 28 Sep 2026 15:29:03 +0=
200<br>
Eugenio P=C3=A9rez &lt;<a href=3D"mailto:eperezma@redhat.com" target=3D"_bl=
ank">eperezma@redhat.com</a>&gt; wrote:<br>
<br>
&gt; __counted_by is a GCC 14 / Clang 18 extension used in imported kernel<=
br>
&gt; uapi headers. Older compilers reject it with an error. Define it as an=
<br>
&gt; empty function-like macro when the compiler does not support it.<br>
&gt; <br>
&gt; Co-Authored-By: Claude Sonnet 4.6 &lt;<a href=3D"mailto:noreply@anthro=
pic.com" target=3D"_blank">noreply@anthropic.com</a>&gt;<br>
&gt; ---<br>
<br>
NAK<br>
<br>
Missing Signed-Of-By and the right way to handle counted_by is to<br>
introduce and a new macro in rte_common.h (aka __rte_counted_by).<br>
There are lots of places in DPDK that could use it.<br>
<br>
If the problem is in vhost, then get it from stddef.h<br>
<br></blockquote><div><br></div><div>To me the solution is to import stddef=
.h, I have not tried but it is quite small and self-contained.</div><div><b=
r></div><div>Regards,</div><div>Maxime=C2=A0</div></div></div>

--000000000000163cde065c9a1b4d--

