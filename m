Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52CA4FF8850
	for <dpdk-dev@archiver.kernel.org>; Mon, 27 Apr 2026 00:48:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 609A8402E1;
	Mon, 27 Apr 2026 02:48:21 +0200 (CEST)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com
 [209.85.208.177])
 by mails.dpdk.org (Postfix) with ESMTP id 6AB3A4025F
 for <dev@dpdk.org>; Mon, 27 Apr 2026 02:48:19 +0200 (CEST)
Received: by mail-lj1-f177.google.com with SMTP id
 38308e7fff4ca-38e7c3a2deaso61838911fa.2
 for <dev@dpdk.org>; Sun, 26 Apr 2026 17:48:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777250899; cv=none;
 d=google.com; s=arc-20240605;
 b=VNXBbEyALQafj1zxFjTySt9GTGhMqnsJUwsKc3l8sYPMyO7UXS2uKgQxByju3FJcQm
 Q+EqbUJwPn6K4ZZ0DkMw2vA5rWS5b0qIK3SxWNh59yZ5qOHO+pqF4rQtnnoIiBIlkS7u
 1b2OleL/3kG5YbMk5YGWG6wMWKnXt5vIBD/n8QFW4zHWYmSlqIH6f8LZbs2hXroDhsSp
 i7l+IqcZ5t9ZubhaQBslF1Pf2UbOohTW5x2E5qOmhzwa5VfWTVhEsfl42zO7KOy5JTW4
 5ArXpZaiHDOV/xZQFqqFISzeB6sVMlwZIc1jJRi545KuMgmYdePwxISRKGbJ/v6V4ECh
 FFuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=OlhQVljN2NEs/tn28b0niQMiEosS8X/JEPGGLf93NXY=;
 fh=2n7/ufCfx64ZGZ20TchZu1EfyblmGxWnWPmP293fge0=;
 b=BByHeRPLDUuEdmHFc/2Ct9AQmj7gg3g8Beae8i0GTDQ+yxzOlYWXS032RttKSWoGNe
 Iye6uJEzPd8s6c6k8dmb8/AeNsYTQBdZP6WvqETPIeQoSgMekfmZSCMrjhIQcTlveKnN
 WPCGRS34uAp/cUbBt3DxuZHpqbRGpf/Ff9pgU6c29icaTfs6ybL48BTM/8BBYvPPppTR
 bsb/6H3i/Mljtl1EOf8JFzKVOrpWeWQZF7OZdpkYMgZ/B9F7QEsewg8h8nR4t6WLESMz
 b/ufSNn9tahu0uEmYm9+PzaHWcXPLgQK48DDmkQxZxxYkUbKSZikHAbHpUTIo9CRhfBU
 oj3A==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777250899; x=1777855699; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OlhQVljN2NEs/tn28b0niQMiEosS8X/JEPGGLf93NXY=;
 b=sVP2cO/qxK8s4dmjkVojoTH5dweMIzI+NSn8Dznyv8VT/EdCXLK1AExmSZMYf7BJq0
 pInAeDXXBlqJuBNOjUsB8pTvUqB1/bmmQn4MYMUONeDH1oXUdWUOlanqhPMuVGQb3/vH
 tzkytVBKJZIdcsggswKjxKRUS4Z9lKrCVDXqMTlgCMdsDAAWdPoImhGEmAUzeRziFKvi
 YXr9MKIezstWn3Vsl/Q7euNh5ulGQyqIjSz3zlqwxA1phPRDb+Nag4UC5xw7RitdehVZ
 kWmJROxYwIWR+mEnvP5QoiVmFTdoZ8VdZE1oTMsCQZyHFaD8EQzEIg/a24iG4pvcnd6p
 Lf6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777250899; x=1777855699;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OlhQVljN2NEs/tn28b0niQMiEosS8X/JEPGGLf93NXY=;
 b=KPxYfA/QM663JqGp7jxkILUwNyxlwnKbi0xuC9s4hK+cTvCwJLEceOLygs8s1it8KX
 CxZa/2ewexsI9QBIf1kTf24PjD5owcJMoiOCmk+mqaMCfcplZULLeCiSyX7SASifC1xg
 svBuKTwnKOH8k7P/xORFiXeDik+znibfUQuK1YYUPRIj2Qq0hBFgLkndUZJ51Vr2P+e5
 tmdZnW/xCVtp5YywE5rMC2BwJQIK4aeq6tZqfNJidcw0OJgmCV1fMwLNoumuBXB/fwJx
 1emUZN+rvuIv7PzJls12xHHftKB1QuQDzqa1x1yaAPwcn5rX8/9bcUuTRwDDvZ5qef0V
 I6Tg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+FaGvijRxtr0+nKgNIuz6StuM+w3EFVkf1KoH45u4l2VMPu+PfQvsCY5/nuEZgl0xMjDU=@dpdk.org
X-Gm-Message-State: AOJu0YzIjY3FRTimqNUy4QPT1LV/WrotykWRYzD0M4rYBSxQi5uudT8m
 scSoM+SKC+eGUve80T7oj3gr3M9rD8fdBGPIbKCvUWNNlD5zXa4HRa/oGzXyaieBsIofa3p76/e
 9BUkYdeRsxsnW5R6MHj5JXNpZ9v4qHYE=
X-Gm-Gg: AeBDieuKitzfntmUpgB5rf5rs3MLk6bmk7er90F6juqZAgcFlOO150q57oXGNxauBtm
 c0caI2tIm7VKzuEAAfHO+VxZzjDPns4F0ruYAvAfCtcXtV2yUuR/vjc2NwiVoMvKIRrgjvB6/tn
 QMIHF1hsHcqMRZozujYQj8Uc5tweJw+WBiXG/KTj3DAx4dov2Bd6M3SWuFAzkswnolpYulXmroo
 Ri0sgm+ELjGvV4e9tkbZXOIa8POIqmmxgnkAgTtDVA6siqDBpcutxiwCigdGvJRQQ2/pHfFsabt
 6mEB+R4XA/E3ZjKyhAomW5HhWTPPuw7IZmTK/iUoOGRlyzxN
X-Received: by 2002:a05:6512:67c9:b0:5a4:ce9:125 with SMTP id
 2adb3069b0e04-5a4172da999mr9866473e87.23.1777250898410; Sun, 26 Apr 2026
 17:48:18 -0700 (PDT)
MIME-Version: 1.0
References: <20260419194836.27602-1-patrickrobb1997@gmail.com>
 <98CBD80474FA8B44BF855DF32C47DC35F657FE@smartserver.smartshare.dk>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F657FE@smartserver.smartshare.dk>
From: Patrick Robb <patrickrobb1997@gmail.com>
Date: Sun, 26 Apr 2026 20:48:06 -0400
X-Gm-Features: AVHnY4JL8xi90m32PJpJ2ktUmlJFuLmUbOTEkgCkGaiVY5ZeN9sd_BJ3ZAUZKf8
Message-ID: <CAK6DuxvoqzKUyO5MAH6YLbSWhkBsNPbOkeqTSXqxna5T6ezWgA@mail.gmail.com>
Subject: Re: [PATCH] maintainers: update dts maintainer email
To: =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>
Cc: thomas@monjalon.net, dev@dpdk.org, aconole@redhat.com, 
 lylavoie@iol.unh.edu, abailey@iol.unh.edu, dmarx@iol.unh.edu, 
 knimoji@iol.unh.edu, luca.vizzarro@arm.com
Content-Type: multipart/alternative; boundary="00000000000079fffe0650667863"
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

--00000000000079fffe0650667863
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks Morten! Fixed.

On Sun, Apr 19, 2026 at 6:20=E2=80=AFPM Morten Br=C3=B8rup <mb@smartsharesy=
stems.com>
wrote:

> > diff --git a/.mailmap b/.mailmap
> > index 0e0d83e1c6..0ce0cfc1a8 100644
> > --- a/.mailmap
> > +++ b/.mailmap
> > @@ -1232,7 +1232,7 @@ Patrick Fu <patrick.fu@intel.com>
> >  Patrick Kutch <patrick.g.kutch@intel.com>
> >  Patrick Lu <patrick.lu@intel.com>
> >  Patrick MacArthur <patrick@patrickmacarthur.net>
> > -Patrick Robb <probb@iol.unh.edu>
> > +Patrick Robb <patrickrobb1997@gmail.com>
>
> In the mailmap file, both addresses should be present, to tie them
> together:
> -Patrick Robb <probb@iol.unh.edu>
> +Patrick Robb <patrickrobb1997@gmail.com> <probb@iol.unh.edu>
>
> Look at other entries with multiple addresses, e.g.:
> Thomas Monjalon <thomas@monjalon.net> <thomas.monjalon@6wind.com>
>
> With that fixed,
> Acked-by: Morten Br=C3=B8rup <mb@smartsharesystems.com>
>
>

--00000000000079fffe0650667863
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thanks Morten! Fixed.</div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Sun, Apr 19,=
 2026 at 6:20=E2=80=AFPM Morten Br=C3=B8rup &lt;<a href=3D"mailto:mb@smarts=
haresystems.com">mb@smartsharesystems.com</a>&gt; wrote:<br></div><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex">&gt; diff --git a/.mailmap b/.mail=
map<br>
&gt; index 0e0d83e1c6..0ce0cfc1a8 100644<br>
&gt; --- a/.mailmap<br>
&gt; +++ b/.mailmap<br>
&gt; @@ -1232,7 +1232,7 @@ Patrick Fu &lt;<a href=3D"mailto:patrick.fu@inte=
l.com" target=3D"_blank">patrick.fu@intel.com</a>&gt;<br>
&gt;=C2=A0 Patrick Kutch &lt;<a href=3D"mailto:patrick.g.kutch@intel.com" t=
arget=3D"_blank">patrick.g.kutch@intel.com</a>&gt;<br>
&gt;=C2=A0 Patrick Lu &lt;<a href=3D"mailto:patrick.lu@intel.com" target=3D=
"_blank">patrick.lu@intel.com</a>&gt;<br>
&gt;=C2=A0 Patrick MacArthur &lt;<a href=3D"mailto:patrick@patrickmacarthur=
.net" target=3D"_blank">patrick@patrickmacarthur.net</a>&gt;<br>
&gt; -Patrick Robb &lt;<a href=3D"mailto:probb@iol.unh.edu" target=3D"_blan=
k">probb@iol.unh.edu</a>&gt;<br>
&gt; +Patrick Robb &lt;<a href=3D"mailto:patrickrobb1997@gmail.com" target=
=3D"_blank">patrickrobb1997@gmail.com</a>&gt;<br>
<br>
In the mailmap file, both addresses should be present, to tie them together=
:<br>
-Patrick Robb &lt;<a href=3D"mailto:probb@iol.unh.edu" target=3D"_blank">pr=
obb@iol.unh.edu</a>&gt;<br>
+Patrick Robb &lt;<a href=3D"mailto:patrickrobb1997@gmail.com" target=3D"_b=
lank">patrickrobb1997@gmail.com</a>&gt; &lt;<a href=3D"mailto:probb@iol.unh=
.edu" target=3D"_blank">probb@iol.unh.edu</a>&gt;<br>
<br>
Look at other entries with multiple addresses, e.g.:<br>
Thomas Monjalon &lt;<a href=3D"mailto:thomas@monjalon.net" target=3D"_blank=
">thomas@monjalon.net</a>&gt; &lt;<a href=3D"mailto:thomas.monjalon@6wind.c=
om" target=3D"_blank">thomas.monjalon@6wind.com</a>&gt;<br>
<br>
With that fixed,<br>
Acked-by: Morten Br=C3=B8rup &lt;<a href=3D"mailto:mb@smartsharesystems.com=
" target=3D"_blank">mb@smartsharesystems.com</a>&gt;<br>
<br>
</blockquote></div>

--00000000000079fffe0650667863--
