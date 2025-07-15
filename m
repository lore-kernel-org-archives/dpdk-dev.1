Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14F01C83F17
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Jul 2025 22:31:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CFCBC4021E;
	Wed, 16 Jul 2025 00:31:53 +0200 (CEST)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by mails.dpdk.org (Postfix) with ESMTP id 241274013F
 for <dev@dpdk.org>; Wed, 16 Jul 2025 00:31:52 +0200 (CEST)
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-23dea2e01e4so67458885ad.1
 for <dev@dpdk.org>; Tue, 15 Jul 2025 15:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1752618711; x=1753223511; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZNQvELRFuDHhq28yt9UJwuzJQk9WbVkmQ4oVjbfpHnY=;
 b=SLa2iY0qPPQwxbAMx2ZZ8Ikd+yWmPsq9o8r+TXz4wJJzE9+x/JvTgc9jijRzgCp1nb
 VoWcgNryfFHaQ7OadoUQF2tbXgcyefH5ZRIuZ7flgUxGyE9HaDVSgL15Mv+OGGMxDNRk
 DMLVPozDsv55yRmULQi2lyuzFy76POmN5ndyo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752618711; x=1753223511;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZNQvELRFuDHhq28yt9UJwuzJQk9WbVkmQ4oVjbfpHnY=;
 b=UBPmwW0hetv4O3SQXFpfzI+RvwIMIzwCV8QqSoFAzQHHJ7DxkptoFCdkxgzIWssL+d
 T5FQ7aPLaHNgVemDPOiEOVCncGJHrl6vTW4BZCHw6oj4F49qGPKLm720djtSZpJBMw5e
 ieSoyjJyPsdAOPv4vjwpwUVf5JXGfy5mb6mOn005N/3qxegjc4oBXOFs4PWeH2i1TMea
 9VU+GvlRzK95k81qA7cXg6iLOYlVZPBEIGzTNbaK5YyfUI+RBeChVF/aSHzGkXIxxWnV
 +PEG6DYUo5wEgUmKh/uSXfXche985gy2cjjmTi5TUOWeErHaQ98YgTdpMvQIwVrAjWPW
 BOWA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXMUNzRLPzQvQOA8QIzsYSN3OVVn+I0v5HSTELAKxKNb5yc7mMdFLF4WbU7R6hAu3I5oJs=@dpdk.org
X-Gm-Message-State: AOJu0Yzn47EiOTs2Hpg8yPT8mhJv79iClsyHpgRjqDCxrVuH72r7X5zU
 eqQ/QpCNfeRGhuoDDfrnGH7g7BkJHQ82eVHKa84UwaPAEaMfcq7+CwzGXBgRVdamjhQJLS/p+QV
 7H0OedD+PZKaW8TjCKU9V7dmqW3Dl+VIpBEImbX/Xeg==
X-Gm-Gg: ASbGncsup2GmgRM3wZYo7lzoMfueNPBo1IjEgwEneeEbTwctwTgia1+2V5c5oT9PobT
 OGKIcMiBlIklxf6X+nFeUMFTqTFW3bzXCoHb7EeCPngYKtn++y5fpo0HURA7vGx7Cw4tpcBvbp3
 tFfAEbzcXV/eEABNv06f0z830PWQXYtX4Tmh3C9UG9nh2cRWCEaMKQd44D3tm1RjhmtHKHLBgCc
 9/d1L+8Vw==
X-Google-Smtp-Source: AGHT+IGnaCzMF4jlrhMu6ibr4IegKbVeV/AZJsnDV9svbHu2HaqJKqpD8ba+So9KqmMMxf3lnrM5p4tNOUZs96ZvqwI=
X-Received: by 2002:a17:902:e802:b0:237:e3a0:9d63 with SMTP id
 d9443c01a7336-23e2576c517mr5061745ad.43.1752618710693; Tue, 15 Jul 2025
 15:31:50 -0700 (PDT)
MIME-Version: 1.0
References: <20250711172534.540416-1-dmarx@iol.unh.edu>
 <20250714171346.564267-1-dmarx@iol.unh.edu>
 <20250714171346.564267-3-dmarx@iol.unh.edu>
In-Reply-To: <20250714171346.564267-3-dmarx@iol.unh.edu>
From: Patrick Robb <probb@iol.unh.edu>
Date: Tue, 15 Jul 2025 18:25:59 -0400
X-Gm-Features: Ac12FXwRbxUEYgFVihoVN1RLjlRf3DQZnvoCOIzmC6R6SOu1W1aBu1632NizhGs
Message-ID: <CAJvnSUC4b4WPDd-SL8CQnhmuuq936pUyPwO51LPuGiZsj2fV0g@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] doc: revise coding guidelines section
To: Dean Marx <dmarx@iol.unh.edu>
Cc: luca.vizzarro@arm.com, yoan.picchi@foss.arm.com, 
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com, dev@dpdk.org
Content-Type: multipart/alternative; boundary="000000000000ad91b80639ff5706"
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

--000000000000ad91b80639ff5706
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 14, 2025 at 1:13=E2=80=AFPM Dean Marx <dmarx@iol.unh.edu> wrote=
:

> The Framework Coding Guidelines section includes outdated information
> about DTS and how to write a test suite. Updated these points to include
> the new test case decorators and setup/teardown hooks.
>
> Signed-off-by: Dean Marx <dmarx@iol.unh.edu>
> Reviewed-by: Patrick Robb <probb@iol.unh.edu>
> ---
>  doc/guides/tools/dts.rst | 194 ++++++++++++++++++---------------------
>  1 file changed, 90 insertions(+), 104 deletions(-)
>
> diff --git a/doc/guides/tools/dts.rst b/doc/guides/tools/dts.rst
> index 8ba855c6fc..4da55e00ef 100644
> --- a/doc/guides/tools/dts.rst
> +++ b/doc/guides/tools/dts.rst
> @@ -78,15 +78,15 @@ Setting up DTS environment
>     To install Poetry, visit their `doc pages <
> https://python-poetry.org/docs/>`_.
>     The recommended Poetry version is at least 1.8.2.
>
> -#. **Getting a Poetry shell**
> +#. **Running DTS with Poetry**
>
>     Once you have Poetry along with the proper Python version all set up,
> it's just a matter
> -   of installing dependencies via Poetry and using the virtual
> environment Poetry provides:
> +   of installing dependencies via Poetry and running main.py:
>
>     .. code-block:: console
>
>        poetry install
> -      poetry shell
> +      poetry run ./main.py
>
>  #. **SSH Connection**
>
> @@ -263,7 +263,7 @@ which don't require password authentication.
>  DTS Execution
>  ~~~~~~~~~~~~~
>
> -DTS is run with ``main.py`` located in the ``dts`` directory after
> entering Poetry shell:
> +DTS is run with ``main.py`` located in the ``dts`` directory using the
> ``poetry run`` command:
>
>  .. code-block:: console
>
> @@ -348,122 +348,111 @@ Adding test cases may require adding code to the
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
> +When contributing code to the DTS framework, follow existing conventions
> to ensure consistency.
> +The :ref:`DTS developer tools <dts_dev_tools>` will flag basic issues.
> +Also, be sure to :ref:`build the API documentation <building_api_docs>`
> to catch any problems during the build.
> +
> +The API documentation is a helpful reference during development.
> +It can be viewed in the code directly or generated using the :ref:`API
> docs build steps <building_api_docs>`.
> +If you add new files or change the directory structure, update the
> corresponding sources in ``doc/api/dts``.
> +
> +Code must be documented with docstrings that follow the
> +`Google style <
> https://google.github.io/styleguide/pyguide.html#38-comments-and-docstrin=
gs
> >`_.
> +Additional references:
> +
> +* `Sphinx Google style example <
> https://www.sphinx-doc.org/en/master/usage/extensions/example_google.html
> >`_
> +* `PEP 257 <https://peps.python.org/pep-0257/>`_
> +
> +Docstring and Attribute Guidelines
> +
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
> +
> +Example::
> +
> +   def foo(greet: bool) -> None:
> +       """Demonstrates single and double backticks.
> +
> +       `greet` controls whether ``Hello World`` is printed.
> +
> +       Args:
> +           greet: Whether to print the ``Hello World`` message.
> +       """
> +       if greet:
> +           print("Hello World")
> +
> +The maximum line length for docstrings must match that of the code.
>
>
>  How To Write a Test Suite
>  -------------------------
>
> -All test suites inherit from ``TestSuite`` defined in
> ``dts/framework/test_suite.py``.
> -There are four types of methods that comprise a test suite:
> +All test suites are classes that inherit from TestSuite, defined in
> dts/framework/test_suite.py. A typical suite contains:
>
> -#. **Test cases**
> +Test Cases
>
> -   | Test cases are methods that start with a particular prefix.
> -   | Functional test cases start with ``test_``, e.g.
> ``test_hello_world_single_core``.
> -   | Performance test cases start with ``test_perf_``, e.g.
> ``test_perf_nic_single_core``.
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
> +   Test cases are defined as methods and must be decorated appropriately=
.
> +   Use the @func_test and/or @perf_test decorators from TestSuite above
> each test case method.
> +   For example:
>
> -#. **Setup and Teardown methods**
> +   @func_test
> +   def test_basic_link(self):
> +      """your testcase docstring here"""
> +      #your testcase code here
>
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
> +   Functional test cases should use the @func_test decorator, and
> performance test cases should use @perf_test.
> +   A test suite may include any number of functional and/or performance
> test cases.
> +   Each suite should focus on testing a single feature (one feature =3D =
one
> test suite).
>
> -#. **Configuration, traffic and other logic**
> +Setup and Teardown Hooks
>
> -   The ``TestSuite`` class contains a variety of methods for anything th=
at
> -   a test suite setup, a teardown, or a test case may need to do.
> +   Setup and teardown methods can be defined at both the suite and test
> case levels.
>
> -   The test suites also frequently use a DPDK app, such as testpmd, in
> interactive mode
> -   and use the interactive shell instances directly.
> +   Suite-level:
>
> -   These are the two main ways to call the framework logic in test suite=
s.
> -   If there's any functionality or logic missing from the framework,
> -   it should be implemented so that the test suites can use one of these
> two ways.
> +   * set_up_suite() =E2=80=94 runs once before any test cases in the sui=
te
>
> -   Test suites may also be configured individually using a file provided
> at the command line.
> -   The file is a simple mapping of test suite names to their
> corresponding configurations.
> +   * tear_down_suite() =E2=80=94 runs once after all test cases have com=
pleted
>
> -   Any test suite can be designed to require custom configuration
> attributes or optional ones.
> -   Any optional attributes should supply a default value for the test
> suite to use.
> +   Case-level:
>
> -#. **Test case verification**
> +   * set_up_test_case() =E2=80=94 runs before each individual test case
>
> -   Test case verification should be done with the ``verify`` method,
> which records the result.
> -   The method should be called at the end of each test case.
> +   * tear_down_test_case() =E2=80=94 runs after each individual test cas=
e
>
> -#. **Other methods**
> +   These methods are optional. If not implemented, the framework will
> simply skip them.
>
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
> +   The TestSuite class provides a variety of methods for setup, teardown=
,
> and test logic.
> +   Test suites often use DPDK applications (e.g., testpmd) in interactiv=
e
> mode and interact with them via shell instances.
> +
> +Using the DTS Framework Within TestSuites:
> +
> +   There are two ways to call the framework logic in test suites:
> +
> +   - Using built-in methods provided by TestSuite or its base classes
> +   - Interacting directly with tools or shell interfaces
> +
> +   If any required functionality is missing, it should be implemented in
> a way that supports one of these two approaches.
>

I still don't think we're driving the point home, which is that the
testsuite class is essentially an API responsible for calls made to
framework code, and it should provide methods for common processes required
in DPDK testsuites (like sending and sniffing traffic). Maybe we should use
more direct language Here is a proposal which you can feel free to modify.

-------------------------------

Leveraging the DTS framework in writing testsuites:

   One should avoid directly importing DTS framework code to their
testsuites where possible. Instead, for performing common processes
required in testsuites, one should use (or add to) the list of methods
provided in the Testsuite class (the base class of all testsuites). For
instance, for sending a list of packets, one should work through the packet
transmitting function already made available in the TestSuite class,
instead of directly importing the DTS traffic generator class and using
that class in one's testsuite implementation. It is also acceptable to
import and instantiate classes for various DPDK applications. For instance,
writing a testsuite for a simple packet forwarding operation would involve
importing the DTS TestPmdShell class, instantiating TestPmdShell, calling
TestPmdShell's .start() method, and then sending traffic via one of the
traffic transmitting functions exposed in the Testsuite class.

-------------------------------

+
> +Test Case Verification
> +
> +   Use the verify method to assert conditions and record test results.
> +   This should typically be called at the end of each test case.
> +   Example: self.verify(link_up, "Link should be up after configuration.=
")
> +
> +Other Methods
> +
> +   All test suite code should follow the project's coding standards.
> +   Only test cases, setup/teardown hooks, and verification methods are
> treated specially by the framework.
> +   Additional methods may be defined as needed (ideally private).
>

Not a big deal but why dont you change to:

Additional private methods may be added as needed in your testsuite
implementation.


>
>
>  .. _dts_dev_tools:
> @@ -493,13 +482,10 @@ Building DTS API docs
>  The documentation is built using the standard DPDK build system.
>  See :doc:`../linux_gsg/build_dpdk` for more details on compiling DPDK
> with meson.
>
> -The :ref:`doc build dependencies <doc_dependencies>` may be installed
> with Poetry:
> -
>  .. code-block:: console
>
>     poetry install --only docs
>     poetry install --with docs  # an alternative that will also install
> DTS dependencies
> -   poetry shell
>
>  After executing the meson command, build the documentation with:
>
> --
> 2.49.0
>
>

--000000000000ad91b80639ff5706
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Jul 14,=
 2025 at 1:13=E2=80=AFPM Dean Marx &lt;<a href=3D"mailto:dmarx@iol.unh.edu"=
>dmarx@iol.unh.edu</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex">The Framework Coding Guidelines section includes outdated=
 information<br>
about DTS and how to write a test suite. Updated these points to include<br=
>
the new test case decorators and setup/teardown hooks.<br>
<br>
Signed-off-by: Dean Marx &lt;<a href=3D"mailto:dmarx@iol.unh.edu" target=3D=
"_blank">dmarx@iol.unh.edu</a>&gt;<br>
Reviewed-by: Patrick Robb &lt;<a href=3D"mailto:probb@iol.unh.edu" target=
=3D"_blank">probb@iol.unh.edu</a>&gt;<br>
---<br>
=C2=A0doc/guides/tools/dts.rst | 194 ++++++++++++++++++--------------------=
-<br>
=C2=A01 file changed, 90 insertions(+), 104 deletions(-)<br>
<br>
diff --git a/doc/guides/tools/dts.rst b/doc/guides/tools/dts.rst<br>
index 8ba855c6fc..4da55e00ef 100644<br>
--- a/doc/guides/tools/dts.rst<br>
+++ b/doc/guides/tools/dts.rst<br>
@@ -78,15 +78,15 @@ Setting up DTS environment<br>
=C2=A0 =C2=A0 To install Poetry, visit their `doc pages &lt;<a href=3D"http=
s://python-poetry.org/docs/" rel=3D"noreferrer" target=3D"_blank">https://p=
ython-poetry.org/docs/</a>&gt;`_.<br>
=C2=A0 =C2=A0 The recommended Poetry version is at least 1.8.2.<br>
<br>
-#. **Getting a Poetry shell**<br>
+#. **Running DTS with Poetry**<br>
<br>
=C2=A0 =C2=A0 Once you have Poetry along with the proper Python version all=
 set up, it&#39;s just a matter<br>
-=C2=A0 =C2=A0of installing dependencies via Poetry and using the virtual e=
nvironment Poetry provides:<br>
+=C2=A0 =C2=A0of installing dependencies via Poetry and running main.py:<br=
>
<br>
=C2=A0 =C2=A0 .. code-block:: console<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0poetry install<br>
-=C2=A0 =C2=A0 =C2=A0 poetry shell<br>
+=C2=A0 =C2=A0 =C2=A0 poetry run ./main.py<br>
<br>
=C2=A0#. **SSH Connection**<br>
<br>
@@ -263,7 +263,7 @@ which don&#39;t require password authentication.<br>
=C2=A0DTS Execution<br>
=C2=A0~~~~~~~~~~~~~<br>
<br>
-DTS is run with ``main.py`` located in the ``dts`` directory after enterin=
g Poetry shell:<br>
+DTS is run with ``main.py`` located in the ``dts`` directory using the ``p=
oetry run`` command:<br>
<br>
=C2=A0.. code-block:: console<br>
<br>
@@ -348,122 +348,111 @@ Adding test cases may require adding code to the fr=
amework as well.<br>
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
+When contributing code to the DTS framework, follow existing conventions t=
o ensure consistency.<br>
+The :ref:`DTS developer tools &lt;dts_dev_tools&gt;` will flag basic issue=
s.<br>
+Also, be sure to :ref:`build the API documentation &lt;building_api_docs&g=
t;` to catch any problems during the build.<br>
+<br>
+The API documentation is a helpful reference during development.<br>
+It can be viewed in the code directly or generated using the :ref:`API doc=
s build steps &lt;building_api_docs&gt;`.<br>
+If you add new files or change the directory structure, update the corresp=
onding sources in ``doc/api/dts``.<br>
+<br>
+Code must be documented with docstrings that follow the<br>
+`Google style &lt;<a href=3D"https://google.github.io/styleguide/pyguide.h=
tml#38-comments-and-docstrings" rel=3D"noreferrer" target=3D"_blank">https:=
//google.github.io/styleguide/pyguide.html#38-comments-and-docstrings</a>&g=
t;`_.<br>
+Additional references:<br>
+<br>
+* `Sphinx Google style example &lt;<a href=3D"https://www.sphinx-doc.org/e=
n/master/usage/extensions/example_google.html" rel=3D"noreferrer" target=3D=
"_blank">https://www.sphinx-doc.org/en/master/usage/extensions/example_goog=
le.html</a>&gt;`_<br>
+* `PEP 257 &lt;<a href=3D"https://peps.python.org/pep-0257/" rel=3D"norefe=
rrer" target=3D"_blank">https://peps.python.org/pep-0257/</a>&gt;`_<br>
+<br>
+Docstring and Attribute Guidelines<br>
+<br>
+* Document ``__init__()`` separately from the class docstring.<br>
+* If an abstract method simply implements a superclass definition without =
changes, refer to that superclass in the docstring.<br>
+* Document instance variables in the class docstring under an ``Attributes=
:`` section.<br>
+* For ``@dataclass`` classes, document instance-level attributes in ``Attr=
ibutes:``, as they are generated from the class fields.<br>
+* Document class variables and Pydantic fields using ``#:``,<br>
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
+<br>
+Example::<br>
+<br>
+=C2=A0 =C2=A0def foo(greet: bool) -&gt; None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Demonstrates single and doubl=
e backticks.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0`greet` controls whether ``Hello World`` is pri=
nted.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0Args:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0greet: Whether to print the ``Hel=
lo World`` message.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if greet:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0print(&quot;Hello World&quot;)<br=
>
+<br>
+The maximum line length for docstrings must match that of the code.<br>
<br>
<br>
=C2=A0How To Write a Test Suite<br>
=C2=A0-------------------------<br>
<br>
-All test suites inherit from ``TestSuite`` defined in ``dts/framework/test=
_suite.py``.<br>
-There are four types of methods that comprise a test suite:<br>
+All test suites are classes that inherit from TestSuite, defined in dts/fr=
amework/test_suite.py. A typical suite contains:<br>
<br>
-#. **Test cases**<br>
+Test Cases<br>
<br>
-=C2=A0 =C2=A0| Test cases are methods that start with a particular prefix.=
<br>
-=C2=A0 =C2=A0| Functional test cases start with ``test_``, e.g. ``test_hel=
lo_world_single_core``.<br>
-=C2=A0 =C2=A0| Performance test cases start with ``test_perf_``, e.g. ``te=
st_perf_nic_single_core``.<br>
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
+=C2=A0 =C2=A0Test cases are defined as methods and must be decorated appro=
priately.<br>
+=C2=A0 =C2=A0Use the @func_test and/or @perf_test decorators from TestSuit=
e above each test case method.<br>
+=C2=A0 =C2=A0For example:<br>
<br>
-#. **Setup and Teardown methods**<br>
+=C2=A0 =C2=A0@func_test<br>
+=C2=A0 =C2=A0def test_basic_link(self):<br>
+=C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;your testcase docstring here&quot;&=
quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 #your testcase code here<br>
<br>
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
+=C2=A0 =C2=A0Functional test cases should use the @func_test decorator, an=
d performance test cases should use @perf_test.<br>
+=C2=A0 =C2=A0A test suite may include any number of functional and/or perf=
ormance test cases.<br>
+=C2=A0 =C2=A0Each suite should focus on testing a single feature (one feat=
ure =3D one test suite).<br>
<br>
-#. **Configuration, traffic and other logic**<br>
+Setup and Teardown Hooks<br>
<br>
-=C2=A0 =C2=A0The ``TestSuite`` class contains a variety of methods for any=
thing that<br>
-=C2=A0 =C2=A0a test suite setup, a teardown, or a test case may need to do=
.<br>
+=C2=A0 =C2=A0Setup and teardown methods can be defined at both the suite a=
nd test case levels.<br>
<br>
-=C2=A0 =C2=A0The test suites also frequently use a DPDK app, such as testp=
md, in interactive mode<br>
-=C2=A0 =C2=A0and use the interactive shell instances directly.<br>
+=C2=A0 =C2=A0Suite-level:<br>
<br>
-=C2=A0 =C2=A0These are the two main ways to call the framework logic in te=
st suites.<br>
-=C2=A0 =C2=A0If there&#39;s any functionality or logic missing from the fr=
amework,<br>
-=C2=A0 =C2=A0it should be implemented so that the test suites can use one =
of these two ways.<br>
+=C2=A0 =C2=A0* set_up_suite() =E2=80=94 runs once before any test cases in=
 the suite<br>
<br>
-=C2=A0 =C2=A0Test suites may also be configured individually using a file =
provided at the command line.<br>
-=C2=A0 =C2=A0The file is a simple mapping of test suite names to their cor=
responding configurations.<br>
+=C2=A0 =C2=A0* tear_down_suite() =E2=80=94 runs once after all test cases =
have completed<br>
<br>
-=C2=A0 =C2=A0Any test suite can be designed to require custom configuratio=
n attributes or optional ones.<br>
-=C2=A0 =C2=A0Any optional attributes should supply a default value for the=
 test suite to use.<br>
+=C2=A0 =C2=A0Case-level:<br>
<br>
-#. **Test case verification**<br>
+=C2=A0 =C2=A0* set_up_test_case() =E2=80=94 runs before each individual te=
st case<br>
<br>
-=C2=A0 =C2=A0Test case verification should be done with the ``verify`` met=
hod, which records the result.<br>
-=C2=A0 =C2=A0The method should be called at the end of each test case.<br>
+=C2=A0 =C2=A0* tear_down_test_case() =E2=80=94 runs after each individual =
test case<br>
<br>
-#. **Other methods**<br>
+=C2=A0 =C2=A0These methods are optional. If not implemented, the framework=
 will simply skip them.<br>
<br>
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
+=C2=A0 =C2=A0The TestSuite class provides a variety of methods for setup, =
teardown, and test logic.<br>
+=C2=A0 =C2=A0Test suites often use DPDK applications (e.g., testpmd) in in=
teractive mode and interact with them via shell instances.<br>
+<br>
+Using the DTS Framework Within TestSuites:<br>
+<br>
+=C2=A0 =C2=A0There are two ways to call the framework logic in test suites=
:<br>
+<br>
+=C2=A0 =C2=A0- Using built-in methods provided by TestSuite or its base cl=
asses<br>
+=C2=A0 =C2=A0- Interacting directly with tools or shell interfaces<br>
+<br>
+=C2=A0 =C2=A0If any required functionality is missing, it should be implem=
ented in a way that supports one of these two approaches.<br></blockquote><=
div><br></div><div>I still don&#39;t think we&#39;re driving the point home=
,=C2=A0which is that the testsuite class is essentially an API responsible =
for calls made to framework=C2=A0code,=C2=A0and it should provide methods f=
or common processes required in DPDK testsuites (like sending and sniffing =
traffic). Maybe we should use more direct language Here is a proposal which=
 you can feel free to=C2=A0modify.</div><div><br></div><div>---------------=
----------------</div><div><br></div><div>Leveraging the DTS framework in w=
riting testsuites:</div><div><br></div><div>=C2=A0 =C2=A0One should avoid d=
irectly importing DTS framework code to their testsuites where possible. In=
stead, for performing common processes required in testsuites, one should u=
se (or add to) the list of methods provided in the Testsuite class (the bas=
e class of all testsuites). For instance, for sending a list of packets, on=
e should work through the packet transmitting function already made availab=
le in the TestSuite class, instead of directly importing the DTS traffic ge=
nerator class and using that class in one&#39;s testsuite implementation. I=
t is also acceptable to import and instantiate classes for various DPDK app=
lications. For instance, writing a testsuite for a simple packet forwarding=
 operation would involve importing the DTS TestPmdShell class, instantiatin=
g TestPmdShell, calling TestPmdShell&#39;s .start() method, and then sendin=
g traffic via one of the traffic transmitting functions exposed in the Test=
suite class.</div><div>=C2=A0</div><div>-------------------------------</di=
v><div><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
+<br>
+Test Case Verification<br>
+<br>
+=C2=A0 =C2=A0Use the verify method to assert conditions and record test re=
sults.<br>
+=C2=A0 =C2=A0This should typically be called at the end of each test case.=
<br>
+=C2=A0 =C2=A0Example: self.verify(link_up, &quot;Link should be up after c=
onfiguration.&quot;)<br>
+<br>
+Other Methods<br>
+<br>
+=C2=A0 =C2=A0All test suite code should follow the project&#39;s coding st=
andards.<br>
+=C2=A0 =C2=A0Only test cases, setup/teardown hooks, and verification metho=
ds are treated specially by the framework.<br>
+=C2=A0 =C2=A0Additional methods may be defined as needed (ideally private)=
.<br></blockquote><div><br></div><div>Not a big deal but why dont you chang=
e to:=C2=A0</div><div><br></div><div>Additional private methods may be adde=
d as needed in your testsuite implementation.</div><div>=C2=A0</div><blockq=
uote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1p=
x solid rgb(204,204,204);padding-left:1ex">
<br>
<br>
=C2=A0.. _dts_dev_tools:<br>
@@ -493,13 +482,10 @@ Building DTS API docs<br>
=C2=A0The documentation is built using the standard DPDK build system.<br>
=C2=A0See :doc:`../linux_gsg/build_dpdk` for more details on compiling DPDK=
 with meson.<br>
<br>
-The :ref:`doc build dependencies &lt;doc_dependencies&gt;` may be installe=
d with Poetry:<br>
-<br>
=C2=A0.. code-block:: console<br>
<br>
=C2=A0 =C2=A0 poetry install --only docs<br>
=C2=A0 =C2=A0 poetry install --with docs=C2=A0 # an alternative that will a=
lso install DTS dependencies<br>
-=C2=A0 =C2=A0poetry shell<br>
<br>
=C2=A0After executing the meson command, build the documentation with:<br>
<br>
-- <br>
2.49.0<br>
<br>
</blockquote></div></div>

--000000000000ad91b80639ff5706--
