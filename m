Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2054BC43602
	for <dpdk-dev@archiver.kernel.org>; Fri,  3 Jul 2026 13:20:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3B5A340A76;
	Fri,  3 Jul 2026 15:19:54 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id 0910B409FA;
 Fri,  3 Jul 2026 15:19:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783084792; x=1814620792;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=I0ZT7MgMG1o4/fa69hzq8cs6NKzCqE2M9ucILbnL41g=;
 b=jXIHfMecWsopSV2Dpa649bfSdFaxLLYJrNQauwXhJggeBaNLuyOVMQK7
 zJ5wRj02CfL4GCRugONt7lOpoCAHE90jb6/KZC8GDCopudCjnM2/kWiTO
 5m/SBtAyUIZDXy4wc+CV6lyo+HQjsn+ZDhwBUK/IVo++IXvnBx2p2R95+
 ZOeslR0LoPBvZMbfgtabT6JDubeFeMr9kbMB0+u/AXJTsB+/OnmmjC+x3
 U/mBnAh+aL343WLXY4U8jV2FMbEdNg1Qnf7eGnhcZ3tQlhzS9GEuUXfJ4
 zr+4/nJfaRCccP8/2FzJ2VuVgbm7Ipm43a8EhjPZIhpJ5cftBG90VQQLq g==;
X-CSE-ConnectionGUID: t4H9cicbTe+6V/DJwi0HgQ==
X-CSE-MsgGUID: nbqUMLEORJKefIr7+fOArg==
X-IronPort-AV: E=McAfee;i="6800,10657,11835"; a="94486674"
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; d="scan'208";a="94486674"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2026 06:19:51 -0700
X-CSE-ConnectionGUID: AJ2zcEMxSDuCy7Y3Jw2hTA==
X-CSE-MsgGUID: 14kmCvuGTFS/eLrdp+jdvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; d="scan'208";a="257439857"
Received: from silpixa00401385.ir.intel.com (HELO
 localhost.ger.corp.intel.com) ([10.20.224.226])
 by orviesa005.jf.intel.com with ESMTP; 03 Jul 2026 06:19:50 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>, stable@dpdk.org,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Qiming Yang <qiming.yang@intel.com>, Qi Zhang <qi.z.zhang@intel.com>
Subject: [PATCH v2 3/6] net/iavf: fix memory leak on error when adding flow
 parser
Date: Fri,  3 Jul 2026 14:19:17 +0100
Message-ID: <20260703131921.4102325-4-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260703131921.4102325-1-bruce.richardson@intel.com>
References: <20260703083335.4058936-1-bruce.richardson@intel.com>
 <20260703131921.4102325-1-bruce.richardson@intel.com>
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

In iavf_register_flow_parser, the final "else" branch is an error leg
which returns immediately, without adding the newly allocated
parser_node to a TAILQ. Add a free call for that parser_node in the
error case to avoid leaking memory.

Fixes: ff2d0c345c3b ("net/iavf: support generic flow API")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/iavf/iavf_generic_flow.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/intel/iavf/iavf_generic_flow.c b/drivers/net/intel/iavf/iavf_generic_flow.c
index 84bb161bd1..92ca20031c 100644
--- a/drivers/net/intel/iavf/iavf_generic_flow.c
+++ b/drivers/net/intel/iavf/iavf_generic_flow.c
@@ -1911,6 +1911,7 @@ iavf_register_parser(struct iavf_flow_parser *parser,
 		list = &vf->dist_parser_list;
 		TAILQ_INSERT_HEAD(list, parser_node, node);
 	} else {
+		rte_free(parser_node);
 		return -EINVAL;
 	}
 
-- 
2.53.0

