Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94863606A31E
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Oct 2026 16:12:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 60AF6400D7;
	Tue, 27 Oct 2026 17:12:45 +0100 (CET)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTPS id 627E3400D5
 for <dev@dpdk.org>; Tue, 27 Oct 2026 17:12:44 +0100 (CET)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 52B8F4D342; Tue, 27 Oct 2026 17:12:44 +0100 (CET)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/ethdev Bug 2081] net/e1000: igb PF never removes VF multicast
 hashes from shared MTA
Date: Tue, 27 Oct 2026 16:12:44 +0000
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
Message-ID: <bug-2081-3@https.bugs.dpdk.org/>
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
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

https://bugs.dpdk.org/show_bug.cgi?id=3D2081

            Bug ID: 2081
           Summary: net/e1000: igb PF never removes VF multicast hashes
                    from shared MTA
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

Created attachment 429
  --> https://bugs.dpdk.org/attachment.cgi?id=3D429&action=3Dedit
AI proposed patch

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
ANT-2026-YE47Z1IV  [NOT SECURITY: ordinary bug]
net/e1000: igb PF never removes VF multicast hashes from shared MTA
Location: drivers/net/intel/e1000/igb_pf.c:357  in igb_vf_set_multicast()
Commit:   9a45341f18a1ab47af7123e63d942b90c1b79f38
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
In the igb PF driver, multicast hash bits that a VF asks for are added to t=
he
port's shared multicast filter (MTA) but never removed. Over time that filt=
er
only widens, and every pool that accepts hash-matched multicast (all VFs and
the PF pool) receives multicast frames nobody subscribed to. The reverse al=
so
happens: when the PF application calls `rte_eth_dev_set_mc_addr_list()`, the
table is rebuilt from the PF's list alone and every VF silently loses the
multicast groups it registered.

The cause is in `igb_vf_set_multicast()` in `drivers/net/intel/e1000/igb_pf=
.c`.
The VF driver sends its complete list on every update, but the handler ORs =
the
hash values into `MTA` rather than replacing that VF's previous bits. It al=
so
saves the list into `vfinfo[0]` whichever VF sent it, and that saved list is
never read back to rebuild the table. `igb_vf_reset_event()` only zeroes a
counter, so neither an empty list nor a VF reset clears anything. Only a
PF-side multicast list update or a port restart does, and both drop the VFs'
entries. The attached reproducer runs the unmodified PF code on RAM-backed
82576 registers with two VFs. After VF1 sends 137 lists of up to 30 hash
values, all 4096 `MTA` bits are set, and they stay set after VF1 sends an e=
mpty
list and resets. A well-behaved VF that replaces a 2-entry list with a 1-en=
try
list likewise leaves 5 bits set instead of 3. There is no crash or memory
effect, and the effect on frame delivery is inferred from register meaning
rather than observed on hardware. A patch is attached that rebuilds `MTA` f=
rom
the PF's shadow list plus each VF's saved list, following the Linux igb dri=
ver.

This is an ordinary bug, not a security issue: a VF can already choose any =
30
multicast hash bits and change them at
will, and can already make every other pool receive frames by sending
broadcast, so a multicast filter that stops
narrowing gives it nothing it did not have.

## Details

`igb_vf_set_multicast()` handles a VF's `E1000_VF_SET_MULTICAST` mailbox
message by ORing the VF's hash values into
`MTA`, the one multicast hash filter of the port, which the PF and all VFs
share. Nothing takes a VF's bits out again,
so the limit of 30 hash values, which is what fits in one mailbox message
(`base/e1000_vf.c:386`), applies to one
message, not to what a VF has accumulated
(`drivers/net/intel/e1000/igb_pf.c:335`):

```c
        /* only so many hash values supported */
        entries =3D RTE_MIN(entries, E1000_MAX_VF_MC_ENTRIES);
        =E2=80=A6
        vfinfo->num_vf_mc_hashes =3D (uint16_t)entries;
        =E2=80=A6
        for (i =3D 0; i < vfinfo->num_vf_mc_hashes; i++) {
                vector_reg =3D (vfinfo->vf_mc_hashes[i] >> 5) & 0x7F;
                vector_bit =3D vfinfo->vf_mc_hashes[i] & 0x1F;
                mta_reg =3D E1000_READ_REG_ARRAY(hw, E1000_MTA, vector_reg);
                mta_reg |=3D (1 << vector_bit);
                E1000_WRITE_REG_ARRAY(hw, E1000_MTA, vector_reg, mta_reg);
        }
```

Running this code unmodified on RAM-backed registers (commit 9a45341f18,
default gcc build; see Reproducing): VF1 sends
137 `E1000_VF_SET_MULTICAST` messages of at most 30 hash values each. `MTA`=
 has
30 bits set after the first message and
all 4096 after the last. VF1 then sends an empty list and `E1000_VF_RESET`;
4096 bits stay set.

The message reaches the handler without any per-VF state check. `ICR.VMMB`
makes `eth_igb_interrupt_action()` call
`igb_pf_mbx_process()` (`igb_ethdev.c:3011`), and `igb_rcv_msg_from_vf()`
copies the 16 mailbox words
(`igb_pf.c:431`), dispatches on `msgbuf[0] & 0xFFFF` (`igb_pf.c:450`) and c=
alls
`igb_vf_set_multicast()`
(`igb_pf.c:455`). The entry count is bits 16-23 of word 0 and the hash valu=
es
are the 30 16-bit halves of words 1-15,
all written by the VF.

On the VF side the message carries the complete list:
`e1000_update_mc_addr_list_vf()` (`base/e1000_vf.c:376`) sends
every hash value on each update. The PF handler treats it as "add these". I=
ts
comment says the list is saved "for
later use to restore when the PF multi cast list changes" (`igb_pf.c:338`),=
 but
`vf_mc_hashes` is read nowhere except
in the loop above, and the save itself goes to `vfinfo[0]` whichever VF sent
the message (`vfinfo->=E2=80=A6`; the `vf`
argument is `__rte_unused`). So a well-behaved VF leaves bits behind too: in
the same setup, VF0 holding 2 hash values
and VF1 replacing a list of 2 with a list of 1 leaves 5 bits set, not 3.

A VF reset does not help. `igb_vf_reset_event()` only zeroes a counter
(`igb_pf.c:247`):

```c
        /* reset multicast table array for vf */
        vfinfo[vf].num_vf_mc_hashes =3D 0;
```

`MTA` bits are cleared in two places only, both driven by the PF applicatio=
n:
`e1000_update_mc_addr_list_generic()`
(`base/e1000_mac.c:583`), reached from `rte_eth_dev_set_mc_addr_list()`,
rewrites the table from the PF's own list,
and `e1000_init_hw_base()` (`base/e1000_base.c:72`) zeroes it when the port=
 is
started. Neither includes the VFs'
saved lists, so the opposite also happens: when the PF application calls
`rte_eth_dev_set_mc_addr_list()`, every VF
silently loses its multicast groups (3 VF groups before, 0 after, in the sa=
me
RAM-register setup).

A set bit is not private to the VF that set it. A pool accepts frames that
match `MTA` when its `VMOLR.ROMPE` is set
(`base/e1000_82575.h:283`), and the PF sets that for every VF at reset
(`igb_pf.c:241`) and for its own pool whenever
the port is not in promiscuous or all-multicast mode (`igb_pf.c:217`).
`E1000_VF_SET_PROMISC` is not implemented in
`igb_pf.c`: it has no case in the dispatcher and is answered with a NACK
(`igb_pf.c:463`). The ixgbe PF grants
all-multicast to any VF that asks (`ixgbe_pf.c:760`).

## Impact

Affected: an 82576 or I350 port whose PF is driven by the DPDK igb PMD with=
 VFs
enabled. Default build, no offload or
devarg.

The port's multicast hash filter only grows while VFs are in use. Every tim=
e a
VF driver changes its multicast list,
the hash bits of the old list stay set, so over time every pool with `ROMPE`
(all VFs and the PF pool) is handed
multicast frames nobody subscribed to, which costs Rx descriptors and CPU a=
nd
has to be dropped in software. A VF that
sends many lists (137, in the reproducer) opens the filter completely. The
stale bits outlive the VF: an empty list or
a VF reset does not clear them; only the PF application rewriting its multi=
cast
list or restarting the port does. The
problem users are more likely to notice is the reverse: a call to
`rte_eth_dev_set_mc_addr_list()` on the PF drops
every VF's multicast groups, and the VFs stop receiving the multicast traff=
ic
they asked for.

None of this gives a VF more than it already has. It may pick any 30 hash b=
its
and replace them at will, so it can
already listen to any group it names; the 30 is the mailbox size, not a quo=
ta.
It can already load every other pool by
sending broadcast, since the PF enables VF-to-VF loopback (`igb_pf.c:151`) =
and
broadcast accept for every VF pool
(`igb_pf.c:241`). There is no memory effect, no crash, and no effect on uni=
cast
or VLAN filtering. The effect on frame
delivery follows from the register state; it was not observed on hardware.

## Reproducing

There is no 82576 or I350 in the test image, so the reproducer runs the
driver's own PF code on a register file in RAM
and reads the registers back. It uses the default gcc build (`/src/build`) =
and
takes about a second.

Files:

* `repro.d/igb_pf_on_ram_bar0.c` (setup: the PF). Links `igb_pf.c` and the
e1000 base code unmodified from the
  already built `/src/build/drivers/librte_net_e1000.a`, points `hw->hw_add=
r`
at a 128 KB array and brings up an
  82576 PF with two VFs through `igb_pf_host_init()` and
`igb_pf_host_configure()`, as `eth_igb_dev_init()` and
  `eth_igb_start()` do. It then reads one step per stdin line. `vf<N> <word=
s>`
writes the words to `VMBMEM(N)`, sets
  the VF's request bit in `MBVFICR` as the NIC would, calls
`igb_pf_mbx_process()` (what the `ICR.VMMB` interrupt
  does) and answers with word 0 of the PF's reply. `mta` answers with the
number of bits set in `MTA`. `rompe` lists
  the pools that have `VMOLR.ROMPE`.
* `repro.d/start_igb_pf.py` (setup). Compiles that program with gcc against=
 the
build and starts it.
* `repro` (VF1's messages, plus the check). Both VFs first send
`E1000_VF_RESET`, as any VF driver does. VF1 then
  sends 137 `E1000_VF_SET_MULTICAST` messages: the entry count in bits 16-2=
3 of
word 0, then the 16-bit hash values two
  per word. Each message holds at most 30 values (136 with 30, one with 16),
and together they cover hash values
  0 to 4095. VF1 then sends an empty list and `E1000_VF_RESET`. If the PF d=
oes
not ACK a message, the script stops
  there.

Expected output on 9a45341f18:

```
CONTROL MTA bits set before any VF list: 0
CONTROL MTA bits set after VF1's first list of 30: 30
OBSERVED MTA bits set after 137 lists from VF1: 4096 of 4096 (correct: 16,
VF1's last list)
OBSERVED MTA bits set after VF1's empty list: 4096 (correct: 0)
OBSERVED MTA bits set after VF1's reset: 4096 (correct: 0)
OBSERVED pools that accept multicast frames matching the MTA (VMOLR.ROMPE):=
 VF0
VF1 PF
BUG
```

The `correct` value is the PF's own bits (none) plus the list VF1 currently
holds. `BUG` is printed when VF1's lists
have set all 4096 bits, the bits are still set after the empty list and aft=
er
the reset, and VF0 and the PF pool have
`ROMPE` (so they receive frames that match those bits). With the attached p=
atch
applied and `igb_pf.c` linked in place
of the archive member, the same run shows 30, 16, 0 and 0 bits and prints `=
OK`.

## Suggested fix

The attached patch (`drivers/net/intel/e1000/igb_pf.c`) treats `MTA` as der=
ived
state. It adds a static helper,
`igb_pf_restore_mta()`, that rewrites the whole table from `hw->mac.mta_sha=
dow`
(the PF's own list, maintained by
`e1000_update_mc_addr_list_generic()`) ORed with the saved list of every VF,
the way `igb_restore_vf_multicasts()` does
in the Linux igb driver. `igb_vf_set_multicast()` now stores the list in
`vfinfo[vf]` instead of `vfinfo[0]` (the `vf`
argument loses `__rte_unused`), drops its OR loop and calls the helper, so a
new list replaces the VF's old one.
`igb_vf_reset_event()` calls the helper after zeroing the VF's count. With =
it
the reproducer shows 30, 16, 0 and 0 bits
and VF0's bits survive a reset of VF1; it was not run on hardware. The tabl=
e is
now rewritten (128 register writes) on
each VF multicast message and VF reset, which is control path only.

The patch is a bare diff: it needs a commit message with `Fixes: be2d648a2d=
d3
("igb: add PF support")` and
`Cc: stable@dpdk.org`, and the helper keeps the original `1 << vector_bit`,
which should be `1U <<` for bit 31.

Two things the patch leaves alone. `eth_igb_set_mc_addr_list()`
(`igb_ethdev.c:4831`) and port start still rewrite
`MTA` without the VFs' entries; they should end with the same helper, which
would fix the PF-side loss of VF groups
described above. And `ixgbe_pf.c:507`, `ngbe_pf.c:403` and `txgbe_pf.c:491`
contain the same store-to-`vfinfo[0]`-and-OR
loop; those belong in separate per-driver patches.

--=20
You are receiving this mail because:
You are the assignee for the bug.=
