Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C65CDC77B7C
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Jul 2025 17:08:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2508D40267;
	Thu,  3 Jul 2025 19:08:02 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 9087240264
 for <dev@dpdk.org>; Thu,  3 Jul 2025 19:08:00 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 8865D46AE8; Thu,  3 Jul 2025 19:08:00 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/other Bug 1744] bus/flsmc: duplicate variable definition
Date: Thu, 03 Jul 2025 17:08:00 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: other
X-Bugzilla-Version: unspecified
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: stephen@networkplumber.org
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone
Message-ID: <bug-1744-3@https.bugs.dpdk.org/>
Content-Type: multipart/alternative; boundary=17515624800.DDc7229c.1310792
Content-Transfer-Encoding: 7bit
X-Bugzilla-URL: https://bugs.dpdk.org/
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


--17515624800.DDc7229c.1310792
Date: Thu, 3 Jul 2025 19:08:00 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugs.dpdk.org/
Auto-Submitted: auto-generated
X-Auto-Response-Suppress: All

https://bugs.dpdk.org/show_bug.cgi?id=3D1744

            Bug ID: 1744
           Summary: bus/flsmc: duplicate variable definition
           Product: DPDK
           Version: unspecified
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: other
          Assignee: dev@dpdk.org
          Reporter: stephen@networkplumber.org
  Target Milestone: ---

Building with -Wshadow reports:

In file included from ../drivers/bus/fslmc/portal/dpaa2_hw_dpci.c:27:
../drivers/bus/fslmc/portal/dpaa2_hw_dpci.c: In function
=E2=80=98rte_dpaa2_create_dpci_device=E2=80=99:
../drivers/bus/fslmc/portal/dpaa2_hw_pvt.h:207:13: warning: declaration of
=E2=80=98ret=E2=80=99 shadows a previous local [-Wshadow]
  207 |         int ret =3D 0, i; \
      |             ^~~
../drivers/bus/fslmc/portal/dpaa2_hw_dpci.c:99:23: note: in expansion of ma=
cro
=E2=80=98dpaa2_queue_storage_alloc=E2=80=99
   99 |                 ret =3D dpaa2_queue_storage_alloc(rxq, 1);
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~
../drivers/bus/fslmc/portal/dpaa2_hw_dpci.c:57:13: note: shadowed declarati=
on
is here
   57 |         int ret, i, dpci_id =3D obj->object_id;
      |             ^~~
../drivers/bus/fslmc/portal/dpaa2_hw_pvt.h:207:22: warning: declaration of =
=E2=80=98i=E2=80=99
shadows a previous local [-Wshadow]
  207 |         int ret =3D 0, i; \
      |                      ^
../drivers/bus/fslmc/portal/dpaa2_hw_dpci.c:99:23: note: in expansion of ma=
cro
=E2=80=98dpaa2_queue_storage_alloc=E2=80=99
   99 |                 ret =3D dpaa2_queue_storage_alloc(rxq, 1);
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~
../drivers/bus/fslmc/portal/dpaa2_hw_dpci.c:57:18: note: shadowed declarati=
on
is here
   57 |         int ret, i, dpci_id =3D obj->object_id;
      |                  ^
../drivers/bus/fslmc/portal/dpaa2_hw_pvt.h:226:13: warning: declaration of =
=E2=80=98i=E2=80=99
shadows a previous local [-Wshadow]
  226 |         int i; \
      |             ^
../drivers/bus/fslmc/portal/dpaa2_hw_dpci.c:148:17: note: in expansion of m=
acro
=E2=80=98dpaa2_queue_storage_free=E2=80=99
  148 |                 dpaa2_queue_storage_free(rxq, 1);
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~
../drivers/bus/fslmc/portal/dpaa2_hw_dpci.c:57:18: note: shadowed declarati=
on
is here
   57 |         int ret, i, dpci_id =3D obj->object_id;
      |                  ^

--=20
You are receiving this mail because:
You are the assignee for the bug.=

--17515624800.DDc7229c.1310792
Date: Thu, 3 Jul 2025 19:08:00 +0200
MIME-Version: 1.0
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugs.dpdk.org/
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
   title=3D"UNCONFIRMED - bus/flsmc: duplicate variable definition"
   href=3D"https://bugs.dpdk.org/show_bug.cgi?id=3D1744">1744</a>
          </td>
        </tr>

        <tr>
          <th>Summary</th>
          <td>bus/flsmc: duplicate variable definition
          </td>
        </tr>

        <tr>
          <th>Product</th>
          <td>DPDK
          </td>
        </tr>

        <tr>
          <th>Version</th>
          <td>unspecified
          </td>
        </tr>

        <tr>
          <th>Hardware</th>
          <td>All
          </td>
        </tr>

        <tr>
          <th>OS</th>
          <td>All
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
          <td>other
          </td>
        </tr>

        <tr>
          <th>Assignee</th>
          <td>dev&#64;dpdk.org
          </td>
        </tr>

        <tr>
          <th>Reporter</th>
          <td>stephen&#64;networkplumber.org
          </td>
        </tr>

        <tr>
          <th>Target Milestone</th>
          <td>---
          </td>
        </tr></table>
      <p>
        <div class=3D"bz_comment_block">
          <pre class=3D"bz_comment_text">Building with -Wshadow reports:

In file included from ../drivers/bus/fslmc/portal/dpaa2_hw_dpci.c:27:
../drivers/bus/fslmc/portal/dpaa2_hw_dpci.c: In function
=E2=80=98rte_dpaa2_create_dpci_device=E2=80=99:
../drivers/bus/fslmc/portal/dpaa2_hw_pvt.h:207:13: warning: declaration of
=E2=80=98ret=E2=80=99 shadows a previous local [-Wshadow]
  207 |         int ret =3D 0, i; \
      |             ^~~
../drivers/bus/fslmc/portal/dpaa2_hw_dpci.c:99:23: note: in expansion of ma=
cro
=E2=80=98dpaa2_queue_storage_alloc=E2=80=99
   99 |                 ret =3D dpaa2_queue_storage_alloc(rxq, 1);
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~
../drivers/bus/fslmc/portal/dpaa2_hw_dpci.c:57:13: note: shadowed declarati=
on
is here
   57 |         int ret, i, dpci_id =3D obj-&gt;object_id;
      |             ^~~
../drivers/bus/fslmc/portal/dpaa2_hw_pvt.h:207:22: warning: declaration of =
=E2=80=98i=E2=80=99
shadows a previous local [-Wshadow]
  207 |         int ret =3D 0, i; \
      |                      ^
../drivers/bus/fslmc/portal/dpaa2_hw_dpci.c:99:23: note: in expansion of ma=
cro
=E2=80=98dpaa2_queue_storage_alloc=E2=80=99
   99 |                 ret =3D dpaa2_queue_storage_alloc(rxq, 1);
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~
../drivers/bus/fslmc/portal/dpaa2_hw_dpci.c:57:18: note: shadowed declarati=
on
is here
   57 |         int ret, i, dpci_id =3D obj-&gt;object_id;
      |                  ^
../drivers/bus/fslmc/portal/dpaa2_hw_pvt.h:226:13: warning: declaration of =
=E2=80=98i=E2=80=99
shadows a previous local [-Wshadow]
  226 |         int i; \
      |             ^
../drivers/bus/fslmc/portal/dpaa2_hw_dpci.c:148:17: note: in expansion of m=
acro
=E2=80=98dpaa2_queue_storage_free=E2=80=99
  148 |                 dpaa2_queue_storage_free(rxq, 1);
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~
../drivers/bus/fslmc/portal/dpaa2_hw_dpci.c:57:18: note: shadowed declarati=
on
is here
   57 |         int ret, i, dpci_id =3D obj-&gt;object_id;
      |                  ^
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
?id=3D1744">
          <meta itemprop=3D"name" content=3D"View bug">
        </div>
        <meta itemprop=3D"description" content=3D"Bugzilla bug update notif=
ication">
      </div>
    </body>
</html>=

--17515624800.DDc7229c.1310792--
