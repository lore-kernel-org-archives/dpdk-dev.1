Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 277E4C9830E
	for <dpdk-dev@archiver.kernel.org>; Thu, 24 Sep 2026 15:51:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 57B954027B;
	Thu, 24 Sep 2026 17:51:13 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 58B4840144
 for <dev@dpdk.org>; Thu, 24 Sep 2026 17:51:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790265071;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BNkWVmnMCD0YX9fmSKFE4qlHNOsHfQJWbzqfmJ2Prfo=;
 b=dEcn+PEE5kWhe0LApAZ85N0hQX6JMvVBhznu9JpkW7V/BunUm1fWrSPMrBfpNZAHqHolCP
 15Aw191F6yjfk0AqqCoqxjKDVjRlfLRqoxHgf/gaFnfFQ4RI25MOlSH0eal5QW9YNIOGsT
 SOLzYcc1/mRrpksmC6uzjuFWFzt9V/Q=
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-ISHNQvChN1mb9Nvt25Fo6g-1; Thu, 24 Sep 2026 11:51:10 -0400
X-MC-Unique: ISHNQvChN1mb9Nvt25Fo6g-1
X-Mimecast-MFC-AGG-ID: ISHNQvChN1mb9Nvt25Fo6g_1790265069
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-32b8c2b30c4so3633566eec.1
 for <dev@dpdk.org>; Thu, 24 Sep 2026 08:51:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790265069; x=1790869869;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=BNkWVmnMCD0YX9fmSKFE4qlHNOsHfQJWbzqfmJ2Prfo=;
 b=Xu6ydIcUMKDyQZwn4un0O5qbxiwm4IbzJCIr5Q7+QEVIKk9FWXgyglyiRNKKebtY/Y
 VfUuZODZeKtgXYTpgL3oPkJGHYjAcbJXAD43pKBkhaofedrfP/IViHmVh4WNEEEpLZZt
 12sR0yjCf72qGz336YOGlSYW17ytmoz7RaU2a+MsqbMjivNv2iOECRwVByB7r9XVbcfL
 JWI9wYf8/zDfIv5iRdKC76zDI/wSUJd5rkeA9LFELneIJiE+0kw3/q5MJcSXYw2y9aX1
 iG0m0f3Wx8a+G3n/3nuelgny8qmlHxE4si3VGOWJ0MP40wa6p70AtagexkEGcExz+8Al
 247g==
X-Forwarded-Encrypted: i=1;
 AKwUvByg2dmnm72CW2LqXSgNuqzYEbwQenUEkSK+2NrOrrKwg9mIV+0m6GfKXKDVXvWLhXxiMf4=@dpdk.org
X-Gm-Message-State: AFuF++kEpZTetqm4Kjd8y2+djgnict2DAJbq3Wa1J1R/SVvToIibiQK2
 JwF3qtodg0KufhtDqTSmdX/dl+81rzASJolrXpaeTlyiDUM3lj7EE5DR/L8zE85cTRwIlRMtOlU
 Wr/Gic6BIOcpSoi9DuU1Az56OLkLIOKuSCLvWHbgDJf9suDmRGKlXCtvu2uTi7Hm5+9pSmWmbhE
 a9CLxyumMLpTq5FFU2B7Q=
X-Gm-Gg: AYBFou2d3k65BnWj2pz9PD27yQ8S49LpJDhJZuLEZs6hJTL4PBDypP3t4ZWWeAf7LlC
 6grWZ4RSFrtNnvODG9LGOXQDEb81Mo4fQKZjbzm0VTk93QDNC6Hiy3ckmzM5r/+UUmiQniQS4d4
 ZBPBLYw7e7tFtZx5owcehUdFqTKOqO41MGeZOs9S3Gnu5pSUwn43t+NBbx2cbvEeSw6jpY68XTy
 2STFCUfFFKRoKheKIqDbG0/LCfhY2pOEHsRgRxj8XvUB8VEN2C8bhWYVMrjFMSvYWbbxAJc2SEU
 /v1mMXtQxJ9vTJCWTmd+xUDfPB4ohm0c8Na823g+cN0=
X-Received: by 2002:a05:7022:3c0c:b0:143:73bc:bed3 with SMTP id
 a92af1059eb24-14504011dcemr1939949c88.42.1790265068838; 
 Thu, 24 Sep 2026 08:51:08 -0700 (PDT)
X-Received: by 2002:a05:7022:3c0c:b0:143:73bc:bed3 with SMTP id
 a92af1059eb24-14504011dcemr1939919c88.42.1790265068211; Thu, 24 Sep 2026
 08:51:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260924101504.810315-1-eperezma@redhat.com>
 <20260924101504.810315-2-eperezma@redhat.com>
 <20260924083845.4d854df3@phoenix.local>
In-Reply-To: <20260924083845.4d854df3@phoenix.local>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Date: Thu, 24 Sep 2026 17:50:56 +0200
X-Gm-Features: AclHuK-xLExJyPSxyaDS18HKvtEo_I50rKo7XXOxqgiPeFzsB12u2xq6SGFZlhM
Message-ID: <CAO55csxMp51tJqjMLdbQUAXcTT_V7_iadUU0AB+aXwiDc30X0Q@mail.gmail.com>
Subject: Re: [PATCH 1/9] uapi: import VDUSE and VFIO header from v7.3-rc3
 kernel
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, dev@dpdk.org, 
 chenbox@nvidia.com, Yongji Xie <xieyongji@bytedance.com>, mst@redhat.com, 
 jasowangio@gmail.com, david.marchand@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _Vyq-29svvqmUQyj0hAeDbT0cO20xLWgXYzWZr0BU0U_1790265069
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="00000000000071e827065c3c91de"
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

--00000000000071e827065c3c91de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 24, 2026 at 5:38=E2=80=AFPM Stephen Hemminger <
stephen@networkplumber.org> wrote:

> On Thu, 24 Sep 2026 12:14:56 +0200
> Eugenio P=C3=A9rez <eperezma@redhat.com> wrote:
>
> > This header will be used by the Vhost library.
> >
> > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > ---
>
> Best to avoid using headers from pre-release kernel versions.


Yes, that's the plan.
I asked Eugenio to share it early so that we can review and test the
series. It will not be merged with -rc headers.

Thanks,
Maxime

--00000000000071e827065c3c91de
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Sep 24,=
 2026 at 5:38=E2=80=AFPM Stephen Hemminger &lt;<a href=3D"mailto:stephen@ne=
tworkplumber.org">stephen@networkplumber.org</a>&gt; wrote:<br></div><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1=
px solid rgb(204,204,204);padding-left:1ex">On Thu, 24 Sep 2026 12:14:56 +0=
200<br>
Eugenio P=C3=A9rez &lt;<a href=3D"mailto:eperezma@redhat.com" target=3D"_bl=
ank">eperezma@redhat.com</a>&gt; wrote:<br>
<br>
&gt; This header will be used by the Vhost library.<br>
&gt; <br>
&gt; Signed-off-by: Eugenio P=C3=A9rez &lt;<a href=3D"mailto:eperezma@redha=
t.com" target=3D"_blank">eperezma@redhat.com</a>&gt;<br>
&gt; ---<br>
<br>
Best to avoid using headers from pre-release kernel versions.</blockquote><=
div><br></div><div>Yes, that&#39;s the plan.</div><div>I asked Eugenio to s=
hare it early so that we can review and test the series. It will not be mer=
ged with -rc headers.</div><div><br></div><div>Thanks,</div><div>Maxime=C2=
=A0</div></div></div>

--00000000000071e827065c3c91de--

