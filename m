Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5066DF36BA0
	for <dpdk-dev@archiver.kernel.org>; Fri, 10 Apr 2026 02:36:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5C56A4064F;
	Fri, 10 Apr 2026 04:36:36 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id D2D4F402D3
 for <dev@dpdk.org>; Fri, 10 Apr 2026 04:36:34 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id C498E4AE72; Fri, 10 Apr 2026 04:36:34 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/ethdev Bug 1934] Pollara 400 AI NIC does not have code for 400G
Date: Fri, 10 Apr 2026 02:36:34 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: ethdev
X-Bugzilla-Version: 26.03
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: critical
X-Bugzilla-Who: vipin.varghese@amd.com
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone
Message-ID: <bug-1934-3@http.bugs.dpdk.org/>
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

http://bugs.dpdk.org/show_bug.cgi?id=3D1934

            Bug ID: 1934
           Summary: Pollara 400 AI NIC does not have code for 400G
           Product: DPDK
           Version: 26.03
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: critical
          Priority: Normal
         Component: ethdev
          Assignee: dev@dpdk.org
          Reporter: vipin.varghese@amd.com
  Target Milestone: ---

DPDK version: 26.03
PMD: driver/net/ionic

problem: as per dpdk patch
https://patchwork.dpdk.org/project/dpdk/patch/20251120183936.8699-1-andrew.=
boyer@amd.com/
Pollaro 400G is supported

code base:

 - file: ionic_if.h
```
/**
 * enum ionic_xcvr_pid - Supported link modes
 */
enum ionic_xcvr_pid {
        IONIC_XCVR_PID_UNKNOWN           =3D 0,

        /* CU */
        IONIC_XCVR_PID_QSFP_100G_CR4     =3D 1,
        IONIC_XCVR_PID_QSFP_40GBASE_CR4  =3D 2,
        IONIC_XCVR_PID_SFP_25GBASE_CR_S  =3D 3,
        IONIC_XCVR_PID_SFP_25GBASE_CR_L  =3D 4,
        IONIC_XCVR_PID_SFP_25GBASE_CR_N  =3D 5,

        /* Fiber */
        IONIC_XCVR_PID_QSFP_100G_AOC    =3D 50,
        IONIC_XCVR_PID_QSFP_100G_ACC    =3D 51,
        IONIC_XCVR_PID_QSFP_100G_SR4    =3D 52,
        IONIC_XCVR_PID_QSFP_100G_LR4    =3D 53,
        IONIC_XCVR_PID_QSFP_100G_ER4    =3D 54,
        IONIC_XCVR_PID_QSFP_40GBASE_ER4 =3D 55,
        IONIC_XCVR_PID_QSFP_40GBASE_SR4 =3D 56,
        IONIC_XCVR_PID_QSFP_40GBASE_LR4 =3D 57,
        IONIC_XCVR_PID_QSFP_40GBASE_AOC =3D 58,
        IONIC_XCVR_PID_SFP_25GBASE_SR   =3D 59,
        IONIC_XCVR_PID_SFP_25GBASE_LR   =3D 60,
        IONIC_XCVR_PID_SFP_25GBASE_ER   =3D 61,
        IONIC_XCVR_PID_SFP_25GBASE_AOC  =3D 62,
        IONIC_XCVR_PID_SFP_10GBASE_SR   =3D 63,
        IONIC_XCVR_PID_SFP_10GBASE_LR   =3D 64,
        IONIC_XCVR_PID_SFP_10GBASE_LRM  =3D 65,
        IONIC_XCVR_PID_SFP_10GBASE_ER   =3D 66,
        IONIC_XCVR_PID_SFP_10GBASE_AOC  =3D 67,
        IONIC_XCVR_PID_SFP_10GBASE_CU   =3D 68,
        IONIC_XCVR_PID_QSFP_100G_CWDM4  =3D 69,
        IONIC_XCVR_PID_QSFP_100G_PSM4   =3D 70,
        IONIC_XCVR_PID_SFP_25GBASE_ACC  =3D 71,
};
```

 - file: ionic_ethdev.c
```
dev_info->speed_capa =3D
                RTE_ETH_LINK_SPEED_10G |
                RTE_ETH_LINK_SPEED_25G |
                RTE_ETH_LINK_SPEED_40G |
                RTE_ETH_LINK_SPEED_50G |
                RTE_ETH_LINK_SPEED_100G;

        } else {
                /* Interface is up */
                link.link_status =3D RTE_ETH_LINK_UP;
                link.link_duplex =3D RTE_ETH_LINK_FULL_DUPLEX;
                switch (adapter->link_speed) {
                case  1000:
                        link.link_speed =3D RTE_ETH_SPEED_NUM_1G;
                        break;
                case  10000:
                        link.link_speed =3D RTE_ETH_SPEED_NUM_10G;
                        break;
                case  25000:
                        link.link_speed =3D RTE_ETH_SPEED_NUM_25G;
                        break;
                case  40000:
                        link.link_speed =3D RTE_ETH_SPEED_NUM_40G;
                        break;
                case  50000:
                        link.link_speed =3D RTE_ETH_SPEED_NUM_50G;
                        break;
                case 100000:
                        link.link_speed =3D RTE_ETH_SPEED_NUM_100G;
                        break;
                case 200000:
                        link.link_speed =3D RTE_ETH_SPEED_NUM_200G;
                        break;
                default:
                        link.link_speed =3D RTE_ETH_SPEED_NUM_NONE;
                        break;
                }
        }

        dev_info->speed_capa =3D
                RTE_ETH_LINK_SPEED_10G |
                RTE_ETH_LINK_SPEED_25G |
                RTE_ETH_LINK_SPEED_40G |
                RTE_ETH_LINK_SPEED_50G |
                RTE_ETH_LINK_SPEED_100G;

static inline uint32_t
ionic_parse_link_speeds(uint16_t link_speeds)
{
        if (link_speeds & RTE_ETH_LINK_SPEED_100G)
                return 100000;
        else if (link_speeds & RTE_ETH_LINK_SPEED_50G)
                return 50000;
        else if (link_speeds & RTE_ETH_LINK_SPEED_40G)
                return 40000;
        else if (link_speeds & RTE_ETH_LINK_SPEED_25G)
                return 25000;
        else if (link_speeds & RTE_ETH_LINK_SPEED_10G)
                return 10000;
        else
                return 0;
}
```

--=20
You are receiving this mail because:
You are the assignee for the bug.=
