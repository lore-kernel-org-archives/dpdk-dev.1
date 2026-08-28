Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3A8CC61DBD
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Aug 2026 14:26:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 46EE740151;
	Fri, 28 Aug 2026 16:26:40 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 3C2E940150
 for <dev@dpdk.org>; Fri, 28 Aug 2026 16:26:38 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 257284CFAD; Fri, 28 Aug 2026 16:26:38 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/other Bug 2005] GTP ptype parser out-of-bounds read
Date: Fri, 28 Aug 2026 14:26:38 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: other
X-Bugzilla-Version: unspecified
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: thomas@monjalon.net
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone bug_group
Message-ID: <bug-2005-3@https.bugs.dpdk.org/>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
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

https://bugs.dpdk.org/show_bug.cgi?id=3D2005

            Bug ID: 2005
           Summary: GTP ptype parser out-of-bounds read
           Product: DPDK
           Version: unspecified
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: other
          Assignee: dev@dpdk.org
          Reporter: thomas@monjalon.net
  Target Milestone: ---
             Group: security

Report date: 2026-06-02
Reported by: Borys Tsyrulnikov <tsyrulnikov.borys@gmail.com>

Hello DPDK security team,

I'm reporting two memory-safety defects found by source audit of the
development branch (HEAD a53fd23, =3D=3D origin/main at time of writing). O=
ne is
reproducible with an AddressSanitizer PoC; the other is source-verified. Fi=
xes
for both are included inline below and attached as patches.

Credit: please credit me as "Borys Tsyrulnikov".
Embargo: No specific embargo requested from my side; please coordinate
according
to the DPDK process if the issues qualify. I will not disclose publicly (Po=
C or
details) until you advise.


=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Issue 1 =E2=80=94 lib/net: out-of-bounds read in GTP packet-type parsing
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Severity: medium (remote DoS on hosts running the software ptype parser on
untrusted traffic). REPRODUCIBLE =E2=80=94 AddressSanitizer PoC attached.

Location: lib/net/rte_net.c:235, function ptype_tunnel_with_udp(), GTP case.

Description:
The GTP case reads the inner IP-version byte at offset gtp_len (8, or 12 wh=
en
the E/S/PN flags are set) from the GTP header:

    gh =3D rte_pktmbuf_read(m, *off, sizeof(*gh), &gh_copy);  /*
validates 8 bytes */
    ...
    if (gh->msg_type =3D=3D 0xff)
        ip_ver =3D *(const uint8_t *)((const char *)gh + gtp_len);  /*
reads byte 8 or 12 */

rte_pktmbuf_read() only guarantees sizeof(struct rte_gtp_hdr) =3D=3D 8 byte=
s. The
read at gh[gtp_len] is past that, with no further bounds check. When the 8 =
GTP
bytes are not contiguous in the first mbuf segment, rte_pktmbuf_read() retu=
rns
the 8-byte on-stack copy gh_copy, so gh[gtp_len] is an out-of-bounds read p=
ast
that stack object.

Reachability / attacker model:
rte_net_get_ptype(m, &lens, RTE_PTYPE_ALL_MASK) runs on received,
attacker-controlled packets =E2=80=94 notably lib/vhost/virtio_net.c:2800 (=
the host
parsing packets from a guest VM), plus virtio/vhost/tap/netvsc RX. A malici=
ous
guest can craft a GTP packet with E/S/PN set and split across mbuf segments=
 to
force the stack-copy path and trigger the over-read.

Reproduction (attached poc_gtp_oob.c + asan_crash.sanitized.txt, against an
ASan
DPDK build):
    READ of size 1 ... ptype_tunnel_with_udp ../lib/net/rte_net.c:235
    [64, 72) 'gh_copy' <=3D=3D access at offset 76 overflows this variable

Fix (attached patch-02-net-gtp-ptype.patch):
Read the version byte through the bounds-checked accessor and treat a short
packet as unknown inner protocol:

    + const uint8_t *ver;
    ...
    - ip_ver =3D *(const uint8_t *)((const char *)gh + gtp_len);
    - ip_ver =3D (ip_ver) & 0xf0;
    + ver =3D rte_pktmbuf_read(m, *off + gtp_len, sizeof(ip_ver), &ip_ver);
    + ip_ver =3D (ver =3D=3D NULL) ? 0 : (*ver & 0xf0);

Patch commit-message tags (for the eventual fix; NOT recipients of this ema=
il):
  Fixes: 64ed7f854cf4 ("net: add tunnel packet type parsing")  [in v25.03+]
  Cc: stable@dpdk.org ; regression author Jie Hai <haijie1@huawei.com>

--=20
You are receiving this mail because:
You are the assignee for the bug.=
