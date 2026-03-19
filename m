Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EB421091916
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Mar 2026 20:47:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4DE98402AC;
	Thu, 19 Mar 2026 21:47:17 +0100 (CET)
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
 by mails.dpdk.org (Postfix) with ESMTP id 5AD0F4013F
 for <dev@dpdk.org>; Thu, 19 Mar 2026 21:47:16 +0100 (CET)
Received: by mail-dl1-f48.google.com with SMTP id
 a92af1059eb24-126ea4e9694so668352c88.1
 for <dev@dpdk.org>; Thu, 19 Mar 2026 13:47:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773953235; cv=none;
 d=google.com; s=arc-20240605;
 b=NbNrTfOAPTYeVp2XjW16I2LkdKPSqqmRguAzkl5RZru2fZ4YaiXYamIqLYsHvhqmtD
 yFsr+qCgZbsOKvQ55sUS0lwtPahmpfRRjaUWgqt4QlcWRA6GfT2PwjFSJPRDZBxYVI7x
 vYwBieOzmKiHaXg2e5d3MdSHJWrOms4RHbpxADVvZKJ8b1mKuT+j6U72WkPwNGqe9gaC
 JIQ3GAKshEeHm4etD20f7k8TxOmGUaV9dlP6qCSBlIkYxtS7FRIwrWV9RVUqD+OnmHS2
 +Sp8ln/E3qXEBPsAqz2t1Bv+qvY6lCP3lk1WH6j5VMcF22vyJuUa+hyRaSD4WxSZjj+h
 WlBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=pLJ1/U4pvm9VHlxfRWdPk/0DtJAP8qDmu9vUs6igWOc=;
 fh=9YWi/qTt6y1yNPsughEGfv6FaHHmY2vwCSeZowWBMgM=;
 b=Xe5WbG/NxzobNv9qhKXPd1MOqxU4hWZWvSLG4G7Lsd3jrmmTxzGDAcXu61w8YLSoWi
 KhIEHCuceT4fGLLuGv51u3QbuDoY6wF2qI6duClRryHVAcva7qoDZQBZEZCI2YKdm6ta
 rviXRmrW+cxdv648r5CWkXRZb1RZfRASizbb3ly1on00R4EM74NNenb09wJ/o2w7yIRR
 kGvr/OxM0yVTWxftdukp6cL4fRSziWTf0G56Q/DlY2vcT7ZY9EHNsTJAErtJ0CX1Zxhi
 +nbuKOa6Qma54CrZwUu2HnW8ZebB+BSxrWwj1Exga4VutXqtkuCK+hj34JDvWpMYlh6/
 smIg==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1773953235; x=1774558035; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pLJ1/U4pvm9VHlxfRWdPk/0DtJAP8qDmu9vUs6igWOc=;
 b=Kc5fu91ecbksr4ryR4aO6E3wCGiADM6pRMai+dQvgc5xENU5xsKi9mNG/gA3FtFh+n
 Ez/WrhtwzvIgJcIWj3YNmWjO9CQv5bcg46biJnFqoP3hPyy2e9xKfQjleb0Y8Lm0Ac30
 ihoP7RwqddqHucGrG4JiKEbOp1DJ4y23AIUtk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773953235; x=1774558035;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pLJ1/U4pvm9VHlxfRWdPk/0DtJAP8qDmu9vUs6igWOc=;
 b=KWaIAj/gNvYx3k7rVmo01PnJSOVF+e+GzqXLmpHgt9r2b9TwgfG0QlKMB2yK+7hjoX
 V3TfCmqmldnDdoL3eYuA91yjBYcg2WIa9eMPtC8bHc7BvaSBaocYrnP1aBGUznqs2DJw
 oNJp++ZcG0kJ5rZRTcO46fN5yKWdLwV44BWq0rTSNgZY8GZZrEsaXYotGmIeSy1oA9jL
 cAKvlfweugBbHWNzdkUHDTJ0o9BaaPIHR7KKeJHSORq0PFX+BVsVEHEAut/LJ3uOrCPy
 G7Nl5qOxsCLm7n1L3eoDbVdNzwXxQCUbV9C4ccai5Mtut+NrNwaFHO3Wwtyq4Dzg0Pgh
 ZU8w==
X-Gm-Message-State: AOJu0YzKty1P2dGA0D2yf3qmWSFpImE6zcF5Pme0M2eI5s9yD4ipAUfn
 tpHG1GI/hBiTUebgJET7Q6mPKabWNsTHtz7ZBIhnd2w0J1JT1wryivG4xBrsVlvx9svbTds8ego
 BIUtRgrSyRhezmUNf6766UPl945piG7/B2JxT7vgSEg==
X-Gm-Gg: ATEYQzwlXTNWN7M03tWAJ/zKkm7uk1ti4F1fMUa8f7RForJHAa9gOQwUIelSMZ+A3zs
 d+9WqrjKVvcONtbaFfOFxadtkk1SnbwSotWUD/kC6Bq6inIKlqUwKgKh7DmBbRHunzrmt0mMRI9
 eBdygLYzXGFOC49qzRJjy0aOGIQAWHSrT/yoiONhGQjTToo7SQuPDIrVnnTGBrhX+LV1PqfBxsg
 bluiUiNBaUHScnvwnpsvuCpqcf3cASZ1o8Wgihj9ynpY6xhXvC6J4fEn0dw/usYHovH/ZMqCZJ1
 5Y7/yVI8T+6d8ojbnmd5EJzhl+LtvZUcqDeFMnpoWDK+j2V88GWPgCmwRsVQr1zX
X-Received: by 2002:a05:7022:6711:b0:128:d87b:8e7c with SMTP id
 a92af1059eb24-12a7264e141mr355636c88.7.1773953235302; Thu, 19 Mar 2026
 13:47:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260319171334.1151425-1-bruce.richardson@intel.com>
In-Reply-To: <20260319171334.1151425-1-bruce.richardson@intel.com>
From: Patrick Robb <probb@iol.unh.edu>
Date: Thu, 19 Mar 2026 16:44:04 -0400
X-Gm-Features: AaiRm50mKnYlpsQl9jRfRa2brxGELt0inDmBG8UTinJub81sng-co3RyBxVtkRU
Message-ID: <CAJvnSUDr8oiCEKX_=Q6unP1QSsYQngQU5A4NGJ4k08ZdrSDrcQ@mail.gmail.com>
Subject: Re: [PATCH 0/7] Get fast-test suite to run on FreeBSD
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, lylavoie@iol.unh.edu, david.marchand@redhat.com
Content-Type: multipart/alternative; boundary="0000000000007048e0064d66acc2"
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

--0000000000007048e0064d66acc2
Content-Type: text/plain; charset="UTF-8"

Tested-by: Patrick Robb <probb@iol.unh.edu>

Okay, applied the patchseries and did a run on FreeBSD 14. Looks like the
suites are passing but a timeout exception is raised (on the test framework
execution, not on a testcase itself).

100/137 DPDK:fast-tests / pflock_autotest
OK              0.58s
101/137 DPDK:fast-tests / pie_autotest
 OK              0.08s
102/137 DPDK:fast-tests / ring_pmd_autotest
OK              0.05s
103/137 DPDK:fast-tests / prefetch_autotest
OK              0.05s
104/137 DPDK:fast-tests / ptr_compress_autotest
OK              0.17s
105/137 DPDK:fast-tests / rawdev_autotest
OK              0.05s
106/137 DPDK:fast-tests / rcu_qsbr_autotest
OK              0.45s
107/137 DPDK:fast-tests / reorder_autotest
 OK              0.25s
Exception in callback TestHarness._run_tests.<locals>.test_done(<Task
finishe...explicitly.')>) at
/usr/local/lib/python3.11/site-packages/mesonbuild/mtest.py:1837
handle: <Handle TestHarness._run_tests.<locals>.test_done(<Task
finishe...explicitly.')>) at
/usr/local/lib/python3.11/site-packages/mesonbuild/mtest.py:1837>
Traceback (most recent call last):
  File "/usr/local/lib/python3.11/site-packages/mesonbuild/mtest.py", line
1268, in wait
    await complete_all(self.all_futures, timeout=timeout)
  File "/usr/local/lib/python3.11/site-packages/mesonbuild/mtest.py", line
1180, in complete_all
    check_futures(futures)
  File "/usr/local/lib/python3.11/site-packages/mesonbuild/mtest.py", line
1168, in check_futures
    raise asyncio.TimeoutError
TimeoutError

During handling of the above exception, another exception occurred:

Traceback (most recent call last):
  File "/usr/local/lib/python3.11/asyncio/events.py", line 84, in _run
    self._context.run(self._callback, *self._args)
  File "/usr/local/lib/python3.11/site-packages/mesonbuild/mtest.py", line
1839, in test_done
    f.result()
  File "/usr/local/lib/python3.11/site-packages/mesonbuild/mtest.py", line
1834, in run_test
    res = await test.run(self)
          ^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.11/site-packages/mesonbuild/mtest.py", line
1376, in run
    await self._run_cmd(harness, cmd)
  File "/usr/local/lib/python3.11/site-packages/mesonbuild/mtest.py", line
1442, in _run_cmd
    returncode, result, additional_error = await p.wait(self.runobj.timeout)
                                           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.11/site-packages/mesonbuild/mtest.py", line
1270, in wait
    additional_error = await self._kill()
                       ^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.11/site-packages/mesonbuild/mtest.py", line
1231, in _kill
    await try_wait_one(p.wait(), timeout=0.5)
  File "/usr/local/lib/python3.11/site-packages/mesonbuild/mtest.py", line
1133, in try_wait_one
    await asyncio.wait(awaitables,
  File "/usr/local/lib/python3.11/asyncio/tasks.py", line 425, in wait
    raise TypeError("Passing coroutines is forbidden, use tasks
explicitly.")
TypeError: Passing coroutines is forbidden, use tasks explicitly.
/usr/local/lib/python3.11/asyncio/events.py:84: RuntimeWarning: coroutine
'Process.wait' was never awaited
  self._context.run(self._callback, *self._args)
RuntimeWarning: Enable tracemalloc to get the object allocation traceback


Ok:                 87
Expected Fail:      0
Fail:               0
Unexpected Pass:    0
Skipped:            20
Timeout:            0

Full log written to /tmp/dpdk/build2/meson-logs/testlog.txt
Traceback (most recent call last):
  File "/usr/local/lib/python3.11/site-packages/mesonbuild/mtest.py", line
1268, in wait
    await complete_all(self.all_futures, timeout=timeout)
  File "/usr/local/lib/python3.11/site-packages/mesonbuild/mtest.py", line
1180, in complete_all
    check_futures(futures)
  File "/usr/local/lib/python3.11/site-packages/mesonbuild/mtest.py", line
1168, in check_futures
    raise asyncio.TimeoutError
TimeoutError

During handling of the above exception, another exception occurred:

Traceback (most recent call last):
  File "/usr/local/lib/python3.11/site-packages/mesonbuild/mesonmain.py",
line 132, in run
    return options.run_func(options)
           ^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.11/site-packages/mesonbuild/mtest.py", line
1989, in run
    return th.doit()
           ^^^^^^^^^
  File "/usr/local/lib/python3.11/site-packages/mesonbuild/mtest.py", line
1672, in doit
    self.run_tests(runners)
  File "/usr/local/lib/python3.11/site-packages/mesonbuild/mtest.py", line
1811, in run_tests
    loop.run_until_complete(self._run_tests(runners))
  File "/usr/local/lib/python3.11/asyncio/base_events.py", line 654, in
run_until_complete
    return future.result()
           ^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.11/site-packages/mesonbuild/mtest.py", line
1901, in _run_tests
    await complete(future)
  File "/usr/local/lib/python3.11/site-packages/mesonbuild/mtest.py", line
1147, in complete
    await future
TypeError: Passing coroutines is forbidden, use tasks explicitly.
root@dpdk-freebsd14:/tmp/dpdk/build2 # echo $?
2

--0000000000007048e0064d66acc2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Tested-by: Patrick Robb &lt;<a href=3D"mailto:probb@iol.un=
h.edu">probb@iol.unh.edu</a>&gt;<div><br></div><div>Okay, applied the patch=
series and did a run on FreeBSD 14. Looks like the suites are passing but a=
 timeout exception is raised (on the test framework execution, not on a tes=
tcase itself).</div><div><br></div><div>100/137 DPDK:fast-tests / pflock_au=
totest =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OK =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00.58s<br>101/137 DPDK:fast-tests / pie_autot=
est =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0OK =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00.08s<br>102/137 DPDK:fast-tests / ri=
ng_pmd_autotest =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OK =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00.05s<br>103/137 DPDK:fast-tests / prefetch_=
autotest =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OK =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A00.05s<br>104/137 DPDK:fast-tests / ptr_compress_aut=
otest =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OK =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A00.17s<br>105/137 DPDK:fast-tests / rawdev_autotest =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 OK =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A00.05s<br>106/137 DPDK:fast-tests / rcu_qsbr_autotest =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 OK =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A00.45s<br>107/137 DPDK:fast-tests / reorder_autotest =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0OK =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
0.25s<br>Exception in callback TestHarness._run_tests.&lt;locals&gt;.test_d=
one(&lt;Task finishe...explicitly.&#39;)&gt;) at /usr/local/lib/python3.11/=
site-packages/mesonbuild/mtest.py:1837<br>handle: &lt;Handle TestHarness._r=
un_tests.&lt;locals&gt;.test_done(&lt;Task finishe...explicitly.&#39;)&gt;)=
 at /usr/local/lib/python3.11/site-packages/mesonbuild/mtest.py:1837&gt;<br=
>Traceback (most recent call last):<br>=C2=A0 File &quot;/usr/local/lib/pyt=
hon3.11/site-packages/mesonbuild/mtest.py&quot;, line 1268, in wait<br>=C2=
=A0 =C2=A0 await complete_all(self.all_futures, timeout=3Dtimeout)<br>=C2=
=A0 File &quot;/usr/local/lib/python3.11/site-packages/mesonbuild/mtest.py&=
quot;, line 1180, in complete_all<br>=C2=A0 =C2=A0 check_futures(futures)<b=
r>=C2=A0 File &quot;/usr/local/lib/python3.11/site-packages/mesonbuild/mtes=
t.py&quot;, line 1168, in check_futures<br>=C2=A0 =C2=A0 raise asyncio.Time=
outError<br>TimeoutError<br><br>During handling of the above exception, ano=
ther exception occurred:<br><br>Traceback (most recent call last):<br>=C2=
=A0 File &quot;/usr/local/lib/python3.11/asyncio/events.py&quot;, line 84, =
in _run<br>=C2=A0 =C2=A0 self._context.run(self._callback, *self._args)<br>=
=C2=A0 File &quot;/usr/local/lib/python3.11/site-packages/mesonbuild/mtest.=
py&quot;, line 1839, in test_done<br>=C2=A0 =C2=A0 f.result()<br>=C2=A0 Fil=
e &quot;/usr/local/lib/python3.11/site-packages/mesonbuild/mtest.py&quot;, =
line 1834, in run_test<br>=C2=A0 =C2=A0 res =3D await test.run(self)<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^^^^^^^^^^^^^^^^^^^^<br>=C2=A0 File &quot;/=
usr/local/lib/python3.11/site-packages/mesonbuild/mtest.py&quot;, line 1376=
, in run<br>=C2=A0 =C2=A0 await self._run_cmd(harness, cmd)<br>=C2=A0 File =
&quot;/usr/local/lib/python3.11/site-packages/mesonbuild/mtest.py&quot;, li=
ne 1442, in _run_cmd<br>=C2=A0 =C2=A0 returncode, result, additional_error =
=3D await p.wait(self.runobj.timeout)<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^=
^^^<br>=C2=A0 File &quot;/usr/local/lib/python3.11/site-packages/mesonbuild=
/mtest.py&quot;, line 1270, in wait<br>=C2=A0 =C2=A0 additional_error =3D a=
wait self._kill()<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^^^^^^^^^^^^^^^^^^<br>=C2=A0 File &quot;/usr=
/local/lib/python3.11/site-packages/mesonbuild/mtest.py&quot;, line 1231, i=
n _kill<br>=C2=A0 =C2=A0 await try_wait_one(p.wait(), timeout=3D0.5)<br>=C2=
=A0 File &quot;/usr/local/lib/python3.11/site-packages/mesonbuild/mtest.py&=
quot;, line 1133, in try_wait_one<br>=C2=A0 =C2=A0 await asyncio.wait(await=
ables,<br>=C2=A0 File &quot;/usr/local/lib/python3.11/asyncio/tasks.py&quot=
;, line 425, in wait<br>=C2=A0 =C2=A0 raise TypeError(&quot;Passing corouti=
nes is forbidden, use tasks explicitly.&quot;)<br>TypeError: Passing corout=
ines is forbidden, use tasks explicitly.<br>/usr/local/lib/python3.11/async=
io/events.py:84: RuntimeWarning: coroutine &#39;Process.wait&#39; was never=
 awaited<br>=C2=A0 self._context.run(self._callback, *self._args)<br>Runtim=
eWarning: Enable tracemalloc to get the object allocation traceback<br><br>=
<br>Ok: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 87 =C2=A0<b=
r>Expected Fail: =C2=A0 =C2=A0 =C2=A00 =C2=A0 <br>Fail: =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0 =C2=A0 <br>Unexpected Pass: =C2=A0 =C2=A0=
0 =C2=A0 <br>Skipped: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A020 =C2=A0<br=
>Timeout: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00 =C2=A0 <br><br>Full lo=
g written to /tmp/dpdk/build2/meson-logs/testlog.txt<br>Traceback (most rec=
ent call last):<br>=C2=A0 File &quot;/usr/local/lib/python3.11/site-package=
s/mesonbuild/mtest.py&quot;, line 1268, in wait<br>=C2=A0 =C2=A0 await comp=
lete_all(self.all_futures, timeout=3Dtimeout)<br>=C2=A0 File &quot;/usr/loc=
al/lib/python3.11/site-packages/mesonbuild/mtest.py&quot;, line 1180, in co=
mplete_all<br>=C2=A0 =C2=A0 check_futures(futures)<br>=C2=A0 File &quot;/us=
r/local/lib/python3.11/site-packages/mesonbuild/mtest.py&quot;, line 1168, =
in check_futures<br>=C2=A0 =C2=A0 raise asyncio.TimeoutError<br>TimeoutErro=
r<br><br>During handling of the above exception, another exception occurred=
:<br><br>Traceback (most recent call last):<br>=C2=A0 File &quot;/usr/local=
/lib/python3.11/site-packages/mesonbuild/mesonmain.py&quot;, line 132, in r=
un<br>=C2=A0 =C2=A0 return options.run_func(options)<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0^^^^^^^^^^^^^^^^^^^^^^^^^<br>=C2=A0 File &quot;/usr=
/local/lib/python3.11/site-packages/mesonbuild/mtest.py&quot;, line 1989, i=
n run<br>=C2=A0 =C2=A0 return th.doit()<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0^^^^^^^^^<br>=C2=A0 File &quot;/usr/local/lib/python3.11/site-pac=
kages/mesonbuild/mtest.py&quot;, line 1672, in doit<br>=C2=A0 =C2=A0 self.r=
un_tests(runners)<br>=C2=A0 File &quot;/usr/local/lib/python3.11/site-packa=
ges/mesonbuild/mtest.py&quot;, line 1811, in run_tests<br>=C2=A0 =C2=A0 loo=
p.run_until_complete(self._run_tests(runners))<br>=C2=A0 File &quot;/usr/lo=
cal/lib/python3.11/asyncio/base_events.py&quot;, line 654, in run_until_com=
plete<br>=C2=A0 =C2=A0 return future.result()<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0^^^^^^^^^^^^^^^<br>=C2=A0 File &quot;/usr/local/lib/python=
3.11/site-packages/mesonbuild/mtest.py&quot;, line 1901, in _run_tests<br>=
=C2=A0 =C2=A0 await complete(future)<br>=C2=A0 File &quot;/usr/local/lib/py=
thon3.11/site-packages/mesonbuild/mtest.py&quot;, line 1147, in complete<br=
>=C2=A0 =C2=A0 await future<br>TypeError: Passing coroutines is forbidden, =
use tasks explicitly.<br>root@dpdk-freebsd14:/tmp/dpdk/build2 # echo $?<br>=
2<br></div></div>

--0000000000007048e0064d66acc2--
