Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2575BC88E75
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Sep 2026 19:10:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E7EC24025F;
	Tue, 15 Sep 2026 21:10:42 +0200 (CEST)
Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com
 [74.125.224.141])
 by mails.dpdk.org (Postfix) with ESMTP id C08284003C
 for <dev@dpdk.org>; Tue, 15 Sep 2026 21:10:41 +0200 (CEST)
Received: by mail-yx2-f13.google.com with SMTP id
 956f58d0204a3-66fded6b087so122119d50.1
 for <dev@dpdk.org>; Tue, 15 Sep 2026 12:10:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789499441; cv=none;
 d=google.com; s=arc-20260327;
 b=pWcGad4f46LNyvn7xA1uBYC5L852T9g+W9l9hS7UQKejqDUh3QvTda7o8P+bY65s4M
 NWvpdO7a1IoTWBTzRhdJrUN4QGeGYUpe+kbD5Yxmo6thQC3ldRa87QYUKt4bl2lM68oo
 6/4M3z1ctvP2Wq/oyN67ZS/eoZQY6ZY6acX+IteuLaLGvBzkwwh4v68OQNf3v61pHZ9I
 GpvXnoWkGG8FkoSA6zkC7R/mdMiclKIV1UTssfMTZadxNMxWyChjj1qJDJH97fDzvGou
 ERtsYRPllOd4b6IeumIquCGtF8izFbplGi7Kq/h5IJIBqmPI0Y4M1SQlJxEEdONNHBTy
 hfCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=nyEj8lgIpwM6luaASJ3i/JYcLn9/Wag8eGdC8MpAfaw=;
 fh=M4ntZrbfNOI2ObdlEHflOdWkDYk4AAaaM2dw1Zibg8s=;
 b=VSxAvrtwgfuW0flvIgRuP52szFZ1tK2fu842mnMZXIrMXBMxvocwUFJAIhcVGsXeEt
 YXrA7IdOGYhIJuB2x9TfpsAjPtNJ+7sDuPiF1snH12PMPrpJEC8nhTyF7Z6lsw/s+q+W
 /S7+EGN6KbP6/X2uQ61cLspaMUixcAFBWhG8xFw1Qz2wP08DVToY2cmUEc0KPaUwKfVn
 NvCGm70UtFS5TfN3SK0B6HFhynmQd/pkamTdYJ5MCCdO5UUAI8b7lHD/ZZjFlWs+5QMI
 WrNLG7qK9hQClkCHSXnEUiAg1ShiOc8jT/Rzf9XDkJE8My4eIDeX58nJEXhDIJ9J+4o4
 DIMA==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789499441; x=1790104241; darn=dpdk.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=nyEj8lgIpwM6luaASJ3i/JYcLn9/Wag8eGdC8MpAfaw=;
 b=cY5hSy02Du9KcQuELrkzdUFxPeYkqfc5j2VO73IJJWdJf72ms12G6lgweTZ8ucZgMV
 I3RZg8/n29CwaC4IK5bZrxUqnkh87bxNei7YlNYH+06ZWroQ+h17y4K9qokrqd4gAUZo
 Cp5vqX78V6n72O3jI8l7tpLI8zJPEklViW8EuRDImKc24sq/i67b/nUDpNgVqhWYqv7R
 ftpkZ6xwx+aIdx7IqULzgHTVBqvRweOBGb9J1VTxDM5aM0D/CV3upWaAXx93Qrh7OKO1
 JUz38ZXT07EBz6c1dkT9WY/G1pdYMm6p5L/Nk0iVZqhkwj/F9NOuzQp+7MQwOUQyF0rT
 jmHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789499441; x=1790104241;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=nyEj8lgIpwM6luaASJ3i/JYcLn9/Wag8eGdC8MpAfaw=;
 b=XTnYhvlgV+0ORDYvAOMrCTmZJAR2V7z/z8fMNl1IFcjOnd7T4Y0yYPh9rBh3B9RNeK
 psWoi9QjDMxalmYyyXGnXsxukirGL628TMhlvyPy7zg0Bd3uCVZxC4noPQSt8dhHPKL6
 +vI7Fp4S+u/bHoo7H00wFz3NbvGREXE6yUFdFGapw3G1/NAfwmgeiENCk1oVIapEWWX0
 WMisPO0/0pOlj/M0IniAhLF/W4yc5x4j4PldqZyqU0U40LOI8SiqkyAgPdFavhUGWnag
 pITtB/5hzd2BN+LJkDZsj8OmQe0JRj/N3RQjRBUSb7LRkQYWoClu6jcYPQ9eucWDSFu6
 Sh6A==
X-Gm-Message-State: AFuF++nF9hTXw75clLWkY6KoU/NH1HzE1NczzpErvNL8Lynsi7s+al/z
 eFiKJtErV66+o9/RLAydVR94D7PQU03W2UqciJYilL4EMrEFFTH9KsK/JdOSM4aAOed9vvtq6k+
 mGydwoBBc8UAbuL8WwbdgiOkRPeyoXOB2OfRc
X-Gm-Gg: AYBFou0aHb3YcTE/5vpsP/TeFsC8MdknQyEfQ0M8ozCp+i4Qlf1YUyyhaNmx4gFG8/K
 MLzw1mGRQ7RXDpNFOdN9jw8Ja/xkYHWHO5CYTEaDDtTLOd6wEHpkXtPoUr/OJDLFz8Nro1OpsPW
 F4EMp4fAaPkkR07C4Pq4hyt1d/TADg4ivfNVNSxx7ujrlMRvTkw9JIPTjnb0bXwyUggh03N8xM5
 EQmVCq6GaoIVV1KN699OmOjRLJOuLFl4ZfTsY65JCrT+LyPBe4B5iOK/8CNHHrWPalvhjMlIlsc
 MbE+wjqC5hVfAbkGyfa7cBgX/nN0DNkkCAgxyZM6XYctI5m1qlMOCWxD
X-Received: by 2002:a05:690e:d03:b0:670:f743:6ec2 with SMTP id
 956f58d0204a3-6715cba54f3mr954604d50.60.1789499440939; Tue, 15 Sep 2026
 12:10:40 -0700 (PDT)
MIME-Version: 1.0
References: <20260913040800.60274-1-amiyaranjan.mohakud@gmail.com>
 <20260913070428.66628-1-amiyaranjan.mohakud@gmail.com>
 <CO1PR18MB4796E0F85799C486CA837DEFBFBA2@CO1PR18MB4796.namprd18.prod.outlook.com>
In-Reply-To: <CO1PR18MB4796E0F85799C486CA837DEFBFBA2@CO1PR18MB4796.namprd18.prod.outlook.com>
From: Amiya Ranjan Mohakud <amiyaranjan.mohakud@gmail.com>
Date: Wed, 16 Sep 2026 00:40:29 +0530
X-Gm-Features: AcwNN1WbAH7Y1cxcin_31CvqTZdDamAj1OCZ6l9TVBXA56mMyyEmQ9IfVArRKaI
Message-ID: <CAL+mCpO43LNUa-xzH7_AkSjcyo1Ws2-SdVUhvn6ySQY2_2OhgQ@mail.gmail.com>
Subject: Re: [EXTERNAL] [PATCH v2] common/cnxk: fix NPA pool RANGE interrupt
 handling
To: Ashwin Sekhar T K <asekhar@marvell.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>,
 Nithin Kumar Dabilpuram <ndabilpuram@marvell.com>, 
 Jerin Jacob <jerinj@marvell.com>, Sunil Kumar Kori <skori@marvell.com>
Content-Type: multipart/alternative; boundary="00000000000080c50d065b8a4e0c"
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

--00000000000080c50d065b8a4e0c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ashwin




*> NPA_POOL_ERR_INT_RANGE fires spuriously between pool creation >
(ptr_start/ptr_end default to 0/~0) and the actual range install > via
roc_npa_pool_op_range_set().  >>ERR_INT_RANGE is not supposed to fire
spuriously. Did you root cause why this is happening ?*

Yes =E2=80=94 the root cause is NDC staleness. The AQ INIT writes pool cont=
ext
(including ptr_start=3D0, ptr_end=3D~0) directly to RAM, bypassing NDC. Whe=
n
the MMIO data path (aura_op_free) reads pool context, it goes through NDC
which can still have stale zeros from a previous init/teardown cycle =E2=80=
=94
including ptr_end=3D0. Against that stale range [0, 0], any buffer IOVA
triggers RANGE.

The NDC sync patch [
https://patches.dpdk.org/project/dpdk/patch/20260909192323.26886-1-amiyaran=
jan.mohakud@gmail.com/]
addresses this root cause by invalidating NDC after AQ INIT. This RANGE
patch adds defense-in-depth: mask RANGE during the init=E2=86=92range_set w=
indow
and re-enable only after the real range is installed.
I also acknowledge that this fix is no longer required if we force-sync the
NDC as in
https://patches.dpdk.org/project/dpdk/patch/20260909192323.26886-1-amiyaran=
jan.mohakud@gmail.com/.
We can drop this patch completely.



*> On CN10K this drains the pool > stack and makes the pool
unusable.>>Didn't quite understand this part. Could you please elaborate.*

Sorry for my poor wordings. on my part. The pool stack does not get drained
=E2=80=94 it never gets populated.During cnxk_mempool_populate(), each
roc_npa_aura_op_free()
call silently drops the buffer (NPA sees stale context with ena=3D0 or
ptr_end=3D0 via NDC). After populate completes, the pool has 0 available
buffers despite no error being returned. Subsequent roc_npa_aura_op_alloc()
returns NULL, causing port start failures.

All this will be taken care of via NDC sync. So it's safe to drop this
patch.

I initially made this fix and later fixed the NDC sync issue, so somehow, I
forgot to  mark this patch as dropped.

Thanks
Amiya


On Tue, 15 Sept 2026 at 12:09, Ashwin Sekhar T K <asekhar@marvell.com>
wrote:

> Hi Amiya,
>
> > NPA_POOL_ERR_INT_RANGE fires spuriously between pool creation
> > (ptr_start/ptr_end default to 0/~0) and the actual range install
> > via roc_npa_pool_op_range_set().
> ERR_INT_RANGE is not supposed to fire spuriously. Did you root cause why
> this is happening ?
>
>
> > On CN10K this drains the pool
> > stack and makes the pool unusable.
> Didn't quite understand this part. Could you please elaborate.
>
> Thanks
> Ashwin
>
>
>

--00000000000080c50d065b8a4e0c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div style=3D"font-family:trebuchet ms,sans-serif;col=
or:rgb(103,78,167)" class=3D"gmail_default">Hi Ashwin</div><div style=3D"fo=
nt-family:trebuchet ms,sans-serif;color:rgb(103,78,167)" class=3D"gmail_def=
ault"><br></div><div style=3D"font-family:trebuchet ms,sans-serif;color:rgb=
(103,78,167)" class=3D"gmail_default"><i><span class=3D"gmail-im" style=3D"=
color:rgb(0,0,0);background-color:rgb(238,238,238)">&gt; NPA_POOL_ERR_INT_R=
ANGE fires spuriously between <span class=3D"gmail-il">pool</span> creation=
<br>
&gt; (ptr_start/ptr_end default to 0/~0) and the actual <span class=3D"gmai=
l-il">range</span> install<br>
&gt; via roc_npa_pool_op_range_set().=C2=A0 <br></span><span style=3D"color=
:rgb(0,0,0);background-color:rgb(238,238,238)">&gt;&gt;ERR_INT_RANGE is not=
 supposed to fire spuriously. Did you root cause why this is happening ?</s=
pan></i></div><div style=3D"font-family:trebuchet ms,sans-serif;color:rgb(1=
03,78,167)" class=3D"gmail_default"><br></div><div style=3D"font-family:tre=
buchet ms,sans-serif;color:rgb(103,78,167)" class=3D"gmail_default">Yes =E2=
=80=94 the root cause is NDC staleness. The AQ INIT writes pool context (in=
cluding ptr_start=3D0, ptr_end=3D~0) directly to RAM, bypassing NDC. When t=
he MMIO data path (aura_op_free) reads pool context, it goes through NDC wh=
ich can still have stale zeros from a previous init/teardown cycle =E2=80=
=94 including ptr_end=3D0. Against that stale range [0, 0], any buffer IOVA=
 triggers RANGE.<br><br></div><div style=3D"font-family:trebuchet ms,sans-s=
erif;color:rgb(103,78,167)" class=3D"gmail_default">The NDC sync patch [<a =
href=3D"https://patches.dpdk.org/project/dpdk/patch/20260909192323.26886-1-=
amiyaranjan.mohakud@gmail.com/">https://patches.dpdk.org/project/dpdk/patch=
/20260909192323.26886-1-amiyaranjan.mohakud@gmail.com/</a>] addresses this =
root cause by invalidating NDC after AQ INIT. This RANGE patch adds defense=
-in-depth: mask RANGE during the init=E2=86=92range_set window and re-enabl=
e only after the real range is installed.=C2=A0</div><div style=3D"font-fam=
ily:trebuchet ms,sans-serif;color:rgb(103,78,167)" class=3D"gmail_default">=
I also acknowledge that this fix is no longer required if we force-sync the=
 NDC as in=C2=A0<a href=3D"https://patches.dpdk.org/project/dpdk/patch/2026=
0909192323.26886-1-amiyaranjan.mohakud@gmail.com/">https://patches.dpdk.org=
/project/dpdk/patch/20260909192323.26886-1-amiyaranjan.mohakud@gmail.com/</=
a>. We can drop this patch completely.</div><div style=3D"font-family:trebu=
chet ms,sans-serif;color:rgb(103,78,167)" class=3D"gmail_default"><br></div=
><span style=3D"background-color:rgb(238,238,238)"><i><span class=3D"gmail-=
im" style=3D"color:rgb(0,0,0);font-family:trebuchet ms,sans-serif">&gt; On =
CN10K this drains the <span class=3D"gmail-il">pool</span><br>
&gt; stack and makes the <span class=3D"gmail-il">pool</span> unusable.<br>=
</span><span style=3D"color:rgb(0,0,0);font-family:trebuchet ms,sans-serif"=
><span class=3D"gmail_default">&gt;&gt;</span></span><span style=3D"color:r=
gb(0,0,0);font-family:trebuchet ms,sans-serif">Didn&#39;t quite understand =
this part. Could you please elaborate.</span></i></span></div><div><br></di=
v><div><span style=3D"color:rgb(103,78,167);font-family:trebuchet ms,sans-s=
erif"><span class=3D"gmail_default">Sorry for my p</span>oor wording<span c=
lass=3D"gmail_default">s.</span> on my part. The pool stack does not get dr=
ained =E2=80=94 it<span class=3D"gmail_default" style=3D"font-family:trebuc=
het ms,sans-serif;color:rgb(103,78,167)">=C2=A0</span>never gets populated.=
<span class=3D"gmail_default" style=3D"font-family:trebuchet ms,sans-serif;=
color:rgb(103,78,167)"></span>During cnxk_mempool_populate(), each<span cla=
ss=3D"gmail_default" style=3D"font-family:trebuchet ms,sans-serif;color:rgb=
(103,78,167)">=C2=A0</span>roc_npa_aura_op_free() call silently drops the b=
uffer (NPA sees<span class=3D"gmail_default" style=3D"font-family:trebuchet=
 ms,sans-serif;color:rgb(103,78,167)">=C2=A0</span>stale context with ena=
=3D0 or ptr_end=3D0 via NDC). After populate<span class=3D"gmail_default" s=
tyle=3D"font-family:trebuchet ms,sans-serif;color:rgb(103,78,167)">=C2=A0</=
span>completes, the pool has 0 available buffers despite no error being<spa=
n class=3D"gmail_default" style=3D"font-family:trebuchet ms,sans-serif;colo=
r:rgb(103,78,167)">=C2=A0</span><span class=3D"gmail_default" style=3D"font=
-family:trebuchet ms,sans-serif;color:rgb(103,78,167)">r</span>eturned. Sub=
sequent roc_npa_aura_op_alloc() returns NULL, causing<span class=3D"gmail_d=
efault" style=3D"font-family:trebuchet ms,sans-serif;color:rgb(103,78,167)"=
>=C2=A0</span>port start failures.</span></div><div><br></div><div><div sty=
le=3D"font-family:trebuchet ms,sans-serif;color:rgb(103,78,167)" class=3D"g=
mail_default">All this will be taken care of via NDC sync. So it&#39;s safe=
 to drop this patch.</div><br></div><div><div style=3D"font-family:trebuche=
t ms,sans-serif;color:rgb(103,78,167)" class=3D"gmail_default">I initially =
made this fix and later fixed the NDC sync issue, so somehow, I forgot to=
=C2=A0 mark=C2=A0this patch as dropped.</div><br></div><div><div dir=3D"ltr=
" class=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div dir=3D"=
ltr"><div><span style=3D"font-family:verdana,sans-serif">Thanks</span></div=
><div><span style=3D"font-family:verdana,sans-serif">Amiya</span><br></div>=
</div></div></div><br></div><br><div class=3D"gmail_quote gmail_quote_conta=
iner"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, 15 Sept 2026 at 12:09, =
Ashwin Sekhar T K &lt;<a href=3D"mailto:asekhar@marvell.com">asekhar@marvel=
l.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex">Hi Amiya,<br>
<br>
&gt; NPA_POOL_ERR_INT_RANGE fires spuriously between pool creation<br>
&gt; (ptr_start/ptr_end default to 0/~0) and the actual range install<br>
&gt; via roc_npa_pool_op_range_set().=C2=A0 <br>
ERR_INT_RANGE is not supposed to fire spuriously. Did you root cause why th=
is is happening ?<br>
<br>
<br>
&gt; On CN10K this drains the pool<br>
&gt; stack and makes the pool unusable.<br>
Didn&#39;t quite understand this part. Could you please elaborate.<br>
<br>
Thanks<br>
Ashwin<br>
<br>
<br>
</blockquote></div>

--00000000000080c50d065b8a4e0c--
