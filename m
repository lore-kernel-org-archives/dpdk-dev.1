Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24639C35FFA
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Mar 2025 12:16:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2E8AF402C4;
	Wed, 19 Mar 2025 13:16:10 +0100 (CET)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 97A884026B
 for <dev@dpdk.org>; Wed, 19 Mar 2025 13:16:08 +0100 (CET)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 81A8A46423; Wed, 19 Mar 2025 13:16:08 +0100 (CET)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/other Bug 1678] acl: build issue in Neon implementation with
 GCC 15 in Fedora Rawhide Aarch64
Date: Wed, 19 Mar 2025 12:16:07 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: other
X-Bugzilla-Version: unspecified
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: david.marchand@redhat.com
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone
Message-ID: <bug-1678-3@http.bugs.dpdk.org/>
Content-Type: multipart/alternative; boundary=17423865680.9bAEa93.671928
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


--17423865680.9bAEa93.671928
Date: Wed, 19 Mar 2025 13:16:08 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: http://bugs.dpdk.org/
Auto-Submitted: auto-generated
X-Auto-Response-Suppress: All

https://bugs.dpdk.org/show_bug.cgi?id=3D1678

            Bug ID: 1678
           Summary: acl: build issue in Neon implementation with GCC 15 in
                    Fedora Rawhide Aarch64
           Product: DPDK
           Version: unspecified
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: other
          Assignee: dev@dpdk.org
          Reporter: david.marchand@redhat.com
  Target Milestone: ---

This was caught in OBS, and can be reproduced with a Fedora Rawhide aarch64
container.

bash-5.2# meson setup build-fedora-aarch64 -Ddisable_drivers=3D*/*
-Denable_libs=3Dacl -Ddeveloper_mode=3Ddisabled -Dmachine=3Ddefault
...
bash-5.2# ninja -C build-fedora-aarch64 lib/librte_acl.a
ninja: Entering directory `build-fedora-aarch64'
[6/7] Compiling C object lib/librte_acl.a.p/acl_acl_run_neon.c.o
In file included from ../lib/acl/acl_run_neon.h:7,
                 from ../lib/acl/acl_run_neon.c:5:
In function 'alloc_completion',
    inlined from 'acl_start_next_trie' at ../lib/acl/acl_run.h:140:24,
    inlined from 'search_neon_4.isra' at ../lib/acl/acl_run_neon.h:239:20:
../lib/acl/acl_run.h:93:25: warning: 'cmplt' may be used uninitialized
[-Wmaybe-uninitialized]
   93 |                 if (p[n].count =3D=3D 0) {
      |                     ~~~~^~~~~~
../lib/acl/acl_run_neon.h: In function 'search_neon_4.isra':
../lib/acl/acl_run_neon.h:230:27: note: 'cmplt' declared here
  230 |         struct completion cmplt[4];
      |                           ^~~~~
In function 'alloc_completion',
    inlined from 'acl_start_next_trie' at ../lib/acl/acl_run.h:140:24,
    inlined from 'search_neon_4.isra' at ../lib/acl/acl_run_neon.h:239:20:
../lib/acl/acl_run.h:93:25: warning: 'cmplt' may be used uninitialized
[-Wmaybe-uninitialized]
   93 |                 if (p[n].count =3D=3D 0) {
      |                     ~~~~^~~~~~
../lib/acl/acl_run_neon.h: In function 'search_neon_4.isra':
../lib/acl/acl_run_neon.h:230:27: note: 'cmplt' declared here
  230 |         struct completion cmplt[4];
      |                           ^~~~~
In function 'alloc_completion',
    inlined from 'acl_start_next_trie' at ../lib/acl/acl_run.h:140:24,
    inlined from 'search_neon_4.isra' at ../lib/acl/acl_run_neon.h:239:20:
../lib/acl/acl_run.h:93:25: warning: 'cmplt' may be used uninitialized
[-Wmaybe-uninitialized]
   93 |                 if (p[n].count =3D=3D 0) {
      |                     ~~~~^~~~~~
../lib/acl/acl_run_neon.h: In function 'search_neon_4.isra':
../lib/acl/acl_run_neon.h:230:27: note: 'cmplt' declared here
  230 |         struct completion cmplt[4];
      |                           ^~~~~
[7/7] Linking static target lib/librte_acl.a


A quick fix (needs review):
diff --git a/lib/acl/acl_run_neon.h b/lib/acl/acl_run_neon.h
index 63074f871d..ed7424e076 100644
--- a/lib/acl/acl_run_neon.h
+++ b/lib/acl/acl_run_neon.h
@@ -234,10 +234,10 @@ search_neon_4(const struct rte_acl_ctx *ctx, const
uint8_t **data,
        acl_set_flow(&flows, cmplt, RTE_DIM(cmplt), data, results,
                     total_packets, categories, ctx->trans_table);

-       for (n =3D 0; n < 4; n++) {
+       for (n =3D 0; n < 4; n++)
                cmplt[n].count =3D 0;
+       for (n =3D 0; n < 4; n++)
                index_array[n] =3D acl_start_next_trie(&flows, parms, n, ct=
x);
-       }

        /* Check for any matches. */
        acl_match_check_x4(0, ctx, parms, &flows, index_array);

--=20
You are receiving this mail because:
You are the assignee for the bug.=

--17423865680.9bAEa93.671928
Date: Wed, 19 Mar 2025 13:16:08 +0100
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
   title=3D"UNCONFIRMED - acl: build issue in Neon implementation with GCC =
15 in Fedora Rawhide Aarch64"
   href=3D"https://bugs.dpdk.org/show_bug.cgi?id=3D1678">1678</a>
          </td>
        </tr>

        <tr>
          <th>Summary</th>
          <td>acl: build issue in Neon implementation with GCC 15 in Fedora=
 Rawhide Aarch64
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
          <td>david.marchand&#64;redhat.com
          </td>
        </tr>

        <tr>
          <th>Target Milestone</th>
          <td>---
          </td>
        </tr></table>
      <p>
        <div class=3D"bz_comment_block">
          <pre class=3D"bz_comment_text">This was caught in OBS, and can be=
 reproduced with a Fedora Rawhide aarch64
container.

bash-5.2# meson setup build-fedora-aarch64 -Ddisable_drivers=3D*/*
-Denable_libs=3Dacl -Ddeveloper_mode=3Ddisabled -Dmachine=3Ddefault
...
bash-5.2# ninja -C build-fedora-aarch64 lib/librte_acl.a
ninja: Entering directory `build-fedora-aarch64'
[6/7] Compiling C object lib/librte_acl.a.p/acl_acl_run_neon.c.o
In file included from ../lib/acl/acl_run_neon.h:7,
                 from ../lib/acl/acl_run_neon.c:5:
In function 'alloc_completion',
    inlined from 'acl_start_next_trie' at ../lib/acl/acl_run.h:140:24,
    inlined from 'search_neon_4.isra' at ../lib/acl/acl_run_neon.h:239:20:
../lib/acl/acl_run.h:93:25: warning: 'cmplt' may be used uninitialized
[-Wmaybe-uninitialized]
   93 |                 if (p[n].count =3D=3D 0) {
      |                     ~~~~^~~~~~
../lib/acl/acl_run_neon.h: In function 'search_neon_4.isra':
../lib/acl/acl_run_neon.h:230:27: note: 'cmplt' declared here
  230 |         struct completion cmplt[4];
      |                           ^~~~~
In function 'alloc_completion',
    inlined from 'acl_start_next_trie' at ../lib/acl/acl_run.h:140:24,
    inlined from 'search_neon_4.isra' at ../lib/acl/acl_run_neon.h:239:20:
../lib/acl/acl_run.h:93:25: warning: 'cmplt' may be used uninitialized
[-Wmaybe-uninitialized]
   93 |                 if (p[n].count =3D=3D 0) {
      |                     ~~~~^~~~~~
../lib/acl/acl_run_neon.h: In function 'search_neon_4.isra':
../lib/acl/acl_run_neon.h:230:27: note: 'cmplt' declared here
  230 |         struct completion cmplt[4];
      |                           ^~~~~
In function 'alloc_completion',
    inlined from 'acl_start_next_trie' at ../lib/acl/acl_run.h:140:24,
    inlined from 'search_neon_4.isra' at ../lib/acl/acl_run_neon.h:239:20:
../lib/acl/acl_run.h:93:25: warning: 'cmplt' may be used uninitialized
[-Wmaybe-uninitialized]
   93 |                 if (p[n].count =3D=3D 0) {
      |                     ~~~~^~~~~~
../lib/acl/acl_run_neon.h: In function 'search_neon_4.isra':
../lib/acl/acl_run_neon.h:230:27: note: 'cmplt' declared here
  230 |         struct completion cmplt[4];
      |                           ^~~~~
[7/7] Linking static target lib/librte_acl.a


A quick fix (needs review):
diff --git a/lib/acl/acl_run_neon.h b/lib/acl/acl_run_neon.h
index 63074f871d..ed7424e076 100644
--- a/lib/acl/acl_run_neon.h
+++ b/lib/acl/acl_run_neon.h
&#64;&#64; -234,10 +234,10 &#64;&#64; search_neon_4(const struct rte_acl_ct=
x *ctx, const
uint8_t **data,
        acl_set_flow(&amp;flows, cmplt, RTE_DIM(cmplt), data, results,
                     total_packets, categories, ctx-&gt;trans_table);

-       for (n =3D 0; n &lt; 4; n++) {
+       for (n =3D 0; n &lt; 4; n++)
                cmplt[n].count =3D 0;
+       for (n =3D 0; n &lt; 4; n++)
                index_array[n] =3D acl_start_next_trie(&amp;flows, parms, n=
, ctx);
-       }

        /* Check for any matches. */
        acl_match_check_x4(0, ctx, parms, &amp;flows, index_array);
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
?id=3D1678">
          <meta itemprop=3D"name" content=3D"View bug">
        </div>
        <meta itemprop=3D"description" content=3D"Bugzilla bug update notif=
ication">
      </div>
    </body>
</html>=

--17423865680.9bAEa93.671928--
