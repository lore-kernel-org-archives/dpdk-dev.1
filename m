Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D419C5DF66
	for <dpdk-dev@archiver.kernel.org>; Mon, 17 Aug 2026 13:44:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6EF9A40294;
	Mon, 17 Aug 2026 15:44:41 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 4A6724021F
 for <dev@dpdk.org>; Mon, 17 Aug 2026 15:44:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786974280; x=1818510280;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=1l4tS7k+/pKK57v9gPO7D5o45J83WDjK/fq2H0yNwnk=;
 b=jjdKHvGFZ7kCGq0T0VXOhIfPfS2QxUvJhcAd/6ltTZjqgATbvrgiyM9x
 rMHxQ/HwBW3eNQF+VdqYQCaD9zMj5lKgkTpZpytUFg9r1dRXG42DRXHpP
 5PLXTLwDXGHbFDZizbtdxOwpbEmYLlCTrEiDFqWCoKz/wFkVGdXK4GQkI
 iC8Sa1YhIv4KHxoXQTF5j1KrGbIRAf6WdqwObj1moF7cG7wFgCPMHCJoD
 B0MPuG5izeHt/UALprrOX7KPR/N1Md5MprvvQn31eDgek7pYgbY21ah6n
 nkBRipPrBkOBZ56tVSheh6vXrrRLwwn7Nas/J0ukX/xm+AFEdb0Gl4j2/ Q==;
X-CSE-ConnectionGUID: tEK+OC0XQKu/YbGLePGKtA==
X-CSE-MsgGUID: FNabrSeLRFSIg5LVx2APbg==
X-IronPort-AV: E=McAfee;i="6800,10657,11877"; a="104831491"
X-IronPort-AV: E=Sophos;i="6.25,229,1779174000"; d="scan'208";a="104831491"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Aug 2026 06:44:37 -0700
X-CSE-ConnectionGUID: WEXyb0u0R0KAzDu54maRnA==
X-CSE-MsgGUID: KFjH2VDtSsKlj5nuFcuwaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,229,1779174000"; d="scan'208";a="263165818"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa006.jf.intel.com with ESMTP; 17 Aug 2026 06:44:37 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2 0/3] lib: remove use of strncpy
Date: Mon, 17 Aug 2026 14:42:39 +0100
Message-ID: <20260817134432.1206297-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260623141930.704771-1-bruce.richardson@intel.com>
References: <20260623141930.704771-1-bruce.richardson@intel.com>
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

Taking a lead from the kernel, which has just finished a multi-year
effort to remove use of strncpy[1], rework DPDK to remove use of the
same function. This series removes all remaining uses of strncpy
in lib directory.

[1] https://www.phoronix.com/news/Linux-7.2-Drops-strncpy

V2: resubmit for 26.11, applying the series-reviewed-by as individual
    per-patch tags.

Bruce Richardson (3):
  ethdev: remove use of strncpy
  eventdev: improve bounds checks for names in adapter create
  vhost: remove use of strncpy

 lib/ethdev/ethdev_driver.c              |  7 ++++++-
 lib/eventdev/rte_event_eth_tx_adapter.c |  4 ++--
 lib/vhost/socket.c                      |  4 +---
 lib/vhost/vduse.c                       |  2 +-
 lib/vhost/vhost.c                       | 12 +++---------
 lib/vhost/vhost.h                       |  2 +-
 6 files changed, 14 insertions(+), 17 deletions(-)

-- 
2.53.0

