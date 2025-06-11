Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 847BDC61CE7
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Jun 2025 06:49:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9AB4C402C6;
	Wed, 11 Jun 2025 08:49:35 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 80A02402C2
 for <dev@dpdk.org>; Wed, 11 Jun 2025 08:49:34 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 6C233468D3; Wed, 11 Jun 2025 08:49:34 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/meson Bug 1721] failed to compile DPDK
Date: Wed, 11 Jun 2025 06:49:34 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: meson
X-Bugzilla-Version: 24.07
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: critical
X-Bugzilla-Who: pdamouny@nvidia.com
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone
Message-ID: <bug-1721-3@http.bugs.dpdk.org/>
Content-Type: multipart/alternative; boundary=17496245740.EF66FFaF.1547183
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


--17496245740.EF66FFaF.1547183
Date: Wed, 11 Jun 2025 08:49:34 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: http://bugs.dpdk.org/
Auto-Submitted: auto-generated
X-Auto-Response-Suppress: All

https://bugs.dpdk.org/show_bug.cgi?id=3D1721

            Bug ID: 1721
           Summary: failed to compile DPDK
           Product: DPDK
           Version: 24.07
          Hardware: x86
                OS: Windows
            Status: UNCONFIRMED
          Severity: critical
          Priority: Normal
         Component: meson
          Assignee: dev@dpdk.org
          Reporter: pdamouny@nvidia.com
  Target Milestone: ---

commit 57c194d142d927f2f5dd757e36777910b5d77d41
Author: David Marchand <david.marchand@redhat.com>
Date:   Fri Mar 7 20:06:51 2025 +0100

    build: use dynamically generated version maps

    Switch to dynamically generated version maps.

    As the map files get generated, tooling around checking, converting,
    updating etc.. static version maps can be removed.

    Signed-off-by: David Marchand <david.marchand@redhat.com>
    Acked-by: Aaron Conole <aconole@redhat.com>


broke compilation=20

FAILED: lib/cmdline_exports.map
"C:\Python38\python.exe" "../buildtools/gen-version-map.py" "--linker"
"mslinker" "--abi-version" "../ABI_VERSION" "--output"
"lib/cmdline_exports.map" "--source" "../lib/cmdline/cmdline.c"
"../lib/cmdline/cmdline_cirbuf.c" "../lib/cmdline/cmdline_parse.c"
"../lib/cmdline/cmdline_parse_etheraddr.c"
"../lib/cmdline/cmdline_parse_ipaddr.c" "../lib/cmdline/cmdline_parse_num.c"
"../lib/cmdline/cmdline_parse_bool.c" "../lib/cmdline/cmdline_parse_portlis=
t.c"
"../lib/cmdline/cmdline_parse_string.c" "../lib/cmdline/cmdline_rdline.c"
"../lib/cmdline/cmdline_socket.c" "../lib/cmdline/cmdline_vt100.c"
"../lib/cmdline/cmdline_os_windows.c"
Traceback (most recent call last):
  File "../buildtools/gen-version-map.py", line 30, in <module>
    type=3Dargparse.FileType("r", encoding=3D"utf-8"),
TypeError: __init__() got an unexpected keyword argument 'encoding'

--=20
You are receiving this mail because:
You are the assignee for the bug.=

--17496245740.EF66FFaF.1547183
Date: Wed, 11 Jun 2025 08:49:34 +0200
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
   title=3D"UNCONFIRMED - failed to compile DPDK"
   href=3D"https://bugs.dpdk.org/show_bug.cgi?id=3D1721">1721</a>
          </td>
        </tr>

        <tr>
          <th>Summary</th>
          <td>failed to compile DPDK
          </td>
        </tr>

        <tr>
          <th>Product</th>
          <td>DPDK
          </td>
        </tr>

        <tr>
          <th>Version</th>
          <td>24.07
          </td>
        </tr>

        <tr>
          <th>Hardware</th>
          <td>x86
          </td>
        </tr>

        <tr>
          <th>OS</th>
          <td>Windows
          </td>
        </tr>

        <tr>
          <th>Status</th>
          <td>UNCONFIRMED
          </td>
        </tr>

        <tr>
          <th>Severity</th>
          <td>critical
          </td>
        </tr>

        <tr>
          <th>Priority</th>
          <td>Normal
          </td>
        </tr>

        <tr>
          <th>Component</th>
          <td>meson
          </td>
        </tr>

        <tr>
          <th>Assignee</th>
          <td>dev&#64;dpdk.org
          </td>
        </tr>

        <tr>
          <th>Reporter</th>
          <td>pdamouny&#64;nvidia.com
          </td>
        </tr>

        <tr>
          <th>Target Milestone</th>
          <td>---
          </td>
        </tr></table>
      <p>
        <div class=3D"bz_comment_block">
          <pre class=3D"bz_comment_text">commit 57c194d142d927f2f5dd757e367=
77910b5d77d41
Author: David Marchand &lt;<a href=3D"mailto:david.marchand&#64;redhat.com"=
>david.marchand&#64;redhat.com</a>&gt;
Date:   Fri Mar 7 20:06:51 2025 +0100

    build: use dynamically generated version maps

    Switch to dynamically generated version maps.

    As the map files get generated, tooling around checking, converting,
    updating etc.. static version maps can be removed.

    Signed-off-by: David Marchand &lt;<a href=3D"mailto:david.marchand&#64;=
redhat.com">david.marchand&#64;redhat.com</a>&gt;
    Acked-by: Aaron Conole &lt;<a href=3D"mailto:aconole&#64;redhat.com">ac=
onole&#64;redhat.com</a>&gt;


broke compilation=20

FAILED: lib/cmdline_exports.map
&quot;C:\Python38\python.exe&quot; &quot;../buildtools/gen-version-map.py&q=
uot; &quot;--linker&quot;
&quot;mslinker&quot; &quot;--abi-version&quot; &quot;../ABI_VERSION&quot; &=
quot;--output&quot;
&quot;lib/cmdline_exports.map&quot; &quot;--source&quot; &quot;../lib/cmdli=
ne/cmdline.c&quot;
&quot;../lib/cmdline/cmdline_cirbuf.c&quot; &quot;../lib/cmdline/cmdline_pa=
rse.c&quot;
&quot;../lib/cmdline/cmdline_parse_etheraddr.c&quot;
&quot;../lib/cmdline/cmdline_parse_ipaddr.c&quot; &quot;../lib/cmdline/cmdl=
ine_parse_num.c&quot;
&quot;../lib/cmdline/cmdline_parse_bool.c&quot; &quot;../lib/cmdline/cmdlin=
e_parse_portlist.c&quot;
&quot;../lib/cmdline/cmdline_parse_string.c&quot; &quot;../lib/cmdline/cmdl=
ine_rdline.c&quot;
&quot;../lib/cmdline/cmdline_socket.c&quot; &quot;../lib/cmdline/cmdline_vt=
100.c&quot;
&quot;../lib/cmdline/cmdline_os_windows.c&quot;
Traceback (most recent call last):
  File &quot;../buildtools/gen-version-map.py&quot;, line 30, in &lt;module=
&gt;
    type=3Dargparse.FileType(&quot;r&quot;, encoding=3D&quot;utf-8&quot;),
TypeError: __init__() got an unexpected keyword argument 'encoding'
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
?id=3D1721">
          <meta itemprop=3D"name" content=3D"View bug">
        </div>
        <meta itemprop=3D"description" content=3D"Bugzilla bug update notif=
ication">
      </div>
    </body>
</html>=

--17496245740.EF66FFaF.1547183--
