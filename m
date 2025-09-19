Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DA60CAC59A
	for <dpdk-dev@archiver.kernel.org>; Fri, 19 Sep 2025 20:15:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 309344042F;
	Fri, 19 Sep 2025 22:15:03 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id CCF74402B7
 for <dev@dpdk.org>; Fri, 19 Sep 2025 22:15:01 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id C5DBA46F5A; Fri, 19 Sep 2025 22:15:01 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/ethdev Bug 1789] vmxnet3_dev_start fails in
 vmxnet3_v4_rss_configure() for single queue in ESX8.0 causing application to
 exit
Date: Fri, 19 Sep 2025 20:15:01 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: ethdev
X-Bugzilla-Version: 19.11
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: amiyaranjan.mohakud@gmail.com
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone
Message-ID: <bug-1789-3@https.bugs.dpdk.org/>
Content-Type: multipart/alternative; boundary=17583129010.14cDfbA7.1511821
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


--17583129010.14cDfbA7.1511821
Date: Fri, 19 Sep 2025 22:15:01 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugs.dpdk.org/
Auto-Submitted: auto-generated
X-Auto-Response-Suppress: All

https://bugs.dpdk.org/show_bug.cgi?id=3D1789

            Bug ID: 1789
           Summary: vmxnet3_dev_start fails in vmxnet3_v4_rss_configure()
                    for single queue in ESX8.0 causing application to exit
           Product: DPDK
           Version: 19.11
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: ethdev
          Assignee: dev@dpdk.org
          Reporter: amiyaranjan.mohakud@gmail.com
  Target Milestone: ---

DPDK Version: 19.11
ESX version: ESX8.0

We faced an exact similar issue as mentioned in
https://mails.dpdk.org/archives/users/2025-April/008236.html.=20

Context Details:
-----------------
In ESXi 8.0 setup with dpdk-19.11, when the HW compatibility version is ESX=
8.0
and with single queue pair configuration, the RSS gets enabled. As a result,
vmxnet3_v4_rss_configure() gets called and fails while writing/reading from
BAR1 hw register. It looks to be some compatibility issue with dpdk-19.11 a=
nd
ESX8.0.

        if (VMXNET3_VERSION_GE_4(hw) &&=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20
            dev->data->dev_conf.rxmode.mq_mode =3D=3D ETH_MQ_RX_RSS) {=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20
                /* Check for additional RSS  */=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
                ret =3D vmxnet3_v4_rss_configure(dev);=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
                if (ret !=3D VMXNET3_SUCCESS) {=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20
                        PMD_INIT_LOG(ERR, "Failed to configure v4 RSS");=20=
=20=20=20=20=20=20=20
                        return ret;=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20
                }=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
        }=20=20

As a result, it causes the application to exit.

Proposed fix:
I have a plausible fix for this. The fix is to disable RSS for such a case (
the fix should go only in 19.11). During dev_configure(),  we can set the
mq_mode  to ETH_MQ_RX_NONE if the num_rx_queues is 1. This would avoid call=
ing
of vmxnet3_v4_rss_configure().


        /* Disabling RSS for single queue pair */=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
        if (dev->data->nb_rx_queues =3D=3D 1) {=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20
                dev->data->dev_conf.rxmode.mq_mode =3D ETH_MQ_RX_NONE;=20=
=20=20=20=20=20=20=20=20=20=20=20
                PMD_INIT_LOG(ERR, "WARN: Disabling RSS for single Rx queue"=
);=20=20=20
        }


Pls verify and let me know if it can be upstreamed. Once confirmed/approved=
, If
required, I can generate a main stream patch for it.

--=20
You are receiving this mail because:
You are the assignee for the bug.=

--17583129010.14cDfbA7.1511821
Date: Fri, 19 Sep 2025 22:15:01 +0200
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
   title=3D"UNCONFIRMED - vmxnet3_dev_start fails in vmxnet3_v4_rss_configu=
re() for single queue in ESX8.0 causing application to exit"
   href=3D"https://bugs.dpdk.org/show_bug.cgi?id=3D1789">1789</a>
          </td>
        </tr>

        <tr>
          <th>Summary</th>
          <td>vmxnet3_dev_start fails in vmxnet3_v4_rss_configure() for sin=
gle queue in ESX8.0 causing application to exit
          </td>
        </tr>

        <tr>
          <th>Product</th>
          <td>DPDK
          </td>
        </tr>

        <tr>
          <th>Version</th>
          <td>19.11
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
          <td>amiyaranjan.mohakud&#64;gmail.com
          </td>
        </tr>

        <tr>
          <th>Target Milestone</th>
          <td>---
          </td>
        </tr></table>
      <p>
        <div class=3D"bz_comment_block">
          <pre class=3D"bz_comment_text">DPDK Version: 19.11
ESX version: ESX8.0

We faced an exact similar issue as mentioned in
<a href=3D"https://mails.dpdk.org/archives/users/2025-April/008236.html">ht=
tps://mails.dpdk.org/archives/users/2025-April/008236.html</a>.=20

Context Details:
-----------------
In ESXi 8.0 setup with dpdk-19.11, when the HW compatibility version is ESX=
8.0
and with single queue pair configuration, the RSS gets enabled. As a result,
vmxnet3_v4_rss_configure() gets called and fails while writing/reading from
BAR1 hw register. It looks to be some compatibility issue with dpdk-19.11 a=
nd
ESX8.0.

        if (VMXNET3_VERSION_GE_4(hw) &amp;&amp;=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20
            dev-&gt;data-&gt;dev_conf.rxmode.mq_mode =3D=3D ETH_MQ_RX_RSS) =
{=20=20=20=20=20=20=20=20=20=20=20=20=20=20
                /* Check for additional RSS  */=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
                ret =3D vmxnet3_v4_rss_configure(dev);=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
                if (ret !=3D VMXNET3_SUCCESS) {=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20
                        PMD_INIT_LOG(ERR, &quot;Failed to configure v4 RSS&=
quot;);=20=20=20=20=20=20=20=20
                        return ret;=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20
                }=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
        }=20=20

As a result, it causes the application to exit.

Proposed fix:
I have a plausible fix for this. The fix is to disable RSS for such a case (
the fix should go only in 19.11). During dev_configure(),  we can set the
mq_mode  to ETH_MQ_RX_NONE if the num_rx_queues is 1. This would avoid call=
ing
of vmxnet3_v4_rss_configure().


        /* Disabling RSS for single queue pair */=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
        if (dev-&gt;data-&gt;nb_rx_queues =3D=3D 1) {=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20
                dev-&gt;data-&gt;dev_conf.rxmode.mq_mode =3D ETH_MQ_RX_NONE=
;=20=20=20=20=20=20=20=20=20=20=20=20
                PMD_INIT_LOG(ERR, &quot;WARN: Disabling RSS for single Rx q=
ueue&quot;);=20=20=20
        }


Pls verify and let me know if it can be upstreamed. Once confirmed/approved=
, If
required, I can generate a main stream patch for it.
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
?id=3D1789">
          <meta itemprop=3D"name" content=3D"View bug">
        </div>
        <meta itemprop=3D"description" content=3D"Bugzilla bug update notif=
ication">
      </div>
    </body>
</html>=

--17583129010.14cDfbA7.1511821--
