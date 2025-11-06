Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02A48CCFA05
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Nov 2025 13:33:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 400984021F;
	Thu,  6 Nov 2025 14:33:58 +0100 (CET)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com
 [209.85.208.45]) by mails.dpdk.org (Postfix) with ESMTP id 7BCAB4013F
 for <dev@dpdk.org>; Thu,  6 Nov 2025 14:33:56 +0100 (CET)
Received: by mail-ed1-f45.google.com with SMTP id
 4fb4d7f45d1cf-64080ccf749so1033341a12.2
 for <dev@dpdk.org>; Thu, 06 Nov 2025 05:33:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1762436036; x=1763040836; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=aBgIXkKiukswEzH+zgqm0/9iWh8Fl9R4v8bFCLlKiUk=;
 b=WxEkN5VMyMYE4uG7gjaAxyATZNF1DBhxByJunB4iEIsRNUcY75wCjPKOG/OY3w+DZ2
 tM+DS7NMZ80Hbsg4qBW9i/4Knn/2H+oAv1CQ2GdEsXJinWZvRCASeYWiTsvxm1/SfO7R
 6c8i8QC3Vi56gQOJkDDbCCDMICTQTyMmeRKQE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762436036; x=1763040836;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aBgIXkKiukswEzH+zgqm0/9iWh8Fl9R4v8bFCLlKiUk=;
 b=qCeGMyrauySQGZ+PFc5c1hZJgWNUu6V6hd4RFYdKzf6ez/kbRf3pqk28f+qTyJVs0M
 yyRmzTVLnq5+xFRn14E9L+SjkElLMcU5cbW14yYsDzKIjJJr+YpPopRo/VY6s5u/r+TW
 CRIJNSkV9tS9OP6ovyvm6N2ugzpgjF7zTVOVhiEDUfboVcGqxRRgb9XxhiWD3mV8xUjE
 J+K0dzEikd4eIkC2XjmjVhFT/4LBZg64HaGiZ0BentedsFrf+WoxKKZyU3ehmUeLR9hN
 H7LtHbM+S9E+p0IHgEIBLrq4xWgGm2XeRDIfQFVYUkvzxMsGqneui1ADPwqAh95mR1Qv
 epkg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/OqAVQU+gKTnOZjUYn9baYnlaoPNTYuURBmpmdIaHEZmdZkAN90IT0yS3QyVJBjU4a0Y=@dpdk.org
X-Gm-Message-State: AOJu0Yx0a0E3LGFXLK0fs0dfBe/0V3uc//Hhs3ttsWs5TlPXr6aHSw/w
 dWk0mvtUk1holY2U9q1kf98YkJTIwLQMN0XqsoYdtf34Q2ONST/zM0kI62WCNsH+3YqcXhsGIaP
 PpRGPyo/e5v/W31feVVDfJodFLD9Yu974jYaxjnnvKg==
X-Gm-Gg: ASbGnctU0tzzhOUcCHf0yuujpfiq4iSwSaZzppSCCTOnE5vM5lsPitFunH46D6lU7pJ
 P7Usu17RVtYlmrzy0GvyxQkS+0PY2ZHnY01twXuDebeyPfczKLmx+d9UNqzFwAHVrwMF7ayGtnr
 s5Q57oUb383596tqcn72JsLTgzoRVmE5tQCMAqlPbrcNA2KaAH/YLLGlmNLX9N2Ov8ibca5vFtL
 b/LE5e3gnRG42jWINpapYwDZqrYVXT7mFNQUYSrbLo6AS8YKHXNoXbeYcApntK0wWu0oBfxJ+I5
 08JRbw9rgo0VsGBnZg==
X-Google-Smtp-Source: AGHT+IEd8NwArbqoUADb6ujzfsjXqsgckfcK8ygZNF00ice7RqBV473Lt0NzTzcCWhRZJfPdrmvrViD9j0KXztwbBvs=
X-Received: by 2002:a05:6402:278a:b0:640:931a:7c2f with SMTP id
 4fb4d7f45d1cf-6410588e133mr6374437a12.7.1762436035727; Thu, 06 Nov 2025
 05:33:55 -0800 (PST)
MIME-Version: 1.0
References: <20251023013049.1368129-1-probb@iol.unh.edu>
 <20251105223628.1659390-1-probb@iol.unh.edu>
 <20251105223628.1659390-3-probb@iol.unh.edu>
In-Reply-To: <20251105223628.1659390-3-probb@iol.unh.edu>
From: Andrew Bailey <abailey@iol.unh.edu>
Date: Thu, 6 Nov 2025 08:33:43 -0500
X-Gm-Features: AWmQ_bmfcVYT5E1Q24mCtap0ww9DS0w0osGkMuiLUH_JOctYeaQEVUvJgzm9qCM
Message-ID: <CABJ3N2V73khnr-4GgpbSyDwKGg906zc7Dgpk+0qXjRuAW+5rcg@mail.gmail.com>
Subject: Re: [PATCH v6 2/3] dts: add trex traffic generator to dts framework
To: Patrick Robb <probb@iol.unh.edu>
Cc: Luca.Vizzarro@arm.com, dev@dpdk.org, Paul.Szczepanek@arm.com, 
 dmarx@iol.unh.edu, Nicholas Pratte <npratte@iol.unh.edu>
Content-Type: multipart/alternative; boundary="000000000000d9633f0642ed1dcc"
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

--000000000000d9633f0642ed1dcc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Andrew Bailey <abailey@iol.unh.edu>

On Wed, Nov 5, 2025 at 5:37=E2=80=AFPM Patrick Robb <probb@iol.unh.edu> wro=
te:

> From: Nicholas Pratte <npratte@iol.unh.edu>
>
> Implement the TREX traffic generator for use in the DTS framework. The
> provided implementation leverages TREX's stateless API automation
> library, via use of a Python shell. The DTS context has been modified
> to include a performance traffic generator in addition to a functional
> traffic generator.
>
> In addition, the DTS testrun state machine has been modified such that
> traffic generators are brought up and down as needed, and so that only
> one traffic generator application is running on the TG system at a time.
> During the testcase setup stage, the testcase type (perf or func) will
> be checked and the correct traffic generator brought up. For instance,
> if a functional TG is running from a previous test and we start a
> performance test, then the functional TG is stopped and the performance
> TG started. This is an attempt to strike a balance between the concept
> of having the scapy asyncsniffer always on to save on execution time,
> with the competing need to bring up performance traffic generators as
> needed. There is also an added boolean toggle for adding new shells
> to the current shell pool or omitting them from the shell pool in order
> to facilitate this new TG initialization approach.
>
> Bugzilla ID: 1697
> Signed-off-by: Nicholas Pratte <npratte@iol.unh.edu>
> Signed-off-by: Patrick Robb <probb@iol.unh.edu>
> Reviewed-by: Dean Marx <dmarx@iol.unh.edu>
> Reviewed-by: Andrew Bailey <abailey@iol.unh.edu>
> ---
>  doc/guides/tools/dts.rst                      |  55 +++-
>  dts/api/packet.py                             |   6 +-
>  dts/{ =3D> configurations}/nodes.example.yaml   |   0
>  .../test_run.example.yaml                     |   6 +-
>  .../tests_config.example.yaml                 |   0
>  dts/framework/config/test_run.py              |  22 +-
>  dts/framework/context.py                      |   5 +-
>  dts/framework/remote_session/blocking_app.py  |  12 +-
>  .../remote_session/interactive_shell.py       |   8 +-
>  dts/framework/settings.py                     |  12 +-
>  dts/framework/test_run.py                     |  52 +++-
>  .../traffic_generator/__init__.py             |  13 +-
>  .../testbed_model/traffic_generator/scapy.py  |  14 +-
>  .../traffic_generator/traffic_generator.py    |  22 ++
>  .../testbed_model/traffic_generator/trex.py   | 259 ++++++++++++++++++
>  15 files changed, 440 insertions(+), 46 deletions(-)
>  rename dts/{ =3D> configurations}/nodes.example.yaml (100%)
>  rename dts/{ =3D> configurations}/test_run.example.yaml (88%)
>  rename dts/{ =3D> configurations}/tests_config.example.yaml (100%)
>  create mode 100644 dts/framework/testbed_model/traffic_generator/trex.py
>
> diff --git a/doc/guides/tools/dts.rst b/doc/guides/tools/dts.rst
> index 25c08c6a00..73d89eb1f6 100644
> --- a/doc/guides/tools/dts.rst
> +++ b/doc/guides/tools/dts.rst
> @@ -209,7 +209,8 @@ These need to be set up on a Traffic Generator Node:
>  #. **Traffic generator dependencies**
>
>     The traffic generator running on the traffic generator node must be
> installed beforehand.
> -   For Scapy traffic generator, only a few Python libraries need to be
> installed:
> +
> +   For Scapy traffic generator (functional tests), only a few Python
> libraries need to be installed:
>
>     .. code-block:: console
>
> @@ -217,6 +218,32 @@ These need to be set up on a Traffic Generator Node:
>        sudo pip install --upgrade pip
>        sudo pip install scapy=3D=3D2.5.0
>
> +   For TREX traffic generator (performance tests), TREX must be
> downloaded and a TREX config produced for each TG NIC. For example:
> +
> +   .. code-block:: console
> +
> +      wget https://trex-tgn.cisco.com/trex/release/v3.03.tar.gz
> +      tar -xf v3.03.tar.gz
> +      cd v3.03
> +      sudo ./dpdk_setup_ports.py -i
> +
> +   Within the dpdk_setup_ports.py utility, follow these instructions:
> +     - Select MAC based config
> +     - Select interfaces 0 and 1 on your TG NIC
> +     - Do not change assumed dest to DUT MAC (just leave the default
> loopback)
> +     - Print preview of the config
> +     - Check for device address correctness
> +     - Check for socket and CPU correctness (CPU/socket NUMA node should
> match NIC NUMA node)
> +     - Write the file to a path on your system
> +
> +   Then, presuming you are using the test_run.example.yaml as a template
> for your test_run config:
> +     - Uncomment the performance_traffic_generator section, making DTS
> use a performance TG
> +     - Update the remote_path and config fields to the remote path of
> your TREX directory and the path to your new TREX config file
> +     - Update the "perf" field to enable performance testing
> +
> +   After these steps, you should be ready to run performance tests with
> TREX.
> +
> +
>  #. **Hardware dependencies**
>
>     The traffic generators, like DPDK, need a proper driver and firmware.
> @@ -249,9 +276,9 @@ DTS configuration is split into nodes and a test run,
>  and must respect the model definitions
>  as documented in the DTS API docs under the ``config`` page.
>  The root of the configuration is represented by the ``Configuration``
> model.
> -By default, DTS will try to use the ``dts/test_run.example.yaml``
> +By default, DTS will try to use the
> ``dts/configurations/test_run.example.yaml``
>  :ref:`config file <test_run_configuration_example>`,
> -and ``dts/nodes.example.yaml``
> +and ``dts/configurations/nodes.example.yaml``
>  :ref:`config file <nodes_configuration_example>`
>  which are templates that illustrate what can be configured in DTS.
>
> @@ -278,9 +305,9 @@ DTS is run with ``main.py`` located in the ``dts``
> directory using the ``poetry
>     options:
>       -h, --help            show this help message and exit
>       --test-run-config-file FILE_PATH
> -                           [DTS_TEST_RUN_CFG_FILE] The configuration fil=
e
> that describes the test cases and DPDK build options. (default:
> test-run.conf.yaml)
> +                           [DTS_TEST_RUN_CFG_FILE] The configuration fil=
e
> that describes the test cases and DPDK build options. (default:
> configurations/test_run.yaml)
>       --nodes-config-file FILE_PATH
> -                           [DTS_NODES_CFG_FILE] The configuration file
> that describes the SUT and TG nodes. (default: nodes.conf.yaml)
> +                           [DTS_NODES_CFG_FILE] The configuration file
> that describes the SUT and TG nodes. (default: configurations/nodes.yaml)
>       --tests-config-file FILE_PATH
>                             [DTS_TESTS_CFG_FILE] Configuration file used
> to override variable values inside specific test suites. (default: None)
>       --output-dir DIR_PATH, --output DIR_PATH
> @@ -549,20 +576,20 @@ And they both have two network ports which are
> physically connected to each othe
>
>  .. _test_run_configuration_example:
>
> -``dts/test_run.example.yaml``
> -~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +``dts/configurations/test_run.example.yaml``
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> -.. literalinclude:: ../../../dts/test_run.example.yaml
> +.. literalinclude:: ../../../dts/configurations/test_run.example.yaml
>     :language: yaml
>     :start-at: # Define
>
>  .. _nodes_configuration_example:
>
>
> -``dts/nodes.example.yaml``
> -~~~~~~~~~~~~~~~~~~~~~~~~~~
> +``dts/configurations/nodes.example.yaml``
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> -.. literalinclude:: ../../../dts/nodes.example.yaml
> +.. literalinclude:: ../../../dts/configurations/nodes.example.yaml
>     :language: yaml
>     :start-at: # Define
>
> @@ -575,9 +602,9 @@ to demonstrate custom test suite configuration:
>
>  .. _tests_config_example:
>
> -``dts/tests_config.example.yaml``
> -~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +``dts/configurations/tests_config.example.yaml``
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> -.. literalinclude:: ../../../dts/tests_config.example.yaml
> +.. literalinclude:: ../../../dts/configurations/tests_config.example.yam=
l
>     :language: yaml
>     :start-at: # Define
> diff --git a/dts/api/packet.py b/dts/api/packet.py
> index b6759d4ce0..ac7f64dd17 100644
> --- a/dts/api/packet.py
> +++ b/dts/api/packet.py
> @@ -85,9 +85,9 @@ def send_packets_and_capture(
>      )
>
>      assert isinstance(
> -        get_ctx().tg, CapturingTrafficGenerator
> +        get_ctx().func_tg, CapturingTrafficGenerator
>      ), "Cannot capture with a non-capturing traffic generator"
> -    tg: CapturingTrafficGenerator =3D cast(CapturingTrafficGenerator,
> get_ctx().tg)
> +    tg: CapturingTrafficGenerator =3D cast(CapturingTrafficGenerator,
> get_ctx().func_tg)
>      # TODO: implement @requires for types of traffic generator
>      packets =3D adjust_addresses(packets)
>      return tg.send_packets_and_capture(
> @@ -108,7 +108,7 @@ def send_packets(
>          packets: Packets to send.
>      """
>      packets =3D adjust_addresses(packets)
> -    get_ctx().tg.send_packets(packets, get_ctx().topology.tg_port_egress=
)
> +    get_ctx().func_tg.send_packets(packets,
> get_ctx().topology.tg_port_egress)
>
>
>  def get_expected_packets(
> diff --git a/dts/nodes.example.yaml b/dts/configurations/nodes.example.ya=
ml
> similarity index 100%
> rename from dts/nodes.example.yaml
> rename to dts/configurations/nodes.example.yaml
> diff --git a/dts/test_run.example.yaml
> b/dts/configurations/test_run.example.yaml
> similarity index 88%
> rename from dts/test_run.example.yaml
> rename to dts/configurations/test_run.example.yaml
> index c90de9d68d..c8035fccf0 100644
> --- a/dts/test_run.example.yaml
> +++ b/dts/configurations/test_run.example.yaml
> @@ -23,8 +23,12 @@ dpdk:
>      # in a subdirectory of DPDK tree root directory. Otherwise, will be
> using the `build_options`
>      # to build the DPDK from source. Either `precompiled_build_dir` or
> `build_options` can be
>      # defined, but not both.
> -traffic_generator:
> +func_traffic_generator:
>    type: SCAPY
> +# perf_traffic_generator:
> +#   type: TREX
> +#   remote_path: "/opt/trex/v3.03" # The remote path of the traffic
> generator application.
> +#   config: "/opt/trex_config/trex_config.yaml" # Additional
> configuration files. (Leave blank if not required)
>  perf: false # disable performance testing
>  func: true # enable functional testing
>  use_virtual_functions: false # use virtual functions (VFs) instead of
> physical functions
> diff --git a/dts/tests_config.example.yaml
> b/dts/configurations/tests_config.example.yaml
> similarity index 100%
> rename from dts/tests_config.example.yaml
> rename to dts/configurations/tests_config.example.yaml
> diff --git a/dts/framework/config/test_run.py
> b/dts/framework/config/test_run.py
> index 71b3755d6e..68db862cea 100644
> --- a/dts/framework/config/test_run.py
> +++ b/dts/framework/config/test_run.py
> @@ -16,7 +16,7 @@
>  from enum import Enum, auto, unique
>  from functools import cached_property
>  from pathlib import Path, PurePath
> -from typing import Annotated, Any, Literal, NamedTuple
> +from typing import Annotated, Any, Literal, NamedTuple, Optional
>
>  from pydantic import (
>      BaseModel,
> @@ -396,6 +396,8 @@ class TrafficGeneratorType(str, Enum):
>
>      #:
>      SCAPY =3D "SCAPY"
> +    #:
> +    TREX =3D "TREX"
>
>
>  class TrafficGeneratorConfig(FrozenModel):
> @@ -412,8 +414,18 @@ class
> ScapyTrafficGeneratorConfig(TrafficGeneratorConfig):
>      type: Literal[TrafficGeneratorType.SCAPY]
>
>
> +class TrexTrafficGeneratorConfig(TrafficGeneratorConfig):
> +    """TREX traffic generator specific configuration."""
> +
> +    type: Literal[TrafficGeneratorType.TREX]
> +    remote_path: PurePath
> +    config: PurePath
> +
> +
>  #: A union type discriminating traffic generators by the `type` field.
> -TrafficGeneratorConfigTypes =3D Annotated[ScapyTrafficGeneratorConfig,
> Field(discriminator=3D"type")]
> +TrafficGeneratorConfigTypes =3D Annotated[
> +    TrexTrafficGeneratorConfig, ScapyTrafficGeneratorConfig,
> Field(discriminator=3D"type")
> +]
>
>  #: Comma-separated list of logical cores to use. An empty string or
> ```any``` means use all lcores.
>  LogicalCores =3D Annotated[
> @@ -461,8 +473,10 @@ class TestRunConfiguration(FrozenModel):
>
>      #: The DPDK configuration used to test.
>      dpdk: DPDKConfiguration
> -    #: The traffic generator configuration used to test.
> -    traffic_generator: TrafficGeneratorConfigTypes
> +    #: The traffic generator configuration used for functional tests.
> +    func_traffic_generator: Optional[ScapyTrafficGeneratorConfig] =3D No=
ne
> +    #: The traffic generator configuration used for performance tests.
> +    perf_traffic_generator: Optional[TrexTrafficGeneratorConfig] =3D Non=
e
>      #: Whether to run performance tests.
>      perf: bool
>      #: Whether to run functional tests.
> diff --git a/dts/framework/context.py b/dts/framework/context.py
> index ae319d949f..8f1021dc96 100644
> --- a/dts/framework/context.py
> +++ b/dts/framework/context.py
> @@ -6,7 +6,7 @@
>  import functools
>  from collections.abc import Callable
>  from dataclasses import MISSING, dataclass, field, fields
> -from typing import TYPE_CHECKING, Any, ParamSpec, Union
> +from typing import TYPE_CHECKING, Any, Optional, ParamSpec, Union
>
>  from framework.exception import InternalError
>  from framework.remote_session.shell_pool import ShellPool
> @@ -76,7 +76,8 @@ class Context:
>      topology: Topology
>      dpdk_build: "DPDKBuildEnvironment"
>      dpdk: "DPDKRuntimeEnvironment"
> -    tg: "TrafficGenerator"
> +    func_tg: Optional["TrafficGenerator"]
> +    perf_tg: Optional["TrafficGenerator"]
>      local: LocalContext =3D field(default_factory=3DLocalContext)
>      shell_pool: ShellPool =3D field(default_factory=3DShellPool)
>
> diff --git a/dts/framework/remote_session/blocking_app.py
> b/dts/framework/remote_session/blocking_app.py
> index 8de536c259..c3b02dcc62 100644
> --- a/dts/framework/remote_session/blocking_app.py
> +++ b/dts/framework/remote_session/blocking_app.py
> @@ -48,20 +48,23 @@ class BlockingApp(InteractiveShell, Generic[P]):
>      def __init__(
>          self,
>          node: Node,
> -        path: PurePath,
> +        path: str | PurePath,
>          name: str | None =3D None,
>          privileged: bool =3D False,
>          app_params: P | str =3D "",
> +        add_to_shell_pool: bool =3D True,
>      ) -> None:
>          """Constructor.
>
>          Args:
>              node: The node to run the app on.
> -            path: Path to the application on the node.
> +            path: Path to the application on the node.s
>              name: Name to identify this application.
>              privileged: Run as privileged user.
>              app_params: The application parameters. Can be of any type
> inheriting :class:`Params` or
>                  a plain string.
> +            add_to_shell_pool: If :data:`True`, the blocking app's shell
> will be added to the
> +                shell pool.
>          """
>          if isinstance(app_params, str):
>              params =3D Params()
> @@ -69,11 +72,12 @@ def __init__(
>              app_params =3D cast(P, params)
>
>          self._path =3D path
> +        self._add_to_shell_pool =3D add_to_shell_pool
>
>          super().__init__(node, name, privileged, app_params)
>
>      @property
> -    def path(self) -> PurePath:
> +    def path(self) -> str | PurePath:
>          """The path of the DPDK app relative to the DPDK build folder.""=
"
>          return self._path
>
> @@ -86,7 +90,7 @@ def wait_until_ready(self, end_token: str) -> Self:
>          Returns:
>              Itself.
>          """
> -        self.start_application(end_token)
> +        self.start_application(end_token, self._add_to_shell_pool)
>          return self
>
>      def close(self) -> None:
> diff --git a/dts/framework/remote_session/interactive_shell.py
> b/dts/framework/remote_session/interactive_shell.py
> index ce93247051..a65cbce209 100644
> --- a/dts/framework/remote_session/interactive_shell.py
> +++ b/dts/framework/remote_session/interactive_shell.py
> @@ -140,7 +140,7 @@ def _make_start_command(self) -> str:
>              start_command =3D
> self._node.main_session._get_privileged_command(start_command)
>          return start_command
>
> -    def start_application(self, prompt: str | None =3D None) -> None:
> +    def start_application(self, prompt: str | None =3D None,
> add_to_shell_pool: bool =3D True) -> None:
>          """Starts a new interactive application based on the path to the
> app.
>
>          This method is often overridden by subclasses as their process
> for starting may look
> @@ -151,6 +151,7 @@ def start_application(self, prompt: str | None =3D No=
ne)
> -> None:
>          Args:
>              prompt: When starting up the application, expect this string
> at the end of stdout when
>                  the application is ready. If :data:`None`, the class'
> default prompt will be used.
> +            add_to_shell_pool: If :data:`True`, the shell will be
> registered to the shell pool.
>
>          Raises:
>              InteractiveCommandExecutionError: If the application fails t=
o
> start within the allotted
> @@ -174,7 +175,8 @@ def start_application(self, prompt: str | None =3D No=
ne)
> -> None:
>              self.is_alive =3D False  # update state on failure to start
>              raise InteractiveCommandExecutionError("Failed to start
> application.")
>          self._ssh_channel.settimeout(self._timeout)
> -        get_ctx().shell_pool.register_shell(self)
> +        if add_to_shell_pool:
> +            get_ctx().shell_pool.register_shell(self)
>
>      def send_command(
>          self, command: str, prompt: str | None =3D None, skip_first_line=
:
> bool =3D False
> @@ -259,7 +261,7 @@ def close(self) -> None:
>
>      @property
>      @abstractmethod
> -    def path(self) -> PurePath:
> +    def path(self) -> str | PurePath:
>          """Path to the shell executable."""
>
>      def _make_real_path(self) -> PurePath:
> diff --git a/dts/framework/settings.py b/dts/framework/settings.py
> index 84b627a06a..b08373b7ea 100644
> --- a/dts/framework/settings.py
> +++ b/dts/framework/settings.py
> @@ -130,11 +130,17 @@ class Settings:
>      """
>
>      #:
> -    test_run_config_path: Path =3D
> Path(__file__).parent.parent.joinpath("test_run.yaml")
> +    test_run_config_path: Path =3D Path(__file__).parent.parent.joinpath=
(
> +        "configurations/test_run.yaml"
> +    )
>      #:
> -    nodes_config_path: Path =3D
> Path(__file__).parent.parent.joinpath("nodes.yaml")
> +    nodes_config_path: Path =3D
> Path(__file__).parent.parent.joinpath("configurations/nodes.yaml")
>      #:
> -    tests_config_path: Path | None =3D None
> +    tests_config_path: Path | None =3D (
> +
> Path(__file__).parent.parent.joinpath("configurations/tests_config.yaml")
> +        if os.path.exists("configurations/tests_config.yaml")
> +        else None
> +    )
>      #:
>      output_dir: str =3D "output"
>      #:
> diff --git a/dts/framework/test_run.py b/dts/framework/test_run.py
> index 9cf04c0b06..ff0a12c9ce 100644
> --- a/dts/framework/test_run.py
> +++ b/dts/framework/test_run.py
> @@ -113,7 +113,7 @@
>  from framework.remote_session.dpdk import DPDKBuildEnvironment,
> DPDKRuntimeEnvironment
>  from framework.settings import SETTINGS
>  from framework.test_result import Result, ResultNode, TestRunResult
> -from framework.test_suite import BaseConfig, TestCase, TestSuite
> +from framework.test_suite import BaseConfig, TestCase, TestCaseType,
> TestSuite
>  from framework.testbed_model.capability import (
>      Capability,
>      get_supported_capabilities,
> @@ -199,10 +199,26 @@ def __init__(
>
>          dpdk_build_env =3D DPDKBuildEnvironment(config.dpdk.build, sut_n=
ode)
>          dpdk_runtime_env =3D DPDKRuntimeEnvironment(config.dpdk, sut_nod=
e,
> dpdk_build_env)
> -        traffic_generator =3D
> create_traffic_generator(config.traffic_generator, tg_node)
> +
> +        func_traffic_generator =3D (
> +            create_traffic_generator(config.func_traffic_generator,
> tg_node)
> +            if config.func and config.func_traffic_generator
> +            else None
> +        )
> +        perf_traffic_generator =3D (
> +            create_traffic_generator(config.perf_traffic_generator,
> tg_node)
> +            if config.perf and config.perf_traffic_generator
> +            else None
> +        )
>
>          self.ctx =3D Context(
> -            sut_node, tg_node, topology, dpdk_build_env,
> dpdk_runtime_env, traffic_generator
> +            sut_node,
> +            tg_node,
> +            topology,
> +            dpdk_build_env,
> +            dpdk_runtime_env,
> +            func_traffic_generator,
> +            perf_traffic_generator,
>          )
>          self.result =3D result
>          self.selected_tests =3D list(self.config.filter_tests(tests_conf=
ig))
> @@ -335,7 +351,10 @@ def next(self) -> State | None:
>              test_run.ctx.topology.instantiate_vf_ports()
>
>          test_run.ctx.topology.configure_ports("sut", "dpdk")
> -        test_run.ctx.tg.setup(test_run.ctx.topology)
> +        if test_run.ctx.func_tg:
> +            test_run.ctx.func_tg.setup(test_run.ctx.topology)
> +        if test_run.ctx.perf_tg:
> +            test_run.ctx.perf_tg.setup(test_run.ctx.topology)
>
>          self.result.ports =3D [
>              port.to_dict()
> @@ -425,7 +444,10 @@ def next(self) -> State | None:
>              self.test_run.ctx.topology.delete_vf_ports()
>
>          self.test_run.ctx.shell_pool.terminate_current_pool()
> -        self.test_run.ctx.tg.teardown()
> +        if self.test_run.ctx.func_tg and
> self.test_run.ctx.func_tg.is_setup:
> +            self.test_run.ctx.func_tg.teardown()
> +        if self.test_run.ctx.perf_tg and
> self.test_run.ctx.perf_tg.is_setup:
> +            self.test_run.ctx.perf_tg.teardown()
>          self.test_run.ctx.topology.teardown()
>          self.test_run.ctx.dpdk.teardown()
>          self.test_run.ctx.tg_node.teardown()
> @@ -611,6 +633,26 @@ def next(self) -> State | None:
>          )
>          self.test_run.ctx.topology.configure_ports("sut",
> sut_ports_drivers)
>
> +        if (
> +            self.test_run.ctx.perf_tg
> +            and self.test_run.ctx.perf_tg.is_setup
> +            and self.test_case.test_type is TestCaseType.FUNCTIONAL
> +        ):
> +            self.test_run.ctx.perf_tg.teardown()
> +            self.test_run.ctx.topology.configure_ports("tg", "kernel")
> +            if self.test_run.ctx.func_tg and not
> self.test_run.ctx.func_tg.is_setup:
> +
> self.test_run.ctx.func_tg.setup(self.test_run.ctx.topology)
> +
> +        if (
> +            self.test_run.ctx.func_tg
> +            and self.test_run.ctx.func_tg.is_setup
> +            and self.test_case.test_type is TestCaseType.PERFORMANCE
> +        ):
> +            self.test_run.ctx.func_tg.teardown()
> +            self.test_run.ctx.topology.configure_ports("tg", "dpdk")
> +            if self.test_run.ctx.perf_tg and not
> self.test_run.ctx.perf_tg.is_setup:
> +
> self.test_run.ctx.perf_tg.setup(self.test_run.ctx.topology)
> +
>          self.test_suite.set_up_test_case()
>          self.result.mark_step_as("setup", Result.PASS)
>          return TestCaseExecution(
> diff --git a/dts/framework/testbed_model/traffic_generator/__init__.py
> b/dts/framework/testbed_model/traffic_generator/__init__.py
> index 2a259a6e6c..fca251f534 100644
> --- a/dts/framework/testbed_model/traffic_generator/__init__.py
> +++ b/dts/framework/testbed_model/traffic_generator/__init__.py
> @@ -14,17 +14,22 @@
>  and a capturing traffic generator is required.
>  """
>
> -from framework.config.test_run import ScapyTrafficGeneratorConfig,
> TrafficGeneratorConfig
> +from framework.config.test_run import (
> +    ScapyTrafficGeneratorConfig,
> +    TrafficGeneratorConfig,
> +    TrexTrafficGeneratorConfig,
> +)
>  from framework.exception import ConfigurationError
>  from framework.testbed_model.node import Node
>
> -from .capturing_traffic_generator import CapturingTrafficGenerator
>  from .scapy import ScapyTrafficGenerator
> +from .traffic_generator import TrafficGenerator
> +from .trex import TrexTrafficGenerator
>
>
>  def create_traffic_generator(
>      traffic_generator_config: TrafficGeneratorConfig, node: Node
> -) -> CapturingTrafficGenerator:
> +) -> TrafficGenerator:
>      """The factory function for creating traffic generator objects from
> the test run configuration.
>
>      Args:
> @@ -40,5 +45,7 @@ def create_traffic_generator(
>      match traffic_generator_config:
>          case ScapyTrafficGeneratorConfig():
>              return ScapyTrafficGenerator(node, traffic_generator_config,
> privileged=3DTrue)
> +        case TrexTrafficGeneratorConfig():
> +            return TrexTrafficGenerator(node, traffic_generator_config)
>          case _:
>              raise ConfigurationError(f"Unknown traffic generator:
> {traffic_generator_config.type}")
> diff --git a/dts/framework/testbed_model/traffic_generator/scapy.py
> b/dts/framework/testbed_model/traffic_generator/scapy.py
> index a31807e8e4..9e15a31c00 100644
> --- a/dts/framework/testbed_model/traffic_generator/scapy.py
> +++ b/dts/framework/testbed_model/traffic_generator/scapy.py
> @@ -170,12 +170,17 @@ def stop_capturing_and_collect(
>          finally:
>              self.stop_capturing()
>
> -    def start_application(self, prompt: str | None =3D None) -> None:
> +    def start_application(self, prompt: str | None =3D None,
> add_to_shell_pool: bool =3D True) -> None:
>          """Overrides
> :meth:`framework.remote_session.interactive_shell.start_application`.
>
>          Prepares the Python shell for scapy and starts the sniffing in a
> new thread.
> +
> +        Args:
> +            prompt: When starting up the application, expect this string
> at the end of stdout when
> +                the application is ready. If :data:`None`, the class'
> default prompt will be used.
> +            add_to_shell_pool: If :data:`True`, the shell will be
> registered to the shell pool.
>          """
> -        super().start_application(prompt)
> +        super().start_application(prompt, add_to_shell_pool)
>          self.send_command("from scapy.all import *")
>          self._sniffer.start()
>          self._is_sniffing.wait()
> @@ -320,15 +325,16 @@ def setup(self, topology: Topology) -> None:
>
>          Binds the TG node ports to the kernel drivers and starts up the
> async sniffer.
>          """
> +        super().setup(topology)
>          topology.configure_ports("tg", "kernel")
>
>          self._sniffer =3D ScapyAsyncSniffer(
>              self._tg_node, topology.tg_port_ingress, self._sniffer_name
>          )
> -        self._sniffer.start_application()
> +        self._sniffer.start_application(add_to_shell_pool=3DFalse)
>
>          self._shell =3D PythonShell(self._tg_node, "scapy", privileged=
=3DTrue)
> -        self._shell.start_application()
> +        self._shell.start_application(add_to_shell_pool=3DFalse)
>          self._shell.send_command("from scapy.all import *")
>          self._shell.send_command("from scapy.contrib.lldp import *")
>
> diff --git
> a/dts/framework/testbed_model/traffic_generator/traffic_generator.py
> b/dts/framework/testbed_model/traffic_generator/traffic_generator.py
> index e5f246df7a..cdda5a7c08 100644
> --- a/dts/framework/testbed_model/traffic_generator/traffic_generator.py
> +++ b/dts/framework/testbed_model/traffic_generator/traffic_generator.py
> @@ -11,9 +11,12 @@
>  from abc import ABC, abstractmethod
>  from typing import Any
>
> +from scapy.packet import Packet
> +
>  from framework.config.test_run import TrafficGeneratorConfig
>  from framework.logger import DTSLogger, get_dts_logger
>  from framework.testbed_model.node import Node
> +from framework.testbed_model.port import Port
>  from framework.testbed_model.topology import Topology
>
>
> @@ -30,6 +33,7 @@ class TrafficGenerator(ABC):
>      _config: TrafficGeneratorConfig
>      _tg_node: Node
>      _logger: DTSLogger
> +    _is_setup: bool
>
>      def __init__(self, tg_node: Node, config: TrafficGeneratorConfig,
> **kwargs: Any) -> None:
>          """Initialize the traffic generator.
> @@ -45,12 +49,25 @@ def __init__(self, tg_node: Node, config:
> TrafficGeneratorConfig, **kwargs: Any)
>          self._config =3D config
>          self._tg_node =3D tg_node
>          self._logger =3D get_dts_logger(f"{self._tg_node.name}
> {self._config.type}")
> +        self._is_setup =3D False
> +
> +    def send_packets(self, packets: list[Packet], port: Port) -> None:
> +        """Send `packets` and block until they are fully sent.
> +
> +        Send `packets` on `port`, then wait until `packets` are fully
> sent.
> +
> +        Args:
> +            packets: The packets to send.
> +            port: The egress port on the TG node.
> +        """
>
>      def setup(self, topology: Topology) -> None:
>          """Setup the traffic generator."""
> +        self._is_setup =3D True
>
>      def teardown(self) -> None:
>          """Teardown the traffic generator."""
> +        self._is_setup =3D False
>          self.close()
>
>      @property
> @@ -61,3 +78,8 @@ def is_capturing(self) -> bool:
>      @abstractmethod
>      def close(self) -> None:
>          """Free all resources used by the traffic generator."""
> +
> +    @property
> +    def is_setup(self) -> bool:
> +        """Indicates whether the traffic generator application is
> currently running."""
> +        return self._is_setup
> diff --git a/dts/framework/testbed_model/traffic_generator/trex.py
> b/dts/framework/testbed_model/traffic_generator/trex.py
> new file mode 100644
> index 0000000000..6ae6d1f181
> --- /dev/null
> +++ b/dts/framework/testbed_model/traffic_generator/trex.py
> @@ -0,0 +1,259 @@
> +# SPDX-License-Identifier: BSD-3-Clause
> +# Copyright(c) 2025 University of New Hampshire
> +
> +"""Implementation for TREX performance traffic generator."""
> +
> +import ast
> +import time
> +from dataclasses import dataclass, field
> +from enum import auto
> +from typing import ClassVar
> +
> +from scapy.packet import Packet
> +
> +from framework.config.node import OS, NodeConfiguration
> +from framework.config.test_run import TrexTrafficGeneratorConfig
> +from framework.parser import TextParser
> +from framework.remote_session.blocking_app import BlockingApp
> +from framework.remote_session.python_shell import PythonShell
> +from framework.testbed_model.node import Node, create_session
> +from framework.testbed_model.os_session import OSSession
> +from framework.testbed_model.topology import Topology
> +from
> framework.testbed_model.traffic_generator.performance_traffic_generator
> import (
> +    PerformanceTrafficGenerator,
> +    PerformanceTrafficStats,
> +)
> +from framework.utils import StrEnum
> +
> +
> +@dataclass(slots=3DTrue)
> +class TrexPerformanceTrafficStats(PerformanceTrafficStats, TextParser):
> +    """Data structure to store performance statistics for a given test
> run.
> +
> +    This class overrides the initialization of
> :class:`PerformanceTrafficStats`
> +    in order to set the attribute values using the TREX stats output.
> +
> +    Attributes:
> +        tx_pps: Recorded tx packets per second.
> +        tx_bps: Recorded tx bytes per second.
> +        rx_pps: Recorded rx packets per second.
> +        rx_bps: Recorded rx bytes per second.
> +        frame_size: The total length of the frame.
> +    """
> +
> +    tx_pps: int =3D field(metadata=3DTextParser.find_int(r"total.*'tx_pp=
s':
> (\d+)"))
> +    tx_bps: int =3D field(metadata=3DTextParser.find_int(r"total.*'tx_bp=
s':
> (\d+)"))
> +    rx_pps: int =3D field(metadata=3DTextParser.find_int(r"total.*'rx_pp=
s':
> (\d+)"))
> +    rx_bps: int =3D field(metadata=3DTextParser.find_int(r"total.*'rx_bp=
s':
> (\d+)"))
> +
> +
> +class TrexStatelessTXModes(StrEnum):
> +    """Flags indicating TREX instance's current transmission mode."""
> +
> +    #: Transmit continuously
> +    STLTXCont =3D auto()
> +    #: Transmit in a single burst
> +    STLTXSingleBurst =3D auto()
> +    #: Transmit in multiple bursts
> +    STLTXMultiBurst =3D auto()
> +
> +
> +class TrexTrafficGenerator(PerformanceTrafficGenerator):
> +    """TREX traffic generator.
> +
> +    This implementation leverages the stateless API library provided in
> the TREX installation.
> +
> +    Attributes:
> +        stl_client_name: The name of the stateless client used in the
> stateless API.
> +        packet_stream_name: The name of the stateless packet stream used
> in the stateless API.
> +    """
> +
> +    _os_session: OSSession
> +
> +    _tg_config: TrexTrafficGeneratorConfig
> +    _node_config: NodeConfiguration
> +
> +    _shell: PythonShell
> +    _python_indentation: ClassVar[str] =3D " " * 4
> +
> +    stl_client_name: ClassVar[str] =3D "client"
> +    packet_stream_name: ClassVar[str] =3D "stream"
> +
> +    _streaming_mode: TrexStatelessTXModes =3D TrexStatelessTXModes.STLTX=
Cont
> +
> +    _tg_cores: int =3D 10
> +
> +    _trex_app: BlockingApp
> +
> +    def __init__(self, tg_node: Node, config: TrexTrafficGeneratorConfig=
)
> -> None:
> +        """Initialize the TREX server.
> +
> +        Initializes needed OS sessions for the creation of the TREX
> server process.
> +
> +        Args:
> +            tg_node: TG node the TREX instance is operating on.
> +            config: Traffic generator config provided for TREX instance.
> +        """
> +        assert (
> +            tg_node.config.os =3D=3D OS.linux
> +        ), "Linux is the only supported OS for trex traffic generation"
> +
> +        super().__init__(tg_node=3Dtg_node, config=3Dconfig)
> +        self._tg_node_config =3D tg_node.config
> +        self._tg_config =3D config
> +
> +        self._os_session =3D create_session(self._tg_node.config, "TREX"=
,
> self._logger)
> +
> +    def setup(self, topology: Topology):
> +        """Initialize and start a TREX server process."""
> +        super().setup(topology)
> +
> +        self._shell =3D PythonShell(self._tg_node, "TREX-client",
> privileged=3DTrue)
> +
> +        # Start TREX server process.
> +        trex_app_path =3D f"cd {self._tg_config.remote_path} && ./t-rex-=
64"
> +        self._trex_app =3D BlockingApp(
> +            node=3Dself._tg_node,
> +            path=3Dtrex_app_path,
> +            name=3D"trex-tg",
> +            privileged=3DTrue,
> +            app_params=3Df"--cfg {self._tg_config.config} -c
> {self._tg_cores} -i",
> +            add_to_shell_pool=3DFalse,
> +        )
> +        self._trex_app.wait_until_ready("-Per port stats table")
> +
> +        self._shell.start_application()
> +        self._shell.send_command("import os")
> +        self._shell.send_command(
> +
> f"os.chdir('{self._tg_config.remote_path}/automation/trex_control_plane/i=
nteractive')"
> +        )
> +
> +        # Import stateless API components.
> +        imports =3D [
> +            "import trex",
> +            "import trex.stl",
> +            "import trex.stl.trex_stl_client",
> +            "import trex.stl.trex_stl_streams",
> +            "import trex.stl.trex_stl_packet_builder_scapy",
> +            "from scapy.layers.l2 import Ether",
> +            "from scapy.layers.inet import IP",
> +            "from scapy.packet import Raw",
> +        ]
> +        self._shell.send_command("\n".join(imports))
> +
> +        stateless_client =3D [
> +            f"{self.stl_client_name} =3D
> trex.stl.trex_stl_client.STLClient(",
> +            f"username=3D'{self._tg_node_config.user}',",
> +            "server=3D'127.0.0.1',",
> +            ")",
> +        ]
> +
> +
> self._shell.send_command(f"\n{self._python_indentation}".join(stateless_c=
lient))
> +        self._shell.send_command(f"{self.stl_client_name}.connect()")
> +
> +    def calculate_traffic_and_stats(
> +        self,
> +        packet: Packet,
> +        duration: float,
> +        send_mpps: int | None =3D None,
> +    ) -> PerformanceTrafficStats:
> +        """Send packet traffic and acquire associated statistics.
> +
> +        Overrides
> +
> :meth:`~.traffic_generator.PerformanceTrafficGenerator.calculate_traffic_=
and_stats`.
> +        """
> +        trex_stats_output =3D
> ast.literal_eval(self._generate_traffic(packet, duration, send_mpps))
> +        stats =3D TrexPerformanceTrafficStats.parse(str(trex_stats_outpu=
t))
> +        stats.frame_size =3D len(packet)
> +        return stats
> +
> +    def _generate_traffic(
> +        self, packet: Packet, duration: float, send_mpps: int | None =3D
> None
> +    ) -> str:
> +        """Generate traffic using provided packet.
> +
> +        Uses the provided packet to generate traffic for the provided
> duration.
> +
> +        Args:
> +            packet: The packet being used for the performance test.
> +            duration: The duration of the test being performed.
> +            send_mpps: MPPS send rate.
> +
> +        Returns:
> +            A string output of statistics provided by the traffic
> generator.
> +        """
> +        self._create_packet_stream(packet)
> +        self._setup_trex_client()
> +
> +        stats =3D self._send_traffic_and_get_stats(duration, send_mpps)
> +
> +        return stats
> +
> +    def _setup_trex_client(self) -> None:
> +        """Create trex client and connect to the server process."""
> +        # Prepare TREX client for next performance test.
> +        procedure =3D [
> +            f"{self.stl_client_name}.connect()",
> +            f"{self.stl_client_name}.reset(ports =3D [0, 1])",
> +            f"{self.stl_client_name}.clear_stats()",
> +
> f"{self.stl_client_name}.add_streams({self.packet_stream_name}, ports=3D[=
0,
> 1])",
> +        ]
> +
> +        for command in procedure:
> +            self._shell.send_command(command)
> +
> +    def _create_packet_stream(self, packet: Packet) -> None:
> +        """Create TREX packet stream with the given packet.
> +
> +        Args:
> +            packet: The packet being used for the performance test.
> +        """
> +        # Create the tx packet on the TG shell
> +        self._shell.send_command(f"packet=3D{packet.command()}")
> +
> +        packet_stream =3D [
> +            f"{self.packet_stream_name} =3D
> trex.stl.trex_stl_streams.STLStream(",
> +            f"name=3D'Test_{len(packet)}_bytes',",
> +
> "packet=3Dtrex.stl.trex_stl_packet_builder_scapy.STLPktBuilder(pkt=3Dpack=
et),",
> +
> f"mode=3Dtrex.stl.trex_stl_streams.{self._streaming_mode}(percentage=3D10=
0),",
> +            ")",
> +        ]
> +        self._shell.send_command("\n".join(packet_stream))
> +
> +    def _send_traffic_and_get_stats(self, duration: float, send_mpps:
> float | None =3D None) -> str:
> +        """Send traffic and get TG Rx stats.
> +
> +        Sends traffic from the TREX client's ports for the given duratio=
n.
> +        When the traffic sending duration has passed, collect the
> aggregate
> +        statistics and return TREX's global stats as a string.
> +
> +        Args:
> +            duration: The traffic generation duration.
> +            send_mpps: The millions of packets per second for TREX to
> send from each port.
> +        """
> +        if send_mpps:
> +
> self._shell.send_command(f"""{self.stl_client_name}.start(ports=3D[0, 1],
> +                mult =3D '{send_mpps}mpps',
> +                duration =3D {duration})""")
> +        else:
> +
> self._shell.send_command(f"""{self.stl_client_name}.start(ports=3D[0, 1],
> +                mult =3D '100%',
> +                duration =3D {duration})""")
> +
> +        time.sleep(duration)
> +
> +        stats =3D self._shell.send_command(
> +            f"{self.stl_client_name}.get_stats(ports=3D[0, 1])",
> skip_first_line=3DTrue
> +        )
> +
> +        self._shell.send_command(f"{self.stl_client_name}.stop(ports=3D[=
0,
> 1])")
> +
> +        return stats
> +
> +    def close(self) -> None:
> +        """Overrides :meth:`.traffic_generator.TrafficGenerator.close`.
> +
> +        Stops the traffic generator and sniffer shells.
> +        """
> +        self._trex_app.close()
> +        self._shell.close()
> --
> 2.49.0
>
>

--000000000000d9633f0642ed1dcc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Reviewed-by: Andrew Bailey &lt;<a href=3D"mailto:abailey@i=
ol.unh.edu" target=3D"_blank">abailey@iol.unh.edu</a>&gt;=C2=A0</div><br><d=
iv class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gm=
ail_attr">On Wed, Nov 5, 2025 at 5:37=E2=80=AFPM Patrick Robb &lt;<a href=
=3D"mailto:probb@iol.unh.edu">probb@iol.unh.edu</a>&gt; wrote:<br></div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex">From: Nicholas Pratte &lt;<a=
 href=3D"mailto:npratte@iol.unh.edu" target=3D"_blank">npratte@iol.unh.edu<=
/a>&gt;<br>
<br>
Implement the TREX traffic generator for use in the DTS framework. The<br>
provided implementation leverages TREX&#39;s stateless API automation<br>
library, via use of a Python shell. The DTS context has been modified<br>
to include a performance traffic generator in addition to a functional<br>
traffic generator.<br>
<br>
In addition, the DTS testrun state machine has been modified such that<br>
traffic generators are brought up and down as needed, and so that only<br>
one traffic generator application is running on the TG system at a time.<br=
>
During the testcase setup stage, the testcase type (perf or func) will<br>
be checked and the correct traffic generator brought up. For instance,<br>
if a functional TG is running from a previous test and we start a<br>
performance test, then the functional TG is stopped and the performance<br>
TG started. This is an attempt to strike a balance between the concept<br>
of having the scapy asyncsniffer always on to save on execution time,<br>
with the competing need to bring up performance traffic generators as<br>
needed. There is also an added boolean toggle for adding new shells<br>
to the current shell pool or omitting them from the shell pool in order<br>
to facilitate this new TG initialization approach.<br>
<br>
Bugzilla ID: 1697<br>
Signed-off-by: Nicholas Pratte &lt;<a href=3D"mailto:npratte@iol.unh.edu" t=
arget=3D"_blank">npratte@iol.unh.edu</a>&gt;<br>
Signed-off-by: Patrick Robb &lt;<a href=3D"mailto:probb@iol.unh.edu" target=
=3D"_blank">probb@iol.unh.edu</a>&gt;<br>
Reviewed-by: Dean Marx &lt;<a href=3D"mailto:dmarx@iol.unh.edu" target=3D"_=
blank">dmarx@iol.unh.edu</a>&gt;<br>
Reviewed-by: Andrew Bailey &lt;<a href=3D"mailto:abailey@iol.unh.edu" targe=
t=3D"_blank">abailey@iol.unh.edu</a>&gt;<br>
---<br>
=C2=A0doc/guides/tools/dts.rst=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 55 +++-<br>
=C2=A0dts/api/packet.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A06 +-<br>
=C2=A0dts/{ =3D&gt; configurations}/nodes.example.yaml=C2=A0 =C2=A0|=C2=A0 =
=C2=A00<br>
=C2=A0.../test_run.example.yaml=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A06 +-<br>
=C2=A0.../tests_config.example.yaml=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A00<br>
=C2=A0dts/framework/config/test_run.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 22 +-<br>
=C2=A0dts/framework/context.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A05 +-<br>
=C2=A0dts/framework/remote_session/blocking_app.py=C2=A0 |=C2=A0 12 +-<br>
=C2=A0.../remote_session/interactive_shell.py=C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 =C2=A08 +-<br>
=C2=A0dts/framework/settings.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 12 +-<br>
=C2=A0dts/framework/test_run.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 52 +++-<br>
=C2=A0.../traffic_generator/__init__.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 13 +-<br>
=C2=A0.../testbed_model/traffic_generator/scapy.py=C2=A0 |=C2=A0 14 +-<br>
=C2=A0.../traffic_generator/traffic_generator.py=C2=A0 =C2=A0 |=C2=A0 22 ++=
<br>
=C2=A0.../testbed_model/traffic_generator/trex.py=C2=A0 =C2=A0| 259 +++++++=
+++++++++++<br>
=C2=A015 files changed, 440 insertions(+), 46 deletions(-)<br>
=C2=A0rename dts/{ =3D&gt; configurations}/nodes.example.yaml (100%)<br>
=C2=A0rename dts/{ =3D&gt; configurations}/test_run.example.yaml (88%)<br>
=C2=A0rename dts/{ =3D&gt; configurations}/tests_config.example.yaml (100%)=
<br>
=C2=A0create mode 100644 dts/framework/testbed_model/traffic_generator/trex=
.py<br>
<br>
diff --git a/doc/guides/tools/dts.rst b/doc/guides/tools/dts.rst<br>
index 25c08c6a00..73d89eb1f6 100644<br>
--- a/doc/guides/tools/dts.rst<br>
+++ b/doc/guides/tools/dts.rst<br>
@@ -209,7 +209,8 @@ These need to be set up on a Traffic Generator Node:<br=
>
=C2=A0#. **Traffic generator dependencies**<br>
<br>
=C2=A0 =C2=A0 The traffic generator running on the traffic generator node m=
ust be installed beforehand.<br>
-=C2=A0 =C2=A0For Scapy traffic generator, only a few Python libraries need=
 to be installed:<br>
+<br>
+=C2=A0 =C2=A0For Scapy traffic generator (functional tests), only a few Py=
thon libraries need to be installed:<br>
<br>
=C2=A0 =C2=A0 .. code-block:: console<br>
<br>
@@ -217,6 +218,32 @@ These need to be set up on a Traffic Generator Node:<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0sudo pip install --upgrade pip<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0sudo pip install scapy=3D=3D2.5.0<br>
<br>
+=C2=A0 =C2=A0For TREX traffic generator (performance tests), TREX must be =
downloaded and a TREX config produced for each TG NIC. For example:<br>
+<br>
+=C2=A0 =C2=A0.. code-block:: console<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 wget <a href=3D"https://trex-tgn.cisco.com/trex/relea=
se/v3.03.tar.gz" rel=3D"noreferrer" target=3D"_blank">https://trex-tgn.cisc=
o.com/trex/release/v3.03.tar.gz</a><br>
+=C2=A0 =C2=A0 =C2=A0 tar -xf v3.03.tar.gz<br>
+=C2=A0 =C2=A0 =C2=A0 cd v3.03<br>
+=C2=A0 =C2=A0 =C2=A0 sudo ./dpdk_setup_ports.py -i<br>
+<br>
+=C2=A0 =C2=A0Within the dpdk_setup_ports.py utility, follow these instruct=
ions:<br>
+=C2=A0 =C2=A0 =C2=A0- Select MAC based config<br>
+=C2=A0 =C2=A0 =C2=A0- Select interfaces 0 and 1 on your TG NIC<br>
+=C2=A0 =C2=A0 =C2=A0- Do not change assumed dest to DUT MAC (just leave th=
e default loopback)<br>
+=C2=A0 =C2=A0 =C2=A0- Print preview of the config<br>
+=C2=A0 =C2=A0 =C2=A0- Check for device address correctness<br>
+=C2=A0 =C2=A0 =C2=A0- Check for socket and CPU correctness (CPU/socket NUM=
A node should match NIC NUMA node)<br>
+=C2=A0 =C2=A0 =C2=A0- Write the file to a path on your system<br>
+<br>
+=C2=A0 =C2=A0Then, presuming you are using the test_run.example.yaml as a =
template for your test_run config:<br>
+=C2=A0 =C2=A0 =C2=A0- Uncomment the performance_traffic_generator section,=
 making DTS use a performance TG<br>
+=C2=A0 =C2=A0 =C2=A0- Update the remote_path and config fields to the remo=
te path of your TREX directory and the path to your new TREX config file<br=
>
+=C2=A0 =C2=A0 =C2=A0- Update the &quot;perf&quot; field to enable performa=
nce testing<br>
+<br>
+=C2=A0 =C2=A0After these steps, you should be ready to run performance tes=
ts with TREX.<br>
+<br>
+<br>
=C2=A0#. **Hardware dependencies**<br>
<br>
=C2=A0 =C2=A0 The traffic generators, like DPDK, need a proper driver and f=
irmware.<br>
@@ -249,9 +276,9 @@ DTS configuration is split into nodes and a test run,<b=
r>
=C2=A0and must respect the model definitions<br>
=C2=A0as documented in the DTS API docs under the ``config`` page.<br>
=C2=A0The root of the configuration is represented by the ``Configuration``=
 model.<br>
-By default, DTS will try to use the ``dts/test_run.example.yaml``<br>
+By default, DTS will try to use the ``dts/configurations/test_run.example.=
yaml``<br>
=C2=A0:ref:`config file &lt;test_run_configuration_example&gt;`,<br>
-and ``dts/nodes.example.yaml``<br>
+and ``dts/configurations/nodes.example.yaml``<br>
=C2=A0:ref:`config file &lt;nodes_configuration_example&gt;`<br>
=C2=A0which are templates that illustrate what can be configured in DTS.<br=
>
<br>
@@ -278,9 +305,9 @@ DTS is run with ``main.py`` located in the ``dts`` dire=
ctory using the ``poetry<br>
=C2=A0 =C2=A0 options:<br>
=C2=A0 =C2=A0 =C2=A0 -h, --help=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sh=
ow this help message and exit<br>
=C2=A0 =C2=A0 =C2=A0 --test-run-config-file FILE_PATH<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0[DTS_TEST_RUN_CFG_FILE] The configuration file that=
 describes the test cases and DPDK build options. (default: test-run.conf.y=
aml)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0[DTS_TEST_RUN_CFG_FILE] The configuration file that=
 describes the test cases and DPDK build options. (default: configurations/=
test_run.yaml)<br>
=C2=A0 =C2=A0 =C2=A0 --nodes-config-file FILE_PATH<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0[DTS_NODES_CFG_FILE] The configuration file that de=
scribes the SUT and TG nodes. (default: nodes.conf.yaml)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0[DTS_NODES_CFG_FILE] The configuration file that de=
scribes the SUT and TG nodes. (default: configurations/nodes.yaml)<br>
=C2=A0 =C2=A0 =C2=A0 --tests-config-file FILE_PATH<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 [DTS_TESTS_CFG_FILE] Configuration file used to ov=
erride variable values inside specific test suites. (default: None)<br>
=C2=A0 =C2=A0 =C2=A0 --output-dir DIR_PATH, --output DIR_PATH<br>
@@ -549,20 +576,20 @@ And they both have two network ports which are physic=
ally connected to each othe<br>
<br>
=C2=A0.. _test_run_configuration_example:<br>
<br>
-``dts/test_run.example.yaml``<br>
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~<br>
+``dts/configurations/test_run.example.yaml``<br>
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~<br>
<br>
-.. literalinclude:: ../../../dts/test_run.example.yaml<br>
+.. literalinclude:: ../../../dts/configurations/test_run.example.yaml<br>
=C2=A0 =C2=A0 :language: yaml<br>
=C2=A0 =C2=A0 :start-at: # Define<br>
<br>
=C2=A0.. _nodes_configuration_example:<br>
<br>
<br>
-``dts/nodes.example.yaml``<br>
-~~~~~~~~~~~~~~~~~~~~~~~~~~<br>
+``dts/configurations/nodes.example.yaml``<br>
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~<br>
<br>
-.. literalinclude:: ../../../dts/nodes.example.yaml<br>
+.. literalinclude:: ../../../dts/configurations/nodes.example.yaml<br>
=C2=A0 =C2=A0 :language: yaml<br>
=C2=A0 =C2=A0 :start-at: # Define<br>
<br>
@@ -575,9 +602,9 @@ to demonstrate custom test suite configuration:<br>
<br>
=C2=A0.. _tests_config_example:<br>
<br>
-``dts/tests_config.example.yaml``<br>
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~<br>
+``dts/configurations/tests_config.example.yaml``<br>
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~<br>
<br>
-.. literalinclude:: ../../../dts/tests_config.example.yaml<br>
+.. literalinclude:: ../../../dts/configurations/tests_config.example.yaml<=
br>
=C2=A0 =C2=A0 :language: yaml<br>
=C2=A0 =C2=A0 :start-at: # Define<br>
diff --git a/dts/api/packet.py b/dts/api/packet.py<br>
index b6759d4ce0..ac7f64dd17 100644<br>
--- a/dts/api/packet.py<br>
+++ b/dts/api/packet.py<br>
@@ -85,9 +85,9 @@ def send_packets_and_capture(<br>
=C2=A0 =C2=A0 =C2=A0)<br>
<br>
=C2=A0 =C2=A0 =C2=A0assert isinstance(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 get_ctx().tg, CapturingTrafficGenerator<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 get_ctx().func_tg, CapturingTrafficGenerator<b=
r>
=C2=A0 =C2=A0 =C2=A0), &quot;Cannot capture with a non-capturing traffic ge=
nerator&quot;<br>
-=C2=A0 =C2=A0 tg: CapturingTrafficGenerator =3D cast(CapturingTrafficGener=
ator, get_ctx().tg)<br>
+=C2=A0 =C2=A0 tg: CapturingTrafficGenerator =3D cast(CapturingTrafficGener=
ator, get_ctx().func_tg)<br>
=C2=A0 =C2=A0 =C2=A0# TODO: implement @requires for types of traffic genera=
tor<br>
=C2=A0 =C2=A0 =C2=A0packets =3D adjust_addresses(packets)<br>
=C2=A0 =C2=A0 =C2=A0return tg.send_packets_and_capture(<br>
@@ -108,7 +108,7 @@ def send_packets(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0packets: Packets to send.<br>
=C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>
=C2=A0 =C2=A0 =C2=A0packets =3D adjust_addresses(packets)<br>
-=C2=A0 =C2=A0 get_ctx().tg.send_packets(packets, get_ctx().topology.tg_por=
t_egress)<br>
+=C2=A0 =C2=A0 get_ctx().func_tg.send_packets(packets, get_ctx().topology.t=
g_port_egress)<br>
<br>
<br>
=C2=A0def get_expected_packets(<br>
diff --git a/dts/nodes.example.yaml b/dts/configurations/nodes.example.yaml=
<br>
similarity index 100%<br>
rename from dts/nodes.example.yaml<br>
rename to dts/configurations/nodes.example.yaml<br>
diff --git a/dts/test_run.example.yaml b/dts/configurations/test_run.exampl=
e.yaml<br>
similarity index 88%<br>
rename from dts/test_run.example.yaml<br>
rename to dts/configurations/test_run.example.yaml<br>
index c90de9d68d..c8035fccf0 100644<br>
--- a/dts/test_run.example.yaml<br>
+++ b/dts/configurations/test_run.example.yaml<br>
@@ -23,8 +23,12 @@ dpdk:<br>
=C2=A0 =C2=A0 =C2=A0# in a subdirectory of DPDK tree root directory. Otherw=
ise, will be using the `build_options`<br>
=C2=A0 =C2=A0 =C2=A0# to build the DPDK from source. Either `precompiled_bu=
ild_dir` or `build_options` can be<br>
=C2=A0 =C2=A0 =C2=A0# defined, but not both.<br>
-traffic_generator:<br>
+func_traffic_generator:<br>
=C2=A0 =C2=A0type: SCAPY<br>
+# perf_traffic_generator:<br>
+#=C2=A0 =C2=A0type: TREX<br>
+#=C2=A0 =C2=A0remote_path: &quot;/opt/trex/v3.03&quot; # The remote path o=
f the traffic generator application.<br>
+#=C2=A0 =C2=A0config: &quot;/opt/trex_config/trex_config.yaml&quot; # Addi=
tional configuration files. (Leave blank if not required)<br>
=C2=A0perf: false # disable performance testing<br>
=C2=A0func: true # enable functional testing<br>
=C2=A0use_virtual_functions: false # use virtual functions (VFs) instead of=
 physical functions<br>
diff --git a/dts/tests_config.example.yaml b/dts/configurations/tests_confi=
g.example.yaml<br>
similarity index 100%<br>
rename from dts/tests_config.example.yaml<br>
rename to dts/configurations/tests_config.example.yaml<br>
diff --git a/dts/framework/config/test_run.py b/dts/framework/config/test_r=
un.py<br>
index 71b3755d6e..68db862cea 100644<br>
--- a/dts/framework/config/test_run.py<br>
+++ b/dts/framework/config/test_run.py<br>
@@ -16,7 +16,7 @@<br>
=C2=A0from enum import Enum, auto, unique<br>
=C2=A0from functools import cached_property<br>
=C2=A0from pathlib import Path, PurePath<br>
-from typing import Annotated, Any, Literal, NamedTuple<br>
+from typing import Annotated, Any, Literal, NamedTuple, Optional<br>
<br>
=C2=A0from pydantic import (<br>
=C2=A0 =C2=A0 =C2=A0BaseModel,<br>
@@ -396,6 +396,8 @@ class TrafficGeneratorType(str, Enum):<br>
<br>
=C2=A0 =C2=A0 =C2=A0#:<br>
=C2=A0 =C2=A0 =C2=A0SCAPY =3D &quot;SCAPY&quot;<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 TREX =3D &quot;TREX&quot;<br>
<br>
<br>
=C2=A0class TrafficGeneratorConfig(FrozenModel):<br>
@@ -412,8 +414,18 @@ class ScapyTrafficGeneratorConfig(TrafficGeneratorConf=
ig):<br>
=C2=A0 =C2=A0 =C2=A0type: Literal[TrafficGeneratorType.SCAPY]<br>
<br>
<br>
+class TrexTrafficGeneratorConfig(TrafficGeneratorConfig):<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;TREX traffic generator specific configurat=
ion.&quot;&quot;&quot;<br>
+<br>
+=C2=A0 =C2=A0 type: Literal[TrafficGeneratorType.TREX]<br>
+=C2=A0 =C2=A0 remote_path: PurePath<br>
+=C2=A0 =C2=A0 config: PurePath<br>
+<br>
+<br>
=C2=A0#: A union type discriminating traffic generators by the `type` field=
.<br>
-TrafficGeneratorConfigTypes =3D Annotated[ScapyTrafficGeneratorConfig, Fie=
ld(discriminator=3D&quot;type&quot;)]<br>
+TrafficGeneratorConfigTypes =3D Annotated[<br>
+=C2=A0 =C2=A0 TrexTrafficGeneratorConfig, ScapyTrafficGeneratorConfig, Fie=
ld(discriminator=3D&quot;type&quot;)<br>
+]<br>
<br>
=C2=A0#: Comma-separated list of logical cores to use. An empty string or `=
``any``` means use all lcores.<br>
=C2=A0LogicalCores =3D Annotated[<br>
@@ -461,8 +473,10 @@ class TestRunConfiguration(FrozenModel):<br>
<br>
=C2=A0 =C2=A0 =C2=A0#: The DPDK configuration used to test.<br>
=C2=A0 =C2=A0 =C2=A0dpdk: DPDKConfiguration<br>
-=C2=A0 =C2=A0 #: The traffic generator configuration used to test.<br>
-=C2=A0 =C2=A0 traffic_generator: TrafficGeneratorConfigTypes<br>
+=C2=A0 =C2=A0 #: The traffic generator configuration used for functional t=
ests.<br>
+=C2=A0 =C2=A0 func_traffic_generator: Optional[ScapyTrafficGeneratorConfig=
] =3D None<br>
+=C2=A0 =C2=A0 #: The traffic generator configuration used for performance =
tests.<br>
+=C2=A0 =C2=A0 perf_traffic_generator: Optional[TrexTrafficGeneratorConfig]=
 =3D None<br>
=C2=A0 =C2=A0 =C2=A0#: Whether to run performance tests.<br>
=C2=A0 =C2=A0 =C2=A0perf: bool<br>
=C2=A0 =C2=A0 =C2=A0#: Whether to run functional tests.<br>
diff --git a/dts/framework/context.py b/dts/framework/context.py<br>
index ae319d949f..8f1021dc96 100644<br>
--- a/dts/framework/context.py<br>
+++ b/dts/framework/context.py<br>
@@ -6,7 +6,7 @@<br>
=C2=A0import functools<br>
=C2=A0from collections.abc import Callable<br>
=C2=A0from dataclasses import MISSING, dataclass, field, fields<br>
-from typing import TYPE_CHECKING, Any, ParamSpec, Union<br>
+from typing import TYPE_CHECKING, Any, Optional, ParamSpec, Union<br>
<br>
=C2=A0from framework.exception import InternalError<br>
=C2=A0from framework.remote_session.shell_pool import ShellPool<br>
@@ -76,7 +76,8 @@ class Context:<br>
=C2=A0 =C2=A0 =C2=A0topology: Topology<br>
=C2=A0 =C2=A0 =C2=A0dpdk_build: &quot;DPDKBuildEnvironment&quot;<br>
=C2=A0 =C2=A0 =C2=A0dpdk: &quot;DPDKRuntimeEnvironment&quot;<br>
-=C2=A0 =C2=A0 tg: &quot;TrafficGenerator&quot;<br>
+=C2=A0 =C2=A0 func_tg: Optional[&quot;TrafficGenerator&quot;]<br>
+=C2=A0 =C2=A0 perf_tg: Optional[&quot;TrafficGenerator&quot;]<br>
=C2=A0 =C2=A0 =C2=A0local: LocalContext =3D field(default_factory=3DLocalCo=
ntext)<br>
=C2=A0 =C2=A0 =C2=A0shell_pool: ShellPool =3D field(default_factory=3DShell=
Pool)<br>
<br>
diff --git a/dts/framework/remote_session/blocking_app.py b/dts/framework/r=
emote_session/blocking_app.py<br>
index 8de536c259..c3b02dcc62 100644<br>
--- a/dts/framework/remote_session/blocking_app.py<br>
+++ b/dts/framework/remote_session/blocking_app.py<br>
@@ -48,20 +48,23 @@ class BlockingApp(InteractiveShell, Generic[P]):<br>
=C2=A0 =C2=A0 =C2=A0def __init__(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0node: Node,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 path: PurePath,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 path: str | PurePath,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0name: str | None =3D None,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0privileged: bool =3D False,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0app_params: P | str =3D &quot;&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 add_to_shell_pool: bool =3D True,<br>
=C2=A0 =C2=A0 =C2=A0) -&gt; None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Constructor.<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Args:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0node: The node to run the a=
pp on.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 path: Path to the application on=
 the node.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 path: Path to the application on=
 the node.s<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0name: Name to identify this=
 application.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0privileged: Run as privileg=
ed user.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0app_params: The application=
 parameters. Can be of any type inheriting :class:`Params` or<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0a plain strin=
g.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 add_to_shell_pool: If :data:`Tru=
e`, the blocking app&#39;s shell will be added to the<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 shell pool.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if isinstance(app_params, str):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0params =3D Params()<br>
@@ -69,11 +72,12 @@ def __init__(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0app_params =3D cast(P, para=
ms)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self._path =3D path<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._add_to_shell_pool =3D add_to_shell_pool<=
br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0super().__init__(node, name, privileged, =
app_params)<br>
<br>
=C2=A0 =C2=A0 =C2=A0@property<br>
-=C2=A0 =C2=A0 def path(self) -&gt; PurePath:<br>
+=C2=A0 =C2=A0 def path(self) -&gt; str | PurePath:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;The path of the DPDK ap=
p relative to the DPDK build folder.&quot;&quot;&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return self._path<br>
<br>
@@ -86,7 +90,7 @@ def wait_until_ready(self, end_token: str) -&gt; Self:<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Returns:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Itself.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.start_application(end_token)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.start_application(end_token, self._add_to=
_shell_pool)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return self<br>
<br>
=C2=A0 =C2=A0 =C2=A0def close(self) -&gt; None:<br>
diff --git a/dts/framework/remote_session/interactive_shell.py b/dts/framew=
ork/remote_session/interactive_shell.py<br>
index ce93247051..a65cbce209 100644<br>
--- a/dts/framework/remote_session/interactive_shell.py<br>
+++ b/dts/framework/remote_session/interactive_shell.py<br>
@@ -140,7 +140,7 @@ def _make_start_command(self) -&gt; str:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0start_command =3D self._nod=
e.main_session._get_privileged_command(start_command)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return start_command<br>
<br>
-=C2=A0 =C2=A0 def start_application(self, prompt: str | None =3D None) -&g=
t; None:<br>
+=C2=A0 =C2=A0 def start_application(self, prompt: str | None =3D None, add=
_to_shell_pool: bool =3D True) -&gt; None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Starts a new interactiv=
e application based on the path to the app.<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0This method is often overridden by subcla=
sses as their process for starting may look<br>
@@ -151,6 +151,7 @@ def start_application(self, prompt: str | None =3D None=
) -&gt; None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Args:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0prompt: When starting up th=
e application, expect this string at the end of stdout when<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0the applicati=
on is ready. If :data:`None`, the class&#39; default prompt will be used.<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 add_to_shell_pool: If :data:`Tru=
e`, the shell will be registered to the shell pool.<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Raises:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0InteractiveCommandExecution=
Error: If the application fails to start within the allotted<br>
@@ -174,7 +175,8 @@ def start_application(self, prompt: str | None =3D None=
) -&gt; None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.is_alive =3D False=C2=
=A0 # update state on failure to start<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise InteractiveCommandExe=
cutionError(&quot;Failed to start application.&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self._ssh_channel.settimeout(self._timeou=
t)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 get_ctx().shell_pool.register_shell(self)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if add_to_shell_pool:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 get_ctx().shell_pool.register_sh=
ell(self)<br>
<br>
=C2=A0 =C2=A0 =C2=A0def send_command(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self, command: str, prompt: str | None =
=3D None, skip_first_line: bool =3D False<br>
@@ -259,7 +261,7 @@ def close(self) -&gt; None:<br>
<br>
=C2=A0 =C2=A0 =C2=A0@property<br>
=C2=A0 =C2=A0 =C2=A0@abstractmethod<br>
-=C2=A0 =C2=A0 def path(self) -&gt; PurePath:<br>
+=C2=A0 =C2=A0 def path(self) -&gt; str | PurePath:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Path to the shell execu=
table.&quot;&quot;&quot;<br>
<br>
=C2=A0 =C2=A0 =C2=A0def _make_real_path(self) -&gt; PurePath:<br>
diff --git a/dts/framework/settings.py b/dts/framework/settings.py<br>
index 84b627a06a..b08373b7ea 100644<br>
--- a/dts/framework/settings.py<br>
+++ b/dts/framework/settings.py<br>
@@ -130,11 +130,17 @@ class Settings:<br>
=C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>
<br>
=C2=A0 =C2=A0 =C2=A0#:<br>
-=C2=A0 =C2=A0 test_run_config_path: Path =3D Path(__file__).parent.parent.=
joinpath(&quot;test_run.yaml&quot;)<br>
+=C2=A0 =C2=A0 test_run_config_path: Path =3D Path(__file__).parent.parent.=
joinpath(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;configurations/test_run.yaml&quot;<br>
+=C2=A0 =C2=A0 )<br>
=C2=A0 =C2=A0 =C2=A0#:<br>
-=C2=A0 =C2=A0 nodes_config_path: Path =3D Path(__file__).parent.parent.joi=
npath(&quot;nodes.yaml&quot;)<br>
+=C2=A0 =C2=A0 nodes_config_path: Path =3D Path(__file__).parent.parent.joi=
npath(&quot;configurations/nodes.yaml&quot;)<br>
=C2=A0 =C2=A0 =C2=A0#:<br>
-=C2=A0 =C2=A0 tests_config_path: Path | None =3D None<br>
+=C2=A0 =C2=A0 tests_config_path: Path | None =3D (<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Path(__file__).parent.parent.joinpath(&quot;co=
nfigurations/tests_config.yaml&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if os.path.exists(&quot;configurations/tests_c=
onfig.yaml&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 else None<br>
+=C2=A0 =C2=A0 )<br>
=C2=A0 =C2=A0 =C2=A0#:<br>
=C2=A0 =C2=A0 =C2=A0output_dir: str =3D &quot;output&quot;<br>
=C2=A0 =C2=A0 =C2=A0#:<br>
diff --git a/dts/framework/test_run.py b/dts/framework/test_run.py<br>
index 9cf04c0b06..ff0a12c9ce 100644<br>
--- a/dts/framework/test_run.py<br>
+++ b/dts/framework/test_run.py<br>
@@ -113,7 +113,7 @@<br>
=C2=A0from framework.remote_session.dpdk import DPDKBuildEnvironment, DPDKR=
untimeEnvironment<br>
=C2=A0from framework.settings import SETTINGS<br>
=C2=A0from framework.test_result import Result, ResultNode, TestRunResult<b=
r>
-from framework.test_suite import BaseConfig, TestCase, TestSuite<br>
+from framework.test_suite import BaseConfig, TestCase, TestCaseType, TestS=
uite<br>
=C2=A0from framework.testbed_model.capability import (<br>
=C2=A0 =C2=A0 =C2=A0Capability,<br>
=C2=A0 =C2=A0 =C2=A0get_supported_capabilities,<br>
@@ -199,10 +199,26 @@ def __init__(<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dpdk_build_env =3D DPDKBuildEnvironment(c=
onfig.dpdk.build, sut_node)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dpdk_runtime_env =3D DPDKRuntimeEnvironme=
nt(config.dpdk, sut_node, dpdk_build_env)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 traffic_generator =3D create_traffic_generator=
(config.traffic_generator, tg_node)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 func_traffic_generator =3D (<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 create_traffic_generator(config.=
func_traffic_generator, tg_node)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if config.func and config.func_t=
raffic_generator<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else None<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 perf_traffic_generator =3D (<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 create_traffic_generator(config.=
perf_traffic_generator, tg_node)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if config.perf and config.perf_t=
raffic_generator<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else None<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.ctx =3D Context(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sut_node, tg_node, topology, dpd=
k_build_env, dpdk_runtime_env, traffic_generator<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sut_node,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tg_node,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 topology,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dpdk_build_env,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dpdk_runtime_env,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 func_traffic_generator,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 perf_traffic_generator,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.result =3D result<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.selected_tests =3D list(self.config.=
filter_tests(tests_config))<br>
@@ -335,7 +351,10 @@ def next(self) -&gt; State | None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0test_run.ctx.topology.insta=
ntiate_vf_ports()<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0test_run.ctx.topology.configure_ports(&qu=
ot;sut&quot;, &quot;dpdk&quot;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 test_run.ctx.tg.setup(test_run.ctx.topology)<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if test_run.ctx.func_tg:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 test_run.ctx.func_tg.setup(test_=
run.ctx.topology)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if test_run.ctx.perf_tg:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 test_run.ctx.perf_tg.setup(test_=
run.ctx.topology)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.result.ports =3D [<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0port.to_dict()<br>
@@ -425,7 +444,10 @@ def next(self) -&gt; State | None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.test_run.ctx.topology.=
delete_vf_ports()<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.test_run.ctx.shell_pool.terminate_cu=
rrent_pool()<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.test_run.ctx.tg.teardown()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if self.test_run.ctx.func_tg and self.test_run=
.ctx.func_tg.is_setup:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.test_run.ctx.func_tg.teardo=
wn()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if self.test_run.ctx.perf_tg and self.test_run=
.ctx.perf_tg.is_setup:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.test_run.ctx.perf_tg.teardo=
wn()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.test_run.ctx.topology.teardown()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.test_run.ctx.dpdk.teardown()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.test_run.ctx.tg_node.teardown()<br>
@@ -611,6 +633,26 @@ def next(self) -&gt; State | None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.test_run.ctx.topology.configure_port=
s(&quot;sut&quot;, sut_ports_drivers)<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.test_run.ctx.perf_tg<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 and self.test_run.ctx.perf_tg.is=
_setup<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 and self.test_case.test_type is =
TestCaseType.FUNCTIONAL<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.test_run.ctx.perf_tg.teardo=
wn()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.test_run.ctx.topology.confi=
gure_ports(&quot;tg&quot;, &quot;kernel&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if self.test_run.ctx.func_tg and=
 not self.test_run.ctx.func_tg.is_setup:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.test_run.ctx.=
func_tg.setup(self.test_run.ctx.topology)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.test_run.ctx.func_tg<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 and self.test_run.ctx.func_tg.is=
_setup<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 and self.test_case.test_type is =
TestCaseType.PERFORMANCE<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.test_run.ctx.func_tg.teardo=
wn()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.test_run.ctx.topology.confi=
gure_ports(&quot;tg&quot;, &quot;dpdk&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if self.test_run.ctx.perf_tg and=
 not self.test_run.ctx.perf_tg.is_setup:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.test_run.ctx.=
perf_tg.setup(self.test_run.ctx.topology)<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.test_suite.set_up_test_case()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.result.mark_step_as(&quot;setup&quot=
;, Result.PASS)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return TestCaseExecution(<br>
diff --git a/dts/framework/testbed_model/traffic_generator/__init__.py b/dt=
s/framework/testbed_model/traffic_generator/__init__.py<br>
index 2a259a6e6c..fca251f534 100644<br>
--- a/dts/framework/testbed_model/traffic_generator/__init__.py<br>
+++ b/dts/framework/testbed_model/traffic_generator/__init__.py<br>
@@ -14,17 +14,22 @@<br>
=C2=A0and a capturing traffic generator is required.<br>
=C2=A0&quot;&quot;&quot;<br>
<br>
-from framework.config.test_run import ScapyTrafficGeneratorConfig, Traffic=
GeneratorConfig<br>
+from framework.config.test_run import (<br>
+=C2=A0 =C2=A0 ScapyTrafficGeneratorConfig,<br>
+=C2=A0 =C2=A0 TrafficGeneratorConfig,<br>
+=C2=A0 =C2=A0 TrexTrafficGeneratorConfig,<br>
+)<br>
=C2=A0from framework.exception import ConfigurationError<br>
=C2=A0from framework.testbed_model.node import Node<br>
<br>
-from .capturing_traffic_generator import CapturingTrafficGenerator<br>
=C2=A0from .scapy import ScapyTrafficGenerator<br>
+from .traffic_generator import TrafficGenerator<br>
+from .trex import TrexTrafficGenerator<br>
<br>
<br>
=C2=A0def create_traffic_generator(<br>
=C2=A0 =C2=A0 =C2=A0traffic_generator_config: TrafficGeneratorConfig, node:=
 Node<br>
-) -&gt; CapturingTrafficGenerator:<br>
+) -&gt; TrafficGenerator:<br>
=C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;The factory function for creating tra=
ffic generator objects from the test run configuration.<br>
<br>
=C2=A0 =C2=A0 =C2=A0Args:<br>
@@ -40,5 +45,7 @@ def create_traffic_generator(<br>
=C2=A0 =C2=A0 =C2=A0match traffic_generator_config:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case ScapyTrafficGeneratorConfig():<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ScapyTrafficGenerato=
r(node, traffic_generator_config, privileged=3DTrue)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 case TrexTrafficGeneratorConfig():<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return TrexTrafficGenerator(node=
, traffic_generator_config)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case _:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise ConfigurationError(f&=
quot;Unknown traffic generator: {traffic_generator_config.type}&quot;)<br>
diff --git a/dts/framework/testbed_model/traffic_generator/scapy.py b/dts/f=
ramework/testbed_model/traffic_generator/scapy.py<br>
index a31807e8e4..9e15a31c00 100644<br>
--- a/dts/framework/testbed_model/traffic_generator/scapy.py<br>
+++ b/dts/framework/testbed_model/traffic_generator/scapy.py<br>
@@ -170,12 +170,17 @@ def stop_capturing_and_collect(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0finally:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.stop_capturing()<br>
<br>
-=C2=A0 =C2=A0 def start_application(self, prompt: str | None =3D None) -&g=
t; None:<br>
+=C2=A0 =C2=A0 def start_application(self, prompt: str | None =3D None, add=
_to_shell_pool: bool =3D True) -&gt; None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Overrides :meth:`framew=
ork.remote_session.interactive_shell.start_application`.<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Prepares the Python shell for scapy and s=
tarts the sniffing in a new thread.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 prompt: When starting up the app=
lication, expect this string at the end of stdout when<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 the application is=
 ready. If :data:`None`, the class&#39; default prompt will be used.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 add_to_shell_pool: If :data:`Tru=
e`, the shell will be registered to the shell pool.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 super().start_application(prompt)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 super().start_application(prompt, add_to_shell=
_pool)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.send_command(&quot;from scapy.all im=
port *&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self._sniffer.start()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self._is_sniffing.wait()<br>
@@ -320,15 +325,16 @@ def setup(self, topology: Topology) -&gt; None:<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Binds the TG node ports to the kernel dri=
vers and starts up the async sniffer.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 super().setup(topology)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0topology.configure_ports(&quot;tg&quot;, =
&quot;kernel&quot;)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self._sniffer =3D ScapyAsyncSniffer(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self._tg_node, topology.tg_=
port_ingress, self._sniffer_name<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._sniffer.start_application()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._sniffer.start_application(add_to_shell_p=
ool=3DFalse)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self._shell =3D PythonShell(self._tg_node=
, &quot;scapy&quot;, privileged=3DTrue)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._shell.start_application()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._shell.start_application(add_to_shell_poo=
l=3DFalse)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self._shell.send_command(&quot;from scapy=
.all import *&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self._shell.send_command(&quot;from scapy=
.contrib.lldp import *&quot;)<br>
<br>
diff --git a/dts/framework/testbed_model/traffic_generator/traffic_generato=
r.py b/dts/framework/testbed_model/traffic_generator/traffic_generator.py<b=
r>
index e5f246df7a..cdda5a7c08 100644<br>
--- a/dts/framework/testbed_model/traffic_generator/traffic_generator.py<br=
>
+++ b/dts/framework/testbed_model/traffic_generator/traffic_generator.py<br=
>
@@ -11,9 +11,12 @@<br>
=C2=A0from abc import ABC, abstractmethod<br>
=C2=A0from typing import Any<br>
<br>
+from scapy.packet import Packet<br>
+<br>
=C2=A0from framework.config.test_run import TrafficGeneratorConfig<br>
=C2=A0from framework.logger import DTSLogger, get_dts_logger<br>
=C2=A0from framework.testbed_model.node import Node<br>
+from framework.testbed_model.port import Port<br>
=C2=A0from framework.testbed_model.topology import Topology<br>
<br>
<br>
@@ -30,6 +33,7 @@ class TrafficGenerator(ABC):<br>
=C2=A0 =C2=A0 =C2=A0_config: TrafficGeneratorConfig<br>
=C2=A0 =C2=A0 =C2=A0_tg_node: Node<br>
=C2=A0 =C2=A0 =C2=A0_logger: DTSLogger<br>
+=C2=A0 =C2=A0 _is_setup: bool<br>
<br>
=C2=A0 =C2=A0 =C2=A0def __init__(self, tg_node: Node, config: TrafficGenera=
torConfig, **kwargs: Any) -&gt; None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Initialize the traffic =
generator.<br>
@@ -45,12 +49,25 @@ def __init__(self, tg_node: Node, config: TrafficGenera=
torConfig, **kwargs: Any)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self._config =3D config<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self._tg_node =3D tg_node<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self._logger =3D get_dts_logger(f&quot;{s=
elf._<a href=3D"http://tg_node.name" rel=3D"noreferrer" target=3D"_blank">t=
g_node.name</a>} {self._config.type}&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._is_setup =3D False<br>
+<br>
+=C2=A0 =C2=A0 def send_packets(self, packets: list[Packet], port: Port) -&=
gt; None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Send `packets` and block unt=
il they are fully sent.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Send `packets` on `port`, then wait until `pac=
kets` are fully sent.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 packets: The packets to send.<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 port: The egress port on the TG =
node.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
<br>
=C2=A0 =C2=A0 =C2=A0def setup(self, topology: Topology) -&gt; None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Setup the traffic gener=
ator.&quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._is_setup =3D True<br>
<br>
=C2=A0 =C2=A0 =C2=A0def teardown(self) -&gt; None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Teardown the traffic ge=
nerator.&quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._is_setup =3D False<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.close()<br>
<br>
=C2=A0 =C2=A0 =C2=A0@property<br>
@@ -61,3 +78,8 @@ def is_capturing(self) -&gt; bool:<br>
=C2=A0 =C2=A0 =C2=A0@abstractmethod<br>
=C2=A0 =C2=A0 =C2=A0def close(self) -&gt; None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Free all resources used=
 by the traffic generator.&quot;&quot;&quot;<br>
+<br>
+=C2=A0 =C2=A0 @property<br>
+=C2=A0 =C2=A0 def is_setup(self) -&gt; bool:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Indicates whether the traffi=
c generator application is currently running.&quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return self._is_setup<br>
diff --git a/dts/framework/testbed_model/traffic_generator/trex.py b/dts/fr=
amework/testbed_model/traffic_generator/trex.py<br>
new file mode 100644<br>
index 0000000000..6ae6d1f181<br>
--- /dev/null<br>
+++ b/dts/framework/testbed_model/traffic_generator/trex.py<br>
@@ -0,0 +1,259 @@<br>
+# SPDX-License-Identifier: BSD-3-Clause<br>
+# Copyright(c) 2025 University of New Hampshire<br>
+<br>
+&quot;&quot;&quot;Implementation for TREX performance traffic generator.&q=
uot;&quot;&quot;<br>
+<br>
+import ast<br>
+import time<br>
+from dataclasses import dataclass, field<br>
+from enum import auto<br>
+from typing import ClassVar<br>
+<br>
+from scapy.packet import Packet<br>
+<br>
+from framework.config.node import OS, NodeConfiguration<br>
+from framework.config.test_run import TrexTrafficGeneratorConfig<br>
+from framework.parser import TextParser<br>
+from framework.remote_session.blocking_app import BlockingApp<br>
+from framework.remote_session.python_shell import PythonShell<br>
+from framework.testbed_model.node import Node, create_session<br>
+from framework.testbed_model.os_session import OSSession<br>
+from framework.testbed_model.topology import Topology<br>
+from framework.testbed_model.traffic_generator.performance_traffic_generat=
or import (<br>
+=C2=A0 =C2=A0 PerformanceTrafficGenerator,<br>
+=C2=A0 =C2=A0 PerformanceTrafficStats,<br>
+)<br>
+from framework.utils import StrEnum<br>
+<br>
+<br>
+@dataclass(slots=3DTrue)<br>
+class TrexPerformanceTrafficStats(PerformanceTrafficStats, TextParser):<br=
>
+=C2=A0 =C2=A0 &quot;&quot;&quot;Data structure to store performance statis=
tics for a given test run.<br>
+<br>
+=C2=A0 =C2=A0 This class overrides the initialization of :class:`Performan=
ceTrafficStats`<br>
+=C2=A0 =C2=A0 in order to set the attribute values using the TREX stats ou=
tput.<br>
+<br>
+=C2=A0 =C2=A0 Attributes:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 tx_pps: Recorded tx packets per second.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 tx_bps: Recorded tx bytes per second.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 rx_pps: Recorded rx packets per second.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 rx_bps: Recorded rx bytes per second.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 frame_size: The total length of the frame.<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+<br>
+=C2=A0 =C2=A0 tx_pps: int =3D field(metadata=3DTextParser.find_int(r&quot;=
total.*&#39;tx_pps&#39;: (\d+)&quot;))<br>
+=C2=A0 =C2=A0 tx_bps: int =3D field(metadata=3DTextParser.find_int(r&quot;=
total.*&#39;tx_bps&#39;: (\d+)&quot;))<br>
+=C2=A0 =C2=A0 rx_pps: int =3D field(metadata=3DTextParser.find_int(r&quot;=
total.*&#39;rx_pps&#39;: (\d+)&quot;))<br>
+=C2=A0 =C2=A0 rx_bps: int =3D field(metadata=3DTextParser.find_int(r&quot;=
total.*&#39;rx_bps&#39;: (\d+)&quot;))<br>
+<br>
+<br>
+class TrexStatelessTXModes(StrEnum):<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;Flags indicating TREX instance&#39;s curre=
nt transmission mode.&quot;&quot;&quot;<br>
+<br>
+=C2=A0 =C2=A0 #: Transmit continuously<br>
+=C2=A0 =C2=A0 STLTXCont =3D auto()<br>
+=C2=A0 =C2=A0 #: Transmit in a single burst<br>
+=C2=A0 =C2=A0 STLTXSingleBurst =3D auto()<br>
+=C2=A0 =C2=A0 #: Transmit in multiple bursts<br>
+=C2=A0 =C2=A0 STLTXMultiBurst =3D auto()<br>
+<br>
+<br>
+class TrexTrafficGenerator(PerformanceTrafficGenerator):<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;TREX traffic generator.<br>
+<br>
+=C2=A0 =C2=A0 This implementation leverages the stateless API library prov=
ided in the TREX installation.<br>
+<br>
+=C2=A0 =C2=A0 Attributes:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 stl_client_name: The name of the stateless cli=
ent used in the stateless API.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 packet_stream_name: The name of the stateless =
packet stream used in the stateless API.<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+<br>
+=C2=A0 =C2=A0 _os_session: OSSession<br>
+<br>
+=C2=A0 =C2=A0 _tg_config: TrexTrafficGeneratorConfig<br>
+=C2=A0 =C2=A0 _node_config: NodeConfiguration<br>
+<br>
+=C2=A0 =C2=A0 _shell: PythonShell<br>
+=C2=A0 =C2=A0 _python_indentation: ClassVar[str] =3D &quot; &quot; * 4<br>
+<br>
+=C2=A0 =C2=A0 stl_client_name: ClassVar[str] =3D &quot;client&quot;<br>
+=C2=A0 =C2=A0 packet_stream_name: ClassVar[str] =3D &quot;stream&quot;<br>
+<br>
+=C2=A0 =C2=A0 _streaming_mode: TrexStatelessTXModes =3D TrexStatelessTXMod=
es.STLTXCont<br>
+<br>
+=C2=A0 =C2=A0 _tg_cores: int =3D 10<br>
+<br>
+=C2=A0 =C2=A0 _trex_app: BlockingApp<br>
+<br>
+=C2=A0 =C2=A0 def __init__(self, tg_node: Node, config: TrexTrafficGenerat=
orConfig) -&gt; None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Initialize the TREX server.<=
br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Initializes needed OS sessions for the creatio=
n of the TREX server process.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tg_node: TG node the TREX instan=
ce is operating on.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 config: Traffic generator config=
 provided for TREX instance.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 assert (<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tg_node.config.os =3D=3D OS.linu=
x<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ), &quot;Linux is the only supported OS for tr=
ex traffic generation&quot;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 super().__init__(tg_node=3Dtg_node, config=3Dc=
onfig)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._tg_node_config =3D tg_node.config<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._tg_config =3D config<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._os_session =3D create_session(self._tg_n=
ode.config, &quot;TREX&quot;, self._logger)<br>
+<br>
+=C2=A0 =C2=A0 def setup(self, topology: Topology):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Initialize and start a TREX =
server process.&quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 super().setup(topology)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._shell =3D PythonShell(self._tg_node, &qu=
ot;TREX-client&quot;, privileged=3DTrue)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Start TREX server process.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 trex_app_path =3D f&quot;cd {self._tg_config.r=
emote_path} &amp;&amp; ./t-rex-64&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._trex_app =3D BlockingApp(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 node=3Dself._tg_node,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 path=3Dtrex_app_path,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 name=3D&quot;trex-tg&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 privileged=3DTrue,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 app_params=3Df&quot;--cfg {self.=
_tg_config.config} -c {self._tg_cores} -i&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 add_to_shell_pool=3DFalse,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._trex_app.wait_until_ready(&quot;-Per por=
t stats table&quot;)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._shell.start_application()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._shell.send_command(&quot;import os&quot;=
)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._shell.send_command(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&quot;os.chdir(&#39;{self._tg_c=
onfig.remote_path}/automation/trex_control_plane/interactive&#39;)&quot;<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Import stateless API components.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 imports =3D [<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;import trex&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;import trex.stl&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;import trex.stl.trex_stl_c=
lient&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;import trex.stl.trex_stl_s=
treams&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;import trex.stl.trex_stl_p=
acket_builder_scapy&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;from scapy.layers.l2 impor=
t Ether&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;from scapy.layers.inet imp=
ort IP&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;from scapy.packet import R=
aw&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._shell.send_command(&quot;\n&quot;.join(i=
mports))<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 stateless_client =3D [<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&quot;{self.stl_client_name} =
=3D trex.stl.trex_stl_client.STLClient(&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&quot;username=3D&#39;{self._tg=
_node_config.user}&#39;,&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;server=3D&#39;127.0.0.1&#3=
9;,&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;)&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ]<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._shell.send_command(f&quot;\n{self._pytho=
n_indentation}&quot;.join(stateless_client))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._shell.send_command(f&quot;{self.stl_clie=
nt_name}.connect()&quot;)<br>
+<br>
+=C2=A0 =C2=A0 def calculate_traffic_and_stats(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 packet: Packet,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 duration: float,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 send_mpps: int | None =3D None,<br>
+=C2=A0 =C2=A0 ) -&gt; PerformanceTrafficStats:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Send packet traffic and acqu=
ire associated statistics.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Overrides<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 :meth:`~.traffic_generator.PerformanceTrafficG=
enerator.calculate_traffic_and_stats`.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 trex_stats_output =3D ast.literal_eval(self._g=
enerate_traffic(packet, duration, send_mpps))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 stats =3D TrexPerformanceTrafficStats.parse(st=
r(trex_stats_output))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 stats.frame_size =3D len(packet)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return stats<br>
+<br>
+=C2=A0 =C2=A0 def _generate_traffic(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self, packet: Packet, duration: float, send_mp=
ps: int | None =3D None<br>
+=C2=A0 =C2=A0 ) -&gt; str:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Generate traffic using provi=
ded packet.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Uses the provided packet to generate traffic f=
or the provided duration.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 packet: The packet being used fo=
r the performance test.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 duration: The duration of the te=
st being performed.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 send_mpps: MPPS send rate.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Returns:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 A string output of statistics pr=
ovided by the traffic generator.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._create_packet_stream(packet)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._setup_trex_client()<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 stats =3D self._send_traffic_and_get_stats(dur=
ation, send_mpps)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return stats<br>
+<br>
+=C2=A0 =C2=A0 def _setup_trex_client(self) -&gt; None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Create trex client and conne=
ct to the server process.&quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Prepare TREX client for next performance tes=
t.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 procedure =3D [<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&quot;{self.stl_client_name}.co=
nnect()&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&quot;{self.stl_client_name}.re=
set(ports =3D [0, 1])&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&quot;{self.stl_client_name}.cl=
ear_stats()&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&quot;{self.stl_client_name}.ad=
d_streams({self.packet_stream_name}, ports=3D[0, 1])&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ]<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 for command in procedure:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._shell.send_command(command=
)<br>
+<br>
+=C2=A0 =C2=A0 def _create_packet_stream(self, packet: Packet) -&gt; None:<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Create TREX packet stream wi=
th the given packet.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 packet: The packet being used fo=
r the performance test.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Create the tx packet on the TG shell<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._shell.send_command(f&quot;packet=3D{pack=
et.command()}&quot;)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 packet_stream =3D [<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&quot;{self.packet_stream_name}=
 =3D trex.stl.trex_stl_streams.STLStream(&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&quot;name=3D&#39;Test_{len(pac=
ket)}_bytes&#39;,&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;packet=3Dtrex.stl.trex_stl=
_packet_builder_scapy.STLPktBuilder(pkt=3Dpacket),&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&quot;mode=3Dtrex.stl.trex_stl_=
streams.{self._streaming_mode}(percentage=3D100),&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;)&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._shell.send_command(&quot;\n&quot;.join(p=
acket_stream))<br>
+<br>
+=C2=A0 =C2=A0 def _send_traffic_and_get_stats(self, duration: float, send_=
mpps: float | None =3D None) -&gt; str:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Send traffic and get TG Rx s=
tats.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Sends traffic from the TREX client&#39;s ports=
 for the given duration.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 When the traffic sending duration has passed, =
collect the aggregate<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 statistics and return TREX&#39;s global stats =
as a string.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 duration: The traffic generation=
 duration.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 send_mpps: The millions of packe=
ts per second for TREX to send from each port.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if send_mpps:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._shell.send_command(f&quot;=
&quot;&quot;{self.stl_client_name}.start(ports=3D[0, 1],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mult =3D &#39;{sen=
d_mpps}mpps&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 duration =3D {dura=
tion})&quot;&quot;&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._shell.send_command(f&quot;=
&quot;&quot;{self.stl_client_name}.start(ports=3D[0, 1],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mult =3D &#39;100%=
&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 duration =3D {dura=
tion})&quot;&quot;&quot;)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 time.sleep(duration)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 stats =3D self._shell.send_command(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&quot;{self.stl_client_name}.ge=
t_stats(ports=3D[0, 1])&quot;, skip_first_line=3DTrue<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._shell.send_command(f&quot;{self.stl_clie=
nt_name}.stop(ports=3D[0, 1])&quot;)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return stats<br>
+<br>
+=C2=A0 =C2=A0 def close(self) -&gt; None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Overrides :meth:`.traffic_ge=
nerator.TrafficGenerator.close`.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Stops the traffic generator and sniffer shells=
.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._trex_app.close()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._shell.close()<br>
-- <br>
2.49.0<br>
<br>
</blockquote></div>

--000000000000d9633f0642ed1dcc--
