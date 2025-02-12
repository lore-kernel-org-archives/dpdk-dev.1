Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D28DC021A7
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Feb 2025 05:53:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 342EB42D55;
	Thu, 13 Feb 2025 06:53:26 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id E3CF0400D5
 for <dev@dpdk.org>; Thu, 13 Feb 2025 06:53:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739426005; x=1770962005;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=v+TBHCxnzodB2yDE1FWB7oT6qJitmWjMLuA5wfVFlxY=;
 b=Ry+izI7tAR5Ho8lwi8vpjfZZUJfT4+5o6PiddILUJoNwM+GRtO3F3Z5v
 xd3ouoTw/omifkK0KFXOWasVgtXIowLBNhAW+e3cRtRO27dBrOEHKEek2
 yoI4TncKmO/XQYQESZe7XlZ4Wp0gxeMm9ZkkwlSBk9n3ZrEIY1S9umCqI
 9EHsP1v36LvF9ZG6ZvuzqNE+gR159+6TYm9pexfHqtsreUMe3OnAaywLC
 EdWowwj7fE3ufch57kJDDfz9GxnlRZybzl0bNAOrh34IPez0mJElY4TQR
 fK7+HcEi5PHGmMzyMbcGgCryq7QE7AhjND+IQKR8ZmT90FyejJqEX2kMX Q==;
X-CSE-ConnectionGUID: TQRk5ZUIS9iWBKeqXYElEg==
X-CSE-MsgGUID: Ffj9E63/QqWH/LzTET0hNg==
X-IronPort-AV: E=McAfee;i="6700,10204,11343"; a="39813327"
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; d="scan'208";a="39813327"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Feb 2025 21:53:24 -0800
X-CSE-ConnectionGUID: FH1xXvVVQR6UR+ZD82iRQA==
X-CSE-MsgGUID: 0YrgNhhiSGGK/pLaqgYQ7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; d="scan'208";a="113035637"
Received: from unknown (HELO sprmax9..) ([10.138.182.122])
 by fmviesa007.fm.intel.com with ESMTP; 12 Feb 2025 21:53:22 -0800
From: Soumyadeep Hore <soumyadeep.hore@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com
Cc: aman.deep.singh@intel.com
Subject: [PATCH v2 0/2] Implement TXPP Support in ICE PMD
Date: Wed, 12 Feb 2025 21:47:09 +0000
Message-ID: <20250212214711.1046777-1-soumyadeep.hore@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250207124300.1022523-2-soumyadeep.hore@intel.com>
References: <20250207124300.1022523-2-soumyadeep.hore@intel.com>
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

This patchset includes TXPP feature implementation in ICE PMD.

---
v2:
- Addressing Bruce's comments and squashed two commits.
---
Paul Greenwalt (1):
  net/intel: add E830 ETF offload timestamp resolution

Soumyadeep Hore (1):
  net/intel: add Tx time queue

 drivers/net/intel/common/tx.h              |   5 +
 drivers/net/intel/ice/base/ice_lan_tx_rx.h |   5 +
 drivers/net/intel/ice/ice_ethdev.h         |   1 +
 drivers/net/intel/ice/ice_rxtx.c           | 174 +++++++++++++++++++++
 drivers/net/intel/ice/ice_rxtx.h           |   5 +
 5 files changed, 190 insertions(+)

-- 
2.43.0

