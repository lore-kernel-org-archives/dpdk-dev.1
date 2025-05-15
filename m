Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6CB1C3ABC9
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 May 2025 12:32:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9A72B40E3E;
	Thu, 15 May 2025 14:32:45 +0200 (CEST)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177])
 by mails.dpdk.org (Postfix) with ESMTP id 64D40402DC
 for <dev@dpdk.org>; Thu, 15 May 2025 14:32:44 +0200 (CEST)
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-22e661313a3so8567475ad.3
 for <dev@dpdk.org>; Thu, 15 May 2025 05:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1747312363; x=1747917163; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=a5aDgYATqVmLnUtXczvRItvBb+OkovxLm9OMioMIJrg=;
 b=cWWutklvmRQnyR19LFnOePtiGbX0iGIG1hXktgXBUAOnTmdSBArTQtWEYu97YnOFTv
 8bP8FHUYntUs3aQo54CZmItaFqiBzDnXvCLQPju1g0D64Lb2aS1B7IA4ihG/3z/DPFAU
 vugInm3R0IK/rO2Scvf4oSDvUtGxpU5Q0ylQY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747312363; x=1747917163;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=a5aDgYATqVmLnUtXczvRItvBb+OkovxLm9OMioMIJrg=;
 b=da8gJKDz5aE2Nmsb7CwK2E3cpVRneoAyf2ZoMkhpBorD1w49VpjUmd5RNPjDos39jZ
 nsdiHLBSHPhGT8VfUsk4COdWOapJjhWBMFxFFa2hkUvo8Ag8Sq4QGmgJtYimB8/+KUCu
 J5EbdaIdKFrK87Qt8jckqf2r5/WRIC/VbTWkPNAp9eNRMswErAksetKTesgRNACfHQ2d
 49scS1kkQ1715nL+M7Ho07XbP/YCwJ1LpBwjgrCLPu2VHUd6TmXGnIQ15/e+ieb+5+K3
 qfY9nP3W9p8u/hvKKbnMbZ3GXRlhWWkXlNt4QJowxpbWbWnn76yTMPA86se4OlNGBhVU
 SY9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUzEed1dg8MWi6pdOOa3/DufTtlLuo4GwLNDmfWq/8kAsDOHKQqFZHRwVVPuKWaoq72LbE=@dpdk.org
X-Gm-Message-State: AOJu0YylEADJx8hsB3qX2x9Hfie68P4CD345JVP06xCDDT/M3qR0LLeU
 NlUQthlDKjv9GOU/YGmmAALz3gq602Wpvdb5vtyJHaTJWxz57fp0VOAxH9sFFrEyTwc1owvcqs6
 kNkmeKiUA7QgK2YCJ7/3i85ounmNsCK5547h+Hw==
X-Gm-Gg: ASbGncuNaZ+61O+JUGSLkUB52gNG8xTbFHSsEU2ub5qL0LW8/h2+rrKYIyChc1e7l5/
 w6esqIcZMaLL3/k7Zp37jaaGfheKO15BbcUR99ILQ8PKYPmRLhHBTJ2wSjp+sdhjvlkOepUgAW5
 XasC8ZqKoXNQ1QCKsr78/3fuEgxyUEp4FHWUA9om2I+Ty4N+c4
X-Google-Smtp-Source: AGHT+IHVVVatj710LAC415ooaQI980YanVbuazy4K9nW2svLlyTqQc+twUc3ii30abkH8Haq9nKOAFycq9MG6Jzb2Mg=
X-Received: by 2002:a17:902:dad2:b0:224:194c:694c with SMTP id
 d9443c01a7336-231b5e6c2afmr32402795ad.28.1747312362980; Thu, 15 May 2025
 05:32:42 -0700 (PDT)
MIME-Version: 1.0
References: <20241009152417.4028297-1-bruce.richardson@intel.com>
 <20250513085956.1670288-1-bruce.richardson@intel.com>
 <CAJFAV8xccPZAvQrFX_dqhQ49ZQUEtTO3GoDPKLZpz05pyBL1nw@mail.gmail.com>
 <aCW1qG-VVALr_o0n@bricha3-mobl1.ger.corp.intel.com>
 <CAJFAV8z842+xoRs2P8YCrG9EvFD_S-aC-0oaiV_7Dz41qiVZnQ@mail.gmail.com>
In-Reply-To: <CAJFAV8z842+xoRs2P8YCrG9EvFD_S-aC-0oaiV_7Dz41qiVZnQ@mail.gmail.com>
From: Patrick Robb <probb@iol.unh.edu>
Date: Thu, 15 May 2025 14:28:01 +0200
X-Gm-Features: AX0GCFvme3CrbWfCH7YE4OwlinGnrqAXnsi1Ropx88CMhaPwigLwpQ0ScY7VMbY
Message-ID: <CAJvnSUAs=UvxGqj41JSMB3TibRrvLh0ZOGDBN7ffUkpGSvUyPA@mail.gmail.com>
Subject: Re: [PATCH v2] build: automatically report minimum meson version
To: David Marchand <david.marchand@redhat.com>
Cc: Bruce Richardson <bruce.richardson@intel.com>, dev@dpdk.org, 
 Stephen Hemminger <stephen@networkplumber.org>,
 Thomas Monjalon <thomas@monjalon.net>
Content-Type: multipart/alternative; boundary="000000000000b5222e06352bdc90"
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

--000000000000b5222e06352bdc90
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 15, 2025 at 1:40=E2=80=AFPM David Marchand <david.marchand@redh=
at.com>
wrote:

>
>
> Retests show the same error, so I think we are hitting the issue fixed
> with dbcd72f3fba0.
>
> Bumping the minimal version to 0.57.2 seems fine.
> I looked and can't find a distrib that ships meson 0.57.
> So either a user relies on the distrib version (with a version >=3D
> 0.58, from my quick search) or the distrib provided version is too old
> and then the user relies on pip.
>
>

FYI here's the stacktrace below which is not making it to the testlog on
the dashboard (something for UNH people to look at). But yes it's the same
issue fixed with dbcd72f3fba0babd2d801c2c63ee537df459df66

---------


 Exception in callback TestHarness._run_tests.<locals>.test_done(<Task
finishe...explicitly.')>) at
/usr/local/lib/python3.12/site-packages/mesonbuild/mtest.py:1806
 handle: <Handle TestHarness._run_tests.<locals>.test_done(<Task
finishe...explicitly.')>) at
/usr/local/lib/python3.12/site-packages/mesonbuild/mtest.py:1806>
 Traceback (most recent call last):
   File "/usr/lib64/python3.12/asyncio/events.py", line 88, in _run
     self._context.run(self._callback, *self._args)
   File "/usr/local/lib/python3.12/site-packages/mesonbuild/mtest.py", line
1808, in test_done
     f.result()
   File "/usr/local/lib/python3.12/site-packages/mesonbuild/mtest.py", line
1803, in run_test
     res =3D await test.run(self)
           ^^^^^^^^^^^^^^^^^^^^
   File "/usr/local/lib/python3.12/site-packages/mesonbuild/mtest.py", line
1349, in run
     await self._run_cmd(harness, cmd)
   File "/usr/local/lib/python3.12/site-packages/mesonbuild/mtest.py", line
1415, in _run_cmd
     returncode, result, additional_error =3D await
p.wait(self.runobj.timeout)

^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
   File "/usr/local/lib/python3.12/site-packages/mesonbuild/mtest.py", line
1241, in wait
     await try_wait_one(p.wait(), timeout=3Dtimeout)
   File "/usr/local/lib/python3.12/site-packages/mesonbuild/mtest.py", line
1132, in try_wait_one
     await asyncio.wait(awaitables,
   File "/usr/lib64/python3.12/asyncio/tasks.py", line 461, in wait
     raise TypeError("Passing coroutines is forbidden, use tasks
explicitly.")
 TypeError: Passing coroutines is forbidden, use tasks explicitly.
 /usr/lib64/python3.12/asyncio/events.py:88: RuntimeWarning: coroutine
'Process.wait' was never awaited
   self._context.run(self._callback, *self._args)
 RuntimeWarning: Enable tracemalloc to get the object allocation traceback
 Traceback (most recent call last):
   File "/usr/local/lib/python3.12/site-packages/mesonbuild/mesonmain.py",
line 132, in run
     return options.run_func(options)
            ^^^^^^^^^^^^^^^^^^^^^^^^^
   File "/usr/local/lib/python3.12/site-packages/mesonbuild/mtest.py", line
1953, in run
     return th.doit()
            ^^^^^^^^^
   File "/usr/local/lib/python3.12/site-packages/mesonbuild/mtest.py", line
1641, in doit
     self.run_tests(runners)
   File "/usr/local/lib/python3.12/site-packages/mesonbuild/mtest.py", line
1780, in run_tests
     loop.run_until_complete(self._run_tests(runners))
   File "/usr/lib64/python3.12/asyncio/base_events.py", line 687, in
run_until_complete
     return future.result()
            ^^^^^^^^^^^^^^^
   File "/usr/local/lib/python3.12/site-packages/mesonbuild/mtest.py", line
1871, in _run_tests
     await complete(future)
   File "/usr/local/lib/python3.12/site-packages/mesonbuild/mtest.py", line
1148, in complete
     await future
 TypeError: Passing coroutines is forbidden, use tasks explicitly.


 Ok:                 0
 Expected Fail:      0
 Fail:               0
 Unexpected Pass:    0
 Skipped:            0
 Timeout:            0

--000000000000b5222e06352bdc90
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, May 15,=
 2025 at 1:40=E2=80=AFPM David Marchand &lt;<a href=3D"mailto:david.marchan=
d@redhat.com">david.marchand@redhat.com</a>&gt; wrote:<br></div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex"><br>
<br>
Retests show the same error, so I think we are hitting the issue fixed<br>
with dbcd72f3fba0.<br>
<br>
Bumping the minimal version to 0.57.2 seems fine.<br>
I looked and can&#39;t find a distrib that ships meson 0.57.<br>
So either a user relies on the distrib version (with a version &gt;=3D<br>
0.58, from my quick search) or the distrib provided version is too old<br>
and then the user relies on pip.<br><br></blockquote><div><br></div><div><b=
r></div><div>FYI here&#39;s the stacktrace below which is not making it to =
the testlog on the dashboard (something for UNH people to look at). But yes=
 it&#39;s the same issue fixed with=C2=A0dbcd72f3fba0babd2d801c2c63ee537df4=
59df66</div><div><br></div><div>---------</div><div><br></div><div><br></di=
v>=C2=A0Exception in callback TestHarness._run_tests.&lt;locals&gt;.test_do=
ne(&lt;Task finishe...explicitly.&#39;)&gt;) at /usr/local/lib/python3.12/s=
ite-packages/mesonbuild/mtest.py:1806<br>=C2=A0handle: &lt;Handle TestHarne=
ss._run_tests.&lt;locals&gt;.test_done(&lt;Task finishe...explicitly.&#39;)=
&gt;) at /usr/local/lib/python3.12/site-packages/mesonbuild/mtest.py:1806&g=
t;<br>=C2=A0Traceback (most recent call last):<br>=C2=A0 =C2=A0File &quot;/=
usr/lib64/python3.12/asyncio/events.py&quot;, line 88, in _run<br>=C2=A0 =
=C2=A0 =C2=A0self._context.run(self._callback, *self._args)<br>=C2=A0 =C2=
=A0File &quot;/usr/local/lib/python3.12/site-packages/mesonbuild/mtest.py&q=
uot;, line 1808, in test_done<br>=C2=A0 =C2=A0 =C2=A0f.result()<br>=C2=A0 =
=C2=A0File &quot;/usr/local/lib/python3.12/site-packages/mesonbuild/mtest.p=
y&quot;, line 1803, in run_test<br>=C2=A0 =C2=A0 =C2=A0res =3D await test.r=
un(self)<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^^^^^^^^^^^^^^^^^^^^<b=
r>=C2=A0 =C2=A0File &quot;/usr/local/lib/python3.12/site-packages/mesonbuil=
d/mtest.py&quot;, line 1349, in run<br>=C2=A0 =C2=A0 =C2=A0await self._run_=
cmd(harness, cmd)<br>=C2=A0 =C2=A0File &quot;/usr/local/lib/python3.12/site=
-packages/mesonbuild/mtest.py&quot;, line 1415, in _run_cmd<br>=C2=A0 =C2=
=A0 =C2=A0returncode, result, additional_error =3D await p.wait(self.runobj=
.timeout)<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^<br>=C2=A0 =C2=A0File &q=
uot;/usr/local/lib/python3.12/site-packages/mesonbuild/mtest.py&quot;, line=
 1241, in wait<br>=C2=A0 =C2=A0 =C2=A0await try_wait_one(p.wait(), timeout=
=3Dtimeout)<br>=C2=A0 =C2=A0File &quot;/usr/local/lib/python3.12/site-packa=
ges/mesonbuild/mtest.py&quot;, line 1132, in try_wait_one<br>=C2=A0 =C2=A0 =
=C2=A0await asyncio.wait(awaitables,<br>=C2=A0 =C2=A0File &quot;/usr/lib64/=
python3.12/asyncio/tasks.py&quot;, line 461, in wait<br>=C2=A0 =C2=A0 =C2=
=A0raise TypeError(&quot;Passing coroutines is forbidden, use tasks explici=
tly.&quot;)<br>=C2=A0TypeError: Passing coroutines is forbidden, use tasks =
explicitly.<br>=C2=A0/usr/lib64/python3.12/asyncio/events.py:88: RuntimeWar=
ning: coroutine &#39;Process.wait&#39; was never awaited<br>=C2=A0 =C2=A0se=
lf._context.run(self._callback, *self._args)<br>=C2=A0RuntimeWarning: Enabl=
e tracemalloc to get the object allocation traceback<br>=C2=A0Traceback (mo=
st recent call last):<br>=C2=A0 =C2=A0File &quot;/usr/local/lib/python3.12/=
site-packages/mesonbuild/mesonmain.py&quot;, line 132, in run<br>=C2=A0 =C2=
=A0 =C2=A0return options.run_func(options)<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 ^^^^^^^^^^^^^^^^^^^^^^^^^<br>=C2=A0 =C2=A0File &quot;/usr/loc=
al/lib/python3.12/site-packages/mesonbuild/mtest.py&quot;, line 1953, in ru=
n<br>=C2=A0 =C2=A0 =C2=A0return th.doit()<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 ^^^^^^^^^<br>=C2=A0 =C2=A0File &quot;/usr/local/lib/python3.1=
2/site-packages/mesonbuild/mtest.py&quot;, line 1641, in doit<br>=C2=A0 =C2=
=A0 =C2=A0self.run_tests(runners)<br>=C2=A0 =C2=A0File &quot;/usr/local/lib=
/python3.12/site-packages/mesonbuild/mtest.py&quot;, line 1780, in run_test=
s<br>=C2=A0 =C2=A0 =C2=A0loop.run_until_complete(self._run_tests(runners))<=
br>=C2=A0 =C2=A0File &quot;/usr/lib64/python3.12/asyncio/base_events.py&quo=
t;, line 687, in run_until_complete<br>=C2=A0 =C2=A0 =C2=A0return future.re=
sult()<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^^^^^^^^^^^^^^^<br>=C2=
=A0 =C2=A0File &quot;/usr/local/lib/python3.12/site-packages/mesonbuild/mte=
st.py&quot;, line 1871, in _run_tests<br>=C2=A0 =C2=A0 =C2=A0await complete=
(future)<br>=C2=A0 =C2=A0File &quot;/usr/local/lib/python3.12/site-packages=
/mesonbuild/mtest.py&quot;, line 1148, in complete<br>=C2=A0 =C2=A0 =C2=A0a=
wait future<br>=C2=A0TypeError: Passing coroutines is forbidden, use tasks =
explicitly.<br>=C2=A0<br>=C2=A0<br>=C2=A0Ok: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 0 =C2=A0 <br>=C2=A0Expected Fail: =C2=A0 =C2=A0=
 =C2=A00 =C2=A0 <br>=C2=A0Fail: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 0 =C2=A0 <br>=C2=A0Unexpected Pass: =C2=A0 =C2=A00 =C2=A0 <br>=C2=A0=
Skipped: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00 =C2=A0 <br><div>=C2=A0T=
imeout: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00=C2=A0 =C2=A0</div></div>=
</div>

--000000000000b5222e06352bdc90--
