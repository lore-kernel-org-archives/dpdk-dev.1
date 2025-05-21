Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C83FC2D0CD
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 May 2025 09:32:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6E9CC41156;
	Wed, 21 May 2025 11:32:39 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 1534F40151
 for <dev@dpdk.org>; Wed, 21 May 2025 11:32:38 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 04C09467AB; Wed, 21 May 2025 11:32:37 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/core Bug 1708] rte_malloc_socket failed to allocate with large
 alignment and ASan
Date: Wed, 21 May 2025 09:32:37 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: core
X-Bugzilla-Version: 21.11
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: plestringant@kalrayinc.com
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone
Message-ID: <bug-1708-3@http.bugs.dpdk.org/>
Content-Type: multipart/alternative; boundary=17478199560.B5e8FC1.2161541
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


--17478199560.B5e8FC1.2161541
Date: Wed, 21 May 2025 11:32:36 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: http://bugs.dpdk.org/
Auto-Submitted: auto-generated
X-Auto-Response-Suppress: All

https://bugs.dpdk.org/show_bug.cgi?id=3D1708

            Bug ID: 1708
           Summary: rte_malloc_socket failed to allocate with large
                    alignment and ASan
           Product: DPDK
           Version: 21.11
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: core
          Assignee: dev@dpdk.org
          Reporter: plestringant@kalrayinc.com
  Target Milestone: ---

After commit f92b9ebed03dbd140a5a7b921cb898e661a59068, I am unable to alloc=
ate
1MiB aligned 1MiB with rte_malloc_socket when DPDK is built with ASan.

Enter try_expand_heap_primary with pg_sz=3D0x200000, elt_size=3D0x100000,
align=3D0x100000
alloc_sz is set to 0x200000
Enter alloc_pages_on_heap
Enter find_suitable_element
Enter elem_start_pt with elem of size 0x200000
MALLOC_ELEM_TRAILER_LEN is non zero because of ASan
new_data_start is equal to elem because of alignment
There is no room for the header and it fails.

If my analysis is correct the formula used in try_expand_heap_primary to
compute alloc_sz is off. I suggest something like:

alloc_sz =3D RTE_ALIGN_CEIL(RTE_ALIGN_CEIL(elt_size + MALLOC_ELEM_TRAILER_L=
EN,
align) + MALLOC_ELEM_HEADER_LEN, pg_sz);

I am working with branch 21.11, but I think this issue affects all the bran=
ches
which contain commit f92b9ebed03dbd140a5a7b921cb898e661a59068

--=20
You are receiving this mail because:
You are the assignee for the bug.=

--17478199560.B5e8FC1.2161541
Date: Wed, 21 May 2025 11:32:36 +0200
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
   title=3D"UNCONFIRMED - rte_malloc_socket failed to allocate with large a=
lignment and ASan"
   href=3D"https://bugs.dpdk.org/show_bug.cgi?id=3D1708">1708</a>
          </td>
        </tr>

        <tr>
          <th>Summary</th>
          <td>rte_malloc_socket failed to allocate with large alignment and=
 ASan
          </td>
        </tr>

        <tr>
          <th>Product</th>
          <td>DPDK
          </td>
        </tr>

        <tr>
          <th>Version</th>
          <td>21.11
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
          <td>plestringant&#64;kalrayinc.com
          </td>
        </tr>

        <tr>
          <th>Target Milestone</th>
          <td>---
          </td>
        </tr></table>
      <p>
        <div class=3D"bz_comment_block">
          <pre class=3D"bz_comment_text">After commit f92b9ebed03dbd140a5a7=
b921cb898e661a59068, I am unable to allocate
1MiB aligned 1MiB with rte_malloc_socket when DPDK is built with ASan.

Enter try_expand_heap_primary with pg_sz=3D0x200000, elt_size=3D0x100000,
align=3D0x100000
alloc_sz is set to 0x200000
Enter alloc_pages_on_heap
Enter find_suitable_element
Enter elem_start_pt with elem of size 0x200000
MALLOC_ELEM_TRAILER_LEN is non zero because of ASan
new_data_start is equal to elem because of alignment
There is no room for the header and it fails.

If my analysis is correct the formula used in try_expand_heap_primary to
compute alloc_sz is off. I suggest something like:

alloc_sz =3D RTE_ALIGN_CEIL(RTE_ALIGN_CEIL(elt_size + MALLOC_ELEM_TRAILER_L=
EN,
align) + MALLOC_ELEM_HEADER_LEN, pg_sz);

I am working with branch 21.11, but I think this issue affects all the bran=
ches
which contain commit f92b9ebed03dbd140a5a7b921cb898e661a59068
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
?id=3D1708">
          <meta itemprop=3D"name" content=3D"View bug">
        </div>
        <meta itemprop=3D"description" content=3D"Bugzilla bug update notif=
ication">
      </div>
    </body>
</html>=

--17478199560.B5e8FC1.2161541--
