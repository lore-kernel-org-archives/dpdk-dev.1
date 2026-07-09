Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C67BC43458
	for <dpdk-dev@archiver.kernel.org>; Thu,  9 Jul 2026 01:05:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 53902402D1;
	Thu,  9 Jul 2026 03:05:10 +0200 (CEST)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com
 [209.85.221.42]) by mails.dpdk.org (Postfix) with ESMTP id D52CF4026E
 for <dev@dpdk.org>; Thu,  9 Jul 2026 03:05:08 +0200 (CEST)
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-47ddf7b09aaso872222f8f.3
 for <dev@dpdk.org>; Wed, 08 Jul 2026 18:05:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783559108; cv=none;
 d=google.com; s=arc-20260327;
 b=Owjnoj8pUurjVT1rFpajP3d+KWGH7lXl20NUHaf0otnTAiZ2UXaquXtEX1L3mfHRLa
 OhbZmp81lTcPdmsTrycYZQHMEGZjsuRQha00/ZSoZVPhUKOEWdIBVoeKwQ0cWjZEDFDC
 /d0l138HTUPl+cdnVz+UQgeUdlFTwgR2hRh/kQ0zw+N+4a82B76qZmJtgHZbZrDjbkIT
 GadNFrdDQ4Cnm7mDUnhevas3xHxj33SlEhX9KssG52JN7+dNm1HISS8Lbauth0XTGlQE
 lhv3b0UemuLsR7vjhH/fRbtR+17DgfOWhnHm83KOupJYqMc1FMYFVTC/m6ltLMfharBN
 sW2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=tKX3lmtmcqSoVZZvZ9yJcRcN8ulpeTGUkeH4I4w9dOc=;
 fh=gvqagplSAqYMdkHxC6SzTWIgW4MJj2Wy2iwnVagobe8=;
 b=jT1pMxBvjKtly0cypS6zZqf3gOZTuBl/pPemLbwQEGyJ3Qfjr61OhcTTh+te9Puyns
 8AW3AQ34RwN/10zXhciM+UtlAspTK09JBf0fYTU4apRG28EFRchd/0NQ56wwvcm99C3C
 r5TL5HUHZ1an9wjoPWqAWpAy6B8B3lEbqgXSBpbtlCHgcJF44RIbglbiell+BNxcfacW
 Z+9szV5r2av0JvgTgJfMhCPmddvvfdi41iWt4OfLDVNtRkZqsAsmeTID1kqryFSxsNvn
 LKgpSRv73zt0H0hlHvMzwFkc+Sx/qmbkVDMxjka3QlbtkMDlRVbQJvVdysjK797JpG1T
 cXjw==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783559108; x=1784163908; darn=dpdk.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=tKX3lmtmcqSoVZZvZ9yJcRcN8ulpeTGUkeH4I4w9dOc=;
 b=WEBfROAulnsspBxDKx+kiO+8ZZHZ4f8eZGiw0KCV2/39368RovZUqGcx43A4K5z9rz
 Zz6yIAfZmaE80Rg3De5j8ypw8NXSjR18jk4xwRUg0sp7E/lUUBNGfWBBSSqxfsDNhfHE
 bGfyBEWMh3wT/dEIzzTzEtg5Xk8Z3K3YDW532i+UbKCjltuOtj/hizjeHjjhDzSp9W08
 niQ4qzEHIbTgctqieXgLVqcQhDsYDtrLIktce2vpUqPAvL1fgKy9EXHVjwoFFL0vE8KY
 Vw32YFbka28Xr/0sugyYhxoxKx5ZK1kLMyu6l0jgwDzJOYYo5ryQNGdxfo3WdmO3QwHl
 RwQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783559108; x=1784163908;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=tKX3lmtmcqSoVZZvZ9yJcRcN8ulpeTGUkeH4I4w9dOc=;
 b=psQ39781NL7dUo8lcmV303O8JXKvHdkb/lKI9Acp06vUyMH32tiO/TaYugmUEBvofJ
 HVRlgvGV0EsZpXO4Ht//qpT7jinEjX5bY6pNVSBTt0snJ9hWTYL8NJyhmb3S19Dlgocz
 tzsyJ2rNjwMiImrJ2Zjc9k0MJsTzT8F7N9alha8fanNLm4ZSTfjrpzN/PIJDwX7cfwhg
 sQrzU4r84pqJXOS8AJqDCS+8RtDagwY2gRAL6JjtBt2nO9qxGnY5BiKygjdQ7LCeuM3e
 aN40yH8NGIdXDvb9gJbMIavG5GkVB1qv+gudwr9GnB8cVhfAWYd7776ARwj61aDv8Zae
 QtjQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rob1FL5s5aUYVehLeYOqEHDcfVT/q67rC5cndWUS3yi+ZLh5YZ4zv+nFHGz5+b2dHD3g4c=@dpdk.org
X-Gm-Message-State: AOJu0YyiSnaBLoFa5fO2oTQx9t1FYG/xJW2ig6Yl8N/uF8g5baXI5HQn
 amT889aWQDX8lR/pmFAGmmJnVDNcMSEBIxSi5tB3CjNZ+ekVE0DHKD8yOAPt1O7CvfoP27RjGQP
 IdflOqKZT9Yqln5QfRmsOui/UYv+j4LE=
X-Gm-Gg: AfdE7cnx2ODIwrXLjeKCI4o5CPv6qujlXNZ81lyIhdtmy9EMJebhE0C9AalLb+2d+Wb
 jccuo7gjpkdb2S5BN+onikZIxMMXWIluCOCV6f+SlEWdX9MsrRmPU+vxbUZqK9BSGS6zXm7M2rY
 QBlwS8AtXXg/mJxPchkMOUv4SP+7+kHhRAFXeMxobxBIn8W9uze6Z0QRrRQ2JlBn4GegA4UsGIY
 MazPuRvT3NBA0KK7jbMtVGk3ZSIxfTuwK+lubg6tj6P/sAIDiRimHS/yGSCfD1b5SL/xvcHPKuR
 UY+TrhhcgxVwjiTUvsjYY5JKjuNY2UgKS2wi+dEIub7Im7BJSrLU4KYTfJCrZhlFFts=
X-Received: by 2002:a05:6000:1a86:b0:46e:47a:dcd3 with SMTP id
 ffacd0b85a97d-47df073326dmr5462943f8f.19.1783559108325; Wed, 08 Jul 2026
 18:05:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260602163647.101815-1-knimoji@iol.unh.edu>
 <20260625154712.2255474-1-knimoji@iol.unh.edu>
 <CAK6DuxvEjRGOQJMY-Amd+QUxQBAV9ihp35fX1PQ2D5p7bt=L8w@mail.gmail.com>
 <CAK6DuxskqPSX-wgxHLOmhd7U=HSYg2js99E7th76LeAY4CBbHA@mail.gmail.com>
In-Reply-To: <CAK6DuxskqPSX-wgxHLOmhd7U=HSYg2js99E7th76LeAY4CBbHA@mail.gmail.com>
From: Patrick Robb <patrickrobb1997@gmail.com>
Date: Wed, 8 Jul 2026 21:04:56 -0400
X-Gm-Features: AUfX_mz7RO7g1YxSsC9sdlNDdyNoSLZIgyp25fjYRIQzc1_XxedI3FEBEMiVUoQ
Message-ID: <CAK6DuxthwOFOdvLgsEoxu+ShXaiKZWc9+RuVXG9czsazuipzTw@mail.gmail.com>
Subject: Re: [PATCH v5] dts: report dut/NIC info during DTS run
To: Koushik Bhargav Nimoji <knimoji@iol.unh.edu>
Cc: luca.vizzarro@arm.com, dev@dpdk.org, abailey@iol.unh.edu, 
 ahassick@iol.unh.edu, lylavoie@iol.unh.edu
Content-Type: multipart/alternative; boundary="0000000000001672d50656233713"
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

--0000000000001672d50656233713
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Actually, please see the AI code review of this patch. Specifically, this
comment looks correct to me. What are your thoughts?

**File:** `dts/framework/testbed_model/linux_session.py`, line 228

The code checks `lshw_result.return_code !=3D 0 and lshw_result.stdout =3D=
=3D ""`
but the logic is incorrect. If the command fails, you should raise an
error. The `and` should likely be `or`:



Please read through the other suggestions too. There is some fluff but also
some good advice.

On Wed, Jul 8, 2026 at 8:57=E2=80=AFPM Patrick Robb <patrickrobb1997@gmail.=
com>
wrote:

> Please make sure you always run checkpatches, check-git-log,
> dts-check-format, and a doc build or each patch you send. I will update t=
he
> commit message before applying. The mailmap issue will go away when your
> other series (with the mailmap addition) is applied.
>
> Thanks for the patch! Applying to next-dts.
>
> ./devtools/check-git-log.sh -n 1
> Wrong headline case:
>                         "dts: report dut and nic info during DTS run": ni=
c
> --> NIC
> Contributor name/email mismatch with .mailmap:
>         Koushik Bhargav Nimoji <knimoji@iol.unh.edu> is unknown in
> .mailmap
>
> Invalid patch(es) found - checked 1 patch
>
> On Tue, Jul 7, 2026 at 9:46=E2=80=AFPM Patrick Robb <patrickrobb1997@gmai=
l.com>
> wrote:
>
>> Tested-by: Patrick Robb <patrickrobb1997@gmail.com>
>>
>

--0000000000001672d50656233713
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Actually, please see the AI code review of this patch. Spe=
cifically, this comment looks correct to me. What are your thoughts?<div><b=
r>**File:** `dts/framework/testbed_model/linux_session.py`, line 228<br><br=
>The code checks `lshw_result.return_code !=3D 0 and lshw_result.stdout =3D=
=3D &quot;&quot;` but the logic is incorrect. If the command fails, you sho=
uld raise an error. The `and` should likely be `or`:</div><div><br><br><br>=
</div><div>Please read through the other suggestions too. There is some flu=
ff but also some good advice.</div></div><br><div class=3D"gmail_quote gmai=
l_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Jul 8, 202=
6 at 8:57=E2=80=AFPM Patrick Robb &lt;<a href=3D"mailto:patrickrobb1997@gma=
il.com">patrickrobb1997@gmail.com</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex"><div dir=3D"ltr">Please make sure you alwa=
ys run checkpatches, check-git-log, dts-check-format, and a doc build or ea=
ch patch you send. I will update the commit=C2=A0message before applying. T=
he mailmap issue will go away when your other series (with the mailmap addi=
tion) is applied.<div><br></div><div>Thanks for the patch! Applying to next=
-dts.<br><div><br></div><div>./devtools/check-git-log.sh -n 1<br>Wrong head=
line case:<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 &quot;dts: report dut and nic info during DTS run&=
quot;: nic --&gt; NIC<br>Contributor name/email mismatch with .mailmap: <br=
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 Koushik Bhargav Nimoji &lt;<a href=3D"mailto:k=
nimoji@iol.unh.edu" target=3D"_blank">knimoji@iol.unh.edu</a>&gt; is unknow=
n in .mailmap<br><br>Invalid patch(es) found - checked 1 patch</div></div><=
/div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">O=
n Tue, Jul 7, 2026 at 9:46=E2=80=AFPM Patrick Robb &lt;<a href=3D"mailto:pa=
trickrobb1997@gmail.com" target=3D"_blank">patrickrobb1997@gmail.com</a>&gt=
; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div di=
r=3D"ltr">Tested-by: Patrick Robb &lt;<a href=3D"mailto:patrickrobb1997@gma=
il.com" target=3D"_blank">patrickrobb1997@gmail.com</a>&gt;</div>
</blockquote></div>
</blockquote></div>

--0000000000001672d50656233713--
