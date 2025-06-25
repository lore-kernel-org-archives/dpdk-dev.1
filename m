Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96A67C77B7C
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Jun 2025 17:44:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D833040B90;
	Wed, 25 Jun 2025 19:44:26 +0200 (CEST)
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51]) by mails.dpdk.org (Postfix) with ESMTP id 4FC7A40B90
 for <dev@dpdk.org>; Wed, 25 Jun 2025 19:44:25 +0200 (CEST)
Received: by mail-pj1-f51.google.com with SMTP id
 98e67ed59e1d1-3138b2f0249so76296a91.2
 for <dev@dpdk.org>; Wed, 25 Jun 2025 10:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1750873464; x=1751478264; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tmtHbtNhmI1dgK3IObXvZx4+BL+bL9Ttva7YwdBYlW8=;
 b=fKpcGHvzPZX9Vz/IzylgdRSVmreFHJR3keYIa1mMQlvYpiN6y5WlmZLWTdUpGBUgYH
 znuhvYJ2Pl87HuGe1CxPQW5Q5I77+dNd2D2L8lRon+0u+tql2snG4rTjw722rKhQKHUd
 WM0iPRX8jWTEKf0CW5JZPW8wMbejVaTEUaFGk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750873464; x=1751478264;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tmtHbtNhmI1dgK3IObXvZx4+BL+bL9Ttva7YwdBYlW8=;
 b=F+QQEqtf0rKNtmepgqOYySUDLD1ybS1MOT4h19Wf4KRV5Wbhpd6j/AECmsoIXc8r0R
 zfRy2RCKCsr98rXquX+qkO0Gld9POzNjTg2hQT6JCjp1ONQoXQYFm9uUrfa5G7lqWGnm
 Uo+EvaYbi029y4tT7yES8+3L7IN8l3GHI+L1ZbHDqO/SsGcfaaH6JdxuLz9z2yRQG7Aa
 sz6oiZggrchOq+tEEPh294noFbXQ7u2I+VYGSeU6RwJN3hqhLGQ2HsY6VAe0VZlT8/31
 rH+pAqP5w0+F7FA4gcwmkBGh3EOlLH9SW+eqkAZx/Xe5GFGEACk4A1cJTIb2CLa9cePh
 x6OA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWtXkH0vwkaYdlAplzW0dVywg7QA0z6aynjtcpm1GVuyfHh3LWNiXgnajfjPaK2ulnMTXc=@dpdk.org
X-Gm-Message-State: AOJu0YyOTTsto6fvuooUCA7KAf4EbbazNB8Nmy+BzvZemRRbSiEOOzmg
 seBxOEXPLlK7OwXf8/VqjV199CYF8GWfy4rYHPhlyC+hxXnYaKgU5X9YgfrGUp1gMV2yIycDu0y
 EKIm++7BHAjmxDl0vKiA9Rc5aZth/mDI7SqfAlV78oA==
X-Gm-Gg: ASbGnctJQ0g8CysAiyCB38PHnyl37BtA/m+zV7VdmUT4Vyn2GFUOYTlTtcKzTAlcvEa
 9el4FEZOVFlfoX0X6ykHk8nqIMuHrsiLe73lFgkqeEMlHaPjMD8t83U6hNbxfuwdWopNV4sSEhY
 vabB5QBF4j2UwvAAcr6wHjNsWXN6eo+43oqLZH14DBvZn6+wUkbXWlGcR00AdnLmjrxQGDFQuB2
 XVVFCrSbkbE1y4=
X-Google-Smtp-Source: AGHT+IGWzkWb7dWEKQ8VfZW7UwShzXK3NgvMfMexEsoU0c5IYWA+sTJsvHMsb5h8Svl9sPiPpqFBU6LzhlGwGE01f+4=
X-Received: by 2002:a17:90b:2c87:b0:316:e77:e2cf with SMTP id
 98e67ed59e1d1-31616040aeamr1079043a91.35.1750873463985; Wed, 25 Jun 2025
 10:44:23 -0700 (PDT)
MIME-Version: 1.0
References: <20250519181957.228084-1-dmarx@iol.unh.edu>
 <20250521192629.294265-1-dmarx@iol.unh.edu>
 <20250521192629.294265-3-dmarx@iol.unh.edu>
In-Reply-To: <20250521192629.294265-3-dmarx@iol.unh.edu>
From: Patrick Robb <probb@iol.unh.edu>
Date: Wed, 25 Jun 2025 13:38:58 -0400
X-Gm-Features: AX0GCFsmpwAOmqGwgAYGrX0ReINFEmOdO4KMRZuElH18LH8wgBUAhceR8uOyklY
Message-ID: <CAJvnSUAxk9D_NL9O7CQv8heESHyMW=Z+ceeRYgMO7BTLD3khHg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] dts: add flow validation
To: Dean Marx <dmarx@iol.unh.edu>
Cc: luca.vizzarro@arm.com, yoan.picchi@foss.arm.com, 
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com, dev@dpdk.org
Content-Type: multipart/alternative; boundary="000000000000de2d98063868fe4c"
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

--000000000000de2d98063868fe4c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 21, 2025 at 3:26=E2=80=AFPM Dean Marx <dmarx@iol.unh.edu> wrote=
:

> Add a method for validating flow rules to the testpmd shell class.
> Implement test case skipping for flow rules that do not pass
> validation.
>
> Signed-off-by: Dean Marx <dmarx@iol.unh.edu>
> ---
>  dts/framework/remote_session/testpmd_shell.py | 15 ++++
>  dts/framework/test_run.py                     |  3 +
>  dts/framework/test_suite.py                   | 21 ++++-
>  dts/tests/TestSuite_flow.py                   | 90 +++++++++++++------
>  4 files changed, 102 insertions(+), 27 deletions(-)
>
> diff --git a/dts/framework/remote_session/testpmd_shell.py
> b/dts/framework/remote_session/testpmd_shell.py
> index bd5f2659bd..c2c7ade60a 100644
> --- a/dts/framework/remote_session/testpmd_shell.py
> +++ b/dts/framework/remote_session/testpmd_shell.py
> @@ -1961,6 +1961,21 @@ def flow_create(self, flow_rule: FlowRule, port_id=
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
> index 0fdc57ea9c..cf4af19e8f 100644
> --- a/dts/framework/test_run.py
> +++ b/dts/framework/test_run.py
> @@ -644,6 +644,9 @@ def next(self) -> State | None:
>                  return self
>
>              self.result.update(Result.FAIL, e)
> +        except SkippedTestException as e:
> +            self.logger.info(f"Test case execution SKIPPED: {e}")
> +            self.result.update(Result.SKIP, e)
>          else:
>              self.result.update(Result.PASS)
>              self.logger.info(f"{self.description.capitalize()} PASSED.")
> diff --git a/dts/framework/test_suite.py b/dts/framework/test_suite.py
> index e07c327b77..34e9eb54ea 100644
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
> +    def verify_skip(self, condition: bool, skip_reason: str) -> None:
>

Maybe rename to "verify_else_skip" so it is more descriptive? Up to you.


>
>

Reviewed-by: Patrick Robb <probb@iol.unh.edu>

--000000000000de2d98063868fe4c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, May 21,=
 2025 at 3:26=E2=80=AFPM Dean Marx &lt;<a href=3D"mailto:dmarx@iol.unh.edu"=
>dmarx@iol.unh.edu</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex">Add a method for validating flow rules to the testpmd she=
ll class.<br>
Implement test case skipping for flow rules that do not pass<br>
validation.<br>
<br>
Signed-off-by: Dean Marx &lt;<a href=3D"mailto:dmarx@iol.unh.edu" target=3D=
"_blank">dmarx@iol.unh.edu</a>&gt;<br>
---<br>
=C2=A0dts/framework/remote_session/testpmd_shell.py | 15 ++++<br>
=C2=A0dts/framework/test_run.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 3 +<br>
=C2=A0dts/framework/test_suite.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0| 21 ++++-<br>
=C2=A0dts/tests/TestSuite_flow.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0| 90 +++++++++++++------<br>
=C2=A04 files changed, 102 insertions(+), 27 deletions(-)<br>
<br>
diff --git a/dts/framework/remote_session/testpmd_shell.py b/dts/framework/=
remote_session/testpmd_shell.py<br>
index bd5f2659bd..c2c7ade60a 100644<br>
--- a/dts/framework/remote_session/testpmd_shell.py<br>
+++ b/dts/framework/remote_session/testpmd_shell.py<br>
@@ -1961,6 +1961,21 @@ def flow_create(self, flow_rule: FlowRule, port_id: =
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
index 0fdc57ea9c..cf4af19e8f 100644<br>
--- a/dts/framework/test_run.py<br>
+++ b/dts/framework/test_run.py<br>
@@ -644,6 +644,9 @@ def next(self) -&gt; State | None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return self<b=
r>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.result.update(Result.F=
AIL, e)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 except SkippedTestException as e:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"http://self.logger.in=
fo" rel=3D"noreferrer" target=3D"_blank">self.logger.info</a>(f&quot;Test c=
ase execution SKIPPED: {e}&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.result.update(Result.SKIP, =
e)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.result.update(Result.P=
ASS)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"http://self.logg=
er.info" rel=3D"noreferrer" target=3D"_blank">self.logger.info</a>(f&quot;{=
self.description.capitalize()} PASSED.&quot;)<br>
diff --git a/dts/framework/test_suite.py b/dts/framework/test_suite.py<br>
index e07c327b77..34e9eb54ea 100644<br>
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
+=C2=A0 =C2=A0 def verify_skip(self, condition: bool, skip_reason: str) -&g=
t; None:<br></blockquote><div><br></div><div>Maybe rename to &quot;verify_e=
lse_skip&quot; so it is more descriptive? Up to you.</div><div>=C2=A0</div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex"><br></blockquote><div><br=
></div><div><br></div><div>Reviewed-by: Patrick Robb &lt;<a href=3D"mailto:=
probb@iol.unh.edu">probb@iol.unh.edu</a>&gt;=C2=A0</div></div></div>

--000000000000de2d98063868fe4c--
