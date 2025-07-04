Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1910DC8303D
	for <dpdk-dev@archiver.kernel.org>; Fri,  4 Jul 2025 04:28:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E6E004028B;
	Fri,  4 Jul 2025 06:28:07 +0200 (CEST)
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com
 [209.85.216.43]) by mails.dpdk.org (Postfix) with ESMTP id 4EF0E4027D
 for <dev@dpdk.org>; Fri,  4 Jul 2025 06:28:06 +0200 (CEST)
Received: by mail-pj1-f43.google.com with SMTP id
 98e67ed59e1d1-315cd33fa79so473687a91.3
 for <dev@dpdk.org>; Thu, 03 Jul 2025 21:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1751603285; x=1752208085; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ohBArDdjLOHeH2wjMuJeErrhBTydPKsdks1Ip5Hf5dE=;
 b=MRDhR3dUwwc6wG8IlllkhRptiP1eDMsrjZUTPzhRsJezTwTwxWkhx/8e9ERdh/MWfz
 bNATdmok7dcpf2eYM0R6ZlCpzlLZlPaAwFMbfLW1JWr+7TEXx7/jH3AJojEEXDSJLvQV
 3JeEv5ZaY9C3Z2ygn/kt8JJDiaMc73XEwuBj4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751603285; x=1752208085;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ohBArDdjLOHeH2wjMuJeErrhBTydPKsdks1Ip5Hf5dE=;
 b=R0XEvkaNgDpQ9Hk9xSsGUIAotiwuqQqjZpKFSK+vWJz/K6tJemxtKGAFQ5HE8GOC0Z
 1cSwBTtvkg5+G/1PkkRcob/A8AuHfCc3UZraGwB8CjITQkWYpsuWXBcm+Kuest1juXOt
 tuL7g0CkV+5TcWRYL6rU4II7b9PJBgSGFRwqeoeFEIIq2Ll3OhGS5hSNjdFGMchPrpF+
 jYZBukrJ9m0S8nD6Jie1+lVT9dBAniLE+0SRMClDdUbvFh4OwIk5qfFzZGmugyRr1Vj9
 rTLaR5V4yCTHAX3yFwQSB49IVLeRKNig4JDoh6fhCmY5CeiGjCrjnKqiNx8Sfn12Dpio
 faiQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXgeRaEdwldH4DaG0EQp5+ZBjPaVmqVKStEjNSf58v1oiLS7MPaybNLZ6fVBlg5LSyNJzo=@dpdk.org
X-Gm-Message-State: AOJu0Yzwhh9W4qTDZEP/+J4GvyZrkUBlKHE4BK9oMsy1kVuQxgHctNjp
 2gdBRWDeD7fFMmRzk4d2wDIW5rJi0dfRXlKIVlVFHqEFBZ3bdYvSeqonoFuXKVyaJiU5rbbt5cI
 G2a/OCgbCOIwhOWdy7eZ6uOR24N3IdydHJu1Wmyaidw==
X-Gm-Gg: ASbGncvtbWlw6rvPRvbnz+5eTEn+ue/cfaJ0Dj/0rZxcFdy5jzVdty+N7R/HMTyoWY7
 YhvzDkUDpr2cQJkfzoscyBBQlXpp5R0GzNuObuqdyuCOX0+YG2GkioLjnzrLLvRMxEHNtN8bOpo
 N5J4m/iLKJusDOU0s62Mq2Ak1EsRhUUdA8ACbSW7KJSeohn0v7UEG5nuO+7rk=
X-Google-Smtp-Source: AGHT+IGxmiH12FVCk/0o4Xzmt1rejTv4MEBOJ9ivPRgqKmCIZIMRZS4xXMtHYy/Ewo8Q9GuWLV/H5woO8iTsrVQnJpI=
X-Received: by 2002:a17:90b:5210:b0:311:d258:3473 with SMTP id
 98e67ed59e1d1-31aac4620e5mr1829730a91.13.1751603285335; Thu, 03 Jul 2025
 21:28:05 -0700 (PDT)
MIME-Version: 1.0
References: <20250626152755.197560-3-dmarx@iol.unh.edu>
 <20250702162331.352313-1-dmarx@iol.unh.edu>
In-Reply-To: <20250702162331.352313-1-dmarx@iol.unh.edu>
From: Patrick Robb <probb@iol.unh.edu>
Date: Fri, 4 Jul 2025 00:22:28 -0400
X-Gm-Features: Ac12FXwIRWOAVfC6TPVtek2RxPkQfulqQPEPLJe8fspledefS1TCaDKAVI8XTHg
Message-ID: <CAJvnSUAO7iBHp9Fm7WiCrCfou3JByrYsL8ZyufcO9VZh-yNM1w@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] dts: add virtual functions to framework
To: Dean Marx <dmarx@iol.unh.edu>
Cc: luca.vizzarro@arm.com, yoan.picchi@foss.arm.com, 
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com, dev@dpdk.org
Content-Type: multipart/alternative; boundary="0000000000009c3b7f063912eb46"
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

--0000000000009c3b7f063912eb46
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 2, 2025 at 12:23=E2=80=AFPM Dean Marx <dmarx@iol.unh.edu> wrote=
:

> Add virtual functions to DTS framework, along with
> a field for specifying VF test runs in the config file.
>
> Signed-off-by: Patrick Robb <probb@iol.unh.edu>
> Signed-off-by: Dean Marx <dmarx@iol.unh.edu>
> ---
>  dts/framework/config/test_run.py             |  2 +
>  dts/framework/test_run.py                    |  7 +++
>  dts/framework/testbed_model/linux_session.py | 53 +++++++++++++++++++-
>  dts/framework/testbed_model/os_session.py    | 42 ++++++++++++++++
>  dts/framework/testbed_model/topology.py      | 53 +++++++++++++++++++-
>  5 files changed, 154 insertions(+), 3 deletions(-)
>
> diff --git a/dts/framework/config/test_run.py
> b/dts/framework/config/test_run.py
> index b6e4099eeb..eefa32c3cb 100644
> --- a/dts/framework/config/test_run.py
> +++ b/dts/framework/config/test_run.py
> @@ -467,6 +467,8 @@ class TestRunConfiguration(FrozenModel):
>      perf: bool
>      #: Whether to run functional tests.
>      func: bool
> +    #: Whether to run the testing with virtual functions instead of
> physical functions
> +    virtual_functions_testrun: bool
>      #: Whether to skip smoke tests.
>      skip_smoke_tests: bool =3D False
>      #: The names of test suites and/or test cases to execute.
> diff --git a/dts/framework/test_run.py b/dts/framework/test_run.py
> index fd49a7dc74..ee919e30d9 100644
> --- a/dts/framework/test_run.py
> +++ b/dts/framework/test_run.py
> @@ -346,6 +346,10 @@ def next(self) -> State | None:
>          test_run.ctx.tg_node.setup()
>          test_run.ctx.dpdk.setup()
>          test_run.ctx.topology.setup()
> +
> +        if test_run.config.virtual_functions_testrun:
> +            test_run.ctx.topology.instantiate_vf_ports()
> +
>          test_run.ctx.topology.configure_ports("sut", "dpdk")
>          test_run.ctx.tg.setup(test_run.ctx.topology)
>
> @@ -432,6 +436,9 @@ def description(self) -> str:
>
>      def next(self) -> State | None:
>          """Next state."""
> +        if self.test_run.config.virtual_functions_testrun:
> +            self.test_run.ctx.topology.delete_vf_ports()
> +
>          self.test_run.ctx.shell_pool.terminate_current_pool()
>          self.test_run.ctx.tg.teardown()
>          self.test_run.ctx.topology.teardown()
> diff --git a/dts/framework/testbed_model/linux_session.py
> b/dts/framework/testbed_model/linux_session.py
> index e01c2dd712..604245d855 100644
> --- a/dts/framework/testbed_model/linux_session.py
> +++ b/dts/framework/testbed_model/linux_session.py
> @@ -17,7 +17,11 @@
>
>  from typing_extensions import NotRequired
>
> -from framework.exception import ConfigurationError, InternalError,
> RemoteCommandExecutionError
> +from framework.exception import (
> +    ConfigurationError,
> +    InternalError,
> +    RemoteCommandExecutionError,
> +)
>  from framework.testbed_model.os_session import PortInfo
>  from framework.utils import expand_range
>
> @@ -211,11 +215,58 @@ def devbind_script_path(self) -> PurePath:
>          """
>          raise InternalError("Accessed devbind script path before setup."=
)
>
> +    def create_vfs(self, pf_port: Port) -> None:
> +        """Overrides :meth:`~.os_session.OSSession.create_vfs`.
> +
> +        Raises:
> +            InternalError: If there are existing VFs which have to be
> deleted.
> +        """
> +        sys_bus_path =3D f"/sys/bus/pci/devices/{pf_port.pci}".replace("=
:",
> "\\:")
> +        curr_num_vfs =3D int(
> +            self.send_command(f"cat {sys_bus_path}/sriov_numvfs",
> privileged=3DTrue).stdout
> +        )
> +        if 0 < curr_num_vfs:
> +            raise InternalError("There are existing VFs on the port whic=
h
> must be deleted.")
> +        if curr_num_vfs =3D=3D 0:
> +            self.send_command(f"echo 1 | sudo tee
> {sys_bus_path}/sriov_numvfs", privileged=3DTrue)
> +            self.refresh_lshw()
> +
> +    def delete_vfs(self, pf_port: Port) -> None:
> +        """Overrides :meth:`~.os_session.OSSession.delete_vfs`."""
> +        sys_bus_path =3D f"/sys/bus/pci/devices/{pf_port.pci}".replace("=
:",
> "\\:")
> +        curr_num_vfs =3D int(
> +            self.send_command(f"cat {sys_bus_path}/sriov_numvfs",
> privileged=3DTrue).stdout
> +        )
> +        if curr_num_vfs =3D=3D 0:
> +            self._logger.debug(f"No VFs found on port {pf_port.pci},
> skipping deletion")
> +        else:
> +            self.send_command(f"echo 0 | sudo tee
> {sys_bus_path}/sriov_numvfs", privileged=3DTrue)
> +
> +    def get_pci_addr_of_vfs(self, pf_port: Port) -> list[str]:
> +        """Overrides
> :meth:`~.os_session.OSSession.get_pci_addr_of_vfs`."""
> +        sys_bus_path =3D f"/sys/bus/pci/devices/{pf_port.pci}".replace("=
:",
> "\\:")
> +        curr_num_vfs =3D int(self.send_command(f"cat
> {sys_bus_path}/sriov_numvfs").stdout)
> +        if curr_num_vfs > 0:
> +            pci_addrs =3D self.send_command(
> +                'awk -F "PCI_SLOT_NAME=3D" "/PCI_SLOT_NAME=3D/ {print \\=
$2}" '
> +                + f"{sys_bus_path}/virtfn*/uevent",
> +                privileged=3DTrue,
> +            )
> +            return pci_addrs.stdout.splitlines()
> +        else:
> +            return []
> +
>      @cached_property
>      def _lshw_net_info(self) -> list[LshwOutput]:
>          output =3D self.send_command("lshw -quiet -json -C network",
> verify=3DTrue)
>          return json.loads(output.stdout)
>
> +    def refresh_lshw(self) -> None:
> +        """Force refresh of cached lshw network info."""
> +        if "_lshw_net_info" in self.__dict__:
> +            del self.__dict__["_lshw_net_info"]
> +        _ =3D self._lshw_net_info
> +
>      def _update_port_attr(self, port: Port, attr_value: str | None,
> attr_name: str) -> None:
>          if attr_value:
>              setattr(port, attr_name, attr_value)
> diff --git a/dts/framework/testbed_model/os_session.py
> b/dts/framework/testbed_model/os_session.py
> index d7a09a0d5d..b6e03aa83d 100644
> --- a/dts/framework/testbed_model/os_session.py
> +++ b/dts/framework/testbed_model/os_session.py
> @@ -603,3 +603,45 @@ def configure_port_mtu(self, mtu: int, port: Port) -=
>
> None:
>              mtu: Desired MTU value.
>              port: Port to set `mtu` on.
>          """
> +
> +    @abstractmethod
> +    def create_vfs(self, pf_port: Port) -> None:
> +        """Creates virtual functions for `pf_port`.
> +
> +        Checks how many virtual functions (VFs) `pf_port` supports, and
> creates that
> +        number of VFs on the port.
> +
> +        Args:
> +            pf_port: The port to create virtual functions on.
> +
> +        Raises:
> +            InternalError: If the number of VFs is greater than 0 but
> less than the
> +            maximum for `pf_port`.
> +        """
> +
> +    @abstractmethod
> +    def delete_vfs(self, pf_port: Port) -> None:
> +        """Deletes virtual functions for `pf_port`.
> +
> +        Checks how many virtual functions (VFs) `pf_port` supports, and
> deletes that
> +        number of VFs on the port.
> +
> +        Args:
> +            pf_port: The port to delete virtual functions on.
> +
> +        Raises:
> +            InternalError: If the number of VFs is greater than 0 but
> less than the
> +            maximum for `pf_port`.
> +        """
> +
> +    @abstractmethod
> +    def get_pci_addr_of_vfs(self, pf_port: Port) -> list[str]:
> +        """Find the PCI addresses of all virtual functions (VFs) on the
> port `pf_port`.
> +
> +        Args:
> +            pf_port: The port to find the VFs on.
> +
> +        Returns:
> +            A list containing all of the PCI addresses of the VFs on the
> port. If the port has no
> +            VFs then the list will be empty.
> +        """
> diff --git a/dts/framework/testbed_model/topology.py
> b/dts/framework/testbed_model/topology.py
> index fb45969136..2bc69d46a9 100644
> --- a/dts/framework/testbed_model/topology.py
> +++ b/dts/framework/testbed_model/topology.py
> @@ -19,7 +19,7 @@
>  from framework.exception import ConfigurationError, InternalError
>  from framework.testbed_model.node import Node
>
> -from .port import DriverKind, Port
> +from .port import DriverKind, Port, PortConfig
>
>
>  class TopologyType(int, Enum):
> @@ -74,6 +74,8 @@ class Topology:
>      type: TopologyType
>      sut_ports: list[Port]
>      tg_ports: list[Port]
> +    pf_ports: list[Port]
> +    vf_ports: list[Port]
>
>      @classmethod
>      def from_port_links(cls, port_links: Iterator[PortLink]) -> Self:
> @@ -101,7 +103,7 @@ def from_port_links(cls, port_links:
> Iterator[PortLink]) -> Self:
>                      msg =3D "More than two links in a topology are not
> supported."
>                      raise ConfigurationError(msg)
>
> -        return cls(type, sut_ports, tg_ports)
> +        return cls(type, sut_ports, tg_ports, [], [])
>
>      def node_and_ports_from_id(self, node_identifier: NodeIdentifier) ->
> tuple[Node, list[Port]]:
>          """Retrieve node and its ports for the current topology.
> @@ -160,6 +162,53 @@ def _setup_ports(self, node_identifier:
> NodeIdentifier) -> None:
>                      f"for port {port.name} in node {node.name}."
>                  )
>
> +    def instantiate_vf_ports(self) -> None:
> +        """Create, setup, and add virtual functions to the list of ports
> on the SUT node.
> +
> +        Raises:
> +            InternalError: If virtual function creation fails.
> +        """
> +        from framework.context import get_ctx
> +
> +        ctx =3D get_ctx()
> +
> +        for port in self.sut_ports:
> +            self.pf_ports.append(port)
> +
> +        for port in self.pf_ports:
> +            ctx.sut_node.main_session.create_vfs(port)
> +            addr_list =3D
> ctx.sut_node.main_session.get_pci_addr_of_vfs(port)
> +            if addr_list =3D=3D []:
> +                raise InternalError(f"Failed to create virtual function
> on port {port.pci}")
> +            for addr in addr_list:
> +                vf_config =3D PortConfig(
> +                    name=3Df"{port.name}-vf-{addr}",
> +                    pci=3Daddr,
> +                    os_driver_for_dpdk=3Dport.config.os_driver_for_dpdk,
> +                    os_driver=3Dport.config.os_driver,
> +                )
> +                self.vf_ports.append(Port(node=3Dport.node,
> config=3Dvf_config))
> +            ctx.sut_node.main_session.send_command(f"ip link set
> {port.logical_name} vf 0 trust on")
> +
> +        self.sut_ports.clear()
> +        self.sut_ports.extend(self.vf_ports)
> +
> +        for port in self.pf_ports:
> +            ctx.sut_node.main_session.send_command(
> +                f"ip link set dev {port.logical_name} up", privileged=3D=
True
> +            )
>

I think this can become:

ctx.sut_node.main_session.bring_up_link(self.pf_ports)

which should do the exact same but runs through the method we already have
implemented.


> +
> +    def delete_vf_ports(self) -> None:
> +        """Delete virtual functions from the SUT node during test run
> teardown."""
> +        from framework.context import get_ctx
> +
> +        ctx =3D get_ctx()
> +
> +        for port in self.pf_ports:
> +            ctx.sut_node.main_session.delete_vfs(port)
> +        self.sut_ports.clear()
> +        self.sut_ports.extend(self.pf_ports)
> +
>      def configure_ports(
>          self, node_identifier: NodeIdentifier, drivers: DriverKind |
> tuple[DriverKind, ...]
>      ) -> None:
> --
> 2.49.0
>
>
Reviewed-by: Patrick Robb <probb@iol.unh.edu>
Tested-by: Patrick Robb <probb@iol.unh.edu>

--0000000000009c3b7f063912eb46
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Jul 2, 2025 =
at 12:23=E2=80=AFPM Dean Marx &lt;<a href=3D"mailto:dmarx@iol.unh.edu" targ=
et=3D"_blank">dmarx@iol.unh.edu</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">Add virtual functions to DTS framework, al=
ong with<br>
a field for specifying VF test runs in the config file.<br>
<br>
Signed-off-by: Patrick Robb &lt;<a href=3D"mailto:probb@iol.unh.edu" target=
=3D"_blank">probb@iol.unh.edu</a>&gt;<br>
Signed-off-by: Dean Marx &lt;<a href=3D"mailto:dmarx@iol.unh.edu" target=3D=
"_blank">dmarx@iol.unh.edu</a>&gt;<br>
---<br>
=C2=A0dts/framework/config/test_run.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 2 +<br>
=C2=A0dts/framework/test_run.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 7 +++<br>
=C2=A0dts/framework/testbed_model/linux_session.py | 53 +++++++++++++++++++=
-<br>
=C2=A0dts/framework/testbed_model/os_session.py=C2=A0 =C2=A0 | 42 +++++++++=
+++++++<br>
=C2=A0dts/framework/testbed_model/topology.py=C2=A0 =C2=A0 =C2=A0 | 53 ++++=
+++++++++++++++-<br>
=C2=A05 files changed, 154 insertions(+), 3 deletions(-)<br>
<br>
diff --git a/dts/framework/config/test_run.py b/dts/framework/config/test_r=
un.py<br>
index b6e4099eeb..eefa32c3cb 100644<br>
--- a/dts/framework/config/test_run.py<br>
+++ b/dts/framework/config/test_run.py<br>
@@ -467,6 +467,8 @@ class TestRunConfiguration(FrozenModel):<br>
=C2=A0 =C2=A0 =C2=A0perf: bool<br>
=C2=A0 =C2=A0 =C2=A0#: Whether to run functional tests.<br>
=C2=A0 =C2=A0 =C2=A0func: bool<br>
+=C2=A0 =C2=A0 #: Whether to run the testing with virtual functions instead=
 of physical functions<br>
+=C2=A0 =C2=A0 virtual_functions_testrun: bool<br>
=C2=A0 =C2=A0 =C2=A0#: Whether to skip smoke tests.<br>
=C2=A0 =C2=A0 =C2=A0skip_smoke_tests: bool =3D False<br>
=C2=A0 =C2=A0 =C2=A0#: The names of test suites and/or test cases to execut=
e.<br>
diff --git a/dts/framework/test_run.py b/dts/framework/test_run.py<br>
index fd49a7dc74..ee919e30d9 100644<br>
--- a/dts/framework/test_run.py<br>
+++ b/dts/framework/test_run.py<br>
@@ -346,6 +346,10 @@ def next(self) -&gt; State | None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0test_run.ctx.tg_node.setup()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0test_run.ctx.dpdk.setup()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0test_run.ctx.topology.setup()<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if test_run.config.virtual_functions_testrun:<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 test_run.ctx.topology.instantiat=
e_vf_ports()<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0test_run.ctx.topology.configure_ports(&qu=
ot;sut&quot;, &quot;dpdk&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0test_run.ctx.tg.setup(test_run.ctx.topolo=
gy)<br>
<br>
@@ -432,6 +436,9 @@ def description(self) -&gt; str:<br>
<br>
=C2=A0 =C2=A0 =C2=A0def next(self) -&gt; State | None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Next state.&quot;&quot;=
&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if self.test_run.config.virtual_functions_test=
run:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.test_run.ctx.topology.delet=
e_vf_ports()<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.test_run.ctx.shell_pool.terminate_cu=
rrent_pool()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.test_run.ctx.tg.teardown()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.test_run.ctx.topology.teardown()<br>
diff --git a/dts/framework/testbed_model/linux_session.py b/dts/framework/t=
estbed_model/linux_session.py<br>
index e01c2dd712..604245d855 100644<br>
--- a/dts/framework/testbed_model/linux_session.py<br>
+++ b/dts/framework/testbed_model/linux_session.py<br>
@@ -17,7 +17,11 @@<br>
<br>
=C2=A0from typing_extensions import NotRequired<br>
<br>
-from framework.exception import ConfigurationError, InternalError, RemoteC=
ommandExecutionError<br>
+from framework.exception import (<br>
+=C2=A0 =C2=A0 ConfigurationError,<br>
+=C2=A0 =C2=A0 InternalError,<br>
+=C2=A0 =C2=A0 RemoteCommandExecutionError,<br>
+)<br>
=C2=A0from framework.testbed_model.os_session import PortInfo<br>
=C2=A0from framework.utils import expand_range<br>
<br>
@@ -211,11 +215,58 @@ def devbind_script_path(self) -&gt; PurePath:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise InternalError(&quot;Accessed devbin=
d script path before setup.&quot;)<br>
<br>
+=C2=A0 =C2=A0 def create_vfs(self, pf_port: Port) -&gt; None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Overrides :meth:`~.os_sessio=
n.OSSession.create_vfs`.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Raises:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 InternalError: If there are exis=
ting VFs which have to be deleted.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 sys_bus_path =3D f&quot;/sys/bus/pci/devices/{=
pf_port.pci}&quot;.replace(&quot;:&quot;, &quot;\\:&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 curr_num_vfs =3D int(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.send_command(f&quot;cat {sy=
s_bus_path}/sriov_numvfs&quot;, privileged=3DTrue).stdout<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if 0 &lt; curr_num_vfs:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise InternalError(&quot;There =
are existing VFs on the port which must be deleted.&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if curr_num_vfs =3D=3D 0:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.send_command(f&quot;echo 1 =
| sudo tee {sys_bus_path}/sriov_numvfs&quot;, privileged=3DTrue)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.refresh_lshw()<br>
+<br>
+=C2=A0 =C2=A0 def delete_vfs(self, pf_port: Port) -&gt; None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Overrides :meth:`~.os_sessio=
n.OSSession.delete_vfs`.&quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 sys_bus_path =3D f&quot;/sys/bus/pci/devices/{=
pf_port.pci}&quot;.replace(&quot;:&quot;, &quot;\\:&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 curr_num_vfs =3D int(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.send_command(f&quot;cat {sy=
s_bus_path}/sriov_numvfs&quot;, privileged=3DTrue).stdout<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if curr_num_vfs =3D=3D 0:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._logger.debug(f&quot;No VFs=
 found on port {pf_port.pci}, skipping deletion&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.send_command(f&quot;echo 0 =
| sudo tee {sys_bus_path}/sriov_numvfs&quot;, privileged=3DTrue)<br>
+<br>
+=C2=A0 =C2=A0 def get_pci_addr_of_vfs(self, pf_port: Port) -&gt; list[str]=
:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Overrides :meth:`~.os_sessio=
n.OSSession.get_pci_addr_of_vfs`.&quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 sys_bus_path =3D f&quot;/sys/bus/pci/devices/{=
pf_port.pci}&quot;.replace(&quot;:&quot;, &quot;\\:&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 curr_num_vfs =3D int(self.send_command(f&quot;=
cat {sys_bus_path}/sriov_numvfs&quot;).stdout)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if curr_num_vfs &gt; 0:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pci_addrs =3D self.send_command(=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;awk -F &quot;=
PCI_SLOT_NAME=3D&quot; &quot;/PCI_SLOT_NAME=3D/ {print \\$2}&quot; &#39;<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 + f&quot;{sys_bus_=
path}/virtfn*/uevent&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 privileged=3DTrue,=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return pci_addrs.stdout.splitlin=
es()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return []<br>
+<br>
=C2=A0 =C2=A0 =C2=A0@cached_property<br>
=C2=A0 =C2=A0 =C2=A0def _lshw_net_info(self) -&gt; list[LshwOutput]:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0output =3D self.send_command(&quot;lshw -=
quiet -json -C network&quot;, verify=3DTrue)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return json.loads(output.stdout)<br>
<br>
+=C2=A0 =C2=A0 def refresh_lshw(self) -&gt; None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Force refresh of cached lshw=
 network info.&quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if &quot;_lshw_net_info&quot; in self.__dict__=
:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 del self.__dict__[&quot;_lshw_ne=
t_info&quot;]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 _ =3D self._lshw_net_info<br>
+<br>
=C2=A0 =C2=A0 =C2=A0def _update_port_attr(self, port: Port, attr_value: str=
 | None, attr_name: str) -&gt; None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if attr_value:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0setattr(port, attr_name, at=
tr_value)<br>
diff --git a/dts/framework/testbed_model/os_session.py b/dts/framework/test=
bed_model/os_session.py<br>
index d7a09a0d5d..b6e03aa83d 100644<br>
--- a/dts/framework/testbed_model/os_session.py<br>
+++ b/dts/framework/testbed_model/os_session.py<br>
@@ -603,3 +603,45 @@ def configure_port_mtu(self, mtu: int, port: Port) -&g=
t; None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mtu: Desired MTU value.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0port: Port to set `mtu` on.=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>
+<br>
+=C2=A0 =C2=A0 @abstractmethod<br>
+=C2=A0 =C2=A0 def create_vfs(self, pf_port: Port) -&gt; None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Creates virtual functions fo=
r `pf_port`.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Checks how many virtual functions (VFs) `pf_po=
rt` supports, and creates that<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 number of VFs on the port.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pf_port: The port to create virt=
ual functions on.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Raises:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 InternalError: If the number of =
VFs is greater than 0 but less than the<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 maximum for `pf_port`.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+<br>
+=C2=A0 =C2=A0 @abstractmethod<br>
+=C2=A0 =C2=A0 def delete_vfs(self, pf_port: Port) -&gt; None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Deletes virtual functions fo=
r `pf_port`.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Checks how many virtual functions (VFs) `pf_po=
rt` supports, and deletes that<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 number of VFs on the port.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pf_port: The port to delete virt=
ual functions on.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Raises:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 InternalError: If the number of =
VFs is greater than 0 but less than the<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 maximum for `pf_port`.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+<br>
+=C2=A0 =C2=A0 @abstractmethod<br>
+=C2=A0 =C2=A0 def get_pci_addr_of_vfs(self, pf_port: Port) -&gt; list[str]=
:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Find the PCI addresses of al=
l virtual functions (VFs) on the port `pf_port`.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pf_port: The port to find the VF=
s on.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Returns:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 A list containing all of the PCI=
 addresses of the VFs on the port. If the port has no<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 VFs then the list will be empty.=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
diff --git a/dts/framework/testbed_model/topology.py b/dts/framework/testbe=
d_model/topology.py<br>
index fb45969136..2bc69d46a9 100644<br>
--- a/dts/framework/testbed_model/topology.py<br>
+++ b/dts/framework/testbed_model/topology.py<br>
@@ -19,7 +19,7 @@<br>
=C2=A0from framework.exception import ConfigurationError, InternalError<br>
=C2=A0from framework.testbed_model.node import Node<br>
<br>
-from .port import DriverKind, Port<br>
+from .port import DriverKind, Port, PortConfig<br>
<br>
<br>
=C2=A0class TopologyType(int, Enum):<br>
@@ -74,6 +74,8 @@ class Topology:<br>
=C2=A0 =C2=A0 =C2=A0type: TopologyType<br>
=C2=A0 =C2=A0 =C2=A0sut_ports: list[Port]<br>
=C2=A0 =C2=A0 =C2=A0tg_ports: list[Port]<br>
+=C2=A0 =C2=A0 pf_ports: list[Port]<br>
+=C2=A0 =C2=A0 vf_ports: list[Port]<br>
<br>
=C2=A0 =C2=A0 =C2=A0@classmethod<br>
=C2=A0 =C2=A0 =C2=A0def from_port_links(cls, port_links: Iterator[PortLink]=
) -&gt; Self:<br>
@@ -101,7 +103,7 @@ def from_port_links(cls, port_links: Iterator[PortLink]=
) -&gt; Self:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0msg =3D &quot;More than two links in a topology are not supported.&quot;=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0raise ConfigurationError(msg)<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return cls(type, sut_ports, tg_ports)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return cls(type, sut_ports, tg_ports, [], [])<=
br>
<br>
=C2=A0 =C2=A0 =C2=A0def node_and_ports_from_id(self, node_identifier: NodeI=
dentifier) -&gt; tuple[Node, list[Port]]:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Retrieve node and its p=
orts for the current topology.<br>
@@ -160,6 +162,53 @@ def _setup_ports(self, node_identifier: NodeIdentifier=
) -&gt; None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0f&quot;for port {<a href=3D"http://port.name" rel=3D"noreferrer" target=
=3D"_blank">port.name</a>} in node {<a href=3D"http://node.name" rel=3D"nor=
eferrer" target=3D"_blank">node.name</a>}.&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0)<br>
<br>
+=C2=A0 =C2=A0 def instantiate_vf_ports(self) -&gt; None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Create, setup, and add virtu=
al functions to the list of ports on the SUT node.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Raises:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 InternalError: If virtual functi=
on creation fails.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 from framework.context import get_ctx<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ctx =3D get_ctx()<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 for port in self.sut_ports:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.pf_ports.append(port)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 for port in self.pf_ports:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ctx.sut_node.main_session.create=
_vfs(port)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 addr_list =3D ctx.sut_node.main_=
session.get_pci_addr_of_vfs(port)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if addr_list =3D=3D []:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise InternalErro=
r(f&quot;Failed to create virtual function on port {port.pci}&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for addr in addr_list:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vf_config =3D Port=
Config(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 name=
=3Df&quot;{<a href=3D"http://port.name" rel=3D"noreferrer" target=3D"_blank=
">port.name</a>}-vf-{addr}&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pci=
=3Daddr,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 os_d=
river_for_dpdk=3Dport.config.os_driver_for_dpdk,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 os_d=
river=3Dport.config.os_driver,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.vf_ports.appe=
nd(Port(node=3Dport.node, config=3Dvf_config))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ctx.sut_node.main_session.send_c=
ommand(f&quot;ip link set {port.logical_name} vf 0 trust on&quot;)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.sut_ports.clear()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.sut_ports.extend(self.vf_ports)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 for port in self.pf_ports:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ctx.sut_node.main_session.send_c=
ommand(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&quot;ip link set=
 dev {port.logical_name} up&quot;, privileged=3DTrue<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br></blockquote><div><br></div=
><div>I think this can become:=C2=A0</div><div><br></div><div>ctx.sut_node.=
main_session.bring_up_link(self.pf_ports)</div><div><br></div><div>which sh=
ould do the exact same but runs through the method we already have implemen=
ted.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
">
+<br>
+=C2=A0 =C2=A0 def delete_vf_ports(self) -&gt; None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Delete virtual functions fro=
m the SUT node during test run teardown.&quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 from framework.context import get_ctx<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ctx =3D get_ctx()<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 for port in self.pf_ports:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ctx.sut_node.main_session.delete=
_vfs(port)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.sut_ports.clear()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.sut_ports.extend(self.pf_ports)<br>
+<br>
=C2=A0 =C2=A0 =C2=A0def configure_ports(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self, node_identifier: NodeIdentifier, dr=
ivers: DriverKind | tuple[DriverKind, ...]<br>
=C2=A0 =C2=A0 =C2=A0) -&gt; None:<br>
-- <br>
2.49.0<br>
<br></blockquote><div><br></div>Reviewed-by: Patrick Robb &lt;<a href=3D"ma=
ilto:probb@iol.unh.edu">probb@iol.unh.edu</a>&gt;<div>Tested-by: Patrick Ro=
bb &lt;<a href=3D"mailto:probb@iol.unh.edu">probb@iol.unh.edu</a>&gt;=C2=A0=
</div></div></div>
</div>

--0000000000009c3b7f063912eb46--
