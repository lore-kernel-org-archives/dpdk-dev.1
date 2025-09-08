Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E33ACA1017
	for <dpdk-dev@archiver.kernel.org>; Mon,  8 Sep 2025 02:04:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 65E3540264;
	Mon,  8 Sep 2025 04:04:13 +0200 (CEST)
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com
 [209.85.215.171])
 by mails.dpdk.org (Postfix) with ESMTP id 058E9400EF
 for <dev@dpdk.org>; Mon,  8 Sep 2025 04:04:08 +0200 (CEST)
Received: by mail-pg1-f171.google.com with SMTP id
 41be03b00d2f7-b4dc35711d9so2683462a12.0
 for <dev@dpdk.org>; Sun, 07 Sep 2025 19:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1757297047; x=1757901847; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qh/YTtbg0wn00FgOVi+aBqkAT7s7Kcjvrx8oFBToYKo=;
 b=i1FQz3owxWo4QcqamiSp+vk8Xhn36wILtFZM8BWg511gXr+MucZ2J44vdLTmZzmWfo
 JFpf6IoJPduwNCxJQnm2PVG18RDX1NlrWX80l8/lJYJAQHIC+xzsnI3xpay/qynzYkC9
 BCS37OvqtdHqNZJs3jFVZGYOEYqbBMIS/LpT8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757297047; x=1757901847;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qh/YTtbg0wn00FgOVi+aBqkAT7s7Kcjvrx8oFBToYKo=;
 b=Vu3HIQ2IMzgbu53pcTksnGXj3A2KTNRlmnEr7eWdx3+fkjVKpOyc8g7FU4I66dSy8S
 r0q8S06JrQ9SswPYSQI8cy+kU6cZEDwjATOyC2GUz7WGiWdb0Ay4CmlrBewK42joZzzN
 BlKClF0wD7fPZvTAi/Kj2tLWRz8xNx5eT1j/6VylTFl6zqL/9PSpqp5CcleP3NVUUhS3
 cr7CxgSQc9v9biMX6IuJMvOh0qPkUvHadxBAs+RCDyxW8hckMrOA0+ON6w6AhSnZZXsd
 1fHSC+VUZYv3tAa+AzRn/knXoAj/bwwD8apsWUEyBZtQgGGOKDARTcGuE+b3laKFGs2j
 eMiA==
X-Gm-Message-State: AOJu0Yx/WZuuUpkH0CeeuTdm7QlPaRbusb2oPjCGjKz8s9kZ1xhL/Feh
 mR7b/46JzHrM9+j6yLYoqF/dy21FOWrMLiNdjoZMEmMnyqa9KaUFifms2x99obGAw+TbMP5GNug
 RSFNeXO0Fk5oonweCJGhcYQLOKMSa6nkhuxE+MsrtjQ==
X-Gm-Gg: ASbGncviAbc6uGvC0xqzeqX9MHPrkOFVUNyG9VO9H6d+ueiEg5qgHP3+yfmdbh/A1Sy
 kDbPxV9DSvsAp4URaqXalvsVyZ296vRNmelVhTv2DY2xBWU+L9Huno4QBgMR/D/XHJsRcdXbgjO
 6XvW5UbblkjwfHKed3f4fq2GC6cg6PqjCTa99qQl9NS9H4bIrVw93y8PXorgS6tGQb5OzIZ0UAu
 BKfIuP6GHbnp2BDqsgL5YmhDWqbyxvGbw5gqpDlQnyl
X-Google-Smtp-Source: AGHT+IH6zRI+kYRIxFrlifOXu9REzszCf1yDVfQEI4reoeZSxv/9O3ijN32YF5CZlKwcd8nz3YGE+1eU1O4AZ7hk+T4=
X-Received: by 2002:a17:90b:3c08:b0:32b:7067:c8f1 with SMTP id
 98e67ed59e1d1-32d43f65352mr8217923a91.18.1757297047039; Sun, 07 Sep 2025
 19:04:07 -0700 (PDT)
MIME-Version: 1.0
References: <20250908014154.82938-1-probb@iol.unh.edu>
In-Reply-To: <20250908014154.82938-1-probb@iol.unh.edu>
From: Patrick Robb <probb@iol.unh.edu>
Date: Sun, 7 Sep 2025 21:57:17 -0400
X-Gm-Features: Ac12FXzth7YtqawPhuus3OTlp--WC17OHqFlBf0-8-yMsAs3DXh8mCNia7sGhAc
Message-ID: <CAJvnSUCabi-1bphBbfCT7oHVBmS2B2bQ4mEkWQK9B1LNn7Qc=w@mail.gmail.com>
Subject: Re: [PATCH] dts: add dpdk shell warm up period
To: luca.vizzarro@arm.com
Cc: dev@dpdk.org, dmarx@iol.unh.edu, abailey@iol.unh.edu, 
 Ajit Khaparde <ajit.khaparde@broadcom.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Content-Type: multipart/alternative; boundary="000000000000410da9063e409acb"
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

--000000000000410da9063e409acb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

To provide a little additional context, specifically what was happening was
we paired up an Intel E810 (traffic generator) against a broadcom p2100G
(SUT) using a generic DAC cable, and then like I said in the original
commit, packets would not transmit even after the regular readiness checks
in DTS had passed (ports are reporting they are started and we have run
testpmd start and the testpmd prompt "testpmd>" had entered the output).
So, this outcome was a little confusing. I tried to throw in some
additional steps (like throw in a bring link down and up via kernel on TG
side and via testpmd on SUT side) but that didn't make a difference. I also
looked through the DTS verbose logs after having done that and saw that
testpmd was reporting link was up on the Broadcom NIC. I briefly thought
about swapping out the E810 for a second P2100G so it would be a broadcom
to broadcom connection, but I didn't have an extra on hand and if we are
going to spend money getting new hardware it should be on the newer devices
Broadcom has put out vs this model which has been out for a few years.

Anyhow, without getting into why exactly this is happening with this
specific mix of hardware, I think the important thing from my perspective
is that DTS should not be fragile to device specific behavior like this
since correctness is more important than speed. And, I don't know when this
will happen in the future with a different device. A (sort of) arbitrary
sleep isn't an ideal addition to DTS in my mind, but given that our
existing readiness checks seem correct (but may not be sufficient) this
seems like the correct action to me.

On Sun, Sep 7, 2025 at 9:48=E2=80=AFPM Patrick Robb <probb@iol.unh.edu> wro=
te:

> When running our existing DTS testsuites on a new
> NIC we observed packets would not transmit from
> the traffic generator to the system under test
> even after DPDK testpmd and the NIC under test
> had indicated readiness through the existing
> readiness checks in DTS. After adding in a warm up
> sleep to DPDK shells, this issue was resolved.
> Correctness is more important than execution
> speed in DTS, so it seems justified to slow down
> the execution a little in order to make the
> testing framework less fragile to such device
> specific bringup behaviors.
>
> Signed-off-by: Patrick Robb <probb@iol.unh.edu>
> ---
>  dts/framework/remote_session/dpdk_shell.py | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/dts/framework/remote_session/dpdk_shell.py
> b/dts/framework/remote_session/dpdk_shell.py
> index d4aa02f39b..b0868d32fb 100644
> --- a/dts/framework/remote_session/dpdk_shell.py
> +++ b/dts/framework/remote_session/dpdk_shell.py
> @@ -6,9 +6,12 @@
>  Provides a base class to create interactive shells based on DPDK.
>  """
>
> +import time
>  from abc import ABC, abstractmethod
>  from pathlib import PurePath
>
> +from typing_extensions import Self
> +
>  from framework.context import get_ctx
>  from framework.params.eal import EalParams
>  from framework.remote_session.interactive_shell import (
> @@ -84,3 +87,9 @@ def _make_real_path(self):
>          Adds the remote DPDK build directory to the path.
>          """
>          return
> get_ctx().dpdk_build.remote_dpdk_build_dir.joinpath(self.path)
> +
> +    def __enter__(self) -> Self:
> +        """Overrides
> :meth:`~.interactive_shell.InteractiveShell.__enter__`."""
> +        super().__enter__()
> +        time.sleep(5)
> +        return self
> --
> 2.49.0
>
>

--000000000000410da9063e409acb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">To provide a little additional context, specifically what =
was happening was we paired up an Intel E810 (traffic generator) against a =
broadcom p2100G (SUT) using a generic DAC cable, and then like I said in th=
e original commit, packets would not transmit even after the regular readin=
ess checks in DTS had passed (ports are reporting they are started and we h=
ave run testpmd start and the testpmd prompt &quot;testpmd&gt;&quot; had en=
tered the output). So, this outcome was a little confusing. I tried to thro=
w in some additional steps (like throw in a bring link down and up via kern=
el on TG side and via testpmd on SUT side) but that didn&#39;t make a diffe=
rence. I also looked through the DTS verbose logs after having done that an=
d saw that testpmd was reporting link was up on the Broadcom NIC. I briefly=
 thought about swapping out the E810 for a second P2100G so it would be a b=
roadcom to broadcom connection, but I didn&#39;t have an extra on hand and =
if we are going to spend money getting new hardware it should be on the new=
er devices Broadcom has put out vs this model which has been out for a few =
years.<div><div><br></div><div>Anyhow, without getting into why exactly thi=
s is happening with this specific mix of hardware, I think the important th=
ing from my perspective is that DTS should not be fragile to device specifi=
c behavior like this since correctness is more important than speed. And, I=
 don&#39;t know when this will happen in the future with a different device=
. A (sort of) arbitrary sleep isn&#39;t an ideal addition to DTS in my mind=
, but given that our existing readiness checks seem correct (but may not be=
 sufficient) this seems like the correct action to me.</div></div></div><br=
><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D=
"gmail_attr">On Sun, Sep 7, 2025 at 9:48=E2=80=AFPM Patrick Robb &lt;<a hre=
f=3D"mailto:probb@iol.unh.edu">probb@iol.unh.edu</a>&gt; wrote:<br></div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">When running our existing D=
TS testsuites on a new<br>
NIC we observed packets would not transmit from<br>
the traffic generator to the system under test<br>
even after DPDK testpmd and the NIC under test<br>
had indicated readiness through the existing<br>
readiness checks in DTS. After adding in a warm up<br>
sleep to DPDK shells, this issue was resolved.<br>
Correctness is more important than execution<br>
speed in DTS, so it seems justified to slow down<br>
the execution a little in order to make the<br>
testing framework less fragile to such device<br>
specific bringup behaviors.<br>
<br>
Signed-off-by: Patrick Robb &lt;<a href=3D"mailto:probb@iol.unh.edu" target=
=3D"_blank">probb@iol.unh.edu</a>&gt;<br>
---<br>
=C2=A0dts/framework/remote_session/dpdk_shell.py | 9 +++++++++<br>
=C2=A01 file changed, 9 insertions(+)<br>
<br>
diff --git a/dts/framework/remote_session/dpdk_shell.py b/dts/framework/rem=
ote_session/dpdk_shell.py<br>
index d4aa02f39b..b0868d32fb 100644<br>
--- a/dts/framework/remote_session/dpdk_shell.py<br>
+++ b/dts/framework/remote_session/dpdk_shell.py<br>
@@ -6,9 +6,12 @@<br>
=C2=A0Provides a base class to create interactive shells based on DPDK.<br>
=C2=A0&quot;&quot;&quot;<br>
<br>
+import time<br>
=C2=A0from abc import ABC, abstractmethod<br>
=C2=A0from pathlib import PurePath<br>
<br>
+from typing_extensions import Self<br>
+<br>
=C2=A0from framework.context import get_ctx<br>
=C2=A0from framework.params.eal import EalParams<br>
=C2=A0from framework.remote_session.interactive_shell import (<br>
@@ -84,3 +87,9 @@ def _make_real_path(self):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Adds the remote DPDK build directory to t=
he path.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return get_ctx().dpdk_build.remote_dpdk_b=
uild_dir.joinpath(self.path)<br>
+<br>
+=C2=A0 =C2=A0 def __enter__(self) -&gt; Self:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Overrides :meth:`~.interacti=
ve_shell.InteractiveShell.__enter__`.&quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 super().__enter__()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 time.sleep(5)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return self<br>
-- <br>
2.49.0<br>
<br>
</blockquote></div>

--000000000000410da9063e409acb--
