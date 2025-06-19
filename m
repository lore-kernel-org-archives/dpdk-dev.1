Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E3DBC71159
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Jun 2025 07:14:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5535642E0B;
	Thu, 19 Jun 2025 09:14:17 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id B935B42E37
 for <dev@dpdk.org>; Thu, 19 Jun 2025 09:14:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750317255; x=1781853255;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=YjFhdf7lqLb7NoyAy0QdQNNGlT2n2ZwIbcC34Nje11A=;
 b=QdyBd0Qnh7Df/lXWEAOpyDOlI65UqBZ7rCjVuLsXYpXV3VEihTO2da0e
 K0DuMXJdCsn28uio2AzO9ZWGB5xfeoEGAdgzky9XzTCouYweRVSmYsvoc
 /A4BGHL5zcBdJVrHmqbKCQfVFP3iYX4bOe24+d4lDSUrlANIY39gSoJWf
 yMZU5YUUjxbvp3QkG49BS2pEMRZRdyLL/+HqjbK7qSlGl7cdlFHbBcFtR
 4KYrrkAzZ+S6zdzh7jL9vrDE+s7b4/VYNHRWJVc3Qxu5ZK7zWCNoHKCEZ
 zo7BzPckjn30JB5PbUmLt6JqBmTSpRo/4mi8bg34jo8Hx7qoCdmrDXIBA g==;
X-CSE-ConnectionGUID: BuomUBQ3TGarucZK0xY+fA==
X-CSE-MsgGUID: tzhsZ2LvTlm5NW8F2N1Odw==
X-IronPort-AV: E=McAfee;i="6800,10657,11468"; a="55193455"
X-IronPort-AV: E=Sophos;i="6.16,247,1744095600"; d="scan'208";a="55193455"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jun 2025 00:14:14 -0700
X-CSE-ConnectionGUID: ZcyLxBRFTDKKHnudDJQLAw==
X-CSE-MsgGUID: KLaZ1pq+RE2ut2YKKWbQ3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,247,1744095600"; d="scan'208";a="150990809"
Received: from unknown (HELO srv24..) ([10.138.182.231])
 by fmviesa008.fm.intel.com with ESMTP; 19 Jun 2025 00:14:12 -0700
From: Shaiq Wani <shaiq.wani@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com,
	aman.deep.singh@intel.com
Subject: [PATCH v2 0/2] doc: update recommended matching list
Date: Thu, 19 Jun 2025 12:45:00 +0530
Message-Id: <20250619071502.442214-1-shaiq.wani@intel.com>
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
v2 - Addressed review comments,fixed idpf kernel driver version.



Shaiq Wani (2):
  doc: update recommended matching list for cpfl PMD
  doc: update recommended matching list for idpf PMD

 doc/guides/nics/cpfl.rst | 2 ++
 doc/guides/nics/idpf.rst | 4 ++++
 2 files changed, 6 insertions(+)

-- 
2.34.1

