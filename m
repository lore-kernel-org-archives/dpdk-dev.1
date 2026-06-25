Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 759EDCDB47C
	for <dpdk-dev@archiver.kernel.org>; Thu, 25 Jun 2026 02:07:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 308CA402A3;
	Thu, 25 Jun 2026 04:07:00 +0200 (CEST)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com
 [209.85.208.173])
 by mails.dpdk.org (Postfix) with ESMTP id 6836E40279
 for <dev@dpdk.org>; Thu, 25 Jun 2026 04:06:59 +0200 (CEST)
Received: by mail-lj1-f173.google.com with SMTP id
 38308e7fff4ca-39677242021so16692151fa.1
 for <dev@dpdk.org>; Wed, 24 Jun 2026 19:06:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782353219; cv=none;
 d=google.com; s=arc-20260327;
 b=qxzxfkduiuinzkW7Ho0iQCRdNtTjBvYIKEy1DRn+Jhb9dBD36z1SY83hNpNR0dNLMK
 WkIrtxHZTy4u7r9L5xY0Ex0vZHXuDliMaqt2uBMlkVQa+euV1YLZ91CN7Jm/vx2KGu6i
 kMxBRVetfZ1+OdSoMw59HcqG3NL3Hz/k55DG+8LK8dtOcggJHFgt/WvrExaqBehoxBch
 cE+y3+FhdPyGB84Tpg9wonZsS566E+SahyPljcAe6OhsSoFwfcl42dL/xcBZPj/r/1PB
 XD7beC13wrTSeeyujRn3gXZqQOUd/MaC1/+ThXwjMzX+eiYcAPqObDG0tHmbRDMmVHK9
 xb2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=iGTm638b5StGgTxSH0lqIgjnrZbAx5RcDrBy3zd8Ip4=;
 fh=2ALQ+imGWu3qHTTtPCcyNepn2wDX33Nfzmv0K1VTmlc=;
 b=jJRE6BoxxMAiA4QryUyO/TqWB7otYuY9dtKiKMxb+j2ysHoRvHmvZd5Moe/D0egKlB
 ZUp75YVoFvLFlAp0brkVPKESjsHM9HucQ38pgRXxdikt56x9AVtSl9EpHY3A1NHDhKn+
 YX9QZFUks4tsMTyGgwtvPs6RItD/qrzbSUkc/4O46HE0XcBDuqOlgX6CA2JI8sedqROh
 /T4OOdf6n11hWgJMmIrOqC1K217DpUoQ4l/o5vcBlDF1k9WWqjImJ0gIp1Bv90ppRM8b
 WCn2LsOCEtryXcj36auHcWoM8m17Us9Z58cfWMI9k5D5N7qlhx9V3hGiPY2iYHeaDhoh
 nWpA==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782353219; x=1782958019; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=iGTm638b5StGgTxSH0lqIgjnrZbAx5RcDrBy3zd8Ip4=;
 b=bvHjoWaQdEnrh45C45xQBCUGAkHmzqX2GIi4y3GZ5+wDYWplCCGEj5itVl9gw4Ev4t
 wsxS89/pFKkltW9MJTr08mWI5mluCp4sWk3GhaZQWuzS77RS7rW2rJkp7jPpJGtHILyT
 uCqJlpftr0fZURjcelK7DGfdozDo/R62gBjaSEQ7c/DZQYigXRZSGRgSLC+HAMKPIUqd
 Y76X9CjYSJDz40IUA4ceyEH/QrlwFVRc5/MnUEP/mQepmZzQbD9AeYt7gbCGLbjR6AGU
 EBQG0QWeV4N/nd7rb0UaDAgpsl308KRE3u94PtME8rSScTeTE25IGEbRLDDdOzM6+12T
 M0GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782353219; x=1782958019;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iGTm638b5StGgTxSH0lqIgjnrZbAx5RcDrBy3zd8Ip4=;
 b=GVy190SmqTWYwLU1YopAuoHNBbNHdyBi2NvwiydzAAUNrCrQLORdIvhdmlVBJEEcEm
 z4gFES0FP1f6p3LBIW2T07H9PZjKHE8jX8+sfixWKH375RQCUWr1afdVbooL6UDMq8cS
 YxpOcCZpx4kLa03gzrzVWQdXGlXixFA58+guLMW6bUnXIPt08mBOEVWEqioFS8GGpfhs
 6mO3ZUjo7dFIvLMKMyoFTYTtFyLFVqX6nEPih+LjdUxiK+q65OwHzR66bHj/JARX6uQ+
 3a1KjrFhGAZPjKExKoe2DRmflvyxmFhye+kwz2o0qLibkaVuZJkiu80CtcYeuBB5NhpU
 kuUQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro+YxLAZkRIjgoEqlF9DDXBcSRPPStck0BvN5y6PfCQmfrmD+oJdATGFaIhbDqgSRguzGw=@dpdk.org
X-Gm-Message-State: AOJu0Yy04Y/bJ3t6uGZWkcob0VM/Zcf5saXJZm/3d8yq66Td4iVZ+83I
 UVptyGcl4k+3WHKJVmUstyUDydq7hfzAxl4LqmTd8XrT85DgdvdY14ArZen2BUu+wHdSwp1+L21
 8eEDqAlWzvUfyMs6DTUta6YNu5pnKMCI=
X-Gm-Gg: AfdE7clV15xOjQgvNmBIxtKtO+cGfAPm5c6iKDoQ3PF/QCwyXpq6cSuPMx7YRWQcTw4
 6V+S70kJQkg+oUkee1g2ZP76dcRzUlhOS+9ixgktKzZ/oELju0Qd+OLOS9MceL00s0yqqG0nQry
 2bvGnhosoTXzct6C/d1ywxhC89A+FwfyxiMGJGdrDkj9/y5r3XqpAwFCGXu+y5tdlbkQT96cleT
 I0wiLsqc1ISKPaE0sca3Q5fX67g6TrYBCSDW2l7f9vuk4fFmuPhYq8GGp6y6c19cnaO5Dp19GlI
 PXB4s1Urzm8GufZcFlFUVYraurXwS9uAP1kwPIyVl89oaf4zYT2xQx2X3/X7uKBPSL8=
X-Received: by 2002:a05:6512:24c5:20b0:5ae:9de4:4907 with SMTP id
 2adb3069b0e04-5aea1f5b463mr65511e87.53.1782353218273; Wed, 24 Jun 2026
 19:06:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260602163647.101815-1-knimoji@iol.unh.edu>
 <20260624213307.2095056-1-knimoji@iol.unh.edu>
In-Reply-To: <20260624213307.2095056-1-knimoji@iol.unh.edu>
From: Patrick Robb <patrickrobb1997@gmail.com>
Date: Wed, 24 Jun 2026 22:06:46 -0400
X-Gm-Features: AVVi8Cfmr7DtU2hnX8s2jz0P_YAMTk9Ed8_KBIIZI0WYO7rCZSBECnE_ixN2Fv4
Message-ID: <CAK6DuxucO6-D0qTeTb=mdpWWP48j9rDyvbwfHGgjfwQXTM93Gg@mail.gmail.com>
Subject: Re: [PATCH v4] dts: report dut/NIC info during DTS run
To: Koushik Bhargav Nimoji <knimoji@iol.unh.edu>
Cc: luca.vizzarro@arm.com, dev@dpdk.org, abailey@iol.unh.edu, 
 ahassick@iol.unh.edu, lylavoie@iol.unh.edu
Content-Type: multipart/alternative; boundary="00000000000070860706550a7266"
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

--00000000000070860706550a7266
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 24, 2026 at 5:33=E2=80=AFPM Koushik Bhargav Nimoji <knimoji@iol=
.unh.edu>
wrote:

> This patch gathers NIC info during a DTS run and writes it to an output
> json file. This allows the json file to be used when reporting results
> on the DTS results dashboard.
>
> Signed-off-by: Koushik Bhargav Nimoji <knimoji@iol.unh.edu>
> ---
> v2:
>     *Resolved merge conflicts
> v3:
>     *Fixed an issue with retrieving
>      the NIC's hardware version
> v4:
>     *Moved nic info gathering step before the nics get
>      binded to their respective drivers
>     *Condensed some areas of code in order to make them
>      more readable
>     *Removed redundant None checks and added some where
>      required
>     *Fixed LshwOutput class to better reflect the lshw
>      command output
> ---
>  dts/framework/test_run.py                    |  8 +++
>  dts/framework/testbed_model/linux_session.py | 68 ++++++++++++++++++++
>  dts/framework/testbed_model/os_session.py    | 11 ++++
>  3 files changed, 87 insertions(+)
>
> diff --git a/dts/framework/test_run.py b/dts/framework/test_run.py
> index 94dc6023a7..c92fe90f2e 100644
> --- a/dts/framework/test_run.py
> +++ b/dts/framework/test_run.py
> @@ -98,6 +98,7 @@
>          "InternalError" -> "exit":ew
>  """
>
> +import json
>  import random
>  from collections import deque
>  from collections.abc import Iterable
> @@ -347,6 +348,12 @@ def next(self) -> State | None:
>          test_run.ctx.dpdk.setup()
>          test_run.ctx.topology.setup()
>
> +        used_nic_info: list[dict[str, str]] =3D
> self.test_run.ctx.sut_node.main_session.get_nic_info()
>

drop "used" for nic_info or change to testrun_nic_info?


> +        with open(f"{SETTINGS.output_dir}/dut_info.json", "w") as file:
> +            json.dump(used_nic_info, file, indent=3D3)
> +
> +        self.logger.info(f"DUT NIC info written to:
> {SETTINGS.output_dir}/dut_info.json")
> +
>          if test_run.config.use_virtual_functions:
>              test_run.ctx.topology.instantiate_vf_ports()
>          if test_run.ctx.sut_node.cryptodevs and test_run.config.crypto:
> @@ -370,6 +377,7 @@ def next(self) -> State | None:
>          test_run.supported_capabilities =3D get_supported_capabilities(
>              test_run.ctx.sut_node, test_run.ctx.topology,
> test_run.required_capabilities
>          )
> +
>          return TestRunExecution(test_run, self.result)
>
>      def on_error(self, ex: BaseException) -> State | None:
> diff --git a/dts/framework/testbed_model/linux_session.py
> b/dts/framework/testbed_model/linux_session.py
> index 3a6e97974b..9e9146c372 100644
> --- a/dts/framework/testbed_model/linux_session.py
> +++ b/dts/framework/testbed_model/linux_session.py
> @@ -38,6 +38,8 @@ class LshwConfigurationOutput(TypedDict):
>      driver: str
>      #:
>      link: str
> +    #:
> +    firmware: str
>
>
>  class LshwOutput(TypedDict):
> @@ -61,6 +63,12 @@ class LshwOutput(TypedDict):
>              ...
>      """
>
> +    #:
> +    vendor: NotRequired[str]
> +    #:
> +    product: NotRequired[str]
> +    #:
> +    version: NotRequired[str]
>      #:
>      businfo: str
>      #:
> @@ -197,6 +205,66 @@ def unbind_ports(self, ports: list[Port]):
>          if self._lshw_net_info:
>              del self._lshw_net_info
>
> +    def get_nic_info(self) -> list[dict[str, str]]:
> +        """Overrides :meth`~.os_session.OSSession.get_nic_info`.
> +
> +        Raises:
> +            ConfigurationError: If the NIC info could not be found.
> +        """
> +        port_data =3D {
> +            port.get("businfo"): port for port in self._lshw_net_info if
> port.get("businfo")
> +        }
> +
> +        all_nic_info: list[dict[str, str]] =3D []
> +        for port in self._config.ports:
> +            pci_addr =3D port.pci
> +
> +            command_result =3D self.send_command(
>

rename to lshw_result please.


> +                f"sudo lshw -c network -businfo | grep '{pci_addr}' | cu=
t
> -d'@' -f1"
> +            )
> +            if command_result.return_code !=3D 0 and command_result.stdo=
ut
> =3D=3D "":
> +                raise ConfigurationError(f"Unable to get bus type for
> port {pci_addr}.")
> +            bus_type =3D command_result.stdout
> +
> +            bus_info =3D f"{bus_type}@{pci_addr}"
> +            nic_port: LshwOutput | None =3D port_data[bus_info]
> +            if nic_port is None:
> +                raise ConfigurationError(f"Port {pci_addr} could not be
> found on the node.")
> +
> +            config: LshwConfigurationOutput | None =3D
> nic_port["configuration"]
> +            if config is None:
> +                raise ConfigurationError(
> +                    f"Configuration info for port {pci_addr} could not b=
e
> found on the node."
> +                )
> +
> +            if "logicalname" not in nic_port:
> +                raise ConfigurationError(
> +                    f"Logical name for port {pci_addr} could not be foun=
d
> on the node."
> +                )
> +
> +            command_result =3D self.send_command(
>

ethtool_result


> +                f"ethtool {nic_port['logicalname']} | grep 'Speed:' | aw=
k
> '{{print $2}}'"
> +            )

+            if command_result.return_code =3D=3D 0 and command_result.stdo=
ut:
> +                nic_speed =3D command_result.stdout
> +            else:
> +                self._logger.error(f"Unable to get speed for NIC:
> {pci_addr}")
> +                nic_speed =3D None
> +
> +            dut_json =3D {
> +                "make": nic_port["vendor"] if "vendor" in nic_port else
> "Unknown",
> +                "model": nic_port["product"] if "product" in nic_port
> else "Unknown",
> +                "hardware version": nic_port["version"] if "version" in
> nic_port else "Unknown",
> +                "firmware version": config["firmware"] if "firmware" in
> config else "Unknown",
> +                "deviceBusType": bus_type,
> +                "deviceId": nic_port["serial"] if "serial" in nic_port
> else "Unknown",
> +                "pmd": config["driver"] if "driver" in config else
> "Unknown",
> +                "speed": nic_speed or "Unknown",
> +            }
> +            all_nic_info.append(dut_json)
> +
> +        return all_nic_info
> +
>

What is the intended behavior for cryptodev tests? I realize the ports list
will be empty and we will not enter the initial loop, but is this intended?
Do we want to gether cryptodev info too?


>      def bind_ports_to_driver(self, ports: list[Port], driver_name: str)
> -> None:
>
>
Reviewed-by: Patrick Robb <patrickrobb1997@gmail.com>

--00000000000070860706550a7266
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Jun 24,=
 2026 at 5:33=E2=80=AFPM Koushik Bhargav Nimoji &lt;<a href=3D"mailto:knimo=
ji@iol.unh.edu">knimoji@iol.unh.edu</a>&gt; wrote:<br></div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex">This patch gathers NIC info during a DTS=
 run and writes it to an output<br>
json file. This allows the json file to be used when reporting results<br>
on the DTS results dashboard.<br>
<br>
Signed-off-by: Koushik Bhargav Nimoji &lt;<a href=3D"mailto:knimoji@iol.unh=
.edu" target=3D"_blank">knimoji@iol.unh.edu</a>&gt;<br>
---<br>
v2:<br>
=C2=A0 =C2=A0 *Resolved merge conflicts<br>
v3:<br>
=C2=A0 =C2=A0 *Fixed an issue with retrieving<br>
=C2=A0 =C2=A0 =C2=A0the NIC&#39;s hardware version=C2=A0 =C2=A0<br>
v4:<br>
=C2=A0 =C2=A0 *Moved nic info gathering step before the nics get<br>
=C2=A0 =C2=A0 =C2=A0binded to their respective drivers <br>
=C2=A0 =C2=A0 *Condensed some areas of code in order to make them<br>
=C2=A0 =C2=A0 =C2=A0more readable<br>
=C2=A0 =C2=A0 *Removed redundant None checks and added some where<br>
=C2=A0 =C2=A0 =C2=A0required<br>
=C2=A0 =C2=A0 *Fixed LshwOutput class to better reflect the lshw<br>
=C2=A0 =C2=A0 =C2=A0command output<br>
---<br>
=C2=A0dts/framework/test_run.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 8 +++<br>
=C2=A0dts/framework/testbed_model/linux_session.py | 68 +++++++++++++++++++=
+<br>
=C2=A0dts/framework/testbed_model/os_session.py=C2=A0 =C2=A0 | 11 ++++<br>
=C2=A03 files changed, 87 insertions(+)<br>
<br>
diff --git a/dts/framework/test_run.py b/dts/framework/test_run.py<br>
index 94dc6023a7..c92fe90f2e 100644<br>
--- a/dts/framework/test_run.py<br>
+++ b/dts/framework/test_run.py<br>
@@ -98,6 +98,7 @@<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;InternalError&quot; -&gt; &quot;exi=
t&quot;:ew<br>
=C2=A0&quot;&quot;&quot;<br>
<br>
+import json<br>
=C2=A0import random<br>
=C2=A0from collections import deque<br>
=C2=A0from collections.abc import Iterable<br>
@@ -347,6 +348,12 @@ def next(self) -&gt; State | None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0test_run.ctx.dpdk.setup()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0test_run.ctx.topology.setup()<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 used_nic_info: list[dict[str, str]] =3D self.t=
est_run.ctx.sut_node.main_session.get_nic_info()<br></blockquote><div><br><=
/div><div>drop &quot;used&quot; for nic_info or change to testrun_nic_info?=
</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 with open(f&quot;{SETTINGS.output_dir}/dut_inf=
o.json&quot;, &quot;w&quot;) as file:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 json.dump(used_nic_info, file, i=
ndent=3D3)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"http://self.logger.info" rel=3D"nor=
eferrer" target=3D"_blank">self.logger.info</a>(f&quot;DUT NIC info written=
 to: {SETTINGS.output_dir}/dut_info.json&quot;)<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if test_run.config.use_virtual_functions:=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0test_run.ctx.topology.insta=
ntiate_vf_ports()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if test_run.ctx.sut_node.cryptodevs and t=
est_run.config.crypto:<br>
@@ -370,6 +377,7 @@ def next(self) -&gt; State | None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0test_run.supported_capabilities =3D get_s=
upported_capabilities(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0test_run.ctx.sut_node, test=
_run.ctx.topology, test_run.required_capabilities<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0)<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return TestRunExecution(test_run, self.re=
sult)<br>
<br>
=C2=A0 =C2=A0 =C2=A0def on_error(self, ex: BaseException) -&gt; State | Non=
e:<br>
diff --git a/dts/framework/testbed_model/linux_session.py b/dts/framework/t=
estbed_model/linux_session.py<br>
index 3a6e97974b..9e9146c372 100644<br>
--- a/dts/framework/testbed_model/linux_session.py<br>
+++ b/dts/framework/testbed_model/linux_session.py<br>
@@ -38,6 +38,8 @@ class LshwConfigurationOutput(TypedDict):<br>
=C2=A0 =C2=A0 =C2=A0driver: str<br>
=C2=A0 =C2=A0 =C2=A0#:<br>
=C2=A0 =C2=A0 =C2=A0link: str<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 firmware: str<br>
<br>
<br>
=C2=A0class LshwOutput(TypedDict):<br>
@@ -61,6 +63,12 @@ class LshwOutput(TypedDict):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0...<br>
=C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>
<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 vendor: NotRequired[str]<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 product: NotRequired[str]<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 version: NotRequired[str]<br>
=C2=A0 =C2=A0 =C2=A0#:<br>
=C2=A0 =C2=A0 =C2=A0businfo: str<br>
=C2=A0 =C2=A0 =C2=A0#:<br>
@@ -197,6 +205,66 @@ def unbind_ports(self, ports: list[Port]):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if self._lshw_net_info:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0del self._lshw_net_info<br>
<br>
+=C2=A0 =C2=A0 def get_nic_info(self) -&gt; list[dict[str, str]]:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Overrides :meth`~.os_session=
.OSSession.get_nic_info`.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Raises:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ConfigurationError: If the NIC i=
nfo could not be found.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 port_data =3D {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 port.get(&quot;businfo&quot;): p=
ort for port in self._lshw_net_info if port.get(&quot;businfo&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 all_nic_info: list[dict[str, str]] =3D []<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 for port in self._config.ports:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pci_addr =3D port.pci<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 command_result =3D self.send_com=
mand(<br></blockquote><div><br></div><div>rename to lshw_result please.</di=
v><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&quot;sudo lshw -=
c network -businfo | grep &#39;{pci_addr}&#39; | cut -d&#39;@&#39; -f1&quot=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if command_result.return_code !=
=3D 0 and command_result.stdout =3D=3D &quot;&quot;:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise Configuratio=
nError(f&quot;Unable to get bus type for port {pci_addr}.&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bus_type =3D command_result.stdo=
ut<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bus_info =3D f&quot;{bus_type}@{=
pci_addr}&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 nic_port: LshwOutput | None =3D =
port_data[bus_info]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if nic_port is None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise Configuratio=
nError(f&quot;Port {pci_addr} could not be found on the node.&quot;)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 config: LshwConfigurationOutput =
| None =3D nic_port[&quot;configuration&quot;]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if config is None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise Configuratio=
nError(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&qu=
ot;Configuration info for port {pci_addr} could not be found on the node.&q=
uot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if &quot;logicalname&quot; not i=
n nic_port:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise Configuratio=
nError(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&qu=
ot;Logical name for port {pci_addr} could not be found on the node.&quot;<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 command_result =3D self.send_com=
mand(<br></blockquote><div><br></div><div>ethtool_result</div><div>=C2=A0</=
div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bor=
der-left:1px solid rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&quot;ethtool {ni=
c_port[&#39;logicalname&#39;]} | grep &#39;Speed:&#39; | awk &#39;{{print $=
2}}&#39;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<span style=3D"background-color=
:transparent">=C2=A0</span></blockquote><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if command_result.return_code =
=3D=3D 0 and command_result.stdout:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 nic_speed =3D comm=
and_result.stdout<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._logger.error=
(f&quot;Unable to get speed for NIC: {pci_addr}&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 nic_speed =3D None=
<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dut_json =3D {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;make&quot;: =
nic_port[&quot;vendor&quot;] if &quot;vendor&quot; in nic_port else &quot;U=
nknown&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;model&quot;:=
 nic_port[&quot;product&quot;] if &quot;product&quot; in nic_port else &quo=
t;Unknown&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;hardware ver=
sion&quot;: nic_port[&quot;version&quot;] if &quot;version&quot; in nic_por=
t else &quot;Unknown&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;firmware ver=
sion&quot;: config[&quot;firmware&quot;] if &quot;firmware&quot; in config =
else &quot;Unknown&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;deviceBusTyp=
e&quot;: bus_type,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;deviceId&quo=
t;: nic_port[&quot;serial&quot;] if &quot;serial&quot; in nic_port else &qu=
ot;Unknown&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;pmd&quot;: c=
onfig[&quot;driver&quot;] if &quot;driver&quot; in config else &quot;Unknow=
n&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;speed&quot;:=
 nic_speed or &quot;Unknown&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 all_nic_info.append(dut_json)<br=
>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return all_nic_info<br>
+<br></blockquote><div><br></div><div>What is the intended behavior for cry=
ptodev tests? I realize the ports list will be empty and we will not enter =
the initial loop, but is this intended? Do we want to gether=C2=A0cryptodev=
 info too?</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-le=
ft:1ex">
=C2=A0 =C2=A0 =C2=A0def bind_ports_to_driver(self, ports: list[Port], drive=
r_name: str) -&gt; None:<br><br></blockquote><div><br></div><div>Reviewed-b=
y: Patrick Robb &lt;<a href=3D"mailto:patrickrobb1997@gmail.com">patrickrob=
b1997@gmail.com</a>&gt;=C2=A0</div></div></div>

--00000000000070860706550a7266--
