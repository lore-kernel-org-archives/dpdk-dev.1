Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3749C982C5
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Sep 2026 15:15:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B0ABD4028B;
	Wed, 16 Sep 2026 17:15:54 +0200 (CEST)
Received: from mail-yx2-f43.google.com (mail-yx2-f43.google.com
 [74.125.224.171])
 by mails.dpdk.org (Postfix) with ESMTP id 6FFF740264
 for <dev@dpdk.org>; Wed, 16 Sep 2026 17:15:53 +0200 (CEST)
Received: by mail-yx2-f43.google.com with SMTP id
 00721157ae682-85d43ac6090so11833647b3.2
 for <dev@dpdk.org>; Wed, 16 Sep 2026 08:15:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789571752; cv=none;
 d=google.com; s=arc-20260327;
 b=ddqTcxqbqtu6KPs/T4JJbBFJqrNQ4lEWJXtQ2yAEbJ2NQFE1lRspsk4njGb/xctTIu
 DgmUjvSkkcYP++MJXDLDjyF3FBMhG1McSR1by2E5+5xVv1sL+0zg1WJh8hO3DCqZzDP5
 GqfqyJq7AsMtuy9KwvPCQxHaki8suA3Yos4knyngu2g3gfXbrrh9u84rb1sp8ip7DYLD
 MBHLd4rY/scTQit/PRd4VyHsFvFZ08p9Eavzg+rbrQ2XzcBxBih8Ilm8e+isaKFzrH8K
 0wfUGW6QwpuNW5Uj02mtYI4PjUTT5DEgeq8S+u/Sy0jb8gkzk6oF8KKHdjXaXyoryBtU
 zXmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=HcwDd/oSmcw7gY5ZuEhdaTswAmOfcDo02uCTlnR/mfQ=;
 fh=M4ntZrbfNOI2ObdlEHflOdWkDYk4AAaaM2dw1Zibg8s=;
 b=CjFNidE8mhDET/rlN0DJL12PU12Q9na0nBxA8952I03NUvVMvW3OlXio9sS08/T7Md
 A9wpkNt1wlI+7DQ7uJdoQP0f3GFt1dfpE3NDBdRutWzkrM2z61FbdiBkuC5Fnze/MfBl
 Axj7b9Kfatk+XGnnzK/eKVBbECjmOOPlFH70pk7a9HhnTvOOBlfPzO2p4wfwxFX/i2c7
 3hfDkJuvDnTFWsgZzP/NU0CoivvyJICmolR1NfzOKG3TXykhU/wWP/yru44C5+0TwtOu
 z2ev8mFM10pCp7yFoYMmrW9asmyLPZj6Yri4UNSk75Kq9YuYi8VK86iFXDDy9Ql5x0B7
 I+Ng==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789571752; x=1790176552; darn=dpdk.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=HcwDd/oSmcw7gY5ZuEhdaTswAmOfcDo02uCTlnR/mfQ=;
 b=RrpfQNibjkI1vvciJCUNsbRJaEIYjpH+hYTh1sTr30f3OZYTo059j4fvpcSdtS4mJ0
 kkcxA1INETDJae5d5iD9rvFFgKpBB11JA5u35Y2g+5n+HzpJflUWZr+HH/PnDwJNkA3/
 TW7zGXaqwuPzCLl/EToW9QvMpJu7szWxvqHt9r2vlrePTs3dtvtDdmFOudoPhUlPPd6z
 3ceo+oVCkNNmW2bwDvD9M2DzJfFdFFDItFCJV3LkCaNaLbPUak0cxvwYVVg6wj1OwFuI
 /lRWRDIjjmpOGOHHxjMsmE4Hq/4sOPibS5dZHFj4gPEtt2sAK27doeF/BVszJWHoEVvX
 C94Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789571752; x=1790176552;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=HcwDd/oSmcw7gY5ZuEhdaTswAmOfcDo02uCTlnR/mfQ=;
 b=rcMDSSQDWTOwntI8n+ioCAfE69LDx5QgNTwGRGh/J1t5AKks1Vrq34tSqagBLy9fmj
 eqKvUKYWigW8J9mSmQ5xt6rNI5r5+5PN6vEyaG5oeUNPhOX3OjZ/7NcUEiQ6xVgm+xYi
 cfknqNpaLMKRbnjc5sftnqHa35H0bf25eRjwkEnCQMb4cS02EPfLyFK09kA6b3GmkC1F
 DIGolGYGGyAodyBmgC3ymdZ+9i//xEsI8Z6Nk3ml7V7DTiX6YqFPtJYLa157jD+5IXBI
 koEPr+mfwInx35iW8deFrttIUoy1gJhBZypyzIHlYeTzu/DtMI0LVQ+nTOSQaNk/X0ms
 Of3A==
X-Gm-Message-State: AFuF++kN42ktR5kXBaq4HA4jytJiaRMwZWf8Yrql11fYp/PpL8EZCbAJ
 /8Eei9aaAPWFPO4TFGRd16NfdMGTQXQ6QElPts7+2HHez7jo6q/c4n2RLz4RNTDdc1y4djsE+7d
 u2UWbhQMuE5xxi/uQDBN6bcHh5ITxmbw=
X-Gm-Gg: AYBFou2i9Cr4FhVWGt5hbv1Hd5tBjQVG87klwtlVPZtul3jtRNDcOMOCIHuRM73yQO+
 4ggcZUdEdaDFKpgmlTSX8eG1EYVwRKXJuzId1ca4TuyPpSUX3tpOipSl9HMGI+CcZGmO7kdUshd
 e/jO6v/f5e5oJikgxK9HtbJieCWqi7CBAhnzUbP52h4zWU8EseSz54qx1CziJIHQdl724/DE4+N
 YnuQO6QN5JxYKIFvl9MqPtqSm7bpUsNXgLJxDIC56wgOD0EgaP8PYFigDzm/L6RbwA274RI0k4L
 51cEcuDlw4g1ucSAgwLLdnFGaj6jZ+8hGtkJ/N7uK4l/hdvNeugY69Orng==
X-Received: by 2002:a05:690c:f04:b0:820:b89:52c6 with SMTP id
 00721157ae682-892247a7e3bmr10630487b3.33.1789571752414; Wed, 16 Sep 2026
 08:15:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260913040800.60274-1-amiyaranjan.mohakud@gmail.com>
 <20260913070428.66628-1-amiyaranjan.mohakud@gmail.com>
 <CO1PR18MB4796E0F85799C486CA837DEFBFBA2@CO1PR18MB4796.namprd18.prod.outlook.com>
 <CAL+mCpO43LNUa-xzH7_AkSjcyo1Ws2-SdVUhvn6ySQY2_2OhgQ@mail.gmail.com>
 <CO1PR18MB4796A90FEE9E4C8246846F11BFB92@CO1PR18MB4796.namprd18.prod.outlook.com>
 <CAL+mCpP35KM98KyydV4VBrCroR41-v1dt61E_dxMfx-3W2AQbA@mail.gmail.com>
In-Reply-To: <CAL+mCpP35KM98KyydV4VBrCroR41-v1dt61E_dxMfx-3W2AQbA@mail.gmail.com>
From: Amiya Ranjan Mohakud <amiyaranjan.mohakud@gmail.com>
Date: Wed, 16 Sep 2026 20:45:40 +0530
X-Gm-Features: AcwNN1UcB0Pw7O2IECxJ14vcUxxLeRtkdLU90Kt9deTuRErYBWtMySgDjWSvOrk
Message-ID: <CAL+mCpPOPtvn+Si6PvnvpK5e3rQHp81SV-+WDaiiJADt99V--A@mail.gmail.com>
Subject: Re: [EXTERNAL] [PATCH v2] common/cnxk: fix NPA pool RANGE interrupt
 handling
To: Ashwin Sekhar T K <asekhar@marvell.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>,
 Nithin Kumar Dabilpuram <ndabilpuram@marvell.com>, 
 Jerin Jacob <jerinj@marvell.com>, Sunil Kumar Kori <skori@marvell.com>
Content-Type: multipart/alternative; boundary="0000000000009a5196065b9b2497"
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

--0000000000009a5196065b9b2497
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ashwin

*The AQ INIT does not bypass NDC. May I know how you arrived at this
conclusion?*
* Even your other NDC sync patch is not required. The only time NDC sync is
required is at teardown time because at this point, we free the stack
memory. So, after this, NPA should not evict any stale stack pages back to
memory (which is already freed).*

*>> *I don't see any ndc_sync calls during pool_init, So the NDC is not
updated at pool_init time, whereas it's getting called for all termination
paths. Could you explain how this is taken care of then without an ndc
sync? I need to test without NDC sync changes multiple times and confirm.
BUt if you could explain how it'll work without NDC sync or how it's a side
effect of IOVA as PA, it would be great.

Thanks
Amiya


On Wed, 16 Sept 2026 at 11:13, Amiya Ranjan Mohakud <
amiyaranjan.mohakud@gmail.com> wrote:

> Hi Ashwin - I have raised a ticket
> https://bugs.dpdk.org/show_bug.cgi?id=3D2031 with details. Pls check if i=
t
> helps.
>
> Thanks
> Amiya
>
>
> On Wed, 16 Sept 2026 at 10:10, Ashwin Sekhar T K <asekhar@marvell.com>
> wrote:
>
>> Hi Amiya,
>> > Yes =E2=80=94 the root cause is NDC staleness. The AQ INIT writes pool=
 context
>> (including ptr_start=3D0, ptr_end=3D~0) directly to RAM, bypassing NDC.
>> The AQ INIT does not bypass NDC. May I know how you arrived at this
>> conclusion?
>> Even your other NDC sync patch is not required. The only time NDC sync i=
s
>> required is at teardown time because at this point, we free the stack
>> memory. So, after this, NPA should not evict any stale stack pages back =
to
>> memory (which is already freed).
>>
>> > Sorry for my poor wordings. on my part. The pool stack does not get
>> drained =E2=80=94 it never gets populated.During cnxk_mempool_populate()=
, each
>> roc_npa_aura_op_free() call silently drops the buffer (NPA sees stale
>> context with ena=3D0 or ptr_end=3D0 via NDC). After populate completes, =
the
>> pool has 0
>> > available buffers despite no error being returned. Subsequent
>> roc_npa_aura_op_alloc() returns NULL, causing port start failures.
>> It will not silently drop. You should be getting AURA DISABLED interrupt=
s.
>>
>> Could you please explain the exact use case and issue that you are facin=
g?
>>
>> Thanks
>> Ashwin
>>
>>

--0000000000009a5196065b9b2497
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div style=3D"font-family:trebuchet ms,sans-serif;col=
or:rgb(103,78,167)" class=3D"gmail_default">Hi Ashwin</div><div style=3D"fo=
nt-family:trebuchet ms,sans-serif;color:rgb(103,78,167)" class=3D"gmail_def=
ault"><br></div><div style=3D"font-family:trebuchet ms,sans-serif;color:rgb=
(103,78,167)" class=3D"gmail_default"><i style=3D"color:rgb(0,0,0)">The AQ =
INIT does not bypass NDC. May I know how you arrived at this conclusion?</i=
></div><div style=3D"font-family:trebuchet ms,sans-serif;color:rgb(103,78,1=
67)" class=3D"gmail_default"><span style=3D"color:rgb(0,0,0)"><i>
Even your other NDC sync patch is not required. The only time NDC sync=20
is required is at teardown time because at this point, we free the stack
 memory. So, after this, NPA should not evict any stale stack pages back
 to memory (which is already freed).</i></span></div><div style=3D"font-fam=
ily:trebuchet ms,sans-serif;color:rgb(103,78,167)" class=3D"gmail_default">=
<span class=3D"gmail-im"><br></span><i>&gt;&gt;=C2=A0</i>I don&#39;t see an=
y ndc_sync calls during pool_init, So the NDC is not updated at pool_init t=
ime, whereas it&#39;s getting called for all termination paths. Could you e=
xplain how this is taken care of then without an ndc sync? I need to test w=
ithout NDC sync changes multiple times and confirm. BUt if you could explai=
n how it&#39;ll work without NDC sync or how it&#39;s a side effect of IOVA=
 as PA, it would be great.</div><br clear=3D"all"></div><div><div dir=3D"lt=
r" class=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div dir=3D=
"ltr"><div><span style=3D"font-family:verdana,sans-serif">Thanks</span></di=
v><div><span style=3D"font-family:verdana,sans-serif">Amiya</span><br></div=
></div></div></div><br></div><br><div class=3D"gmail_quote gmail_quote_cont=
ainer"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, 16 Sept 2026 at 11:13,=
 Amiya Ranjan Mohakud &lt;<a href=3D"mailto:amiyaranjan.mohakud@gmail.com">=
amiyaranjan.mohakud@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(20=
4,204,204);padding-left:1ex"><div dir=3D"ltr"><div><div style=3D"font-famil=
y:trebuchet ms,sans-serif;color:rgb(103,78,167)" class=3D"gmail_default">Hi=
 Ashwin - I have raised a ticket <a href=3D"https://bugs.dpdk.org/show_bug.=
cgi?id=3D2031" target=3D"_blank">https://bugs.dpdk.org/show_bug.cgi?id=3D20=
31</a> with details. Pls check if it helps.</div><br clear=3D"all"></div><d=
iv><div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><div><span s=
tyle=3D"font-family:verdana,sans-serif">Thanks</span></div><div><span style=
=3D"font-family:verdana,sans-serif">Amiya</span><br></div></div></div></div=
><br></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_a=
ttr">On Wed, 16 Sept 2026 at 10:10, Ashwin Sekhar T K &lt;<a href=3D"mailto=
:asekhar@marvell.com" target=3D"_blank">asekhar@marvell.com</a>&gt; wrote:<=
br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hi Amiya,<br>
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
</blockquote></div>

--0000000000009a5196065b9b2497--
