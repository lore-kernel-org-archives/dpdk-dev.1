Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E2E3C43458
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Jun 2026 12:57:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4471540650;
	Tue, 30 Jun 2026 14:57:39 +0200 (CEST)
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com
 [209.85.160.179])
 by mails.dpdk.org (Postfix) with ESMTP id 3C6034026B
 for <dev@dpdk.org>; Tue, 30 Jun 2026 14:57:37 +0200 (CEST)
Received: by mail-qt1-f179.google.com with SMTP id
 d75a77b69052e-51a1fe8f578so47172451cf.2
 for <dev@dpdk.org>; Tue, 30 Jun 2026 05:57:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782824256; cv=none;
 d=google.com; s=arc-20260327;
 b=YTlx9OMi2nA4KXpnn/KE8jR2P5CZPuI1dDFwrPMjKWDd2x0izRHpXFrSidjjcZim3E
 gWYhyZYc4rbAC8YtYlwf1M25dWhc6I9n7LEuZXQAMTqRfIq5Je2IkEQSiDx47uh0KNld
 gRo3n5hDQoxGncFc1XvxcQoKJsKRXxxs66FwAW6QSrqpoLHgqtbGW1hYkGVFTIz3qiGR
 VAlxous8TtcRNPCWD7w0jpWnCinB7JMDcNE5Mcd6WPuYPtpubNzVLQmmY3KrYVCUOO9i
 dZz7ZkU6dQl8od6Mg7fmGq4VYog/8Ccqydk62sftiRiWLLHyk5YljuCAm7JVY1w2SvDx
 yuLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=UCMynAkaCXJ1pgRmSRqXmBqFjh97zMSJ2tYiB2frpXM=;
 fh=7FKIagBHB1mNo8LDA4y0EWWsa7F5gHsL+PA71HbGIg0=;
 b=RPjfkJDCSmiQqkXLffHd0vsK4EliWYm+3woQKp4u1uFCHRHeyiMOLzhKggjDRVT5R2
 +6rZvJfkC84djricNA5iCZbrkEfCCsJX1mtmqLtuYMX/vMb/nFDkRmMTySj8qz6LZs3X
 +VF2mIlP0D85GTbcLYJJmx+Ynhe0EkR/vItJSOfPvPssj3uE+0EhO29vSqkKGREYnBzx
 VkuD8CmrguCgunl06PoVpiWsJ+2XAVjcnqjr4DhFDYgdOk4kdKZy7EkHyQlINwHoLknQ
 hXmOOGx0Vw3clIF0Ad9zfIpJU11kvTsBy011/Eek56wMv7/XUX7kqaLD79XG6WrsQC48
 K3Zg==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1782824256; x=1783429056; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UCMynAkaCXJ1pgRmSRqXmBqFjh97zMSJ2tYiB2frpXM=;
 b=Ln5QmTwNvgUKMPJQpoJe/cYg1GAc1x7+RvwVZP//jmTqO7f2X3qegaeXXKbTx0fPNd
 oQ5cjIzvmSTTo/gYcOYzF65VGkl+U6ImAE9rnQzVXJvOYP5yvYYDtA5JtHYApOzV8PWy
 JZN6iTEtsqUKUHJvNQWfWC1IR+8qfqqzQXv98=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782824256; x=1783429056;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UCMynAkaCXJ1pgRmSRqXmBqFjh97zMSJ2tYiB2frpXM=;
 b=SLb870/TNmKufki9c+masZP86CQ6TMbO8MtXF7y4IUABSTYFKTbWjMSOp/lldeg/Zw
 A0Im+cPtlQQCf4ooHtyC5DLHtl1c+B2fqRSTFIQy/TgHsXS7zbsC9+QgX4Bp7EIf6nHo
 prYoD7RlmWkZ+Jtz/ny4OCASMrbGSuTwZBs1FaR5aQTtVOvfJpT7HEAmOGKsTENTnfHS
 DlKmZEP0eDXC6Y2L83U5TQiMjTC7TDliXYJ5D0rSK8mqDYkVxkWursSqPPeiI5EJSWTu
 DgmPpUS6VLx0CeQCx9FT0oNzQ3NkqfoOUdyxqO6H/bIDYUzJzEjj67ZkzIx3wiHI807P
 1gYg==
X-Forwarded-Encrypted: i=1;
 AFNElJ++nShX9IQ4xL9AEuLAD5PlObNHLyYNkQLJVXcMI2f93xbGB+6rcc5W+idYmWtVNT1hDlM=@dpdk.org
X-Gm-Message-State: AOJu0YxIrOkxB+hpOQQ5I4C1bhVWknTIMch9RMo8LmDlbbVXcu17cXWF
 EtIQvheUvBntBn3gQywcDwnr4E7oRPt1JUN6mjQSyhHwCw9+9CmmlbF5+fuMHcpIRzF4FUWDLPn
 Ro1ksyvT9S8Sk5MNZDmmT83p+4Z2LOJzu49C+ykXoEA==
X-Gm-Gg: AfdE7cntG5HGTwSf54EQE8yOFW4fRgMRmiEkBoAAEsDvSfu6TKJ9QYKbYfcGsZS9qco
 nm5iZcZkwNGGcbdtb/Fp/V4dn1Cv2DJv8s/KMGHyE9iAIwVTaVgKzGubo9BjYmo6p5dbifuhrNm
 VCa172JjM/AdrQKgxEccp0SAt9NoQRFtafc4FggrsFax51aBXt1rwcy3uVsFmsVeX7NVjmSGVt+
 XRZNXTkP6PubuOLiylZqR2CErsf+QImnIheLIZdJV+J5OqaTRzURDnKpBh6jQXXIVKN7nq9O68o
 mVz1c04vALWXl2NZTFY4h/77ygMQSZNsMvaTtXlGu/o/MPgGHtOtSIwrrUZBd9Uo+6Ff7q/62eT
 qcl3TrnKX7h9Gd7q6GCdmscI/ZRku5mAGiJig7AHI+0flu6lOnaXHVy6Fp1c1lw==
X-Received: by 2002:a05:622a:38b:b0:517:89d0:b8d0 with SMTP id
 d75a77b69052e-51c1073f404mr43473611cf.10.1782824256307; Tue, 30 Jun 2026
 05:57:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260609142330.1423729-1-knimoji@iol.unh.edu>
 <20260625172233.2288663-1-knimoji@iol.unh.edu>
 <CAK6Duxvkpxh8XzwvmMaX2y=Am2ePXD092JwX61H5EizDv5f2Gg@mail.gmail.com>
In-Reply-To: <CAK6Duxvkpxh8XzwvmMaX2y=Am2ePXD092JwX61H5EizDv5f2Gg@mail.gmail.com>
From: Koushik Bhargav Nimoji <knimoji@iol.unh.edu>
Date: Tue, 30 Jun 2026 08:57:00 -0400
X-Gm-Features: AVVi8CcTYKN6ODggOSHNseZyz5vdDMAZZS0wNRUB2VToa20g7R6LsLOx9YV34RI
Message-ID: <CAKYPG+yPEA2pH4hv3PHDGkVoc=NggT4+GWrvLg0E3V4JvRLBVA@mail.gmail.com>
Subject: Re: [PATCH v3] dts: update dts check format script and resolve errors
To: Patrick Robb <patrickrobb1997@gmail.com>
Cc: luca.vizzarro@arm.com, dev@dpdk.org, abailey@iol.unh.edu, 
 ahassick@iol.unh.edu, lylavoie@iol.unh.edu
Content-Type: multipart/alternative; boundary="0000000000007e95150655781e4e"
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

--0000000000007e95150655781e4e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 29, 2026 at 6:37=E2=80=AFPM Patrick Robb <patrickrobb1997@gmail=
.com>
wrote:

> In the UNH jenkins repo, please read the jenkinsfile for running the
> dts-check-format script, check which image it is pulling, and check how i=
t
> meets dependencies. I can't remember if the dependencies are met at runti=
me
> or build time, or even if it uses poetry or not. So, there is a risk that
> the checks in CI could continue to run with older dependency versions eve=
n
> after this patch hits main. Let me know if you have questions.
>

According to the check format jenkinsfile in the UNH jenkins repo, the
dependencies are resolved using poetry. As the patch updates the
pyproject.toml and poetry.lock files, the updated tool versions should
reflect in CI as well.


> On Thu, Jun 25, 2026 at 1:22=E2=80=AFPM Koushik Bhargav Nimoji <
> knimoji@iol.unh.edu> wrote:
>
>>
>>
>> +Tar_modes: TypeAlias =3D Literal["w:gz", "w:bz2", "w:xz", "w:tar"]
>> +
>>
>
> Should this be tar_modes (snake case)?
>

Tar_modes is of type TypeAlias, which is a user-defined type. Keeping it
uppercase matches the naming convention for type aliases.


>>  def expand_range(range_str: str) -> list[int]:
>>      """Process `range_str` into a list of integers.
>> @@ -154,7 +156,11 @@ def extension(self) -> str:
>>          For other compression formats, the extension will be in the
>> format
>>          'tar.{compression format}'.
>>          """
>> -        return f"{self.value}" if self =3D=3D self.none else
>> f"{type(self).none.value}.{self.value}"
>> +        return (
>> +            f"{self.value}"
>> +            if self =3D=3D self.none
>> +            else f"{TarCompressionFormat.none.value}.{self.value}"
>> +        )
>>
>>
>>  def convert_to_list_of_string(value: Any | list[Any]) -> list[str]:
>> @@ -207,7 +213,8 @@ def filter_func(tarinfo: tarfile.TarInfo) ->
>> tarfile.TarInfo | None:
>>          return None
>>
>>      target_tarball_path =3D
>> dir_path.with_suffix(f".{compress_format.extension}")
>> -    with tarfile.open(target_tarball_path, f"w:{compress_format.value}"=
)
>> as tar:
>> +    tarball_mode =3D cast(Tar_modes, f"w:{compress_format.value}")
>> +    with tarfile.open(target_tarball_path, tarball_mode) as tar:
>>
>
> Have you completed a testrun which flexes create_tarball(), i.e. running =
a
> DTS testrun which copies over a normal DPDK dir (instead of defining a
> tarball in test_run.yaml you define a normal dpdk dir source) to the SUT,
> i.e. it actually has to create the tarball?
>
>
>>          tar.add(dir_path, arcname=3Ddir_path.name,
>> filter=3Dcreate_filter_function(exclude))
>>
>>
I have tested create_tarball(), with DTS copying over a dpdk tree from the
DTS host. The dpdk tree was properly compressed into a tarball, copied over
to the SUT node, and unpacked on the SUT node before continuing DTS
execution.

--0000000000007e95150655781e4e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><span style=3D"background-color:transpare=
nt"><br></span></div><div dir=3D"ltr"><span style=3D"background-color:trans=
parent"><br></span></div><div dir=3D"ltr"><span style=3D"background-color:t=
ransparent">On Mon, Jun 29, 2026 at 6:37=E2=80=AFPM Patrick Robb &lt;<a hre=
f=3D"mailto:patrickrobb1997@gmail.com">patrickrobb1997@gmail.com</a>&gt; wr=
ote:</span></div><div class=3D"gmail_quote gmail_quote_container"><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div>In the UNH j=
enkins repo, please read the jenkinsfile for running the dts-check-format s=
cript, check which image it is pulling, and check how it meets dependencies=
. I can&#39;t remember if the dependencies are met at runtime or build time=
, or even if it uses poetry or not. So, there is a risk that the checks in =
CI could continue to run with older dependency versions even after this pat=
ch hits main. Let me know if you have questions.</div></div></blockquote><d=
iv>=C2=A0</div><div>According to the check format jenkinsfile in the UNH je=
nkins repo, the dependencies are resolved using poetry. As the patch update=
s the pyproject.toml and=C2=A0poetry.lock files, the updated tool versions =
should reflect in CI as well.</div><div>=C2=A0</div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex"><div dir=3D"ltr"><div class=3D"gmail_quote"><div=
 dir=3D"ltr" class=3D"gmail_attr">On Thu, Jun 25, 2026 at 1:22=E2=80=AFPM K=
oushik Bhargav Nimoji &lt;<a href=3D"mailto:knimoji@iol.unh.edu" target=3D"=
_blank">knimoji@iol.unh.edu</a>&gt; wrote:<br></div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex"><br>
<br>
+Tar_modes: TypeAlias =3D Literal[&quot;w:gz&quot;, &quot;w:bz2&quot;, &quo=
t;w:xz&quot;, &quot;w:tar&quot;]<br>
+<br></blockquote><div><br></div><div>Should this be tar_modes (snake case)=
?<span style=3D"background-color:transparent">=C2=A0</span></div></div></di=
v></blockquote><div>=C2=A0</div><div>Tar_modes is of type TypeAlias, which =
is a user-defined type. Keeping it uppercase matches the naming convention =
for type aliases.</div><div><br></div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex"><div dir=3D"ltr"><div class=3D"gmail_quote"><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
<br>
=C2=A0def expand_range(range_str: str) -&gt; list[int]:<br>
=C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Process `range_str` into a list of in=
tegers.<br>
@@ -154,7 +156,11 @@ def extension(self) -&gt; str:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0For other compression formats, the extens=
ion will be in the format<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;tar.{compression format}&#39;.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return f&quot;{self.value}&quot; if self =3D=
=3D self.none else f&quot;{type(self).none.value}.{self.value}&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return (<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&quot;{self.value}&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if self =3D=3D self.none<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else f&quot;{TarCompressionForma=
t.none.value}.{self.value}&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
<br>
<br>
=C2=A0def convert_to_list_of_string(value: Any | list[Any]) -&gt; list[str]=
:<br>
@@ -207,7 +213,8 @@ def filter_func(tarinfo: tarfile.TarInfo) -&gt; tarfile=
.TarInfo | None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return None<br>
<br>
=C2=A0 =C2=A0 =C2=A0target_tarball_path =3D dir_path.with_suffix(f&quot;.{c=
ompress_format.extension}&quot;)<br>
-=C2=A0 =C2=A0 with tarfile.open(target_tarball_path, f&quot;w:{compress_fo=
rmat.value}&quot;) as tar:<br>
+=C2=A0 =C2=A0 tarball_mode =3D cast(Tar_modes, f&quot;w:{compress_format.v=
alue}&quot;)<br>
+=C2=A0 =C2=A0 with tarfile.open(target_tarball_path, tarball_mode) as tar:=
<br></blockquote><div><br></div><div>Have you completed a testrun which fle=
xes create_tarball(), i.e. running a DTS testrun which copies over a normal=
 DPDK dir (instead of defining a tarball in test_run.yaml you define a norm=
al dpdk dir source) to the SUT, i.e. it actually has to create the tarball?=
</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tar.add(dir_path, arcname=3D<a href=3D"ht=
tp://dir_path.name" rel=3D"noreferrer" target=3D"_blank">dir_path.name</a>,=
 filter=3Dcreate_filter_function(exclude))<br><br></blockquote></div></div>=
</blockquote><div>=C2=A0</div><div><span style=3D"background-color:transpar=
ent">I have tested create_tarball(), with DTS copying over a dpdk tree from=
 the DTS host. The dpdk tree was properly compressed into a tarball, copied=
 over to the SUT node, and unpacked on the SUT node before continuing DTS e=
xecution.</span></div></div></div>

--0000000000007e95150655781e4e--
