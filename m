Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1698C3600C
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Apr 2025 20:12:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8050540A7D;
	Thu,  3 Apr 2025 22:12:36 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 690D1406B6
 for <dev@dpdk.org>; Thu,  3 Apr 2025 22:12:35 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 572B8464F9; Thu,  3 Apr 2025 22:12:35 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/ethdev Bug 1690] Calling rte_eth_dev_get_module_info() and
 rte_eth_dev_get_module_eeprom() for MLX ConnectX-6 spawn errors when
 transceiver not inserted
Date: Thu, 03 Apr 2025 20:12:35 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: ethdev
X-Bugzilla-Version: unspecified
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: yogev@cgstowernetworks.com
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone
Message-ID: <bug-1690-3@http.bugs.dpdk.org/>
Content-Type: multipart/alternative; boundary=17437111550.D67ea3A.1955444
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


--17437111550.D67ea3A.1955444
Date: Thu, 3 Apr 2025 22:12:35 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: http://bugs.dpdk.org/
Auto-Submitted: auto-generated
X-Auto-Response-Suppress: All

https://bugs.dpdk.org/show_bug.cgi?id=3D1690

            Bug ID: 1690
           Summary: Calling rte_eth_dev_get_module_info() and
                    rte_eth_dev_get_module_eeprom() for MLX ConnectX-6
                    spawn errors when transceiver not inserted
           Product: DPDK
           Version: unspecified
          Hardware: All
                OS: Linux
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: ethdev
          Assignee: dev@dpdk.org
          Reporter: yogev@cgstowernetworks.com
  Target Milestone: ---

For Mellanox 'MT2892 Family [ConnectX-6 Dx] 101d'=20=20
Calling the dpdk-testpmd's "show port 0 module_eeprom" results in an error =
when
a transceiver isn't inserted.=20=20
The error is spawned from the mlx source:
drivers/net/mlx5/linux/mlx5_ethdev_os.c=20=20
In two places:=20=20

```
int mlx5_get_module_info(...)
{
        ...
        ret =3D mlx5_ifreq(dev, SIOCETHTOOL, &ifr);
        if (ret) {
                DRV_LOG(DEBUG, "port %u ioctl(SIOCETHTOOL) failed: %s",
                        dev->data->port_id, strerror(rte_errno));
                return ret;
        }
        ...
}
```

And=20=20

```
int mlx5_get_module_eeprom(...)
{
        ...
        ret =3D mlx5_ifreq(dev, SIOCETHTOOL, &ifr);
        if (ret)
                DRV_LOG(WARNING, "port %u ioctl(SIOCETHTOOL) failed: %s",
                        dev->data->port_id, strerror(rte_errno));
        ...
}
```

dpdk-testpmd shows:=20=20

```
  testpmd> show port 0 module_eeprom=20
  mlx5_net: port 0 ioctl(SIOCETHTOOL) failed: Input/output error           =
//
<------------ this error.
  device is removed
```

When trying to use these functions in my own application, as dpdk-testpmd d=
oes:
rte_eth_dev_get_module_info() and rte_eth_dev_get_module_eeprom() this error
log gets printed as well.=20=20

An expected result would be to check out the return value and print these
errors if required by the caller.
For my scenario, I would like a silence fail in case there's no transceiver=
.=20=20

I've tried to overcome this by asking first if a device "exists" using
rte_eth_dev_is_removed() and rte_eth_dev_is_valid_port() but they don't ref=
lect
the transceiver state.=20=20

A possible solution would be to print these errors in DEBUG=20=20

Please advice,=20=20
Thanks.

--=20
You are receiving this mail because:
You are the assignee for the bug.=

--17437111550.D67ea3A.1955444
Date: Thu, 3 Apr 2025 22:12:35 +0200
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
   title=3D"UNCONFIRMED - Calling rte_eth_dev_get_module_info() and rte_eth=
_dev_get_module_eeprom() for MLX ConnectX-6 spawn errors when transceiver n=
ot inserted"
   href=3D"https://bugs.dpdk.org/show_bug.cgi?id=3D1690">1690</a>
          </td>
        </tr>

        <tr>
          <th>Summary</th>
          <td>Calling rte_eth_dev_get_module_info() and rte_eth_dev_get_mod=
ule_eeprom() for MLX ConnectX-6 spawn errors when transceiver not inserted
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
          <td>Linux
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
          <td>yogev&#64;cgstowernetworks.com
          </td>
        </tr>

        <tr>
          <th>Target Milestone</th>
          <td>---
          </td>
        </tr></table>
      <p>
        <div class=3D"bz_comment_block">
          <pre class=3D"bz_comment_text">For Mellanox 'MT2892 Family [Conne=
ctX-6 Dx] 101d'=20=20
Calling the dpdk-testpmd's &quot;show port 0 module_eeprom&quot; results in=
 an error when
a transceiver isn't inserted.=20=20
The error is spawned from the mlx source:
drivers/net/mlx5/linux/mlx5_ethdev_os.c=20=20
In two places:=20=20

```
int mlx5_get_module_info(...)
{
        ...
        ret =3D mlx5_ifreq(dev, SIOCETHTOOL, &amp;ifr);
        if (ret) {
                DRV_LOG(DEBUG, &quot;port %u ioctl(SIOCETHTOOL) failed: %s&=
quot;,
                        dev-&gt;data-&gt;port_id, strerror(rte_errno));
                return ret;
        }
        ...
}
```

And=20=20

```
int mlx5_get_module_eeprom(...)
{
        ...
        ret =3D mlx5_ifreq(dev, SIOCETHTOOL, &amp;ifr);
        if (ret)
                DRV_LOG(WARNING, &quot;port %u ioctl(SIOCETHTOOL) failed: %=
s&quot;,
                        dev-&gt;data-&gt;port_id, strerror(rte_errno));
        ...
}
```

dpdk-testpmd shows:=20=20

```
  testpmd&gt; show port 0 module_eeprom=20
  mlx5_net: port 0 ioctl(SIOCETHTOOL) failed: Input/output error           =
//
&lt;------------ this error.
  device is removed
```

When trying to use these functions in my own application, as dpdk-testpmd d=
oes:
rte_eth_dev_get_module_info() and rte_eth_dev_get_module_eeprom() this error
log gets printed as well.=20=20

An expected result would be to check out the return value and print these
errors if required by the caller.
For my scenario, I would like a silence fail in case there's no transceiver=
.=20=20

I've tried to overcome this by asking first if a device &quot;exists&quot; =
using
rte_eth_dev_is_removed() and rte_eth_dev_is_valid_port() but they don't ref=
lect
the transceiver state.=20=20

A possible solution would be to print these errors in DEBUG=20=20

Please advice,=20=20
Thanks.
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
?id=3D1690">
          <meta itemprop=3D"name" content=3D"View bug">
        </div>
        <meta itemprop=3D"description" content=3D"Bugzilla bug update notif=
ication">
      </div>
    </body>
</html>=

--17437111550.D67ea3A.1955444--
