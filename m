Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE136C71135
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Jun 2025 03:26:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2B33040292;
	Mon, 16 Jun 2025 05:26:30 +0200 (CEST)
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com
 [209.85.216.52]) by mails.dpdk.org (Postfix) with ESMTP id F36774027A
 for <dev@dpdk.org>; Mon, 16 Jun 2025 05:26:26 +0200 (CEST)
Received: by mail-pj1-f52.google.com with SMTP id
 98e67ed59e1d1-312116d75a6so3370957a91.3
 for <dev@dpdk.org>; Sun, 15 Jun 2025 20:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1750044386; x=1750649186; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wXL2HpEXJthF8pYP+tYjTzFyg+SKUqk83rGUasRAYp0=;
 b=bWyyb85f0xSLnH4fqL60REnSCnPpROwBBee3G8pCWTMLqvwxBrmeSfRrnrRXH7YL3P
 MKLOtJ+ibhu2L5Tg4amE4cYKrWfvjKY4ngUBSfQKF4n79Y6vbX6RvodEWb+dTvvtVcxk
 i6n6XGFYBHLvVbzpg3vJxr6Zme5Z4kchx1Rcs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750044386; x=1750649186;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wXL2HpEXJthF8pYP+tYjTzFyg+SKUqk83rGUasRAYp0=;
 b=vxv/5i8vdPFgp4Joa5tvWY3phztiuFGDTqmiQVg03bl8k+e9Q8pB89GkEaCqcFOefv
 2kDc7c6Kmf2LyXST7d+ukmF2ajiGisl4muN2qAx18lVWipuoRIHl0JmW1h2GwG2zvftE
 n4eoojTIrQZqHz8LDJJZXbAE6hjrvoaZ8+J7vJ5TgUmklJIJFhD+hY6/IBnzoRqUetX1
 eoMkJsYOiksT6BE0c/t2ScE1vWIrBMKg9L400zVOEaQqILlz17bn8dj2enZDx5er5785
 5Yb2gBdWwUIJOCzWffbOIE3ISJ0B1qBp0dUznHP16CBJWGe3wPMH/CvYQIBZ39f5KYBZ
 U2IQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXdIKvVyP1kKqjRCZf2Xk/G01MM+htOmlK5SYtLrvOW/MQhz18YnD8TIpATfwKwFNUOgUU=@dpdk.org
X-Gm-Message-State: AOJu0YwdZmGhQFQhq9+O3poqs/3PeAXOCgkF2eTmUlBgYklHRI9vRc9+
 cwf1G+oStM8qQ40mcuEmclY2o5CP90kuZJ/Bfg02owlypwQqd38mFC1dy7Jqyad6TdTQRmO5Bg0
 C9NTOKTd7HSNz+Lb0n9RhNEOJoqc27mfvnAvZwd5ZqQQg0/ZFiVWEWdA=
X-Gm-Gg: ASbGncv/U2tIh9HHCAghFTzW2DiWWaHE4Xa/XP8HtQxlppG1F5Y/vYMP4SUP9kzZtHj
 81nAZ8eCg3PMSIYI+9FKKdWvqPg27b6uJ24Uzz6G8WON4xRiZMX6M4UKjHdpcn+/ow81SueKvgB
 CS3uGfkfpO7aUfpuuobaaYiJZcDAk4fMPzJfBW+N3KW5OUtkX00Ab4cDOUXiE=
X-Google-Smtp-Source: AGHT+IEhSiD2YBkmWEjM/VCzv0l9aB4le6EOJf5QMqN1Esl9gRpUKpm4Q+3/nyb/XqSRJTmWY2dwGsYZIITbH8ZSkHY=
X-Received: by 2002:a17:90b:39cb:b0:313:bdbf:36c0 with SMTP id
 98e67ed59e1d1-313f1b37d43mr14861275a91.0.1750044385796; Sun, 15 Jun 2025
 20:26:25 -0700 (PDT)
MIME-Version: 1.0
References: <20250612201220.614724-1-dmarx@iol.unh.edu>
In-Reply-To: <20250612201220.614724-1-dmarx@iol.unh.edu>
From: Patrick Robb <probb@iol.unh.edu>
Date: Sun, 15 Jun 2025 23:21:12 -0400
X-Gm-Features: AX0GCFvpdbCipgtvDd50cHSJvEe25rE_XlpoXyQ6sozp3ty0D-RkRamHf9hYgjo
Message-ID: <CAJvnSUC3U2rUPfa0wAcUtTcwPdidcX=qgRpQf=k3ORBKCB0_vw@mail.gmail.com>
Subject: Re: [PATCH v1] dts: fix devbind initialization bug
To: Dean Marx <dmarx@iol.unh.edu>
Cc: luca.vizzarro@arm.com, yoan.picchi@foss.arm.com, 
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com, dev@dpdk.org
Content-Type: multipart/alternative; boundary="000000000000f4f5340637a7f554"
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

--000000000000f4f5340637a7f554
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 12, 2025 at 4:12=E2=80=AFPM Dean Marx <dmarx@iol.unh.edu> wrote=
:

> Rearrange the topology and DPDK setup/teardown calls during
> test runs to ensure the devbind script is not called
> while the DPDK tmp directory doesn't exist.
>
> Fixes: 4cef16f1f0a4 ("dts: improve port handling")
>
> Signed-off-by: Dean Marx <dmarx@iol.unh.edu>
> ---
>  dts/framework/test_run.py | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/dts/framework/test_run.py b/dts/framework/test_run.py
> index cff0085317..4287028b4b 100644
> --- a/dts/framework/test_run.py
> +++ b/dts/framework/test_run.py
> @@ -344,8 +344,8 @@ def next(self) -> State | None:
>
>          test_run.ctx.sut_node.setup()
>          test_run.ctx.tg_node.setup()
> -        test_run.ctx.topology.setup()
>          test_run.ctx.dpdk.setup()
> +        test_run.ctx.topology.setup()
>          test_run.ctx.tg.setup(test_run.ctx.topology)
>
>          self.result.ports =3D test_run.ctx.topology.sut_ports +
> test_run.ctx.topology.tg_ports
> @@ -433,8 +433,8 @@ def next(self) -> State | None:
>          """Next state."""
>          self.test_run.ctx.shell_pool.terminate_current_pool()
>          self.test_run.ctx.tg.teardown()
> -        self.test_run.ctx.dpdk.teardown()
>          self.test_run.ctx.topology.teardown()
> +        self.test_run.ctx.dpdk.teardown()
>          self.test_run.ctx.tg_node.teardown()
>          self.test_run.ctx.sut_node.teardown()
>          self.result.update_teardown(Result.PASS)
> --
> 2.49.0
>
>
Thanks this makes sense in principle but I think there is an additional
issue, which I saw when I just tested your patch on 2 XL710 NICs connected
both on the Braum server.

Here is the execution order from the testrun

1. testrun init creates DPDKRuntimeEnvironment with _node=3Dsutnote like:

dpdk_runtime_env =3D DPDKRuntimeEnvironment(config.dpdk, sut_node,
dpdk_build_env)

which is then added to ctx.

2. TestRunSetup calls test_run.ctx.dpdk.setup() which
calls _prepare_devbind_script() which adds the devbind_script_path to
_node.main_session, but _node in this case is the sut node. I don't believe
there is the code path for adding devbind_script_path to the tg node
main_session, so later at topology.setup() we call self._setup_ports("sut")
which runs fine, and then error on self._setup_ports("tg") because again
the tg node main session is lacking the devbind_script_path attribute. I
think you will need to address this second part for your patch to be
complete. In any case, let's chat in the morning and figure out what a v2
of this bugfix can be.

See this stacktrace:

2025/06/16 02:59:03 - test_run_setup - dts.braum-intel-40g-SUT - INFO -
Sending: 'lshw -quiet -json -C network'
2025/06/16 02:59:04 - test_run_setup - dts.braum-intel-40g-TG - INFO -
Sending: 'lshw -quiet -json -C network'
2025/06/16 02:59:05 - test_run_setup - dts - ERROR - A CRITICAL ERROR has
occurred during test run setup. Unrecoverable state reached, shutting down.
2025/06/16 02:59:05 - test_run_setup - dts - ERROR - An unexpected error
has occurred.
Traceback (most recent call last):
  File "/dpdk/dts/framework/runner.py", line 81, in run
    test_run.spin()
  File "/dpdk/dts/framework/test_run.py", line 242, in spin
    next_state =3D self.state.handle_exception(e)
                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/dpdk/dts/framework/test_run.py", line 240, in spin
    next_state =3D self.state.next()
                 ^^^^^^^^^^^^^^^^^
  File "/dpdk/dts/framework/test_run.py", line 348, in next
    test_run.ctx.topology.setup()
  File "/dpdk/dts/framework/testbed_model/topology.py", line 130, in setup
    self._setup_ports("tg")
  File "/dpdk/dts/framework/testbed_model/topology.py", line 154, in
_setup_ports
    self._bind_ports_to_drivers(node, ports, "kernel")
  File "/dpdk/dts/framework/testbed_model/topology.py", line 205, in
_bind_ports_to_drivers
    node.main_session.bind_ports_to_driver(ports, driver_name)
  File "/dpdk/dts/framework/testbed_model/linux_session.py", line 187, in
bind_ports_to_driver
    f"{self.devbind_script_path} -b {driver_name} --force
{ports_pci_addrs}",
       ^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/lib/python3.12/functools.py", line 995, in __get__
    val =3D self.func(instance)
          ^^^^^^^^^^^^^^^^^^^
  File "/dpdk/dts/framework/testbed_model/linux_session.py", line 212, in
devbind_script_path
    raise InternalError("Accessed devbind script path before setup.")
framework.exception.InternalError: Accessed devbind script path before
setup.
2025/06/16 02:59:05 - test_run_setup - dts - INFO - Moving from stage
'test_run_setup' to stage 'post_run'.
2025/06/16 02:59:05 - post_run - dts - INFO - DTS execution has ended.

--000000000000f4f5340637a7f554
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Jun 12,=
 2025 at 4:12=E2=80=AFPM Dean Marx &lt;<a href=3D"mailto:dmarx@iol.unh.edu"=
>dmarx@iol.unh.edu</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex">Rearrange the topology and DPDK setup/teardown calls duri=
ng<br>
test runs to ensure the devbind script is not called<br>
while the DPDK tmp directory doesn&#39;t exist.<br>
<br>
Fixes: 4cef16f1f0a4 (&quot;dts: improve port handling&quot;)<br>
<br>
Signed-off-by: Dean Marx &lt;<a href=3D"mailto:dmarx@iol.unh.edu" target=3D=
"_blank">dmarx@iol.unh.edu</a>&gt;<br>
---<br>
=C2=A0dts/framework/test_run.py | 4 ++--<br>
=C2=A01 file changed, 2 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/dts/framework/test_run.py b/dts/framework/test_run.py<br>
index cff0085317..4287028b4b 100644<br>
--- a/dts/framework/test_run.py<br>
+++ b/dts/framework/test_run.py<br>
@@ -344,8 +344,8 @@ def next(self) -&gt; State | None:<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0test_run.ctx.sut_node.setup()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0test_run.ctx.tg_node.setup()<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 test_run.ctx.topology.setup()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0test_run.ctx.dpdk.setup()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 test_run.ctx.topology.setup()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0test_run.ctx.tg.setup(test_run.ctx.topolo=
gy)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.result.ports =3D test_run.ctx.topolo=
gy.sut_ports + test_run.ctx.topology.tg_ports<br>
@@ -433,8 +433,8 @@ def next(self) -&gt; State | None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Next state.&quot;&quot;=
&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.test_run.ctx.shell_pool.terminate_cu=
rrent_pool()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.test_run.ctx.tg.teardown()<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.test_run.ctx.dpdk.teardown()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.test_run.ctx.topology.teardown()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.test_run.ctx.dpdk.teardown()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.test_run.ctx.tg_node.teardown()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.test_run.ctx.sut_node.teardown()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.result.update_teardown(Result.PASS)<=
br>
-- <br>
2.49.0<br>
<br></blockquote><div><br></div><div>Thanks this makes sense in principle=
=C2=A0but I think there is an additional issue, which I saw when I just tes=
ted your patch on 2 XL710 NICs connected both on the Braum server.</div><di=
v><br></div><div>Here is the execution order from the testrun</div><div><br=
></div><div>1. testrun init creates DPDKRuntimeEnvironment with _node=3Dsut=
note like:=C2=A0</div><div><br></div><div>dpdk_runtime_env =3D DPDKRuntimeE=
nvironment(config.dpdk, sut_node, dpdk_build_env)</div><div><br></div><div>=
which is then added to ctx.</div><div><br></div><div>2. TestRunSetup calls=
=C2=A0test_run.ctx.dpdk.setup() which calls=C2=A0_prepare_devbind_script() =
which adds the devbind_script_path to _node.main_session, but _node in this=
 case is the sut node. I don&#39;t believe there is the code path for addin=
g devbind_script_path to the tg node main_session, so later at topology.set=
up() we call=C2=A0self._setup_ports(&quot;sut&quot;) which runs fine, and t=
hen error on=C2=A0self._setup_ports(&quot;tg&quot;) because again the tg no=
de main session is lacking the devbind_script_path attribute. I think you w=
ill need to address this second part for your patch to be complete. In any =
case, let&#39;s chat in the morning and figure out what a v2 of this bugfix=
 can be.</div><div><br></div><div>See this stacktrace:</div><div><br>2025/0=
6/16 02:59:03 - test_run_setup - dts.braum-intel-40g-SUT - INFO - Sending: =
&#39;lshw -quiet -json -C network&#39;<br>2025/06/16 02:59:04 - test_run_se=
tup - dts.braum-intel-40g-TG - INFO - Sending: &#39;lshw -quiet -json -C ne=
twork&#39;<br>2025/06/16 02:59:05 - test_run_setup - dts - ERROR - A CRITIC=
AL ERROR has occurred during test run setup. Unrecoverable state reached, s=
hutting down.<br>2025/06/16 02:59:05 - test_run_setup - dts - ERROR - An un=
expected error has occurred.<br>Traceback (most recent call last):<br>=C2=
=A0 File &quot;/dpdk/dts/framework/runner.py&quot;, line 81, in run<br>=C2=
=A0 =C2=A0 test_run.spin()<br>=C2=A0 File &quot;/dpdk/dts/framework/test_ru=
n.py&quot;, line 242, in spin<br>=C2=A0 =C2=A0 next_state =3D self.state.ha=
ndle_exception(e)<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^<br>=C2=A0 File &quot;/dpdk/dts/fra=
mework/test_run.py&quot;, line 240, in spin<br>=C2=A0 =C2=A0 next_state =3D=
 self.state.next()<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0^^^^^^^^^^^^^^^^^<br>=C2=A0 File &quot;/dpdk/dts/framework/test_r=
un.py&quot;, line 348, in next<br>=C2=A0 =C2=A0 test_run.ctx.topology.setup=
()<br>=C2=A0 File &quot;/dpdk/dts/framework/testbed_model/topology.py&quot;=
, line 130, in setup<br>=C2=A0 =C2=A0 self._setup_ports(&quot;tg&quot;)<br>=
=C2=A0 File &quot;/dpdk/dts/framework/testbed_model/topology.py&quot;, line=
 154, in _setup_ports<br>=C2=A0 =C2=A0 self._bind_ports_to_drivers(node, po=
rts, &quot;kernel&quot;)<br>=C2=A0 File &quot;/dpdk/dts/framework/testbed_m=
odel/topology.py&quot;, line 205, in _bind_ports_to_drivers<br>=C2=A0 =C2=
=A0 node.main_session.bind_ports_to_driver(ports, driver_name)<br>=C2=A0 Fi=
le &quot;/dpdk/dts/framework/testbed_model/linux_session.py&quot;, line 187=
, in bind_ports_to_driver<br>=C2=A0 =C2=A0 f&quot;{self.devbind_script_path=
} -b {driver_name} --force {ports_pci_addrs}&quot;,<br>=C2=A0 =C2=A0 =C2=A0=
 =C2=A0^^^^^^^^^^^^^^^^^^^^^^^^<br>=C2=A0 File &quot;/usr/lib/python3.12/fu=
nctools.py&quot;, line 995, in __get__<br>=C2=A0 =C2=A0 val =3D self.func(i=
nstance)<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^^^^^^^^^^^^^^^^^^^<br>=C2=
=A0 File &quot;/dpdk/dts/framework/testbed_model/linux_session.py&quot;, li=
ne 212, in devbind_script_path<br>=C2=A0 =C2=A0 raise InternalError(&quot;A=
ccessed devbind script path before setup.&quot;)<br>framework.exception.Int=
ernalError: Accessed devbind script path before setup.<br>2025/06/16 02:59:=
05 - test_run_setup - dts - INFO - Moving from stage &#39;test_run_setup&#3=
9; to stage &#39;post_run&#39;.<br>2025/06/16 02:59:05 - post_run - dts - I=
NFO - DTS execution has ended.</div><div><br></div><div>=C2=A0</div></div><=
/div>

--000000000000f4f5340637a7f554--
