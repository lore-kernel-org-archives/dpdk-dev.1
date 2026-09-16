Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEDC6C88E5C
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Sep 2026 05:43:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D4AC540265;
	Wed, 16 Sep 2026 07:43:19 +0200 (CEST)
Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com
 [74.125.224.140])
 by mails.dpdk.org (Postfix) with ESMTP id D3ACF4025A
 for <dev@dpdk.org>; Wed, 16 Sep 2026 07:43:17 +0200 (CEST)
Received: by mail-yx2-f12.google.com with SMTP id
 00721157ae682-85d43da99easo5010287b3.1
 for <dev@dpdk.org>; Tue, 15 Sep 2026 22:43:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789537397; cv=none;
 d=google.com; s=arc-20260327;
 b=PqzH3A7rRFXoLzLiQggWOPS+STZWP9vuIR0vp5CXQ4/4ctvBA60x3UrNugSXVYoj9V
 QyFtuLx1aif1XOar9eUTMmxY9R1GWA1Yq7GeHfwJ8/vrsqRH7OCVDgtCTwTYPyKFkGHq
 61+4MUB/0XtWgHx8ISgMphYkhd7DZ8G2v+u6NruXGE+PpeXO6UulkK0fE8Zn9PI+yaX6
 4hbZgyc2BGocQXqb6kOTIeoE0q4KSVIjf1Bdf+RzHE8wIEjJr9LLU9WyKlYGYlYw3M7x
 +dE2QS2ZZMiMcn9KQicn8SawQLyfThOwM0MxX5g8+JFSANsB7IqxD7t77mlq2GSJqZY1
 o4yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=wwWmMxtDme+xFhqJXcWngckruO0r4DellC182v/XeDI=;
 fh=M4ntZrbfNOI2ObdlEHflOdWkDYk4AAaaM2dw1Zibg8s=;
 b=U5FJUigh8EtFWMY1hgHZXvoAPvvhbPSGARYrOntvLgXONWupPNLXotV/0Er2PsniP0
 eBegBq+RRra66xGgSwoJSnERBmLCFnqF8TPknRyLokvXj7AE8YK+VnF1CKspJCk+4lyP
 2URy6nS6CzbejP2IvXUbXoPQHPybLmB8F7cqm/kO2aevJR/QYh0LZcpuzZVGzRvFKru1
 am4+p5dO3zuHrlPapayUkFWeRpLOc5cSLoS/h7ry1bD11Smt2lvC4OvxtmymEapH2bWF
 24NUyqm4zcOJscScPEBb4y1i8i+2QcJPv9q7l22AzNb70U1N1wIq1rQdsI663LDCfQ9M
 6zIw==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789537397; x=1790142197; darn=dpdk.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=wwWmMxtDme+xFhqJXcWngckruO0r4DellC182v/XeDI=;
 b=fhaXfFg0hg8Fij4jSMOBvVv4noq6FSazr6IdKjWOrkdHIMBDC+iXFBzJ3CXQB4CFmg
 8zwXLpMtHKtnGgEmuPpUYQ5tLY2PD6hDAgaPSOxfDdVlAqaran0Yt9ThLbRghMIzx1s/
 Xi/xXV/oLHpHxns7T+oWMGbtel+vIqf538HetKndIJBA7o4XQ9fCAXSr7O4rTLu9OuCJ
 /PLRmF+sgju+UCrntzWVFKvtmCTZT9AtdIlGIl9+zSJ8sjQUyuzcRkRuKdztDV28DqUp
 T0uGgmGdpP9dRZoNY9toV9QYyN4LPJLtyaigSKmwS3CHvpGuE1flyqlV1oOzsNMfwqtk
 EFDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789537397; x=1790142197;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=wwWmMxtDme+xFhqJXcWngckruO0r4DellC182v/XeDI=;
 b=J9rzUgD0PrqkwSErF6g7KbsPyolt6ToPdEmO9jSfMWgammR5WQYA2nlZDgUrnKpyHZ
 KZnpHRsuE3QRSyOI/nYjW8tDNXekVfoA7BZ5HQzR26jLvwgvjhrZFpMm7gi5/SV3GfAJ
 OnVqpoIlBRTBaiOHMLaoBn1iT9CWsfvg0ED/ozaery3pw5J1u3nut7lF6mZe5nntwirx
 cuEgriZtnVitRA9Xsyx8AUIFIKa0RG2ETbOuUn2RVaTekrmqMbgZaImZ3UXv5WrUQIbw
 rKwT2Kd4ndS6yHZdJ9xrRQwJ5Y1YA++6stBPqBUNSWJTKfzp6h0oPRkhYbDF1p1/+9IQ
 5gRg==
X-Gm-Message-State: AFuF++lPqSTS1JShuq4Io7jC91tE2Z9GuzZerBzP9n8RMkP9klEn0btl
 aDauVBMRHFdyzgb+DHkQFGPnFN/pApbeFTAWq9mafxamR34psk1PmaIYXYEdWaNCC2sAsGKBN+k
 asYu0GQ6BuN1/26F6Ql3ngkl5RXnRROs=
X-Gm-Gg: AYBFou0gWGH+Sj0pdg6rPfMYAKoLYZSSHZ8XzdtfvipW6+8Q0+qZ8eDClcvzFKTxr6l
 MsxsFDLxSn9iGZCUviEcNgUzebZp+nu/RGpxGL4Dd6t5U1qyxyluAyZZcSy/EvQcWSdyj3vy9mA
 uwbfmiZ7uR9FmMIk8aG8BQczo7BEqC1FJQg9+8xv4bg81wBSF0CuniQtzAlP6IppBH0W/z0TJ4s
 ifcb9lwoHgX1h6QsOnD5ZAR0tjP/4CQMWm3hrQ/NFRzDnRslE6sZahyr6+6JQynTKI8qj2bcuqN
 JkDQ8RuUdMm4z9ym5Ld58KMOlOjhrZOy/YBiLohmt1AoqM4bud9Z6lnT
X-Received: by 2002:a05:690c:660a:b0:873:5bd1:98bc with SMTP id
 00721157ae682-89225a37612mr4064807b3.46.1789537397072; Tue, 15 Sep 2026
 22:43:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260913040800.60274-1-amiyaranjan.mohakud@gmail.com>
 <20260913070428.66628-1-amiyaranjan.mohakud@gmail.com>
 <CO1PR18MB4796E0F85799C486CA837DEFBFBA2@CO1PR18MB4796.namprd18.prod.outlook.com>
 <CAL+mCpO43LNUa-xzH7_AkSjcyo1Ws2-SdVUhvn6ySQY2_2OhgQ@mail.gmail.com>
 <CO1PR18MB4796A90FEE9E4C8246846F11BFB92@CO1PR18MB4796.namprd18.prod.outlook.com>
In-Reply-To: <CO1PR18MB4796A90FEE9E4C8246846F11BFB92@CO1PR18MB4796.namprd18.prod.outlook.com>
From: Amiya Ranjan Mohakud <amiyaranjan.mohakud@gmail.com>
Date: Wed, 16 Sep 2026 11:13:05 +0530
X-Gm-Features: AcwNN1VsVXCWYpdJOuVCq3nonGzvQjid8QTnnFxOcir1Xo6Re7WmfulaqvAGhes
Message-ID: <CAL+mCpP35KM98KyydV4VBrCroR41-v1dt61E_dxMfx-3W2AQbA@mail.gmail.com>
Subject: Re: [EXTERNAL] [PATCH v2] common/cnxk: fix NPA pool RANGE interrupt
 handling
To: Ashwin Sekhar T K <asekhar@marvell.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>,
 Nithin Kumar Dabilpuram <ndabilpuram@marvell.com>, 
 Jerin Jacob <jerinj@marvell.com>, Sunil Kumar Kori <skori@marvell.com>
Content-Type: multipart/alternative; boundary="000000000000dd6591065b9324c1"
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

--000000000000dd6591065b9324c1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ashwin - I have raised a ticket
https://bugs.dpdk.org/show_bug.cgi?id=3D2031 with details. Pls check if it
helps.

Thanks
Amiya


On Wed, 16 Sept 2026 at 10:10, Ashwin Sekhar T K <asekhar@marvell.com>
wrote:

> Hi Amiya,
> > Yes =E2=80=94 the root cause is NDC staleness. The AQ INIT writes pool =
context
> (including ptr_start=3D0, ptr_end=3D~0) directly to RAM, bypassing NDC.
> The AQ INIT does not bypass NDC. May I know how you arrived at this
> conclusion?
> Even your other NDC sync patch is not required. The only time NDC sync is
> required is at teardown time because at this point, we free the stack
> memory. So, after this, NPA should not evict any stale stack pages back t=
o
> memory (which is already freed).
>
> > Sorry for my poor wordings. on my part. The pool stack does not get
> drained =E2=80=94 it never gets populated.During cnxk_mempool_populate(),=
 each
> roc_npa_aura_op_free() call silently drops the buffer (NPA sees stale
> context with ena=3D0 or ptr_end=3D0 via NDC). After populate completes, t=
he
> pool has 0
> > available buffers despite no error being returned. Subsequent
> roc_npa_aura_op_alloc() returns NULL, causing port start failures.
> It will not silently drop. You should be getting AURA DISABLED interrupts=
.
>
> Could you please explain the exact use case and issue that you are facing=
?
>
> Thanks
> Ashwin
>
>

--000000000000dd6591065b9324c1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div style=3D"font-family:trebuchet ms,sans-serif;col=
or:rgb(103,78,167)" class=3D"gmail_default">Hi Ashwin - I have raised a tic=
ket <a href=3D"https://bugs.dpdk.org/show_bug.cgi?id=3D2031">https://bugs.d=
pdk.org/show_bug.cgi?id=3D2031</a> with details. Pls check if it helps.</di=
v><br clear=3D"all"></div><div><div dir=3D"ltr" class=3D"gmail_signature" d=
ata-smartmail=3D"gmail_signature"><div dir=3D"ltr"><div><span style=3D"font=
-family:verdana,sans-serif">Thanks</span></div><div><span style=3D"font-fam=
ily:verdana,sans-serif">Amiya</span><br></div></div></div></div><br></div><=
br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=
=3D"gmail_attr">On Wed, 16 Sept 2026 at 10:10, Ashwin Sekhar T K &lt;<a hre=
f=3D"mailto:asekhar@marvell.com">asekhar@marvell.com</a>&gt; wrote:<br></di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left:1px solid rgb(204,204,204);padding-left:1ex">Hi Amiya,<br>
&gt; Yes =E2=80=94 the root cause is NDC staleness. The AQ INIT writes pool=
 context (including ptr_start=3D0, ptr_end=3D~0) directly to RAM, bypassing=
 NDC.<br>
The AQ INIT does not bypass NDC. May I know how you arrived at this conclus=
ion?<br>
Even your other NDC sync patch is not required. The only time NDC sync is r=
equired is at teardown time because at this point, we free the stack memory=
. So, after this, NPA should not evict any stale stack pages back to memory=
 (which is already freed).<br>
<br>
&gt; Sorry for my poor wordings. on my part. The pool stack does not get dr=
ained =E2=80=94 it never gets populated.During cnxk_mempool_populate(), eac=
h roc_npa_aura_op_free() call silently drops the buffer (NPA sees stale con=
text with ena=3D0 or ptr_end=3D0 via NDC). After populate completes, the po=
ol has 0 <br>
&gt; available buffers despite no error being returned. Subsequent roc_npa_=
aura_op_alloc() returns NULL, causing port start failures.<br>
It will not silently drop. You should be getting AURA DISABLED interrupts.<=
br>
<br>
Could you please explain the exact use case and issue that you are facing?<=
br>
<br>
Thanks<br>
Ashwin<br>
<br>
</blockquote></div>

--000000000000dd6591065b9324c1--
