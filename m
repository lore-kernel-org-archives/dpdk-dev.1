Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48FB8C87FD3
	for <dpdk-dev@archiver.kernel.org>; Wed,  6 Aug 2025 13:46:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2EE3B402AB;
	Wed,  6 Aug 2025 15:46:42 +0200 (CEST)
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com
 [209.85.210.174])
 by mails.dpdk.org (Postfix) with ESMTP id EF82940291
 for <dev@dpdk.org>; Wed,  6 Aug 2025 15:46:40 +0200 (CEST)
Received: by mail-pf1-f174.google.com with SMTP id
 d2e1a72fcca58-76bee58e01cso5224312b3a.1
 for <dev@dpdk.org>; Wed, 06 Aug 2025 06:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1754488000; x=1755092800; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VbBbdmOQ0rbIv7f8qL9RV8v+OqGPHGTw2A4X4nHR15M=;
 b=KuZB8/ioXHYVg/asVXbd4BAnsOmGbm8NOATwEmFPJ8pSSY3rwu57LRaoSB2ZU/3KJW
 U2IxAz8y+6UO6M7fwkFp1Zo+1ndM+Q9zomw6g9qlB/0KX/ef5zh+oU3ezoOuHbJImqC+
 XWopc4i0pRAMmcXjO/gmJPJ+DJ2SXG9MncfkE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754488000; x=1755092800;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VbBbdmOQ0rbIv7f8qL9RV8v+OqGPHGTw2A4X4nHR15M=;
 b=E2sO/vo5rT3f5A8UuhL4mEOe12TL/MvsqWSNoCXqnkxbbrFQ8rOwxVMVmBxrX37iJa
 GJ4lFYpRhP6n/4aR+gXT7KhotG1nk+q3NWN6nF/2bGi5UGyKlifsluM2l4C3my67z2i8
 mCj5RehD9tOdL8IQePzIWXqKMVuv7injmA9vh9iED2kxKDsKDIkEIadlmZFxZF4WhoRj
 N+JKYo4a7CHgUErppc+qn418PdbngfCJHe07Dlb3FYW9Pxgy3ZSHR7o56cZ9vdki/nld
 CemXnTtR8HbGiuAg78qe0cEEG7RuPtVd9vkKCBB9nFqyv+qSHxY/CVPq8bBH5xFVYiwy
 23lQ==
X-Gm-Message-State: AOJu0Yz94DsCPOkGl3GMm8YKPwhvKSGK3LkLbxTxhFQoEZOSfpIzx36H
 Lmta06gtPeWjVZxAZvRI77g0In69DCarIt52CXjL9aW3TIYar14nP1BmgLzcfZiTpwOe/5BbbUc
 K2ajWNwyUafBFFehpIZs510eLeuzaewjcGhZJ8dVfK3lIw+PXd+lI
X-Gm-Gg: ASbGnctoDR+49Q2DDXB8+NO/rbKA+zspvSP0kUCFoB0P09WdSILl1l3JPvN5GfxgYYm
 NPwSxPMOD94xZM/TLpBknzAF7p3K7qPh8HykU+Xx6A3QQ5CdPAYdtGyQ3ubOMUhNyJjk/hS9s/E
 U2ps3tgqukPeI0Fn5JZlpYXePTJMxNPOhEZT8U5LIURuAc9HWaF2bvLriDEZWkPEuzTBHyIJlJg
 5AU/JuKkLcVRCag+zJCqEb6L3T2rtvt2/vcIc2KA2ZRws/38Io=
X-Google-Smtp-Source: AGHT+IE0ymn/S8WbLtR1pyjSIBVqTxs2EWId90qvKgH7XzGWXb0adEz4THuKi8BL3cBepgE9kaJREwYdcBq0Id279Mw=
X-Received: by 2002:a17:903:4b08:b0:240:1850:cb18 with SMTP id
 d9443c01a7336-242a0bc8ef7mr27641385ad.53.1754487999938; Wed, 06 Aug 2025
 06:46:39 -0700 (PDT)
MIME-Version: 1.0
References: <20250801114547.1128950-1-luca.vizzarro@arm.com>
In-Reply-To: <20250801114547.1128950-1-luca.vizzarro@arm.com>
From: Patrick Robb <probb@iol.unh.edu>
Date: Wed, 6 Aug 2025 09:40:26 -0400
X-Gm-Features: Ac12FXzP7WjJctSI7DBHWOu7ksRDxIC57GixGOYZ9XrZy6VRAYcJgPypsjNQhw4
Message-ID: <CAJvnSUAiijC7bzEmRD50BDPz65DbPVnRLXegMCH-iJHpZfZZww@mail.gmail.com>
Subject: Re: [PATCH] dts: remove optional docs dependencies
To: Luca Vizzarro <luca.vizzarro@arm.com>
Cc: dev@dpdk.org
Content-Type: multipart/alternative; boundary="000000000000ffdc7f063bb29110"
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

--000000000000ffdc7f063bb29110
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks. Confirming for the mailing list that we discussed this at the DTS
meeting last week and agreed on this course of action.

Reviewed-by: Patrick Robb <probb@iol.unh.edu>

On Fri, Aug 1, 2025 at 7:45=E2=80=AFAM Luca Vizzarro <luca.vizzarro@arm.com=
> wrote:

> The CI currently does not support the optional DTS docs dependencies. As
> a consequence, all of the public docs are always built and deployed witho=
ut
> them.
>
> To simplify the maintenance process, remove the optional docs dependencie=
s
> and abandon support.
>
> Signed-off-by: Luca Vizzarro <luca.vizzarro@arm.com>
> ---
>  doc/guides/conf.py       | 7 -------
>  doc/guides/tools/dts.rst | 5 -----
>  dts/pyproject.toml       | 9 ---------
>  3 files changed, 21 deletions(-)
>
> diff --git a/doc/guides/conf.py b/doc/guides/conf.py
> index 4b1059c202..2c1aa81bbf 100644
> --- a/doc/guides/conf.py
> +++ b/doc/guides/conf.py
> @@ -65,13 +65,6 @@
>          graphviz_output_format =3D "svg"
>          tags.add("graphviz")
>
> -    # Pydantic models require autodoc_pydantic for the right formatting.
> Add if installed.
> -    try:
> -        import sphinxcontrib.autodoc_pydantic
> -        extensions.append("sphinxcontrib.autodoc_pydantic")
> -    except ImportError:
> -        pass
> -
>      # Napoleon enables the Google format of Python doscstrings.
>      napoleon_numpy_docstring =3D False
>      napoleon_attr_annotations =3D True
> diff --git a/doc/guides/tools/dts.rst b/doc/guides/tools/dts.rst
> index 78761dc49e..3837b398cf 100644
> --- a/doc/guides/tools/dts.rst
> +++ b/doc/guides/tools/dts.rst
> @@ -491,11 +491,6 @@ Building DTS API docs
>  The documentation is built using the standard DPDK build system.
>  See :doc:`../linux_gsg/build_dpdk` for more details on compiling DPDK
> with meson.
>
> -.. code-block:: console
> -
> -   poetry install --only docs
> -   poetry install --with docs  # an alternative that will also install
> DTS dependencies
> -
>  After executing the meson command, build the documentation with:
>
>  .. code-block:: console
> diff --git a/dts/pyproject.toml b/dts/pyproject.toml
> index 8df0a894dc..8b061c3cee 100644
> --- a/dts/pyproject.toml
> +++ b/dts/pyproject.toml
> @@ -35,15 +35,6 @@ types-paramiko =3D "^3.5.0.20240928"
>  types-invoke =3D "^2.0.0.10"
>  types-pyyaml =3D "^6.0.12.20240917"
>
> -[tool.poetry.group.docs]
> -optional =3D true
> -
> -[tool.poetry.group.docs.dependencies]
> -sphinx =3D "<=3D7"
> -sphinx-rtd-theme =3D ">=3D1.2.2"
> -pyelftools =3D "^0.31"
> -autodoc-pydantic =3D "^2.2.0"
> -
>  [build-system]
>  requires =3D ["poetry-core>=3D1.0.0"]
>  build-backend =3D "poetry.core.masonry.api"
> --
> 2.43.0
>
>

--000000000000ffdc7f063bb29110
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thanks. Confirming for the mailing list that we discussed =
this at the DTS meeting last week and agreed on this course of action.<div>=
<br></div><div>Reviewed-by: Patrick Robb &lt;<a href=3D"mailto:probb@iol.un=
h.edu">probb@iol.unh.edu</a>&gt;</div></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Aug 1, =
2025 at 7:45=E2=80=AFAM Luca Vizzarro &lt;<a href=3D"mailto:luca.vizzarro@a=
rm.com">luca.vizzarro@arm.com</a>&gt; wrote:<br></div><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(20=
4,204,204);padding-left:1ex">The CI currently does not support the optional=
 DTS docs dependencies. As<br>
a consequence, all of the public docs are always built and deployed without=
<br>
them.<br>
<br>
To simplify the maintenance process, remove the optional docs dependencies<=
br>
and abandon support.<br>
<br>
Signed-off-by: Luca Vizzarro &lt;<a href=3D"mailto:luca.vizzarro@arm.com" t=
arget=3D"_blank">luca.vizzarro@arm.com</a>&gt;<br>
---<br>
=C2=A0doc/guides/conf.py=C2=A0 =C2=A0 =C2=A0 =C2=A0| 7 -------<br>
=C2=A0doc/guides/tools/dts.rst | 5 -----<br>
=C2=A0dts/pyproject.toml=C2=A0 =C2=A0 =C2=A0 =C2=A0| 9 ---------<br>
=C2=A03 files changed, 21 deletions(-)<br>
<br>
diff --git a/doc/guides/conf.py b/doc/guides/conf.py<br>
index 4b1059c202..2c1aa81bbf 100644<br>
--- a/doc/guides/conf.py<br>
+++ b/doc/guides/conf.py<br>
@@ -65,13 +65,6 @@<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0graphviz_output_format =3D &quot;svg&quot=
;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tags.add(&quot;graphviz&quot;)<br>
<br>
-=C2=A0 =C2=A0 # Pydantic models require autodoc_pydantic for the right for=
matting. Add if installed.<br>
-=C2=A0 =C2=A0 try:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 import sphinxcontrib.autodoc_pydantic<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 extensions.append(&quot;sphinxcontrib.autodoc_=
pydantic&quot;)<br>
-=C2=A0 =C2=A0 except ImportError:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 pass<br>
-<br>
=C2=A0 =C2=A0 =C2=A0# Napoleon enables the Google format of Python doscstri=
ngs.<br>
=C2=A0 =C2=A0 =C2=A0napoleon_numpy_docstring =3D False<br>
=C2=A0 =C2=A0 =C2=A0napoleon_attr_annotations =3D True<br>
diff --git a/doc/guides/tools/dts.rst b/doc/guides/tools/dts.rst<br>
index 78761dc49e..3837b398cf 100644<br>
--- a/doc/guides/tools/dts.rst<br>
+++ b/doc/guides/tools/dts.rst<br>
@@ -491,11 +491,6 @@ Building DTS API docs<br>
=C2=A0The documentation is built using the standard DPDK build system.<br>
=C2=A0See :doc:`../linux_gsg/build_dpdk` for more details on compiling DPDK=
 with meson.<br>
<br>
-.. code-block:: console<br>
-<br>
-=C2=A0 =C2=A0poetry install --only docs<br>
-=C2=A0 =C2=A0poetry install --with docs=C2=A0 # an alternative that will a=
lso install DTS dependencies<br>
-<br>
=C2=A0After executing the meson command, build the documentation with:<br>
<br>
=C2=A0.. code-block:: console<br>
diff --git a/dts/pyproject.toml b/dts/pyproject.toml<br>
index 8df0a894dc..8b061c3cee 100644<br>
--- a/dts/pyproject.toml<br>
+++ b/dts/pyproject.toml<br>
@@ -35,15 +35,6 @@ types-paramiko =3D &quot;^3.5.0.20240928&quot;<br>
=C2=A0types-invoke =3D &quot;^2.0.0.10&quot;<br>
=C2=A0types-pyyaml =3D &quot;^6.0.12.20240917&quot;<br>
<br>
-[tool.poetry.group.docs]<br>
-optional =3D true<br>
-<br>
-[tool.poetry.group.docs.dependencies]<br>
-sphinx =3D &quot;&lt;=3D7&quot;<br>
-sphinx-rtd-theme =3D &quot;&gt;=3D1.2.2&quot;<br>
-pyelftools =3D &quot;^0.31&quot;<br>
-autodoc-pydantic =3D &quot;^2.2.0&quot;<br>
-<br>
=C2=A0[build-system]<br>
=C2=A0requires =3D [&quot;poetry-core&gt;=3D1.0.0&quot;]<br>
=C2=A0build-backend =3D &quot;poetry.core.masonry.api&quot;<br>
-- <br>
2.43.0<br>
<br>
</blockquote></div>

--000000000000ffdc7f063bb29110--
