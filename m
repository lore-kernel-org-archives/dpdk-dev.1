Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3017BCDB479
	for <dpdk-dev@archiver.kernel.org>; Thu, 25 Jun 2026 15:30:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ECA9F40616;
	Thu, 25 Jun 2026 17:30:54 +0200 (CEST)
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com
 [209.85.160.177])
 by mails.dpdk.org (Postfix) with ESMTP id DC6D3402D2
 for <dev@dpdk.org>; Thu, 25 Jun 2026 17:30:52 +0200 (CEST)
Received: by mail-qt1-f177.google.com with SMTP id
 d75a77b69052e-519ddebce3dso21582281cf.0
 for <dev@dpdk.org>; Thu, 25 Jun 2026 08:30:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782401452; cv=none;
 d=google.com; s=arc-20260327;
 b=DUXkzjU8Iyu5yXbB4Q7v3hRSWrZB9j2enii1IJpzlVXjxKv1KjoivxiUM0yHu0zC4r
 v99JvpJ0DL5vrIYLRWy4xaYOLItRrGRlzLG1QJTfeMGS5FYxyBz4yNlNtlYV9lMecy57
 9mti0C9/wXxfxshS606zEs8uq1R0QRI2uQK9pB8W5OgCsKC6nKiMk/hgpCPMt7/XDF8N
 XMOMl2Tt9kurv08tTa18snCGzils9PocSU75/9VXW2pDrQ9gNyuXU5S2++ORXHPfIz1p
 XFzQU9gzf56JCa93X3TWXHWOOaJ+2s6I9hjXUcT1pQ//vWJyIcF2PQy/dStbaobWTnEE
 C6HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=QN5WdL9LcNBic8KCYRRNKnKJcNLq3E7QrfJOVNRLFnc=;
 fh=01T75kqsSwLpqYHnA+wOLmyBipY7QQ7UDNF4Ckcnvhw=;
 b=S2W92yISZAxzKmi1D4VJy3Y+3Zl2oMHnpFDIgJg+ylVaQOd7IJ7oLk18QvGITfo66l
 FxYDkPGW2jzcS8zPRGoawKfl0aAuQc3IUIUoB4VzLTEs5F4FMvpY12hv2WhRENomZGuF
 nsiHZklSnYvykvTtvnNZF5E3PvTbvw+BJVmiehmwPtTlqgbyDJ2e9VfqNxTVnbXjObuE
 u19h5oq+qJcZiDTszl6PiAfjZLkTIJhF1W2ct1Pl5J5HxMuvUcaNDRabMSRs1MPuCEwl
 PfmgiaAL4HveHJXFzeTFWqBh7OXockz4dGdEj1ciBIvFET9Ssx7sQ7KXc/m1aWYkCRAs
 fqIA==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1782401452; x=1783006252; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QN5WdL9LcNBic8KCYRRNKnKJcNLq3E7QrfJOVNRLFnc=;
 b=do6XVun+ccRpciaZsf78QrdSQR+rb9FHWwz1Pq/Zcyfn/cgQGftII7sjdr2NeaaJbx
 3zhmNJK42DsFPSLhBqRKRCnfdoQpYdbWo8TQ6+dRMkhGMnorycZHfaGS4e+lSwZAr04j
 UYm74hPcwh0yy3jhrIKOMw0Wn9gm76/ZrSXcQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782401452; x=1783006252;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QN5WdL9LcNBic8KCYRRNKnKJcNLq3E7QrfJOVNRLFnc=;
 b=a5nKeu3bhC4+dm2EuK2lCKT1Qve84qBkXT4Ik8Pe7tR/uF1aw3atWMdTE6cJpik2IK
 se0RDtneYlAzhGoxhYRagvxKV50u/JD4zIQ0VjJKtEZBty/hbAZ2XpRRXJ6KQ7Bqxr+6
 jqNzr5rSLtSze+8gFrUtpjFdKFCXzwNrEMecMbGDtTpNA8Nz/i9fcUiDyg2+97SdfGYD
 6eMLdhbekFiwNCilPx6KNG0WQnlhg9orh8TiJ6D6B+imXTaFaaDcTnDzornCA4mw5I7v
 fPGJZ24N3c6dqaVH3XBQMpAzbrN5PgBco8Nj08VR4NvU0woUjW5dGQ//95FddXIddanL
 6HKw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8zQ/JWQXr7kMwpaXPMRQRGJraBriHemSVyPmJTk4WtdPZCaegECDbVCt3oK5A9yNjEeJc=@dpdk.org
X-Gm-Message-State: AOJu0YzXLbrDXiZ5D7F3XxwrwgTDOj/WqIbgjcRZYeTQ/XDHRRRsJjBs
 x/qwRkFFg+C2su1EFBeuXtHmtMVsHyvWZKdE9HZ6Cvjg9TCK3ExPHPnbLvKpqIEQByzV9uDe+gt
 gGCgiDVlFT93H+cBLYVHkOYf2JmBfQd0CzRdJ8lpGTg==
X-Gm-Gg: AfdE7cmZQroBLi41PxWPFFD583HtRKhaQrGrCEY9Pop19Y0Qp3ffEsSFJ4qD/GPa2ZY
 UhlLCdSWXh5cIMSViIVDkyadPGz72AqBcIIZOntV3mVU6IfJuN7/juZegZdtu8F8ymhwKJqeZXQ
 6INdjDli4cUf9DvGBfV6hhaDpCQpsCnfWIb9feqMZXEVmGmT0K+yjl5PuT/zxCcJNCEihLLDgfs
 pNRFrOCdw+Cy2Yk7fhX4I6bWxuAUAvFaxJJx/lcwKWlRoIr3hA6Zj5ireLXqR7m+ucSlG3iuUuo
 nzMXBeaA6Fo9Bm5dXCoxpJJyl+fYdkaE4WI8mm55lrzJBYCoOm2jEdKVFEPLbHep5Ene2RTEoVd
 4GlJIARovVv/dwaZHGXALetZJPiNrqf4TNXumQkmedXmtpxCCcFOhvOLG4vB6uw==
X-Received: by 2002:a05:622a:3c7:b0:51a:17f1:a6ad with SMTP id
 d75a77b69052e-51a7283aa8emr38768541cf.31.1782401448711; Thu, 25 Jun 2026
 08:30:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260602163647.101815-1-knimoji@iol.unh.edu>
 <20260624213307.2095056-1-knimoji@iol.unh.edu>
 <CAK6DuxucO6-D0qTeTb=mdpWWP48j9rDyvbwfHGgjfwQXTM93Gg@mail.gmail.com>
In-Reply-To: <CAK6DuxucO6-D0qTeTb=mdpWWP48j9rDyvbwfHGgjfwQXTM93Gg@mail.gmail.com>
From: Koushik Bhargav Nimoji <knimoji@iol.unh.edu>
Date: Thu, 25 Jun 2026 11:30:12 -0400
X-Gm-Features: AVVi8Ccg6duRQLCFId6XD47mK2zAmGL7lf2EDCCMpwQ0mUC0K5qa7bSWI3aJ1-g
Message-ID: <CAKYPG+y4_Z_c4KGQ1aq2r5TjyinKz3b77iJVO5bLgnbp5i+RGw@mail.gmail.com>
Subject: Re: [PATCH v4] dts: report dut/NIC info during DTS run
To: Patrick Robb <patrickrobb1997@gmail.com>
Cc: luca.vizzarro@arm.com, dev@dpdk.org, abailey@iol.unh.edu, 
 ahassick@iol.unh.edu, lylavoie@iol.unh.edu
Content-Type: multipart/alternative; boundary="00000000000032e7e5065515ad81"
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

--00000000000032e7e5065515ad81
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 24, 2026 at 10:06=E2=80=AFPM Patrick Robb <patrickrobb1997@gmai=
l.com>
wrote:

>
>
> On Wed, Jun 24, 2026 at 5:33=E2=80=AFPM Koushik Bhargav Nimoji <
> knimoji@iol.unh.edu> wrote:
>
>> This patch gathers NIC info during a DTS run and writes it to an output
>> json file. This allows the json file to be used when reporting results
>> on the DTS results dashboard.
>>
>> Signed-off-by: Koushik Bhargav Nimoji <knimoji@iol.unh.edu>
>> ---
>> v2:
>>     *Resolved merge conflicts
>> v3:
>>     *Fixed an issue with retrieving
>>      the NIC's hardware version
>> v4:
>>     *Moved nic info gathering step before the nics get
>>      binded to their respective drivers
>>     *Condensed some areas of code in order to make them
>>      more readable
>>     *Removed redundant None checks and added some where
>>      required
>>     *Fixed LshwOutput class to better reflect the lshw
>>      command output
>> ---
>>  dts/framework/test_run.py                    |  8 +++
>>  dts/framework/testbed_model/linux_session.py | 68 ++++++++++++++++++++
>>  dts/framework/testbed_model/os_session.py    | 11 ++++
>>  3 files changed, 87 insertions(+)
>>
>> diff --git a/dts/framework/test_run.py b/dts/framework/test_run.py
>> index 94dc6023a7..c92fe90f2e 100644
>> --- a/dts/framework/test_run.py
>> +++ b/dts/framework/test_run.py
>> @@ -98,6 +98,7 @@
>>          "InternalError" -> "exit":ew
>>  """
>>
>> +import json
>>  import random
>>  from collections import deque
>>  from collections.abc import Iterable
>> @@ -347,6 +348,12 @@ def next(self) -> State | None:
>>          test_run.ctx.dpdk.setup()
>>          test_run.ctx.topology.setup()
>>
>> +        used_nic_info: list[dict[str, str]] =3D
>> self.test_run.ctx.sut_node.main_session.get_nic_info()
>>
>
> drop "used" for nic_info or change to testrun_nic_info?
>
>
>> +        with open(f"{SETTINGS.output_dir}/dut_info.json", "w") as file:
>> +            json.dump(used_nic_info, file, indent=3D3)
>> +
>> +        self.logger.info(f"DUT NIC info written to:
>> {SETTINGS.output_dir}/dut_info.json")
>> +
>>          if test_run.config.use_virtual_functions:
>>              test_run.ctx.topology.instantiate_vf_ports()
>>          if test_run.ctx.sut_node.cryptodevs and test_run.config.crypto:
>> @@ -370,6 +377,7 @@ def next(self) -> State | None:
>>          test_run.supported_capabilities =3D get_supported_capabilities(
>>              test_run.ctx.sut_node, test_run.ctx.topology,
>> test_run.required_capabilities
>>          )
>> +
>>          return TestRunExecution(test_run, self.result)
>>
>>      def on_error(self, ex: BaseException) -> State | None:
>> diff --git a/dts/framework/testbed_model/linux_session.py
>> b/dts/framework/testbed_model/linux_session.py
>> index 3a6e97974b..9e9146c372 100644
>> --- a/dts/framework/testbed_model/linux_session.py
>> +++ b/dts/framework/testbed_model/linux_session.py
>> @@ -38,6 +38,8 @@ class LshwConfigurationOutput(TypedDict):
>>      driver: str
>>      #:
>>      link: str
>> +    #:
>> +    firmware: str
>>
>>
>>  class LshwOutput(TypedDict):
>> @@ -61,6 +63,12 @@ class LshwOutput(TypedDict):
>>              ...
>>      """
>>
>> +    #:
>> +    vendor: NotRequired[str]
>> +    #:
>> +    product: NotRequired[str]
>> +    #:
>> +    version: NotRequired[str]
>>      #:
>>      businfo: str
>>      #:
>> @@ -197,6 +205,66 @@ def unbind_ports(self, ports: list[Port]):
>>          if self._lshw_net_info:
>>              del self._lshw_net_info
>>
>> +    def get_nic_info(self) -> list[dict[str, str]]:
>> +        """Overrides :meth`~.os_session.OSSession.get_nic_info`.
>> +
>> +        Raises:
>> +            ConfigurationError: If the NIC info could not be found.
>> +        """
>> +        port_data =3D {
>> +            port.get("businfo"): port for port in self._lshw_net_info i=
f
>> port.get("businfo")
>> +        }
>> +
>> +        all_nic_info: list[dict[str, str]] =3D []
>> +        for port in self._config.ports:
>> +            pci_addr =3D port.pci
>> +
>> +            command_result =3D self.send_command(
>>
>
> rename to lshw_result please.
>
>
>> +                f"sudo lshw -c network -businfo | grep '{pci_addr}' |
>> cut -d'@' -f1"
>> +            )
>> +            if command_result.return_code !=3D 0 and command_result.std=
out
>> =3D=3D "":
>> +                raise ConfigurationError(f"Unable to get bus type for
>> port {pci_addr}.")
>> +            bus_type =3D command_result.stdout
>> +
>> +            bus_info =3D f"{bus_type}@{pci_addr}"
>> +            nic_port: LshwOutput | None =3D port_data[bus_info]
>> +            if nic_port is None:
>> +                raise ConfigurationError(f"Port {pci_addr} could not be
>> found on the node.")
>> +
>> +            config: LshwConfigurationOutput | None =3D
>> nic_port["configuration"]
>> +            if config is None:
>> +                raise ConfigurationError(
>> +                    f"Configuration info for port {pci_addr} could not
>> be found on the node."
>> +                )
>> +
>> +            if "logicalname" not in nic_port:
>> +                raise ConfigurationError(
>> +                    f"Logical name for port {pci_addr} could not be
>> found on the node."
>> +                )
>> +
>> +            command_result =3D self.send_command(
>>
>
> ethtool_result
>
>
>> +                f"ethtool {nic_port['logicalname']} | grep 'Speed:' |
>> awk '{{print $2}}'"
>> +            )
>
> +            if command_result.return_code =3D=3D 0 and command_result.st=
dout:
>> +                nic_speed =3D command_result.stdout
>> +            else:
>> +                self._logger.error(f"Unable to get speed for NIC:
>> {pci_addr}")
>> +                nic_speed =3D None
>> +
>> +            dut_json =3D {
>> +                "make": nic_port["vendor"] if "vendor" in nic_port else
>> "Unknown",
>> +                "model": nic_port["product"] if "product" in nic_port
>> else "Unknown",
>> +                "hardware version": nic_port["version"] if "version" in
>> nic_port else "Unknown",
>> +                "firmware version": config["firmware"] if "firmware" in
>> config else "Unknown",
>> +                "deviceBusType": bus_type,
>> +                "deviceId": nic_port["serial"] if "serial" in nic_port
>> else "Unknown",
>> +                "pmd": config["driver"] if "driver" in config else
>> "Unknown",
>> +                "speed": nic_speed or "Unknown",
>> +            }
>> +            all_nic_info.append(dut_json)
>> +
>> +        return all_nic_info
>> +
>>
>
> What is the intended behavior for cryptodev tests? I realize the ports
> list will be empty and we will not enter the initial loop, but is this
> intended? Do we want to gether cryptodev info too?
>
>
The intended behavior here is to skip cryptodev devices. Not entering the
initial loop, and therefore returning an empty list is the expected
behavior when running cryptodev tests.

>

>      def bind_ports_to_driver(self, ports: list[Port], driver_name: str)
>> -> None:
>>
>>
> Reviewed-by: Patrick Robb <patrickrobb1997@gmail.com>
>

--00000000000032e7e5065515ad81
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Jun 24,=
 2026 at 10:06=E2=80=AFPM Patrick Robb &lt;<a href=3D"mailto:patrickrobb199=
7@gmail.com">patrickrobb1997@gmail.com</a>&gt; wrote:<br></div><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px sol=
id rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div dir=3D"ltr"><br=
></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr"=
>On Wed, Jun 24, 2026 at 5:33=E2=80=AFPM Koushik Bhargav Nimoji &lt;<a href=
=3D"mailto:knimoji@iol.unh.edu" target=3D"_blank">knimoji@iol.unh.edu</a>&g=
t; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">This p=
atch gathers NIC info during a DTS run and writes it to an output<br>
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
 info too?</div><div>=C2=A0</div></div></div></blockquote><div>The intended=
 behavior here is to skip cryptodev devices. Not entering the initial loop,=
 and therefore=C2=A0returning an empty list is the expected behavior when r=
unning cryptodev tests.</div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex"><div dir=3D"ltr"><div class=3D"gmail_quote"></div></div></blockquote><d=
iv><span style=3D"background-color:transparent">=C2=A0</span></div><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px=
 solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div class=3D"gm=
ail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.=
8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
=C2=A0 =C2=A0 =C2=A0def bind_ports_to_driver(self, ports: list[Port], drive=
r_name: str) -&gt; None:<br><br></blockquote><div><br></div><div>Reviewed-b=
y: Patrick Robb &lt;<a href=3D"mailto:patrickrobb1997@gmail.com" target=3D"=
_blank">patrickrobb1997@gmail.com</a>&gt;=C2=A0</div></div></div>
</blockquote></div></div>

--00000000000032e7e5065515ad81--
