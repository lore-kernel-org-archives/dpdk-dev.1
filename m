Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FBFEC5AD49
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 May 2025 21:30:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F2BD7402DA;
	Wed, 28 May 2025 23:30:04 +0200 (CEST)
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51]) by mails.dpdk.org (Postfix) with ESMTP id 9FFB74003C
 for <dev@dpdk.org>; Wed, 28 May 2025 23:30:02 +0200 (CEST)
Received: by mail-pj1-f51.google.com with SMTP id
 98e67ed59e1d1-310ce23a660so128395a91.1
 for <dev@dpdk.org>; Wed, 28 May 2025 14:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1748467801; x=1749072601; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mPBL5yGMqFvh84Qmxlx2uH/qP8o6WP7lXXbWaijLguo=;
 b=CjAdSNK05dU3JZ7D66+GZffLt/Gs2WW7qBJLl4vx1uYE6nm3vUHHC6QXDDYakg6Bal
 vwwOI2ogPsl3kUNSuYS0V4ubi+LEizrOLw48gcWsDgdO/CF9JX8ZwoWy+iIzhmApMnVb
 qv1vU/yh0+L+fUx81JSFVDB+bexS3U2Xb9VmA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748467801; x=1749072601;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mPBL5yGMqFvh84Qmxlx2uH/qP8o6WP7lXXbWaijLguo=;
 b=OFGxT+KPu1uhQDY7rrJOhfmVf17i+hzp5sjF19Pmwus1oF0N9vvyzJOfn0LUwgBH35
 JINhtVHVC0zcCterjxoVWqYjn8VnM8pa6d7947Y5tQiutao+VfybQ9TU6s937tT12Iz5
 3HPH0v489KNSuXAGBrKvFSRabya3t0XqxG1bTK1nxnASpgnjPBFQo+MbxvuNRmzaa9iv
 L3kpmXI9OLzT5+U53WG0k5NVoBzgo0D2njCvO/lNzWEaccWafKW1gg7czkUSuMUNagIm
 MagQ0bNAaO7ktAHOd0N0ziFBfZaGN8rVdc2ybN+V3ZrgM1FOqNup/+1PH12oGrRTl+mc
 42ig==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2frymei+DJrcIBrafHnZi/IozfSWnfAU0OcRR/uaokpeun7mZ5g2j+zInI5hlC61dwjE=@dpdk.org
X-Gm-Message-State: AOJu0YzP0rdc7zWyfMF1mhazEBB6792aa+jxwBul7srKAlir17LAaXOn
 3I1Y4lTQGlAfaitmki1JvhWxpW8M6lfCICSjyAfDJ+KdyKrsPk1VM96BjCGmc1mQaw3J5z6rcgv
 eNN4QHCiMp/wWs+RNEda+BHkwqVoG4nnVbAO2R8woWA==
X-Gm-Gg: ASbGncuLQaWXauQNwmAEY8BF9U72DOHUFO3wZ/oKFCAmAe8mCJrlmAC6B2M/T6Gw7DO
 H/xu4cJl8FBmuP+/NZpwKYIyY6hG1pEKhJ/4uCyfCWIJ3RZBqJCKizGViil/iJz85g3jRIwuARB
 69kErwvtGl8nLj3L7mo3d0WYKPGZKws0HGJ0tGAATtAqk/D6fXQWi6k0fRDqixPk9Wuw==
X-Google-Smtp-Source: AGHT+IGdJHyiyuXiANkjfZltFrkjssvplDoGyGcHBfjLinDPo2fGE3sGd+ezawai3fIqurKTkYTQgoOZj33UuNDV9dg=
X-Received: by 2002:a17:90b:4c92:b0:311:a561:86f3 with SMTP id
 98e67ed59e1d1-311a5618778mr12040261a91.6.1748467801381; Wed, 28 May 2025
 14:30:01 -0700 (PDT)
MIME-Version: 1.0
References: <20250527153734.368235-1-dmarx@iol.unh.edu>
 <20250527153734.368235-2-dmarx@iol.unh.edu>
In-Reply-To: <20250527153734.368235-2-dmarx@iol.unh.edu>
From: Patrick Robb <probb@iol.unh.edu>
Date: Wed, 28 May 2025 17:25:06 -0400
X-Gm-Features: AX0GCFsbkZMdGw5syp55uU1kR17USFE_f3kZgS7TFuhl5HnBqeUAiZP0_EQi55k
Message-ID: <CAJvnSUCBu7Q2nzqyWyZis3hu1if7MZejKhHU2z8RHwdakpEktQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] dts: rewrite dts rst
To: Dean Marx <dmarx@iol.unh.edu>
Cc: luca.vizzarro@arm.com, yoan.picchi@foss.arm.com, 
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com, dev@dpdk.org
Content-Type: multipart/alternative; boundary="00000000000033f35c063638e2bf"
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

--00000000000033f35c063638e2bf
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 27, 2025 at 11:37=E2=80=AFAM Dean Marx <dmarx@iol.unh.edu> wrot=
e:

> Modify dts.rst to exclude redundant/outdated information about the projec=
t,
> and add new information regarding setup and framework design.
>
> Signed-off-by: Dean Marx <dmarx@iol.unh.edu>
> ---
>  doc/guides/tools/dts.rst | 310 +++++++++++++--------------------------
>  1 file changed, 99 insertions(+), 211 deletions(-)
>
> diff --git a/doc/guides/tools/dts.rst b/doc/guides/tools/dts.rst
> index fcc6d22036..0aa6663b9f 100644
> --- a/doc/guides/tools/dts.rst
> +++ b/doc/guides/tools/dts.rst
> @@ -1,6 +1,7 @@
>  ..  SPDX-License-Identifier: BSD-3-Clause
>      Copyright(c) 2022-2023 PANTHEON.tech s.r.o.
>      Copyright(c) 2024 Arm Limited
> +    Copyright(c) 2025 University of New Hampshire
>
>  DPDK Test Suite
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> @@ -20,31 +21,18 @@ DTS runtime environment
>
>  DTS runtime environment node
>    A node where at least one DTS runtime environment is present.
> -  This is the node where we run DTS and from which DTS connects to other
> nodes.
>

Leave this in.


>
>  System under test
> -  An SUT is the combination of DPDK and the hardware we're testing
> -  in conjunction with DPDK (NICs, crypto and other devices).
> +  Node with DPDK and relevant hardware (NICs, crypto, etc.).
>

Maybe change to "The system which runs a DPDK application on relevant
hardware (NIC, accelerator cards, etc) and from which the DPDK behavior is
observed for tests."


>
>  System under test node
>    A node where at least one SUT is present.
>
>  Traffic generator
> -  A TG is either software or hardware capable of sending packets.
> +  Node that sends traffic; can be hardware or software-based.
>

"Node that sends traffic to the SUT;"

Sorry for being so particular. :)


>  Traffic generator node
>    A node where at least one TG is present.
> -  In case of hardware traffic generators, the TG and the node are
> literally the same.
> -
> -
> -In most cases, interchangeably referring to a runtime environment, SUT,
> TG or the node
> -they're running on (e.g. using SUT and SUT node interchangeably) doesn't
> cause confusion.
> -There could theoretically be more than of these running on the same node
> and in that case
> -it's useful to have stricter definitions.
> -An example would be two different traffic generators (such as Trex and
> Scapy)
> -running on the same node.
> -A different example would be a node containing both a DTS runtime
> environment
> -and a traffic generator, in which case it's both a DTS runtime
> environment node and a TG node.
>
>
>  DTS Environment
> @@ -195,12 +183,28 @@ These need to be set up on a Traffic Generator Node=
:
>  Running DTS
>  -----------
>
> -DTS needs to know which nodes to connect to and what hardware to use on
> those nodes.
> -Once that's configured, either a DPDK source code tarball or tree folder
> -need to be supplied whether these are on your DTS host machine or the SU=
T
> node.
> -DTS can accept a pre-compiled build placed in a subdirectory,
> -or it will compile DPDK on the SUT node,
> -and then run the tests with the newly built binaries.
> +To run DTS, use ``main.py`` with Poetry:
> +
> +.. code-block:: console
> +
> +   ```shell
> +   docker build --target dev -t dpdk-dts .
> +   docker run -v $(pwd)/..:/dpdk -v /home/dtsuser/.ssh:/root/.ssh:ro -it
> dpdk-dts bash
> +   $ poetry install
> +   $ poetry run ./main.py
> +   ```
> +
> +Common options include:
> +
> +- ``--output-dir``: Custom output location.
> +- ``--remote-source``: Use sources stored on the SUT.
> +- ``--tarball``: Specify the tarball to be tested.
> +
> +For a full list:
> +
> +.. code-block:: console
> +
> +   poetry run ./main.py --help
>

I think we should keep the full list of flags here instead of removing it
for this subset. It's a bit of a maintenance burden and it make the file
longer but it's important info. I think it's good to present it here even
if it is only "a --help away."


>
>
>  Configuring DTS
> @@ -220,71 +224,6 @@ The user must have :ref:`administrator privileges
> <sut_admin_user>`
>  which don't require password authentication.
>
>
> -DTS Execution
> -~~~~~~~~~~~~~
> -
> -DTS is run with ``main.py`` located in the ``dts`` directory after
> entering Poetry shell:
> -
> -.. code-block:: console
> -
> -   (dts-py3.10) $ ./main.py --help
> -   usage: main.py [-h] [--test-run-config-file FILE_PATH]
> [--nodes-config-file FILE_PATH] [--tests-config-file FILE_PATH]
> -                  [--output-dir DIR_PATH] [-t SECONDS] [-v] [--dpdk-tree
> DIR_PATH | --tarball FILE_PATH] [--remote-source]
> -                  [--precompiled-build-dir DIR_NAME] [--compile-timeout
> SECONDS] [--test-suite TEST_SUITE [TEST_CASES ...]]
> -                  [--re-run N_TIMES] [--random-seed NUMBER]
> -
> -   Run DPDK test suites. All options may be specified with the
> environment variables provided in brackets. Command line arguments have
> higher
> -   priority.
> -
> -   options:
> -     -h, --help            show this help message and exit
> -     --test-run-config-file FILE_PATH
> -                           [DTS_TEST_RUN_CFG_FILE] The configuration fil=
e
> that describes the test cases and DPDK build options. (default:
> test-run.conf.yaml)
> -     --nodes-config-file FILE_PATH
> -                           [DTS_NODES_CFG_FILE] The configuration file
> that describes the SUT and TG nodes. (default: nodes.conf.yaml)
> -     --tests-config-file FILE_PATH
> -                           [DTS_TESTS_CFG_FILE] Configuration file used
> to override variable values inside specific test suites. (default: None)
> -     --output-dir DIR_PATH, --output DIR_PATH
> -                           [DTS_OUTPUT_DIR] Output directory where DTS
> logs and results are saved. (default: output)
> -     -t SECONDS, --timeout SECONDS
> -                           [DTS_TIMEOUT] The default timeout for all DTS
> operations except for compiling DPDK. (default: 15)
> -     -v, --verbose         [DTS_VERBOSE] Specify to enable verbose
> output, logging all messages to the console. (default: False)
> -     --compile-timeout SECONDS
> -                           [DTS_COMPILE_TIMEOUT] The timeout for
> compiling DPDK. (default: 1200)
> -     --test-suite TEST_SUITE [TEST_CASES ...]
> -                           [DTS_TEST_SUITES] A list containing a test
> suite with test cases. The first parameter is the test suite name, and
> -                           the rest are test case names, which are
> optional. May be specified multiple times. To specify multiple test suite=
s
> -                           in the environment variable, join the lists
> with a comma. Examples: --test-suite suite case case --test-suite
> -                           suite case ... | DTS_TEST_SUITES=3D'suite cas=
e
> case, suite case, ...' | --test-suite suite --test-suite suite case
> -                           ... | DTS_TEST_SUITES=3D'suite, suite case, .=
..'
> (default: [])
> -     --re-run N_TIMES, --re_run N_TIMES
> -                           [DTS_RERUN] Re-run each test case the
> specified number of times if a test failure occurs. (default: 0)
> -     --random-seed NUMBER  [DTS_RANDOM_SEED] The seed to use with the
> pseudo-random generator. If not specified, the configuration value is
> -                           used instead. If that's also not specified, a
> random seed is generated. (default: None)
> -
> -   DPDK Build Options:
> -     Arguments in this group (and subgroup) will be applied to a
> DPDKLocation when the DPDK tree, tarball or revision will be provided,
> -     other arguments like remote source and build dir are optional. A
> DPDKLocation from settings are used instead of from config if
> -     construct successful.
> -
> -     --dpdk-tree DIR_PATH  [DTS_DPDK_TREE] The path to the DPDK source
> tree directory to test. Cannot be used in conjunction with --tarball.
> -                           (default: None)
> -     --tarball FILE_PATH, --snapshot FILE_PATH
> -                           [DTS_DPDK_TARBALL] The path to the DPDK sourc=
e
> tarball to test. DPDK must be contained in a folder with the same
> -                           name as the tarball file. Cannot be used in
> conjunction with --dpdk-tree. (default: None)
> -     --remote-source       [DTS_REMOTE_SOURCE] Set this option if either
> the DPDK source tree or tarball to be used are located on the SUT
> -                           node. Can only be used with --dpdk-tree or
> --tarball. (default: False)
> -     --precompiled-build-dir DIR_NAME
> -                           [DTS_PRECOMPILED_BUILD_DIR] Define the
> subdirectory under the DPDK tree root directory or tarball where the pre-
> -                           compiled binaries are located. (default: None=
)
> -
> -
> -The brackets contain the names of environment variables that set the sam=
e
> thing.
> -The minimum DTS needs is a config file and a pre-built DPDK
> -or DPDK sources location which can be specified in said config file
> -or on the command line or environment variables.
> -
> -
>  DTS Results
>  ~~~~~~~~~~~
>
> @@ -308,140 +247,89 @@ Adding test cases may require adding code to the
> framework as well.
>  Framework Coding Guidelines
>  ~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> -When adding code to the DTS framework, pay attention to the rest of the
> code
> -and try not to divert much from it.
> -The :ref:`DTS developer tools <dts_dev_tools>` will issue warnings
> -when some of the basics are not met.
> -You should also build the :ref:`API documentation <building_api_docs>`
> -to address any issues found during the build.
> -
> -The API documentation, which is a helpful reference when developing, may
> be accessed
> -in the code directly or generated with the :ref:`API docs build steps
> <building_api_docs>`.
> -When adding new files or modifying the directory structure,
> -the corresponding changes must be made to DTS API doc sources in
> ``doc/api/dts``.
> -
> -Speaking of which, the code must be properly documented with docstrings.
> -The style must conform to the `Google style
> -<
> https://google.github.io/styleguide/pyguide.html#38-comments-and-docstrin=
gs
> >`_.
> -See an example of the style `here
> -<
> https://www.sphinx-doc.org/en/master/usage/extensions/example_google.html
> >`_.
> -For cases which are not covered by the Google style, refer to `PEP 257
> -<https://peps.python.org/pep-0257/>`_.
> -There are some cases which are not covered by the two style guides,
> -where we deviate or where some additional clarification is helpful:
> -
> -   * The ``__init__()`` methods of classes are documented separately
> -     from the docstring of the class itself.
> -   * The docstrings of implemented abstract methods should refer to the
> superclass's definition
> -     if there's no deviation.
> -   * Instance variables/attributes should be documented in the docstring
> of the class
> -     in the ``Attributes:`` section.
> -   * The ``dataclass.dataclass`` decorator changes how the attributes ar=
e
> processed.
> -     The dataclass attributes which result in instance
> variables/attributes
> -     should also be recorded in the ``Attributes:`` section.
> -   * Class variables/attributes and Pydantic model fields, on the other
> hand,
> -     should be documented with ``#:`` above the type annotated line.
> -     The description may be omitted if the meaning is obvious.
> -   * The ``Enum`` and ``TypedDict`` also process the attributes in
> particular ways
> -     and should be documented with ``#:`` as well.
> -     This is mainly so that the autogenerated documentation contains the
> assigned value.
> -   * When referencing a parameter of a function or a method in their
> docstring,
> -     don't use any articles and put the parameter into single backticks.
> -     This mimics the style of `Python's documentation <
> https://docs.python.org/3/index.html>`_.
> -   * When specifying a value, use double backticks::
> -
> -        def foo(greet: bool) -> None:
> -            """Demonstration of single and double backticks.
> -
> -            `greet` controls whether ``Hello World`` is printed.
> -
> -            Args:
> -               greet: Whether to print the ``Hello World`` message.
> -            """
> -            if greet:
> -               print(f"Hello World")
> -
> -   * The docstring maximum line length is the same as the code maximum
> line length.
> -
> -
> -How To Write a Test Suite
> --------------------------
> -
> -All test suites inherit from ``TestSuite`` defined in
> ``dts/framework/test_suite.py``.
>

"All test suites are a class which inherits from"


> -There are four types of methods that comprise a test suite:
> -
> -#. **Test cases**
> -
> -   | Test cases are methods that start with a particular prefix.
> -   | Functional test cases start with ``test_``, e.g.
> ``test_hello_world_single_core``.

-   | Performance test cases start with ``test_perf_``, e.g.
> ``test_perf_nic_single_core``.
>

Now decorator based.


> -   | A test suite may have any number of functional and/or performance
> test cases.
> -     However, these test cases must test the same feature,
> -     following the rule of one feature =3D one test suite.
> -     Test cases for one feature don't need to be grouped in just one tes=
t
> suite, though.
> -     If the feature requires many testing scenarios to cover,
> -     the test cases would be better off spread over multiple test suites
> -     so that each test suite doesn't take too long to execute.
> -
> -#. **Setup and Teardown methods**
> -
> -   | There are setup and teardown methods for the whole test suite and
> each individual test case.
> -   | Methods ``set_up_suite`` and ``tear_down_suite`` will be executed
> -     before any and after all test cases have been executed, respectivel=
y.
> -   | Methods ``set_up_test_case`` and ``tear_down_test_case`` will be
> executed
> -     before and after each test case, respectively.
> -   | These methods don't need to be implemented if there's no need for
> them in a test suite.
> -     In that case, nothing will happen when they are executed.
> -
> -#. **Configuration, traffic and other logic**
> -
> -   The ``TestSuite`` class contains a variety of methods for anything th=
at
> -   a test suite setup, a teardown, or a test case may need to do.
> -
> -   The test suites also frequently use a DPDK app, such as testpmd, in
> interactive mode
> -   and use the interactive shell instances directly.
> -
> -   These are the two main ways to call the framework logic in test suite=
s.
> -   If there's any functionality or logic missing from the framework,
> -   it should be implemented so that the test suites can use one of these
> two ways.
> -
> -#. **Test case verification**
> -
> -   Test case verification should be done with the ``verify`` method,
> which records the result.
> -   The method should be called at the end of each test case.
> -
> -#. **Other methods**
>

I see that some of the content under "Other methods" is now false and
should be removed - thanks for doing so. However, I do think there was a
lot of good within the original "Test Cases," "Setup and Teardown Methods,"
and "Configuration, traffic and other logic" which has been removed. For
this one I prefer if we just sit down and hash it out in person when you're
in next week.


> -
> -   Of course, all test suite code should adhere to coding standards.
> -   Only the above methods will be treated specially and any other method=
s
> may be defined
> -   (which should be mostly private methods needed by each particular tes=
t
> suite).
> -   Any specific features (such as NIC configuration) required by a test
> suite
> -   should be implemented in the ``SutNode`` class (and the underlying
> classes that ``SutNode`` uses)
> -   and used by the test suite via the ``sut_node`` field.
> +When contributing code to the DTS framework, follow existing conventions
> to ensure consistency.
> +The :ref:`DTS developer tools <dts_dev_tools>` will flag basic issues.
> +Also, be sure to :ref:`build the API documentation <building_api_docs>`
> to catch any problems during the build.
>
> +The API documentation is a helpful reference during development.
> +It can be viewed in the code directly or generated using the :ref:`API
> docs build steps <building_api_docs>`.
> +If you add new files or change the directory structure, update the
> corresponding sources in ``doc/api/dts``.
>
> -.. _dts_dev_tools:
> +Code must be documented with docstrings that follow the
> +`Google style <
> https://google.github.io/styleguide/pyguide.html#38-comments-and-docstrin=
gs
> >`_.
> +Additional references:
>
> -DTS Developer Tools
> --------------------
> +* `Sphinx Google style example <
> https://www.sphinx-doc.org/en/master/usage/extensions/example_google.html
> >`_
> +* `PEP 257 <https://peps.python.org/pep-0257/>`_
> +
> +Docstring and Attribute Guidelines
>
> -There are two tools used in DTS to help with code checking, style and
> formatting:
> +* Document ``__init__()`` separately from the class docstring.
> +* If an abstract method simply implements a superclass definition withou=
t
> changes, refer to that superclass in the docstring.
> +* Document instance variables in the class docstring under an
> ``Attributes:`` section.
> +* For ``@dataclass`` classes, document instance-level attributes in
> ``Attributes:``, as they are generated from the class fields.
> +* Document class variables and Pydantic fields using ``#:``,
> +   placed above the type-annotated line. Descriptions may be omitted if
> the meaning is clear.
> +* Apply ``#:`` to ``Enum`` and ``TypedDict`` fields as well, so that
> autogenerated documentation includes their values.
> +* When referring to a parameter in a docstring, omit articles and enclos=
e
> the parameter in single backticks (e.g., `` `param` ``),
> +   consistent with the `Python documentation style <
> https://docs.python.org/3/index.html>`_.
> +* Use double backticks (````value````) for literal values.
>
> -* `ruff <https://astral.sh/ruff/>`_
> +Example::
>
> -  An extremely fast all-in-one linting and formatting solution,
> -  which covers most if not all the major rules such as:
> -  pylama, flake8, pylint etc.
> -  Its built-in formatter is also Black-compatible
> -  and is able to sort imports automatically like isort would.
> +   def foo(greet: bool) -> None:
> +       """Demonstrates single vs. double backticks.
>
> -* `mypy <https://github.com/python/mypy>`_
> +       `greet` controls whether ``Hello World`` is printed.
>
> -  Enables static typing for Python, exploiting the type hints in the
> source code.
> +       Args:
> +           greet: Whether to print the ``Hello World`` message.
> +       """
> +       if greet:
> +           print("Hello World")
> +
> +The maximum line length for docstrings must match that of the code.
> +
> +
> +Creating a Test Suite
> +---------------------
> +
> +All test suites inherit from ``TestSuite`` in
> ``dts/framework/test_suite.py``. A typical suite contains:
> +
> +- Test Cases
> +  - Functional: start with ``test_``, e.g., ``test_basic_link``
> +  - Performance: start with ``test_perf_``, e.g.,
> ``test_perf_throughput``


I realize you go on to describe the decorators after this, but I think the
test_func and test_perf naming convention is no longer required. Example:

    @requires(NicCapability.FLOW_CTRL)
    @func_test
    def flow_ctrl_port_configuration_persistence(self) -> None:
        """Flow control port configuration persistency test.

        Steps:
            For each port enable flow control for RX and TX individually.
        Verify:
            The configuration persists after the port is restarted.
        """



> +  - Import the ``func_test`` and/or ``perf_test`` decorators from
> ``TestSuite`` and add them above each test case method,
> +   e.g., ``@func_test`` followed by ``test_basic_link``
> +
> +- Setup/Teardown Hooks
> +  - Suite-level: ``set_up_suite()``, ``tear_down_suite()``
> +  - Case-level: ``set_up_test_case()``, ``tear_down_test_case()``
> +
> +- Verification
> +  Use ``self.verify(condition, message)`` to record test results.
>

I think the important part of "verify" to explain to people is that you are
setting the testcase assertion condition, not the recording aspect.


> +
> +- Support Methods
> +  Helper logic (e.g., traffic handling, config) should be in private
> methods or delegated to ``sut_node``.
>

I realize this is just a rewording that crept in, but this is wrong for a
couple reasons:

1. We no longer import node/sutnode when writing testsuites. Node is purely
framework code now, and is not exposed to testsuites.
2. sut_node (and tg_node) no longer exists.


> +
> +
> +.. _dts_dev_tools:
> +
> +Developer Tools
> +---------------
> +
> +- ruff
> +  - Linter and formatter (replaces flake8, pylint, isort, etc.)
> +  - Compatible with Black
> +
> +- mypy
> +  - Performs static type checking
> +
> +Run checks using:
> +
> +.. code-block:: console
>
> -These two tools are all used in ``devtools/dts-check-format.sh``,
> -the DTS code check and format script.
> -Refer to the script for usage: ``devtools/dts-check-format.sh -h``.
> +   devtools/dts-check-format.sh
>
>
>  .. _building_api_docs:
> --
> 2.49.0
>
>
Lots of improvements overall - keep up the good work! A productive Summer
ahead.

Reviewed-by: Patrick Robb <probb@iol.unh.edu>

--00000000000033f35c063638e2bf
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, May 27, 2025=
 at 11:37=E2=80=AFAM Dean Marx &lt;<a href=3D"mailto:dmarx@iol.unh.edu" tar=
get=3D"_blank">dmarx@iol.unh.edu</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">Modify dts.rst to exclude redundant/outdat=
ed information about the project,<br>
and add new information regarding setup and framework design.<br>
<br>
Signed-off-by: Dean Marx &lt;<a href=3D"mailto:dmarx@iol.unh.edu" target=3D=
"_blank">dmarx@iol.unh.edu</a>&gt;<br>
---<br>
=C2=A0doc/guides/tools/dts.rst | 310 +++++++++++++-------------------------=
-<br>
=C2=A01 file changed, 99 insertions(+), 211 deletions(-)<br>
<br>
diff --git a/doc/guides/tools/dts.rst b/doc/guides/tools/dts.rst<br>
index fcc6d22036..0aa6663b9f 100644<br>
--- a/doc/guides/tools/dts.rst<br>
+++ b/doc/guides/tools/dts.rst<br>
@@ -1,6 +1,7 @@<br>
=C2=A0..=C2=A0 SPDX-License-Identifier: BSD-3-Clause<br>
=C2=A0 =C2=A0 =C2=A0Copyright(c) 2022-2023 PANTHEON.tech s.r.o.<br>
=C2=A0 =C2=A0 =C2=A0Copyright(c) 2024 Arm Limited<br>
+=C2=A0 =C2=A0 Copyright(c) 2025 University of New Hampshire<br>
<br>
=C2=A0DPDK Test Suite<br>
=C2=A0=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
@@ -20,31 +21,18 @@ DTS runtime environment<br>
<br>
=C2=A0DTS runtime environment node<br>
=C2=A0 =C2=A0A node where at least one DTS runtime environment is present.<=
br>
-=C2=A0 This is the node where we run DTS and from which DTS connects to ot=
her nodes.<br></blockquote><div><br></div><div>Leave this in.</div><div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
=C2=A0System under test<br>
-=C2=A0 An SUT is the combination of DPDK and the hardware we&#39;re testin=
g<br>
-=C2=A0 in conjunction with DPDK (NICs, crypto and other devices).<br>
+=C2=A0 Node with DPDK and relevant hardware (NICs, crypto, etc.).<br></blo=
ckquote><div><br></div><div>Maybe change to &quot;The system which runs a D=
PDK application on relevant hardware (NIC, accelerator cards, etc) and from=
 which the DPDK behavior is observed for tests.&quot;</div><div>=C2=A0</div=
><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border=
-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
=C2=A0System under test node<br>
=C2=A0 =C2=A0A node where at least one SUT is present.<br>
<br>
=C2=A0Traffic generator<br>
-=C2=A0 A TG is either software or hardware capable of sending packets.<br>
+=C2=A0 Node that sends traffic; can be hardware or software-based.<br></bl=
ockquote><div><br></div><div>&quot;Node that sends traffic to the SUT;&quot=
;</div><div>=C2=A0</div><div>Sorry for being so particular. :)</div><div><b=
r></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex=
;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
=C2=A0Traffic generator node<br>
=C2=A0 =C2=A0A node where at least one TG is present.<br>
-=C2=A0 In case of hardware traffic generators, the TG and the node are lit=
erally the same.<br>
-<br>
-<br>
-In most cases, interchangeably referring to a runtime environment, SUT, TG=
 or the node<br>
-they&#39;re running on (e.g. using SUT and SUT node interchangeably) doesn=
&#39;t cause confusion.<br>
-There could theoretically be more than of these running on the same node a=
nd in that case<br>
-it&#39;s useful to have stricter definitions.<br>
-An example would be two different traffic generators (such as Trex and Sca=
py)<br>
-running on the same node.<br>
-A different example would be a node containing both a DTS runtime environm=
ent<br>
-and a traffic generator, in which case it&#39;s both a DTS runtime environ=
ment node and a TG node.<br>
<br>
<br>
=C2=A0DTS Environment<br>
@@ -195,12 +183,28 @@ These need to be set up on a Traffic Generator Node:<=
br>
=C2=A0Running DTS<br>
=C2=A0-----------<br>
<br>
-DTS needs to know which nodes to connect to and what hardware to use on th=
ose nodes.<br>
-Once that&#39;s configured, either a DPDK source code tarball or tree fold=
er<br>
-need to be supplied whether these are on your DTS host machine or the SUT =
node.<br>
-DTS can accept a pre-compiled build placed in a subdirectory,<br>
-or it will compile DPDK on the SUT node,<br>
-and then run the tests with the newly built binaries.<br>
+To run DTS, use ``main.py`` with Poetry:<br>
+<br>
+.. code-block:: console<br>
+<br>
+=C2=A0 =C2=A0```shell<br>
+=C2=A0 =C2=A0docker build --target dev -t dpdk-dts .<br>
+=C2=A0 =C2=A0docker run -v $(pwd)/..:/dpdk -v /home/dtsuser/.ssh:/root/.ss=
h:ro -it dpdk-dts bash<br>
+=C2=A0 =C2=A0$ poetry install<br>
+=C2=A0 =C2=A0$ poetry run ./main.py<br>
+=C2=A0 =C2=A0```<br>
+<br>
+Common options include:<br>
+<br>
+- ``--output-dir``: Custom output location.<br>
+- ``--remote-source``: Use sources stored on the SUT.<br>
+- ``--tarball``: Specify the tarball to be tested.<br>
+<br>
+For a full list:<br>
+<br>
+.. code-block:: console<br>
+<br>
+=C2=A0 =C2=A0poetry run ./main.py --help<br></blockquote><div><br></div><d=
iv>I think we should keep the full list of flags here instead of removing i=
t for this subset. It&#39;s a bit of a maintenance burden and it make the f=
ile longer but it&#39;s important info. I think it&#39;s good to present it=
 here even if it is only &quot;a --help away.&quot;</div><div>=C2=A0</div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">
<br>
<br>
=C2=A0Configuring DTS<br>
@@ -220,71 +224,6 @@ The user must have :ref:`administrator privileges &lt;=
sut_admin_user&gt;`<br>
=C2=A0which don&#39;t require password authentication.<br>
<br>
<br>
-DTS Execution<br>
-~~~~~~~~~~~~~<br>
-<br>
-DTS is run with ``main.py`` located in the ``dts`` directory after enterin=
g Poetry shell:<br>
-<br>
-.. code-block:: console<br>
-<br>
-=C2=A0 =C2=A0(dts-py3.10) $ ./main.py --help<br>
-=C2=A0 =C2=A0usage: main.py [-h] [--test-run-config-file FILE_PATH] [--nod=
es-config-file FILE_PATH] [--tests-config-file FILE_PATH]<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [--output-d=
ir DIR_PATH] [-t SECONDS] [-v] [--dpdk-tree DIR_PATH | --tarball FILE_PATH]=
 [--remote-source]<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [--precompi=
led-build-dir DIR_NAME] [--compile-timeout SECONDS] [--test-suite TEST_SUIT=
E [TEST_CASES ...]]<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [--re-run N=
_TIMES] [--random-seed NUMBER]<br>
-<br>
-=C2=A0 =C2=A0Run DPDK test suites. All options may be specified with the e=
nvironment variables provided in brackets. Command line arguments have high=
er<br>
-=C2=A0 =C2=A0priority.<br>
-<br>
-=C2=A0 =C2=A0options:<br>
-=C2=A0 =C2=A0 =C2=A0-h, --help=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sh=
ow this help message and exit<br>
-=C2=A0 =C2=A0 =C2=A0--test-run-config-file FILE_PATH<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0[DTS_TEST_RUN_CFG_FILE] The configuration file that=
 describes the test cases and DPDK build options. (default: test-run.conf.y=
aml)<br>
-=C2=A0 =C2=A0 =C2=A0--nodes-config-file FILE_PATH<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0[DTS_NODES_CFG_FILE] The configuration file that de=
scribes the SUT and TG nodes. (default: nodes.conf.yaml)<br>
-=C2=A0 =C2=A0 =C2=A0--tests-config-file FILE_PATH<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0[DTS_TESTS_CFG_FILE] Configuration file used to ove=
rride variable values inside specific test suites. (default: None)<br>
-=C2=A0 =C2=A0 =C2=A0--output-dir DIR_PATH, --output DIR_PATH<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0[DTS_OUTPUT_DIR] Output directory where DTS logs an=
d results are saved. (default: output)<br>
-=C2=A0 =C2=A0 =C2=A0-t SECONDS, --timeout SECONDS<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0[DTS_TIMEOUT] The default timeout for all DTS opera=
tions except for compiling DPDK. (default: 15)<br>
-=C2=A0 =C2=A0 =C2=A0-v, --verbose=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[DTS_VE=
RBOSE] Specify to enable verbose output, logging all messages to the consol=
e. (default: False)<br>
-=C2=A0 =C2=A0 =C2=A0--compile-timeout SECONDS<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0[DTS_COMPILE_TIMEOUT] The timeout for compiling DPD=
K. (default: 1200)<br>
-=C2=A0 =C2=A0 =C2=A0--test-suite TEST_SUITE [TEST_CASES ...]<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0[DTS_TEST_SUITES] A list containing a test suite wi=
th test cases. The first parameter is the test suite name, and<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0the rest are test case names, which are optional. M=
ay be specified multiple times. To specify multiple test suites<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0in the environment variable, join the lists with a =
comma. Examples: --test-suite suite case case --test-suite<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0suite case ... | DTS_TEST_SUITES=3D&#39;suite case =
case, suite case, ...&#39; | --test-suite suite --test-suite suite case<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0... | DTS_TEST_SUITES=3D&#39;suite, suite case, ...=
&#39; (default: [])<br>
-=C2=A0 =C2=A0 =C2=A0--re-run N_TIMES, --re_run N_TIMES<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0[DTS_RERUN] Re-run each test case the specified num=
ber of times if a test failure occurs. (default: 0)<br>
-=C2=A0 =C2=A0 =C2=A0--random-seed NUMBER=C2=A0 [DTS_RANDOM_SEED] The seed =
to use with the pseudo-random generator. If not specified, the configuratio=
n value is<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0used instead. If that&#39;s also not specified, a r=
andom seed is generated. (default: None)<br>
-<br>
-=C2=A0 =C2=A0DPDK Build Options:<br>
-=C2=A0 =C2=A0 =C2=A0Arguments in this group (and subgroup) will be applied=
 to a DPDKLocation when the DPDK tree, tarball or revision will be provided=
,<br>
-=C2=A0 =C2=A0 =C2=A0other arguments like remote source and build dir are o=
ptional. A DPDKLocation from settings are used instead of from config if<br=
>
-=C2=A0 =C2=A0 =C2=A0construct successful.<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0--dpdk-tree DIR_PATH=C2=A0 [DTS_DPDK_TREE] The path to=
 the DPDK source tree directory to test. Cannot be used in conjunction with=
 --tarball.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0(default: None)<br>
-=C2=A0 =C2=A0 =C2=A0--tarball FILE_PATH, --snapshot FILE_PATH<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0[DTS_DPDK_TARBALL] The path to the DPDK source tarb=
all to test. DPDK must be contained in a folder with the same<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0name as the tarball file. Cannot be used in conjunc=
tion with --dpdk-tree. (default: None)<br>
-=C2=A0 =C2=A0 =C2=A0--remote-source=C2=A0 =C2=A0 =C2=A0 =C2=A0[DTS_REMOTE_=
SOURCE] Set this option if either the DPDK source tree or tarball to be use=
d are located on the SUT<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0node. Can only be used with --dpdk-tree or --tarbal=
l. (default: False)<br>
-=C2=A0 =C2=A0 =C2=A0--precompiled-build-dir DIR_NAME<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0[DTS_PRECOMPILED_BUILD_DIR] Define the subdirectory=
 under the DPDK tree root directory or tarball where the pre-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0compiled binaries are located. (default: None)<br>
-<br>
-<br>
-The brackets contain the names of environment variables that set the same =
thing.<br>
-The minimum DTS needs is a config file and a pre-built DPDK<br>
-or DPDK sources location which can be specified in said config file<br>
-or on the command line or environment variables.<br>
-<br>
-<br>
=C2=A0DTS Results<br>
=C2=A0~~~~~~~~~~~<br>
<br>
@@ -308,140 +247,89 @@ Adding test cases may require adding code to the fra=
mework as well.<br>
=C2=A0Framework Coding Guidelines<br>
=C2=A0~~~~~~~~~~~~~~~~~~~~~~~~~~~<br>
<br>
-When adding code to the DTS framework, pay attention to the rest of the co=
de<br>
-and try not to divert much from it.<br>
-The :ref:`DTS developer tools &lt;dts_dev_tools&gt;` will issue warnings<b=
r>
-when some of the basics are not met.<br>
-You should also build the :ref:`API documentation &lt;building_api_docs&gt=
;`<br>
-to address any issues found during the build.<br>
-<br>
-The API documentation, which is a helpful reference when developing, may b=
e accessed<br>
-in the code directly or generated with the :ref:`API docs build steps &lt;=
building_api_docs&gt;`.<br>
-When adding new files or modifying the directory structure,<br>
-the corresponding changes must be made to DTS API doc sources in ``doc/api=
/dts``.<br>
-<br>
-Speaking of which, the code must be properly documented with docstrings.<b=
r>
-The style must conform to the `Google style<br>
-&lt;<a href=3D"https://google.github.io/styleguide/pyguide.html#38-comment=
s-and-docstrings" rel=3D"noreferrer" target=3D"_blank">https://google.githu=
b.io/styleguide/pyguide.html#38-comments-and-docstrings</a>&gt;`_.<br>
-See an example of the style `here<br>
-&lt;<a href=3D"https://www.sphinx-doc.org/en/master/usage/extensions/examp=
le_google.html" rel=3D"noreferrer" target=3D"_blank">https://www.sphinx-doc=
.org/en/master/usage/extensions/example_google.html</a>&gt;`_.<br>
-For cases which are not covered by the Google style, refer to `PEP 257<br>
-&lt;<a href=3D"https://peps.python.org/pep-0257/" rel=3D"noreferrer" targe=
t=3D"_blank">https://peps.python.org/pep-0257/</a>&gt;`_.<br>
-There are some cases which are not covered by the two style guides,<br>
-where we deviate or where some additional clarification is helpful:<br>
-<br>
-=C2=A0 =C2=A0* The ``__init__()`` methods of classes are documented separa=
tely<br>
-=C2=A0 =C2=A0 =C2=A0from the docstring of the class itself.<br>
-=C2=A0 =C2=A0* The docstrings of implemented abstract methods should refer=
 to the superclass&#39;s definition<br>
-=C2=A0 =C2=A0 =C2=A0if there&#39;s no deviation.<br>
-=C2=A0 =C2=A0* Instance variables/attributes should be documented in the d=
ocstring of the class<br>
-=C2=A0 =C2=A0 =C2=A0in the ``Attributes:`` section.<br>
-=C2=A0 =C2=A0* The ``dataclass.dataclass`` decorator changes how the attri=
butes are processed.<br>
-=C2=A0 =C2=A0 =C2=A0The dataclass attributes which result in instance vari=
ables/attributes<br>
-=C2=A0 =C2=A0 =C2=A0should also be recorded in the ``Attributes:`` section=
.<br>
-=C2=A0 =C2=A0* Class variables/attributes and Pydantic model fields, on th=
e other hand,<br>
-=C2=A0 =C2=A0 =C2=A0should be documented with ``#:`` above the type annota=
ted line.<br>
-=C2=A0 =C2=A0 =C2=A0The description may be omitted if the meaning is obvio=
us.<br>
-=C2=A0 =C2=A0* The ``Enum`` and ``TypedDict`` also process the attributes =
in particular ways<br>
-=C2=A0 =C2=A0 =C2=A0and should be documented with ``#:`` as well.<br>
-=C2=A0 =C2=A0 =C2=A0This is mainly so that the autogenerated documentation=
 contains the assigned value.<br>
-=C2=A0 =C2=A0* When referencing a parameter of a function or a method in t=
heir docstring,<br>
-=C2=A0 =C2=A0 =C2=A0don&#39;t use any articles and put the parameter into =
single backticks.<br>
-=C2=A0 =C2=A0 =C2=A0This mimics the style of `Python&#39;s documentation &=
lt;<a href=3D"https://docs.python.org/3/index.html" rel=3D"noreferrer" targ=
et=3D"_blank">https://docs.python.org/3/index.html</a>&gt;`_.<br>
-=C2=A0 =C2=A0* When specifying a value, use double backticks::<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 def foo(greet: bool) -&gt; None:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Demonstration =
of single and double backticks.<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 `greet` controls whether ``Hello=
 World`` is printed.<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0greet: Whether to p=
rint the ``Hello World`` message.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if greet:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0print(f&quot;Hello =
World&quot;)<br>
-<br>
-=C2=A0 =C2=A0* The docstring maximum line length is the same as the code m=
aximum line length.<br>
-<br>
-<br>
-How To Write a Test Suite<br>
--------------------------<br>
-<br>
-All test suites inherit from ``TestSuite`` defined in ``dts/framework/test=
_suite.py``.<br></blockquote><div><br></div><div>&quot;All test suites are =
a class which inherits from&quot;</div><div>=C2=A0</div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
-There are four types of methods that comprise a test suite:<br>
-<br>
-#. **Test cases**<br>
-<br>
-=C2=A0 =C2=A0| Test cases are methods that start with a particular prefix.=
<br>
-=C2=A0 =C2=A0| Functional test cases start with ``test_``, e.g. ``test_hel=
lo_world_single_core``.</blockquote><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
-=C2=A0 =C2=A0| Performance test cases start with ``test_perf_``, e.g. ``te=
st_perf_nic_single_core``.<br></blockquote><div><br></div><div><div>Now dec=
orator based.</div></div><div>=C2=A0</div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex">
-=C2=A0 =C2=A0| A test suite may have any number of functional and/or perfo=
rmance test cases.<br>
-=C2=A0 =C2=A0 =C2=A0However, these test cases must test the same feature,<=
br>
-=C2=A0 =C2=A0 =C2=A0following the rule of one feature =3D one test suite.<=
br>
-=C2=A0 =C2=A0 =C2=A0Test cases for one feature don&#39;t need to be groupe=
d in just one test suite, though.<br>
-=C2=A0 =C2=A0 =C2=A0If the feature requires many testing scenarios to cove=
r,<br>
-=C2=A0 =C2=A0 =C2=A0the test cases would be better off spread over multipl=
e test suites<br>
-=C2=A0 =C2=A0 =C2=A0so that each test suite doesn&#39;t take too long to e=
xecute.<br>
-<br>
-#. **Setup and Teardown methods**<br>
-<br>
-=C2=A0 =C2=A0| There are setup and teardown methods for the whole test sui=
te and each individual test case.<br>
-=C2=A0 =C2=A0| Methods ``set_up_suite`` and ``tear_down_suite`` will be ex=
ecuted<br>
-=C2=A0 =C2=A0 =C2=A0before any and after all test cases have been executed=
, respectively.<br>
-=C2=A0 =C2=A0| Methods ``set_up_test_case`` and ``tear_down_test_case`` wi=
ll be executed<br>
-=C2=A0 =C2=A0 =C2=A0before and after each test case, respectively.<br>
-=C2=A0 =C2=A0| These methods don&#39;t need to be implemented if there&#39=
;s no need for them in a test suite.<br>
-=C2=A0 =C2=A0 =C2=A0In that case, nothing will happen when they are execut=
ed.<br>
-<br>
-#. **Configuration, traffic and other logic**<br>
-<br>
-=C2=A0 =C2=A0The ``TestSuite`` class contains a variety of methods for any=
thing that<br>
-=C2=A0 =C2=A0a test suite setup, a teardown, or a test case may need to do=
.<br>
-<br>
-=C2=A0 =C2=A0The test suites also frequently use a DPDK app, such as testp=
md, in interactive mode<br>
-=C2=A0 =C2=A0and use the interactive shell instances directly.<br>
-<br>
-=C2=A0 =C2=A0These are the two main ways to call the framework logic in te=
st suites.<br>
-=C2=A0 =C2=A0If there&#39;s any functionality or logic missing from the fr=
amework,<br>
-=C2=A0 =C2=A0it should be implemented so that the test suites can use one =
of these two ways.<br>
-<br>
-#. **Test case verification**<br>
-<br>
-=C2=A0 =C2=A0Test case verification should be done with the ``verify`` met=
hod, which records the result.<br>
-=C2=A0 =C2=A0The method should be called at the end of each test case.<br>
-<br>
-#. **Other methods**<br></blockquote><div><br></div><div>I see that some o=
f the content under &quot;Other methods&quot; is now false and should be re=
moved - thanks for doing so. However, I do think there was a lot of good wi=
thin the original &quot;Test Cases,&quot; &quot;Setup and Teardown Methods,=
&quot; and &quot;Configuration, traffic and other logic&quot; which has bee=
n removed. For this one I prefer if we just sit down and hash it out in per=
son when you&#39;re in next week.</div><div>=C2=A0</div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
-<br>
-=C2=A0 =C2=A0Of course, all test suite code should adhere to coding standa=
rds.<br>
-=C2=A0 =C2=A0Only the above methods will be treated specially and any othe=
r methods may be defined<br>
-=C2=A0 =C2=A0(which should be mostly private methods needed by each partic=
ular test suite).<br>
-=C2=A0 =C2=A0Any specific features (such as NIC configuration) required by=
 a test suite<br>
-=C2=A0 =C2=A0should be implemented in the ``SutNode`` class (and the under=
lying classes that ``SutNode`` uses)<br>
-=C2=A0 =C2=A0and used by the test suite via the ``sut_node`` field.<br>
+When contributing code to the DTS framework, follow existing conventions t=
o ensure consistency.<br>
+The :ref:`DTS developer tools &lt;dts_dev_tools&gt;` will flag basic issue=
s.<br>
+Also, be sure to :ref:`build the API documentation &lt;building_api_docs&g=
t;` to catch any problems during the build.<br>
<br>
+The API documentation is a helpful reference during development.<br>
+It can be viewed in the code directly or generated using the :ref:`API doc=
s build steps &lt;building_api_docs&gt;`.<br>
+If you add new files or change the directory structure, update the corresp=
onding sources in ``doc/api/dts``.<br>
<br>
-.. _dts_dev_tools:<br>
+Code must be documented with docstrings that follow the<br>
+`Google style &lt;<a href=3D"https://google.github.io/styleguide/pyguide.h=
tml#38-comments-and-docstrings" rel=3D"noreferrer" target=3D"_blank">https:=
//google.github.io/styleguide/pyguide.html#38-comments-and-docstrings</a>&g=
t;`_.<br>
+Additional references:<br>
<br>
-DTS Developer Tools<br>
--------------------<br>
+* `Sphinx Google style example &lt;<a href=3D"https://www.sphinx-doc.org/e=
n/master/usage/extensions/example_google.html" rel=3D"noreferrer" target=3D=
"_blank">https://www.sphinx-doc.org/en/master/usage/extensions/example_goog=
le.html</a>&gt;`_<br>
+* `PEP 257 &lt;<a href=3D"https://peps.python.org/pep-0257/" rel=3D"norefe=
rrer" target=3D"_blank">https://peps.python.org/pep-0257/</a>&gt;`_<br>
+<br>
+Docstring and Attribute Guidelines<br>
<br>
-There are two tools used in DTS to help with code checking, style and form=
atting:<br>
+* Document ``__init__()`` separately from the class docstring.<br>
+* If an abstract method simply implements a superclass definition without =
changes, refer to that superclass in the docstring.<br>
+* Document instance variables in the class docstring under an ``Attributes=
:`` section.<br>
+* For ``@dataclass`` classes, document instance-level attributes in ``Attr=
ibutes:``, as they are generated from the class fields.<br>
+* Document class variables and Pydantic fields using ``#:``, <br>
+=C2=A0 =C2=A0placed above the type-annotated line. Descriptions may be omi=
tted if the meaning is clear.<br>
+* Apply ``#:`` to ``Enum`` and ``TypedDict`` fields as well, so that autog=
enerated documentation includes their values.<br>
+* When referring to a parameter in a docstring, omit articles and enclose =
the parameter in single backticks (e.g., `` `param` ``),<br>
+=C2=A0 =C2=A0consistent with the `Python documentation style &lt;<a href=
=3D"https://docs.python.org/3/index.html" rel=3D"noreferrer" target=3D"_bla=
nk">https://docs.python.org/3/index.html</a>&gt;`_.<br>
+* Use double backticks (````value````) for literal values.<br>
<br>
-* `ruff &lt;<a href=3D"https://astral.sh/ruff/" rel=3D"noreferrer" target=
=3D"_blank">https://astral.sh/ruff/</a>&gt;`_<br>
+Example::<br>
<br>
-=C2=A0 An extremely fast all-in-one linting and formatting solution,<br>
-=C2=A0 which covers most if not all the major rules such as:<br>
-=C2=A0 pylama, flake8, pylint etc.<br>
-=C2=A0 Its built-in formatter is also Black-compatible<br>
-=C2=A0 and is able to sort imports automatically like isort would.<br>
+=C2=A0 =C2=A0def foo(greet: bool) -&gt; None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Demonstrates single vs. doubl=
e backticks.<br>
<br>
-* `mypy &lt;<a href=3D"https://github.com/python/mypy" rel=3D"noreferrer" =
target=3D"_blank">https://github.com/python/mypy</a>&gt;`_<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0`greet` controls whether ``Hello World`` is pri=
nted.<br>
<br>
-=C2=A0 Enables static typing for Python, exploiting the type hints in the =
source code.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0Args:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0greet: Whether to print the ``Hel=
lo World`` message.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if greet:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0print(&quot;Hello World&quot;)<br=
>
+<br>
+The maximum line length for docstrings must match that of the code.<br>
+<br>
+<br>
+Creating a Test Suite<br>
+---------------------<br>
+<br>
+All test suites inherit from ``TestSuite`` in ``dts/framework/test_suite.p=
y``. A typical suite contains:<br>
+<br>
+- Test Cases=C2=A0 <br>
+=C2=A0 - Functional: start with ``test_``, e.g., ``test_basic_link``=C2=A0=
 <br>
+=C2=A0 - Performance: start with ``test_perf_``, e.g., ``test_perf_through=
put``=C2=A0</blockquote><div><br></div><div>I realize you go on to describe=
 the decorators after this, but I think the test_func and test_perf naming =
convention is no longer required. Example:=C2=A0</div><div><br></div><div>=
=C2=A0 =C2=A0 @requires(NicCapability.FLOW_CTRL)<br>=C2=A0 =C2=A0 @func_tes=
t<br>=C2=A0 =C2=A0 def flow_ctrl_port_configuration_persistence(self) -&gt;=
 None:<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Flow control port c=
onfiguration persistency test.<br><br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 Steps:<br=
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 For each port enable flow contro=
l for RX and TX individually.<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 Verify:<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 The configuration persists after the=
 port is restarted.<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;</div>=
<div><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex">
+=C2=A0 - Import the ``func_test`` and/or ``perf_test`` decorators from ``T=
estSuite`` and add them above each test case method,<br>
+=C2=A0 =C2=A0e.g., ``@func_test`` followed by ``test_basic_link``<br>
+<br>
+- Setup/Teardown Hooks<br>
+=C2=A0 - Suite-level: ``set_up_suite()``, ``tear_down_suite()``<br>
+=C2=A0 - Case-level: ``set_up_test_case()``, ``tear_down_test_case()``<br>
+<br>
+- Verification=C2=A0 <br>
+=C2=A0 Use ``self.verify(condition, message)`` to record test results.<br>=
</blockquote><div><br></div><div>I think the important part of &quot;verify=
&quot; to=C2=A0explain to people is that you are setting the testcase asser=
tion condition, not the recording aspect.</div><div>=C2=A0</div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex">
+<br>
+- Support Methods<br>
+=C2=A0 Helper logic (e.g., traffic handling, config) should be in private =
methods or delegated to ``sut_node``.<br></blockquote><div><br></div><div>I=
 realize this is just a rewording that crept in, but this is wrong for a co=
uple reasons:</div><div><br></div><div>1. We no longer import node/sutnode=
=C2=A0when writing testsuites. Node is=C2=A0purely framework code now, and =
is not exposed to testsuites.</div><div>2. sut_node (and tg_node) no longer=
 exists.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">
+<br>
+<br>
+.. _dts_dev_tools:<br>
+<br>
+Developer Tools<br>
+---------------<br>
+<br>
+- ruff=C2=A0 <br>
+=C2=A0 - Linter and formatter (replaces flake8, pylint, isort, etc.)<br>
+=C2=A0 - Compatible with Black<br>
+<br>
+- mypy=C2=A0 <br>
+=C2=A0 - Performs static type checking<br>
+<br>
+Run checks using:<br>
+<br>
+.. code-block:: console<br>
<br>
-These two tools are all used in ``devtools/dts-check-format.sh``,<br>
-the DTS code check and format script.<br>
-Refer to the script for usage: ``devtools/dts-check-format.sh -h``.<br>
+=C2=A0 =C2=A0devtools/dts-check-format.sh<br>
<br>
<br>
=C2=A0.. _building_api_docs:<br>
-- <br>
2.49.0<br>
<br></blockquote><div><br></div><div>Lots of improvements overall - keep up=
 the good work! A productive Summer ahead.=C2=A0</div><div><br></div><div>R=
eviewed-by: Patrick Robb &lt;<a href=3D"mailto:probb@iol.unh.edu">probb@iol=
.unh.edu</a>&gt;</div><div>=C2=A0</div></div></div>
</div>

--00000000000033f35c063638e2bf--
