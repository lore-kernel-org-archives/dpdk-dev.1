Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8EF1C0218F
	for <dpdk-dev@archiver.kernel.org>; Fri, 31 Jan 2025 19:19:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6B24F4025A;
	Fri, 31 Jan 2025 20:19:36 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id E6948400D7
 for <dev@dpdk.org>; Fri, 31 Jan 2025 20:19:34 +0100 (CET)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 713D5497;
 Fri, 31 Jan 2025 11:19:59 -0800 (PST)
Received: from localhost.localdomain (unknown [10.57.75.129])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 08D353F694;
 Fri, 31 Jan 2025 11:19:32 -0800 (PST)
From: Luca Vizzarro <luca.vizzarro@arm.com>
To: dev@dpdk.org
Cc: Thomas Monjalon <thomas@monjalon.net>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Jerin Jacob <jerinj@marvell.com>, Akhil Goyal <gakhil@marvell.com>,
 Luca Vizzarro <luca.vizzarro@arm.com>, Patrick Robb <probb@iol.unh.edu>,
 Paul Szczepanek <paul.szczepanek@arm.com>
Subject: [PATCH 0/3] dts: fix doc issues
Date: Fri, 31 Jan 2025 19:19:21 +0000
Message-ID: <20250131191924.1936157-1-luca.vizzarro@arm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Hi everyone,

The first patch will finally get rid of any warnings in the doc build.
Whereas the other two patches are required to build docs or even run DTS
in Python 3.12 and 3.13. 

Python 3.13 has introduced a new breaking change without warning, which
broke the way we used a specific stdlib function.

Finally, we were relying on an older version of our SSH client library
fabric which backwards-compatibility was dropped in Python 3.12, raising
further problems while building docs.

Best,
Luca

Luca Vizzarro (3):
  dts: remove use of field validators
  dts: stop using partial in enums
  dts: bump up fabric version

 doc/guides/conf.py                            |   9 +-
 dts/framework/config/__init__.py              |  18 +-
 dts/framework/remote_session/__init__.py      |   2 +-
 .../interactive_remote_session.py             |   2 +-
 .../remote_session/remote_session.py          |   2 +-
 dts/framework/remote_session/testpmd_shell.py | 145 +++++++--------
 dts/framework/testbed_model/capability.py     |   6 +-
 dts/poetry.lock                               | 165 ++++++++++++++----
 dts/pyproject.toml                            |   2 +-
 9 files changed, 219 insertions(+), 132 deletions(-)

-- 
2.43.0

