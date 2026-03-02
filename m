Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9324AE9B36B
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Mar 2026 11:48:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DB5DA4028C;
	Mon,  2 Mar 2026 12:48:50 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id 6576B400D7
 for <dev@dpdk.org>; Mon,  2 Mar 2026 12:48:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772452129; x=1803988129;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=aX117mWDBM2fmlV5g0h1pR2w4YPxsVwY6T9gZ8Pqi1g=;
 b=Dds/3M8yqdpHB0pJZSTugqdDgepoA2u2bDQy+PJ+D3aJWnwAlYa2g9v+
 AWez+nAHecunHlOlmsyTNER1RjJQRinx6X6YuP8xbU9RUI0vMFHeyvnnM
 SMi/LQ8NOJa9q/02stJyXVfeLjni5ODicyi3fvIcEMYDF4o6ytd/ouFmi
 GV1PMiHZK2gJ6WNLYjbXa+F13l7z4qDDFxfyQPoUy41uMRbXS6jmwYVrr
 Ms3UiILnB5KJHIRhRmuCYOU6ni52b6/9awEbE2WK6jwDDuXrwmXCbo3Pf
 R67xBy/UrhREzU6wLpO7JxPhdauLwAdfpBKycejVWiL16YXWu4NCAs7G2 g==;
X-CSE-ConnectionGUID: 9qA2291KS0eR3jggb6JtYw==
X-CSE-MsgGUID: 8l0n3IYLQhC9dbOu9EdJOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11716"; a="77294767"
X-IronPort-AV: E=Sophos;i="6.21,319,1763452800"; d="scan'208";a="77294767"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Mar 2026 03:48:48 -0800
X-CSE-ConnectionGUID: b/qXx0jfRn2bK1Z4uru/SQ==
X-CSE-MsgGUID: epmT/9/uS92qG+iSK7UI4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,319,1763452800"; d="scan'208";a="222266600"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa005.fm.intel.com with ESMTP; 02 Mar 2026 03:48:47 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v3 0/2] net/ice: get link status updates via adminq message
Date: Mon,  2 Mar 2026 11:48:40 +0000
Message-ID: <20260302114842.946182-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260227110205.4099981-1-bruce.richardson@intel.com>
References: <20260227110205.4099981-1-bruce.richardson@intel.com>
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

As explained in patch 2, change the link status tracking to be via receipt
of an adminq message rather than directly querying the link status on
interrupt. As part of this change, we can reduce the cost of using the
adminq by removing the need to allocate and free memory but instead just
use the stack to store any received adminq messages.

V3: added patch 1 to reduce cost of querying the adminq.

v2: rebase on next-net-intel

Bruce Richardson (2):
  net/ice: remove malloc call for admin queue msg
  net/ice: get link status updates via adminq message

 drivers/net/intel/ice/ice_ethdev.c | 62 ++++++++++--------------------
 1 file changed, 21 insertions(+), 41 deletions(-)

--
2.51.0

