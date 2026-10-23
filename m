Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C5CB606A31A
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Oct 2026 16:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=dressler.pro header.i=@dressler.pro header.a=rsa-sha256 header.s=uddkim-202310 header.b=m4tcidcn
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6C23D40276;
	Fri, 23 Oct 2026 18:22:55 +0200 (CEST)
Received: from smtp03-ext2.udag.de (smtp03-ext2.udag.de [62.146.106.30])
 by mails.dpdk.org (Postfix) with ESMTP id 24ED640268
 for <dev@dpdk.org>; Fri, 23 Oct 2026 18:22:54 +0200 (CEST)
Received: from machine (unknown [37.228.233.148])
 by smtp03-ext2.udag.de (Postfix) with ESMTPA id E14FAE018F;
 Fri, 23 Oct 2026 18:22:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dressler.pro;
 s=uddkim-202310; t=1792772573;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=5kIMm5+eH3UOknLIkr9Zima/h6Hl7JeD0SqLUgo9nxk=;
 b=m4tcidcnhFnNFML/Q4mpvq0OOK2SZ54g/4KSAqeGSpMytjZlZ14Ii3fzjGOLGVd4FcEfs7
 DHb9OGS2qEIlxdWD6oeP1qfUTd5RbkB20goqjYbSosuKC/AVkuV6suPa0/Dtn9FdGMtmcV
 W4c5I2z5B3u5LphVEc0YpOWsq0X8YcVA4W4ymkAtRShxQCo0OSanJLAe8AzIHiEB4zcmsc
 4UqRHlrNG0UP4vRle2acHaNXFogSKJiYPlBS3pl0OjwATweTkPHP+TYX9eHNHGfFFAdRas
 uESk5k5T2jolyjV5xAifwVYeJyJptbUzOLBDsdXpfqjpD7w7Pj2mqYSwtUQqOA==
Authentication-Results: smtp03-ext2.udag.de;
 auth=pass smtp.auth=dressler-pro-0001 smtp.mailfrom=frank@dressler.pro
From: Frank Dressler <frank@dressler.pro>
To: stephen@networkplumber.org
Cc: dev@dpdk.org
Subject: [PATCH 0/2] fix AF_PACKET PMD rollover fanout mode
Date: Fri, 23 Oct 2026 17:22:45 +0100
Message-ID: <20261023162247.276245-1-frank@dressler.pro>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_PDS_PRO_TLD,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series fixes a bug in the AF_PACKET PMD that prevented it from
running in rollover fanout mode.

History: 364e08f2bb introduced the AF_PACKET PMD in 2014 and
unconditionally set the rollover flag. In 2025, d3bc77ab05 added
code allowing the user to select the fanout mode, including rollover
mode. Both the flag and the mode were introduced in Linux in 2013
with 77f65ebdca but their combination has been rejected ever since.
Because of that, rollover mode has never worked in the PMD.

The first patch clears the rollover _flag_ when the rollover _mode_
is set.

The second patch adds a test that checks that each fanout mode the
PMD supports is accepted by the kernel.

Frank Dressler (2):
  net/af_packet: do not set rollover flag in rollover mode
  test/af_packet: add test for fanout modes

 app/test/test_pmd_af_packet.c             | 41 +++++++++++++++++++++++
 drivers/net/af_packet/rte_eth_af_packet.c |  2 ++
 2 files changed, 43 insertions(+)

-- 
2.56.0

