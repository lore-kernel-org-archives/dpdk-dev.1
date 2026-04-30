Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFCE1FF8875
	for <dpdk-dev@archiver.kernel.org>; Thu, 30 Apr 2026 09:44:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 005A740395;
	Thu, 30 Apr 2026 11:44:42 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id B8AE64021F
 for <dev@dpdk.org>; Thu, 30 Apr 2026 11:44:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777542282; x=1809078282;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=okQLMWFFoZt5FSsBVhIOZKrd808UaF06IfrSAKCU2hc=;
 b=Cve/WJ8C1UFr/d071U/sUBVimSD+WEvhD9lre1mo1ubdhrRK3L5mcVrZ
 DtdCIImHTbBNpOt9ZejhE49UNUzp2uqtrWtY6fJ6EF2BpJnwW61wucGBh
 fWwo8QRYp5QclLRw+e0vGUox4VVNWQzz83CGh56m3bFOYlRv7/IIkhghG
 4avPMa9SLFfWhzWi/jF80E/0jUMeGNR4RKgMfu2OCyhQHOVdozgrigcge
 OduR5FnEsQwllwwE6Zr7oPkxqsjdSEo+3+lxAX5SetDaIW/VBE3fwSVO9
 +peaU909O6oGc8ou1uW0Lopn+WGm8ELBb0aojjFIXUOIeU4Vv9nHpfsO+ Q==;
X-CSE-ConnectionGUID: EUGfzP5+QJad3TvIr0z+3g==
X-CSE-MsgGUID: fnXtcBR5Q8auEdU5fMKFtQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="78354790"
X-IronPort-AV: E=Sophos;i="6.23,207,1770624000"; d="scan'208";a="78354790"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Apr 2026 02:44:41 -0700
X-CSE-ConnectionGUID: tuLm/pB2Rxi8WNfkmol5Mg==
X-CSE-MsgGUID: VibjgIAJSFmxJWb0VnnTzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,207,1770624000"; d="scan'208";a="258113808"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa001.fm.intel.com with ESMTP; 30 Apr 2026 02:44:40 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v1 1/1] net/iavf: remove RAW flow item support from fsub
Date: Thu, 30 Apr 2026 10:44:38 +0100
Message-ID: <34827309e49eaba498cfe41500ee8de1fd3a2bb5.1777542270.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
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

Currently, no kernel driver implements support for RAW items, so having
this support in our parser is extra work for no value. Remove the support
for RAW flow items until such time as there is kernel driver support.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/iavf/iavf_fsub.c | 75 ------------------------------
 1 file changed, 75 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf_fsub.c b/drivers/net/intel/iavf/iavf_fsub.c
index bfb34695de..a00d02ded5 100644
--- a/drivers/net/intel/iavf/iavf_fsub.c
+++ b/drivers/net/intel/iavf/iavf_fsub.c
@@ -57,7 +57,6 @@ static struct iavf_flow_parser iavf_fsub_parser;
 
 static struct
 iavf_pattern_match_item iavf_fsub_pattern_list[] = {
-	{iavf_pattern_raw,				IAVF_INSET_NONE,			IAVF_INSET_NONE},
 	{iavf_pattern_ethertype,			IAVF_SW_INSET_ETHER,			IAVF_INSET_NONE},
 	{iavf_pattern_eth_ipv4,				IAVF_SW_INSET_MAC_IPV4,			IAVF_INSET_NONE},
 	{iavf_pattern_eth_vlan_ipv4,			IAVF_SW_INSET_MAC_VLAN_IPV4,		IAVF_INSET_NONE},
@@ -154,7 +153,6 @@ iavf_fsub_parse_pattern(const struct rte_flow_item pattern[],
 {
 	struct virtchnl_proto_hdrs *hdrs = &filter->sub_fltr.proto_hdrs;
 	enum rte_flow_item_type item_type;
-	const struct rte_flow_item_raw *raw_spec, *raw_mask;
 	const struct rte_flow_item_eth *eth_spec, *eth_mask;
 	const struct rte_flow_item_ipv4 *ipv4_spec, *ipv4_mask;
 	const struct rte_flow_item_ipv6 *ipv6_spec, *ipv6_mask;
@@ -166,7 +164,6 @@ iavf_fsub_parse_pattern(const struct rte_flow_item pattern[],
 	uint64_t outer_input_set = IAVF_INSET_NONE;
 	uint64_t *input = NULL;
 	uint16_t input_set_byte = 0;
-	uint8_t item_num = 0;
 	uint32_t layer = 0;
 
 	for (item = pattern; item->type != RTE_FLOW_ITEM_TYPE_END; item++) {
@@ -178,79 +175,7 @@ iavf_fsub_parse_pattern(const struct rte_flow_item pattern[],
 		}
 
 		item_type = item->type;
-		item_num++;
-
 		switch (item_type) {
-		case RTE_FLOW_ITEM_TYPE_RAW: {
-			raw_spec = item->spec;
-			raw_mask = item->mask;
-
-			if (!raw_spec || !raw_mask) {
-				PMD_DRV_LOG(ERR, "NULL RAW spec/mask");
-				rte_flow_error_set(error, EINVAL,
-						RTE_FLOW_ERROR_TYPE_ITEM,
-						item, "NULL RAW spec/mask");
-				return -rte_errno;
-			}
-
-			if (item_num != 1)
-				return -rte_errno;
-
-			if (raw_spec->length != raw_mask->length)
-				return -rte_errno;
-
-			uint16_t pkt_len = 0;
-			uint16_t tmp_val = 0;
-			uint8_t tmp = 0;
-			int i, j;
-
-			pkt_len = raw_spec->length;
-
-			for (i = 0, j = 0; i < pkt_len; i += 2, j++) {
-				tmp = raw_spec->pattern[i];
-				if (tmp >= 'a' && tmp <= 'f')
-					tmp_val = tmp - 'a' + 10;
-				if (tmp >= 'A' && tmp <= 'F')
-					tmp_val = tmp - 'A' + 10;
-				if (tmp >= '0' && tmp <= '9')
-					tmp_val = tmp - '0';
-
-				tmp_val *= 16;
-				tmp = raw_spec->pattern[i + 1];
-				if (tmp >= 'a' && tmp <= 'f')
-					tmp_val += (tmp - 'a' + 10);
-				if (tmp >= 'A' && tmp <= 'F')
-					tmp_val += (tmp - 'A' + 10);
-				if (tmp >= '0' && tmp <= '9')
-					tmp_val += (tmp - '0');
-
-				hdrs->raw.spec[j] = tmp_val;
-
-				tmp = raw_mask->pattern[i];
-				if (tmp >= 'a' && tmp <= 'f')
-					tmp_val = tmp - 'a' + 10;
-				if (tmp >= 'A' && tmp <= 'F')
-					tmp_val = tmp - 'A' + 10;
-				if (tmp >= '0' && tmp <= '9')
-					tmp_val = tmp - '0';
-
-				tmp_val *= 16;
-				tmp = raw_mask->pattern[i + 1];
-				if (tmp >= 'a' && tmp <= 'f')
-					tmp_val += (tmp - 'a' + 10);
-				if (tmp >= 'A' && tmp <= 'F')
-					tmp_val += (tmp - 'A' + 10);
-				if (tmp >= '0' && tmp <= '9')
-					tmp_val += (tmp - '0');
-
-				hdrs->raw.mask[j] = tmp_val;
-			}
-
-			hdrs->raw.pkt_len = pkt_len / 2;
-			hdrs->tunnel_level = 0;
-			hdrs->count = 0;
-			return 0;
-		}
 		case RTE_FLOW_ITEM_TYPE_ETH:
 			eth_spec = item->spec;
 			eth_mask = item->mask;
-- 
2.47.3

