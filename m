Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D421C36002
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Mar 2025 10:26:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3408540655;
	Mon, 24 Mar 2025 11:26:10 +0100 (CET)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 28121402DA
 for <dev@dpdk.org>; Mon, 24 Mar 2025 11:26:09 +0100 (CET)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id E38D046466; Mon, 24 Mar 2025 11:26:08 +0100 (CET)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/testpmd Bug 1680] ASan check failed during testpmd termination
Date: Mon, 24 Mar 2025 10:26:08 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: testpmd
X-Bugzilla-Version: 25.03
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: iafaneh@nvidia.com
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone
Message-ID: <bug-1680-3@http.bugs.dpdk.org/>
Content-Type: multipart/alternative; boundary=17428119680.BAf02B0.3370184
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


--17428119680.BAf02B0.3370184
Date: Mon, 24 Mar 2025 11:26:08 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: http://bugs.dpdk.org/
Auto-Submitted: auto-generated
X-Auto-Response-Suppress: All

https://bugs.dpdk.org/show_bug.cgi?id=3D1680

            Bug ID: 1680
           Summary: ASan check failed during testpmd termination
           Product: DPDK
           Version: 25.03
          Hardware: All
                OS: Linux
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: testpmd
          Assignee: dev@dpdk.org
          Reporter: iafaneh@nvidia.com
  Target Milestone: ---

To reproduce, build DPDK with "-Db_sanitize=3Daddress", then run and quit
testpmd:

$ bin/dpdk-testpmd -n 4  -a 0000:08:00.0  -a 0000:08:00.1 -- --mbcache=3D51=
2 -i=20
--nb-cores=3D1  --txd=3D256 --rxd=3D256

Result after quitting app:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D197123=3D=3DAddressSanitizer CHECK failed:
../../../../src/libsanitizer/asan/asan_thread.cpp:367 "((ptr[0] =3D=3D
kCurrentStackFrameMagic)) !=3D (0)" (0x0, 0x0)
    #0 0x7f1374d18988 in AsanCheckFailed
../../../../src/libsanitizer/asan/asan_rtl.cpp:74
    #1 0x7f1374d3930e in __sanitizer::CheckFailed(char const*, int, char
const*, unsigned long long, unsigned long long)
../../../../src/libsanitizer/sanitizer_common/sanitizer_termination.cpp:78
    #2 0x7f1374d1e10c in __asan::AsanThread::GetStackFrameAccessByAddr(unsi=
gned
long, __asan::AsanThread::StackFrameAccess*)
../../../../src/libsanitizer/asan/asan_thread.cpp:367
    #3 0x7f1374c88e9b in __asan::GetStackAddressInformation(unsigned long,
unsigned long, __asan::StackAddressDescription*)
../../../../src/libsanitizer/asan/asan_descriptions.cpp:203
    #4 0x7f1374c8a2d8 in
__asan::AddressDescription::AddressDescription(unsigned long, unsigned long,
bool) ../../../../src/libsanitizer/asan/asan_descriptions.cpp:455
    #5 0x7f1374c8a2d8 in
__asan::AddressDescription::AddressDescription(unsigned long, unsigned long,
bool) ../../../../src/libsanitizer/asan/asan_descriptions.cpp:439
    #6 0x7f1374c8ca84 in __asan::ErrorGeneric::ErrorGeneric(unsigned int,
unsigned long, unsigned long, unsigned long, unsigned long, bool, unsigned
long) ../../../../src/libsanitizer/asan/asan_errors.cpp:389
    #7 0x7f1374d17fa5 in __asan::ReportGenericError(unsigned long, unsigned
long, unsigned long, unsigned long, bool, unsigned long, unsigned int, bool)
../../../../src/libsanitizer/asan/asan_report.cpp:476
    #8 0x7f1374caefe8 in __interceptor_sigaltstack
../../../../src/libsanitizer/sanitizer_common/sanitizer_common_interceptors=
.inc:9986
    #9 0x7f1374d2d867 in __sanitizer::UnsetAlternateSignalStack()
../../../../src/libsanitizer/sanitizer_common/sanitizer_posix_libcdep.cpp:1=
95
    #10 0x7f1374d1d60c in __asan::AsanThread::Destroy()
../../../../src/libsanitizer/asan/asan_thread.cpp:104
    #11 0x7f1374414710 in __GI___nptl_deallocate_tsd
nptl/nptl_deallocate_tsd.c:73
    #12 0x7f1374414710 in __GI___nptl_deallocate_tsd
nptl/nptl_deallocate_tsd.c:22
    #13 0x7f13744179c9 in start_thread nptl/pthread_create.c:453
    #14 0x7f13744a99ff  (/lib/x86_64-linux-gnu/libc.so.6+0x1269ff)

Environment info:
Device: ConnectX-6 DX
OS: Ubuntu 22.04
Kernel: 5.15.0-25-generic
MLNX_OFED: MLNX_OFED_LINUX-25.01-0.6.0
FW: 22.44.1036
DPDK version: 25.03.0-rc3

--=20
You are receiving this mail because:
You are the assignee for the bug.=

--17428119680.BAf02B0.3370184
Date: Mon, 24 Mar 2025 11:26:08 +0100
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
   title=3D"UNCONFIRMED - ASan check failed during testpmd termination"
   href=3D"https://bugs.dpdk.org/show_bug.cgi?id=3D1680">1680</a>
          </td>
        </tr>

        <tr>
          <th>Summary</th>
          <td>ASan check failed during testpmd termination
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
          <td>All
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
          <td>testpmd
          </td>
        </tr>

        <tr>
          <th>Assignee</th>
          <td>dev&#64;dpdk.org
          </td>
        </tr>

        <tr>
          <th>Reporter</th>
          <td>iafaneh&#64;nvidia.com
          </td>
        </tr>

        <tr>
          <th>Target Milestone</th>
          <td>---
          </td>
        </tr></table>
      <p>
        <div class=3D"bz_comment_block">
          <pre class=3D"bz_comment_text">To reproduce, build DPDK with &quo=
t;-Db_sanitize=3Daddress&quot;, then run and quit
testpmd:

$ bin/dpdk-testpmd -n 4  -a 0000:08:00.0  -a 0000:08:00.1 -- --mbcache=3D51=
2 -i=20
--nb-cores=3D1  --txd=3D256 --rxd=3D256

Result after quitting app:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D197123=3D=3DAddressSanitizer CHECK failed:
../../../../src/libsanitizer/asan/asan_thread.cpp:367 &quot;((ptr[0] =3D=3D
kCurrentStackFrameMagic)) !=3D (0)&quot; (0x0, 0x0)
    #0 0x7f1374d18988 in AsanCheckFailed
../../../../src/libsanitizer/asan/asan_rtl.cpp:74
    #1 0x7f1374d3930e in __sanitizer::CheckFailed(char const*, int, char
const*, unsigned long long, unsigned long long)
../../../../src/libsanitizer/sanitizer_common/sanitizer_termination.cpp:78
    #2 0x7f1374d1e10c in __asan::AsanThread::GetStackFrameAccessByAddr(unsi=
gned
long, __asan::AsanThread::StackFrameAccess*)
../../../../src/libsanitizer/asan/asan_thread.cpp:367
    #3 0x7f1374c88e9b in __asan::GetStackAddressInformation(unsigned long,
unsigned long, __asan::StackAddressDescription*)
../../../../src/libsanitizer/asan/asan_descriptions.cpp:203
    #4 0x7f1374c8a2d8 in
__asan::AddressDescription::AddressDescription(unsigned long, unsigned long,
bool) ../../../../src/libsanitizer/asan/asan_descriptions.cpp:455
    #5 0x7f1374c8a2d8 in
__asan::AddressDescription::AddressDescription(unsigned long, unsigned long,
bool) ../../../../src/libsanitizer/asan/asan_descriptions.cpp:439
    #6 0x7f1374c8ca84 in __asan::ErrorGeneric::ErrorGeneric(unsigned int,
unsigned long, unsigned long, unsigned long, unsigned long, bool, unsigned
long) ../../../../src/libsanitizer/asan/asan_errors.cpp:389
    #7 0x7f1374d17fa5 in __asan::ReportGenericError(unsigned long, unsigned
long, unsigned long, unsigned long, bool, unsigned long, unsigned int, bool)
../../../../src/libsanitizer/asan/asan_report.cpp:476
    #8 0x7f1374caefe8 in __interceptor_sigaltstack
../../../../src/libsanitizer/sanitizer_common/sanitizer_common_interceptors=
.inc:9986
    #9 0x7f1374d2d867 in __sanitizer::UnsetAlternateSignalStack()
../../../../src/libsanitizer/sanitizer_common/sanitizer_posix_libcdep.cpp:1=
95
    #10 0x7f1374d1d60c in __asan::AsanThread::Destroy()
../../../../src/libsanitizer/asan/asan_thread.cpp:104
    #11 0x7f1374414710 in __GI___nptl_deallocate_tsd
nptl/nptl_deallocate_tsd.c:73
    #12 0x7f1374414710 in __GI___nptl_deallocate_tsd
nptl/nptl_deallocate_tsd.c:22
    #13 0x7f13744179c9 in start_thread nptl/pthread_create.c:453
    #14 0x7f13744a99ff  (/lib/x86_64-linux-gnu/libc.so.6+0x1269ff)

Environment info:
Device: ConnectX-6 DX
OS: Ubuntu 22.04
Kernel: 5.15.0-25-generic
MLNX_OFED: MLNX_OFED_LINUX-25.01-0.6.0
FW: 22.44.1036
DPDK version: 25.03.0-rc3
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
?id=3D1680">
          <meta itemprop=3D"name" content=3D"View bug">
        </div>
        <meta itemprop=3D"description" content=3D"Bugzilla bug update notif=
ication">
      </div>
    </body>
</html>=

--17428119680.BAf02B0.3370184--
