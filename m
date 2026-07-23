Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAA73C531F7
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Jul 2026 16:56:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8B21740663;
	Thu, 23 Jul 2026 18:56:48 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 2EBB340280
 for <dev@dpdk.org>; Thu, 23 Jul 2026 18:56:47 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id E40B24B931; Thu, 23 Jul 2026 18:56:46 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/ethdev Bug 1973] net/af_xdp: default dp_path uses /tmp
Date: Thu, 23 Jul 2026 16:56:45 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: ethdev
X-Bugzilla-Version: 26.07
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
Message-ID: <bug-1973-3@http.bugs.dpdk.org/>
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

http://bugs.dpdk.org/show_bug.cgi?id=3D1973

            Bug ID: 1973
           Summary: net/af_xdp: default dp_path uses /tmp
           Product: DPDK
           Version: 26.07
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: ethdev
          Assignee: dev@dpdk.org
          Reporter: stephen@networkplumber.org
  Target Milestone: ---

When use_cni=3D1 or use_pinned_map=3D1 is set without an explicit dp_path, =
the PMD
defaults the UDS / pinned-map path under /tmp/afxdp_dp/<if_name>/...
(DP_BASE_PATH in drivers/net/af_xdp/rte_eth_af_xdp.c).

Two related problems:

/tmp does not match current Linux file-hierarchy conventions for runtime
sockets. These belong under the runtime directory (/run, e.g.
rte_eal_get_runtime_dir()), not world-writable /tmp.

The AF_XDP Device Plugin for Kubernetes integration assumes /tmp: the plugin
creates and mounts the socket, and the PMD default hardcodes the same /tmp =
path
to match it. The location is effectively a contract duplicated in both
projects.
Note: the <if_name> component must be kept in any fix =E2=80=94 it disambig=
uates
multiple UDS servers in one pod (added by the "fix multi interface support =
for
K8s" series).

--=20
You are receiving this mail because:
You are the assignee for the bug.=
