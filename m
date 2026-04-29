Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A299BCCFA13
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Apr 2026 19:02:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E6FCA40655;
	Wed, 29 Apr 2026 21:02:08 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id C57BC402AC
 for <dev@dpdk.org>; Wed, 29 Apr 2026 21:02:07 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id B803F4B0F0; Wed, 29 Apr 2026 21:02:07 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: =?UTF-8?B?W0RQREsvZXRoZGV2IEJ1ZyAxOTQwXSBbbmV0L2ljZV0gRTgxMCBQ?=
 =?UTF-8?B?RiBQYXNzdGhyb3VnaDogSW50ZXJtaXR0ZW50IExpbmsgQnJpbmfigJFVcCBG?=
 =?UTF-8?B?YWlsdXJlIEFmdGVyIFJlYm9vdCAoRFBESyAyNC4xMS4xKQ==?=
Date: Wed, 29 Apr 2026 19:02:07 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: ethdev
X-Bugzilla-Version: 24.11
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: major
X-Bugzilla-Who: gownivalla.susmitha@wipro.com
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone
Message-ID: <bug-1940-3@http.bugs.dpdk.org/>
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

http://bugs.dpdk.org/show_bug.cgi?id=3D1940

            Bug ID: 1940
           Summary: [net/ice] E810 PF Passthrough: Intermittent Link
                    Bring=E2=80=91Up Failure After Reboot (DPDK 24.11.1)
           Product: DPDK
           Version: 24.11
          Hardware: x86
                OS: Linux
            Status: UNCONFIRMED
          Severity: major
          Priority: Normal
         Component: ethdev
          Assignee: dev@dpdk.org
          Reporter: gownivalla.susmitha@wipro.com
  Target Milestone: ---

Hello DPDK Community,

We are facing an intermittent physical link bring=E2=80=91up failure with I=
ntel E810 PF
passthrough to a VM using DPDK 24.11.1. The failure occurs after reboot.

NIC: Intel E810 (Dell OEM, dual=E2=80=91port)
NVM: 4.20
Host ICE driver: 1.11.14
Guest ICE driver (base): 1.6.4
DPDK: 24.11.1
Mode: PF passthrough
Environment: Openstack

After a VM reboot, port availability is inconsistent; occasionally both por=
ts
come up, but often only one or neither initializes.

We would appreciate input on:

1. Any known ICE PMD issues with E810 in PF passthrough scenarios.
3. Known firmware dependencies or minimum NVM levels required for stable PF=
PT
operation.
4. Any potential software-level workarounds to mitigate compatibility issues
without changing the underlying firmware/driver?
5. Any upstream discussions or patches related to E810 reset/timing issues?

Thanks in advance.

Regards,
Susmitha

--=20
You are receiving this mail because:
You are the assignee for the bug.=
