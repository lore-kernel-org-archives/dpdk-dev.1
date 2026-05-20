Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BF2DCD4F3C
	for <dpdk-dev@archiver.kernel.org>; Wed, 20 May 2026 09:29:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8891F40276;
	Wed, 20 May 2026 11:29:52 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id 221D0400D5
 for <dev@dpdk.org>; Wed, 20 May 2026 11:29:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779269391; x=1810805391;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=DMUuBKt4LQVufLfyA24yX+P/3zZ6Ix3AM5Zn9olct78=;
 b=fOR0G/bZ21r/IRinlrZP/gCN0V3PbgZOcUBxUbNDHCNwwBY68DzJXHeG
 +n3Ws40quV/p/b9PspE7ZCtOmOOSojkOxccHVDhtaQHDyHaKz3YRXPyfD
 UL+sFV/KAZwh9qhFBw8hJQ7XTwnr0wHHK66Sy07PCGMzE97DymtefsYwL
 0mkSa8pE1gxPYaNa1z3+VJtVlZ6+MvJ/WCrjrOfFvG9usqb0MFlfcwhpx
 /u22yzsBPYFvmXXfzMrDi7qRiiJzzumtCm14VT4rnNMjG/T9kGwJCPLLR
 +BpgGzJqvZ7MZmDquc1M0BoGTJ7Q7B+Vg5Bwu3Fb5GlMAZE81AUl4PhDk Q==;
X-CSE-ConnectionGUID: dBYGgUpZTd6V9x7600+ImA==
X-CSE-MsgGUID: cw7QhRgDSZSWWRKVh2giwg==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="80013697"
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; d="scan'208";a="80013697"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2026 02:29:50 -0700
X-CSE-ConnectionGUID: xvFG9nQHSFWvDZrfrsvTag==
X-CSE-MsgGUID: Ynd5RnT8RdGTp1vuyJBRFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; d="scan'208";a="245088184"
Received: from fenlix-mobl.ccr.corp.intel.com ([10.239.252.5])
 by orviesa005.jf.intel.com with ESMTP; 20 May 2026 02:29:48 -0700
From: Soumyadeep Hore <soumyadeep.hore@intel.com>
To: bruce.richardson@intel.com, manoj.kumar.subbarao@intel.com,
 aman.deep.singh@intel.com, dev@dpdk.org
Subject: [PATCH v2 0/2] Update IDPF Base Code
Date: Wed, 20 May 2026 18:03:04 -0400
Message-ID: <20260520220306.85273-1-soumyadeep.hore@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260509015408.29188-3-soumyadeep.hore@intel.com>
References: <20260509015408.29188-3-soumyadeep.hore@intel.com>
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

Update idpf base code with compatible configuration on MEV.

---
v2:
- lists only LTS releases
- lists releases in descending order, so that latest is on top
- reworks table to use the new RST table format
---

Christopher Pau (1):
  net/idpf/base: add MMG device IDs

Soumyadeep Hore (1):
  doc: update recommended matching versions for cpfl and idpf

 doc/guides/nics/cpfl.rst                  | 21 ++++++++-------------
 doc/guides/nics/idpf.rst                  | 19 ++++++++-----------
 drivers/net/intel/idpf/base/idpf_devids.h |  3 +++
 3 files changed, 19 insertions(+), 24 deletions(-)

-- 
2.47.1

