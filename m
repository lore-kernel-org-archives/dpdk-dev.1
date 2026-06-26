Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66A99C43458
	for <dpdk-dev@archiver.kernel.org>; Sun, 28 Jun 2026 13:28:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E7381402D1;
	Sun, 28 Jun 2026 15:28:10 +0200 (CEST)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com
 [209.85.208.50]) by mails.dpdk.org (Postfix) with ESMTP id 7988F400D6
 for <dev@dpdk.org>; Fri, 26 Jun 2026 09:42:02 +0200 (CEST)
Received: by mail-ed1-f50.google.com with SMTP id
 4fb4d7f45d1cf-697763eeafcso981411a12.3
 for <dev@dpdk.org>; Fri, 26 Jun 2026 00:42:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782459722; cv=none;
 d=google.com; s=arc-20260327;
 b=m0cT8/K9nPI/tU0lK1FzLsUSVp05AXTaeQm74MOeUFYdwvsLt2iEcX7PdkmIQfXTXI
 64VVd5K3vuoQIOry9tW7Y9u7knWiLnl4RxCgFP7Zg56kNWTrsjP10LGjEijodohw3MqG
 ncZPVA13NEOVE6ixnWEeY2YfVZb9Z+SHTbes4PwMNU2ZJj7No6N3PyUsjkT+eFhv5Fcd
 F1HEsdfUqojh+TBespLtkEEwozmPISMWd66jjFrHPstbyb0TM5YmbzL+7VI3iKvWejPI
 R9eforRWNzp8fiHqhKQO0dcDaJf/aS9GarMwPT5kI00aUcoYtPmD+U5bn+IpdROmwst2
 0X6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=A84nhbC84AdbM4f41hBASEpF/dtUTOcKAr8i2rN0z68=;
 fh=t3gKGAfgfMRkCz3NtbEh4bcscSwMadsdVqBRRb31XAU=;
 b=DSg7fQoA4qd6qwWtPg5ZKAljpYuF0P8HdKJXnyUhnL1N+7OHrAIl2gHJYu/S/b38ah
 lN5vUtktsDaEo/el6gcY2RvCKHEBNid1KWJ67RipRiEOaxBpyR32iAO/Jx+M14qjyRtP
 VKbg1H49ZY0pmeX2ODXXyMpSWsGcCjKX7vC4TX6+5zxWNymktbsa+xYj1tO16PN5jbSN
 QbAmMG7ARVFWS27k2RWBVVPQHdakBOj6tJ7KEgs8mC2b7RU0vdsqBHLsEwnyvEIqZmMS
 lWP3xW2DRz3fSYdRpwJapWnTjclVwPOc3xqXI3u0gCsbPvLw2wrIsFmAjMGLkZyLhj3w
 QbJw==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782459722; x=1783064522; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=A84nhbC84AdbM4f41hBASEpF/dtUTOcKAr8i2rN0z68=;
 b=FjbS+LQEZmy3DzogBbfXr954lJLeLSur5HpcFdmlK+I2DEtPNekeFP8MUou98XWKKB
 4uT3gNJa5J3TcSOQD9ke6t54EP0n6BjQzwBe1vdRLmf+iBSSjG2q4v1p6HutpSyrh2Te
 n8X5oAcC7Ww5ZtpLj/pkrBysmGeLgjmlofUl3TSMqiJvhR1SnO+h3TkgiVnfkRTLgh4x
 YtmWRVcHkcasKgKsq7oQ00+mxewdVem90Xvo9IVdxVvo2U2YReM8Qpi8TMsmPhZ+Fe4f
 MTx4nfvFRcEpftanHeevEnTSogvXd8KOzPafhrdyNa7wUzSo3x72rftc7CxQ6OMLqeY4
 fJJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782459722; x=1783064522;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A84nhbC84AdbM4f41hBASEpF/dtUTOcKAr8i2rN0z68=;
 b=U9lNGkjnx0hVhZ9jYeIBpNgisKq2LUAl2MREwFRgv1F0X+pobU3nBs9yC5oimNjLKt
 9TPe9ERtLd0y3Q2phJGMrJ9qsbh0BKmxY9YuirRHhuDAou0+1efZPWDaG5rGCazTPjZr
 KKLHOlN92Kr32jSRepp8wj1GvaUpiHqaxtfIJsj61W60+z+syW2sdK6RIuAMUXMQ6tv/
 xr00ntT75J7GkL3/RLmK4TMe3sUQU6t2nVZprVDfdNF1VvD4fyQYz3soUJO+WGZGv9Jz
 2Fr6SXkZ1EnOwPXh1zKFU6dPCbawK91UnrUGUWXfrLonOxja2Gf91oaulK5G1HqdD/Ul
 apig==
X-Gm-Message-State: AOJu0YwyXn5Gw/b4B5TBQrB8BYwfhD6gWloaZopcuGNT9JGlwCfv/L/R
 2Es9t/S3Ag6rPum+AXHg5JmrZ7j4xBhbt70ry8t+cxRp+knJ9sARG4Yc4zEp1uqYld9ulOWdRBz
 5y4XOcfa7CogQTBEPOSvKWgLVLH0yYuo+NM5nLPuYPML6
X-Gm-Gg: AfdE7cmEDHol4rloyb4tjj+R+j+79HSRcvyTv7YmGU7/2cTNNISyX9hptE7wOxyTdEA
 U/GCgfVeEP9/WbcolhBxz/2uUPtTWz17qIG+2VWxat/YsOm84Jv94fZYseW6shBcJNONlFfJFGX
 kbxVBrBfSKH5ELxhUASeX/TqvkmL9xZDq7hxa75cXOKRM+jZD5PSLPL+usMI91NztIjJb2ugL2f
 zxddW0ideajnRgfCb0ZXCW0YeC4TR/MfiecF8267kc4QnII+CFANupdQIPtTNghngEHmVoJ
X-Received: by 2002:a05:6402:5113:b0:697:b86d:809c with SMTP id
 4fb4d7f45d1cf-6981087601fmr1480985a12.0.1782459721923; Fri, 26 Jun 2026
 00:42:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260624085741.2195573-1-samaryadav5@gmail.com>
 <20260624081036.6c6c82e8@phoenix.local>
In-Reply-To: <20260624081036.6c6c82e8@phoenix.local>
From: Samar Yadav <samaryadav5@gmail.com>
Date: Fri, 26 Jun 2026 13:11:49 +0530
X-Gm-Features: AVVi8CdyQpER9c-x0R4GWJ-YSkDvM4h2OBh1KLZU88mud0s6wf9yhTwJHTba0eA
Message-ID: <CAJR3iYA+VGyOXPTZ5bfW3jzxGutzqtiEcva+foAuVrZgtOVpeQ@mail.gmail.com>
Subject: Re: [PATCH] net/virtio-user: fix eventfd sharing in secondary process
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, maxime.coquelin@redhat.com, chenbox@nvidia.com, 
 tiwei.bie@intel.com, stable@dpdk.org
Content-Type: multipart/alternative; boundary="0000000000008d42840655233eaa"
X-Mailman-Approved-At: Sun, 28 Jun 2026 15:28:09 +0200
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

--0000000000008d42840655233eaa
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Agreed Stephen, will switch to rte_calloc in patch v2:

- pp->kickfds =3D rte_malloc("virtio_user_proc_priv",
- total_queues * sizeof(int), 0);
- pp->callfds =3D rte_malloc("virtio_user_proc_priv",
- total_queues * sizeof(int), 0);
+ pp->kickfds =3D rte_calloc("virtio_user_proc_priv",
+ total_queues, sizeof(int), 0);
+ pp->callfds =3D rte_calloc("virtio_user_proc_priv",
+ total_queues, sizeof(int), 0);


On Wed, Jun 24, 2026 at 8:47=E2=80=AFPM Stephen Hemminger <
stephen@networkplumber.org> wrote:

> On Wed, 24 Jun 2026 08:57:41 +0000
> Samar Yadav <samaryadav5@gmail.com> wrote:
>
> > +     pp =3D rte_zmalloc("virtio_user_proc_priv", sizeof(*pp), 0);
> > +     if (pp =3D=3D NULL)
> > +             return -ENOMEM;
> > +
> > +     pp->kickfds =3D rte_malloc("virtio_user_proc_priv",
> > +                              total_queues * sizeof(int), 0);
> > +     pp->callfds =3D rte_malloc("virtio_user_proc_priv",
> > +                              total_queues * sizeof(int), 0);
>
> Better to use rte_calloc.
>

--0000000000008d42840655233eaa
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Agreed Stephen, will switch to rte_calloc in patch v2:<br>=
<br>-	pp-&gt;kickfds =3D rte_malloc(&quot;virtio_user_proc_priv&quot;,<br>-=
				 total_queues * sizeof(int), 0);<br>-	pp-&gt;callfds =3D rte_malloc(&qu=
ot;virtio_user_proc_priv&quot;,<br>-				 total_queues * sizeof(int), 0);<br=
>+	pp-&gt;kickfds =3D rte_calloc(&quot;virtio_user_proc_priv&quot;,<br>+			=
	 total_queues, sizeof(int), 0);<br>+	pp-&gt;callfds =3D rte_calloc(&quot;v=
irtio_user_proc_priv&quot;,<br>+				 total_queues, sizeof(int), 0);<br><br>=
</div><br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr"=
 class=3D"gmail_attr">On Wed, Jun 24, 2026 at 8:47=E2=80=AFPM Stephen Hemmi=
nger &lt;<a href=3D"mailto:stephen@networkplumber.org">stephen@networkplumb=
er.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">On Wed, 24 Jun 2026 08:57:41 +0000<br>
Samar Yadav &lt;<a href=3D"mailto:samaryadav5@gmail.com" target=3D"_blank">=
samaryadav5@gmail.com</a>&gt; wrote:<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0pp =3D rte_zmalloc(&quot;virtio_user_proc_priv&qu=
ot;, sizeof(*pp), 0);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (pp =3D=3D NULL)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENOMEM;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0pp-&gt;kickfds =3D rte_malloc(&quot;virtio_user_p=
roc_priv&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 total_queues * sizeof(int), 0);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0pp-&gt;callfds =3D rte_malloc(&quot;virtio_user_p=
roc_priv&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 total_queues * sizeof(int), 0);<br>
<br>
Better to use rte_calloc.<br>
</blockquote></div>

--0000000000008d42840655233eaa--
