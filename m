Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 310C1C021B8
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Mar 2025 22:48:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5AB67402DF;
	Tue,  4 Mar 2025 23:48:45 +0100 (CET)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id C67B6402C5
 for <dev@dpdk.org>; Tue,  4 Mar 2025 23:48:44 +0100 (CET)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id AD0FE46344; Tue,  4 Mar 2025 23:48:44 +0100 (CET)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/core Bug 1668] EAL: rte_eal_mp_remote_launch is able to launch
 an lcore which is running
Date: Tue, 04 Mar 2025 22:48:44 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: core
X-Bugzilla-Version: 25.03
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: probb@iol.unh.edu
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone attachments.created
Message-ID: <bug-1668-3@http.bugs.dpdk.org/>
Content-Type: multipart/alternative; boundary=17411285240.7EEFbBfCa.6348
Content-Transfer-Encoding: 7bit
X-Bugzilla-URL: http://bugs.dpdk.org/
Auto-Submitted: auto-generated
X-Auto-Response-Suppress: All
MIME-Version: 1.0
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


--17411285240.7EEFbBfCa.6348
Date: Tue, 4 Mar 2025 23:48:44 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: http://bugs.dpdk.org/
Auto-Submitted: auto-generated
X-Auto-Response-Suppress: All

https://bugs.dpdk.org/show_bug.cgi?id=3D1668

            Bug ID: 1668
           Summary: EAL: rte_eal_mp_remote_launch is able to launch an
                    lcore which is running
           Product: DPDK
           Version: 25.03
          Hardware: x86
                OS: Linux
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: core
          Assignee: dev@dpdk.org
          Reporter: probb@iol.unh.edu
  Target Milestone: ---

Created attachment 303
  --> https://bugs.dpdk.org/attachment.cgi?id=3D303&action=3Dedit
Testlog

Branch: main

Environment info:

$ lscpu
Architecture:                       x86_64
CPU op-mode(s):                     32-bit, 64-bit
Byte Order:                         Little Endian
Address sizes:                      45 bits physical, 48 bits virtual
CPU(s):                             16
On-line CPU(s) list:                0-15
Thread(s) per core:                 1
Core(s) per socket:                 1
Socket(s):                          16
NUMA node(s):                       2
Vendor ID:                          GenuineIntel
CPU family:                         6
Model:                              85
Model name:                         Intel(R) Xeon(R) Gold 6246 CPU @ 3.30GHz

# gcc --version
gcc (Debian 10.2.1-6) 10.2.1 20210110

cat /etc/os-release=20
PRETTY_NAME=3D"Debian GNU/Linux 11 (bullseye)"

From UNH CI, we had a fail for dpdk-test per_lcore_autotest, due to
rte_eal_mp_remote_launch launching an lcore which is already running. I have
attached the testlogs, and the relevant blurgs are below.

78/119 DPDK:fast-tests / per_lcore_autotest             FAIL             1.=
14s=20
 (exit status 255 or signal 127 SIGinvalid)
16:49:56 DPDK_TEST=3Dper_lcore_autotest MALLOC_PERTURB_=3D178
/root/workspace/Generic-Unit-Test-DPDK/dpdk/build/app/dpdk-test --no-huge -m
2048
----------------------------------- output --------------------------------=
---
stdout:
RTE>>per_lcore_autotest
on socket 0, on core 1, variable is 1
wait 100ms on lcore 1
It does remote launch successfully but it should not at this time
Test Failed
RTE>>wait 100ms on lcore 1
stderr:
EAL: Detected CPU lcores: 16
EAL: Detected NUMA nodes: 2
EAL: Detected static linkage of DPDK
EAL: Multi-process socket /var/run/dpdk/rte/mp_socket
EAL: Selected IOVA mode 'VA'
EAL: VFIO support initialized
APP: HPET is not enabled, using TSC as default timer
---------------------------------------------------------------------------=
---

The test:

```
test_per_lcore(void)
{
unsigned lcore_id;
int ret;

rte_eal_mp_remote_launch(assign_vars, NULL, SKIP_MAIN);
RTE_LCORE_FOREACH_WORKER(lcore_id) {
if (rte_eal_wait_lcore(lcore_id) < 0)
return -1;
}

rte_eal_mp_remote_launch(display_vars, NULL, SKIP_MAIN);
RTE_LCORE_FOREACH_WORKER(lcore_id) {
if (rte_eal_wait_lcore(lcore_id) < 0)
return -1;
}

/* test if it could do remote launch twice at the same time or not */
ret =3D rte_eal_mp_remote_launch(test_per_lcore_delay, NULL, SKIP_MAIN);
if (ret < 0) {
printf("It fails to do remote launch but it should able to do\n");
return -1;
}
/* it should not be able to launch a lcore which is running */
ret =3D rte_eal_mp_remote_launch(test_per_lcore_delay, NULL, SKIP_MAIN);
if (ret =3D=3D 0) {
printf("It does remote launch successfully but it should not at this time\n=
");
return -1;
}
RTE_LCORE_FOREACH_WORKER(lcore_id) {
if (rte_eal_wait_lcore(lcore_id) < 0)
return -1;
}

return 0;
}
```

The patch which triggered the run which resulted in the fail has CI results
here, although it is unrelated to the failure: Patch:
https://lab.dpdk.org/results/dashboard/patchsets/32742/

I will also note that Debian 11 is EOL and should be removed from our CI. We
will do this, but I felt that I should add this bug anyhow since it is unli=
kely
to be caused by the OS version.

--=20
You are receiving this mail because:
You are the assignee for the bug.=

--17411285240.7EEFbBfCa.6348
Date: Tue, 4 Mar 2025 23:48:44 +0100
MIME-Version: 1.0
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: http://bugs.dpdk.org/
Auto-Submitted: auto-generated
X-Auto-Response-Suppress: All

<html>
    <head>
      <base href=3D"https://bugs.dpdk.org/">
    </head>
    <body><table border=3D"1" cellspacing=3D"0" cellpadding=3D"8" class=3D"=
bz_new_table">
        <tr>
          <th>Bug ID</th>
          <td><a class=3D"bz_bug_link=20
          bz_status_UNCONFIRMED "
   title=3D"UNCONFIRMED - EAL: rte_eal_mp_remote_launch is able to launch a=
n lcore which is running"
   href=3D"https://bugs.dpdk.org/show_bug.cgi?id=3D1668">1668</a>
          </td>
        </tr>

        <tr>
          <th>Summary</th>
          <td>EAL: rte_eal_mp_remote_launch is able to launch an lcore whic=
h is running
          </td>
        </tr>

        <tr>
          <th>Product</th>
          <td>DPDK
          </td>
        </tr>

        <tr>
          <th>Version</th>
          <td>25.03
          </td>
        </tr>

        <tr>
          <th>Hardware</th>
          <td>x86
          </td>
        </tr>

        <tr>
          <th>OS</th>
          <td>Linux
          </td>
        </tr>

        <tr>
          <th>Status</th>
          <td>UNCONFIRMED
          </td>
        </tr>

        <tr>
          <th>Severity</th>
          <td>normal
          </td>
        </tr>

        <tr>
          <th>Priority</th>
          <td>Normal
          </td>
        </tr>

        <tr>
          <th>Component</th>
          <td>core
          </td>
        </tr>

        <tr>
          <th>Assignee</th>
          <td>dev&#64;dpdk.org
          </td>
        </tr>

        <tr>
          <th>Reporter</th>
          <td>probb&#64;iol.unh.edu
          </td>
        </tr>

        <tr>
          <th>Target Milestone</th>
          <td>---
          </td>
        </tr></table>
      <p>
        <div class=3D"bz_comment_block">
          <pre class=3D"bz_comment_text">Created <span class=3D""><a href=
=3D"attachment.cgi?id=3D303" name=3D"attach_303" title=3D"Testlog">attachme=
nt 303</a> <a href=3D"attachment.cgi?id=3D303&amp;action=3Dedit" title=3D"T=
estlog">[details]</a></span>
Testlog

Branch: main

Environment info:

$ lscpu
Architecture:                       x86_64
CPU op-mode(s):                     32-bit, 64-bit
Byte Order:                         Little Endian
Address sizes:                      45 bits physical, 48 bits virtual
CPU(s):                             16
On-line CPU(s) list:                0-15
Thread(s) per core:                 1
Core(s) per socket:                 1
Socket(s):                          16
NUMA node(s):                       2
Vendor ID:                          GenuineIntel
CPU family:                         6
Model:                              85
Model name:                         Intel(R) Xeon(R) Gold 6246 CPU &#64; 3.=
30GHz

# gcc --version
gcc (Debian 10.2.1-6) 10.2.1 20210110

cat /etc/os-release=20
PRETTY_NAME=3D&quot;Debian GNU/Linux 11 (bullseye)&quot;

From UNH CI, we had a fail for dpdk-test per_lcore_autotest, due to
rte_eal_mp_remote_launch launching an lcore which is already running. I have
attached the testlogs, and the relevant blurgs are below.

78/119 DPDK:fast-tests / per_lcore_autotest             FAIL             1.=
14s=20
 (exit status 255 or signal 127 SIGinvalid)
16:49:56 DPDK_TEST=3Dper_lcore_autotest MALLOC_PERTURB_=3D178
/root/workspace/Generic-Unit-Test-DPDK/dpdk/build/app/dpdk-test --no-huge -m
2048
----------------------------------- output --------------------------------=
---
stdout:
RTE&gt;&gt;per_lcore_autotest
on socket 0, on core 1, variable is 1
wait 100ms on lcore 1
It does remote launch successfully but it should not at this time
Test Failed
RTE&gt;&gt;wait 100ms on lcore 1
stderr:
EAL: Detected CPU lcores: 16
EAL: Detected NUMA nodes: 2
EAL: Detected static linkage of DPDK
EAL: Multi-process socket /var/run/dpdk/rte/mp_socket
EAL: Selected IOVA mode 'VA'
EAL: VFIO support initialized
APP: HPET is not enabled, using TSC as default timer
---------------------------------------------------------------------------=
---

The test:

```
test_per_lcore(void)
{
unsigned lcore_id;
int ret;

rte_eal_mp_remote_launch(assign_vars, NULL, SKIP_MAIN);
RTE_LCORE_FOREACH_WORKER(lcore_id) {
if (rte_eal_wait_lcore(lcore_id) &lt; 0)
return -1;
}

rte_eal_mp_remote_launch(display_vars, NULL, SKIP_MAIN);
RTE_LCORE_FOREACH_WORKER(lcore_id) {
if (rte_eal_wait_lcore(lcore_id) &lt; 0)
return -1;
}

/* test if it could do remote launch twice at the same time or not */
ret =3D rte_eal_mp_remote_launch(test_per_lcore_delay, NULL, SKIP_MAIN);
if (ret &lt; 0) {
printf(&quot;It fails to do remote launch but it should able to do\n&quot;);
return -1;
}
/* it should not be able to launch a lcore which is running */
ret =3D rte_eal_mp_remote_launch(test_per_lcore_delay, NULL, SKIP_MAIN);
if (ret =3D=3D 0) {
printf(&quot;It does remote launch successfully but it should not at this t=
ime\n&quot;);
return -1;
}
RTE_LCORE_FOREACH_WORKER(lcore_id) {
if (rte_eal_wait_lcore(lcore_id) &lt; 0)
return -1;
}

return 0;
}
```

The patch which triggered the run which resulted in the fail has CI results
here, although it is unrelated to the failure: Patch:
<a href=3D"https://lab.dpdk.org/results/dashboard/patchsets/32742/">https:/=
/lab.dpdk.org/results/dashboard/patchsets/32742/</a>

I will also note that Debian 11 is EOL and should be removed from our CI. We
will do this, but I felt that I should add this bug anyhow since it is unli=
kely
to be caused by the OS version.
          </pre>
        </div>
      </p>


      <hr>
      <span>You are receiving this mail because:</span>

      <ul>
          <li>You are the assignee for the bug.</li>
      </ul>
      <div itemscope itemtype=3D"http://schema.org/EmailMessage">
        <div itemprop=3D"action" itemscope itemtype=3D"http://schema.org/Vi=
ewAction">
=20=20=20=20=20=20=20=20=20=20
          <link itemprop=3D"url" href=3D"https://bugs.dpdk.org/show_bug.cgi=
?id=3D1668">
          <meta itemprop=3D"name" content=3D"View bug">
        </div>
        <meta itemprop=3D"description" content=3D"Bugzilla bug update notif=
ication">
      </div>
    </body>
</html>=

--17411285240.7EEFbBfCa.6348--
