Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37A4ACCD183
	for <dpdk-dev@archiver.kernel.org>; Mon, 13 Oct 2025 18:05:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 170A0402AE;
	Mon, 13 Oct 2025 20:05:30 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id 98CA140288
 for <dev@dpdk.org>; Mon, 13 Oct 2025 20:05:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760378727; x=1791914727;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=81NyW+lUpot2xfuvzfAziJcuDtNCD4DnZCX+ZX5AoiM=;
 b=A2ZnWiW4hr0wWmClaiHm/Acv4v0ecRPAifKA2dNz5Aeb0Rfku13hwvuy
 /QvYxhdmwJD5+YR/DbaOyPA817n+hzd2lje2a1aQwnfWdpoQrKt6/xgi5
 +q1O3PlG4pmCQA1BHYhnk4hV/VTem00tRn4XpsxWvMsy5A+uNeQSlteF6
 Cs3Gk0MHr3axH6BFULD5UsSivEHSmUBIvSnIhgDeKxKTsQpA0d31SfCaj
 ACL84Jk3XrCQiRcc4SW3SajUX4RQ4zDRZygmj0OmOLhNCC/oKh8movSwK
 Jr2C5MFRH92jtyRK3ApXss5pCv0nS/u/xGH3adfsFfCVcMfakyWTJyDFY g==;
X-CSE-ConnectionGUID: j3mMqxduRAe5xTzh+sc7zQ==
X-CSE-MsgGUID: BJW5ZSMTR86ihhACGjRM8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11581"; a="73208641"
X-IronPort-AV: E=Sophos;i="6.19,226,1754982000"; d="scan'208";a="73208641"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2025 11:05:26 -0700
X-CSE-ConnectionGUID: gpeVDxKJQ7CO4FZXgCzpvA==
X-CSE-MsgGUID: ZIoz80MtRr2EY62x4l+tyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,226,1754982000"; d="scan'208";a="181468867"
Received: from silpixa00401176.ir.intel.com ([10.20.224.212])
 by orviesa007.jf.intel.com with ESMTP; 13 Oct 2025 11:05:25 -0700
From: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com,
	anatoly.burakov@intel.com
Subject: [PATCH v6 0/3] Enable DCB/PFC support for ICE PMD
Date: Mon, 13 Oct 2025 18:05:20 +0000
Message-ID: <20251013180523.61468-1-vladimir.medvedkin@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251003124037.342760-1-vladimir.medvedkin@intel.com>
References: <20251003124037.342760-1-vladimir.medvedkin@intel.com>
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

This series introduces an initial implementation of DCB and PFC to the ICE PMD.
This includes adding support for TCs in ice_aq_set_mac_cfg() and asymmetric DCB/PFC configuration in base code.

Current implementation relies on current API and has a number of limitation and assumptions such as:

- Symmetric DCB configuration with respect to RX/TX, only dcb_rx_conf is used
- All TCs are configured equally with respect to BW they share
- No support for Low Latency TCs
- All existing queues are split evenly across TCs. Number of queues must be power of 2 and be no less than configured nb_tcs
- TX queues assigned to TCs the same way as RX queues

v6:
 - various small fixes

v5:
 - drop base code patches
 - rebase on top of the next-net

v4:
 - fix more endianness

v3:
 - ice_get_tc_by_up() is renamed to ice_get_tc_by_priority() for better clarity
 - added ice_aq_set_mac_pfc_cfg(). Old ice_aq_set_mac_cfg() is a wrapper around a new function to keep better backward compatibility with an old code
 - removed rte_memcpy() and memcry() with direct assignment
 - addressed various style-related comments

v2:
 - fix spelling
 - replace rte_memcpy with memcpy()
 - fix endianness in several places

Vladimir Medvedkin (3):
  net/ice: enable DCB support
  net/ice: enable PFC support
  net/ice: add PFC statistics

 drivers/net/intel/ice/ice_ethdev.c | 370 +++++++++++++++++++++++++++++
 drivers/net/intel/ice/ice_rxtx.c   |  21 ++
 2 files changed, 391 insertions(+)

-- 
2.43.0

