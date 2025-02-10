Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D2BCC02198
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Feb 2025 19:09:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 49226402A1;
	Mon, 10 Feb 2025 20:09:56 +0100 (CET)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com
 [209.85.208.174])
 by mails.dpdk.org (Postfix) with ESMTP id 3734A4021E
 for <dev@dpdk.org>; Mon, 10 Feb 2025 20:09:55 +0100 (CET)
Received: by mail-lj1-f174.google.com with SMTP id
 38308e7fff4ca-308f3dbd305so897901fa.2
 for <dev@dpdk.org>; Mon, 10 Feb 2025 11:09:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1739214594; x=1739819394; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iWdq3432XJZh96+3dedrXUZQ09QHlnJCsr2EacdQlus=;
 b=XmxxaEFDBFmuL+RydQ5EjLxirLFiKhD11+PbixhTtPEeyVMsOWu7Jyh9Zi1MyAdWYA
 KVJ8kIV5GTK8NLTz7SMgeFxHaMXEo21GPvYnxqQk4mzv28+dwHmK8ptN98kRbfK5DDRm
 jC8+gRPobzcm/cWVnNQNfk90qa3U55TbJqdq8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739214594; x=1739819394;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iWdq3432XJZh96+3dedrXUZQ09QHlnJCsr2EacdQlus=;
 b=KPbWTPauM9ksoTaGbegg5KFMLwFxE2BRnX0Gsz7FRy7bCvmZcTT4Y/ziH0+dEX2gGw
 zDDh6/OX2JvO08wU4jK55Vtpvp39iGHOuttWhHjnAu1f1EpvcPHyG8OA0IS3PDuluQQl
 sQ3PhcUOOOjaUJqqK7pXIHDRAqnwmejqV6aOB49Eyx6w2gyksrwIDj15QuzGX6SeF7Pz
 sRbUPSVaRCH8KrLSTPuZrv3z0U9gmZ+50hZ7gb76QKv5BGHvgFnoRm7SZCceF7l0+nvN
 u82WHJzW/TW1DATyrAm+aALOnrth6ld6Q412gobF0U+EgKp6UJ5yIntUBosMo6P8DU37
 zxfA==
X-Gm-Message-State: AOJu0YzNfKUW9mInBumIsjzLWeJR6RPb43HYfsVnYk8A0J3AzX+Po0kc
 Leg52KNeQZyeCYlIizsDIKkbuSfJsiEsGTc/nD0M+ZP9cKyTp/3q7sdCFh2FMv9TwuKNo0LZtNN
 1/2sqnrYDPyXI9cLNEcdQCQVNAnQWbbv+4gjtYg==
X-Gm-Gg: ASbGncvvWZfD+HBIlk0fGkmUfcxT28ZKSwrpH4L+RnyzEz6gRDaDALzhQA/Asy4dtH1
 /gLVc+GKaL6sRrbRUbUjCjOSCswgK557dWFLwjb7OYHaucSSCCN9BZAW4bPoith1svs+J3eJ0Rl
 k/9MeFjcXcBJxflATr3Eln5L5sTBact9g=
X-Google-Smtp-Source: AGHT+IH8q/XKEQVh3d3J7hmNGs/jaEenSYGCY22iqYiNcNFX/GgtJ2LyYYY9xUxA2DKIrjqwcCtIFcjHEx0/VMTPnxo=
X-Received: by 2002:a2e:be10:0:b0:308:eb58:658d with SMTP id
 38308e7fff4ca-308eb5868e7mr8568451fa.11.1739214594388; Mon, 10 Feb 2025
 11:09:54 -0800 (PST)
MIME-Version: 1.0
References: <20250203151613.2436570-1-luca.vizzarro@arm.com>
 <20250203151613.2436570-3-luca.vizzarro@arm.com>
In-Reply-To: <20250203151613.2436570-3-luca.vizzarro@arm.com>
From: Nicholas Pratte <npratte@iol.unh.edu>
Date: Mon, 10 Feb 2025 14:09:42 -0500
X-Gm-Features: AWEUYZnlBm0gowvSkdJ2B18ka-rvYAP-_ZKPszspIdBpBEDMQPeL_0KZwYUSZPw
Message-ID: <CAKXZ7eihDxJmAydrbT36bEV9uAfQfeEvS4-o1US-5p8PHrfoUg@mail.gmail.com>
Subject: Re: [RFC PATCH 2/7] dts: isolate test specification to config
To: Luca Vizzarro <luca.vizzarro@arm.com>
Cc: dev@dpdk.org, Patrick Robb <probb@iol.unh.edu>, 
 Paul Szczepanek <paul.szczepanek@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

This makes sense to me!

Reviewed-by: Nicholas Pratte <npratte@iol.unh.edu>

On Mon, Feb 3, 2025 at 10:17=E2=80=AFAM Luca Vizzarro <luca.vizzarro@arm.co=
m> wrote:
>
> In an effort to improve separation of concerns, make the TestRunConfig
> class responsible for processing the configured test suites. Moreover,
> give TestSuiteConfig a facility to yield references to the selected test
> cases.
>
> Signed-off-by: Luca Vizzarro <luca.vizzarro@arm.com>
> ---
>  dts/framework/config/__init__.py | 84 +++++++++++---------------------
>  dts/framework/config/test_run.py | 59 +++++++++++++++++-----
>  2 files changed, 76 insertions(+), 67 deletions(-)
>
> diff --git a/dts/framework/config/__init__.py b/dts/framework/config/__in=
it__.py
> index f8ac2c0d18..7761a8b56f 100644
> --- a/dts/framework/config/__init__.py
> +++ b/dts/framework/config/__init__.py
> @@ -27,9 +27,8 @@
>        and makes it thread safe should we ever want to move in that direc=
tion.
>  """
>
> -from functools import cached_property
>  from pathlib import Path
> -from typing import Annotated, Any, Literal, NamedTuple, TypeVar, cast
> +from typing import Annotated, Any, Literal, TypeVar, cast
>
>  import yaml
>  from pydantic import Field, TypeAdapter, ValidationError, field_validato=
r, model_validator
> @@ -46,18 +45,6 @@
>  )
>  from .test_run import TestRunConfiguration
>
> -
> -class TestRunWithNodesConfiguration(NamedTuple):
> -    """Tuple containing the configuration of the test run and its associ=
ated nodes."""
> -
> -    #:
> -    test_run_config: TestRunConfiguration
> -    #:
> -    sut_node_config: SutNodeConfiguration
> -    #:
> -    tg_node_config: TGNodeConfiguration
> -
> -
>  TestRunsConfig =3D Annotated[list[TestRunConfiguration], Field(min_lengt=
h=3D1)]
>
>  NodesConfig =3D Annotated[list[NodeConfigurationTypes], Field(min_length=
=3D1)]
> @@ -71,40 +58,6 @@ class Configuration(FrozenModel):
>      #: Node configurations.
>      nodes: NodesConfig
>
> -    @cached_property
> -    def test_runs_with_nodes(self) -> list[TestRunWithNodesConfiguration=
]:
> -        """List of test runs with the associated nodes."""
> -        test_runs_with_nodes =3D []
> -
> -        for test_run_no, test_run in enumerate(self.test_runs):
> -            sut_node_name =3D test_run.system_under_test_node
> -            sut_node =3D next(filter(lambda n: n.name =3D=3D sut_node_na=
me, self.nodes), None)
> -
> -            assert sut_node is not None, (
> -                f"test_runs.{test_run_no}.sut_node_config.node_name "
> -                f"({test_run.system_under_test_node}) is not a valid nod=
e name"
> -            )
> -            assert isinstance(sut_node, SutNodeConfiguration), (
> -                f"test_runs.{test_run_no}.sut_node_config.node_name is a=
 valid node name, "
> -                "but it is not a valid SUT node"
> -            )
> -
> -            tg_node_name =3D test_run.traffic_generator_node
> -            tg_node =3D next(filter(lambda n: n.name =3D=3D tg_node_name=
, self.nodes), None)
> -
> -            assert tg_node is not None, (
> -                f"test_runs.{test_run_no}.tg_node_name "
> -                f"({test_run.traffic_generator_node}) is not a valid nod=
e name"
> -            )
> -            assert isinstance(tg_node, TGNodeConfiguration), (
> -                f"test_runs.{test_run_no}.tg_node_name is a valid node n=
ame, "
> -                "but it is not a valid TG node"
> -            )
> -
> -            test_runs_with_nodes.append(TestRunWithNodesConfiguration(te=
st_run, sut_node, tg_node))
> -
> -        return test_runs_with_nodes
> -
>      @field_validator("nodes")
>      @classmethod
>      def validate_node_names(cls, nodes: list[NodeConfiguration]) -> list=
[NodeConfiguration]:
> @@ -164,14 +117,33 @@ def validate_port_links(self) -> Self:
>          return self
>
>      @model_validator(mode=3D"after")
> -    def validate_test_runs_with_nodes(self) -> Self:
> -        """Validate the test runs to nodes associations.
> -
> -        This validator relies on the cached property `test_runs_with_nod=
es` to run for the first
> -        time in this call, therefore triggering the assertions if needed=
.
> -        """
> -        if self.test_runs_with_nodes:
> -            pass
> +    def validate_test_runs_against_nodes(self) -> Self:
> +        """Validate the test runs to nodes associations."""
> +        for test_run_no, test_run in enumerate(self.test_runs):
> +            sut_node_name =3D test_run.system_under_test_node
> +            sut_node =3D next((n for n in self.nodes if n.name =3D=3D su=
t_node_name), None)
> +
> +            assert sut_node is not None, (
> +                f"Test run {test_run_no}.system_under_test_node "
> +                f"({sut_node_name}) is not a valid node name."
> +            )
> +            assert isinstance(sut_node, SutNodeConfiguration), (
> +                f"Test run {test_run_no}.system_under_test_node is a val=
id node name, "
> +                "but it is not a valid SUT node."
> +            )
> +
> +            tg_node_name =3D test_run.traffic_generator_node
> +            tg_node =3D next((n for n in self.nodes if n.name =3D=3D tg_=
node_name), None)
> +
> +            assert tg_node is not None, (
> +                f"Test run {test_run_no}.traffic_generator_name "
> +                f"({tg_node_name}) is not a valid node name."
> +            )
> +            assert isinstance(tg_node, TGNodeConfiguration), (
> +                f"Test run {test_run_no}.traffic_generator_name is a val=
id node name, "
> +                "but it is not a valid TG node."
> +            )
> +
>          return self
>
>
> diff --git a/dts/framework/config/test_run.py b/dts/framework/config/test=
_run.py
> index 2092da725e..9ea898b15c 100644
> --- a/dts/framework/config/test_run.py
> +++ b/dts/framework/config/test_run.py
> @@ -11,6 +11,8 @@
>
>  import re
>  import tarfile
> +from collections import deque
> +from collections.abc import Iterable
>  from enum import auto, unique
>  from functools import cached_property
>  from pathlib import Path, PurePath
> @@ -25,7 +27,7 @@
>  from .common import FrozenModel, load_fields_from_settings
>
>  if TYPE_CHECKING:
> -    from framework.test_suite import TestSuiteSpec
> +    from framework.test_suite import TestCase, TestSuite, TestSuiteSpec
>
>
>  @unique
> @@ -233,6 +235,21 @@ def test_suite_spec(self) -> "TestSuiteSpec":
>          ), f"{self.test_suite_name} is not a valid test suite module nam=
e."
>          return test_suite_spec
>
> +    @cached_property
> +    def test_cases(self) -> list[type["TestCase"]]:
> +        """The objects of the selected test cases."""
> +        available_test_cases =3D {t.name: t for t in self.test_suite_spe=
c.class_obj.get_test_cases()}
> +        selected_test_cases =3D []
> +
> +        for requested_test_case in self.test_cases_names:
> +            assert requested_test_case in available_test_cases, (
> +                f"{requested_test_case} is not a valid test case "
> +                f"of test suite {self.test_suite_name}."
> +            )
> +            selected_test_cases.append(available_test_cases[requested_te=
st_case])
> +
> +        return selected_test_cases or list(available_test_cases.values()=
)
> +
>      @model_validator(mode=3D"before")
>      @classmethod
>      def convert_from_string(cls, data: Any) -> Any:
> @@ -246,17 +263,11 @@ def convert_from_string(cls, data: Any) -> Any:
>      def validate_names(self) -> Self:
>          """Validate the supplied test suite and test cases names.
>
> -        This validator relies on the cached property `test_suite_spec` t=
o run for the first
> -        time in this call, therefore triggering the assertions if needed=
.
> +        This validator relies on the cached properties `test_suite_spec`=
 and `test_cases` to run for
> +        the first time in this call, therefore triggering the assertions=
 if needed.
>          """
> -        available_test_cases =3D map(
> -            lambda t: t.name, self.test_suite_spec.class_obj.get_test_ca=
ses()
> -        )
> -        for requested_test_case in self.test_cases_names:
> -            assert requested_test_case in available_test_cases, (
> -                f"{requested_test_case} is not a valid test case "
> -                f"of test suite {self.test_suite_name}."
> -            )
> +        if self.test_cases:
> +            pass
>
>          return self
>
> @@ -383,3 +394,29 @@ class TestRunConfiguration(FrozenModel):
>      fields_from_settings =3D model_validator(mode=3D"before")(
>          load_fields_from_settings("test_suites", "random_seed")
>      )
> +
> +    def filter_tests(
> +        self,
> +    ) -> Iterable[tuple[type["TestSuite"], deque[type["TestCase"]]]]:
> +        """Filter test suites and cases selected for execution."""
> +        from framework.test_suite import TestCaseType
> +
> +        test_suites =3D [TestSuiteConfig(test_suite=3D"smoke_tests")]
> +
> +        if self.skip_smoke_tests:
> +            test_suites =3D self.test_suites
> +        else:
> +            test_suites +=3D self.test_suites
> +
> +        return (
> +            (
> +                t.test_suite_spec.class_obj,
> +                deque(
> +                    tt
> +                    for tt in t.test_cases
> +                    if (tt.test_type is TestCaseType.FUNCTIONAL and self=
.func)
> +                    or (tt.test_type is TestCaseType.PERFORMANCE and sel=
f.perf)
> +                ),
> +            )
> +            for t in test_suites
> +        )
> --
> 2.43.0
>
