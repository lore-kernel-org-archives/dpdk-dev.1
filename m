Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 970EECA0EC4
	for <dpdk-dev@archiver.kernel.org>; Tue, 12 Aug 2025 13:57:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 857E740270;
	Tue, 12 Aug 2025 15:57:04 +0200 (CEST)
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com
 [209.85.215.181])
 by mails.dpdk.org (Postfix) with ESMTP id 15FEA400EF
 for <dev@dpdk.org>; Tue, 12 Aug 2025 15:57:03 +0200 (CEST)
Received: by mail-pg1-f181.google.com with SMTP id
 41be03b00d2f7-b26f7d2c1f1so5845863a12.0
 for <dev@dpdk.org>; Tue, 12 Aug 2025 06:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1755007022; x=1755611822; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=C/giqfV3Pld6KDV1e8yughJX+LIkiOtPKaHGrY8a20k=;
 b=FBbN3HUqQXiZxosiIyIQH/NA0H0yLuQ8wF0c2GC/ioVfVpMoj/5vHM4Jn7xkATfKke
 AREY1NoM+6gMDzDd/7iYM1bQx03SfeeHNtFjctofd2LFGl3mRKziDsChnRP67s9uQGH9
 U1ex2JVfAreb4ox2XC6cR+k+jZt48HQJ8I2xk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755007022; x=1755611822;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=C/giqfV3Pld6KDV1e8yughJX+LIkiOtPKaHGrY8a20k=;
 b=UNi33cxhnNMWDN/X+6kzPrLi0tdRjoirFfUuLEwJysubn9mEXMYRzfdDXZYlYtU2O6
 ffSf906KD4iH+lp0cjanNATII7lCKeslfjwppmnD2CyLg+2Ys34t6vte1i1r/qkV2RsK
 DjCK7jv9xxOfkCIZCUCvrV/OTxiYJFPnDufhZ3olQB6iIW7ALh3GzoHwfbIbt/SPpXnc
 uRd4XGvKVqCSjhZV3NcF7TysyqtIZ6fcKv+88SNTfjBTdQ1rTwaAoUiryy9V0de5Gay1
 s+sm5hXT19D7wHp2N6QVEdLASGWDqMVF3skuW/DvXfQTJBMWivjLZ2z4QJWdKIlbS6Yp
 yjpg==
X-Gm-Message-State: AOJu0YxQsjI6lGOJACLJGOMCzwjlMubV/OhtZ1fIvm8ktjbhuqDUHq/s
 sjy5W3TQQClIjl0LsDvhI1bX0KbKBwdjEpgvYXBXrHhiXquJP66OTZ6y7U7ey05sWcMtWh1rg6B
 aampFr2MJUF7rheZUZIGQl6girlG19Y0QOgyzIZsPGA==
X-Gm-Gg: ASbGncuztTxl5bxYQHTM5Dccf0UyuBb8FwWyWPFMLienWAiC1Li2DfClWPyhsajjVKb
 KoMnNBhRZOzKR1eEgDSAigXzPx8l6z2pnxFhilh45ZLGJRda1c+dyyuBv0A3ILFhIpe4JcaBZ/z
 pHDFiz5nhA3UYe8P8pns6dcvNTo4ppcX3Gfo6P4p34tRDObDNgN5M8ka9EmjFXcUsrFRmgLAaU1
 MsopuE4zVezZwEV4SK3kw==
X-Google-Smtp-Source: AGHT+IFUWOsYzi8kmgviaPET3ou1xtUHHWM406PnQMMUNswc8crZq6Lu4g1W4iSsNSHH6rly5JK+pCsGTscRnu6QUkw=
X-Received: by 2002:a17:902:ea05:b0:240:4fbf:cd29 with SMTP id
 d9443c01a7336-242fc22b3acmr43500775ad.18.1755007021970; Tue, 12 Aug 2025
 06:57:01 -0700 (PDT)
MIME-Version: 1.0
References: <20250725151503.87374-1-luca.vizzarro@arm.com>
 <20250725151503.87374-5-luca.vizzarro@arm.com>
 <CAJvnSUAvo4NimU9xVVGY10uGhGDcsQQ-gBbW0QfHS3pANf64pQ@mail.gmail.com>
 <df1c5f22-4dce-48a1-9152-4e508efd068b@arm.com>
In-Reply-To: <df1c5f22-4dce-48a1-9152-4e508efd068b@arm.com>
From: Patrick Robb <probb@iol.unh.edu>
Date: Tue, 12 Aug 2025 09:50:40 -0400
X-Gm-Features: Ac12FXyrBdQVofrJSfjP8vT1lEoqoVZ8HYxYhAglLZarG36SiZ-ZS4WkiwPC83I
Message-ID: <CAJvnSUA=1tBBjg1QitD09__pGmJuJ428PfkGEoS6VkppofX28A@mail.gmail.com>
Subject: Re: [PATCH 4/6] dts: add artifact module
To: Luca Vizzarro <Luca.Vizzarro@arm.com>
Cc: dev@dpdk.org, Paul Szczepanek <paul.szczepanek@arm.com>
Content-Type: multipart/alternative; boundary="0000000000001f93fc063c2b6ab5"
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

--0000000000001f93fc063c2b6ab5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 12, 2025 at 4:31=E2=80=AFAM Luca Vizzarro <Luca.Vizzarro@arm.co=
m> wrote:

> On 12/08/2025 02:25, Patrick Robb wrote:
> > On Fri, Jul 25, 2025 at 11:15=E2=80=AFAM Luca Vizzarro <luca.vizzarro@a=
rm.com
> > <mailto:luca.vizzarro@arm.com>> wrote:
> >
> >
> >     +
> >     +@overload
> >     +def make_file_path(node: Node, file_name: str, custom_path:
> >     PurePath | None =3D None) -> PurePath: ...
> >     +
> >     +
> >     +@overload
> >     +def make_file_path(node: None, file_name: str, custom_path:
> >     PurePath | None =3D None) -> Path: ...
> >     +
> >     +
> >     +def make_file_path(
> >     +    node: Node | None, file_name: str, custom_path: PurePath | Non=
e
> >     =3D None
> >
> >
> > Maybe it makes sense to set a default value of None for node? That way
> > people don't have to pass in None every time they want to make a path o=
n
> > the DTS engine system.
>
> Even though this function is not private, ideally we don't want this to
> be used outside of the artifact module. But we want the Artifact class
> to be used instead. For this reason the node argument is kept without a
> default to match the behaviour of the Artifact constructor.
>
> Could just make this private.
>

Okay, I was thinking this may be the case. I don't think any change is
needed.


>
> >     +    def open(
> >     +        self, file_mode: BinaryMode | TextMode =3D "rb", buffering=
:
> >     int =3D -1
> >     +    ) -> Union["ArtifactFile", TextIOWrapper]:
> >     +        """Open the artifact file.
> >     +
> >     +        Args:
> >     +            file_mode: The mode of file opening.
> >     +            buffering: The size of the buffer to use. If -1, the
> >     default buffer size is used.
> >     +
> >     +        Returns:
> >     +            An instance of :class:`ArtifactFile`
> >     or :class:`TextIOWrapper`.
> >     +        """
> >     +        if self._fd is not None and not self._fd.closed:
> >     +            self._logger.warning(
> >     +                f"Artifact {self.path} is already open. Closing th=
e
> >     previous file descriptor."
> >     +            )
> >     +            self._fd.close()
> >     +        elif not self._directories_created:
> >     +            self.mkdir()
> >     +
> >     +        # SFTPFile does not support text mode, therefore everythin=
g
> >     needs to be handled as binary.
> >     +        if "t" in file_mode:
> >     +            actual_mode =3D cast(BinaryMode, cast(str,
> >     file_mode).replace("t", "") + "b")
> >
> >
> > Is it worth logging this event to prevent confusion? (where we change
> > the requested mode to binary mode)
> This is an implementation-related internal detail. At a higher level,
> where the user and test writer are interested, the mode is the same as
> specific in `mode`. The only reason why this is happening is because the
> lower level implementation works in binary mode only. Text mode (in
> standard Python too) is just an encoder/decoder wrapper as used here.
> Under the hood all the file operations are done in binary mode.
>
> A user shouldn't be concerned about how it works internally. Quite the
> opposite, introducing logging for this kind of thing will introduce
> confusion. The user should only care about the higher level
> functionality, which is the API.
>
> Please let me know if it's not clear.
>

That's clear. So, this patch looks good to me, thanks Luca.

--0000000000001f93fc063c2b6ab5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Aug 12,=
 2025 at 4:31=E2=80=AFAM Luca Vizzarro &lt;<a href=3D"mailto:Luca.Vizzarro@=
arm.com">Luca.Vizzarro@arm.com</a>&gt; wrote:<br></div><blockquote class=3D=
"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(2=
04,204,204);padding-left:1ex">On 12/08/2025 02:25, Patrick Robb wrote:<br>
&gt; On Fri, Jul 25, 2025 at 11:15=E2=80=AFAM Luca Vizzarro &lt;<a href=3D"=
mailto:luca.vizzarro@arm.com" target=3D"_blank">luca.vizzarro@arm.com</a> <=
br>
&gt; &lt;mailto:<a href=3D"mailto:luca.vizzarro@arm.com" target=3D"_blank">=
luca.vizzarro@arm.com</a>&gt;&gt; wrote:<br>
&gt; <br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+@overload<br>
&gt;=C2=A0 =C2=A0 =C2=A0+def make_file_path(node: Node, file_name: str, cus=
tom_path:<br>
&gt;=C2=A0 =C2=A0 =C2=A0PurePath | None =3D None) -&gt; PurePath: ...<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+@overload<br>
&gt;=C2=A0 =C2=A0 =C2=A0+def make_file_path(node: None, file_name: str, cus=
tom_path:<br>
&gt;=C2=A0 =C2=A0 =C2=A0PurePath | None =3D None) -&gt; Path: ...<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+def make_file_path(<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 node: Node | None, file_name: str, c=
ustom_path: PurePath | None<br>
&gt;=C2=A0 =C2=A0 =C2=A0=3D None<br>
&gt; <br>
&gt; <br>
&gt; Maybe it makes sense to set a default value of None for node? That way=
 <br>
&gt; people don&#39;t have to pass in None every time they want to make a p=
ath on <br>
&gt; the DTS engine system.<br>
<br>
Even though this function is not private, ideally we don&#39;t want this to=
 <br>
be used outside of the artifact module. But we want the Artifact class <br>
to be used instead. For this reason the node argument is kept without a <br=
>
default to match the behaviour of the Artifact constructor.<br>
<br>
Could just make this private.<br></blockquote><div><br></div><div>Okay, I w=
as thinking this may be the case. I don&#39;t think any change is needed.</=
div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 def open(<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self, file_mode: Binar=
yMode | TextMode =3D &quot;rb&quot;, buffering:<br>
&gt;=C2=A0 =C2=A0 =C2=A0int =3D -1<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 ) -&gt; Union[&quot;ArtifactFile&quo=
t;, TextIOWrapper]:<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Open=
 the artifact file.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 file_mod=
e: The mode of file opening.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bufferin=
g: The size of the buffer to use. If -1, the<br>
&gt;=C2=A0 =C2=A0 =C2=A0default buffer size is used.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Returns:<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 An insta=
nce of :class:`ArtifactFile`<br>
&gt;=C2=A0 =C2=A0 =C2=A0or :class:`TextIOWrapper`.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if self._fd is not Non=
e and not self._fd.closed:<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._lo=
gger.warning(<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 f&quot;Artifact {self.path} is already open. Closing the<br>
&gt;=C2=A0 =C2=A0 =C2=A0previous file descriptor.&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._fd=
.close()<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 elif not self._directo=
ries_created:<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.mkd=
ir()<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # SFTPFile does not su=
pport text mode, therefore everything<br>
&gt;=C2=A0 =C2=A0 =C2=A0needs to be handled as binary.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if &quot;t&quot; in fi=
le_mode:<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 actual_m=
ode =3D cast(BinaryMode, cast(str,<br>
&gt;=C2=A0 =C2=A0 =C2=A0file_mode).replace(&quot;t&quot;, &quot;&quot;) + &=
quot;b&quot;)<br>
&gt; <br>
&gt; <br>
&gt; Is it worth logging this event to prevent confusion? (where we change =
<br>
&gt; the requested mode to binary mode)<br>
This is an implementation-related internal detail. At a higher level, <br>
where the user and test writer are interested, the mode is the same as <br>
specific in `mode`. The only reason why this is happening is because the <b=
r>
lower level implementation works in binary mode only. Text mode (in <br>
standard Python too) is just an encoder/decoder wrapper as used here. <br>
Under the hood all the file operations are done in binary mode.<br>
<br>
A user shouldn&#39;t be concerned about how it works internally. Quite the =
<br>
opposite, introducing logging for this kind of thing will introduce <br>
confusion. The user should only care about the higher level <br>
functionality, which is the API.<br>
<br>
Please let me know if it&#39;s not clear.<br></blockquote><div><br></div><d=
iv>That&#39;s clear. So,=C2=A0this patch looks good to me, thanks Luca.=C2=
=A0</div></div></div>

--0000000000001f93fc063c2b6ab5--
