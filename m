Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CE1CCD6E57
	for <dpdk-dev@archiver.kernel.org>; Wed,  3 Jun 2026 17:24:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5E8F240648;
	Wed,  3 Jun 2026 19:24:55 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 06A20402C4
 for <dev@dpdk.org>; Wed,  3 Jun 2026 19:24:54 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id ECF624B5BC; Wed,  3 Jun 2026 19:24:53 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/ethdev Bug 1950] Lots of problems found from review of ARK PMD
Date: Wed, 03 Jun 2026 17:24:53 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: ethdev
X-Bugzilla-Version: 22.03
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: major
X-Bugzilla-Who: stephen@networkplumber.org
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone
Message-ID: <bug-1950-3@http.bugs.dpdk.org/>
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

http://bugs.dpdk.org/show_bug.cgi?id=3D1950

            Bug ID: 1950
           Summary: Lots of problems found from review of ARK PMD
           Product: DPDK
           Version: 22.03
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: major
          Priority: Normal
         Component: ethdev
          Assignee: dev@dpdk.org
          Reporter: stephen@networkplumber.org
  Target Milestone: ---

In addition to the problems identified by LF scan, using Claude Opus found a
lot more in this driver:

Component: drivers/net/ark
Version: main

Manual review of the full ark driver tree (ark_ethdev.c, ark_ethdev_rx.c,
ark_ethdev_tx.c, ark_pktgen.{c,h}, ark_pktchkr.{c,h}, ark_mpu.c, ark_pktdir=
.c)
turned up the issues below, in addition to existing scanner reports (strncat
length-arg misuse and non-NUL-terminating strncpy in process_file_args;
unchecked rte_zmalloc_socket before memcpy in ark_dev_init).

=3D=3D SECURITY (suggest separate tracking item) =3D=3D

S1. Unvalidated dlopen() driver overload in check_for_ext() (ark_ethdev.c)
    Loads an arbitrary .so from the ARK_EXT_PATH environment variable
    (dlopen(path, RTLD_LOCAL | RTLD_LAZY)) and resolves ~12 rte_pmd_ark_*
    symbols that are cast to function pointers and called on the control and
    data paths. No path validation, allow-list, ownership/permission check,=
 or
    integrity check. DPDK apps commonly run privileged, so any process able=
 to
    influence the environment gets arbitrary in-process code execution -- a
    local code-injection / privesc vector. RTLD_LAZY defeats up-front symbol
    validation; unchecked dlsym casts are UB on ABI mismatch.
    Recommendation: gate behind a build option off by default; refuse to lo=
ad
    when privileged or when the file is not root-owned / is world-writable;
    document as debug-only.

=3D=3D HIGH - crashes / memory safety =3D=3D

1. NULL deref in ark_pktgen_setup() (ark_pktgen.c): pktgen toptions[] has no
   "port" entry (only pktchkr's does), but the run branch calls
   options("port")->v.INT; options() returns NULL on miss. Crashes whenever
   Pkt_gen config sets run=3D1.

2. ark_tx_queue_release() missing NULL guard (ark_ethdev_tx.c): ark_dev_clo=
se()
   calls it for every tx_queues[] slot and ark_dev_stop() loops over
   ark_tx_queue_stop() without checks; both deref queue->ddm / cons_index. =
RX
   side guards (queue =3D=3D 0); TX side does not -> NULL deref on close/st=
op with
   any un-setup TX slot.

3. ark_dev_rx_queue_count() missing NULL guard (ark_ethdev_rx.c): dereferen=
ces
   queue with no queue =3D=3D 0 check, unlike every other entry point in th=
e file.

4. mac_addrs alloc failure not handled (ark_ethdev.c ark_dev_init, ~L381):
   failure is logged but execution falls through with mac_addrs =3D=3D NULL=
; the
   secondary-port path (~L461) uses goto error, the primary does not.

5. error: path leaks secondary ports (ark_ethdev.c ark_dev_init, ~L480): on=
ly
   the primary mac_addrs is freed; already-probed secondary eth_devs and th=
eir
   dev_private/mac_addrs leak.

=3D=3D HIGH - silent data corruption =3D=3D

6. OTLONG written through wrong union member (ark_pktgen.c pmd_set_arg,
   ark_pktchkr.c set_arg): "case OTLONG: o->v.INT =3D atoll(val);" truncate=
s to
   32 bits and leaves stale upper bits in .LONG. Affects num_pkts,
   src_mac_addr, dst_mac_addr. Should be o->v.LONG.

7. src_mac_addr / num_pkts read via .v.INT in setup (both *_setup()): these=
 are
   OTLONG; reading .INT drops upper MAC bytes (default 0xdC3cF6425060).
Adjacent
   dst_mac_addr correctly uses .LONG.

=3D=3D MEDIUM =3D=3D

8. parse_ipv4_string() return type (ark_pktgen.c, ark_pktchkr.c): declared
   int32_t but builds values up to 0xFFFFFFFF via unsigned math; default
   169.254.10.240 goes negative on conversion. Should be uint32_t. "return =
0"
   on parse failure also aliases a valid 0.0.0.0.

9. Divide-by-zero risk in ark_api_num_queues_per_port() (ark_mpu.c):
   num_queues / ark_ports; ark_ports derives from untrusted
   user_ext.dev_get_port_count(), unchecked for 0.

10. pkt_size_min > pkt_size_max defaults: 2006/2005 vs 1514 in both option
    tables; likely a typo.

11. dst_port / src_port default 65536: out of range for a 16-bit port.

=3D=3D LOW / cleanup =3D=3D

12. Misplaced log in ark_pktchkr_wait_done(): "pktgen done" prints every lo=
op
    iteration instead of once after completion.

13. ark_pktchkr_get_pkts_sent() returns int for a uint32_t register
    (signedness); pktgen version returns uint32_t.

14. *_parse() tokenizer/doc mismatch: comments document comma-separated arg=
s;
    toks[] omits ','.

15. inst->dev_info never set/used in ark_pkt_gen_inst / ark_pkt_chkr_inst
    (allocated via rte_malloc, not zmalloc).

16. check_for_ext() "found" is dead: never reassigned; only the -1
    dlopen-failure path is meaningful.

17. ark_mpu_configure() logs ring_size (uint32_t) with %d.

=3D=3D PROCESS / TOOLING =3D=3D

P1. Non-inclusive naming not caught by review tooling: en_slaved_start
    (ark_pktgen.c toptions[] and the ark_pktgen_set_pkt_ctrl() parameter) u=
ses
    terminology DPDK has been retiring. The substantive point is that
    checkpatches.sh / the checkpatch master|slave test should have flagged =
this
    and did not -- indicating the file was either grandfathered in or the c=
heck
    is not being run against this tree. Coverage gap in the tooling, not ju=
st a
    naming nit. Suggest renaming (e.g. en_gated_start) and reviewing why the
    automated check missed it.

--=20
You are receiving this mail because:
You are the assignee for the bug.=
