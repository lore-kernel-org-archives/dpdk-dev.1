Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E0B3C7EE2A
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Jun 2025 04:34:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 79CE24060B;
	Fri, 27 Jun 2025 06:34:54 +0200 (CEST)
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com
 [209.85.216.54]) by mails.dpdk.org (Postfix) with ESMTP id 22575402DC
 for <dev@dpdk.org>; Fri, 27 Jun 2025 06:34:52 +0200 (CEST)
Received: by mail-pj1-f54.google.com with SMTP id
 98e67ed59e1d1-31393526d0dso1180884a91.0
 for <dev@dpdk.org>; Thu, 26 Jun 2025 21:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1750998891; x=1751603691; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IHZjeuQNGWAvb7Q3mPuG7jiHPKguqibYN5ZhapnDLOc=;
 b=TzEl7GYWfn06ic7HSaafezVPB0eoXYWvRG903DyqQqVJ0+zgTEPN3hAJX/BnIxjxTM
 QfHtQWUBbBlRv9hmb1DC8hGU0DQwCytiJjXV9pKwRJYjyObxgFwhmnTjQihRLO1h6l+n
 hyALzeyTVe3FKTC/OR+LNoktEMIdXw5EMA2Is=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750998891; x=1751603691;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IHZjeuQNGWAvb7Q3mPuG7jiHPKguqibYN5ZhapnDLOc=;
 b=p31m5ye0Hl5Z8nUkdjBJQY5ov6EsigeWNwU5RlwM3D5I/Y7rVBkHRXvUM9KqT2GZMB
 1fd/XsZx7A6bRaGguogsY1bC8zLtU5bxRCvwCcxwZzhs6Lq93P/2SRTCvf1FwqLsbg5j
 PVnS3n5fiz5Yn7oreEAFVjUWbwk7ySGOlzv3InF9VnjFM937pAa7TQneEnKCbSBzTMxD
 R2JbGI5flM/6kZX1EJBIt/qNxWR9FknrVxw9wWfp/VsIViTiw7+b7LTOD7GC2/0rvxnd
 xPtENvIB9EUbf4yGGKTgCZmFfvdWr5FtyxnEEGLhWTMNuZDAEzFU3ewuKKkPKmCHSBQe
 2bZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJKnghGRfysn3Q6HduDUXS22x66Bt0TFSWiomucjvB/stcwWNJM8Ou0nR3HaKyqZPcOso=@dpdk.org
X-Gm-Message-State: AOJu0Yy0zh69LmWopQuQSE7g31ppHtMeB086oWfHmOettauYWvUdYlUA
 LCFVnhQEzVpznVAM6gKO3mug3PA3Gfu503O0ZD/bWCOM0mSZt+PwebYc01Nc5y7MPurdAlXurCQ
 0zO7hLGI4/5XuO597rm+t6yjtx1CvjtVxrOnjVr2L1w==
X-Gm-Gg: ASbGncv9UCGW6R93LJyBFtKI+LwbxNxhp8E5tD60RtGo5mueiXFKg/1wJ4AyIdW2Skh
 wV6yLCjYzj8lQ64/RPD+KBsmH4BjgrxtDLZf2h8GaFB4pwiGV3nfm/NmiyLbyNLAoxCERXg8zph
 yfnPvGgjzAfN44NHIFz35lniQgktS9yZcegkdYnn+z2d/i+zdwx++jihQ2owM=
X-Google-Smtp-Source: AGHT+IH8H7qr+9J2LY2PLE6kND+BK6d0a3Bim2LAU8lRWjd4YoHbaWtZSmYFbvmXBUEr1Wit+4cNYHfoirrjkKM8kXs=
X-Received: by 2002:a17:90b:2e52:b0:313:287e:f1e8 with SMTP id
 98e67ed59e1d1-318c9218fb8mr2678087a91.8.1750998891231; Thu, 26 Jun 2025
 21:34:51 -0700 (PDT)
MIME-Version: 1.0
References: <20250521192629.294265-3-dmarx@iol.unh.edu>
 <20250626195617.219395-1-dmarx@iol.unh.edu>
 <20250626195617.219395-2-dmarx@iol.unh.edu>
In-Reply-To: <20250626195617.219395-2-dmarx@iol.unh.edu>
From: Patrick Robb <probb@iol.unh.edu>
Date: Fri, 27 Jun 2025 00:29:23 -0400
X-Gm-Features: Ac12FXxY6a6d55DR38eK-zTrBjh25c_g0COo0UsRuNrzCnWiq50YEZ1Y-KcL_p4
Message-ID: <CAJvnSUAph0-X2nnap6e-dyPVriuGgjSFNmgmoKSpuY9u-37Z0w@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] dts: add flow validation
To: Dean Marx <dmarx@iol.unh.edu>
Cc: luca.vizzarro@arm.com, yoan.picchi@foss.arm.com, 
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com, dev@dpdk.org
Content-Type: multipart/alternative; boundary="000000000000ea123b06388632ec"
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

--000000000000ea123b06388632ec
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied to next-dts, thanks.

On Thu, Jun 26, 2025 at 3:56=E2=80=AFPM Dean Marx <dmarx@iol.unh.edu> wrote=
:

> Add a method for validating flow rules to the testpmd shell class.
> Implement test case skipping for flow rules that do not pass
> validation.
>
> Signed-off-by: Dean Marx <dmarx@iol.unh.edu>
> Reviewed-by: Patrick Robb <probb@iol.unh.edu>
> ---
>  dts/framework/remote_session/testpmd_shell.py | 15 +++++++++++++
>  dts/framework/test_run.py                     |  3 +++
>  dts/framework/test_suite.py                   | 21 ++++++++++++++++++-
>  3 files changed, 38 insertions(+), 1 deletion(-)
>
> diff --git a/dts/framework/remote_session/testpmd_shell.py
> b/dts/framework/remote_session/testpmd_shell.py
> index 0b9bb4070a..299887dd80 100644
> --- a/dts/framework/remote_session/testpmd_shell.py
> +++ b/dts/framework/remote_session/testpmd_shell.py
> @@ -1984,6 +1984,21 @@ def flow_create(self, flow_rule: FlowRule, port_id=
:
> int) -> int:
>              self._logger.debug(f"Failed to create flow
> rule:\n{flow_output}")
>              raise InteractiveCommandExecutionError(f"Failed to create
> flow rule:\n{flow_output}")
>
> +    def flow_validate(self, flow_rule: FlowRule, port_id: int) -> bool:
> +        """Validates a flow rule in the testpmd session.
> +
> +        Args:
> +            flow_rule: :class:`FlowRule` object used for validating
> testpmd flow rule.
> +            port_id: Integer representing the port to use.
> +
> +        Returns:
> +            Boolean representing whether rule is valid or not.
> +        """
> +        flow_output =3D self.send_command(f"flow validate {port_id}
> {flow_rule}")
> +        if "Flow rule validated" in flow_output:
> +            return True
> +        return False
> +
>      def flow_delete(self, flow_id: int, port_id: int, verify: bool =3D
> True) -> None:
>          """Deletes the specified flow rule from the testpmd session.
>
> diff --git a/dts/framework/test_run.py b/dts/framework/test_run.py
> index 10a5e1a6b8..fd49a7dc74 100644
> --- a/dts/framework/test_run.py
> +++ b/dts/framework/test_run.py
> @@ -655,6 +655,9 @@ def next(self) -> State | None:
>                  return self
>
>              self.result.update(Result.FAIL, e)
> +        except SkippedTestException as e:
> +            self.logger.info(f"{self.description.capitalize()} SKIPPED:
> {e}")
> +            self.result.update(Result.SKIP, e)
>          else:
>              self.result.update(Result.PASS)
>              self.logger.info(f"{self.description.capitalize()} PASSED.")
> diff --git a/dts/framework/test_suite.py b/dts/framework/test_suite.py
> index e5fbadd1a1..145b79496f 100644
> --- a/dts/framework/test_suite.py
> +++ b/dts/framework/test_suite.py
> @@ -39,7 +39,7 @@
>      PacketFilteringConfig,
>  )
>
> -from .exception import ConfigurationError, InternalError,
> TestCaseVerifyError
> +from .exception import ConfigurationError, InternalError,
> SkippedTestException, TestCaseVerifyError
>  from .logger import DTSLogger, get_dts_logger
>  from .utils import get_packet_summaries, to_pascal_case
>
> @@ -411,6 +411,25 @@ def _fail_test_case_verify(self, failure_description=
:
> str) -> None:
>              self._logger.debug(command_res.command)
>          raise TestCaseVerifyError(failure_description)
>
> +    def verify_else_skip(self, condition: bool, skip_reason: str) -> Non=
e:
> +        """Verify `condition` and handle skips.
> +
> +        When `condition` is :data:`False`, raise a skip exception.
> +
> +        Args:
> +            condition: The condition to check.
> +            skip_reason: Description of the reason for skipping.
> +
> +        Raises:
> +            SkippedTestException: `condition` is :data:`False`.
> +        """
> +        if not condition:
> +            self._skip_test_case_verify(skip_reason)
> +
> +    def _skip_test_case_verify(self, skip_description: str) -> None:
> +        self._logger.debug(f"Test case skipped: {skip_description}")
> +        raise SkippedTestException(skip_description)
> +
>      def verify_packets(self, expected_packet: Packet, received_packets:
> list[Packet]) -> None:
>          """Verify that `expected_packet` has been received.
>
> --
> 2.49.0
>
>

--000000000000ea123b06388632ec
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Applied to next-dts, thanks.</div><br><div class=3D"gmail_=
quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, =
Jun 26, 2025 at 3:56=E2=80=AFPM Dean Marx &lt;<a href=3D"mailto:dmarx@iol.u=
nh.edu">dmarx@iol.unh.edu</a>&gt; wrote:<br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">Add a method for validating flow rules to the test=
pmd shell class.<br>
Implement test case skipping for flow rules that do not pass<br>
validation.<br>
<br>
Signed-off-by: Dean Marx &lt;<a href=3D"mailto:dmarx@iol.unh.edu" target=3D=
"_blank">dmarx@iol.unh.edu</a>&gt;<br>
Reviewed-by: Patrick Robb &lt;<a href=3D"mailto:probb@iol.unh.edu" target=
=3D"_blank">probb@iol.unh.edu</a>&gt;<br>
---<br>
=C2=A0dts/framework/remote_session/testpmd_shell.py | 15 +++++++++++++<br>
=C2=A0dts/framework/test_run.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 3 +++<br>
=C2=A0dts/framework/test_suite.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0| 21 ++++++++++++++++++-<br>
=C2=A03 files changed, 38 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/dts/framework/remote_session/testpmd_shell.py b/dts/framework/=
remote_session/testpmd_shell.py<br>
index 0b9bb4070a..299887dd80 100644<br>
--- a/dts/framework/remote_session/testpmd_shell.py<br>
+++ b/dts/framework/remote_session/testpmd_shell.py<br>
@@ -1984,6 +1984,21 @@ def flow_create(self, flow_rule: FlowRule, port_id: =
int) -&gt; int:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self._logger.debug(f&quot;F=
ailed to create flow rule:\n{flow_output}&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise InteractiveCommandExe=
cutionError(f&quot;Failed to create flow rule:\n{flow_output}&quot;)<br>
<br>
+=C2=A0 =C2=A0 def flow_validate(self, flow_rule: FlowRule, port_id: int) -=
&gt; bool:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Validates a flow rule in the=
 testpmd session.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 flow_rule: :class:`FlowRule` obj=
ect used for validating testpmd flow rule.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 port_id: Integer representing th=
e port to use.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Returns:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Boolean representing whether rul=
e is valid or not.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 flow_output =3D self.send_command(f&quot;flow =
validate {port_id} {flow_rule}&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if &quot;Flow rule validated&quot; in flow_out=
put:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return True<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return False<br>
+<br>
=C2=A0 =C2=A0 =C2=A0def flow_delete(self, flow_id: int, port_id: int, verif=
y: bool =3D True) -&gt; None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Deletes the specified f=
low rule from the testpmd session.<br>
<br>
diff --git a/dts/framework/test_run.py b/dts/framework/test_run.py<br>
index 10a5e1a6b8..fd49a7dc74 100644<br>
--- a/dts/framework/test_run.py<br>
+++ b/dts/framework/test_run.py<br>
@@ -655,6 +655,9 @@ def next(self) -&gt; State | None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return self<b=
r>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.result.update(Result.F=
AIL, e)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 except SkippedTestException as e:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"http://self.logger.in=
fo" rel=3D"noreferrer" target=3D"_blank">self.logger.info</a>(f&quot;{self.=
description.capitalize()} SKIPPED: {e}&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.result.update(Result.SKIP, =
e)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.result.update(Result.P=
ASS)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"http://self.logg=
er.info" rel=3D"noreferrer" target=3D"_blank">self.logger.info</a>(f&quot;{=
self.description.capitalize()} PASSED.&quot;)<br>
diff --git a/dts/framework/test_suite.py b/dts/framework/test_suite.py<br>
index e5fbadd1a1..145b79496f 100644<br>
--- a/dts/framework/test_suite.py<br>
+++ b/dts/framework/test_suite.py<br>
@@ -39,7 +39,7 @@<br>
=C2=A0 =C2=A0 =C2=A0PacketFilteringConfig,<br>
=C2=A0)<br>
<br>
-from .exception import ConfigurationError, InternalError, TestCaseVerifyEr=
ror<br>
+from .exception import ConfigurationError, InternalError, SkippedTestExcep=
tion, TestCaseVerifyError<br>
=C2=A0from .logger import DTSLogger, get_dts_logger<br>
=C2=A0from .utils import get_packet_summaries, to_pascal_case<br>
<br>
@@ -411,6 +411,25 @@ def _fail_test_case_verify(self, failure_description: =
str) -&gt; None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self._logger.debug(command_=
res.command)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise TestCaseVerifyError(failure_descrip=
tion)<br>
<br>
+=C2=A0 =C2=A0 def verify_else_skip(self, condition: bool, skip_reason: str=
) -&gt; None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Verify `condition` and handl=
e skips.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 When `condition` is :data:`False`, raise a ski=
p exception.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 condition: The condition to chec=
k.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 skip_reason: Description of the =
reason for skipping.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Raises:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SkippedTestException: `condition=
` is :data:`False`.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if not condition:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._skip_test_case_verify(skip=
_reason)<br>
+<br>
+=C2=A0 =C2=A0 def _skip_test_case_verify(self, skip_description: str) -&gt=
; None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._logger.debug(f&quot;Test case skipped: {=
skip_description}&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 raise SkippedTestException(skip_description)<b=
r>
+<br>
=C2=A0 =C2=A0 =C2=A0def verify_packets(self, expected_packet: Packet, recei=
ved_packets: list[Packet]) -&gt; None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Verify that `expected_p=
acket` has been received.<br>
<br>
-- <br>
2.49.0<br>
<br>
</blockquote></div>

--000000000000ea123b06388632ec--
