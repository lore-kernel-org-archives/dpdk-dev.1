Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79782C3ABC0
	for <dpdk-dev@archiver.kernel.org>; Tue,  6 May 2025 13:31:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C942A40608;
	Tue,  6 May 2025 15:31:12 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id 09E794042E
 for <dev@dpdk.org>; Tue,  6 May 2025 15:31:11 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AAE261007;
 Tue,  6 May 2025 06:31:00 -0700 (PDT)
Received: from localhost.localdomain (JR4XG4HTQC.cambridge.arm.com
 [10.1.25.44])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9A1EF3F5A1;
 Tue,  6 May 2025 06:31:09 -0700 (PDT)
From: Luca Vizzarro <luca.vizzarro@arm.com>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Luca Vizzarro <luca.vizzarro@arm.com>, Patrick Robb <probb@iol.unh.edu>,
 Paul Szczepanek <paul.szczepanek@arm.com>
Subject: [PATCH v2 0/3] dts: add packet capture test suite
Date: Tue,  6 May 2025 14:29:30 +0100
Message-ID: <20250506132933.1580584-1-luca.vizzarro@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250331155800.449823-1-thomas.wilks@arm.com>
References: <20250331155800.449823-1-thomas.wilks@arm.com>
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

sending in a v2 for the packet capture test suite.

v2:
- added a new command to change file permissions on remote
- changed test suite to use dpdk-dumpcap instead of dpdk-pdump

Best regards,
Luca

Luca Vizzarro (1):
  dts: add facility to change file permissions

Thomas Wilks (2):
  dts: import lldp package in scapy
  dts: add packet capture test suite

 .../dts/tests.TestSuite_packet_capture.rst    |   8 +
 dts/framework/testbed_model/os_session.py     |  34 +++
 dts/framework/testbed_model/posix_session.py  |  11 +-
 .../testbed_model/traffic_generator/scapy.py  |   1 +
 dts/tests/TestSuite_packet_capture.py         | 238 ++++++++++++++++++
 5 files changed, 291 insertions(+), 1 deletion(-)
 create mode 100644 doc/api/dts/tests.TestSuite_packet_capture.rst
 create mode 100644 dts/tests/TestSuite_packet_capture.py

-- 
2.43.0

