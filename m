Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1FC3CCD1BE
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Oct 2025 16:39:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D094540151;
	Thu, 23 Oct 2025 18:39:51 +0200 (CEST)
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com
 [209.85.219.43]) by mails.dpdk.org (Postfix) with ESMTP id AE1AF40144
 for <dev@dpdk.org>; Thu, 23 Oct 2025 18:39:50 +0200 (CEST)
Received: by mail-qv1-f43.google.com with SMTP id
 6a1803df08f44-87c1f3f4373so15758296d6.2
 for <dev@dpdk.org>; Thu, 23 Oct 2025 09:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=uetpeshawar-edu-pk.20230601.gappssmtp.com; s=20230601; t=1761237590;
 x=1761842390; darn=dpdk.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vnea2mFkWlkW5XvnIihHI/p29uZ2AbXKnHa4aLIIjq4=;
 b=Wy0JkvGVw8OSfh9y5BtanP95I0AtL8FV2muXF4+DniZ/4dLXxy7eusOuky7ANIaD51
 iOMmmeH9DY+qBvLrzKZJoInwWCmJjGFsf6HDKbG2QFzDAM9xAuYuLkvinJBQ8XhBogHp
 g08G5c1DJXFOyjgXmKWX77nZep1vmU6etxitPqQ2rhVAmJQ81lbR2lwcVxa9bZpVoMOQ
 057cJ3J9a+4hmg1NNjiyEwsqyjwSgyobNyaOyoEgoMs+MapZ3uGbVpUt208+evhwwc5y
 cRVrz08ez3okRaJFJY5ck+JU7MuoLtheySSZEkHRa4850mzwnkXW7lvAPrzdRBUw5KGv
 pkog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761237590; x=1761842390;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vnea2mFkWlkW5XvnIihHI/p29uZ2AbXKnHa4aLIIjq4=;
 b=N6mtxZTjVMsQxiZrOGsOZbqSr3Np7wbcbNZ8QHFERZD0oCBnRpcs3aM0xhvyMYqvc4
 PoPiKT3SgTnC1UR02sAFfoEDCAV7f7lHqADRadC3dzL1NZIW5THywk6x3FwQwuOrpt8Z
 Frur1ofXrsTPKSgz91GmYOGkmoaL8GPGtEjkPQFBvk664N43gWMp0bYMQDRVfnEoF3V2
 1y2OIj9c9YZyABYa0ngSBpH/DDubJAWSdcbXmC3qLUdugFyCRuUUyATvIIJRDuAREi3J
 qv2OYfvb0CLMoC4uNP1YQIt3vmg1sWsTLUZ7xIDbRWVA1PIGqoTLHKxrAeHOxWfAhysM
 PpaA==
X-Gm-Message-State: AOJu0YwdaL2WnLSbNpwhK9JewjXFQH53acPRV0tGEYmA736wD0+Myp/+
 RWypiE/lkVxZZL2eQXdj447cO+6rCxVPUt6LY5KoxDzKNjw6QJw+toGYu6QRnF8mdCCyYht2F3O
 06uEMATwL1IXGsue7ZjcziSChpw4NJFd5FY2v4lXrKHxXKxvjEM7R
X-Gm-Gg: ASbGncuSEXLcfyLmfayCe5OPAEAKHYei+M1A3vKbbpHfNwnqnCsVNqkmQ2DN/NBBdFK
 KydoXtIZiMhhs+ughfm9TkShullYlG4ozqVsqMwzKf/NJWkbo/iwH/f8DzkiF+sm8xtBaudNI1w
 bU+Zdu8QAiv4Xy4r/gIglRJyMMQqTAD3FVsZUIRtC8PjN1AkvV8bQUQIG6DUzjsPAsXD1odqklz
 D8+HDgaPBT3XJ9yqAjCpdpYNzcVOmslPP/sxlQn+H7tRrNG6VPK+cS9xpNmSb0qJHuPHSp5CM1A
 st2KTXChrWrY2T+O1dT4QhHRkKV7U5sBbU9w7DKE2T9SjYwbcQ/Gv8HT06TNz6UPaA/uTjz31ed
 B8XWNO0Kb01JtsU1kBQ==
X-Google-Smtp-Source: AGHT+IGc+DM3zDxzFgM3kdl+crB48uWsm0DC1tnWZgxiHyCuMX4I5LWIfFd2UmfyioQ3rPzccsGcDkoK5xUT/w+5ZZc=
X-Received: by 2002:a05:6214:27c4:b0:796:5c30:b079 with SMTP id
 6a1803df08f44-87c2062d615mr288306586d6.43.1761237589920; Thu, 23 Oct 2025
 09:39:49 -0700 (PDT)
MIME-Version: 1.0
References: <250811213632.16023-1-stephen@networkplumber.org>
 <20251023154748.38535-1-stephen@networkplumber.org>
In-Reply-To: <20251023154748.38535-1-stephen@networkplumber.org>
From: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
Date: Thu, 23 Oct 2025 21:39:37 +0500
X-Gm-Features: AWmQ_bkwOEqMYK_Wh-PsZhjy_1BF8HEnIw6PV-PGrMuQNMT7llmbWXbYSUkVJfs
Message-ID: <CA++2-x5AecSjdm0Lt8B_NEbsAHAYd8zPe=N6FGaQ1KVPnCFiKg@mail.gmail.com>
Subject: Re: [PATCH v4 0/8] packet capture bugfix and secondary support
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org
Content-Type: multipart/alternative; boundary="000000000000e9ac4e0641d61427"
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

--000000000000e9ac4e0641d61427
Content-Type: text/plain; charset="UTF-8"

On Thu, Oct 23, 2025, 20:47 Stephen Hemminger <stephen@networkplumber.org>
wrote:

> This patch series addresses the problem of packet capture when
> the secondary process is sending/receiving by using the same
> mechanism as hot plug.  It also fixes some bugs on shutdown
> of dumpcap (and pdump).
>
> The documentation has been updated and improved as well.
>
> v4 - instead of using alloca() instead process in chunks
>      which avoids possible stack overflow
>
> Stephen Hemminger (8):
>   dumpcap: handle primary process exit
>   pdump: handle primary process exit
>   pdump: fix races in callbacks
>   dumpcap: handle pdump requests from primary
>   pdump: handle pdump requests from primary
>   pdump: forward callback enable to secondary

  pdump: remove use of VLA

  doc: update documentation on pdump library


Series-acked-by: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>

--000000000000e9ac4e0641d61427
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Oct 23, 2025, 20:47 Step=
hen Hemminger &lt;<a href=3D"mailto:stephen@networkplumber.org">stephen@net=
workplumber.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">This=
 patch series addresses the problem of packet capture when<br>
the secondary process is sending/receiving by using the same<br>
mechanism as hot plug.=C2=A0 It also fixes some bugs on shutdown<br>
of dumpcap (and pdump).<br>
<br>
The documentation has been updated and improved as well.<br>
<br>
v4 - instead of using alloca() instead process in chunks<br>
=C2=A0 =C2=A0 =C2=A0which avoids possible stack overflow<br>
<br>
Stephen Hemminger (8):<br>
=C2=A0 dumpcap: handle primary process exit<br>
=C2=A0 pdump: handle primary process exit<br>
=C2=A0 pdump: fix races in callbacks<br>
=C2=A0 dumpcap: handle pdump requests from primary<br>
=C2=A0 pdump: handle pdump requests from primary<br>
=C2=A0 pdump: forward callback enable to secondary</blockquote><blockquote =
class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid=
;padding-left:1ex">=C2=A0 pdump: remove use of VLA</blockquote><blockquote =
class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid=
;padding-left:1ex">=C2=A0 doc: update documentation on pdump library</block=
quote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto"></div><div =
dir=3D"auto">Series-acked-by: Khadem Ullah &lt;<a href=3D"mailto:14pwcse122=
4@uetpeshawar.edu.pk">14pwcse1224@uetpeshawar.edu.pk</a>&gt;</div><div dir=
=3D"auto"></div></div>

--000000000000e9ac4e0641d61427--
