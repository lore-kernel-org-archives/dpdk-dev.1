Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48114CCF9F8
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Nov 2025 02:49:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E7C8A402B1;
	Tue,  4 Nov 2025 03:49:36 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id 4524740299
 for <dev@dpdk.org>; Tue,  4 Nov 2025 03:49:35 +0100 (CET)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A10831C2B;
 Mon,  3 Nov 2025 18:49:26 -0800 (PST)
Received: from ampere-altra-2-2.usa.arm.com (unknown [10.118.91.160])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6A3C83F694;
 Mon,  3 Nov 2025 18:49:34 -0800 (PST)
From: Doug Foster <doug.foster@arm.com>
To: dev@dpdk.org
Cc: nd@arm.com,
	Doug Foster <doug.foster@arm.com>
Subject: [PATCH 0/2] app/test-pipeline: cleanup and add ring/help options
Date: Tue,  4 Nov 2025 02:49:17 +0000
Message-Id: <20251104024919.3329372-1-doug.foster@arm.com>
X-Mailer: git-send-email 2.34.1
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

This patchset adds command-line options to configure the size of RX and
TX rings in the test-pipeline application. The current implementation
fixes the ring size at 128, which cannot be changed through the command
line. This default value may not be optimal, as the ideal ring size
depends on the platform and the CPU's ability to process entries before
they are dequeued.

This was confirmed by the observation of 66% failed enqueue attempts to
the RX ring on the Grace CPU when using a ring size of 128, indicating
that the ring was too small for the workload. Increasing the RX ring
size to 256 reduced the number of failed enqueue attempts to 22% and
improved overall throughput by approximately 22%.

In addition to making the ring sizes configurable, this patchset
introduces a help option to make valid parameters easier to understand.
It also includes minor cleanup to improve readability and
maintainability of the code.

Doug Foster (2):
  app/test-pipeline: cleanup and add help
  app/test-pipeline: add ring size options

 app/test-pipeline/config.c                 | 131 +++++++++++++++------
 app/test-pipeline/init.c                   |   4 -
 app/test-pipeline/main.h                   |   9 +-
 doc/guides/sample_app_ug/test_pipeline.rst |  12 +-
 4 files changed, 114 insertions(+), 42 deletions(-)

-- 
2.34.1

