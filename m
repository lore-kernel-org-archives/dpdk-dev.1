Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2C67E9E31E
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Feb 2026 15:15:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 15E60402AB;
	Wed, 11 Feb 2026 16:15:53 +0100 (CET)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id ED85540297
 for <dev@dpdk.org>; Wed, 11 Feb 2026 16:15:51 +0100 (CET)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id D70C64A600; Wed, 11 Feb 2026 16:15:51 +0100 (CET)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/ethdev Bug 1879] net/mlx5: dev_info.tx_desc_lim.nb_min is zero
 (uninitialized),
 causing port start failure when TX descriptors set to 0
Date: Wed, 11 Feb 2026 15:15:51 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: ethdev
X-Bugzilla-Version: 26.03
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: sismis@dyna-nic.com
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone
Message-ID: <bug-1879-3@http.bugs.dpdk.org/>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
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

http://bugs.dpdk.org/show_bug.cgi?id=3D1879

            Bug ID: 1879
           Summary: net/mlx5: dev_info.tx_desc_lim.nb_min is zero
                    (uninitialized), causing port start failure when TX
                    descriptors set to 0
           Product: DPDK
           Version: 26.03
          Hardware: x86
                OS: Linux
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: ethdev
          Assignee: dev@dpdk.org
          Reporter: sismis@dyna-nic.com
  Target Milestone: ---

Description
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

The Mellanox (mlx5) PMD driver does not populate dev_info.tx_desc_lim.nb_min
with a valid value. It currently reports 0 (zero) as the minimum number of =
TX
descriptors. This leads to a port start failure when an application configu=
res
a minimum number of TX descriptors on a TX queue, because the driver accepts
the configuration but then fails internally during port start.

This is particularly problematic for applications that are RX-only (packet
capture/reading applications) and have no intention of transmitting any
packets. Such applications should logically be able to set TX descriptor co=
unt
to 0 or at least to a very small number to conserve resources, but the curr=
ent
behavior makes this impossible.

Steps to Reproduce
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

1. Call rte_eth_dev_info_get() and observe that dev_info.tx_desc_lim.nb_min=
 =3D=3D
0.
2. Configure a TX queue with nb_tx_desc =3D 0 via rte_eth_tx_queue_setup().
   Since nb_min is 0, the ethdev layer does not reject this configuration.
3. Attempt to start the port with rte_eth_dev_start().
4. Port start fails.

Note: This bug cannot be reproduced using testpmd, because testpmd has inte=
rnal
logic that prevents setting the TX descriptor count to zero (it enforces its
own minimum regardless of what the driver reports). This means the bug is
effectively hidden from the most common DPDK testing tool. I could reproduc=
e it
in Suricata.

Expected Behavior
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

The mlx5 driver should report a correct, non-zero nb_min value in
dev_info.tx_desc_lim.nb_min (matching the actual hardware/driver minimum). =
This
way, the ethdev layer can properly validate the number of TX descriptors at
configuration time and return a clear error to the user, rather than silent=
ly
accepting an invalid configuration that fails later during port start.

Actual Behavior
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

dev_info.tx_desc_lim.nb_min is reported as 0. The ethdev layer allows
configuring 0 TX descriptors (since 0 >=3D nb_min which is 0). The port then
fails to start with no clear indication that the root cause is the zero TX
descriptor count.
When set to less than 32, the driver complains about the value being lower =
than
MLX5_TX_COMP_THRESH, but this macro is not available in the user application
code.

```
$ sudo dpdk-testpmd -a 0000:3b:00.0 -- -i --forward-mode=3Drxonly  --txd=3D=
16
...
mlx5_net: port 0 number of descriptors requested for Tx queue 0 must be hig=
her
than MLX5_TX_COMP_THRESH, using 33 instead of 16
mlx5_net: port 0 increased number of descriptors in Tx queue 0 to the next
power of two (64)
...
```

Additional Remarks
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Previous DPDK versions allowed configuration of 0 TX descriptors. On some s=
ites
I've found, DPDK devices should not be configured with 0 TX descriptors but=
 I
see no reason for not doing so.


Environment
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

- DPDK version: 26.03-dev (dce76acf61859242946e619cf6113de5e134b117)
- NIC: Mellanox ConnectX-6 (mlx5 PMD)
- OS: Oracle Linux 8
- Architecture: x86_64

--=20
You are receiving this mail because:
You are the assignee for the bug.=
