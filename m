Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B243C282D1
	for <dpdk-dev@archiver.kernel.org>; Mon,  3 Mar 2025 14:58:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C837940608;
	Mon,  3 Mar 2025 15:57:27 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id 2DB814060A
 for <dev@dpdk.org>; Mon,  3 Mar 2025 15:57:25 +0100 (CET)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BFFFB113E;
 Mon,  3 Mar 2025 06:57:38 -0800 (PST)
Received: from localhost.localdomain (unknown [10.57.64.81])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id EE2F93F66E;
 Mon,  3 Mar 2025 06:57:23 -0800 (PST)
From: Luca Vizzarro <Luca.Vizzarro@arm.com>
To: dev@dpdk.org
Cc: Luca Vizzarro <luca.vizzarro@arm.com>,
 Paul Szczepanek <paul.szczepanek@arm.com>, Patrick Robb <probb@iol.unh.edu>
Subject: [PATCH v4 6/7] dts: add per-test-suite configuration
Date: Mon,  3 Mar 2025 16:57:08 +0200
Message-ID: <20250303145709.126126-7-Luca.Vizzarro@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250303145709.126126-1-Luca.Vizzarro@arm.com>
References: <20241108134532.130681-1-luca.vizzarro@arm.com>
 <20250303145709.126126-1-Luca.Vizzarro@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Luca Vizzarro <luca.vizzarro@arm.com>

Allow test suites to be configured individually. Moreover enable them to
implement their own custom configuration.

Adds a new argument to the command line which enables the user to supply
a YAML file to configure all of the requested test suites. This argument
becomes mandatory only if any of the selected test suites' configuration
does not provide defaults for at least one field.

The configuration file is a simple mapping of test suite names to their
corresponding configurations. The validation object is created
dynamically, implementing only the selected test suites at runtime. This
is needed so that any test suites that require manual configuration,
won't complain if they are not selected.

Bugzilla ID: 1375

Signed-off-by: Luca Vizzarro <luca.vizzarro@arm.com>
Reviewed-by: Paul Szczepanek <paul.szczepanek@arm.com>
---
 doc/guides/tools/dts.rst           |  9 ++++---
 dts/framework/config/__init__.py   | 39 +++++++++++++++++++++++++++---
 dts/framework/config/test_run.py   | 36 ++++++++++++++++++++++++---
 dts/framework/runner.py            |  7 +++++-
 dts/framework/settings.py          | 17 +++++++++++++
 dts/framework/test_run.py          | 23 ++++++++++++------
 dts/framework/test_suite.py        | 25 +++++++++++++------
 dts/tests/TestSuite_hello_world.py | 14 +++++++++--
 dts/tests_config.example.yaml      |  2 ++
 9 files changed, 144 insertions(+), 28 deletions(-)

diff --git a/doc/guides/tools/dts.rst b/doc/guides/tools/dts.rst
index 2affcf5d39..fcc6d22036 100644
--- a/doc/guides/tools/dts.rst
+++ b/doc/guides/tools/dts.rst
@@ -228,9 +228,10 @@ DTS is run with ``main.py`` located in the ``dts`` directory after entering Poet
 .. code-block:: console
 
    (dts-py3.10) $ ./main.py --help
-   usage: main.py [-h] [--test-run-config-file FILE_PATH] [--nodes-config-file FILE_PATH] [--output-dir DIR_PATH] [-t SECONDS] [-v]
-                  [--dpdk-tree DIR_PATH | --tarball FILE_PATH] [--remote-source] [--precompiled-build-dir DIR_NAME]
-                  [--compile-timeout SECONDS] [--test-suite TEST_SUITE [TEST_CASES ...]] [--re-run N_TIMES] [--random-seed NUMBER]
+   usage: main.py [-h] [--test-run-config-file FILE_PATH] [--nodes-config-file FILE_PATH] [--tests-config-file FILE_PATH]
+                  [--output-dir DIR_PATH] [-t SECONDS] [-v] [--dpdk-tree DIR_PATH | --tarball FILE_PATH] [--remote-source]
+                  [--precompiled-build-dir DIR_NAME] [--compile-timeout SECONDS] [--test-suite TEST_SUITE [TEST_CASES ...]]
+                  [--re-run N_TIMES] [--random-seed NUMBER]
 
    Run DPDK test suites. All options may be specified with the environment variables provided in brackets. Command line arguments have higher
    priority.
@@ -241,6 +242,8 @@ DTS is run with ``main.py`` located in the ``dts`` directory after entering Poet
                            [DTS_TEST_RUN_CFG_FILE] The configuration file that describes the test cases and DPDK build options. (default: test-run.conf.yaml)
      --nodes-config-file FILE_PATH
                            [DTS_NODES_CFG_FILE] The configuration file that describes the SUT and TG nodes. (default: nodes.conf.yaml)
+     --tests-config-file FILE_PATH
+                           [DTS_TESTS_CFG_FILE] Configuration file used to override variable values inside specific test suites. (default: None)
      --output-dir DIR_PATH, --output DIR_PATH
                            [DTS_OUTPUT_DIR] Output directory where DTS logs and results are saved. (default: output)
      -t SECONDS, --timeout SECONDS
diff --git a/dts/framework/config/__init__.py b/dts/framework/config/__init__.py
index 5495cfc5d5..129e6f3222 100644
--- a/dts/framework/config/__init__.py
+++ b/dts/framework/config/__init__.py
@@ -17,6 +17,7 @@
       defining what tests are going to be run and how DPDK will be built. It also references
       the testbed where these tests and DPDK are going to be run,
     * A list of the nodes of the testbed which ar represented by :class:`~.node.NodeConfiguration`.
+    * A dictionary mapping test suite names to their corresponding configurations.
 
 The real-time information about testbed is supposed to be gathered at runtime.
 
@@ -27,8 +28,9 @@
       and makes it thread safe should we ever want to move in that direction.
 """
 
+import os
 from pathlib import Path
-from typing import Annotated, Any, Literal, TypeVar, cast
+from typing import TYPE_CHECKING, Annotated, Any, Literal, TypeVar, cast
 
 import yaml
 from pydantic import Field, TypeAdapter, ValidationError, model_validator
@@ -38,7 +40,11 @@
 
 from .common import FrozenModel, ValidationContext
 from .node import NodeConfiguration
-from .test_run import TestRunConfiguration
+from .test_run import TestRunConfiguration, create_test_suites_config_model
+
+# Import only if type checking or building docs, to prevent circular imports.
+if TYPE_CHECKING or os.environ.get("DTS_DOC_BUILD"):
+    from framework.test_suite import BaseConfig
 
 NodesConfig = Annotated[list[NodeConfiguration], Field(min_length=1)]
 
@@ -50,6 +56,8 @@ class Configuration(FrozenModel):
     test_run: TestRunConfiguration
     #: Node configurations.
     nodes: NodesConfig
+    #: Test suites custom configurations.
+    tests_config: dict[str, "BaseConfig"]
 
     @model_validator(mode="after")
     def validate_node_names(self) -> Self:
@@ -127,7 +135,7 @@ def validate_test_run_against_nodes(self) -> Self:
 T = TypeVar("T")
 
 
-def _load_and_parse_model(file_path: Path, model_type: T, ctx: ValidationContext) -> T:
+def _load_and_parse_model(file_path: Path, model_type: type[T], ctx: ValidationContext) -> T:
     with open(file_path) as f:
         try:
             data = yaml.safe_load(f)
@@ -154,9 +162,32 @@ def load_config(ctx: ValidationContext) -> Configuration:
     test_run = _load_and_parse_model(
         ctx["settings"].test_run_config_path, TestRunConfiguration, ctx
     )
+
+    TestSuitesConfiguration = create_test_suites_config_model(test_run.test_suites)
+    if ctx["settings"].tests_config_path:
+        tests_config = _load_and_parse_model(
+            ctx["settings"].tests_config_path,
+            TestSuitesConfiguration,
+            ctx,
+        )
+    else:
+        try:
+            tests_config = TestSuitesConfiguration()
+        except ValidationError as e:
+            raise ConfigurationError(
+                "A test suites' configuration file is required for the given test run. "
+                "The following selected test suites require manual configuration: "
+                + ", ".join(str(error["loc"][0]) for error in e.errors())
+            )
+
     nodes = _load_and_parse_model(ctx["settings"].nodes_config_path, NodesConfig, ctx)
 
     try:
-        return Configuration.model_validate({"test_run": test_run, "nodes": nodes}, context=ctx)
+        from framework.test_suite import BaseConfig as BaseConfig
+
+        Configuration.model_rebuild()
+        return Configuration.model_validate(
+            {"test_run": test_run, "nodes": nodes, "tests_config": dict(tests_config)}, context=ctx
+        )
     except ValidationError as e:
         raise ConfigurationError("the configurations supplied are invalid") from e
diff --git a/dts/framework/config/test_run.py b/dts/framework/config/test_run.py
index c1e534e480..688688e88e 100644
--- a/dts/framework/config/test_run.py
+++ b/dts/framework/config/test_run.py
@@ -18,7 +18,13 @@
 from pathlib import Path, PurePath
 from typing import Annotated, Any, Literal, NamedTuple
 
-from pydantic import Field, field_validator, model_validator
+from pydantic import (
+    BaseModel,
+    Field,
+    create_model,
+    field_validator,
+    model_validator,
+)
 from typing_extensions import TYPE_CHECKING, Self
 
 from framework.exception import InternalError
@@ -27,7 +33,7 @@
 from .common import FrozenModel, load_fields_from_settings
 
 if TYPE_CHECKING:
-    from framework.test_suite import TestCase, TestSuite, TestSuiteSpec
+    from framework.test_suite import BaseConfig, TestCase, TestSuite, TestSuiteSpec
 
 
 @unique
@@ -283,6 +289,27 @@ def fetch_all_test_suites() -> list[TestSuiteConfig]:
     ]
 
 
+def make_test_suite_config_field(config_obj: type["BaseConfig"]):
+    """Make a field for a test suite's configuration.
+
+    If the test suite's configuration has required fields, then make the field required. Otherwise
+    make it optional.
+    """
+    if any(f.is_required() for f in config_obj.model_fields.values()):
+        return config_obj, Field()
+    else:
+        return config_obj, Field(default_factory=config_obj)
+
+
+def create_test_suites_config_model(test_suites: Iterable[TestSuiteConfig]) -> type[BaseModel]:
+    """Create model for the test suites configuration."""
+    test_suites_kwargs = {
+        t.test_suite_name: make_test_suite_config_field(t.test_suite_spec.config_obj)
+        for t in test_suites
+    }
+    return create_model("TestSuitesConfiguration", **test_suites_kwargs)
+
+
 class LinkPortIdentifier(NamedTuple):
     """A tuple linking test run node type to port name."""
 
@@ -455,8 +482,8 @@ class TestRunConfiguration(FrozenModel):
     )
 
     def filter_tests(
-        self,
-    ) -> Iterable[tuple[type["TestSuite"], deque[type["TestCase"]]]]:
+        self, tests_config: dict[str, "BaseConfig"]
+    ) -> Iterable[tuple[type["TestSuite"], "BaseConfig", deque[type["TestCase"]]]]:
         """Filter test suites and cases selected for execution."""
         from framework.test_suite import TestCaseType
 
@@ -470,6 +497,7 @@ def filter_tests(
         return (
             (
                 t.test_suite_spec.class_obj,
+                tests_config[t.test_suite_name],
                 deque(
                     tt
                     for tt in t.test_cases
diff --git a/dts/framework/runner.py b/dts/framework/runner.py
index a0016d5d57..f822e8a8fc 100644
--- a/dts/framework/runner.py
+++ b/dts/framework/runner.py
@@ -60,7 +60,12 @@ def run(self) -> None:
                 nodes.append(Node(node_config))
 
             test_run_result = self._result.add_test_run(self._configuration.test_run)
-            test_run = TestRun(self._configuration.test_run, nodes, test_run_result)
+            test_run = TestRun(
+                self._configuration.test_run,
+                self._configuration.tests_config,
+                nodes,
+                test_run_result,
+            )
             test_run.spin()
 
         except Exception as e:
diff --git a/dts/framework/settings.py b/dts/framework/settings.py
index 256afd5cfb..3f21615223 100644
--- a/dts/framework/settings.py
+++ b/dts/framework/settings.py
@@ -24,6 +24,11 @@
 
     The path to the YAML configuration file of the nodes.
 
+.. option:: --tests-config-file
+.. envvar:: DTS_TESTS_CFG_FILE
+
+    The path to the YAML configuration file of the test suites.
+
 .. option:: --output-dir, --output
 .. envvar:: DTS_OUTPUT_DIR
 
@@ -129,6 +134,8 @@ class Settings:
     #:
     nodes_config_path: Path = Path(__file__).parent.parent.joinpath("nodes.yaml")
     #:
+    tests_config_path: Path | None = None
+    #:
     output_dir: str = "output"
     #:
     timeout: float = 15
@@ -342,6 +349,16 @@ def _get_parser() -> _DTSArgumentParser:
     )
     _add_env_var_to_action(action, "NODES_CFG_FILE")
 
+    action = parser.add_argument(
+        "--tests-config-file",
+        default=SETTINGS.tests_config_path,
+        type=Path,
+        help="Configuration file used to override variable values inside specific test suites.",
+        metavar="FILE_PATH",
+        dest="tests_config_path",
+    )
+    _add_env_var_to_action(action, "TESTS_CFG_FILE")
+
     action = parser.add_argument(
         "--output-dir",
         "--output",
diff --git a/dts/framework/test_run.py b/dts/framework/test_run.py
index 2808d013f6..3f2eea693f 100644
--- a/dts/framework/test_run.py
+++ b/dts/framework/test_run.py
@@ -118,7 +118,7 @@
 from framework.remote_session.dpdk import DPDKBuildEnvironment, DPDKRuntimeEnvironment
 from framework.settings import SETTINGS
 from framework.test_result import BaseResult, Result, TestCaseResult, TestRunResult, TestSuiteResult
-from framework.test_suite import TestCase, TestSuite
+from framework.test_suite import BaseConfig, TestCase, TestSuite
 from framework.testbed_model.capability import (
     Capability,
     get_supported_capabilities,
@@ -128,7 +128,7 @@
 from framework.testbed_model.topology import PortLink, Topology
 from framework.testbed_model.traffic_generator import create_traffic_generator
 
-TestScenario = tuple[type[TestSuite], deque[type[TestCase]]]
+TestScenario = tuple[type[TestSuite], BaseConfig, deque[type[TestCase]]]
 
 
 class TestRun:
@@ -176,11 +176,18 @@ class TestRun:
     remaining_test_cases: deque[type[TestCase]]
     supported_capabilities: set[Capability]
 
-    def __init__(self, config: TestRunConfiguration, nodes: Iterable[Node], result: TestRunResult):
+    def __init__(
+        self,
+        config: TestRunConfiguration,
+        tests_config: dict[str, BaseConfig],
+        nodes: Iterable[Node],
+        result: TestRunResult,
+    ):
         """Test run constructor.
 
         Args:
             config: The test run's own configuration.
+            tests_config: The test run's test suites configurations.
             nodes: A reference to all the available nodes.
             result: A reference to the test run result object.
         """
@@ -201,7 +208,7 @@ def __init__(self, config: TestRunConfiguration, nodes: Iterable[Node], result:
 
         self.ctx = Context(sut_node, tg_node, topology, dpdk_runtime_env, traffic_generator)
         self.result = result
-        self.selected_tests = list(self.config.filter_tests())
+        self.selected_tests = list(self.config.filter_tests(tests_config))
         self.blocked = False
         self.remaining_tests = deque()
         self.remaining_test_cases = deque()
@@ -214,7 +221,7 @@ def required_capabilities(self) -> set[Capability]:
         """The capabilities required to run this test run in its totality."""
         caps = set()
 
-        for test_suite, test_cases in self.selected_tests:
+        for test_suite, _, test_cases in self.selected_tests:
             caps.update(test_suite.required_capabilities)
             for test_case in test_cases:
                 caps.update(test_case.required_capabilities)
@@ -371,8 +378,10 @@ def next(self) -> State | None:
         """Next state."""
         test_run = self.test_run
         try:
-            test_suite_class, test_run.remaining_test_cases = test_run.remaining_tests.popleft()
-            test_suite = test_suite_class()
+            test_suite_class, test_config, test_run.remaining_test_cases = (
+                test_run.remaining_tests.popleft()
+            )
+            test_suite = test_suite_class(test_config)
             test_suite_result = test_run.result.add_test_suite(test_suite.name)
 
             if test_run.blocked:
diff --git a/dts/framework/test_suite.py b/dts/framework/test_suite.py
index 58da26adf0..e07c327b77 100644
--- a/dts/framework/test_suite.py
+++ b/dts/framework/test_suite.py
@@ -31,6 +31,7 @@
 from scapy.packet import Packet, Padding, raw
 from typing_extensions import Self
 
+from framework.config.common import FrozenModel
 from framework.testbed_model.capability import TestProtocol
 from framework.testbed_model.topology import Topology
 from framework.testbed_model.traffic_generator.capturing_traffic_generator import (
@@ -46,6 +47,10 @@
     from framework.context import Context
 
 
+class BaseConfig(FrozenModel):
+    """Base for a custom test suite configuration."""
+
+
 class TestSuite(TestProtocol):
     """The base class with building blocks needed by most test cases.
 
@@ -70,8 +75,13 @@ class TestSuite(TestProtocol):
 
     The test suite is aware of the testbed (the SUT and TG) it's running on. From this, it can
     properly choose the IP addresses and other configuration that must be tailored to the testbed.
+
+    Attributes:
+        config: The test suite configuration.
     """
 
+    config: BaseConfig
+
     #: Whether the test suite is blocking. A failure of a blocking test suite
     #: will block the execution of all subsequent test suites in the current test run.
     is_blocking: ClassVar[bool] = False
@@ -82,19 +92,15 @@ class TestSuite(TestProtocol):
     _tg_ip_address_ingress: Union[IPv4Interface, IPv6Interface]
     _tg_ip_address_egress: Union[IPv4Interface, IPv6Interface]
 
-    def __init__(self):
+    def __init__(self, config: BaseConfig):
         """Initialize the test suite testbed information and basic configuration.
 
-        Find links between ports and set up default IP addresses to be used when
-        configuring them.
-
         Args:
-            sut_node: The SUT node where the test suite will run.
-            tg_node: The TG node where the test suite will run.
-            topology: The topology where the test suite will run.
+            config: The test suite configuration.
         """
         from framework.context import get_ctx
 
+        self.config = config
         self._ctx = get_ctx()
         self._logger = get_dts_logger(self.__class__.__name__)
         self._sut_ip_address_ingress = ip_interface("192.168.100.2/24")
@@ -678,6 +684,11 @@ def is_test_suite(obj) -> bool:
             f"Expected class {self.class_name} not found in module {self.module_name}."
         )
 
+    @cached_property
+    def config_obj(self) -> type[BaseConfig]:
+        """A reference to the test suite's configuration class."""
+        return self.class_obj.__annotations__.get("config", BaseConfig)
+
     @classmethod
     def discover_all(
         cls, package_name: str | None = None, module_prefix: str | None = None
diff --git a/dts/tests/TestSuite_hello_world.py b/dts/tests/TestSuite_hello_world.py
index 141f2bc4c9..6c9ecc1177 100644
--- a/dts/tests/TestSuite_hello_world.py
+++ b/dts/tests/TestSuite_hello_world.py
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: BSD-3-Clause
 # Copyright(c) 2024 University of New Hampshire
+# Copyright(c) 2025 Arm Limited
 
 """DPDK Hello World test suite.
 
@@ -8,12 +9,21 @@
 """
 
 from framework.remote_session.testpmd_shell import TestPmdShell
-from framework.test_suite import TestSuite, func_test
+from framework.test_suite import BaseConfig, TestSuite, func_test
+
+
+class Config(BaseConfig):
+    """Example custom configuration."""
+
+    #: The hello world message to print.
+    msg: str = "Hello World!"
 
 
 class TestHelloWorld(TestSuite):
     """Hello World test suite. One test case, which starts and stops a testpmd session."""
 
+    config: Config
+
     @func_test
     def test_hello_world(self) -> None:
         """EAL confidence test.
@@ -25,4 +35,4 @@ def test_hello_world(self) -> None:
         """
         with TestPmdShell() as testpmd:
             testpmd.start()
-        self.log("Hello World!")
+        self.log(self.config.msg)
diff --git a/dts/tests_config.example.yaml b/dts/tests_config.example.yaml
index e69de29bb2..72af9da260 100644
--- a/dts/tests_config.example.yaml
+++ b/dts/tests_config.example.yaml
@@ -0,0 +1,2 @@
+hello_world:
+  msg: A custom hello world to you!
\ No newline at end of file
-- 
2.43.0

