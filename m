Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431CA60A2605
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Nov 2026 17:47:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2668E40281;
	Tue, 10 Nov 2026 18:47:10 +0100 (CET)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTPS id 03C564026C
 for <dev@dpdk.org>; Tue, 10 Nov 2026 18:47:09 +0100 (CET)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id C97494D194; Tue, 10 Nov 2026 18:47:08 +0100 (CET)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/ethdev Bug 1442] uninitalized warning when ASAN enabled in
 hns3 PMD
Date: Tue, 10 Nov 2026 17:47:08 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: ethdev
X-Bugzilla-Version: 24.03
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: stephen@networkplumber.org
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: FIXED
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: resolution bug_status
Message-ID: <bug-1442-3-ZGUG1gh2KA@https.bugs.dpdk.org/>
In-Reply-To: <bug-1442-3@https.bugs.dpdk.org/>
References: <bug-1442-3@https.bugs.dpdk.org/>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
X-Bugzilla-URL: https://bugs.dpdk.org/
Auto-Submitted: auto-generated
X-Auto-Response-Suppress: All
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

https://bugs.dpdk.org/show_bug.cgi?id=3D1442

Stephen Hemminger (stephen@networkplumber.org) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
         Resolution|---                         |FIXED
             Status|UNCONFIRMED                 |RESOLVED

--- Comment #1 from Stephen Hemminger (stephen@networkplumber.org) ---
commit 7dfc8e69aa4286854a0ac893d3828eaffee20347
Author: Jie Hai <haijie1@huawei.com>
Date:   Tue Jul 23 14:09:00 2024 +0800

    net/hns3: fix uninitialized variable in FEC query

    This patch fixes uninitialized auto_state value when
    querying FEC mode of device.

    Bugzilla ID: 1498
    Fixes: 9bf2ea8dbc65 ("net/hns3: support FEC")
    Cc: stable@dpdk.org

    Signed-off-by: Jie Hai <haijie1@huawei.com>
    Acked-by: Huisong Li <lihuisong@huawei.com>
    Acked-by: Chengwen Feng <fengchengwen@huawei.com>

--=20
You are receiving this mail because:
You are the assignee for the bug.=
