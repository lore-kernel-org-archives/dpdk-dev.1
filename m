Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD1D3C88E63
	for <dpdk-dev@archiver.kernel.org>; Sun, 13 Sep 2026 17:35:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C8D9B4027A;
	Sun, 13 Sep 2026 19:35:53 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id E9AB54026E
 for <dev@dpdk.org>; Sun, 13 Sep 2026 19:35:51 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id E37224D0EB; Sun, 13 Sep 2026 19:35:51 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/ethdev Bug 2037] net/intel/ice: parse_bool clobbers adjacent
 devargs fields
Date: Sun, 13 Sep 2026 17:35:52 +0000
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
 target_milestone
Message-ID: <bug-2037-3@https.bugs.dpdk.org/>
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

https://bugs.dpdk.org/show_bug.cgi?id=3D2037

            Bug ID: 2037
           Summary: net/intel/ice: parse_bool clobbers adjacent devargs
                    fields
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

drivers/net/intel/ice/ice_ethdev.c:2144, ice_ethdev.h:624

parse_bool() stores an int:

        static int
        parse_bool(const char *key, const char *value, void *args)
        {
                int *i =3D args;
                ...
                *i =3D (value[0] =3D=3D '1');

Three of its five callers pass the address of a uint8_t in struct
ice_devargs:

        struct ice_devargs {
                int rx_low_latency;
                int safe_mode_support;
                uint8_t proto_xtr_dflt;
                uint8_t default_mac_disable;    <- 4 byte store
                uint8_t proto_xtr[ICE_MAX_QUEUE_NUM];
                uint8_t pin_idx;
                uint8_t pps_out_ena;
                uint8_t ddp_load_sched;         <- 4 byte store
                uint8_t tm_exposed_levels;
                uint8_t source_prune;           <- 4 byte store
                uint32_t rl_burst_size;
                ...

"default-mac-disable" is the notable one: the three bytes past it land in
proto_xtr[], which ice_parse_devargs() has just memset to PROTO_XTR_NONE a
few lines earlier, so the protocol extraction configuration is silently
altered. ddp_load_sched overruns into tm_exposed_levels/source_prune, and
source_prune into rl_burst_size.

Fixes: 66214b547c65 ("net/ice: add option to disable default MAC")

--=20
You are receiving this mail because:
You are the assignee for the bug.=
