Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B70AACC6B03
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Oct 2026 12:05:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 811DE40A89;
	Tue, 13 Oct 2026 14:03:52 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 1A13940A84
 for <dev@dpdk.org>; Tue, 13 Oct 2026 14:03:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791893030; x=1823429030;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=ItPYF13uMMQnaJGov5t3LkWzeBaI8yUFrMT+hq9pi00=;
 b=A6s3PJDIC9fK4KIoJS2fFGsjd8UnW81Gsb/RBy0eWxSzwjOOKHDQIB4S
 zQWB2fekLI3bAqIA1WFSodZBy704EbCqZVLiOJVsYsGK0RAT8MU7xVI0T
 5fVn99JyWozAzJpoBDWxS299HXWya9dSTr7yZzSMfSz3zPzl7mWWQrz2D
 7GWt1vVLmJKjD6Y4Li41131aQULBQcnvoQ1W4WSWu42iPFYRgt1XyRNGy
 FoHHoAGsAO7uHlRCS/+6qqIyUHAAjBii44LQ5+na9ZVraISBOlS9iemrQ
 kO/H3C9Rw0Wi+/TVV6nHJyR17EHLRs/zXxl+yZZUdeSlvyvhD8smWmBIl g==;
X-CSE-ConnectionGUID: x0QQKjv1TE6huW/KncK8xA==
X-CSE-MsgGUID: b7M7ceGLQKGwUI2sxQOQpg==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="608383"
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="608383"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2026 05:03:50 -0700
X-CSE-ConnectionGUID: YpcOA5tyQZSCgCB4CkhDcw==
X-CSE-MsgGUID: txleTBfxTue8mboyHrPucg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="2908610"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa013.fm.intel.com with ESMTP; 13 Oct 2026 05:03:48 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Wenzhuo Lu <wenzhuo.lu@intel.com>, Wei Zhao <wei.zhao1@intel.com>
Subject: [PATCH v7 12/25] net/ixgbe: fix L4 protocol parsing for ntuple
Date: Tue, 13 Oct 2026 13:03:10 +0100
Message-ID: <099f46306a32b3d7410f6fa12577a581747718f3.1791892576.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1791892574.git.anatoly.burakov@intel.com>
 <cover.1791892574.git.anatoly.burakov@intel.com>
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

Currently, when parsing ntuple flows, we may hit an empty L4 protocol item
(i.e. one that does not have a mask or spec), in which case we just skip to
the end. However, we do not set a protocol mask, which means we will not
be matching L4 flows even though the flow structure implies that we should.

Fix it by setting up match-by-protocol when we have an empty L4 flow.

Additionally, there's a separate issue with how empty L4 protocol items are
handled in that once we see one, we do not check whether there's anything
else past it, and instead go straight to exit. This means that we might
have any other flow item after L4 (e.g. ipv4 / tcp / gtp) and this will be
silently accepted. Fix by enforcing that last item is END.

Fixes: 46ea969177f3 ("net/ixgbe: add ntuple support to flow parser")
Cc: stable@dpdk.org

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
Acked-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
---
 drivers/net/intel/ixgbe/ixgbe_flow.c | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/drivers/net/intel/ixgbe/ixgbe_flow.c b/drivers/net/intel/ixgbe/ixgbe_flow.c
index 547c6621d3e..04f09409ec9 100644
--- a/drivers/net/intel/ixgbe/ixgbe_flow.c
+++ b/drivers/net/intel/ixgbe/ixgbe_flow.c
@@ -358,9 +358,29 @@ cons_parse_ntuple_filter(const struct rte_flow_attr *attr,
 		return -rte_errno;
 	}
 
-	if ((item->type != RTE_FLOW_ITEM_TYPE_END) &&
-		(!item->spec && !item->mask)) {
-		goto action;
+	/* an L4 item always implies its protocol, even when empty */
+	if (item->type != RTE_FLOW_ITEM_TYPE_END) {
+		uint8_t proto;
+
+		if (item->type == RTE_FLOW_ITEM_TYPE_TCP)
+			proto = IPPROTO_TCP;
+		else if (item->type == RTE_FLOW_ITEM_TYPE_UDP)
+			proto = IPPROTO_UDP;
+		else
+			proto = IPPROTO_SCTP;
+
+		if (filter->proto_mask != 0 && filter->proto != proto) {
+			*filter = (struct rte_eth_ntuple_filter){0};
+			rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM,
+				item, "L4 item conflicts with IPv4 protocol");
+			return -rte_errno;
+		}
+		filter->proto = proto;
+		filter->proto_mask = UINT8_MAX;
+
+		if (item->spec == NULL && item->mask == NULL)
+			goto check_end;
 	}
 
 	/* get the TCP/UDP/SCTP info */
@@ -490,6 +510,7 @@ cons_parse_ntuple_filter(const struct rte_flow_attr *attr,
 		goto action;
 	}
 
+check_end:
 	/* check if the next not void item is END */
 	item = next_no_void_pattern(pattern, item);
 	if (item->type != RTE_FLOW_ITEM_TYPE_END) {
-- 
2.52.0

