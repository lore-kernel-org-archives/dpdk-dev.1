Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9194C44529
	for <dpdk-dev@archiver.kernel.org>; Tue, 21 Jul 2026 15:13:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E208E402ED;
	Tue, 21 Jul 2026 17:13:31 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id D144240294
 for <dev@dpdk.org>; Tue, 21 Jul 2026 17:13:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784646810; x=1816182810;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=qL6LcZVJzrKQkk5GhwzmzcKpndsQh5krHysTz71LsNg=;
 b=QZLlur9OfY3LT1HJEoV05H+y8IY2PrIzzO5fteKeV5FvX7xpV1hZKnf3
 GvGP2IKq6PrLd4tRt0F5bS1ENuZgfZHYhZUv9r06MA+yJq/aLh+PAobQl
 0Br/5dAI1MyIvwSA1OqezJuapb7DjWJw28t/rC9XogoXQHAZTqqQQxGf9
 agirJ3FBvyRZUPuj4vcqL25Q7qALor8pYNbr6E/zQEXSdpinLRdQ/2vgm
 4jkRaTU9hTpNWYGY9UZ6YN1FSSaIgSQcYhfGcDEVxPN4ytVQxCqV7ZDit
 XK/N7pKVetagl4a/TWxh3NeHNi9csD6wHLmeuMTe5+zubI+yGTkHhDiQb w==;
X-CSE-ConnectionGUID: i58vDxeyQo+B5FW2R87DpA==
X-CSE-MsgGUID: Ijr6mBAxQi+6eiv4P78+bQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11853"; a="85107705"
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; d="scan'208";a="85107705"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jul 2026 08:13:28 -0700
X-CSE-ConnectionGUID: q0xiHon3QrSXiX6JiThSIg==
X-CSE-MsgGUID: 4GnNziHSSCmTiNNcjvkl1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; d="scan'208";a="281070922"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa002.fm.intel.com with ESMTP; 21 Jul 2026 08:13:28 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH 0/6] doc/rel_notes: updates to 26.07 doc
Date: Tue, 21 Jul 2026 16:13:19 +0100
Message-ID: <20260721151325.2698283-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
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

A collection of miscellaneous updates and fixes for the 26.07 release notes.

Bruce Richardson (6):
  doc/rel_notes: remove bullets for single items
  doc/rel_notes: move mempool change to first item
  doc/rel_notes: keep library updates together
  doc/rel_notes: fix driver ordering
  doc/rel_notes: fix style of API changes section
  doc/rel_notes: minor style fixes

 doc/guides/rel_notes/release_26_07.rst | 143 ++++++++++++-------------
 1 file changed, 69 insertions(+), 74 deletions(-)

--
2.53.0

