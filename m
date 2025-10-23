Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78AC2CCD193
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Oct 2025 23:45:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C014140151;
	Fri, 24 Oct 2025 01:45:32 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 0C7B740144
 for <dev@dpdk.org>; Fri, 24 Oct 2025 01:45:31 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 0147D489BE; Fri, 24 Oct 2025 01:45:30 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/ethdev Bug 1809] net/intel: possible misuse of comma operator
Date: Thu, 23 Oct 2025 23:45:31 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: ethdev
X-Bugzilla-Version: 20.11
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
Message-ID: <bug-1809-3@http.bugs.dpdk.org/>
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

http://bugs.dpdk.org/show_bug.cgi?id=3D1809

            Bug ID: 1809
           Summary: net/intel: possible misuse of comma operator
           Product: DPDK
           Version: 20.11
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: ethdev
          Assignee: dev@dpdk.org
          Reporter: stephen@networkplumber.org
  Target Milestone: ---

If DPDK is built with clang and -Wcomma is enabled for drivers then:

[1127/3622] Compiling C object
drivers/libtmp_rte_net_ice.a.p/net_intel_ice_ice_ethdev.c.o
../drivers/net/intel/ice/ice_ethdev.c:945:52: warning: possible misuse of c=
omma
operator here [-Wcomma]
  945 |              entry && (next_entry =3D LIST_NEXT(entry, next), 1);
      |                                                           ^
../drivers/net/intel/ice/ice_ethdev.c:945:17: note: cast expression to void=
 to
silence warning
  945 |              entry && (next_entry =3D LIST_NEXT(entry, next), 1);
      |                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      |                        (void)(                            )
../drivers/net/intel/ice/ice_ethdev.c:952:52: warning: possible misuse of c=
omma
operator here [-Wcomma]
  952 |              entry && (next_entry =3D LIST_NEXT(entry, next), 1);
      |                                                           ^
../drivers/net/intel/ice/ice_ethdev.c:952:17: note: cast expression to void=
 to
silence warning
  952 |              entry && (next_entry =3D LIST_NEXT(entry, next), 1);
      |                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      |                        (void)(                            )
2 warnings generated.
[1150/3622] Compiling C object
drivers/libtmp_rte_net_i40e.a.p/net_intel_i40e_i40e_ethdev.c.o
../drivers/net/intel/i40e/i40e_ethdev.c:5102:49: warning: possible misuse of
comma operator here [-Wcomma]
 5102 |                         entry && (next_entry =3D LIST_NEXT(entry, n=
ext),
1);
      |                                                                    =
  ^
../drivers/net/intel/i40e/i40e_ethdev.c:5102:14: note: cast expression to v=
oid
to silence warning
 5102 |                         entry && (next_entry =3D LIST_NEXT(entry, n=
ext),
1);
      |                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~
      |                                   (void)(                          =
  )
../drivers/net/intel/i40e/i40e_ethdev.c:5109:49: warning: possible misuse of
comma operator here [-Wcomma]
 5109 |                         entry && (next_entry =3D LIST_NEXT(entry, n=
ext),
1);
      |                                                                    =
  ^
../drivers/net/intel/i40e/i40e_ethdev.c:5109:14: note: cast expression to v=
oid
to silence warning
 5109 |                         entry && (next_entry =3D LIST_NEXT(entry, n=
ext),
1);
      |                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~
      |                                   (void)(                          =
  )
2 warnings generated.


Suggest looking at how LIST_NEXT could be changed to not generate warnings,=
 not
seen elsewhere.

--=20
You are receiving this mail because:
You are the assignee for the bug.=
