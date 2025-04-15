Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B31F9C369AB
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Apr 2025 13:09:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B8F44402A1;
	Tue, 15 Apr 2025 15:09:16 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id EBB3E40289
 for <dev@dpdk.org>; Tue, 15 Apr 2025 15:09:14 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 438A415A1;
 Tue, 15 Apr 2025 06:09:12 -0700 (PDT)
Received: from e132991.cambridge.arm.com (e132991.arm.com [10.1.30.26])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DDF013F59E;
 Tue, 15 Apr 2025 06:09:12 -0700 (PDT)
From: Thomas Wilks <thomas.wilks@arm.com>
To: dev@dpdk.org
Cc: Paul Szczepanek <paul.szczepanek@arm.com>,
 Luca Vizzarro <luca.vizzarro@arm.com>, Patrick Robb <probb@iol.unh.edu>,
 Thomas Wilks <thomas.wilks@arm.com>
Subject: [PATCH 0/2] dts: use tmp dir and DPDK tree dir
Date: Tue, 15 Apr 2025 14:09:01 +0100
Message-ID: <20250415130903.224858-1-thomas.wilks@arm.com>
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

Hi,

Sending this update to extend the use of the tmp and DPDK
tree dir.

Best regards,
Thomas


Thomas Wilks (2):
  dts: add remote create dir function
  dts: use tmp dir and DPDK tree dir

 dts/framework/remote_session/dpdk.py         | 74 ++++++--------------
 dts/framework/testbed_model/os_session.py    | 14 ++--
 dts/framework/testbed_model/posix_session.py | 26 ++++---
 dts/tests/TestSuite_softnic.py               |  2 +-
 4 files changed, 49 insertions(+), 67 deletions(-)

-- 
2.43.0

