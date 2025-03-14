Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1CA5C282EC
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Mar 2025 13:19:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BC11E4029E;
	Fri, 14 Mar 2025 14:19:21 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id BCA6A400D5
 for <dev@dpdk.org>; Fri, 14 Mar 2025 14:19:19 +0100 (CET)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E1BE41424;
 Fri, 14 Mar 2025 06:19:28 -0700 (PDT)
Received: from localhost.localdomain (unknown [10.57.40.184])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2C7E03F673;
 Fri, 14 Mar 2025 06:19:18 -0700 (PDT)
From: Luca Vizzarro <luca.vizzarro@arm.com>
To: dev@dpdk.org
Cc: Luca Vizzarro <luca.vizzarro@arm.com>, Patrick Robb <probb@iol.unh.edu>,
 Paul Szczepanek <paul.szczepanek@arm.com>
Subject: [PATCH v2 0/7] dts: shell improvements
Date: Fri, 14 Mar 2025 15:18:50 +0200
Message-ID: <20250314131857.1298247-1-luca.vizzarro@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241220172337.2194523-1-luca.vizzarro@arm.com>
References: <20241220172337.2194523-1-luca.vizzarro@arm.com>
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

Hi there,

sending in a v2, which should also remove the RFC status from v1, as I
believe these changes are now ready as they are.

v2:
- rebased
- added further improvements
- reworked shell registration based on the recent framework
  improvements, e.g. context
- removed multi inheritance to simplify
- added a new pseudo-shell to handle blocking applications

Best,
Luca

Luca Vizzarro (7):
  dts: escape single quotes
  dts: add blocking dpdk app class
  dts: add shells pool
  dts: revert back to a single InteractiveShell
  dts: make shells path dynamic
  dts: remove multi-inheritance classes
  dts: enable shell pooling

 doc/api/dts/framework.remote_session.rst      |   1 +
 .../framework.remote_session.shell_pool.rst   |   8 +
 dts/framework/context.py                      |   2 +
 dts/framework/remote_session/dpdk_app.py      |  80 +++++
 dts/framework/remote_session/dpdk_shell.py    |  21 +-
 .../remote_session/interactive_shell.py       | 302 ++++++++++++++++--
 dts/framework/remote_session/python_shell.py  |  13 +-
 dts/framework/remote_session/shell_pool.py    | 106 ++++++
 .../single_active_interactive_shell.py        | 269 ----------------
 dts/framework/remote_session/testpmd_shell.py |  16 +-
 dts/framework/test_run.py                     |   5 +
 dts/framework/testbed_model/linux_session.py  |   1 +
 .../testbed_model/traffic_generator/scapy.py  |  38 ++-
 .../traffic_generator/traffic_generator.py    |   6 +-
 dts/framework/utils.py                        |  14 -
 15 files changed, 531 insertions(+), 351 deletions(-)
 create mode 100644 doc/api/dts/framework.remote_session.shell_pool.rst
 create mode 100644 dts/framework/remote_session/dpdk_app.py
 create mode 100644 dts/framework/remote_session/shell_pool.py
 delete mode 100644 dts/framework/remote_session/single_active_interactive_shell.py

-- 
2.43.0

