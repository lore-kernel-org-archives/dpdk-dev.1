Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CED2C5DF86
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Aug 2026 12:33:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4F60E40693;
	Wed, 19 Aug 2026 14:33:06 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id BF48440679
 for <dev@dpdk.org>; Wed, 19 Aug 2026 14:33:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787142783; x=1818678783;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=/Wg+LNIhXy5pJV2DXq1SC2JCcSHcgKUaLaKOpCrUuug=;
 b=Q8Bd/2oCVqMGS7/MXZPL/g5wcafMqNAz8EhaDrplTDvtbIXB4nWTptCe
 ObV8x/MnnUqnCpeNBLiLNcZTLIxKWXbfnNrlhVXerOpxg6qOZxzWNBeDS
 xjSOp6iuhJtTFRFb5hho27FmDbsmioUWjtYlE3cwuaHfUYwQV4O1UWtIb
 p0OYVDYX9o/CO4fwrr1S/S9RdYH/xpugpvjNfRE0bfHU+dYt1O5P6sGta
 GHYD06KayBjcdwRTiRxzMJnLjWmWyHFdtHi+Sd+nhc+Ny4qqCqi2X4kDr
 RSiXbeV04CWuQIS159b+84o/sRA3eqXY6NNgktfq3NTwv7rPNLGdKVpaD A==;
X-CSE-ConnectionGUID: /1djG2TvQ/ugPx4W+baIzg==
X-CSE-MsgGUID: IWJETuudSXmPA0bvQR4h6Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11879"; a="87775536"
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; d="scan'208";a="87775536"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Aug 2026 05:33:02 -0700
X-CSE-ConnectionGUID: dHidEGJuQ3yoq8aWVgqFvQ==
X-CSE-MsgGUID: uYtudG7ySWSJ+oeYlMLfuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; d="scan'208";a="269382568"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa004.jf.intel.com with ESMTP; 19 Aug 2026 05:33:01 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Declan Doherty <declan.doherty@intel.com>,
 Radu Nicolau <radu.nicolau@intel.com>
Subject: [PATCH v2 6/7] net/ixgbe: fix missing HW write in IPsec
Date: Wed, 19 Aug 2026 13:32:38 +0100
Message-ID: <5513a38560b945c19b228ffb017f8f328c85ec46.1787142684.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1787142684.git.anatoly.burakov@intel.com>
 <cover.1787142684.git.anatoly.burakov@intel.com>
References: 
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

When removing an SA and finding ourselves with zero refcount on an IP table
entry, we zero out the IP table registers, but do not write them. Add the
missing write.

Fixes: 9a0752f498d2 ("net/ixgbe: enable inline IPsec")
Cc: radu.nicolau@intel.com
Cc: stable@dpdk.org

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
Acked-by: Radu Nicolau <radu.nicolau@intel.com>
---
 drivers/net/intel/ixgbe/ixgbe_ipsec.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/intel/ixgbe/ixgbe_ipsec.c b/drivers/net/intel/ixgbe/ixgbe_ipsec.c
index f026a41690..4fe4dc9ba0 100644
--- a/drivers/net/intel/ixgbe/ixgbe_ipsec.c
+++ b/drivers/net/intel/ixgbe/ixgbe_ipsec.c
@@ -318,6 +318,7 @@ ixgbe_crypto_remove_sa(struct ixgbe_crypto_session *ic_session)
 			IXGBE_WRITE_REG(hw, IXGBE_IPSRXIPADDR(1), 0);
 			IXGBE_WRITE_REG(hw, IXGBE_IPSRXIPADDR(2), 0);
 			IXGBE_WRITE_REG(hw, IXGBE_IPSRXIPADDR(3), 0);
+			IXGBE_WAIT_RWRITE;
 		}
 	} else { /* session->dir == RTE_CRYPTO_OUTBOUND */
 		int i;
-- 
2.52.0

