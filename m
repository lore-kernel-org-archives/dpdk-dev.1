Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C325CC83F04
	for <dpdk-dev@archiver.kernel.org>; Wed,  2 Jul 2025 16:43:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 076B74064C;
	Wed,  2 Jul 2025 18:43:30 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id 6A9EA4028E
 for <dev@dpdk.org>; Wed,  2 Jul 2025 18:43:28 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DBC3322C7;
 Wed,  2 Jul 2025 09:43:12 -0700 (PDT)
Received: from localhost.localdomain (JR4XG4HTQC-2.cambridge.arm.com
 [10.1.35.68])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id ED0223F66E;
 Wed,  2 Jul 2025 09:43:26 -0700 (PDT)
From: Luca Vizzarro <luca.vizzarro@arm.com>
To: dev@dpdk.org
Cc: Luca Vizzarro <luca.vizzarro@arm.com>, Patrick Robb <probb@iol.unh.edu>,
 Paul Szczepanek <paul.szczepanek@arm.com>
Subject: [PATCH 0/2] dts: add generic blocking app class
Date: Wed,  2 Jul 2025 17:42:02 +0100
Message-ID: <20250702164204.607685-1-luca.vizzarro@arm.com>
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

Hello,

sending in some minor improvements that unlocks the possibility of
running any app in the background.

Best,
Luca

Luca Vizzarro (2):
  dts: add DPDK build app helper function
  dts: add generic blocking app class

 dts/framework/remote_session/blocking_app.py | 135 +++++++++++++++++++
 dts/framework/remote_session/dpdk.py         |   8 +-
 dts/framework/remote_session/dpdk_app.py     |  80 -----------
 dts/tests/TestSuite_packet_capture.py        |  66 +++------
 4 files changed, 160 insertions(+), 129 deletions(-)
 create mode 100644 dts/framework/remote_session/blocking_app.py
 delete mode 100644 dts/framework/remote_session/dpdk_app.py

-- 
2.43.0

