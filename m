Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDBE0C19776
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Feb 2025 12:03:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B901B40E3F;
	Fri, 28 Feb 2025 13:03:49 +0100 (CET)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 2162440609
 for <dev@dpdk.org>; Fri, 28 Feb 2025 13:03:49 +0100 (CET)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id EAB62462E7; Fri, 28 Feb 2025 13:03:48 +0100 (CET)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/ethdev Bug 1666] It is not possible to increase the MTU for
 AF_PACKET PMD beyond 1500B
Date: Fri, 28 Feb 2025 12:03:48 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: ethdev
X-Bugzilla-Version: 21.11
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: angelo.mirabella96@gmail.com
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone attachments.created
Message-ID: <bug-1666-3@http.bugs.dpdk.org/>
Content-Type: multipart/alternative; boundary=17407442280.8dcc148.1469702
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


--17407442280.8dcc148.1469702
Date: Fri, 28 Feb 2025 13:03:48 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: http://bugs.dpdk.org/
Auto-Submitted: auto-generated
X-Auto-Response-Suppress: All

https://bugs.dpdk.org/show_bug.cgi?id=3D1666

            Bug ID: 1666
           Summary: It is not possible to increase the MTU for AF_PACKET
                    PMD beyond 1500B
           Product: DPDK
           Version: 21.11
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: ethdev
          Assignee: dev@dpdk.org
          Reporter: angelo.mirabella96@gmail.com
  Target Milestone: ---

Created attachment 302
  --> https://bugs.dpdk.org/attachment.cgi?id=3D302&action=3Dedit
testpmd logs

Hi everyone,

I'm currently working with DPDK v21.11 from the official Ubuntu Jammy packa=
ge,
having recently upgraded from v19.11. I noticed that a new check,
"eth_dev_validate_mtu", has been introduced in "eth_dev_configure".

The final check in this function is:


```
        if (frame_size > dev_info->max_rx_pktlen) {
---
```

For the AF_PACKET PMD, "max_rx_pktlen" is hardcoded to RTE_ETHER_MAX_LEN
(1518). As a result, any attempt to increase the MTU beyond 1500 fails, even
when the vdev is configured with a larger framesz.

I've attached logs from testpmd for reference. Any insights or possible
workarounds would be appreciated!

Thanks!

--=20
You are receiving this mail because:
You are the assignee for the bug.=

--17407442280.8dcc148.1469702
Date: Fri, 28 Feb 2025 13:03:48 +0100
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
   title=3D"UNCONFIRMED - It is not possible to increase the MTU for AF_PAC=
KET PMD beyond 1500B"
   href=3D"https://bugs.dpdk.org/show_bug.cgi?id=3D1666">1666</a>
          </td>
        </tr>

        <tr>
          <th>Summary</th>
          <td>It is not possible to increase the MTU for AF_PACKET PMD beyo=
nd 1500B
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
          <td>angelo.mirabella96&#64;gmail.com
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
=3D"attachment.cgi?id=3D302" name=3D"attach_302" title=3D"testpmd logs">att=
achment 302</a> <a href=3D"attachment.cgi?id=3D302&amp;action=3Dedit" title=
=3D"testpmd logs">[details]</a></span>
testpmd logs

Hi everyone,

I'm currently working with DPDK v21.11 from the official Ubuntu Jammy packa=
ge,
having recently upgraded from v19.11. I noticed that a new check,
&quot;eth_dev_validate_mtu&quot;, has been introduced in &quot;eth_dev_conf=
igure&quot;.

The final check in this function is:


```
        if (frame_size &gt; dev_info-&gt;max_rx_pktlen) {
---
```

For the AF_PACKET PMD, &quot;max_rx_pktlen&quot; is hardcoded to RTE_ETHER_=
MAX_LEN
(1518). As a result, any attempt to increase the MTU beyond 1500 fails, even
when the vdev is configured with a larger framesz.

I've attached logs from testpmd for reference. Any insights or possible
workarounds would be appreciated!

Thanks!
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
?id=3D1666">
          <meta itemprop=3D"name" content=3D"View bug">
        </div>
        <meta itemprop=3D"description" content=3D"Bugzilla bug update notif=
ication">
      </div>
    </body>
</html>=

--17407442280.8dcc148.1469702--
