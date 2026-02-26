Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 187C5FD461A
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Feb 2026 04:35:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5458B4026F;
	Thu, 26 Feb 2026 05:35:55 +0100 (CET)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id CE4C04021F
 for <dev@dpdk.org>; Thu, 26 Feb 2026 05:35:54 +0100 (CET)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id AF36F4A90B; Thu, 26 Feb 2026 05:35:54 +0100 (CET)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/other Bug 1897] iavf_execute_vf_cmd(): Return failure -22 for
 cmd 11
Date: Thu, 26 Feb 2026 04:35:54 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: other
X-Bugzilla-Version: unspecified
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: albe19021990@gmail.com
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone
Message-ID: <bug-1897-3@http.bugs.dpdk.org/>
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

http://bugs.dpdk.org/show_bug.cgi?id=3D1897

            Bug ID: 1897
           Summary: iavf_execute_vf_cmd(): Return failure -22 for cmd 11
           Product: DPDK
           Version: unspecified
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: other
          Assignee: dev@dpdk.org
          Reporter: albe19021990@gmail.com
  Target Milestone: ---

Good day. Every time I am trying to set rte_eth_dev_default_mac_addr_set on=
 my
VF I get next error message in logs:

iavf_execute_vf_cmd(): Return failure -22 for cmd 11
iavf_add_del_eth_addr(): fail to execute command OP_DEL_ETH_ADDR
iavf_dev_set_default_mac_addr(): Fail to delete old MAC:{}

On dpdk initialization step if there are no MAC on interface - new MAC
generated and assigned

https://github.com/DPDK/dpdk/blob/main/drivers/net/intel/iavf/iavf_ethdev.c=
#L2851

But real asignment is made in iavf_dev_start by sending
VIRTCHNL_ETHER_ADDR_PRIMARY request to linux kernel.

https://github.com/DPDK/dpdk/blob/main/drivers/net/intel/iavf/iavf_ethdev.c=
#L1069
https://github.com/DPDK/dpdk/blob/main/drivers/net/intel/iavf/iavf_vchnl.c#=
L1426

But if we change MAC with iavf_dev_set_default_mac_addr it removes old MAC,=
 and
assing new MAC. As iavf_dev_start was not called yet we try to remove non
asigned VIRTCHNL_ETHER_ADDR_PRIMARY MAC. linux kernel checks this and return
-EINVAL.

If we call rte_eth_dev_default_mac_addr_set second time with other MAC - th=
ere
will be no stderr, as there are MAC in linux kernel and delete primary MAC
operation will now be executed without -EINVAL.

This is not a critical issue, but this stderr confusing. As
rte_eth_dev_default_mac_addr_set return success, but logs say about error.

--=20
You are receiving this mail because:
You are the assignee for the bug.=
