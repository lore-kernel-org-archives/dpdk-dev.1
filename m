Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BA30CD8C85
	for <dpdk-dev@archiver.kernel.org>; Tue,  9 Jun 2026 07:49:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C8D0D402BE;
	Tue,  9 Jun 2026 09:49:02 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 5F395402AD
 for <dev@dpdk.org>; Tue,  9 Jun 2026 09:49:01 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 4EE424B610; Tue,  9 Jun 2026 09:49:01 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/ethdev Bug 1953] net/iavf: TX VLAN insertion offload has no
 effect on E810 in Double-VLAN-Mode (kernel iavf inserts fine on same PF)
Date: Tue, 09 Jun 2026 07:49:01 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: ethdev
X-Bugzilla-Version: 26.03
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: critical
X-Bugzilla-Who: g.navinsrinivas@gmail.com
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone attachments.created
Message-ID: <bug-1953-3@http.bugs.dpdk.org/>
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

http://bugs.dpdk.org/show_bug.cgi?id=3D1953

            Bug ID: 1953
           Summary: net/iavf: TX VLAN insertion offload has no effect on
                    E810 in Double-VLAN-Mode (kernel iavf inserts fine on
                    same PF)
           Product: DPDK
           Version: 26.03
          Hardware: x86
                OS: Linux
            Status: UNCONFIRMED
          Severity: critical
          Priority: Normal
         Component: ethdev
          Assignee: dev@dpdk.org
          Reporter: g.navinsrinivas@gmail.com
  Target Milestone: ---

Created attachment 354
  --> http://bugs.dpdk.org/attachment.cgi?id=3D354&action=3Dedit
The logs, pcap for both DPDK 25.11 and 26.03 and behaviour difference with
Kernel vlan tagging

On an Intel E810 with the PF in Double=E2=80=91VLAN=E2=80=91Mode (DVM), an =
iavf VF bound to
vfio-pci does not insert a TX VLAN tag =E2=80=94 frames egress untagged des=
pite
tx_offload vlan_insert on + tx_vlan set (and with
insertion enabled / insertion_cap: L2TAG2). The in-tree kernel iavf on the =
same
PF / adjacent VF inserts the single C=E2=80=91VLAN correctly (802.1Q on the=
 wire).
Forcing inner/L2TAG1 in the PMD doesn't help
either. Reproduced with vanilla dpdk-testpmd on both DPDK 25.11 and 26.03.

Env: E810 fw 7.9.1 / nvm 4.90 / DDP "ICE OS Default Package 1.3.49.0"; host=
 ice
on kernel 6.8.12=E2=80=91pve; guest iavf 6.17. VF VLAN_V2 caps: ins_outer=
=3D0xc0000207
(TOGGLE|XOR|L2TAG2|{8100,88A8,9100}),
ins_inner=3D0x80000101 (TOGGLE|L2TAG1|8100), VF_OFFLOAD_VLAN(v1)=3D0. Logs/=
pcaps
attached (per-version + kernel contrast).

On an Intel E810 with the PF in Double-VLAN-Mode (DVM), an iavf VF bound to
vfio-pci does not insert a TX VLAN tag =E2=80=94 frames egress untagged des=
pite
tx_offload vlan_insert on + tx_vlan set (and with insertion enabled /
insertion_cap: L2TAG2). The in-tree kernel iavf on the same PF / adjacent VF
inserts the single C-VLAN correctly (802.1Q on the wire). Forcing inner/L2T=
AG1
in the PMD doesn't help either. Reproduced with vanilla dpdk-testpmd on both
DPDK 25.11 and 26.03.

Reproduction (testpmd):
dpdk-testpmd -a <vf_pci> --file-prefix=3Dtp -l <cores> -- -i
--eth-peer=3D0,<peer_mac>
  port stop 0
  port config 0 tx_offload vlan_insert on
  tx_vlan set 0 20
  port start 0
  set fwd txonly
  start
- tcpdump on the peer: frames arrive as plain ethertype IPv4 =E2=80=94 no 8=
02.1Q / vlan
20.
- show port xstats: tx_good counts up (frames do leave the VF; no Tx error).

Expected: egress frames carry 802.1Q vlan 20.
Actual: egress frames are untagged; tx_good increments, no Tx error reporte=
d.

Ruled out: VF was trust on, spoofchk off, and the VLAN filter added via
rte_eth_dev_vlan_filter() (vlan offload: filter on) =E2=80=94 no change. Sa=
me result on
25.11 and 26.03, and with the PMD forced to inner/L2TAG1. The kernel iavf on
the same PF (adjacent VF) inserts the tag correctly, so the PF/HW and VF co=
nfig
are fine =E2=80=94 only the DPDK iavf PMD insertion path produces no tag.

Environment: E810 fw 7.9.1 / nvm 4.90 / DDP "ICE OS Default Package 1.3.49.=
0";
host ice on kernel 6.8.12-pve; guest iavf 6.17. VF VLAN_V2 caps:
ins_outer=3D0xc0000207 (TOGGLE|XOR|L2TAG2|{8100,88A8,9100}), ins_inner=3D0x=
80000101
(TOGGLE|L2TAG1|8100), VF_OFFLOAD_VLAN(v1)=3D0. Logs/pcaps attached (per-ver=
sion +
kernel contrast).

--=20
You are receiving this mail because:
You are the assignee for the bug.=
