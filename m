Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF1DEC5DF74
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Aug 2026 13:20:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D58434067B;
	Tue, 18 Aug 2026 15:19:45 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id 09E1140693
 for <dev@dpdk.org>; Tue, 18 Aug 2026 15:19:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787059183; x=1818595183;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=WIuGdfuRVASk6VmGbTCbSEfC50/F/8xBWvsDubNY+qw=;
 b=CRBmT7vfZQUlnVQQw3ZWv4efxzp/VKlWyJbUxbtaz1o0fz3W9QfBDbEO
 77Q9wFZ1/ScHGI8RsLGFNNBilU/cJueuNW6vf6YlkW6TAUD+75zKsoXdy
 N//CvAo76+4w71+pyUaY0YCW+Q3yOl4dV7+G0ReVBOUNGWPkgJDC/fdIT
 TOEkTanuWHdRIZa6Uj+oR1MrOBQGRLwsBWgW8RzqN8qCHSFhfWHp8tkRS
 oh6cBbshvpjTajaUeFCOEv3+jbQ1Lik+Mv2Fv7UIvDiNdQ94BdiNXOt1E
 0ZcxafSYq6xMQg3QZcQ+X23P5up1LlbaSZ7P5oAUZgwMMAKW44ZEVF4zB g==;
X-CSE-ConnectionGUID: nv/NRCa7SdGY9y1aU+V/+A==
X-CSE-MsgGUID: wUGOtO2tRseaXro4O+0PHg==
X-IronPort-AV: E=McAfee;i="6800,10657,11878"; a="86669430"
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; d="scan'208";a="86669430"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2026 06:19:42 -0700
X-CSE-ConnectionGUID: nR6EGTMAQQWT4/6+UbhBmQ==
X-CSE-MsgGUID: O67sUgspQBqP+qh/PBMsxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; d="scan'208";a="261015727"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa006.fm.intel.com with ESMTP; 18 Aug 2026 06:19:41 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Declan Doherty <declan.doherty@intel.com>,
 Radu Nicolau <radu.nicolau@intel.com>
Subject: [PATCH v1 5/6] net/ixgbe: fix missing HW write in IPsec
Date: Tue, 18 Aug 2026 14:19:31 +0100
Message-ID: <8e60a01c72a46b0ecc6ba650affe1035dea24cb7.1787059138.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1787059137.git.anatoly.burakov@intel.com>
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
---
 drivers/net/intel/ixgbe/ixgbe_ipsec.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/intel/ixgbe/ixgbe_ipsec.c b/drivers/net/intel/ixgbe/ixgbe_ipsec.c
index 1d001b955b..2d1b3a43ca 100644
--- a/drivers/net/intel/ixgbe/ixgbe_ipsec.c
+++ b/drivers/net/intel/ixgbe/ixgbe_ipsec.c
@@ -312,6 +312,7 @@ ixgbe_crypto_remove_sa(struct ixgbe_crypto_session *ic_session)
 			IXGBE_WRITE_REG(hw, IXGBE_IPSRXIPADDR(1), 0);
 			IXGBE_WRITE_REG(hw, IXGBE_IPSRXIPADDR(2), 0);
 			IXGBE_WRITE_REG(hw, IXGBE_IPSRXIPADDR(3), 0);
+			IXGBE_WAIT_RWRITE;
 		}
 	} else { /* session->dir == RTE_CRYPTO_OUTBOUND */
 		int i;
-- 
2.52.0

