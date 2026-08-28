Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72E94C61DCB
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Aug 2026 17:31:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 920F04025A;
	Fri, 28 Aug 2026 19:31:40 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 2A7EF40151
 for <dev@dpdk.org>; Fri, 28 Aug 2026 19:31:39 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 104084CF0F; Fri, 28 Aug 2026 19:31:39 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/ethdev Bug 2011] memif: incorrect control message validation
Date: Fri, 28 Aug 2026 17:31:39 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: ethdev
X-Bugzilla-Version: 26.11
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
 target_milestone bug_group
Message-ID: <bug-2011-3@https.bugs.dpdk.org/>
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

https://bugs.dpdk.org/show_bug.cgi?id=3D2011

            Bug ID: 2011
           Summary: memif: incorrect control message validation
           Product: DPDK
           Version: 26.11
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: major
          Priority: Normal
         Component: ethdev
          Assignee: dev@dpdk.org
          Reporter: stephen@networkplumber.org
  Target Milestone: ---
             Group: security

Long winded AI analysis

memif_msg_receive() in drivers/net/memif/memif_socket.c dispatches on
msg.type without checking that the message is legal for the receiving
device's role. Every message type is accepted from either direction.

MEMIF_MSG_TYPE_HELLO is a server-to-client message, but a connected
client can send one to a server. memif_msg_receive_hello() then sets
pmd->run.num_c2s_rings, pmd->run.num_s2c_rings and
pmd->run.log2_ring_size from values the peer supplied, and the
dispatcher goes on to run memif_init_regions_and_queues(), which is the
client-side initialisation path, on a server device. That path then
enqueues an ADD_REGION message for each entry in
proc_private->regions_num, meaning the server offers its own region file
descriptors to the untrusted peer.

Two consequences:

  1. A server can be driven into client-side state and can be made to
     hand its own shared memory file descriptors to the peer that
     connected to it. That inverts the trust direction the protocol
     depends on: the client is supposed to be the side that shares
     memory, and the server the side that receives it.

  2. Any server-side validation that reads pmd->run.* or
     proc_private->regions_num can be primed by the client with a
     spoofed HELLO before the messages being validated are sent. This
     matters for the ADD_REGION and ADD_RING validation filed
     separately: those checks are only sound once the state they read
     cannot be set by the peer.

Suggested fix
-------------

Reject messages sent in the wrong direction at dispatch, before any
handler runs:

  server to client only:  ACK, HELLO, CONNECTED
  client to server only:  INIT, ADD_REGION, ADD_RING, CONNECT
  both directions:        DISCONNECT

A wrong-direction message should disconnect the peer, since a conforming
implementation never sends one.

No fix has been written for this yet. It should land before, or in the
same series as, the ADD_REGION and ADD_RING validation, since those
checks read state this bug lets the peer set.

Reported by Arthur Chan <arthur.chan@adalogics.com> (Ada Logics), via
fuzzing.

--=20
You are receiving this mail because:
You are the assignee for the bug.=
