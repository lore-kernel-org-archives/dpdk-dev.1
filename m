Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1989C021B8
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Feb 2025 15:19:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DA9AE4029F;
	Wed, 26 Feb 2025 16:19:35 +0100 (CET)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id E2F264026C
 for <dev@dpdk.org>; Wed, 26 Feb 2025 16:19:34 +0100 (CET)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id B7095462CB; Wed, 26 Feb 2025 16:19:34 +0100 (CET)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/other Bug 1665] __rte_trace_mem_get causing out of bounds write
Date: Wed, 26 Feb 2025 15:19:34 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: other
X-Bugzilla-Version: 24.11
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: oleksandrn@interfacemasters.com
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone
Message-ID: <bug-1665-3@http.bugs.dpdk.org/>
Content-Type: multipart/alternative; boundary=17405831740.c4D0F.392278
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


--17405831740.c4D0F.392278
Date: Wed, 26 Feb 2025 16:19:34 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: http://bugs.dpdk.org/
Auto-Submitted: auto-generated
X-Auto-Response-Suppress: All

https://bugs.dpdk.org/show_bug.cgi?id=3D1665

            Bug ID: 1665
           Summary: __rte_trace_mem_get causing out of bounds write
           Product: DPDK
           Version: 24.11
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: other
          Assignee: dev@dpdk.org
          Reporter: oleksandrn@interfacemasters.com
  Target Milestone: ---

When almost out of trace memory, __rte_trace_mem_get can write out of bound=
s.

It happens in my case if I have trace events of sizes that are not aligned =
to
__RTE_TRACE_EVENT_HEADER_SZ. like 27,33 etc.

I suspect that the issue is with the incorrect bounds check in
__rte_trace_mem_get.

>    uint32_t offset =3D trace->offset;
>    if (unlikely((offset + sz) >=3D trace->len)) { // assume condition is =
false,
>    and offset is not aligned
>    ...}
>    offset =3D RTE_ALIGN_CEIL(offset, __RTE_TRACE_EVENT_HEADER_SZ); // aft=
er
>    offset alignment offset + size might be bigger than trace->len
>    void *mem =3D RTE_PTR_ADD(&trace->mem[0], offset); // returning memory=
 chunk
>    that is smaller than requested size


For example:
offset =3D 21, len =3D 32, size =3D 9 -> offset + size is smaller than len
align offset to __RTE_TRACE_EVENT_HEADER_SZ -> offset =3D 24
offset + size is bigger than len.

--=20
You are receiving this mail because:
You are the assignee for the bug.=

--17405831740.c4D0F.392278
Date: Wed, 26 Feb 2025 16:19:34 +0100
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
   title=3D"UNCONFIRMED - __rte_trace_mem_get causing out of bounds write"
   href=3D"https://bugs.dpdk.org/show_bug.cgi?id=3D1665">1665</a>
          </td>
        </tr>

        <tr>
          <th>Summary</th>
          <td>__rte_trace_mem_get causing out of bounds write
          </td>
        </tr>

        <tr>
          <th>Product</th>
          <td>DPDK
          </td>
        </tr>

        <tr>
          <th>Version</th>
          <td>24.11
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
          <td>oleksandrn&#64;interfacemasters.com
          </td>
        </tr>

        <tr>
          <th>Target Milestone</th>
          <td>---
          </td>
        </tr></table>
      <p>
        <div class=3D"bz_comment_block">
          <pre class=3D"bz_comment_text">When almost out of trace memory, _=
_rte_trace_mem_get can write out of bounds.

It happens in my case if I have trace events of sizes that are not aligned =
to
__RTE_TRACE_EVENT_HEADER_SZ. like 27,33 etc.

I suspect that the issue is with the incorrect bounds check in
__rte_trace_mem_get.

<span class=3D"quote">&gt;    uint32_t offset =3D trace-&gt;offset;
&gt;    if (unlikely((offset + sz) &gt;=3D trace-&gt;len)) { // assume cond=
ition is false,
&gt;    and offset is not aligned
&gt;    ...}
&gt;    offset =3D RTE_ALIGN_CEIL(offset, __RTE_TRACE_EVENT_HEADER_SZ); // =
after
&gt;    offset alignment offset + size might be bigger than trace-&gt;len
&gt;    void *mem =3D RTE_PTR_ADD(&amp;trace-&gt;mem[0], offset); // return=
ing memory chunk
&gt;    that is smaller than requested size</span >


For example:
offset =3D 21, len =3D 32, size =3D 9 -&gt; offset + size is smaller than l=
en
align offset to __RTE_TRACE_EVENT_HEADER_SZ -&gt; offset =3D 24
offset + size is bigger than len.
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
?id=3D1665">
          <meta itemprop=3D"name" content=3D"View bug">
        </div>
        <meta itemprop=3D"description" content=3D"Bugzilla bug update notif=
ication">
      </div>
    </body>
</html>=

--17405831740.c4D0F.392278--
