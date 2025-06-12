Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42181C61CE8
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Jun 2025 12:25:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E391841148;
	Thu, 12 Jun 2025 14:25:09 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id 59103410F6
 for <dev@dpdk.org>; Thu, 12 Jun 2025 14:25:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749731108; x=1781267108;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=2RThylbBrrQmipF8eA1gSZQwUgm1mbHG6ZCrGuMgfBg=;
 b=FHB4sz1zdCKbyfrH75nQeLMN+zD4JaofFD8M2jM47UD0ffu5OKumSHjU
 c6Xr7QB5G1LWhGfOj7qcJasSWbQSXd/sn7j7LnOL4SHjdmnDJ97+bz9B0
 jIJcn3eXWWP/JvHy2dWsiidPgTOPQHm1zRog8W5riOhFq5pPfYaR0V3GC
 25VPFABpTuNoCJgLBZ68y2pJ34f+7PUcv8pl8JeYsR7Ux4Kw6SDYFd1JY
 NUTB0YmOnpu/xusgx/PL3qOq9MxDfyiDc6qQUVXxX8DOroP2MqbDoPnzj
 oOwNEricw+krd9MRoEZNdK9XyWELHLJVNpgxLGRAx/Rq9g1df7a56/9mP Q==;
X-CSE-ConnectionGUID: if+4JPwLSSquZHywpDpo8w==
X-CSE-MsgGUID: vunyRYopRJuZpeE54faFCg==
X-IronPort-AV: E=McAfee;i="6800,10657,11462"; a="62557373"
X-IronPort-AV: E=Sophos;i="6.16,230,1744095600"; d="scan'208";a="62557373"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jun 2025 05:25:01 -0700
X-CSE-ConnectionGUID: B3ml+/tARL2wYR49+r85vA==
X-CSE-MsgGUID: OlfJw8m2QDyA1Wc7Eyt+1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,230,1744095600"; d="scan'208";a="152650622"
Received: from unknown (HELO srv24..) ([10.138.182.231])
 by fmviesa004.fm.intel.com with ESMTP; 12 Jun 2025 05:24:53 -0700
From: Shaiq Wani <shaiq.wani@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com,
	aman.deep.singh@intel.com
Subject: [PATCH v1 0/2] doc: update recommended matching list 
Date: Thu, 12 Jun 2025 17:55:41 +0530
Message-Id: <20250612122543.146876-1-shaiq.wani@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250612121322.146355-1-shaiq.wani@intel.com>
References: <20250612121322.146355-1-shaiq.wani@intel.com>
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

v1 - fixed the series name.

Shaiq Wani (2):
  doc: update recommended matching list for cpfl PMD
  doc: update recommended matching list for idpf PMD

 doc/guides/nics/cpfl.rst | 2 ++
 doc/guides/nics/idpf.rst | 2 ++
 2 files changed, 4 insertions(+)

-- 
2.34.1

