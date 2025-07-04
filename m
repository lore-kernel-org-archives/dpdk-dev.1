Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AAD4C83F03
	for <dpdk-dev@archiver.kernel.org>; Fri,  4 Jul 2025 15:30:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 525C74060B;
	Fri,  4 Jul 2025 17:30:33 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id 0CF0E402F2
 for <dev@dpdk.org>; Fri,  4 Jul 2025 17:30:31 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 52307152B;
 Fri,  4 Jul 2025 08:30:17 -0700 (PDT)
Received: from localhost.localdomain (JR4XG4HTQC-2.cambridge.arm.com
 [10.1.30.57])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8F5BD3F66E;
 Fri,  4 Jul 2025 08:30:30 -0700 (PDT)
From: Luca Vizzarro <luca.vizzarro@arm.com>
To: dev@dpdk.org
Cc: Luca Vizzarro <luca.vizzarro@arm.com>, Patrick Robb <probb@iol.unh.edu>,
 Paul Szczepanek <paul.szczepanek@arm.com>
Subject: [PATCH v2 0/2] dts: add generic blocking app class
Date: Fri,  4 Jul 2025 16:29:06 +0100
Message-ID: <20250704152908.683265-1-luca.vizzarro@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250702164204.607685-1-luca.vizzarro@arm.com>
References: <20250702164204.607685-1-luca.vizzarro@arm.com>
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

Hi again,

sending v2.

v2:
- removing the build dpdk example app as not needed.

Luca Vizzarro (2):
  dts: remove dpdk example build function
  dts: add generic blocking app class

 dts/framework/remote_session/blocking_app.py | 135 +++++++++++++++++++
 dts/framework/remote_session/dpdk.py         |  33 +----
 dts/framework/remote_session/dpdk_app.py     |  80 -----------
 dts/tests/TestSuite_packet_capture.py        |  66 +++------
 4 files changed, 157 insertions(+), 157 deletions(-)
 create mode 100644 dts/framework/remote_session/blocking_app.py
 delete mode 100644 dts/framework/remote_session/dpdk_app.py

-- 
2.43.0

