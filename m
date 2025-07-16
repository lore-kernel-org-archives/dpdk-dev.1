Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8B8FC83F1B
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Jul 2025 22:04:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A236D4014F;
	Thu, 17 Jul 2025 00:04:17 +0200 (CEST)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by mails.dpdk.org (Postfix) with ESMTP id 9ABB9400EF
 for <dev@dpdk.org>; Thu, 17 Jul 2025 00:04:16 +0200 (CEST)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-234d3261631so2300395ad.1
 for <dev@dpdk.org>; Wed, 16 Jul 2025 15:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1752703456; x=1753308256; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6e8MRj/Wtkc0eY5u2X9sMqhbpAtC0HLen0JQK9hC9q8=;
 b=Z9nw8bE0Ah4SaIbLHhMMDEkBhNwTWaIhlVY4Bh3pgg/mFDZeS6sCx9ruyI18+QYx/W
 6Zgnp0V2EqHdq0l9PyM51Z1KUqjhZt9H6MKKixX4C9eftExdfg1+B7eI9TTJWeGJDCSq
 h/sP0glP4atnXlF49yeFiRbzQ4nF7D1wv+9ho=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752703456; x=1753308256;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6e8MRj/Wtkc0eY5u2X9sMqhbpAtC0HLen0JQK9hC9q8=;
 b=nEEWQL/IyaZXw2jg+ArzI6YI9ys/IbhvC93gLpU445e3NRtgm62dVV4GpSL3wRjgr8
 tIYc8qGczoLMAVKQErTyyfpHt8y2H3LLDZWW4Z4h4rpwUD6v5NZJ/6l13xrB3vJiZhJk
 LGH2Lo6GnZrKXFH3Z3IokB/vUBogPlUqLg4CABEz/zK4B9PE2rwdskCJna89vs2TzID8
 4lBNe83UmM/kbqG3vDH4IxMlhyA2eNlXicPNbMcHoCxquoQeiiLThOJsviMAp/awiV/9
 P1TDjh6tRLHzBdD9zZeD1iJEgwsJ94B91lYzQNMUujyYaCmySWYam3xj/+Grk6mHL65N
 ZIWg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXmAYC5COWyG3q02ZfR2HOp3lGKqNEsC4PqU0q25gbtx6kCafw+UvMZqOm4cG5ir7nZayk=@dpdk.org
X-Gm-Message-State: AOJu0Yxahw0mINAJQFwNf+ozOPn6UsMR+CzH4wtH9IQ62uZIsvPB3B7q
 qD1OwLl5H0JdB4T2rcn2BQiGi/RhWLBhUdVYBqBkqqbYcyqWy944qlv+vOSK37ntrfmCnWlN+wZ
 O9nRSxzCC3tqdhPQeMFl/QrcRAo/QHRjVgAvsQQ5//g==
X-Gm-Gg: ASbGncuRAj/32hGY03ioNZI7pOggpUXwTGr+Voz6HPmUKO03HlsqIh7HrR0ZktLMLfU
 sWF+GyxYS5SYMSGFIaYeDPAGsDGNjFdIUvIJVdXA3DQd3Dh/5IlTom6hZzt3Zx4xIp7pwtffGXW
 eXAQOzBJHsFDPCwE2W1+6NVmuSuSyQLPYpFmZ3os6g4cdygl1K0FJqbYAiX/OzbyfIknkYfrVnJ
 xRJJPY9Og==
X-Google-Smtp-Source: AGHT+IHRjsM13m9O0G8Jruzlf+qi+0Qgnwh9b/Xc0vBXyYzEGKn4u4fD4ZRb5pO5A9rYhnS971fyuIP4DsvJyHMC05g=
X-Received: by 2002:a17:903:2a88:b0:235:655:11aa with SMTP id
 d9443c01a7336-23e24f522dbmr56683665ad.39.1752703455703; Wed, 16 Jul 2025
 15:04:15 -0700 (PDT)
MIME-Version: 1.0
References: <20250716182546.58567-1-dmarx@iol.unh.edu>
 <20250716205402.64997-1-dmarx@iol.unh.edu>
 <20250716205402.64997-3-dmarx@iol.unh.edu>
In-Reply-To: <20250716205402.64997-3-dmarx@iol.unh.edu>
From: Patrick Robb <probb@iol.unh.edu>
Date: Wed, 16 Jul 2025 17:58:23 -0400
X-Gm-Features: Ac12FXyYhc_1dwqRwLP0uK9cdOU8pO9BAiqrS7nbcv95Ic0s_UkhLMbOg9SN1xA
Message-ID: <CAJvnSUABS=J2_C00NFyJ2N4aZGkd3AEYwZCOAkX7odNioFxOBA@mail.gmail.com>
Subject: Re: [PATCH v7 3/3] doc: revise coding guidelines section
To: Dean Marx <dmarx@iol.unh.edu>
Cc: luca.vizzarro@arm.com, yoan.picchi@foss.arm.com, 
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com, dev@dpdk.org
Content-Type: multipart/alternative; boundary="000000000000dfd041063a131264"
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

--000000000000dfd041063a131264
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 16, 2025 at 4:54=E2=80=AFPM Dean Marx <dmarx@iol.unh.edu> wrote=
:

> code.
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
> +
> +Test Cases
> +
> +   Test cases are defined as methods and must be decorated appropriately=
.
> +   Use the @func_test and/or @perf_test decorators from TestSuite above
> each test case method.
> +   For example:
> +
> +Example::
> +
> +   @func_test
> +   def test_basic_link(self):
> +      """your testcase docstring here"""
> +      # your testcase code here
>

This looks good except for the fact that the whole example block should be
indented once. Otherwise it's not actually under "Test Cases," and also it
consumes the text blurb immediately following the example.

I just did a git fixup which indents it and that looks good after reviewing
the guides docs build output file. I'm pushing to my GHA robot fork to make
sure it still passes the checks but unless there are any fails I will just
push to next-dts with my fixup.


>
> -#. **Test cases**
> +   Functional test cases should use the @func_test decorator, and
> performance test cases should use @perf_test.
> +   A test suite may include any number of functional and/or performance
> test cases.
> +   Each suite should focus on testing a single feature (one feature =3D =
one
> test suite).
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
> +Setup and Teardown Hooks
>
> -#. **Setup and Teardown methods**
> +   Setup and teardown methods can be defined at both the suite and test
> case levels.
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
> +   Suite-level:
>
> -#. **Configuration, traffic and other logic**
> +   * set_up_suite() =E2=80=94 runs once before any test cases in the sui=
te
>
> -   The ``TestSuite`` class contains a variety of methods for anything th=
at
> -   a test suite setup, a teardown, or a test case may need to do.
> +   * tear_down_suite() =E2=80=94 runs once after all test cases have com=
pleted
>
> -   The test suites also frequently use a DPDK app, such as testpmd, in
> interactive mode
> -   and use the interactive shell instances directly.
> +   Case-level:
>
> -   These are the two main ways to call the framework logic in test suite=
s.
> -   If there's any functionality or logic missing from the framework,
> -   it should be implemented so that the test suites can use one of these
> two ways.
> +   * set_up_test_case() =E2=80=94 runs before each individual test case
>
> -   Test suites may also be configured individually using a file provided
> at the command line.
> -   The file is a simple mapping of test suite names to their
> corresponding configurations.
> +   * tear_down_test_case() =E2=80=94 runs after each individual test cas=
e
>
> -   Any test suite can be designed to require custom configuration
> attributes or optional ones.
> -   Any optional attributes should supply a default value for the test
> suite to use.
> +   These methods are optional. If not implemented, the framework will
> simply skip them.
>
> -#. **Test case verification**
> +   The TestSuite class provides a variety of methods for setup, teardown=
,
> and test logic.
> +   Test suites often use DPDK applications (e.g., testpmd) in interactiv=
e
> mode and interact with them via shell instances.
>
> -   Test case verification should be done with the ``verify`` method,
> which records the result.
> -   The method should be called at the end of each test case.
> +Leveraging the DTS framework in writing testsuites:
>
> -#. **Other methods**
> +   One should avoid directly importing DTS framework code to their
> +   testsuites where possible. Instead, for performing common processes
> +   required in testsuites, one should use (or add to) the list of method=
s
> +   provided in the Testsuite class (the base class of all testsuites). F=
or
> +   instance, for sending a list of packets, one should work through the
> packet
> +   transmitting function already made available in the TestSuite class,
> +   instead of directly importing the DTS traffic generator class and usi=
ng
> +   that class in one's testsuite implementation. It is also acceptable t=
o
> +   import and instantiate classes for various DPDK applications. For
> instance,
> +   writing a testsuite for a simple packet forwarding operation would
> involve
> +   importing the DTS TestPmdShell class, instantiating TestPmdShell,
> calling
> +   TestPmdShell's start() method, and then sending traffic via one of th=
e
> +   traffic transmitting functions exposed in the Testsuite class.
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
> +   Additional private methods may be added as needed in your testsuite
> implementation.
>
>
>  .. _dts_dev_tools:
> @@ -493,13 +491,10 @@ Building DTS API docs
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
> 2.50.1
>
>

--000000000000dfd041063a131264
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Jul 16,=
 2025 at 4:54=E2=80=AFPM Dean Marx &lt;<a href=3D"mailto:dmarx@iol.unh.edu"=
>dmarx@iol.unh.edu</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex">code.<br>
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
+<br>
+Test Cases<br>
+<br>
+=C2=A0 =C2=A0Test cases are defined as methods and must be decorated appro=
priately.<br>
+=C2=A0 =C2=A0Use the @func_test and/or @perf_test decorators from TestSuit=
e above each test case method.<br>
+=C2=A0 =C2=A0For example:<br>
+<br>
+Example::<br>
+<br>
+=C2=A0 =C2=A0@func_test<br>
+=C2=A0 =C2=A0def test_basic_link(self):<br>
+=C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;your testcase docstring here&quot;&=
quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 # your testcase code here<br></blockquote><div><br></=
div><div>This looks good except for the fact that the whole example block s=
hould be indented once. Otherwise it&#39;s not actually under &quot;Test Ca=
ses,&quot; and also it consumes the text blurb immediately following the ex=
ample.</div><div><br></div><div>I just did a git fixup which indents it and=
 that looks good after reviewing the guides docs build output file. I&#39;m=
 pushing to my GHA robot fork to make sure it still passes the checks but u=
nless there are any fails I will just push to next-dts with my fixup.</div>=
<div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
-#. **Test cases**<br>
+=C2=A0 =C2=A0Functional test cases should use the @func_test decorator, an=
d performance test cases should use @perf_test.<br>
+=C2=A0 =C2=A0A test suite may include any number of functional and/or perf=
ormance test cases.<br>
+=C2=A0 =C2=A0Each suite should focus on testing a single feature (one feat=
ure =3D one test suite).<br>
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
+Setup and Teardown Hooks<br>
<br>
-#. **Setup and Teardown methods**<br>
+=C2=A0 =C2=A0Setup and teardown methods can be defined at both the suite a=
nd test case levels.<br>
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
+=C2=A0 =C2=A0Suite-level:<br>
<br>
-#. **Configuration, traffic and other logic**<br>
+=C2=A0 =C2=A0* set_up_suite() =E2=80=94 runs once before any test cases in=
 the suite<br>
<br>
-=C2=A0 =C2=A0The ``TestSuite`` class contains a variety of methods for any=
thing that<br>
-=C2=A0 =C2=A0a test suite setup, a teardown, or a test case may need to do=
.<br>
+=C2=A0 =C2=A0* tear_down_suite() =E2=80=94 runs once after all test cases =
have completed<br>
<br>
-=C2=A0 =C2=A0The test suites also frequently use a DPDK app, such as testp=
md, in interactive mode<br>
-=C2=A0 =C2=A0and use the interactive shell instances directly.<br>
+=C2=A0 =C2=A0Case-level:<br>
<br>
-=C2=A0 =C2=A0These are the two main ways to call the framework logic in te=
st suites.<br>
-=C2=A0 =C2=A0If there&#39;s any functionality or logic missing from the fr=
amework,<br>
-=C2=A0 =C2=A0it should be implemented so that the test suites can use one =
of these two ways.<br>
+=C2=A0 =C2=A0* set_up_test_case() =E2=80=94 runs before each individual te=
st case<br>
<br>
-=C2=A0 =C2=A0Test suites may also be configured individually using a file =
provided at the command line.<br>
-=C2=A0 =C2=A0The file is a simple mapping of test suite names to their cor=
responding configurations.<br>
+=C2=A0 =C2=A0* tear_down_test_case() =E2=80=94 runs after each individual =
test case<br>
<br>
-=C2=A0 =C2=A0Any test suite can be designed to require custom configuratio=
n attributes or optional ones.<br>
-=C2=A0 =C2=A0Any optional attributes should supply a default value for the=
 test suite to use.<br>
+=C2=A0 =C2=A0These methods are optional. If not implemented, the framework=
 will simply skip them.<br>
<br>
-#. **Test case verification**<br>
+=C2=A0 =C2=A0The TestSuite class provides a variety of methods for setup, =
teardown, and test logic.<br>
+=C2=A0 =C2=A0Test suites often use DPDK applications (e.g., testpmd) in in=
teractive mode and interact with them via shell instances.<br>
<br>
-=C2=A0 =C2=A0Test case verification should be done with the ``verify`` met=
hod, which records the result.<br>
-=C2=A0 =C2=A0The method should be called at the end of each test case.<br>
+Leveraging the DTS framework in writing testsuites:<br>
<br>
-#. **Other methods**<br>
+=C2=A0 =C2=A0One should avoid directly importing DTS framework code to the=
ir<br>
+=C2=A0 =C2=A0testsuites where possible. Instead, for performing common pro=
cesses<br>
+=C2=A0 =C2=A0required in testsuites, one should use (or add to) the list o=
f methods<br>
+=C2=A0 =C2=A0provided in the Testsuite class (the base class of all testsu=
ites). For<br>
+=C2=A0 =C2=A0instance, for sending a list of packets, one should work thro=
ugh the packet<br>
+=C2=A0 =C2=A0transmitting function already made available in the TestSuite=
 class,<br>
+=C2=A0 =C2=A0instead of directly importing the DTS traffic generator class=
 and using<br>
+=C2=A0 =C2=A0that class in one&#39;s testsuite implementation. It is also =
acceptable to<br>
+=C2=A0 =C2=A0import and instantiate classes for various DPDK applications.=
 For instance,<br>
+=C2=A0 =C2=A0writing a testsuite for a simple packet forwarding operation =
would involve<br>
+=C2=A0 =C2=A0importing the DTS TestPmdShell class, instantiating TestPmdSh=
ell, calling<br>
+=C2=A0 =C2=A0TestPmdShell&#39;s start() method, and then sending traffic v=
ia one of the<br>
+=C2=A0 =C2=A0traffic transmitting functions exposed in the Testsuite class=
.<br>
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
+=C2=A0 =C2=A0Additional private methods may be added as needed in your tes=
tsuite implementation.<br>
<br>
<br>
=C2=A0.. _dts_dev_tools:<br>
@@ -493,13 +491,10 @@ Building DTS API docs<br>
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
2.50.1<br>
<br>
</blockquote></div></div>

--000000000000dfd041063a131264--
