Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43764D116F3
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Dec 2025 17:24:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 183B04021F;
	Mon,  1 Dec 2025 18:24:48 +0100 (CET)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 953014013F
 for <dev@dpdk.org>; Mon,  1 Dec 2025 18:24:46 +0100 (CET)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 665F348BFD; Mon,  1 Dec 2025 18:24:46 +0100 (CET)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/core Bug 1847] Tests should be in a test suite
Date: Mon, 01 Dec 2025 17:24:46 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: core
X-Bugzilla-Version: 25.11
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: minor
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
Message-ID: <bug-1847-3@http.bugs.dpdk.org/>
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

http://bugs.dpdk.org/show_bug.cgi?id=3D1847

            Bug ID: 1847
           Summary: Tests should be in a test suite
           Product: DPDK
           Version: 25.11
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: minor
          Priority: Normal
         Component: core
          Assignee: dev@dpdk.org
          Reporter: stephen@networkplumber.org
  Target Milestone: ---

Builds generate warning from tests not in test suites.
I think many of these could/should be in the fast test suite.
Others maybe in another suite (maybe eventdev-suite??)

app/test/suites/meson.build:42: WARNING: Test "cryptodev_crosscheck" is not
defined in any test suite
app/test/suites/meson.build:42: WARNING: Test "ethdev_api" is not defined in
any test suite
app/test/suites/meson.build:42: WARNING: Test "event_crypto_adapter_autotes=
t"
is not defined in any test suite
app/test/suites/meson.build:42: WARNING: Test "event_eth_rx_adapter_autotes=
t"
is not defined in any test suite
app/test/suites/meson.build:42: WARNING: Test
"event_eth_rx_intr_adapter_autotest" is not defined in any test suite
app/test/suites/meson.build:42: WARNING: Test "event_timer_adapter_test" is=
 not
defined in any test suite
app/test/suites/meson.build:42: WARNING: Test "external_mem_autotest" is not
defined in any test suite
app/test/suites/meson.build:42: WARNING: Test "ipsec_sad_autotest" is not
defined in any test suite
app/test/suites/meson.build:42: WARNING: Test "power_caps_autotest" is not
defined in any test suite
app/test/suites/meson.build:42: WARNING: Test "red_autotest" is not defined=
 in
any test suite
app/test/suites/meson.build:42: WARNING: Test "inline_macsec_autotest" is n=
ot
defined in any test suite
app/test/suites/meson.build:42: WARNING: Test "inline_ipsec_autotest" is not
defined in any test suite
app/test/suites/meson.build:42: WARNING: Test "inline_ipsec_sg_autotest" is=
 not
defined in any test suite
app/test/suites/meson.build:42: WARNING: Test "event_inline_ipsec_autotest"=
 is
not defined in any test suite
app/test/suites/meson.build:42: WARNING: Test "timer_secondary_autotest" is=
 not
defined in any test suite

--=20
You are receiving this mail because:
You are the assignee for the bug.=
