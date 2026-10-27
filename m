Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A482F606A323
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Oct 2026 16:01:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 512B8400D7;
	Tue, 27 Oct 2026 17:01:41 +0100 (CET)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTPS id 6A384400D5
 for <dev@dpdk.org>; Tue, 27 Oct 2026 17:01:40 +0100 (CET)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 535CA4D088; Tue, 27 Oct 2026 17:01:40 +0100 (CET)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/ethdev Bug 2077] net/bonding: division by zero in ALB Tx with
 no active member
Date: Tue, 27 Oct 2026 16:01:40 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: ethdev
X-Bugzilla-Version: 26.11
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: stephen@networkplumber.org
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone attachments.created
Message-ID: <bug-2077-3@https.bugs.dpdk.org/>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
X-Bugzilla-URL: https://bugs.dpdk.org/
Auto-Submitted: auto-generated
X-Auto-Response-Suppress: All
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

https://bugs.dpdk.org/show_bug.cgi?id=3D2077

            Bug ID: 2077
           Summary: net/bonding: division by zero in ALB Tx with no active
                    member
           Product: DPDK
           Version: 26.11
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: ethdev
          Assignee: dev@dpdk.org
          Reporter: stephen@networkplumber.org
  Target Milestone: ---

Created attachment 425
  --> https://bugs.dpdk.org/attachment.cgi?id=3D425&action=3Dedit
AI proposed patch

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
ANT-2026-EDSAQEWD  [NOT SECURITY: ordinary bug]
net/bonding: division by zero in ALB Tx with no active member
Location: drivers/net/bonding/rte_eth_bond_alb.c:26  in calculate_member()
Commit:   9a45341f18a1ab47af7123e63d942b90c1b79f38
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D


Transmitting an ARP reply on a mode 6 (ALB) bonding port while none of its
members is active crashes the whole DPDK process with SIGFPE, taking down e=
very
port and queue it serves. Every other bonding mode simply returns 0 from th=
e Tx
burst in that state. The trigger is an ARP reply whose sender hardware addr=
ess
is the bond's own MAC, sent from start-up until the first member link comes=
 up,
or at any time all member links are down.

`bond_ethdev_tx_burst_alb()` in `drivers/net/bonding/rte_eth_bond_pmd.c` is=
 the
only Tx burst function without the `active_member_count` check that round
robin, active backup, TLB, balance, 802.3ad and broadcast all have. It pass=
es
ARP frames to `bond_mode_alb_arp_xmit()`. For a REPLY whose `arp_sha` equals
the bond's MAC and whose `arp_sip`/`arp_tip` pair has no client table entry
yet, that function calls `calculate_member()` in `rte_eth_bond_alb.c`, which
computes `(last_member + 1) % active_member_count` with a count of 0.

In the documented use of mode 6 the frame is the application's own reply, f=
or
example a gratuitous ARP sent at start-up before the link poll has activate=
d a
member. The attached reproducer hands one such reply to a mode 6 bond in
testpmd (io forwarding, two `net_af_packet` members with links down). It st=
ops
with a division-by-zero FPE in `calculate_member` in about two seconds, and=
 a
plain gcc build is killed by SIGFPE the same way.

The division appears to date back to the commit that added mode 6
(06fe78b98ccd). A patch is attached that adds the missing check to the ALB =
Tx
path, makes `calculate_member()` tolerate a count of 0, and adds a unit tes=
t.

## Details

This is an ordinary bug, not a security issue: it needs a mode 6 bond with =
no
active member, a state no outside party can bring about and in which the bo=
nd
carries no traffic anyway, and an ARP reply with the bond's own MAC as send=
er
handed to the bond's transmit function, which in the documented use of mode=
 6
is a reply the application writes itself.

`bond_ethdev_tx_burst_alb()` processes a burst even when the bonding port h=
as
no
active member, and its ARP path computes an index modulo `active_member_cou=
nt`.
Entry point: `rte_eth_tx_burst()` on a mode 6 (ALB) bonding port. Tested at
commit
9a45341f18a1; the default build is affected.

Every other Tx burst function in `drivers/net/bonding/rte_eth_bond_pmd.c`
returns
before touching the burst when there is no active member: round robin (`:63=
5`),
active backup (`:687`), TLB (`:975`), balance (`:1260`), 802.3ad (`:1289`),
broadcast (`:1380`). The ALB function has no such test and goes from its
declarations straight into the classification loop,
`drivers/net/bonding/rte_eth_bond_pmd.c:1063`:

```c
        int i, j;

        /* Search tx buffer for ARP packets and forward them to alb */
        for (i =3D 0; i < nb_pkts; i++) {
                eth_h =3D rte_pktmbuf_mtod(bufs[i], struct rte_ether_hdr *);
                ether_type =3D eth_h->ether_type;
                offset =3D get_vlan_offset(eth_h, &ether_type);

                if (ether_type =3D=3D rte_cpu_to_be_16(RTE_ETHER_TYPE_ARP))=
 {
                        member_idx =3D bond_mode_alb_arp_xmit(eth_h, offset,
internals);
```

`bond_mode_alb_arp_xmit()` (`drivers/net/bonding/rte_eth_bond_alb.c:128`)
decides
on two fields of the ARP payload. A frame whose `arp_sha` differs from the
bond's
MAC is assigned to the current primary port (`:147`) and nothing is divided=
. A
frame whose `arp_sha` equals the bond's MAC and whose opcode is REPLY (`:15=
8`)
is
looked up in the client table by `arp_tip`; unless an entry with the same
`arp_sip`/`arp_tip` pair already exists (`:159`-`:178`), a member is assign=
ed
to
the client, `rte_eth_bond_alb.c:187`:

```c
                client_info->member_idx =3D calculate_member(internals);
```

`rte_eth_bond_alb.c:21`:

```c
static uint16_t
calculate_member(struct bond_dev_private *internals)
{
        uint16_t idx;

        idx =3D (internals->mode6.last_member + 1) %
internals->active_member_count;
```

With `active_member_count =3D=3D 0` this is an integer division by zero: SI=
GFPE on
x86, which terminates the process.

`active_member_count` is 0 in ordinary operation. `bond_ethdev_start()` does
not
fill `active_members[]`; a member is added only by `activate_member()` in
`bond_ethdev_lsc_event_callback()` once its link is reported up
(`rte_eth_bond_pmd.c:3111`) and removed again when its link goes down
(`:3124`).
So the count is 0 from start until the first member link comes up, and when=
ever
all member links are down. The bonding port reports link down in that state,
but
nothing stops an application from calling `rte_eth_tx_burst()` on it, and w=
ith
the other modes it gets 0 back.

Shown with testpmd: port 0 is `net_pcap0`, port 3 is a mode 6 bond over two
`net_af_packet` members whose links are down, forwarding mode `io`.
`show bonding config 3` prints `Active Members: []`. The capture holds one
60-byte
ARP reply with the bond's MAC `02:aa:bb:cc:dd:01` as sender hardware addres=
s:

```
02 00 00 00 00 0a  02 00 00 00 00 0b  08 06            dst, src, ARP
00 01 08 00 06 04  00 02                               Ethernet/IPv4, REPLY
02 aa bb cc dd 01  0a 00 00 01                         arp_sha =3D bond MAC,
arp_sip
02 00 00 00 00 0a  0a 00 00 02                         arp_tha, arp_tip
(18 bytes of padding)
```

After `start`, `/src/build-asan/app/dpdk-testpmd` stops with:

```
../drivers/net/bonding/rte_eth_bond_alb.c:26:43: runtime error: division by
zero
=3D=3D739=3D=3DERROR: AddressSanitizer: FPE on unknown address 0x56543ac40e=
f4 (pc
0x56543ac40ef4 ... T3)
    #0 0x56543ac40ef4 in calculate_member
/src/build-asan/../drivers/net/bonding/rte_eth_bond_alb.c:26:43
    #1 0x56543ac4271e in bond_mode_alb_arp_xmit
/src/build-asan/../drivers/net/bonding/rte_eth_bond_alb.c:187:29
    #2 0x56543ac988d6 in bond_ethdev_tx_burst_alb
/src/build-asan/../drivers/net/bonding/rte_eth_bond_pmd.c:1072:17
    #3 0x565434f9b0b9 in rte_eth_tx_burst
/src/build-asan/../lib/ethdev/rte_ethdev.h:6565:12
    #4 0x565434f98f92 in common_fwd_stream_transmit
/src/build-asan/../app/test-pmd/testpmd.h:945:10
    #5 0x565434f98b2f in pkt_burst_io_forward
/src/build-asan/../app/test-pmd/iofwd.c:57:2
SUMMARY: AddressSanitizer: FPE
/src/build-asan/../drivers/net/bonding/rte_eth_bond_alb.c:26:43 in
calculate_member
```

`/src/build/app/dpdk-testpmd` (gcc, debugoptimized) with the same arguments=
 is
killed by SIGFPE, and the kernel logs `trap divide error` for `dpdk-worker1=
`.
Two controls behave normally: the same frame with both member links up is
forwarded, and an ARP reply that differs only in `arp_sha` (the sender's own
MAC) is handled without a crash while the links are down. The `mac=3D` deva=
rg is
not needed; without it the bond has the first member's MAC and a frame carr=
ying
that address crashes testpmd the same way.

## Impact

One ARP reply transmitted on a mode 6 bonding port that has no active member
kills the DPDK process (SIGFPE in a plain build), and with it every port and
queue that process serves, where every other mode drops the burst. Nothing =
is
corrupted. The frame needs `arp_sha` equal to the bond's MAC and an
`arp_sip`/`arp_tip` pair without a client table entry.

ALB mode is described for ARP replies sent by the local system
(`drivers/net/bonding/rte_eth_bond.h:78`), so in practice the frame is the
application's own reply. An application meets the crash when it sends one w=
hile
all member links are down: a gratuitous ARP sent at start-up before the fir=
st
link poll has activated a member, or a reply sent during a total link outag=
e.
An application that answers ARP requests itself receives no requests throug=
h a
bond with no active member, so ordinary neighbour traffic does not lead the=
re;
replies already in flight when the last link drops normally go out before t=
he
10 ms link poll deactivates the member.

The testpmd `io` set-up above, which transmits received ARP frames on the b=
ond
unchanged, is only a convenient way to hand such a frame to the bond's tran=
smit
function; it is not a working deployment. With the links up, mode 6 rewrites
the
Ethernet source and ARP sender address of every forwarded ARP reply to the
bond's
MAC (`drivers/net/bonding/rte_eth_bond_alb.c:146-150`), so the hosts behind
such a
forwarder would map every neighbour's address to the bond.

## Reproducing

`repro` runs the prebuilt `/src/build-asan/app/dpdk-testpmd` once; nothing =
is
built. It needs root: it moves itself into a private network namespace
(`unshare(CLONE_NEWNET)`) and creates two veth interfaces there, `bond_m0` =
and
`bond_m1`, which disappear with the script.

* `repro.d/make_arp_reply_pcap.py` writes a capture with one 60-byte ARP re=
ply
  whose sender hardware address is its second argument. `repro` passes the
bond's
  MAC `02:aa:bb:cc:dd:01` (the layout is the one shown in Details).
* `repro` is the setup, the testpmd run and the check. The veth interfaces
  are never set up, so `net_af_packet`, which reports link state from
  `IFF_RUNNING`, reports both members' links down and the bond activates
neither:
  the state of a bond whose member links are all down. The `mac=3D` devarg =
only
makes
  the bond's address known to the script; without it the bond takes the fir=
st
  member's MAC and a frame carrying that one crashes the same way.

The testpmd run is

```
dpdk-testpmd -l 0-1 --no-huge -m 512 --no-pci \
    --vdev
net_pcap0,rx_pcap=3D/tmp/arp_reply_with_bond_mac.pcap,tx_pcap=3D/dev/null \
    --vdev net_af_packet0,iface=3Dbond_m0 --vdev net_af_packet1,iface=3Dbon=
d_m1 \
    --vdev
net_bonding0,mode=3D6,member=3Dnet_af_packet0,member=3Dnet_af_packet1,mac=
=3D02:aa:bb:cc:dd:01
\
    -- -i --total-num-mbufs=3D4096 --portlist=3D0,3 --no-flush-rx
```

with `show bonding config 3`, `set fwd io`, `start`, `stop`, `quit` on stdi=
n:
io forwarding hands the captured frame (port 0) to `rte_eth_tx_burst()` on =
the
bond (port 3). `--no-flush-rx` keeps testpmd from discarding the frame befo=
re
forwarding starts; `stdbuf -oL` keeps testpmd's stdout when it dies.

The script prints the `Active Members` line of `show bonding config 3`, the
UBSan `division by zero` line, testpmd's exit status and the first four lin=
es
of
the AddressSanitizer report, and prints `BUG` when the bond had no active
member
and the report is an `FPE` with `calculate_member` as frame #0 and
`bond_ethdev_tx_burst_alb` as frame #2. Expected output (about 2 seconds):

```
OBSERVED show bonding config 3: ['Active Members: []']
OBSERVED UBSan: ['../drivers/net/bonding/rte_eth_bond_alb.c:26:43: runtime
error: division by zero']
OBSERVED testpmd exit status 1
FPE on unknown address 0x55c0cbffbef4 (pc 0x55c0cbffbef4 bp 0x7bc7a99a49f0 =
sp
0x7bc7a99a4940 T3)
    #0 0x55c0cbffbef4 in calculate_member
/src/build-asan/../drivers/net/bonding/rte_eth_bond_alb.c:26:43
    #1 0x55c0cbffd71e in bond_mode_alb_arp_xmit
/src/build-asan/../drivers/net/bonding/rte_eth_bond_alb.c:187:29
    #2 0x55c0cc0538d6 in bond_ethdev_tx_burst_alb
/src/build-asan/../drivers/net/bonding/rte_eth_bond_pmd.c:1072:17
BUG
```

The sanitizer only names the line: `/src/build/app/dpdk-testpmd` (gcc,
debugoptimized) with the same arguments is killed by SIGFPE. With the attac=
hed
patch applied and testpmd rebuilt, the bond drops the frame, testpmd reaches
`Bye...` and `repro` prints `OK`.

## Suggested fix

The attached patch makes two changes in the driver and adds a unit test.

`bond_ethdev_tx_burst_alb()` gets the test its six siblings have, before the
classification loop:

```diff
--- a/drivers/net/bonding/rte_eth_bond_pmd.c
+++ b/drivers/net/bonding/rte_eth_bond_pmd.c
@@ -1062,6 +1062,9 @@ bond_ethdev_tx_burst_alb(void *queue, struct rte_mbuf
**bufs, uint16_t nb_pkts)

        int i, j;

+       if (internals->active_member_count < 1)
+               return 0;
+
        /* Search tx buffer for ARP packets and forward them to alb */
        for (i =3D 0; i < nb_pkts; i++) {
                eth_h =3D rte_pktmbuf_mtod(bufs[i], struct rte_ether_hdr *);
```

A bond with no active member now returns 0 and leaves the burst to the call=
er,
as every other mode does.

`calculate_member()` (`drivers/net/bonding/rte_eth_bond_alb.c:21`) now reads
`active_member_count` once into a local and returns
`internals->current_primary_port` when it is 0. The link status callback, w=
hich
does not run on the forwarding lcore, can deactivate the last member between
the
new test and the modulo; round robin, balance, 802.3ad and broadcast avoid =
this
by working on a local copy of the count, and this change closes the same wi=
ndow
for ALB. It also covers the second caller, `bond_mode_alb_arp_recv()`
(`rte_eth_bond_alb.c:115`), which the receive side reaches only through that
race with the link status callback.

`test_alb_tx_burst_no_active_member` in `app/test/test_link_bonding.c` (par=
t of
`link_bonding_autotest`) starts an ALB bond with all member links down and
transmits an ARP reply with the bond's MAC as sender; it dies with SIGFPE on
the
unpatched driver and passes with the fix.

With the patch applied and rebuilt, `repro` prints `OK`, forwarding with bo=
th
links up is unchanged and the bonding unit test suite passes. The patch is a
plain diff; its commit message should carry
`Fixes: 06fe78b98ccd ("bond: add mode 6")`, the commit that introduced the
division with the mode itself, and `Cc: stable@dpdk.org`.

--=20
You are receiving this mail because:
You are the assignee for the bug.=
