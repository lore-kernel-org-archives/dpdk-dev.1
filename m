Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26C30C3600B
	for <dpdk-dev@archiver.kernel.org>; Mon, 31 Mar 2025 15:58:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CC57F4068A;
	Mon, 31 Mar 2025 17:58:14 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id 0C4E140689
 for <dev@dpdk.org>; Mon, 31 Mar 2025 17:58:12 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B77E31692;
 Mon, 31 Mar 2025 08:58:15 -0700 (PDT)
Received: from e132991.cambridge.arm.com (e132991.arm.com [10.1.39.18])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 233C03F63F;
 Mon, 31 Mar 2025 08:58:11 -0700 (PDT)
From: Thomas Wilks <thomas.wilks@arm.com>
To: dev@dpdk.org
Cc: Paul Szczepanek <paul.szczepanek@arm.com>,
 Luca Vizzarro <luca.vizzarro@arm.com>, Patrick Robb <probb@iol.unh.edu>,
 Thomas Wilks <thomas.wilks@arm.com>
Subject: [PATCH 0/2] dts: add packet capture test suite
Date: Mon, 31 Mar 2025 16:57:58 +0100
Message-ID: <20250331155800.449823-1-thomas.wilks@arm.com>
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

Sending this new test suite that tests the packet capture framework.

Best regards,
Thomas

Depends-on: series-34865 ("dts: shell improvements")

Thomas Wilks (2):
  dts: add packet capture test suite
  dts: import lldp package in scapy

 .../dts/tests.TestSuite_packet_capture.rst    |   8 +
 .../testbed_model/traffic_generator/scapy.py  |   1 +
 dts/tests/TestSuite_packet_capture.py         | 357 ++++++++++++++++++
 3 files changed, 366 insertions(+)
 create mode 100644 doc/api/dts/tests.TestSuite_packet_capture.rst
 create mode 100644 dts/tests/TestSuite_packet_capture.py

-- 
2.43.0

