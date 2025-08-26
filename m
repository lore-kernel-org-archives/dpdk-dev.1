Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF5B2CA0EFA
	for <dpdk-dev@archiver.kernel.org>; Tue, 26 Aug 2025 12:02:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EF5DE402A3;
	Tue, 26 Aug 2025 14:02:33 +0200 (CEST)
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com
 [209.85.219.41]) by mails.dpdk.org (Postfix) with ESMTP id BD9754021E
 for <dev@dpdk.org>; Tue, 26 Aug 2025 14:02:32 +0200 (CEST)
Received: by mail-qv1-f41.google.com with SMTP id
 6a1803df08f44-70d9eb2e976so34286256d6.0
 for <dev@dpdk.org>; Tue, 26 Aug 2025 05:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=uetpeshawar-edu-pk.20230601.gappssmtp.com; s=20230601; t=1756209752;
 x=1756814552; darn=dpdk.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JPlPwVdyJt1Fpa3Z3muUPBz0KFKV79bDKqM54CmGLMY=;
 b=zZ//lDkdLJEqbIxlkVF78SU6T8qUykSDxILH9fDhNzMHcX2BrvwqLwRqg8+HNb1cj7
 3M+q4PPJpPB/u+xE0tWwSqWWRanULZS6uIRAXMf1d02g1tEZY5No4LENPBuKCqeyMliV
 EnGQeG03ezjU0rcnJD7u/j+hxe3tHioYeD4+9LD3m3OSGF73JjFBizfT3jjpkpMdt6Qh
 Ei5MoGa5TLgC/c8TVS5AqJArPPgyY9YVvMkPfD/vus06xNpEUrEslUCs4xKYTS0E8eRd
 AtgxpDRUHuD6Ovz7OuiswfNwd2zZuD+HbXUu/3xpCsYqkOqD8tVrVu4zum2KnihgIfJh
 Fypg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756209752; x=1756814552;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JPlPwVdyJt1Fpa3Z3muUPBz0KFKV79bDKqM54CmGLMY=;
 b=EssSgDTqPWk5IBm5hj2wKDU0fwxy1BFSIVgclNeSnF7QFDD21gvq58Fvz6jl9zgFam
 iy3nQxDwAxRVZpBL4r8kd0Aga3zYP+iyMAfEKpQeh9ZOmFJTw4q42SOov6OOXVv0WDOy
 yho/V1Vpb7ndHIs+8dhIYvJs1kGVlM6rP5sL/SpIYL2o+8o+hexqlK4zw5hQQMczzJbg
 SX5suzqFZszyLsjddGtVKoOZXunV2nZF8tZoHuL3xbHvZmW/5a5ydwawfsP+yRfb1+rO
 nZtR0sUYgX+BWS6s7q49j0ZKbk6tpmoMBL//XSXnb+kpwdS9iUHvO4t6iZd/3z17hq3D
 3dLg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVpQZxetNFN/q3qh2apjvMXWST5sw9VW/7Q0/c5DZEDbNoPwyRx0UHgSY5rhgUXHmVqokI=@dpdk.org
X-Gm-Message-State: AOJu0Yx0PeSxejxnWQLk+PVKhwr1AzE+b9utqi4ErFI7qn/DP9nErnxJ
 VNZU742pz7dGtMJzT8398G4e/anpvRK0H09+tc5QFPikil0mxXNzj1ni834S7Y0JFBJUqAZFASc
 5rPJ2RKjHAeuyQMgWWJS1QQqtiFcswOb5R5nhFBreKA==
X-Gm-Gg: ASbGncs1BtbYm0CBq075y1wE41ibttC4d3MWDqrgLzOkj7aCExOdYHDahp0B7B6yzKA
 gH8DtsgjFM0q2ar0skLJKpHMYcV2XVd4yz2sxaLMklrqzZ5I2XBR9WWjbKOO0JvHo7sP+1yXtqm
 vPaU9N/aCRNzqC5U55YTXGQYS9RAB+PSRe2D4CBRt4mX2DSK2LRgTPAJk2kfqv2chnBM/ubJ1m3
 uW6QoJ9h9KjReE6Mm4sgEPBVRj0JdsurQMOpfXRqd9ZOJBB5AcZ/mEOnsqcbBL8nTIeIYPBdBSA
 8MSyx1eqCw==
X-Google-Smtp-Source: AGHT+IFp1IYhkxkm3E4JXS1H4Qll8yxEqYoZKVIt20qq5mBpQuAKXrtONOG+bTm4ntHGQu2uT6SG6BercDl65FJm8Z4=
X-Received: by 2002:ad4:5cc9:0:b0:707:71d9:d6da with SMTP id
 6a1803df08f44-70d9722a7abmr184684006d6.10.1756209739161; Tue, 26 Aug 2025
 05:02:19 -0700 (PDT)
MIME-Version: 1.0
References: <20250825123548.1177090-1-ciara.loftus@intel.com>
 <20250825123548.1177090-4-ciara.loftus@intel.com>
 <CA++2-x4mGrxvu7vxRgvQLbtGkS3bMBnLt+1NLpqa9P-GQobsAA@mail.gmail.com>
 <aK1oNgPbHGeJdgUp@bricha3-mobl1.ger.corp.intel.com>
 <CA++2-x5j0hH3XweLL+=O7-GJOnGSuN8zoFURs13mgFiVh1MD3Q@mail.gmail.com>
 <aK2Rajd8rypPr7lT@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <aK2Rajd8rypPr7lT@bricha3-mobl1.ger.corp.intel.com>
From: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
Date: Tue, 26 Aug 2025 17:02:07 +0500
X-Gm-Features: Ac12FXyZyc-LFqTCkmhABhGq3NU7BgexgmmvpNdsogzUVp23qhCgH8wHUq493oU
Message-ID: <CA++2-x5wuAT_DrXw+sBa5OQ6JrXTXaBMXwSA0Wnda==GX-9JVw@mail.gmail.com>
Subject: Re: [PATCH 3/4] net/ice: remove SSE vector path
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: Ciara Loftus <ciara.loftus@intel.com>, dev@dpdk.org
Content-Type: multipart/alternative; boundary="000000000000a7e844063d437176"
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

--000000000000a7e844063d437176
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2025 at 3:50=E2=80=AFPM Bruce Richardson <bruce.richardson@=
intel.com>
wrote:

> On Tue, Aug 26, 2025 at 02:29:28PM +0500, Khadem Ullah wrote:
> >    Hi Bruce,
> >    Thanks for the feedback!
>
> No problem.
> BTW: Please don't top-post in replying - it's best practice to put
> the reply below the text you are replying to. Thanks.
>
> Ohh, I got it :)
I was trimming the quotes when replying but in top-post format,
I will always try to avoid a top-post reply in future!


> AVX2 was first available in systems starting in 2013, (and AMD systems
> since 2015), so at this point it's been around a long time. The SSE code
> paths in the drivers will only be used by systems which do not have AVX2 =
on
> them - which should be relatively rare, I hope, at this point. There are =
no
> features in the SSE driver that are not available in the AVX2 one, so, I'=
m
> not aware of any reason why one would need to use the SSE code path in a
> deployment of DPDK


Yes, I think all features in SSE do already exist in AVX2 paths.

>
> Even without this patch, there will be no features added to the SSE code
> paths in the drivers. Any new additions would just be to the AVX2 and
> AVX-512 code paths. Even for systems without AVX2, if the SSE path is
> removed the driver will fall-back to the scalar paths, which have far mor=
e
> features available in them than the SSE codepaths, which were simplified
> for
> performance reasons.
>
> /Bruce
>
Thanks for the update. I could not exactly get the meaning of fall-back to
the scalar path.
Does that mean that the driver automatically switches to the scalar path ?
which is slower but includes all the necessary features that were
simplified in the AVX2 path.
I believe AVX2 provides an average performance much better for small frame
or packet size (about 14 Gbps).

Please forget the previous email, some mess up with practicing not doing
top-posts.
Hope this will be fine :)
Regards,
Khadem

--000000000000a7e844063d437176
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><div><br></div><div class=3D"gm=
ail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On T=
ue, Aug 26, 2025 at 3:50=E2=80=AFPM Bruce Richardson &lt;<a href=3D"mailto:=
bruce.richardson@intel.com">bruce.richardson@intel.com</a>&gt; wrote:<br></=
div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bor=
der-left:1px solid rgb(204,204,204);padding-left:1ex">On Tue, Aug 26, 2025 =
at 02:29:28PM +0500, Khadem Ullah wrote:<br>
&gt;=C2=A0 =C2=A0 Hi Bruce,<br>
&gt;=C2=A0 =C2=A0 Thanks for the feedback!<br>
<br>
No problem. <br>
BTW: Please don&#39;t top-post in replying - it&#39;s best practice to put<=
br>
the reply below the text you are replying to. Thanks.<br><br></blockquote><=
div><div><div>Ohh, I got it :)=C2=A0=C2=A0<br></div>I was trimming the quot=
es when replying but in top-post format,=C2=A0<br></div>I will always try t=
o avoid a top-post reply in future!=C2=A0<br>=C2=A0</div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">AVX2 was first available in systems starti=
ng in 2013, (and AMD systems<br>
since 2015), so at this point it&#39;s been around a long time. The SSE cod=
e<br>
paths in the drivers will only be used by systems which do not have AVX2 on=
<br>
them - which should be relatively rare, I hope, at this point. There are no=
<br>
features in the SSE driver that are not available in the AVX2 one, so, I&#3=
9;m<br>
not aware of any reason why one would need to use the SSE code path in a<br=
>
deployment of DPDK</blockquote><div>=C2=A0<div>Yes, I think all features in=
 SSE do already exist in AVX2 paths.=C2=A0 =C2=A0</div></div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">
<br>
Even without this patch, there will be no features added to the SSE code<br=
>
paths in the drivers. Any new additions would just be to the AVX2 and<br>
AVX-512 code paths. Even for systems without AVX2, if the SSE path is<br>
removed the driver will fall-back to the scalar paths, which have far more<=
br>
features available in them than the SSE codepaths, which were simplified fo=
r<br>
performance reasons.<br>
<br>
/Bruce<br></blockquote></div><div><div>Thanks for the update. I could not e=
xactly get the meaning of fall-back to the scalar path.=C2=A0<br>Does that =
mean=C2=A0<span><span dir=3D"ltr">that the driver automatically switches to=
 the scalar path ?<br>which is slower but includes all the necessary featur=
es that were simplified in the AVX2 path.=C2=A0</span></span>=C2=A0<br>I be=
lieve AVX2 provides an average performance much better for small frame or p=
acket size (about 14 Gbps).=C2=A0<br><br></div><div>Please forget the previ=
ous email, some mess up with practicing not doing top-posts.=C2=A0<br>Hope =
this will be fine :)<br>Regards,<br></div><div>Khadem=C2=A0</div><br clear=
=3D"all"></div><br><span class=3D"gmail_signature_prefix">=C2=A0</span><br>=
</div>

--000000000000a7e844063d437176--
