Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A82E5C83F26
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Jul 2025 19:18:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7A1B04026A;
	Wed, 30 Jul 2025 21:18:27 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 8C6484025A
 for <dev@dpdk.org>; Wed, 30 Jul 2025 21:18:26 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 658B146C57; Wed, 30 Jul 2025 21:18:26 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/ethdev Bug 1762] Unable to use TB-mode when code blocks have
 different length (ACC100 / VRB drivers)
Date: Wed, 30 Jul 2025 19:18:26 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: ethdev
X-Bugzilla-Version: unspecified
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: faust1002@gmail.com
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone attachments.created
Message-ID: <bug-1762-3@https.bugs.dpdk.org/>
Content-Type: multipart/alternative; boundary=17539031060.7F67C7.649321
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


--17539031060.7F67C7.649321
Date: Wed, 30 Jul 2025 21:18:26 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugs.dpdk.org/
Auto-Submitted: auto-generated
X-Auto-Response-Suppress: All

https://bugs.dpdk.org/show_bug.cgi?id=3D1762

            Bug ID: 1762
           Summary: Unable to use TB-mode when code blocks have different
                    length (ACC100 / VRB drivers)
           Product: DPDK
           Version: unspecified
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: ethdev
          Assignee: dev@dpdk.org
          Reporter: faust1002@gmail.com
  Target Milestone: ---

Created attachment 324
  --> https://bugs.dpdk.org/attachment.cgi?id=3D324&action=3Dedit
Problem with AC100 / VRB1 drivers when using TB mode

Hello,
First of all, I hope I selected the problematic component correctly. I deci=
ded
to choose ethdev, because I found a different bug in the same piece of code
reported under the same category.

Going back to the problem - based on my understanding of bbdev documentation
(https://doc.dpdk.org/guides/prog_guide/bbdev.html), it is possible to
configure two different code block lengths (denoted as tb_params.ea and
tb_params.eb) in TB mode within one OP. In other words, to decode an entire=
 TB,
instead of doing TB segmentation in SW and then allocating one OP per CB, I=
 can
offload everything to HW by using only one OP per TB. So, for example, I can
configure OP as follows
code_block_mode =3D 0
tb_params.ea =3D 9056
tb_params.eb =3D 9088
tb_params.c =3D 23
tb_params.r =3D 0
tb_params.cab =3D 4
In other words, the first four CBs will be 9056 bits longs and the remainin=
g 29
CBs will be 9088 bits long. Decoding will start with CB#0.

However, looking at the attached piece of code, it seems like fcw->rm_e is
configured only onces. Then the calculated value is used for all CBs,
regardless of their size provided as part of tb_params. As a result, decodi=
ng
fails. The entire code flow is as follows: vrb_enqueue_ldpc_dec (num set to=
 1
as we use only one OP per TB) -> vrb_enqueue_ldpc_dec_tb ->
vrb_enqueue_ldpc_dec_one_op_tb -> vrb_fcw_ld_fill (where fcw->rm_e is set) =
and
then for each end every CB vrb_dma_desc_ld_fill (where possibly incorrect
fcw->rm_e is used). I hope the problem description is clear. Please do not
hesitate to contact me if you have any further questions.

It seems like both LDPC encoding and decoding are impacted by this problem.
Furthermore, drivers for ACC100 and VRB1 are almost identical.

Not sure if the described problem is an actual bug or an undocumented featu=
re.
I would not be surprised if ACC100 / VRB1 didn't support different CB lengt=
hs
in TB mode. However, this should have been clearly documented. Furthermore,
there are no examples of how to use TB mode, only examples for CB mode are
available. This needs to be addressed as well in my humble opinion.

The original implementation was done by Nicolas Chautru from Intel. So I
believe he should be the first point of contact here.=20
Kind regards

--=20
You are receiving this mail because:
You are the assignee for the bug.=

--17539031060.7F67C7.649321
Date: Wed, 30 Jul 2025 21:18:26 +0200
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
   title=3D"UNCONFIRMED - Unable to use TB-mode when code blocks have diffe=
rent length (ACC100 / VRB drivers)"
   href=3D"https://bugs.dpdk.org/show_bug.cgi?id=3D1762">1762</a>
          </td>
        </tr>

        <tr>
          <th>Summary</th>
          <td>Unable to use TB-mode when code blocks have different length =
(ACC100 / VRB drivers)
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
          <td>ethdev
          </td>
        </tr>

        <tr>
          <th>Assignee</th>
          <td>dev&#64;dpdk.org
          </td>
        </tr>

        <tr>
          <th>Reporter</th>
          <td>faust1002&#64;gmail.com
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
=3D"attachment.cgi?id=3D324" name=3D"attach_324" title=3D"Problem with AC10=
0 / VRB1 drivers when using TB mode">attachment 324</a> <a href=3D"attachme=
nt.cgi?id=3D324&amp;action=3Dedit" title=3D"Problem with AC100 / VRB1 drive=
rs when using TB mode">[details]</a></span>
Problem with AC100 / VRB1 drivers when using TB mode

Hello,
First of all, I hope I selected the problematic component correctly. I deci=
ded
to choose ethdev, because I found a different bug in the same piece of code
reported under the same category.

Going back to the problem - based on my understanding of bbdev documentation
(<a href=3D"https://doc.dpdk.org/guides/prog_guide/bbdev.html">https://doc.=
dpdk.org/guides/prog_guide/bbdev.html</a>), it is possible to
configure two different code block lengths (denoted as tb_params.ea and
tb_params.eb) in TB mode within one OP. In other words, to decode an entire=
 TB,
instead of doing TB segmentation in SW and then allocating one OP per CB, I=
 can
offload everything to HW by using only one OP per TB. So, for example, I can
configure OP as follows
code_block_mode =3D 0
tb_params.ea =3D 9056
tb_params.eb =3D 9088
tb_params.c =3D 23
tb_params.r =3D 0
tb_params.cab =3D 4
In other words, the first four CBs will be 9056 bits longs and the remainin=
g 29
CBs will be 9088 bits long. Decoding will start with CB#0.

However, looking at the attached piece of code, it seems like fcw-&gt;rm_e =
is
configured only onces. Then the calculated value is used for all CBs,
regardless of their size provided as part of tb_params. As a result, decodi=
ng
fails. The entire code flow is as follows: vrb_enqueue_ldpc_dec (num set to=
 1
as we use only one OP per TB) -&gt; vrb_enqueue_ldpc_dec_tb -&gt;
vrb_enqueue_ldpc_dec_one_op_tb -&gt; vrb_fcw_ld_fill (where fcw-&gt;rm_e is=
 set) and
then for each end every CB vrb_dma_desc_ld_fill (where possibly incorrect
fcw-&gt;rm_e is used). I hope the problem description is clear. Please do n=
ot
hesitate to contact me if you have any further questions.

It seems like both LDPC encoding and decoding are impacted by this problem.
Furthermore, drivers for ACC100 and VRB1 are almost identical.

Not sure if the described problem is an actual bug or an undocumented featu=
re.
I would not be surprised if ACC100 / VRB1 didn't support different CB lengt=
hs
in TB mode. However, this should have been clearly documented. Furthermore,
there are no examples of how to use TB mode, only examples for CB mode are
available. This needs to be addressed as well in my humble opinion.

The original implementation was done by Nicolas Chautru from Intel. So I
believe he should be the first point of contact here.=20
Kind regards
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
?id=3D1762">
          <meta itemprop=3D"name" content=3D"View bug">
        </div>
        <meta itemprop=3D"description" content=3D"Bugzilla bug update notif=
ication">
      </div>
    </body>
</html>=

--17539031060.7F67C7.649321--
