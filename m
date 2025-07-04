Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFA12C83F04
	for <dpdk-dev@archiver.kernel.org>; Fri,  4 Jul 2025 02:07:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E3BDE4028B;
	Fri,  4 Jul 2025 04:07:38 +0200 (CEST)
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com
 [209.85.216.47]) by mails.dpdk.org (Postfix) with ESMTP id 053E84027D
 for <dev@dpdk.org>; Fri,  4 Jul 2025 04:07:37 +0200 (CEST)
Received: by mail-pj1-f47.google.com with SMTP id
 98e67ed59e1d1-3135f3511bcso561443a91.0
 for <dev@dpdk.org>; Thu, 03 Jul 2025 19:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1751594856; x=1752199656; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hknHd7TOKSxvB7+IjZNR/Zgmzn+uZbq/GJLTas5K8CM=;
 b=YOM12jT1FE9ICKRF9OX737hN2AxDpFvP6/8d0c5oPrXmAnF0xtz61/OhFxiSvGKVxm
 J/Sfgp/nl6RR8YhPyTnsotFNCR6Mf6LZ1LDTxqjLH3X6LQjeR1483ASIsRjh5YBJ6TDK
 YRgX1F0N6zfYBE8Y9dg3xc5dgzjzLj9hYVsBE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751594856; x=1752199656;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hknHd7TOKSxvB7+IjZNR/Zgmzn+uZbq/GJLTas5K8CM=;
 b=bRCSGQJ0QLVJrjbinZ/fLCC38wBgxfGLubjGs1JnCANp28Ov+eaqzq3rs8CcBHriSL
 PV6O8TzCFbQFnD4RqkUMICrgctCVsSf3eAGUJbU3c8DqsGQ7p13gEyNnFPHDEdWX3mZ3
 qMkmvgex9pkZP+Ba5zWxrDi9MGWZcYucMLpYnkrefmLOhEoPwabZdJEgLWRxwOL2q9Ak
 j5kCs04Ijw72NLdDvkGjP52rfPCAdNQDCxdQ3CL5FDCCvWEbcVwX0ibHZHEzmscp7XDD
 jq0dLGEITtRE+CqKJIzkU0M4OKkR6dYLEmLM5sBc6vcxPhMVXJoKIY4rrGqpSpqlBFZJ
 7Wtw==
X-Gm-Message-State: AOJu0YwKQ7zacXwbwKfRVEPPvJ8mbRud4tviAHdqUIl95aY/L5UsE691
 pyBAFgbl7sgX0Lel863V7xhK7uVM7OFmmOUTsrcW6lsFtVXY1elO8qi8S3GCmiFsnJxp2F1kqMC
 rFtAbhoOgIomk05kh5zHhojhUCM+m6zFd0gVhmBoofNRtWzvn7jUPhpg=
X-Gm-Gg: ASbGncvz5Xx1BidEgZMD2RHuQ8QQN4QWFB+Ec1vustB0t9cjqXiJtQimHnV0H/4UIxL
 7qVv8vWD3IggU3+SPDutjN/nw9J7gx2kWikP8PIvEs1TCn0Y1sieJ/Xj7sMPFIRaf5t7H69kj6v
 kZWEo2d2Bffv+2Pi8WwjR9BzEM02Uul97i2xTN1vY2kSKQ5HpSnkFOq2c27nA=
X-Google-Smtp-Source: AGHT+IFC3JlNgnBoxWngz7NQcNX+EsLJhQ+u8aq4dQAoKBTkOJP/OAY8FXdpDClshrftIVp97cNX0aja/8LRwYNzgg0=
X-Received: by 2002:a17:90b:2882:b0:312:f88d:260b with SMTP id
 98e67ed59e1d1-31aac45a607mr1406695a91.14.1751594855890; Thu, 03 Jul 2025
 19:07:35 -0700 (PDT)
MIME-Version: 1.0
References: <20250627151241.335114-1-thomas.wilks@arm.com>
 <20250627151241.335114-3-thomas.wilks@arm.com>
In-Reply-To: <20250627151241.335114-3-thomas.wilks@arm.com>
From: Patrick Robb <probb@iol.unh.edu>
Date: Thu, 3 Jul 2025 22:01:58 -0400
X-Gm-Features: Ac12FXyocQqW62i1D4hz64luKDKV_-S5S_9UNs1WC8b6uPYyLdcYpGJND2Mcsqk
Message-ID: <CAJvnSUB1efYf2hwTxQU3o_mMoYbP7wLHs-W7ey8CdEYowiSk1Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] dts: rework test results
To: Thomas Wilks <thomas.wilks@arm.com>
Cc: dev@dpdk.org, Paul Szczepanek <paul.szczepanek@arm.com>, 
 Luca Vizzarro <luca.vizzarro@arm.com>
Content-Type: multipart/alternative; boundary="0000000000002d16db063910f518"
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

--0000000000002d16db063910f518
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 27, 2025 at 11:12=E2=80=AFAM Thomas Wilks <thomas.wilks@arm.com=
> wrote:

> Refactor the DTS result recording system to use a hierarchical tree
> structure based on `ResultNode` and `ResultLeaf`, replacing the prior fla=
t
> model of DTSResult, TestRunResult, and TestSuiteResult. This improves
> clarity, composability, and enables consistent traversal and aggregation
> of test outcomes.
>

Agreed.


>
> Update all FSM states and the runner to build results directly into the
> tree, capturing setup, teardown, and test outcomes uniformly. Errors are
> now stored directly as exceptions and reduced into an exit code, and
> summaries are generated using Pydantic-based serializers for JSON and tex=
t
> output. Finally, a new textual result summary is generated showing the
> result of all the steps.
>
> Signed-off-by: Thomas Wilks <thomas.wilks@arm.com>
> Signed-off-by: Luca Vizzarro <luca.vizzarro@arm.com>
> ---
>  dts/framework/runner.py                      |  33 +-
>  dts/framework/test_result.py                 | 882 +++++--------------
>  dts/framework/test_run.py                    | 137 +--
>  dts/framework/testbed_model/posix_session.py |   4 +-
>  4 files changed, 337 insertions(+), 719 deletions(-)
>
> diff --git a/dts/framework/runner.py b/dts/framework/runner.py
> index f20aa3576a..0a3d92b0c8 100644
> --- a/dts/framework/runner.py
> +++ b/dts/framework/runner.py
> @@ -18,16 +18,10 @@
>  from framework.test_run import TestRun
>  from framework.testbed_model.node import Node
>
> -from .config import (
> -    Configuration,
> -    load_config,
> -)
> +from .config import Configuration, load_config
>  from .logger import DTSLogger, get_dts_logger
>  from .settings import SETTINGS
> -from .test_result import (
> -    DTSResult,
> -    Result,
> -)
> +from .test_result import ResultNode, TestRunResult
>
>
>  class DTSRunner:
> @@ -35,7 +29,7 @@ class DTSRunner:
>
>      _configuration: Configuration
>      _logger: DTSLogger
> -    _result: DTSResult
> +    _result: TestRunResult
>
>      def __init__(self):
>          """Initialize the instance with configuration, logger, result an=
d
> string constants."""
> @@ -54,7 +48,9 @@ def __init__(self):
>          if not os.path.exists(SETTINGS.output_dir):
>              os.makedirs(SETTINGS.output_dir)
>          self._logger.add_dts_root_logger_handlers(SETTINGS.verbose,
> SETTINGS.output_dir)
> -        self._result =3D DTSResult(SETTINGS.output_dir, self._logger)
> +
> +        test_suites_result =3D ResultNode(label=3D"test_suites")
> +        self._result =3D TestRunResult(test_suites=3Dtest_suites_result)
>
>      def run(self) -> None:
>          """Run DTS.
> @@ -66,34 +62,30 @@ def run(self) -> None:
>          try:
>              # check the python version of the server that runs dts
>              self._check_dts_python_version()
> -            self._result.update_setup(Result.PASS)
>
>              for node_config in self._configuration.nodes:
>                  nodes.append(Node(node_config))
>
> -            test_run_result =3D
> self._result.add_test_run(self._configuration.test_run)
>              test_run =3D TestRun(
>                  self._configuration.test_run,
>                  self._configuration.tests_config,
>                  nodes,
> -                test_run_result,
> +                self._result,
>              )
>              test_run.spin()
>
>          except Exception as e:
> -            self._logger.exception("An unexpected error has occurred.")
> +            self._logger.exception("An unexpected error has occurred.", =
e)
>              self._result.add_error(e)
> -            # raise
>
>          finally:
>              try:
>                  self._logger.set_stage("post_run")
>                  for node in nodes:
>                      node.close()
> -                self._result.update_teardown(Result.PASS)
>              except Exception as e:
> -                self._logger.exception("The final cleanup of nodes
> failed.")
> -                self._result.update_teardown(Result.ERROR, e)
> +                self._logger.exception("The final cleanup of nodes
> failed.", e)
> +                self._result.add_error(e)
>
>          # we need to put the sys.exit call outside the finally clause to
> make sure
>          # that unexpected exceptions will propagate
> @@ -116,9 +108,6 @@ def _check_dts_python_version(self) -> None:
>
>      def _exit_dts(self) -> None:
>          """Process all errors and exit with the proper exit code."""
> -        self._result.process()
> -
>          if self._logger:
>              self._logger.info("DTS execution has ended.")
> -
> -        sys.exit(self._result.get_return_code())
> +        sys.exit(self._result.process())
> diff --git a/dts/framework/test_result.py b/dts/framework/test_result.py
> index 7f576022c7..8ce6cc8fbf 100644
> --- a/dts/framework/test_result.py
> +++ b/dts/framework/test_result.py
> @@ -7,723 +7,323 @@
>
>  The results are recorded in a hierarchical manner:
>
> -    * :class:`DTSResult` contains
>      * :class:`TestRunResult` contains
> -    * :class:`TestSuiteResult` contains
> -    * :class:`TestCaseResult`
> +    * :class:`ResultNode` may contain itself or
> +    * :class:`ResultLeaf`
>
> -Each result may contain multiple lower level results, e.g. there are
> multiple
> -:class:`TestSuiteResult`\s in a :class:`TestRunResult`.
> -The results have common parts, such as setup and teardown results,
> captured in :class:`BaseResult`,
> -which also defines some common behaviors in its methods.
> -
> -Each result class has its own idiosyncrasies which they implement in
> overridden methods.
> +Each result may contain many intermediate steps, e.g. there are multiple
> +:class:`ResultNode`\s in a :class:`ResultNode`.
>
>  The :option:`--output` command line argument and the
> :envvar:`DTS_OUTPUT_DIR` environment
>  variable modify the directory where the files with results will be store=
d.
>  """
>
> -import json
> -from collections.abc import MutableSequence
> -from enum import Enum, auto
> +import sys
> +from collections import Counter
> +from enum import IntEnum, auto
> +from io import StringIO
>  from pathlib import Path
> -from typing import Any, Callable, TypedDict
> +from typing import Any, ClassVar, Literal, TextIO, Union
> +
> +from pydantic import (
> +    BaseModel,
> +    ConfigDict,
> +    Field,
> +    computed_field,
> +    field_serializer,
> +    model_serializer,
> +)
> +from typing_extensions import OrderedDict
>
> -from .config.test_run import TestRunConfiguration
> -from .exception import DTSError, ErrorSeverity
> -from .logger import DTSLogger
> -from .remote_session.dpdk import DPDKBuildInfo
> -from .testbed_model.os_session import OSSessionInfo
> -from .testbed_model.port import Port
> +from framework.remote_session.dpdk import DPDKBuildInfo
> +from framework.settings import SETTINGS
> +from framework.testbed_model.os_session import OSSessionInfo
>
> +from .exception import DTSError, ErrorSeverity, InternalError
>
> -class Result(Enum):
> +
> +class Result(IntEnum):
>      """The possible states that a setup, a teardown or a test case may
> end up in."""
>
>      #:
>      PASS =3D auto()
>      #:
> -    FAIL =3D auto()
> -    #:
> -    ERROR =3D auto()
> +    SKIP =3D auto()
>      #:
>      BLOCK =3D auto()
>      #:
> -    SKIP =3D auto()
> +    FAIL =3D auto()
> +    #:
> +    ERROR =3D auto()
>
>      def __bool__(self) -> bool:
>          """Only :attr:`PASS` is True."""
>          return self is self.PASS
>
>
> -class TestCaseResultDict(TypedDict):
> -    """Represents the `TestCaseResult` results.
> -
> -    Attributes:
> -        test_case_name: The name of the test case.
> -        result: The result name of the test case.
> -    """
> -
> -    test_case_name: str
> -    result: str
> -
> -
> -class TestSuiteResultDict(TypedDict):
> -    """Represents the `TestSuiteResult` results.
> -
> -    Attributes:
> -        test_suite_name: The name of the test suite.
> -        test_cases: A list of test case results contained in this test
> suite.
> -    """
> -
> -    test_suite_name: str
> -    test_cases: list[TestCaseResultDict]
> -
> -
> -class TestRunResultDict(TypedDict, total=3DFalse):
> -    """Represents the `TestRunResult` results.
> -
> -    Attributes:
> -        compiler_version: The version of the compiler used for the DPDK
> build.
> -        dpdk_version: The version of DPDK being tested.
> -        ports: A list of ports associated with the test run.
> -        test_suites: A list of test suite results included in this test
> run.
> -        summary: A dictionary containing overall results, such as
> pass/fail counts.
> -    """
> -
> -    compiler_version: str | None
> -    dpdk_version: str | None
> -    ports: list[dict[str, Any]]
> -    test_suites: list[TestSuiteResultDict]
> -    summary: dict[str, int | float]
> -
> +class ResultLeaf(BaseModel):
> +    """Class representing a result in the results tree.
>
> -class DtsRunResultDict(TypedDict):
> -    """Represents the `DtsRunResult` results.
> +    A leaf node that can contain the results for a
> :class:`~.test_suite.TestSuite`,
> +    :class:`.test_suite.TestCase` or a DTS execution step.
>
>      Attributes:
> -        test_runs: A list of test run results.
> -        summary: A summary dictionary containing overall statistics for
> the test runs.
> +        result: The actual result.
> +        reason: The reason of the result.
>      """
>

From running some testcases that resulted in Error or Fail, I agree adding
this is a big benefit. Providing an example for any others on the mailing
list who are curious:

  rte_flow: FAIL
    test_drop_action_ETH: PASS
    test_drop_action_IP: PASS
    test_drop_action_L4: PASS
    test_drop_action_VLAN: PASS
    test_egress_rules: SKIP
      reason: flow rule failed validation.
    test_jump_action: PASS
    test_modify_actions: FAIL
      reason: Packet was never received.
    test_priority_attribute: PASS
    test_queue_action_ETH: PASS
    test_queue_action_IP: PASS
    test_queue_action_L4: PASS
    test_queue_action_VLAN: PASS


>
>
> --
> 2.43.0
>
>
Looks good, I will apply to next-dts now.

Reviewed-by: Patrick Robb <probb@iol.unh.edu>
Tested-by Patrick Robb <probb@iol.unh.edu>

--0000000000002d16db063910f518
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Jun 27,=
 2025 at 11:12=E2=80=AFAM Thomas Wilks &lt;<a href=3D"mailto:thomas.wilks@a=
rm.com">thomas.wilks@arm.com</a>&gt; wrote:<br></div><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex">Refactor the DTS result recording system to use=
 a hierarchical tree<br>
structure based on `ResultNode` and `ResultLeaf`, replacing the prior flat<=
br>
model of DTSResult, TestRunResult, and TestSuiteResult. This improves<br>
clarity, composability, and enables consistent traversal and aggregation<br=
>
of test outcomes.<br></blockquote><div><br></div><div>Agreed.</div><div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Update all FSM states and the runner to build results directly into the<br>
tree, capturing setup, teardown, and test outcomes uniformly. Errors are<br=
>
now stored directly as exceptions and reduced into an exit code, and<br>
summaries are generated using Pydantic-based serializers for JSON and text<=
br>
output. Finally, a new textual result summary is generated showing the<br>
result of all the steps.<br>
<br>
Signed-off-by: Thomas Wilks &lt;<a href=3D"mailto:thomas.wilks@arm.com" tar=
get=3D"_blank">thomas.wilks@arm.com</a>&gt;<br>
Signed-off-by: Luca Vizzarro &lt;<a href=3D"mailto:luca.vizzarro@arm.com" t=
arget=3D"_blank">luca.vizzarro@arm.com</a>&gt;<br>
---<br>
=C2=A0dts/framework/runner.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 33 +-<br>
=C2=A0dts/framework/test_result.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0| 882 +++++--------------<br>
=C2=A0dts/framework/test_run.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 137 +--<br>
=C2=A0dts/framework/testbed_model/posix_session.py |=C2=A0 =C2=A04 +-<br>
=C2=A04 files changed, 337 insertions(+), 719 deletions(-)<br>
<br>
diff --git a/dts/framework/runner.py b/dts/framework/runner.py<br>
index f20aa3576a..0a3d92b0c8 100644<br>
--- a/dts/framework/runner.py<br>
+++ b/dts/framework/runner.py<br>
@@ -18,16 +18,10 @@<br>
=C2=A0from framework.test_run import TestRun<br>
=C2=A0from framework.testbed_model.node import Node<br>
<br>
-from .config import (<br>
-=C2=A0 =C2=A0 Configuration,<br>
-=C2=A0 =C2=A0 load_config,<br>
-)<br>
+from .config import Configuration, load_config<br>
=C2=A0from .logger import DTSLogger, get_dts_logger<br>
=C2=A0from .settings import SETTINGS<br>
-from .test_result import (<br>
-=C2=A0 =C2=A0 DTSResult,<br>
-=C2=A0 =C2=A0 Result,<br>
-)<br>
+from .test_result import ResultNode, TestRunResult<br>
<br>
<br>
=C2=A0class DTSRunner:<br>
@@ -35,7 +29,7 @@ class DTSRunner:<br>
<br>
=C2=A0 =C2=A0 =C2=A0_configuration: Configuration<br>
=C2=A0 =C2=A0 =C2=A0_logger: DTSLogger<br>
-=C2=A0 =C2=A0 _result: DTSResult<br>
+=C2=A0 =C2=A0 _result: TestRunResult<br>
<br>
=C2=A0 =C2=A0 =C2=A0def __init__(self):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Initialize the instance=
 with configuration, logger, result and string constants.&quot;&quot;&quot;=
<br>
@@ -54,7 +48,9 @@ def __init__(self):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if not os.path.exists(SETTINGS.output_dir=
):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0os.makedirs(SETTINGS.output=
_dir)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self._logger.add_dts_root_logger_handlers=
(SETTINGS.verbose, SETTINGS.output_dir)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._result =3D DTSResult(SETTINGS.output_dir=
, self._logger)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 test_suites_result =3D ResultNode(label=3D&quo=
t;test_suites&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._result =3D TestRunResult(test_suites=3Dt=
est_suites_result)<br>
<br>
=C2=A0 =C2=A0 =C2=A0def run(self) -&gt; None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Run DTS.<br>
@@ -66,34 +62,30 @@ def run(self) -&gt; None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0try:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# check the python version =
of the server that runs dts<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self._check_dts_python_vers=
ion()<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._result.update_setup(Result=
.PASS)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for node_config in self._co=
nfiguration.nodes:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0nodes.append(=
Node(node_config))<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 test_run_result =3D self._result=
.add_test_run(self._configuration.test_run)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0test_run =3D TestRun(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self._configu=
ration.test_run,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self._configu=
ration.tests_config,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0nodes,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 test_run_result,<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._result,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0test_run.spin()<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0except Exception as e:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._logger.exception(&quot;An =
unexpected error has occurred.&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._logger.exception(&quot;An =
unexpected error has occurred.&quot;, e)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self._result.add_error(e)<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # raise<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0finally:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0try:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self._logger.=
set_stage(&quot;post_run&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for node in n=
odes:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0node.close()<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._result.updat=
e_teardown(Result.PASS)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0except Exception as e:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._logger.excep=
tion(&quot;The final cleanup of nodes failed.&quot;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._result.updat=
e_teardown(Result.ERROR, e)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._logger.excep=
tion(&quot;The final cleanup of nodes failed.&quot;, e)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._result.add_e=
rror(e)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# we need to put the sys.exit call outsid=
e the finally clause to make sure<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# that unexpected exceptions will propaga=
te<br>
@@ -116,9 +108,6 @@ def _check_dts_python_version(self) -&gt; None:<br>
<br>
=C2=A0 =C2=A0 =C2=A0def _exit_dts(self) -&gt; None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Process all errors and =
exit with the proper exit code.&quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._result.process()<br>
-<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if self._logger:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self._<a href=3D"http://log=
ger.info" rel=3D"noreferrer" target=3D"_blank">logger.info</a>(&quot;DTS ex=
ecution has ended.&quot;)<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 sys.exit(self._result.get_return_code())<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 sys.exit(self._result.process())<br>
diff --git a/dts/framework/test_result.py b/dts/framework/test_result.py<br=
>
index 7f576022c7..8ce6cc8fbf 100644<br>
--- a/dts/framework/test_result.py<br>
+++ b/dts/framework/test_result.py<br>
@@ -7,723 +7,323 @@<br>
<br>
=C2=A0The results are recorded in a hierarchical manner:<br>
<br>
-=C2=A0 =C2=A0 * :class:`DTSResult` contains<br>
=C2=A0 =C2=A0 =C2=A0* :class:`TestRunResult` contains<br>
-=C2=A0 =C2=A0 * :class:`TestSuiteResult` contains<br>
-=C2=A0 =C2=A0 * :class:`TestCaseResult`<br>
+=C2=A0 =C2=A0 * :class:`ResultNode` may contain itself or<br>
+=C2=A0 =C2=A0 * :class:`ResultLeaf`<br>
<br>
-Each result may contain multiple lower level results, e.g. there are multi=
ple<br>
-:class:`TestSuiteResult`\s in a :class:`TestRunResult`.<br>
-The results have common parts, such as setup and teardown results, capture=
d in :class:`BaseResult`,<br>
-which also defines some common behaviors in its methods.<br>
-<br>
-Each result class has its own idiosyncrasies which they implement in overr=
idden methods.<br>
+Each result may contain many intermediate steps, e.g. there are multiple<b=
r>
+:class:`ResultNode`\s in a :class:`ResultNode`.<br>
<br>
=C2=A0The :option:`--output` command line argument and the :envvar:`DTS_OUT=
PUT_DIR` environment<br>
=C2=A0variable modify the directory where the files with results will be st=
ored.<br>
=C2=A0&quot;&quot;&quot;<br>
<br>
-import json<br>
-from collections.abc import MutableSequence<br>
-from enum import Enum, auto<br>
+import sys<br>
+from collections import Counter<br>
+from enum import IntEnum, auto<br>
+from io import StringIO<br>
=C2=A0from pathlib import Path<br>
-from typing import Any, Callable, TypedDict<br>
+from typing import Any, ClassVar, Literal, TextIO, Union<br>
+<br>
+from pydantic import (<br>
+=C2=A0 =C2=A0 BaseModel,<br>
+=C2=A0 =C2=A0 ConfigDict,<br>
+=C2=A0 =C2=A0 Field,<br>
+=C2=A0 =C2=A0 computed_field,<br>
+=C2=A0 =C2=A0 field_serializer,<br>
+=C2=A0 =C2=A0 model_serializer,<br>
+)<br>
+from typing_extensions import OrderedDict<br>
<br>
-from .config.test_run import TestRunConfiguration<br>
-from .exception import DTSError, ErrorSeverity<br>
-from .logger import DTSLogger<br>
-from .remote_session.dpdk import DPDKBuildInfo<br>
-from .testbed_model.os_session import OSSessionInfo<br>
-from .testbed_model.port import Port<br>
+from framework.remote_session.dpdk import DPDKBuildInfo<br>
+from framework.settings import SETTINGS<br>
+from framework.testbed_model.os_session import OSSessionInfo<br>
<br>
+from .exception import DTSError, ErrorSeverity, InternalError<br>
<br>
-class Result(Enum):<br>
+<br>
+class Result(IntEnum):<br>
=C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;The possible states that a setup, a t=
eardown or a test case may end up in.&quot;&quot;&quot;<br>
<br>
=C2=A0 =C2=A0 =C2=A0#:<br>
=C2=A0 =C2=A0 =C2=A0PASS =3D auto()<br>
=C2=A0 =C2=A0 =C2=A0#:<br>
-=C2=A0 =C2=A0 FAIL =3D auto()<br>
-=C2=A0 =C2=A0 #:<br>
-=C2=A0 =C2=A0 ERROR =3D auto()<br>
+=C2=A0 =C2=A0 SKIP =3D auto()<br>
=C2=A0 =C2=A0 =C2=A0#:<br>
=C2=A0 =C2=A0 =C2=A0BLOCK =3D auto()<br>
=C2=A0 =C2=A0 =C2=A0#:<br>
-=C2=A0 =C2=A0 SKIP =3D auto()<br>
+=C2=A0 =C2=A0 FAIL =3D auto()<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 ERROR =3D auto()<br>
<br>
=C2=A0 =C2=A0 =C2=A0def __bool__(self) -&gt; bool:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Only :attr:`PASS` is Tr=
ue.&quot;&quot;&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return self is self.PASS<br>
<br>
<br>
-class TestCaseResultDict(TypedDict):<br>
-=C2=A0 =C2=A0 &quot;&quot;&quot;Represents the `TestCaseResult` results.<b=
r>
-<br>
-=C2=A0 =C2=A0 Attributes:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 test_case_name: The name of the test case.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 result: The result name of the test case.<br>
-=C2=A0 =C2=A0 &quot;&quot;&quot;<br>
-<br>
-=C2=A0 =C2=A0 test_case_name: str<br>
-=C2=A0 =C2=A0 result: str<br>
-<br>
-<br>
-class TestSuiteResultDict(TypedDict):<br>
-=C2=A0 =C2=A0 &quot;&quot;&quot;Represents the `TestSuiteResult` results.<=
br>
-<br>
-=C2=A0 =C2=A0 Attributes:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 test_suite_name: The name of the test suite.<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 test_cases: A list of test case results contai=
ned in this test suite.<br>
-=C2=A0 =C2=A0 &quot;&quot;&quot;<br>
-<br>
-=C2=A0 =C2=A0 test_suite_name: str<br>
-=C2=A0 =C2=A0 test_cases: list[TestCaseResultDict]<br>
-<br>
-<br>
-class TestRunResultDict(TypedDict, total=3DFalse):<br>
-=C2=A0 =C2=A0 &quot;&quot;&quot;Represents the `TestRunResult` results.<br=
>
-<br>
-=C2=A0 =C2=A0 Attributes:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 compiler_version: The version of the compiler =
used for the DPDK build.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 dpdk_version: The version of DPDK being tested=
.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 ports: A list of ports associated with the tes=
t run.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 test_suites: A list of test suite results incl=
uded in this test run.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 summary: A dictionary containing overall resul=
ts, such as pass/fail counts.<br>
-=C2=A0 =C2=A0 &quot;&quot;&quot;<br>
-<br>
-=C2=A0 =C2=A0 compiler_version: str | None<br>
-=C2=A0 =C2=A0 dpdk_version: str | None<br>
-=C2=A0 =C2=A0 ports: list[dict[str, Any]]<br>
-=C2=A0 =C2=A0 test_suites: list[TestSuiteResultDict]<br>
-=C2=A0 =C2=A0 summary: dict[str, int | float]<br>
-<br>
+class ResultLeaf(BaseModel):<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;Class representing a result in the results=
 tree.<br>
<br>
-class DtsRunResultDict(TypedDict):<br>
-=C2=A0 =C2=A0 &quot;&quot;&quot;Represents the `DtsRunResult` results.<br>
+=C2=A0 =C2=A0 A leaf node that can contain the results for a :class:`~.tes=
t_suite.TestSuite`,<br>
+=C2=A0 =C2=A0 :class:`.test_suite.TestCase` or a DTS execution step.<br>
<br>
=C2=A0 =C2=A0 =C2=A0Attributes:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 test_runs: A list of test run results.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 summary: A summary dictionary containing overa=
ll statistics for the test runs.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 result: The actual result.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 reason: The reason of the result.<br>
=C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br></blockquote><div><br></div><div>=
From running some testcases that resulted in Error or Fail, I agree adding =
this is a big benefit. Providing an example for any others on the mailing l=
ist who are curious:</div><div><br></div>=C2=A0 rte_flow: FAIL<br>=C2=A0 =
=C2=A0 test_drop_action_ETH: PASS<br>=C2=A0 =C2=A0 test_drop_action_IP: PAS=
S<br>=C2=A0 =C2=A0 test_drop_action_L4: PASS<br>=C2=A0 =C2=A0 test_drop_act=
ion_VLAN: PASS<br>=C2=A0 =C2=A0 test_egress_rules: SKIP<br>=C2=A0 =C2=A0 =
=C2=A0 reason: flow rule failed validation.<br>=C2=A0 =C2=A0 test_jump_acti=
on: PASS<br>=C2=A0 =C2=A0 test_modify_actions: FAIL<br>=C2=A0 =C2=A0 =C2=A0=
 reason: Packet was never received.<br>=C2=A0 =C2=A0 test_priority_attribut=
e: PASS<br>=C2=A0 =C2=A0 test_queue_action_ETH: PASS<br>=C2=A0 =C2=A0 test_=
queue_action_IP: PASS<br>=C2=A0 =C2=A0 test_queue_action_L4: PASS<br><div>=
=C2=A0 =C2=A0 test_queue_action_VLAN: PASS=C2=A0</div><div>=C2=A0</div><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left=
:1px solid rgb(204,204,204);padding-left:1ex">
<br><br>
-- <br>
2.43.0<br>
<br></blockquote><div><br></div><div>Looks good, I will apply to next-dts n=
ow.</div><div><br></div><div>Reviewed-by: Patrick Robb &lt;<a href=3D"mailt=
o:probb@iol.unh.edu">probb@iol.unh.edu</a>&gt;</div><div>Tested-by Patrick =
Robb &lt;<a href=3D"mailto:probb@iol.unh.edu">probb@iol.unh.edu</a>&gt;=C2=
=A0</div></div></div>

--0000000000002d16db063910f518--
