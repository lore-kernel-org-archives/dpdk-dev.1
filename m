Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D12ACCF9EA
	for <dpdk-dev@archiver.kernel.org>; Tue, 28 Oct 2025 22:33:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 37BD04028D;
	Tue, 28 Oct 2025 23:33:51 +0100 (CET)
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com
 [209.85.215.182])
 by mails.dpdk.org (Postfix) with ESMTP id 3652640262
 for <dev@dpdk.org>; Tue, 28 Oct 2025 23:33:50 +0100 (CET)
Received: by mail-pg1-f182.google.com with SMTP id
 41be03b00d2f7-b6cf25c9ad5so5123084a12.0
 for <dev@dpdk.org>; Tue, 28 Oct 2025 15:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1761690829; x=1762295629; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DNann4CWl1ZzAxAE6N2HgBUcrO8/PCd7xGnLeEv+Uo8=;
 b=JTptewII3UslE6Qz0kx7RDLEWISMqx2j4IYsDQ6t7bHjkJnSb/o3d/mV+PaZDyLwea
 HIw5xSLHLaUPsPrbAX5OkLWwlUqdpcRpFVWwRN7Wh5nt2uKC2QAeF5uvBRhy0A2zzQRT
 8WExR/ZegzT3456pUwz32g8tkXAgwTlh0jO94=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761690829; x=1762295629;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DNann4CWl1ZzAxAE6N2HgBUcrO8/PCd7xGnLeEv+Uo8=;
 b=OzcpGM9TrG7DBR6+vSv5uwzCQ1LxSWUsNXyf7IThsR97zIJGymb+yl+tFAB/KvnCoA
 U8rDGLRH8Yem1mbabgJ2lmPa1IO9p5uAabaJrgudTmShGqwyV02aI/Rcb86LS8Q6uu4h
 01KJZtFeNSvcV341xRK0XklhBVvd+OVkwwA4w4WC9Hsfils7bFUPzW0Z1MgMuzGVVNmk
 L/1jsUEyFaK0GeXPj099OVswDcHuxXz5Qm2DiRsGrBHzhWnA0xEoT82K5uhA0O/sHWfP
 PXFh6PxIEvbqHkFEyWvjYB90VaaS2G78tENORKGgMacN4yldTpio3Y7m2ppCvIqvfIWA
 iUbQ==
X-Gm-Message-State: AOJu0YwuEkg8Pm4dfzbYb0/1555bM+vuYGdPO+jzdbq8Msb1aPZUu37A
 Q3UR8ke9x35D29ShlYTeIYdBd3pZV9dvKHdhMjJcZM3BEwtEQi7hnWzewXVEui00GPBpHqg6+iT
 YoVvzEXPyuuszD2FT5CjwzJ9ty7jQ404smzVyR6rT+g==
X-Gm-Gg: ASbGncuKFpKvAu0YeAe534VjeUO74ttrN2ck2BanuF1vVrdaT+w5+nBk7piurRO18mT
 yK25E1MYsYsUKfOTQxdt24bPrVtvh+bg+Khrc9/5rvUI+gMnLjyAG0f7cgnetmx5ACgqYQ6xTm7
 aDVAkyzivxVTVlzJ+1eu3R3jdSjpPPUC1c0HJo1cM5ITm0+Zsib/ITMI2W0zX33eE7mdJVB0r+r
 yTgDc39wKXX/egUx5RSWRjhz5JWkd0J+vQilHn+aG1rnhjwL7dxsGdgVMJCR7QCssIZm2BYfebn
 ugh3AaHhjpWrB6wzlk5dg1jXCbnc
X-Google-Smtp-Source: AGHT+IGu9VxdE41MvztS6FFiuSZ6GzA8MLaiYXXaEKoXpbZKs3sArsBJRb8I1Zsnex3BmW2Neq3IApaSfj9L+1wRsks=
X-Received: by 2002:a17:903:32c2:b0:265:57dc:977b with SMTP id
 d9443c01a7336-294def3b02cmr7376935ad.61.1761690829183; Tue, 28 Oct 2025
 15:33:49 -0700 (PDT)
MIME-Version: 1.0
References: <20250902114327.48185-1-abailey@iol.unh.edu>
 <20251028122240.112773-1-abailey@iol.unh.edu>
 <20251028122240.112773-2-abailey@iol.unh.edu>
In-Reply-To: <20251028122240.112773-2-abailey@iol.unh.edu>
From: Patrick Robb <probb@iol.unh.edu>
Date: Tue, 28 Oct 2025 18:32:49 -0400
X-Gm-Features: AWmQ_bldLEFyAhJx9scbAkRLh_VTTd_RO8KXed3Pp3RZaHfq8-8uZY-lIGwcJVY
Message-ID: <CAJvnSUDLujYSwLD1bN6vZFtP14ikBgjxVbhfun3xnXW7K=VgdQ@mail.gmail.com>
Subject: Re: [PATCH v11 1/3] dts: allow mbuf fast free to be set with testpmd
 shell
To: Andrew Bailey <abailey@iol.unh.edu>
Cc: dev@dpdk.org, luca.vizzarro@arm.com, dmarx@iol.unh.edu
Content-Type: multipart/alternative; boundary="00000000000013e94706423f9ca6"
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

--00000000000013e94706423f9ca6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied to next-dts, thanks.

On Tue, Oct 28, 2025 at 8:22=E2=80=AFAM Andrew Bailey <abailey@iol.unh.edu>=
 wrote:

> Currently, there is no way in the testpmd shell class to set the mbuf
> fast free offload configuration for queues or ports. This prohibits any
> test suites to be written utilizing this offload configuration.
> Introduce methods that support calls to testpmd in order to allow
> the configuration of mbuf fast free.
>
> Signed-off-by: Andrew Bailey <abailey@iol.unh.edu>
> ---
>  dts/api/testpmd/__init__.py | 60 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 60 insertions(+)
>
> diff --git a/dts/api/testpmd/__init__.py b/dts/api/testpmd/__init__.py
> index a060ab5639..9e9cbaf495 100644
> --- a/dts/api/testpmd/__init__.py
> +++ b/dts/api/testpmd/__init__.py
> @@ -1292,3 +1292,63 @@ def get_capabilities_physical_function(
>              supported_capabilities.add(NicCapability.PHYSICAL_FUNCTION)
>          else:
>              unsupported_capabilities.add(NicCapability.PHYSICAL_FUNCTION=
)
> +
> +    @_requires_stopped_ports
> +    def set_port_mbuf_fast_free(
> +        self,
> +        port_id: int,
> +        on: bool,
> +        /,
> +        verify: bool =3D True,
> +    ) -> None:
> +        """Sets the mbuf_fast_free configuration for the Tx offload of a
> given port.
> +
> +        Args:
> +            port_id: The ID of the port to configure mbuf_fast_free on.
> +            on: If :data:`True` mbuf_fast_free will be enabled, disable
> it otherwise.
> +            verify: If :data:`True` the output of the command will be
> scanned in an attempt to
> +                verify that the mbuf_fast_free was set successfully.
> +
> +        Raises:
> +            InteractiveCommandExecutionError: If mbuf_fast_free could no=
t
> be set successfully.
> +        """
> +        mbuf_output =3D self.send_command(
> +            f"port config {port_id} tx_offload mbuf_fast_free {"on" if o=
n
> else "off"}"
> +        )
> +
> +        if verify and "Error" in mbuf_output:
> +            raise InteractiveCommandExecutionError(
> +                f"Unable to set mbuf_fast_free config on port
> {port_id}:\n{mbuf_output}"
> +            )
> +
> +    @_requires_stopped_ports
> +    def set_queue_mbuf_fast_free(
> +        self,
> +        port_id: int,
> +        on: bool,
> +        /,
> +        queue_id: int =3D 0,
> +        verify: bool =3D True,
> +    ) -> None:
> +        """Sets the Tx mbuf_fast_free configuration of the specified
> queue on a given port.
> +
> +        Args:
> +            port_id: The ID of the port containing the queues.
> +            on: If :data:`True` the mbuf_fast_free configuration will be
> enabled, otherwise
> +                disabled.
> +            queue_id: The ID of the queue to configure mbuf_fast_free on=
.
> +            verify: If :data:`True` the output of the command will be
> scanned in an attempt to
> +                verify that mbuf_fast_free was set successfully on all
> ports.
> +
> +        Raises:
> +            InteractiveCommandExecutionError: If all queues could not be
> set successfully.
> +        """
> +        toggle =3D "on" if on else "off"
> +        output =3D self.send_command(
> +            f"port {port_id} txq {queue_id} tx_offload mbuf_fast_free
> {toggle}"
> +        )
> +        if verify and "Error" in output:
> +            self._logger.debug(f"Set queue offload config
> error\n{output}")
> +            raise InteractiveCommandExecutionError(
> +                f"Failed to get offload config on port {port_id}, queue
> {queue_id}:\n{output}"
> +            )
> --
> 2.50.1
>
>

--00000000000013e94706423f9ca6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Applied to next-dts, thanks.</div><br><div class=3D"gmail_=
quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, =
Oct 28, 2025 at 8:22=E2=80=AFAM Andrew Bailey &lt;<a href=3D"mailto:abailey=
@iol.unh.edu">abailey@iol.unh.edu</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">Currently, there is no way in the testpmd =
shell class to set the mbuf<br>
fast free offload configuration for queues or ports. This prohibits any<br>
test suites to be written utilizing this offload configuration.<br>
Introduce methods that support calls to testpmd in order to allow<br>
the configuration of mbuf fast free.<br>
<br>
Signed-off-by: Andrew Bailey &lt;<a href=3D"mailto:abailey@iol.unh.edu" tar=
get=3D"_blank">abailey@iol.unh.edu</a>&gt;<br>
---<br>
=C2=A0dts/api/testpmd/__init__.py | 60 ++++++++++++++++++++++++++++++++++++=
+<br>
=C2=A01 file changed, 60 insertions(+)<br>
<br>
diff --git a/dts/api/testpmd/__init__.py b/dts/api/testpmd/__init__.py<br>
index a060ab5639..9e9cbaf495 100644<br>
--- a/dts/api/testpmd/__init__.py<br>
+++ b/dts/api/testpmd/__init__.py<br>
@@ -1292,3 +1292,63 @@ def get_capabilities_physical_function(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0supported_capabilities.add(=
NicCapability.PHYSICAL_FUNCTION)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsupported_capabilities.ad=
d(NicCapability.PHYSICAL_FUNCTION)<br>
+<br>
+=C2=A0 =C2=A0 @_requires_stopped_ports<br>
+=C2=A0 =C2=A0 def set_port_mbuf_fast_free(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 port_id: int,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 on: bool,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 verify: bool =3D True,<br>
+=C2=A0 =C2=A0 ) -&gt; None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Sets the mbuf_fast_free conf=
iguration for the Tx offload of a given port.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 port_id: The ID of the port to c=
onfigure mbuf_fast_free on.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 on: If :data:`True` mbuf_fast_fr=
ee will be enabled, disable it otherwise.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 verify: If :data:`True` the outp=
ut of the command will be scanned in an attempt to<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 verify that the mb=
uf_fast_free was set successfully.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Raises:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 InteractiveCommandExecutionError=
: If mbuf_fast_free could not be set successfully.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 mbuf_output =3D self.send_command(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&quot;port config {port_id} tx_=
offload mbuf_fast_free {&quot;on&quot; if on else &quot;off&quot;}&quot;<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if verify and &quot;Error&quot; in mbuf_output=
:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise InteractiveCommandExecutio=
nError(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&quot;Unable to s=
et mbuf_fast_free config on port {port_id}:\n{mbuf_output}&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+<br>
+=C2=A0 =C2=A0 @_requires_stopped_ports<br>
+=C2=A0 =C2=A0 def set_queue_mbuf_fast_free(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 port_id: int,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 on: bool,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 queue_id: int =3D 0,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 verify: bool =3D True,<br>
+=C2=A0 =C2=A0 ) -&gt; None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Sets the Tx mbuf_fast_free c=
onfiguration of the specified queue on a given port.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 port_id: The ID of the port cont=
aining the queues.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 on: If :data:`True` the mbuf_fas=
t_free configuration will be enabled, otherwise<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 disabled.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 queue_id: The ID of the queue to=
 configure mbuf_fast_free on.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 verify: If :data:`True` the outp=
ut of the command will be scanned in an attempt to<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 verify that mbuf_f=
ast_free was set successfully on all ports.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Raises:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 InteractiveCommandExecutionError=
: If all queues could not be set successfully.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 toggle =3D &quot;on&quot; if on else &quot;off=
&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 output =3D self.send_command(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&quot;port {port_id} txq {queue=
_id} tx_offload mbuf_fast_free {toggle}&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if verify and &quot;Error&quot; in output:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._logger.debug(f&quot;Set qu=
eue offload config error\n{output}&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise InteractiveCommandExecutio=
nError(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&quot;Failed to g=
et offload config on port {port_id}, queue {queue_id}:\n{output}&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
-- <br>
2.50.1<br>
<br>
</blockquote></div>

--00000000000013e94706423f9ca6--
