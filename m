Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62CDBCAC597
	for <dpdk-dev@archiver.kernel.org>; Mon, 15 Sep 2025 18:56:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2AF07402C2;
	Mon, 15 Sep 2025 20:56:01 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id 1AEA54027F
 for <dev@dpdk.org>; Mon, 15 Sep 2025 20:55:59 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B2C7A1424;
 Mon, 15 Sep 2025 11:55:50 -0700 (PDT)
Received: from ampere-altra-2-1.usa.arm.com (ampere-altra-2-1.usa.arm.com
 [10.118.91.158])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D20D93F694;
 Mon, 15 Sep 2025 11:55:58 -0700 (PDT)
From: Wathsala Vithanage <wathsala.vithanage@arm.com>
To: 
Cc: dev@dpdk.org,
	Wathsala Vithanage <wathsala.vithanage@arm.com>
Subject: [PATCH 0/1] ring: correct ordering issue in head/tail update
Date: Mon, 15 Sep 2025 18:54:49 +0000
Message-ID: <20250915185451.533039-1-wathsala.vithanage@arm.com>
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

Hi all,

This patch resolves a subtle ordering issue in the ring code that could
lead to incorrect behavior under certain conditions. The change favors a
performance-conscious fix while preserving existing behavior.

For background, motivation, and validation (including Herd7 litmus
tests), please see the accompanying write-up:https://community.arm.com/arm-community-blogs/b/architectures-and-processors-blog/posts/when-a-barrier-does-not-block-the-pitfalls-of-partial-order

Wathsala Vithanage (1):
  ring: safe partial ordering for head/tail update

 lib/ring/rte_ring_c11_pvt.h | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

-- 
2.43.0

