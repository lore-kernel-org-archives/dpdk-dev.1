Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF7E8CA5FC7
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Sep 2026 15:38:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D62A440E50;
	Wed, 30 Sep 2026 17:38:32 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 15D40402D9
 for <dev@dpdk.org>; Wed, 30 Sep 2026 17:38:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790782711;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xVwJoHYojN35A8ybZ9//JM0/HnmcMNGEYBxseaomWYA=;
 b=IjlI9T+oH4PK+1ZDZdPNrqIXrm919TCSSQKO6linVz3Eh7VV7Z+7YkYlUVSAq/FfFUsE4d
 o2iP7+ceHk/rarigk4PwWgSWBU4q+A1Xw21NfpoEfoPCslngDlQGh2eBi51A52k7J8Snei
 1AGXtqSrQolIrABvBHa24JBQPGpYX1I=
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-26-tKxoyllNPtu82j1SxzdwDQ-1; Wed, 30 Sep 2026 11:38:30 -0400
X-MC-Unique: tKxoyllNPtu82j1SxzdwDQ-1
X-Mimecast-MFC-AGG-ID: tKxoyllNPtu82j1SxzdwDQ_1790782709
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-33713e5e6daso7972900eec.0
 for <dev@dpdk.org>; Wed, 30 Sep 2026 08:38:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790782709; x=1791387509;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=xVwJoHYojN35A8ybZ9//JM0/HnmcMNGEYBxseaomWYA=;
 b=z590FfHYa0+7z9ru4Y7pOBDDiI5Bg6SStRJ6HcqDZuh9lELvl1mnVjAbp/EG82pPug
 kWULitjP94P+/+Jw4mOCdWixMKvmuX4llg6Ivruty20hFJDCO41kziFALvJ6nsixChZd
 MG7nPzlDhDNtOtXfqikJ3yrETp6E1RSqVO+PD7G9nlGbnWSr2Cu5U0Gn/vC/KBsYasdh
 txJaoIlzcW5P9sNHaqhSw4Jkdhf2ICgjFTl69hZPIPkXgt8RDE6kmxLQAg9YHwh6aIg6
 5S3YBRPTMT1q+TSThz67U2Q4jJzC5QmqNhDOJvS17pEA1tB9mlL2iv1A+oAvZLyhAcAG
 E5pg==
X-Gm-Message-State: AFuF++kaTd8MtONvKLaX0j0jNYyp0oIQdLZINXqGTCGrQ3cin1pb0hKY
 fSZpSPy+UIjr+VA06m6c8P7EUkv9mHYHtdX1QktkkEDavZSsS0Q1K97KAxtw31pBzolV1WgqtnE
 jexcmXoWmXnKxNR3hT2GAdIvurWPtbgG2zZKznlG5wLXYMS1nLOsvlNlKh+fKfSvdA8mV2EQbY7
 ZJyxzR5T5CZQdRuK9wnVQ=
X-Gm-Gg: AYBFou3Bn8Kx7kfpZLEp6jmykKlrAPbXOYLgox3skBRR1kZXAcA3f8AX6riq+Ctl6vf
 5w+uZVZJwiKiUf3t9++lzDCM2EXfPanvXlh2GMPVj1lbUWzSLWlRk8onKMQVMaTnTjrV12mGGLf
 QsLu3Dt9NqOKo0CPWyay8klNl6LtI2pW/aSz/HPWzgE+HjIaiwPRg60wBg/aW0tQ1of7wWlGAdb
 qDrq/uDQTYjsCSRLmWK48AN5B1MMPAfQaTTj40BaVI115hehb32BA2s5k2MeOmHGpM8OA1I8Zzg
 r9e0RBdM68ODdDHFvqbNGg7G7NF5HOAChyweUKCvooI=
X-Received: by 2002:a05:7022:61b:b0:13d:974:a2c6 with SMTP id
 a92af1059eb24-14d3204e745mr2523381c88.7.1790782708523; 
 Wed, 30 Sep 2026 08:38:28 -0700 (PDT)
X-Received: by 2002:a05:7022:61b:b0:13d:974:a2c6 with SMTP id
 a92af1059eb24-14d3204e745mr2523335c88.7.1790782707937; Wed, 30 Sep 2026
 08:38:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260930095800.551314-1-maxime.coquelin@redhat.com>
 <20260930095800.551314-3-maxime.coquelin@redhat.com>
 <20260930082724.06b79bb6@phoenix.local>
In-Reply-To: <20260930082724.06b79bb6@phoenix.local>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Date: Wed, 30 Sep 2026 17:38:15 +0200
X-Gm-Features: AclHuK_9uQTOGH3dPihh5Uc_g4pjSXZhuxLBVZaoWhWw-m409gfYUx5OwhvRfbw
Message-ID: <CAO55csygHRtugFxNyDHc_EEyfZJooGjyGEDwVHKxjwGY2CxxSA@mail.gmail.com>
Subject: Re: [PATCH 2/2] uapi: update headers to v6.19
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, eperezma@redhat.com, david.marchand@redhat.com, 
 thomas@monjalon.net
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 6euw5Xk7D0zDaUT9lFOl84uUWlUJO5l3haffjqNucsw_1790782709
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="0000000000002d4985065cb5174b"
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

--0000000000002d4985065cb5174b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2026 at 5:27=E2=80=AFPM Stephen Hemminger <
stephen@networkplumber.org> wrote:

> On Wed, 30 Sep 2026 11:58:00 +0200
> Maxime Coquelin <maxime.coquelin@redhat.com> wrote:
>
> > diff --git a/kernel/linux/uapi/linux/vfio.h
> b/kernel/linux/uapi/linux/vfio.h
> > index 79bf8c0cc5..720edfee7a 100644
> > --- a/kernel/linux/uapi/linux/vfio.h
> > +++ b/kernel/linux/uapi/linux/vfio.h
> > @@ -14,6 +14,7 @@
> >
> >  #include <linux/types.h>
> >  #include <linux/ioctl.h>
> > +#include <linux/stddef.h>
> >
>
> Just add sanitized stddef.h into kernel/linux/uapi/linux
>
>
See my reply on patch 1 where I explain why it does not work.

--0000000000002d4985065cb5174b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Sep 30,=
 2026 at 5:27=E2=80=AFPM Stephen Hemminger &lt;<a href=3D"mailto:stephen@ne=
tworkplumber.org">stephen@networkplumber.org</a>&gt; wrote:<br></div><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1=
px solid rgb(204,204,204);padding-left:1ex">On Wed, 30 Sep 2026 11:58:00 +0=
200<br>
Maxime Coquelin &lt;<a href=3D"mailto:maxime.coquelin@redhat.com" target=3D=
"_blank">maxime.coquelin@redhat.com</a>&gt; wrote:<br>
<br>
&gt; diff --git a/kernel/linux/uapi/linux/vfio.h b/kernel/linux/uapi/linux/=
vfio.h<br>
&gt; index 79bf8c0cc5..720edfee7a 100644<br>
&gt; --- a/kernel/linux/uapi/linux/vfio.h<br>
&gt; +++ b/kernel/linux/uapi/linux/vfio.h<br>
&gt; @@ -14,6 +14,7 @@<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 #include &lt;linux/types.h&gt;<br>
&gt;=C2=A0 #include &lt;linux/ioctl.h&gt;<br>
&gt; +#include &lt;linux/stddef.h&gt;<br>
&gt;=C2=A0 <br>
<br>
Just add sanitized stddef.h into kernel/linux/uapi/linux<br>
<br></blockquote><div><br></div><div>See my reply on patch 1 where I explai=
n why it does not work.=C2=A0</div></div></div>

--0000000000002d4985065cb5174b--

