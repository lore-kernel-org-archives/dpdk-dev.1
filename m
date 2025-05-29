Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB90FC54FB3
	for <dpdk-dev@archiver.kernel.org>; Thu, 29 May 2025 08:18:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 026CE427B0;
	Thu, 29 May 2025 10:16:30 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 489CC427BD
 for <dev@dpdk.org>; Thu, 29 May 2025 10:16:29 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 3C51F4681F; Thu, 29 May 2025 10:16:29 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/ethdev Bug 1716] virtio_xmit_cleanup failed when vm rx/tx
 queues from 1024 to 4096
Date: Thu, 29 May 2025 08:16:28 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: ethdev
X-Bugzilla-Version: 22.11
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: major
X-Bugzilla-Who: updoing@sina.com
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone attachments.created
Message-ID: <bug-1716-3@http.bugs.dpdk.org/>
Content-Type: multipart/alternative; boundary=17485065890.7Cdf6.3889295
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


--17485065890.7Cdf6.3889295
Date: Thu, 29 May 2025 10:16:28 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: http://bugs.dpdk.org/
Auto-Submitted: auto-generated
X-Auto-Response-Suppress: All

https://bugs.dpdk.org/show_bug.cgi?id=3D1716

            Bug ID: 1716
           Summary: virtio_xmit_cleanup failed when vm rx/tx queues from
                    1024 to 4096
           Product: DPDK
           Version: 22.11
          Hardware: Other
                OS: All
            Status: UNCONFIRMED
          Severity: major
          Priority: Normal
         Component: ethdev
          Assignee: dev@dpdk.org
          Reporter: updoing@sina.com
  Target Milestone: ---

Created attachment 319
  --> https://bugs.dpdk.org/attachment.cgi?id=3D319&action=3Dedit
viritio patch

In a virtual machine scenario running a DPDK application with virtio driver=
s,
when the host machine adjusted the guest VM's transmit/receive queue size f=
rom
1024 to 4096, the DPDK application's allocated 2048 mbufs became insufficie=
nt.
After this adjustment, the condition vq->vq_nentries - vq->vq_free_thresh w=
as
never triggered, resulting in the cleanup operation not occurring.

virtio_dev_rx_queue_setup the third param nb_desc is not used when
vq->vq_free_cnt great then nb_desc. vq->vq_free_cnt is assigned a value thr=
ough
vq->n_nentries when virtio driver has inited. i40e driver vq has a nb_rx_de=
sc
value, our dpdk app nb_desc setup 2048, malloc 2048 mbufs, so our dpdk app
rx/tx burst is failed on the line.

--=20
You are receiving this mail because:
You are the assignee for the bug.=

--17485065890.7Cdf6.3889295
Date: Thu, 29 May 2025 10:16:29 +0200
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
   title=3D"UNCONFIRMED - virtio_xmit_cleanup failed when vm rx/tx queues f=
rom 1024 to 4096"
   href=3D"https://bugs.dpdk.org/show_bug.cgi?id=3D1716">1716</a>
          </td>
        </tr>

        <tr>
          <th>Summary</th>
          <td>virtio_xmit_cleanup failed when vm rx/tx queues from 1024 to =
4096
          </td>
        </tr>

        <tr>
          <th>Product</th>
          <td>DPDK
          </td>
        </tr>

        <tr>
          <th>Version</th>
          <td>22.11
          </td>
        </tr>

        <tr>
          <th>Hardware</th>
          <td>Other
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
          <td>major
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
          <td>updoing&#64;sina.com
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
=3D"attachment.cgi?id=3D319&amp;action=3Ddiff" name=3D"attach_319" title=3D=
"viritio patch">attachment 319</a> <a href=3D"attachment.cgi?id=3D319&amp;a=
ction=3Dedit" title=3D"viritio patch">[details]</a></span>
viritio patch

In a virtual machine scenario running a DPDK application with virtio driver=
s,
when the host machine adjusted the guest VM's transmit/receive queue size f=
rom
1024 to 4096, the DPDK application's allocated 2048 mbufs became insufficie=
nt.
After this adjustment, the condition vq-&gt;vq_nentries - vq-&gt;vq_free_th=
resh was
never triggered, resulting in the cleanup operation not occurring.

virtio_dev_rx_queue_setup the third param nb_desc is not used when
vq-&gt;vq_free_cnt great then nb_desc. vq-&gt;vq_free_cnt is assigned a val=
ue through
vq-&gt;n_nentries when virtio driver has inited. i40e driver vq has a nb_rx=
_desc
value, our dpdk app nb_desc setup 2048, malloc 2048 mbufs, so our dpdk app
rx/tx burst is failed on the line.
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
?id=3D1716">
          <meta itemprop=3D"name" content=3D"View bug">
        </div>
        <meta itemprop=3D"description" content=3D"Bugzilla bug update notif=
ication">
      </div>
    </body>
</html>=

--17485065890.7Cdf6.3889295--
