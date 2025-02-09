Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E180C0219B
	for <dpdk-dev@archiver.kernel.org>; Sun,  9 Feb 2025 21:29:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4FDDB402B7;
	Sun,  9 Feb 2025 22:29:56 +0100 (CET)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by mails.dpdk.org (Postfix) with ESMTP id 0413A4021F
 for <dev@dpdk.org>; Sun,  9 Feb 2025 22:29:55 +0100 (CET)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-21f7f1e1194so18069925ad.2
 for <dev@dpdk.org>; Sun, 09 Feb 2025 13:29:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1739136594; x=1739741394; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xC55BwtRei2ZXwuZ6vDG8wRdT9/w9IxTCNPzI09NyPY=;
 b=M1HK47gfKYndPuRa6bb4DXxGtuPqC7Hguf9Ok36VT3z4f8Oz0jrylHlLwNbXp1njIm
 6kQLb1xQVJZglwEOeRPnJ1K4ttcZohGgeSgfg5bqMALcz/OmuBysMfyMyAx1gsxGb40N
 Uv4VDgGf7WCixQW4JD3IleN6N1JqeovNYaBdY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739136594; x=1739741394;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xC55BwtRei2ZXwuZ6vDG8wRdT9/w9IxTCNPzI09NyPY=;
 b=pY5O9SVNe02QypB7UE5ybdUUNZDUYlPmgAhOiDwuwpLDcRlnl9gWnnKe12vm75rZ0K
 uICHgqc/reLk4+bpK21WPRmzIb2F6hDJZFjrv0kz5y80JiG7QNTE54Xd6RSUWxI59CFJ
 gGOrmuhDZbN15LMm6g2vGaoQx6m4uuciGSHHq69Frciw3d4RiRhZTn90HlqNRVOgrfUH
 b0bi11oBL1B7oceFbjtlyZQNyqPDAK2zXInJ6UF7icNsrRzB2WL91A5YrDM0FNRye1wi
 sw94Dt5vyO+b3jl4oTaI/v2lMM3QhTXd6EGwVNeG5dgvaTljbWNiWg/THc5rLA/JPOWc
 UVTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVI16rf8+kbizYq6TmHWXq6alXRgDOa9sZGfqWlBFdOVkZdaxUqcq0jdlJlem4U7b7Ceak=@dpdk.org
X-Gm-Message-State: AOJu0YzBPpzs+q9Hob40HI7lx5Dxvo+AOUQeKuB4+ILCGJMoDRd+pOQ+
 vFwDU3DJEzGauArojZHwKp41BCH+01ImCmbDy5viAs+MikkalaLnS4cqU6Dwfb6veg37qtcFWeq
 QZ9m/LATbFe53JzMdSbznlzZqEsZ0IHqieBd2tEPSFkLe51+rYYM=
X-Gm-Gg: ASbGncvRQdTE/+QYzlS4AoqLCVlinAKIe2dJNn23cM4nJ65CbkifILNd80OnDOxpPVr
 qvkmZ+tySXpmezZzd00TkCn8sICJ/c9MQWNtch/ajpnySyqezCz5qj9DrxwFrU9xAC9B6SyASGT
 fq7W2N/4ARji5IgDk6/uFB1kdkP9dRgQ==
X-Google-Smtp-Source: AGHT+IH8NwECFF+tB4i4IpKKCJopVg9HukxbR1rz1XZ00xbkdmdXOI3yg/tIbaNtQVy3vc9Fr+jYBJ2YEmT8NmiQ9KY=
X-Received: by 2002:a17:902:d491:b0:21f:89e5:2712 with SMTP id
 d9443c01a7336-21f89e52baamr41525165ad.39.1739136593833; Sun, 09 Feb 2025
 13:29:53 -0800 (PST)
MIME-Version: 1.0
References: <20241209205902.18321-2-dmarx@iol.unh.edu>
 <20250130221324.75711-1-dmarx@iol.unh.edu>
In-Reply-To: <20250130221324.75711-1-dmarx@iol.unh.edu>
From: Patrick Robb <probb@iol.unh.edu>
Date: Sun, 9 Feb 2025 16:26:42 -0500
X-Gm-Features: AWEUYZn1TfuMfxEpwkUOzKeMZ9S_RpOzYctIVtQyEgBex7KU0wM4K2drA4KCfWs
Message-ID: <CAJvnSUDic-6rBrPC-YPT3C7J-xVXjAwSGJah-gavNfPaqoTgRw@mail.gmail.com>
Subject: Re: [PATCH v2] dts: add SUT cleanup to framework
To: Dean Marx <dmarx@iol.unh.edu>
Cc: npratte@iol.unh.edu, luca.vizzarro@arm.com, yoan.picchi@foss.arm.com, 
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com, dev@dpdk.org
Content-Type: multipart/alternative; boundary="000000000000e44a0e062dbc4a15"
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

--000000000000e44a0e062dbc4a15
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 30, 2025 at 5:13=E2=80=AFPM Dean Marx <dmarx@iol.unh.edu> wrote=
:

> Add method cleanup_sut to framework that removes a
> DPDK source from a SUT node at the conclusion of a testrun.
> This will only run when the DPDK source is being copied
> from the DTS engine node during the testrun
> (when remote=3Dfalse in the conf.yaml).
>
> Signed-off-by: Dean Marx <dmarx@iol.unh.edu>
> ---
>  dts/framework/runner.py                 |  2 +-
>  dts/framework/testbed_model/sut_node.py | 21 ++++++++++++++++++---
>  2 files changed, 19 insertions(+), 4 deletions(-)
>
> diff --git a/dts/framework/runner.py b/dts/framework/runner.py
> index 9f9789cf49..367034e038 100644
> --- a/dts/framework/runner.py
> +++ b/dts/framework/runner.py
> @@ -336,7 +336,7 @@ def _run_test_run(
>          finally:
>              try:
>                  self._logger.set_stage(DtsStage.test_run_teardown)
> -                sut_node.tear_down_test_run()
> +
> sut_node.tear_down_test_run(test_run_config.dpdk_config.dpdk_location)
>                  tg_node.tear_down_test_run()
>                  test_run_result.update_teardown(Result.PASS)
>              except Exception as e:
> diff --git a/dts/framework/testbed_model/sut_node.py
> b/dts/framework/testbed_model/sut_node.py
> index 483733cede..c73500b146 100644
> --- a/dts/framework/testbed_model/sut_node.py
> +++ b/dts/framework/testbed_model/sut_node.py
> @@ -188,6 +188,19 @@ def path_to_devbind_script(self) -> PurePath | str:
>              )
>          return self._path_to_devbind_script
>
> +    def cleanup_sut(self, dpdk_build_location, remote_tree: str |
> PurePath | None) -> None:
>

I think you have a missing type hint here for the dpdk_build_location arg.
I think it is a LocalDPDKLocation.


> --
> 2.48.1
>
>
While you're at it, you can edit the commit message to replace the
reference to conf.yaml (no longer named this) to the new name or just
"configuration."

Thanks and sorry I missed this on the first look through! Can merge this
asap once you make the edits.

--000000000000e44a0e062dbc4a15
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Jan 30,=
 2025 at 5:13=E2=80=AFPM Dean Marx &lt;<a href=3D"mailto:dmarx@iol.unh.edu"=
>dmarx@iol.unh.edu</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex">Add method cleanup_sut to framework that removes a<br>
DPDK source from a SUT node at the conclusion of a testrun.<br>
This will only run when the DPDK source is being copied<br>
from the DTS engine node during the testrun<br>
(when remote=3Dfalse in the conf.yaml).<br>
<br>
Signed-off-by: Dean Marx &lt;<a href=3D"mailto:dmarx@iol.unh.edu" target=3D=
"_blank">dmarx@iol.unh.edu</a>&gt;<br>
---<br>
=C2=A0dts/framework/runner.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 2 +-<br>
=C2=A0dts/framework/testbed_model/sut_node.py | 21 ++++++++++++++++++---<br=
>
=C2=A02 files changed, 19 insertions(+), 4 deletions(-)<br>
<br>
diff --git a/dts/framework/runner.py b/dts/framework/runner.py<br>
index 9f9789cf49..367034e038 100644<br>
--- a/dts/framework/runner.py<br>
+++ b/dts/framework/runner.py<br>
@@ -336,7 +336,7 @@ def _run_test_run(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0finally:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0try:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self._logger.=
set_stage(DtsStage.test_run_teardown)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sut_node.tear_down=
_test_run()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sut_node.tear_down=
_test_run(test_run_config.dpdk_config.dpdk_location)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tg_node.tear_=
down_test_run()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0test_run_resu=
lt.update_teardown(Result.PASS)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0except Exception as e:<br>
diff --git a/dts/framework/testbed_model/sut_node.py b/dts/framework/testbe=
d_model/sut_node.py<br>
index 483733cede..c73500b146 100644<br>
--- a/dts/framework/testbed_model/sut_node.py<br>
+++ b/dts/framework/testbed_model/sut_node.py<br>
@@ -188,6 +188,19 @@ def path_to_devbind_script(self) -&gt; PurePath | str:=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return self._path_to_devbind_script<br>
<br>
+=C2=A0 =C2=A0 def cleanup_sut(self, dpdk_build_location, remote_tree: str =
| PurePath | None) -&gt; None:<br></blockquote><div><br></div><div>I think =
you have a missing type hint here for the dpdk_build_location arg. I think =
it is a=C2=A0LocalDPDKLocation.</div><div>=C2=A0</div><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(20=
4,204,204);padding-left:1ex">
-- <br>
2.48.1<br>
<br></blockquote><div><br></div><div>While you&#39;re at it, you can edit t=
he commit message to replace the reference to conf.yaml (no longer named th=
is) to the new name or just &quot;configuration.&quot;=C2=A0</div><div><br>=
</div><div>Thanks and sorry I missed this on the first look through! Can me=
rge this asap once you make the edits.</div><div>=C2=A0</div></div></div>

--000000000000e44a0e062dbc4a15--
