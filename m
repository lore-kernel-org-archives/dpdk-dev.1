Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09CA8C5B542
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 May 2025 13:02:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 396E2402D6;
	Tue, 27 May 2025 15:02:02 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id D2F47402AE
 for <dev@dpdk.org>; Tue, 27 May 2025 15:02:00 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id CB46046806; Tue, 27 May 2025 15:02:00 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/core Bug 1713] dispatcher_autotest hangs on build with
 disabled RTE_USE_C11_MEM_MODEL
Date: Tue, 27 May 2025 13:02:00 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: core
X-Bugzilla-Version: 25.03
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: konstantin.v.ananyev@yandex.ru
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone
Message-ID: <bug-1713-3@http.bugs.dpdk.org/>
Content-Type: multipart/alternative; boundary=17483509200.Fb6Fcdf.2313538
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


--17483509200.Fb6Fcdf.2313538
Date: Tue, 27 May 2025 15:02:00 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: http://bugs.dpdk.org/
Auto-Submitted: auto-generated
X-Auto-Response-Suppress: All

https://bugs.dpdk.org/show_bug.cgi?id=3D1713

            Bug ID: 1713
           Summary: dispatcher_autotest hangs on build with disabled
                    RTE_USE_C11_MEM_MODEL
           Product: DPDK
           Version: 25.03
          Hardware: ARM
                OS: All
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: core
          Assignee: dev@dpdk.org
          Reporter: konstantin.v.ananyev@yandex.ru
  Target Milestone: ---

CPU: Ampere(R) Altra(R) Max

steps to reproduce:
1)build dpdk with RTE_USE_C11_MEM_MODEL undefined, i.e.:
--- a/config/arm/meson.build
+++ b/config/arm/meson.build
@@ -33,7 +33,7 @@ implementer_generic =3D {
     'description': 'Generic armv8',
     'flags': [
         ['RTE_MACHINE', '"armv8a"'],
-        ['RTE_USE_C11_MEM_MODEL', true],
+        ['RTE_USE_C11_MEM_MODEL', false],
         ['RTE_MAX_LCORE', 256],
         ['RTE_MAX_NUMA_NODES', 4]
     ],

$CFLAGS=3D'-g -O1 -DRTE_SORING_DEBUG -DRTE_ENABLE_ASSERT' CC=3Dgcc-13 meson
--prefix=3D${PWD}/aarch64-default-linuxapp-gcc13-rg-dbg-install --werror
-Dbuildtype=3Drelease -Dmachine=3Ddefault -Ddisable_drivers=3Dnet/cnxk,net/=
xsc
-Dexamples=3Dall aarch64-default-linuxapp-gcc13-rg-dbg

$grep C11_MEM aarch64-default-linuxapp-gcc13-rg-dbg/rte_build_config.h
#undef RTE_USE_C11_MEM_MODEL

$ninja -v -j 24 -C aarch64-default-linuxapp-gcc13-rg-dbg

2) run dispatcher_autotest:
$DPDK_TEST=3Ddispatcher_autotest
./aarch64-default-linuxapp-gcc13-rg-dbg/app/dpdk-test --no-huge -m 2048
--no-pci --lcores=3D0-3

the test will get hanged forever at the very first test.

Looking with gdb, we get stuck at:
...
#11 test_basic () at ../app/test/test_dispatcher.c:848
#12 0x000000000050d638 in unit_test_suite_runner (
    suite=3Dsuite@entry=3D0x1a23370 <test_suite>) at ../app/test/test.c:364
#13 0x0000000000571fa8 in test_dispatcher ()
    at ../app/test/test_dispatcher.c:1053
...
i.e. we are waiting for all events to complete, but it never happens,
though there is huge numbers of errors:
(gdb) print test_app->completed_events
$1 =3D 71402
(gdb) print test_app->errors
$2 =3D 767639

Debugging it a bit more, errors counters are incremented at:
./app/test/test_dispatcher.c:377
test_app_process_queue(uint8_t p_event_dev_id, uint8_t p_event_port_id,
        struct rte_event *in_events, uint16_t num,
        void *cb_data)
{
    ...

    for (i =3D 0; i < num; i++) {
                const struct rte_event *in_event =3D &in_events[i];
                struct rte_event *out_event =3D &out_events[i];
                uint64_t sn =3D in_event->u64;
                uint64_t expected_sn;

                if (in_event->queue_id !=3D app_queue->queue_id) {
                        test_app_queue_note_error(app);
                        return;
                }

                expected_sn =3D app_queue->sn[in_event->flow_id]++;

                if (expected_sn !=3D sn) {
                        test_app_queue_note_error(app);
                        return;


As I can read the code - that means that dequeued events don't pass sanity
check.
Note that with RTE_USE_C11_MEM_MODEL undefined we use different (legacy)
implementation of __rte_ring_headtail_move_head().
Also note that we do use MP/SC rte_ring for events.=20

In that implementation we do:

load(&d->head);
rmb();
load(&s->tail);
...
if (st)
     d->head =3D ...;
else
   rte_atomic32_cmpset(&d->head, ...);

While for MT case cmpset will generate a CASAL instruction - CAS() with
acquire-release mem-order, for ST case we don't have any memory-ordering
primitives.
So, as I understand, what happens here:
reading elements from the ring sometimes get re-ordered with reading prod.t=
ail
value, i.e. we reading elements that are not yet completely written into the
ring.
What is really strange that we never hit such issue before...

Anyway, the proposed fix, is to put rmb() after load(&s->tail); for ST case:
--- a/lib/ring/rte_ring_generic_pvt.h
+++ b/lib/ring/rte_ring_generic_pvt.h
@@ -106,6 +106,7 @@ __rte_ring_headtail_move_head(struct rte_ring_headtail =
*d,

                *new_head =3D *old_head + n;
                if (is_st) {
+                       rte_smp_rmb();
                        d->head =3D *new_head;
                        success =3D 1;
                } else

With it in place, dispatcher_autotest completes successfully on that machin=
e.

--=20
You are receiving this mail because:
You are the assignee for the bug.=

--17483509200.Fb6Fcdf.2313538
Date: Tue, 27 May 2025 15:02:00 +0200
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
   title=3D"UNCONFIRMED - dispatcher_autotest hangs on build with disabled =
RTE_USE_C11_MEM_MODEL"
   href=3D"https://bugs.dpdk.org/show_bug.cgi?id=3D1713">1713</a>
          </td>
        </tr>

        <tr>
          <th>Summary</th>
          <td>dispatcher_autotest hangs on build with disabled RTE_USE_C11_=
MEM_MODEL
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
          <td>ARM
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
          <td>konstantin.v.ananyev&#64;yandex.ru
          </td>
        </tr>

        <tr>
          <th>Target Milestone</th>
          <td>---
          </td>
        </tr></table>
      <p>
        <div class=3D"bz_comment_block">
          <pre class=3D"bz_comment_text">CPU: Ampere(R) Altra(R) Max

steps to reproduce:
1)build dpdk with RTE_USE_C11_MEM_MODEL undefined, i.e.:
--- a/config/arm/meson.build
+++ b/config/arm/meson.build
&#64;&#64; -33,7 +33,7 &#64;&#64; implementer_generic =3D {
     'description': 'Generic armv8',
     'flags': [
         ['RTE_MACHINE', '&quot;armv8a&quot;'],
-        ['RTE_USE_C11_MEM_MODEL', true],
+        ['RTE_USE_C11_MEM_MODEL', false],
         ['RTE_MAX_LCORE', 256],
         ['RTE_MAX_NUMA_NODES', 4]
     ],

$CFLAGS=3D'-g -O1 -DRTE_SORING_DEBUG -DRTE_ENABLE_ASSERT' CC=3Dgcc-13 meson
--prefix=3D${PWD}/aarch64-default-linuxapp-gcc13-rg-dbg-install --werror
-Dbuildtype=3Drelease -Dmachine=3Ddefault -Ddisable_drivers=3Dnet/cnxk,net/=
xsc
-Dexamples=3Dall aarch64-default-linuxapp-gcc13-rg-dbg

$grep C11_MEM aarch64-default-linuxapp-gcc13-rg-dbg/rte_build_config.h
#undef RTE_USE_C11_MEM_MODEL

$ninja -v -j 24 -C aarch64-default-linuxapp-gcc13-rg-dbg

2) run dispatcher_autotest:
$DPDK_TEST=3Ddispatcher_autotest
./aarch64-default-linuxapp-gcc13-rg-dbg/app/dpdk-test --no-huge -m 2048
--no-pci --lcores=3D0-3

the test will get hanged forever at the very first test.

Looking with gdb, we get stuck at:
...
#11 test_basic () at ../app/test/test_dispatcher.c:848
#12 0x000000000050d638 in unit_test_suite_runner (
    suite=3Dsuite&#64;entry=3D0x1a23370 &lt;test_suite&gt;) at ../app/test/=
test.c:364
#13 0x0000000000571fa8 in test_dispatcher ()
    at ../app/test/test_dispatcher.c:1053
...
i.e. we are waiting for all events to complete, but it never happens,
though there is huge numbers of errors:
(gdb) print test_app-&gt;completed_events
$1 =3D 71402
(gdb) print test_app-&gt;errors
$2 =3D 767639

Debugging it a bit more, errors counters are incremented at:
./app/test/test_dispatcher.c:377
test_app_process_queue(uint8_t p_event_dev_id, uint8_t p_event_port_id,
        struct rte_event *in_events, uint16_t num,
        void *cb_data)
{
    ...

    for (i =3D 0; i &lt; num; i++) {
                const struct rte_event *in_event =3D &amp;in_events[i];
                struct rte_event *out_event =3D &amp;out_events[i];
                uint64_t sn =3D in_event-&gt;u64;
                uint64_t expected_sn;

                if (in_event-&gt;queue_id !=3D app_queue-&gt;queue_id) {
                        test_app_queue_note_error(app);
                        return;
                }

                expected_sn =3D app_queue-&gt;sn[in_event-&gt;flow_id]++;

                if (expected_sn !=3D sn) {
                        test_app_queue_note_error(app);
                        return;


As I can read the code - that means that dequeued events don't pass sanity
check.
Note that with RTE_USE_C11_MEM_MODEL undefined we use different (legacy)
implementation of __rte_ring_headtail_move_head().
Also note that we do use MP/SC rte_ring for events.=20

In that implementation we do:

load(&amp;d-&gt;head);
rmb();
load(&amp;s-&gt;tail);
...
if (st)
     d-&gt;head =3D ...;
else
   rte_atomic32_cmpset(&amp;d-&gt;head, ...);

While for MT case cmpset will generate a CASAL instruction - CAS() with
acquire-release mem-order, for ST case we don't have any memory-ordering
primitives.
So, as I understand, what happens here:
reading elements from the ring sometimes get re-ordered with reading prod.t=
ail
value, i.e. we reading elements that are not yet completely written into the
ring.
What is really strange that we never hit such issue before...

Anyway, the proposed fix, is to put rmb() after load(&amp;s-&gt;tail); for =
ST case:
--- a/lib/ring/rte_ring_generic_pvt.h
+++ b/lib/ring/rte_ring_generic_pvt.h
&#64;&#64; -106,6 +106,7 &#64;&#64; __rte_ring_headtail_move_head(struct rt=
e_ring_headtail *d,

                *new_head =3D *old_head + n;
                if (is_st) {
+                       rte_smp_rmb();
                        d-&gt;head =3D *new_head;
                        success =3D 1;
                } else

With it in place, dispatcher_autotest completes successfully on that machin=
e.
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
?id=3D1713">
          <meta itemprop=3D"name" content=3D"View bug">
        </div>
        <meta itemprop=3D"description" content=3D"Bugzilla bug update notif=
ication">
      </div>
    </body>
</html>=

--17483509200.Fb6Fcdf.2313538--
