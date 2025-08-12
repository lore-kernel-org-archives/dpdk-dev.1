Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D025ACA0ED1
	for <dpdk-dev@archiver.kernel.org>; Tue, 12 Aug 2025 01:31:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BC71640270;
	Tue, 12 Aug 2025 03:31:51 +0200 (CEST)
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50]) by mails.dpdk.org (Postfix) with ESMTP id 0F3254026C
 for <dev@dpdk.org>; Tue, 12 Aug 2025 03:31:51 +0200 (CEST)
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-3214762071bso6061047a91.3
 for <dev@dpdk.org>; Mon, 11 Aug 2025 18:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1754962310; x=1755567110; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GzcowskhuhU/wnkbj/lbepsnKmxEQY6I0ebJHeC1qYY=;
 b=YcU3G6000IiBDPPgHUv9eYu0zOxx1fEK9yB4xPPJrg8+5AYa5lxA6hCIZtpo7TzmS7
 3ibvRnSphg5p+7WG1E+R61SERCYEb84wc7XVYC3t/cIvDjkDgbKiaZ4b0wZCUrXJtw1R
 3fwgC8+tqCaYMwNgb+s/d6llcG6Np6HYlLeuI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754962310; x=1755567110;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GzcowskhuhU/wnkbj/lbepsnKmxEQY6I0ebJHeC1qYY=;
 b=YYB2DqjsYWZ+ueiT5v2bMyOzGrvS0Ai+SEtrlohOZ//R8derJbOlO2DlH+5dUaC38T
 tmlWDCcga4WmW7VOxN7xLcrk5I8te9X9xgwojlPZBFyRUch2sNxGr9sPM1Vy2Fe9herS
 msIWKEYvkLUGK+uIcaPRe0Zp8GXPsTa7qOlzY38c1YZ/Ud/hYdmiT594zWEVP4CRMHsi
 WaviAhFbrmg5hasrQ2OxrGd5p3nQJYhEeI8SHpKcpak4mHcgp8kBsIYr25bdcLcLsdIb
 M9bXxamCSXNVQr0bwEHr6EvaBesfZKlgrWWF4LKIKzqZ+Fhlw1//JaRmnvq27pdE+Kp3
 c9DQ==
X-Gm-Message-State: AOJu0Yx0X7Ls2tT0Yr6UyoyNjUnu74wvevrPXDc/pjQ1ZqY1RUzo4dk6
 hqel4/v1Qw0J5Fo9rq2BVyZy8S8WzQ8CnME3k1/ozRaQ45cg1j2g1zIuakLwSU/fwuVjI6oo38c
 n9lk4YRVrQv4dL50hg350tahw+smO6r5C23Fntvouzw==
X-Gm-Gg: ASbGncunb3CUsK6vbzZLICUDbuJH1epjb0NpA4kg5/HiOGdgzTRyF97yIAi8fPaEr1N
 LTM8kFoSRegbDChTDCW5s1uz0NeAbhkrdnd1sbJdjBw6TfLzsQhryngCAwfCKUpA7f8Dcjdbyg8
 1qaUzYkhizYPY80hrpjRd1U1I5fj1Sskz8wdyQUnfHkdvrHF3qAoV9fD8kgiUQingmlH/6BWVlP
 7fjBO9khk/igIr/Me0IE1Y=
X-Google-Smtp-Source: AGHT+IE99STMWrIT63U2MUgAcsAKse+OaaO25vxcei/lhsVGCRIcvRjpnibT8LV8ZoJi6VafVnLFB3yf4/JncY2Wt3g=
X-Received: by 2002:a17:90b:43:b0:31e:7410:a4d7 with SMTP id
 98e67ed59e1d1-321c0b022bemr2694837a91.33.1754962309997; Mon, 11 Aug 2025
 18:31:49 -0700 (PDT)
MIME-Version: 1.0
References: <20250725151503.87374-1-luca.vizzarro@arm.com>
 <20250725151503.87374-5-luca.vizzarro@arm.com>
In-Reply-To: <20250725151503.87374-5-luca.vizzarro@arm.com>
From: Patrick Robb <probb@iol.unh.edu>
Date: Mon, 11 Aug 2025 21:25:29 -0400
X-Gm-Features: Ac12FXzICj3P9lkp-ZL4rsn7zNFBP8iT9wkoU5sxEz_uZ47LRgAj_PsLdDeCA1w
Message-ID: <CAJvnSUAvo4NimU9xVVGY10uGhGDcsQQ-gBbW0QfHS3pANf64pQ@mail.gmail.com>
Subject: Re: [PATCH 4/6] dts: add artifact module
To: Luca Vizzarro <luca.vizzarro@arm.com>
Cc: dev@dpdk.org, Paul Szczepanek <paul.szczepanek@arm.com>
Content-Type: multipart/alternative; boundary="00000000000014f838063c2101f7"
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

--00000000000014f838063c2101f7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 25, 2025 at 11:15=E2=80=AFAM Luca Vizzarro <luca.vizzarro@arm.c=
om>
wrote:

>
> +
> +@overload
> +def make_file_path(node: Node, file_name: str, custom_path: PurePath |
> None =3D None) -> PurePath: ...
> +
> +
> +@overload
> +def make_file_path(node: None, file_name: str, custom_path: PurePath |
> None =3D None) -> Path: ...
> +
> +
> +def make_file_path(
> +    node: Node | None, file_name: str, custom_path: PurePath | None =3D =
None
>

Maybe it makes sense to set a default value of None for node? That way
people don't have to pass in None every time they want to make a path on
the DTS engine system.


>
> +    def open(
> +        self, file_mode: BinaryMode | TextMode =3D "rb", buffering: int =
=3D -1
> +    ) -> Union["ArtifactFile", TextIOWrapper]:
> +        """Open the artifact file.
> +
> +        Args:
> +            file_mode: The mode of file opening.
> +            buffering: The size of the buffer to use. If -1, the default
> buffer size is used.
> +
> +        Returns:
> +            An instance of :class:`ArtifactFile` or
> :class:`TextIOWrapper`.
> +        """
> +        if self._fd is not None and not self._fd.closed:
> +            self._logger.warning(
> +                f"Artifact {self.path} is already open. Closing the
> previous file descriptor."
> +            )
> +            self._fd.close()
> +        elif not self._directories_created:
> +            self.mkdir()
> +
> +        # SFTPFile does not support text mode, therefore everything need=
s
> to be handled as binary.
> +        if "t" in file_mode:
> +            actual_mode =3D cast(BinaryMode, cast(str,
> file_mode).replace("t", "") + "b")
>

Is it worth logging this event to prevent confusion? (where we change the
requested mode to binary mode)

+        elif "b" not in file_mode:
> +            actual_mode =3D cast(BinaryMode, file_mode + "b")
>

same


>
> --
> 2.43.0
>
>
Reviewed-by: Patrick Robb <probb@iol.unh.edu>

--00000000000014f838063c2101f7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Jul 25, 2025=
 at 11:15=E2=80=AFAM Luca Vizzarro &lt;<a href=3D"mailto:luca.vizzarro@arm.=
com" target=3D"_blank">luca.vizzarro@arm.com</a>&gt; wrote:<br></div><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1=
px solid rgb(204,204,204);padding-left:1ex"><br>
+<br>
+@overload<br>
+def make_file_path(node: Node, file_name: str, custom_path: PurePath | Non=
e =3D None) -&gt; PurePath: ...<br>
+<br>
+<br>
+@overload<br>
+def make_file_path(node: None, file_name: str, custom_path: PurePath | Non=
e =3D None) -&gt; Path: ...<br>
+<br>
+<br>
+def make_file_path(<br>
+=C2=A0 =C2=A0 node: Node | None, file_name: str, custom_path: PurePath | N=
one =3D None<br></blockquote><div><br></div><div>Maybe it makes sense to se=
t a default value of None for node? That way people don&#39;t have to pass =
in None every time they want to make a path on the DTS engine system.</div>=
<div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><br>
+=C2=A0 =C2=A0 def open(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self, file_mode: BinaryMode | TextMode =3D &qu=
ot;rb&quot;, buffering: int =3D -1<br>
+=C2=A0 =C2=A0 ) -&gt; Union[&quot;ArtifactFile&quot;, TextIOWrapper]:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Open the artifact file.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 file_mode: The mode of file open=
ing.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 buffering: The size of the buffe=
r to use. If -1, the default buffer size is used.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Returns:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 An instance of :class:`ArtifactF=
ile` or :class:`TextIOWrapper`.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if self._fd is not None and not self._fd.close=
d:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._logger.warning(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&quot;Artifact {s=
elf.path} is already open. Closing the previous file descriptor.&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._fd.close()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 elif not self._directories_created:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.mkdir()<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # SFTPFile does not support text mode, therefo=
re everything needs to be handled as binary.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if &quot;t&quot; in file_mode:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 actual_mode =3D cast(BinaryMode,=
 cast(str, file_mode).replace(&quot;t&quot;, &quot;&quot;) + &quot;b&quot;)=
<br></blockquote><div><br></div><div>Is it worth logging this event to prev=
ent confusion? (where we change the requested mode to binary mode)</div><di=
v><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 elif &quot;b&quot; not in file_mode:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 actual_mode =3D cast(BinaryMode,=
 file_mode + &quot;b&quot;)<br></blockquote><div><br></div><div>same</div><=
div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><br>
-- <br>
2.43.0<br>
<br></blockquote><div><br></div><div>Reviewed-by: Patrick Robb &lt;<a href=
=3D"mailto:probb@iol.unh.edu">probb@iol.unh.edu</a>&gt;=C2=A0</div></div></=
div>
</div>

--00000000000014f838063c2101f7--
