Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74BC4606A323
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Nov 2026 15:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=iol.unh.edu header.i=@iol.unh.edu header.a=rsa-sha256 header.s=unh-iol header.b=TXWohHBB
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 02DC440682;
	Thu, 12 Nov 2026 16:48:51 +0100 (CET)
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com
 [209.85.160.173])
 by mails.dpdk.org (Postfix) with ESMTPS id A7E7D4065A
 for <dev@dpdk.org>; Thu, 12 Nov 2026 16:48:49 +0100 (CET)
Received: by mail-qt1-f173.google.com with SMTP id
 d75a77b69052e-53644ab1f7bso35562971cf.3
 for <dev@dpdk.org>; Thu, 12 Nov 2026 07:48:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794498528; cv=none;
 d=google.com; s=arc-20260327;
 b=A/BTR2d0zmkVtQsXSqc7vwCiftz9jnDdtCdG6SjiKbP84UoFRGd4oMTbevXO+/n2xX
 KROa+X1NTlaHhoL0mvfJ5H1hj8r925qIWjt5dlJEHt2xIDnij8uUo64om2DrzaADyRvq
 ga4hDLYBOgpatXcw1zl17v6UTQ/YtiP9TTb3maP+VinarL9y9j05lDoa1BXGx/zTHFB7
 qOZtuU9AQAbBkUuy6aYLCFfIsSRu4nyRJ4kh5heZgB8lVYfDUWkLU9R1tNCVZ98wKvVi
 tp9XgCOrTombkxh+qjm2IMhc/4e3uujeFtSts+0rvBcl3myRuRJ9W1QJ8Swe/Ks/paRG
 fqhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=AkPh52qqTKiDmt93uJtH78YnATNbBt1x3WqF/AXtzX0=;
 fh=JtuNEzyFYXVxEWycLSqS9IjhQsjEDKgmjgSuY5AODZs=;
 b=iZcY2n0M3OuBbON4ZnjliN5f3p2bbMQEq8hpYHmQIrW2LqX+HDtJorv1I7u1BRQRfN
 rolh9AyxJYvDdwe7k5CfbF1nz8RCG/+7NgV+AX9t+4wjNH5m8CSbG8OyHsaTMYe0Jo/N
 sOrKiww2J8tFrFnkWKGoMIAs5EysmGgMHwTOi0eeKILhLEqp34rzfoDLpanyJZ8sbvSk
 NyH2yErHIV93bAX008C7lsj7s2CgcuBJgTZ7Yah4LM/WeCgw5VnsZy7YN57hlFyJNhC5
 GvVJNXN+FXlwxSkqlBruaso0A2uREf9Q5d4g8glZHn2xj42bsxlplfyu/1b7AO1b4uGH
 LfyA==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1794498528; x=1795103328; darn=dpdk.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=AkPh52qqTKiDmt93uJtH78YnATNbBt1x3WqF/AXtzX0=;
 b=TXWohHBBFkpPw4UGq3UhO/RF/j7tvaJvvYZrlSKWXs9qWLSXro+1YaELdd6SaWCDXH
 fH271TW72pVpY0er/bk8gpxhsk2N9JEGLBOT04l0nnj74RDhwyRWLcy+Ndjp93frwqgD
 22MLQwnX3t/qqCTg3h1mnjZZ7U6auHIk31o/I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794498528; x=1795103328;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=AkPh52qqTKiDmt93uJtH78YnATNbBt1x3WqF/AXtzX0=;
 b=RwuIlMaJCrRIReIaU9UMmgc5WBIJeAQ5yJY7eCy9uE65y/5SlhCHtciwfwEe/DTz/Z
 2rh6I3FtJqwdXdJoz67WHelW2coDhTgzQC07/qgLtIVB31eW+mPxlolE3gfjGrrl91NO
 MSbbGhYa7/uhY0xJWFjZANus4gn20Eqg0y7fwbIdrnDmPIOQfrFxImpH7Xx4aMmu6zIN
 BMsis3u2ELVkP7fqAtTVsna356hH2vXIJQk1jafjbE0fPmWCN1Upm+O7rb83IUPyM3bV
 47u4NigS1krorKlBHvnxrzJpb6CU8aBv1ODstLcyeT7FabGjackYzPFGEItsdO5HBGev
 CWlQ==
X-Forwarded-Encrypted: i=1;
 AL+hErHz68YTdqe8+nchylbZNwoqUGPOk8htJZLvcuqXz6vMzXgnN32xaAn4jzBMS5H0BGfpE+E=@dpdk.org
X-Gm-Message-State: APuU4Z+5Ezfnlj5s4bafYzbG91w/BiP7wjXGV+clnXDPhxkc6fJU1T4O
 y20DG28SCJFS2FkpAUyUZsasGXUVeQzLNNRqn+wbsfOi7NMBm/pWPXc7foETdnE4yleGFacdQgg
 j92T0KnJQe6AdLUlRb3fw8PW/KW+NmQgn+B2vPKibMA==
X-Gm-Gg: AYBFou1uVpMZFsg0cbjeLTpuQkk6wRdSNDKonYkdn97hoohbEML7/bocAFb8rMWjhk0
 kLk8b3O0QrjgMm6KWbfRzap3A+KWqIqH3CqHCvh+OL6aqWSso2kTxSvabFbk5StE9JaBEp9pxJ0
 EQc5XQamlalCgzf5RoVJWF0TdbzYu3TsIuArh1PSIABcHTfcJ2riqUG1MFzLJV4XgbJDloRF+HY
 6X+WmYYvf0MXwfxshEZaxT0WcSnU/uJl5MZ8OB7Ek0/MBzMbLavgH/LQxO1Ok9s/wZ2Di2/Q7bd
 qn/FxM339/Ey9/5gYZpcMCTHgs1hMNelMyh9DdZCJiwK7i+Rlgnr37kFEH8VK5ydN82pSXr8Z4k
 wepP9/dF0N53cnMTeNvmbLCvRxgPvX7URZKXsOwOpyPhUFHdNmRfUPIPxGB8IuA2+8w7ztCM4/6
 3uangzns6nCi5oGjgeJOkranxB20Lx/Z/q/mnexeE7fbfvULuwmgiqiCf52X7yKYCX1PxAs5BaR
 nIaUXYFxN2nXThr0+ukEi2hygyu
X-Received: by 2002:a05:622a:5b93:b0:536:5a78:6b14 with SMTP id
 d75a77b69052e-556c0fa32b0mr96969131cf.61.1794498528285; Thu, 12 Nov 2026
 07:48:48 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261008191139.1094155-1-knimoji@iol.unh.edu>
 <20261110201011.1374679-1-knimoji@iol.unh.edu>
 <b6282340-43f0-4b3e-8c54-c6a73ac07fe0@arm.com>
In-Reply-To: <b6282340-43f0-4b3e-8c54-c6a73ac07fe0@arm.com>
From: Koushik Bhargav Nimoji <knimoji@iol.unh.edu>
Date: Thu, 12 Nov 2026 10:48:12 -0500
X-Gm-Features: AclHuK-P98txcvbtNWq2pdpg-mdnGmW_0VlemPnvOZG_dFzLY7GVFJWL-jVjxCY
Message-ID: <CAKYPG+zJhqCFv1Ped2QcNZaS7Bcy=nkDeoxOhtOhEksTSaPapQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] dts: add pvp multi paths vhost performance
 testsuite
To: Luca Vizzarro <Luca.Vizzarro@arm.com>
Cc: patrickrobb1997@gmail.com, dev@dpdk.org, dladd@iol.unh.edu, 
 abailey@iol.unh.edu, lylavoie@iol.unh.edu
Content-Type: multipart/alternative; boundary="0000000000005427f40660163f38"
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--0000000000005427f40660163f38
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 11, 2026 at 11:30=E2=80=AFAM Luca Vizzarro <Luca.Vizzarro@arm.c=
om>
wrote:

> Hey Koushik,
>
> It looks like not all of my comments were addressed, e.g. Artifact.
>

Hi Luca, as I mentioned in the previous email all vhost socket files are
handled by testpmd, ensuring that they are created and deleted properly. I
don't think the use of Artifact will be required here, as it will interfere
with testpmd's handling of the files.


> > +from pydantic import BaseModel, ConfigDict
> > +
> >   from api.params import (
> >       Params,
> >       Switch,
> > @@ -618,3 +620,15 @@ class TestPmdParams(EalParams):
> >       )
> >       record_core_cycles: Switch =3D None
> >       record_burst_status: Switch =3D None
> > +
> > +
> > +class PerfSuiteConfig(BaseModel):
>
> I wouldn't call the TestParameter a PerfSuiteConfig. Also I am not sure
> this is the right place for this? I think it should just live next to
> BaseConfig in api.test_suite. The idea is that PerfSuiteConfig would
> just be the test suite config model, as the name suggests. Instead of
> replicating the model across test suites just to set defaults. These can
> be a constant and then set during test suite setup as it's already done
> with other test suites. We only extend the config if we have extra
> special fields which are unique for said test suite. anything that is
> common across all of them should be kept in a common config.
>
> These changes can be their own commit before the test suites. Updating
> other test suites using the same pattern would also be a welcome change.
>
>
I'm a bit confused by this, do you mean to say that the PerfSuiteConfig is
something that should already hold the default values, but can be
overridden by the specific test parameters in tests_config.yaml? So this
would mean that performance test suites would only need to import this
config for usage so the config declaration in the test suites wouldn't be
necessary.


> > +    """Generic performance test suite parameters."""
> > +
> > +    model_config =3D ConfigDict(strict=3DTrue, extra=3D"forbid",
> frozen=3DFalse, from_attributes=3DTrue)
> > +    frame_size: int
> > +    num_descriptors: int
> > +    expected_mpps: float
> > +    performance_delta: float | None =3D None
> > +    measured_mpps: float | None =3D None
> > +    passing: float | None =3D None
>
> Still lacking documentation for the fields.
>

Will add documentation in my next version, thanks!

--0000000000005427f40660163f38
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Nov 11,=
 2026 at 11:30=E2=80=AFAM Luca Vizzarro &lt;<a href=3D"mailto:Luca.Vizzarro=
@arm.com">Luca.Vizzarro@arm.com</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">Hey Koushik,<br>
<br>
It looks like not all of my comments were addressed, e.g. Artifact.<br></bl=
ockquote><div><br></div><div>Hi Luca, as I mentioned in the previous email =
all vhost socket files are handled by testpmd, ensuring that they are creat=
ed and deleted properly. I don&#39;t=C2=A0think the use of Artifact will be=
 required here, as it will interfere with testpmd&#39;s=C2=A0handling of th=
e files.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">
&gt; +from pydantic import BaseModel, ConfigDict<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0from api.params import (<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0Params,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0Switch,<br>
&gt; @@ -618,3 +620,15 @@ class TestPmdParams(EalParams):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0record_core_cycles: Switch =3D None<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0record_burst_status: Switch =3D None<br>
&gt; +<br>
&gt; +<br>
&gt; +class PerfSuiteConfig(BaseModel):<br>
<br>
I wouldn&#39;t call the TestParameter a PerfSuiteConfig. Also I am not sure=
 <br>
this is the right place for this? I think it should just live next to <br>
BaseConfig in api.test_suite. The idea is that PerfSuiteConfig would <br>
just be the test suite config model, as the name suggests. Instead of <br>
replicating the model across test suites just to set defaults. These can <b=
r>
be a constant and then set during test suite setup as it&#39;s already done=
 <br>
with other test suites. We only extend the config if we have extra <br>
special fields which are unique for said test suite. anything that is <br>
common across all of them should be kept in a common config.<br>
<br>
These changes can be their own commit before the test suites. Updating <br>
other test suites using the same pattern would also be a welcome change.<br=
>
<br></blockquote><div><br></div><div>I&#39;m a bit confused by this, do you=
 mean to say that the PerfSuiteConfig is something that should already hold=
 the default values, but can be overridden=C2=A0by the specific test parame=
ters in tests_config.yaml? So this would mean that performance test suites =
would only need to import this config for usage so the config declaration i=
n the test suites wouldn&#39;t be necessary.=C2=A0</div><div>=C2=A0</div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">
&gt; +=C2=A0 =C2=A0 &quot;&quot;&quot;Generic performance test suite parame=
ters.&quot;&quot;&quot;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 model_config =3D ConfigDict(strict=3DTrue, extra=3D&quo=
t;forbid&quot;, frozen=3DFalse, from_attributes=3DTrue)<br>
&gt; +=C2=A0 =C2=A0 frame_size: int<br>
&gt; +=C2=A0 =C2=A0 num_descriptors: int<br>
&gt; +=C2=A0 =C2=A0 expected_mpps: float<br>
&gt; +=C2=A0 =C2=A0 performance_delta: float | None =3D None<br>
&gt; +=C2=A0 =C2=A0 measured_mpps: float | None =3D None<br>
&gt; +=C2=A0 =C2=A0 passing: float | None =3D None<br>
<br>
Still lacking documentation for the fields.<br></blockquote><div><br></div>=
<div>Will add documentation in my next version, thanks!=C2=A0</div></div></=
div>

--0000000000005427f40660163f38--
