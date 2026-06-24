Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95844CDB479
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Jun 2026 18:44:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AD2BF402D2;
	Wed, 24 Jun 2026 20:44:20 +0200 (CEST)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com
 [209.85.208.52]) by mails.dpdk.org (Postfix) with ESMTP id A7E09402C6
 for <dev@dpdk.org>; Wed, 24 Jun 2026 20:44:19 +0200 (CEST)
Received: by mail-ed1-f52.google.com with SMTP id
 4fb4d7f45d1cf-697564cb69eso1181888a12.0
 for <dev@dpdk.org>; Wed, 24 Jun 2026 11:44:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782326659; cv=none;
 d=google.com; s=arc-20240605;
 b=AkzybQLZX8C2hDBGFBIvn17WzjEogSm0vwpRPkRJDZKoLb0i+1NX+hs2nOrVtfDbZn
 p53emsB3xASGYhP0YUfL9pCRJ8BcaBKXIxs7jHiMULESg7xXrCMwGP3YaUTFM8zd67mK
 L/yojd4WBMJBvSWrawT452A6oFHGyVHC+w3EjEPwNRePIYOUvmpEURsiWL/jP2nOBUfw
 nIEDUi5zMyUIJG6DROy94QOSu8GEACtpEKGo4Dl6CHzkz/qoN7rNL5rVeEwfSiyOYBnP
 TzdeGrfMDXMAiWMWkAXkbaF70UcrzmBrlylAWfMX47MdsQvSFEQnQhNZuxw8XocN3Tx8
 RaFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ZzU8T2vbhB9HsxHA+9YE1Sl4cYJxw6WoOtJq8/Afc7Y=;
 fh=4hsYhFnr6DLNNV+hMod8lIxg+OS0iQbpQroj08RThkA=;
 b=T2NZj8Wg6PpJLlzspsK61v6cbBz/1W5KXW4LpAYSulDWf/TLA2j1/wnIJKRj7PmpEx
 Tc4fWy4REsD/+rt2yZJvxtqDipGe5GTkzNAOwjpnADbfsEfRPJ0bRNX6BgBu2tZLzBLn
 N3yIkh1UeeAwr7CdvKbPWOrV8JmsywxgDBaOLlel3jzVSHMoAM6F3DQ/7W/HUk2PA4l1
 pZtpqZ+TPuk0u9P4RzcryTSSuRkqHQ2wUiAWSXh6jyWs8uLMFQe/nnZdhssGZvY4GnVr
 MMutUiNQQBxOdUNbZmFMXzvkKcZ7urRUWJWpbFWNQqFqVORnxWheKN4mub0Xy9A8yn8T
 q7mg==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1782326659; x=1782931459; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZzU8T2vbhB9HsxHA+9YE1Sl4cYJxw6WoOtJq8/Afc7Y=;
 b=fDlJffTZugpk0OmvLsv5+U461hbxz2WUiUYqt9Xq7s3oXpQhwIEzJxszs5VlRQXmG7
 b3xHnxcCupAMiXbEoV2cJVMwLqaSsbqhHQTKte/bx9BU/Zsvb9Hsrn0KzMKT+mGpi9gs
 tOnuhimdisD8VMiHExtkhJrMj4zo08bPeJKzo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782326659; x=1782931459;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZzU8T2vbhB9HsxHA+9YE1Sl4cYJxw6WoOtJq8/Afc7Y=;
 b=k0iB2FkARiBVw21fto74VBQcqYYCLdw3b4+4cpVNddnwQgis69DDNaCEC4vLAA7egp
 Iar5FTzsTCfeCV82ko8DSzzLePSzo9J7bRInpM7Q1I92ie28pXd2w1r/hB/Vl+uOhgRp
 I7UaeG5qMhMRRjYHGrbr4NEPxDWoQs0LqGGoLTLl9UKXil/FHA+k+KtSGUk8bV/4TMGS
 jNWxQVmMT/591POWh+xiIEm0QsVopCFYfP0XPTXjKr6S+CSiXctBlv9EqNyL2M/pij8A
 KNIvf00g12K/PT85BepHPcTpWSQVCUIer7gvqbjriCvRw8ozki2Xajeqeeq6z8AQy3x2
 m/Vg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpYeFRTxJ6YTpGUdXW7HX6tOvR5J/7lP5SJyClZYlmacJfYm2grIZ3XZ4cf7AWKYAGUh0A=@dpdk.org
X-Gm-Message-State: AOJu0YzEgOGUOSfah06Vbows/ub99lbUEPakHn08vIwSs5CI6C0b3rnf
 gv7BqsyYhgvXF1qM8GFQJrutUcc/Lwzy48E6kVuBWdZ8RP9GTKOphFNonFK3AJC9SgBZdCvIhrh
 qKtOLzdKTgvCSXCC02XgAbmdgxnN7TTI2z0KF2Soc1g==
X-Gm-Gg: AfdE7claw6xTik6RkXKBGM6iWf0+XKfbvmE8KMQQSll7IO4YlMr4TjVi6SttjCI6spc
 ECZK+tUyyvHbWcqfGKIZja8ERP4vmVqEI4p6ZPOcn4fCAFBU1twKrVe2Q8uKBFAoyzZ2+VRsQKS
 9G3BDCDmZMSgap5UtsfJkMGXziZYtaKK3MzSMNXuW5m++OD406+z1m4rZKELY95cqis8hxSa6bT
 ocmyPACg0ec6WKs7itoz2il7uFrP+hz2YUekNE26waRsHcWejEKPqgNGzcucmER35ujofplgNMr
 B45q9xDnBU0ToWRKuTk8M0YkEC/3Wfs=
X-Received: by 2002:a05:6402:4502:b0:697:7f68:4340 with SMTP id
 4fb4d7f45d1cf-697f3aabe70mr2155912a12.20.1782326658287; Wed, 24 Jun 2026
 11:44:18 -0700 (PDT)
MIME-Version: 1.0
References: <20260602163647.101815-1-knimoji@iol.unh.edu>
 <20260623184902.1657251-1-knimoji@iol.unh.edu>
In-Reply-To: <20260623184902.1657251-1-knimoji@iol.unh.edu>
From: Andrew Bailey <abailey@iol.unh.edu>
Date: Wed, 24 Jun 2026 14:44:07 -0400
X-Gm-Features: AVVi8CdT8JkO-emzL8WI9OwtpzsyWGGbP7sO20UCLWPKZZuTSoYtzkBnyWqz8Ak
Message-ID: <CABJ3N2VBum7rVAB9hYUkXszH3-fvdjTdtVo=7VarS8SZOVsM0Q@mail.gmail.com>
Subject: Re: [PATCH v3] dts: report dut/NIC info during DTS run
To: Koushik Bhargav Nimoji <knimoji@iol.unh.edu>
Cc: luca.vizzarro@arm.com, patrickrobb1997@gmail.com, dev@dpdk.org, 
 ahassick@iol.unh.edu, lylavoie@iol.unh.edu
Content-Type: multipart/alternative; boundary="00000000000057614706550443af"
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

--00000000000057614706550443af
Content-Type: text/plain; charset="UTF-8"

>
> +
> +        used_nic_info: list[dict[str, object]] = (
> +            self.test_run.ctx.sut_node.main_session.get_nic_info()
> +        )
> +        with open(f"{SETTINGS.output_dir}/dut_info.json", "w") as file:
> +            json.dump(used_nic_info, file, indent=3)
> +            file.close()
>

file.close() is redundant and can be removed.
More importantly, the info is gathered after the dut nics have been bound
to the dpdk driver. This is an issue if a driver is bound to vfio-pci since
it has limited visibility from the commands used to gather info. I tested
this with broadcom cards which showed various info fields that were empty
or None. This is resolved by moving this snippet before the DUT ports are
bound. Keep in mind to test your patches against multiple NICs,
preferably with different drivers.


> +        self.logger.info(f"DUT NIC info written to:
> {SETTINGS.output_dir}/dut_info.json")
> +
>          return TestRunExecution(test_run, self.result)
>
>      def on_error(self, ex: BaseException) -> State | None:
> diff --git a/dts/framework/testbed_model/linux_session.py
> b/dts/framework/testbed_model/linux_session.py
> index 30c89ad70d..67eba33ce8 100644
> --- a/dts/framework/testbed_model/linux_session.py
> +++ b/dts/framework/testbed_model/linux_session.py
> @@ -197,6 +197,70 @@ def unbind_ports(self, ports: list[Port]):
>          if self._lshw_net_info:
>              del self._lshw_net_info
>
> +    def get_nic_info(self) -> list[dict[str, object]]:
>

object may be too generic, are there issues tightening the type hinting on
this signature?


> +        """Overrides :meth`~.os_session.OSSession.get_nic_info`.
> +
> +        Raises:
> +            ConfigurationError: If the NIC info could not be found.
> +        """
> +        port_data = {
> +            port.get("businfo"): port for port in self._lshw_net_info if
> port.get("businfo")
> +        }
> +
> +        all_nic_info = []
>

all_nic_info should be type hinted


> +        for port in self._config.ports:
> +            pci_addr = port.pci
> +
> +            command_result = self.send_command(
> +                f"sudo lshw -c network -businfo | grep '{pci_addr}' | cut
> -d'@' -f1"
> +            )
>



> +            bus_type = (
> +                command_result.stdout
> +                if command_result.return_code == 0 and
> command_result.stdout
> +                else None
> +            )
> +            if bus_type is None:
> +                raise ConfigurationError(f"Unable to get bus type for
> port {pci_addr}.")
>

There is a redundant check on setting the variable and then verifying.
Since you are throwing an exception if there is no valid value, you could
do a check once and throw an error and then set the variable after with no
further checks required. This makes it more readable in my opinion but let
me know if you disagree, for example...

 if command.code != 0 or command.stdout == '':
     raise ConfigurationError()
bus_type = command.stdout

+            bus_info = f"{bus_type}@{pci_addr}"
> +
> +            nic_port: LshwOutput | None = port_data.get(bus_info)
> +            if nic_port is None:
> +                raise ConfigurationError(f"Port {pci_addr} could not be
> found on the node.")
> +
> +            config: LshwConfigurationOutput | None =
> nic_port.get("configuration")
> +            if config is None:
> +                raise ConfigurationError(
> +                    f"Configuration info for port {pci_addr} could not be
> found on the node."
> +                )
> +
> +            nic_name = nic_port.get("logicalname")
> +            nic_speed = None
> +            if nic_name is not None:
> +                command_result = self.send_command(
> +                    f"ethtool {nic_name} | grep 'Speed:' | awk '{{print
> $2}}'"
> +                )
> +                nic_speed = (
> +                    command_result.stdout
> +                    if command_result.return_code == 0 and
> command_result.stdout
> +                    else None
> +                )
> +            if nic_speed is None:
> +                self._logger.error(f"Unable to get speed for NIC:
> {pci_addr}")
>

this code can be condensed as well, redundant check but logic is good.

If the intention is to report unknown in this case, it should be mentioned
in this log message.
Also I'm not sure if this has a logger level error if everything runs fine
in this case.
Maybe info or warning level is sufficient.


> +

+            dut_json = {
> +                "make": nic_port.get("vendor"),
> +                "model": nic_port.get("product"),
> +                "hardware version": nic_port.get("version") or "Unknown",
> +                "firmware version": config.get("firmware"),
> +                "deviceBusType": bus_type,
> +                "deviceId": nic_port.get("serial"),
> +                "pmd": config.get("driver"),
> +                "speed": nic_speed or "Unknown",
> +            }
> +            all_nic_info.append(dut_json)
> +
> +        return all_nic_info
> +
>      def bind_ports_to_driver(self, ports: list[Port], driver_name: str)
> -> None:
>          """Overrides :meth:`~.os_session.OSSession.bind_ports_to_driver
>
>

--00000000000057614706550443af
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote gmail_quote_container"><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex">+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 used_nic_info: list[dict[str, object]] =3D (<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.test_run.ctx.sut_node.main_=
session.get_nic_info()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 with open(f&quot;{SETTINGS.output_dir}/dut_inf=
o.json&quot;, &quot;w&quot;) as file:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 json.dump(used_nic_info, file, i=
ndent=3D3)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 file.close()<br></blockquote><di=
v>=C2=A0</div><div>file.close() is redundant and can be removed.<br>More im=
portantly, the info is gathered after the dut nics have been bound to the d=
pdk driver. This is an issue if a driver is bound to vfio-pci since it has =
limited visibility from the commands used to gather info. I tested this wit=
h broadcom cards which showed various info fields that were empty or None. =
This is resolved by moving this snippet before the DUT ports are bound. Kee=
p in mind to test your patches against multiple NICs, preferably=C2=A0with =
different drivers.=C2=A0<br>=C2=A0</div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"http://self.logger.info" rel=3D"nor=
eferrer" target=3D"_blank">self.logger.info</a>(f&quot;DUT NIC info written=
 to: {SETTINGS.output_dir}/dut_info.json&quot;)<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return TestRunExecution(test_run, self.re=
sult)<br>
<br>
=C2=A0 =C2=A0 =C2=A0def on_error(self, ex: BaseException) -&gt; State | Non=
e:<br>
diff --git a/dts/framework/testbed_model/linux_session.py b/dts/framework/t=
estbed_model/linux_session.py<br>
index 30c89ad70d..67eba33ce8 100644<br>
--- a/dts/framework/testbed_model/linux_session.py<br>
+++ b/dts/framework/testbed_model/linux_session.py<br>
@@ -197,6 +197,70 @@ def unbind_ports(self, ports: list[Port]):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if self._lshw_net_info:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0del self._lshw_net_info<br>
<br>
+=C2=A0 =C2=A0 def get_nic_info(self) -&gt; list[dict[str, object]]:<br></b=
lockquote><div><br>object may be too generic, are there issues tightening t=
he type hinting on this signature?<br>=C2=A0</div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">
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
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 all_nic_info =3D []<br></blockquote><div>=C2=
=A0</div><div>all_nic_info should be type hinted<br>=C2=A0</div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 for port in self._config.ports:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pci_addr =3D port.pci<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 command_result =3D self.send_com=
mand(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&quot;sudo lshw -=
c network -businfo | grep &#39;{pci_addr}&#39; | cut -d&#39;@&#39; -f1&quot=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br></blockquote><div><br>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bus_type =3D (<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 command_result.std=
out<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if command_result.=
return_code =3D=3D 0 and command_result.stdout<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else None<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if bus_type is None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise Configuratio=
nError(f&quot;Unable to get bus type for port {pci_addr}.&quot;)<br></block=
quote><div><br>There is a redundant=C2=A0check on setting the variable and =
then verifying. Since you are throwing an exception if there is no valid va=
lue, you could do a check once and throw an error and then set the variable=
 after with no further checks required. This makes it more readable in my o=
pinion but let me know if you disagree,=C2=A0for example...<br><br>=C2=A0<s=
pan style=3D"background-color:transparent">if command.code !=3D 0 or comman=
d.stdout =3D=3D &#39;&#39;:</span></div>=C2=A0 =C2=A0 =C2=A0raise Configura=
tionError()<br>bus_type =3D command.stdout<br><br><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bus_info =3D f&quot;{bus_type}@{=
pci_addr}&quot;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 nic_port: LshwOutput | None =3D =
port_data.get(bus_info)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if nic_port is None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise Configuratio=
nError(f&quot;Port {pci_addr} could not be found on the node.&quot;)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 config: LshwConfigurationOutput =
| None =3D nic_port.get(&quot;configuration&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if config is None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise Configuratio=
nError(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&qu=
ot;Configuration info for port {pci_addr} could not be found on the node.&q=
uot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 nic_name =3D nic_port.get(&quot;=
logicalname&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 nic_speed =3D None<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if nic_name is not None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 command_result =3D=
 self.send_command(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&qu=
ot;ethtool {nic_name} | grep &#39;Speed:&#39; | awk &#39;{{print $2}}&#39;&=
quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 nic_speed =3D (<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 comm=
and_result.stdout<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if c=
ommand_result.return_code =3D=3D 0 and command_result.stdout<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else=
 None<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if nic_speed is None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._logger.error=
(f&quot;Unable to get speed for NIC: {pci_addr}&quot;)<br></blockquote><div=
><br></div><div>this code can be condensed as well, redundant check but log=
ic is good.=C2=A0<br><br>If the intention is to report unknown in this case=
, it should be mentioned in this log message.<br>Also I&#39;m not sure if t=
his has a logger level error if everything runs fine in this case. <br>Mayb=
e info or warning level is sufficient.<br>=C2=A0</div><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(20=
4,204,204);padding-left:1ex">
+<span style=3D"background-color:transparent">=C2=A0</span></blockquote><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dut_json =3D {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;make&quot;: =
nic_port.get(&quot;vendor&quot;),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;model&quot;:=
 nic_port.get(&quot;product&quot;),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;hardware ver=
sion&quot;: nic_port.get(&quot;version&quot;) or &quot;Unknown&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;firmware ver=
sion&quot;: config.get(&quot;firmware&quot;),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;deviceBusTyp=
e&quot;: bus_type,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;deviceId&quo=
t;: nic_port.get(&quot;serial&quot;),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;pmd&quot;: c=
onfig.get(&quot;driver&quot;),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;speed&quot;:=
 nic_speed or &quot;Unknown&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 all_nic_info.append(dut_json)<br=
>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return all_nic_info<br>
+<br>
=C2=A0 =C2=A0 =C2=A0def bind_ports_to_driver(self, ports: list[Port], drive=
r_name: str) -&gt; None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Overrides :meth:`~.os_s=
ession.OSSession.bind_ports_to_driver<br>
<br>
</blockquote></div></div>

--00000000000057614706550443af--
