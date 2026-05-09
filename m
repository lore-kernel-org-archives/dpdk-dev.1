Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58C18CD3447
	for <dpdk-dev@archiver.kernel.org>; Fri,  8 May 2026 13:20:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6C81A40659;
	Fri,  8 May 2026 15:20:09 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id A41664064C
 for <dev@dpdk.org>; Fri,  8 May 2026 15:20:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778246408; x=1809782408;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=hk4ewufrVTb4NfUWgr9IZ5f8hA9I52zY2B5co4I4zHg=;
 b=BxJR7gpDD771B4lnLJ5Hmuo1pc97CuiFsnXbAreHa8nKamBdQj2GKnek
 3/S1eBxS+5vs8SRNznicWwnLZ6tkPg0Difyz4vWLlJ5e1u/lEm26DpdNW
 aQ76N8Y162rtXaQhTAq7FCibqy6FAPckVNxbE7rcQWlFa6NL0mSTA/V6n
 LOMYTogFoQcmC/o5SI6p03kb/5g1f0LidHK/PkZdRLe7WBCv8z5Ct1pou
 lJr7r9/QnkFJf5WmZY6AuxI6/At3XzMdLfnbJljxDV2rk+RuXcLQ0gvjZ
 LYGOPm3PwJOo8RoCIeDIvjBacvC9P1EtFNiNdcs8D8tz2UrvYieWYlgJL g==;
X-CSE-ConnectionGUID: 0i3rJRFlRGu1EUW1l9heaw==
X-CSE-MsgGUID: cUGEtk+PSgKjIY24qBOdTg==
X-IronPort-AV: E=McAfee;i="6800,10657,11779"; a="82833592"
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; d="scan'208";a="82833592"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2026 06:20:07 -0700
X-CSE-ConnectionGUID: 9NGTXlbSR5eAEPRVGFe78g==
X-CSE-MsgGUID: iTE9hei7QuquagU35FGR1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; d="scan'208";a="241110563"
Received: from fenlix-mobl.ccr.corp.intel.com ([10.239.252.5])
 by orviesa004.jf.intel.com with ESMTP; 08 May 2026 06:20:05 -0700
From: Soumyadeep Hore <soumyadeep.hore@intel.com>
To: bruce.richardson@intel.com, manoj.kumar.subbarao@intel.com,
 aman.deep.singh@intel.com, dev@dpdk.org
Subject: [PATCH v1 2/2] doc: update recommended matching versions for cpfl and
 idpf
Date: Fri,  8 May 2026 21:54:08 -0400
Message-ID: <20260509015408.29188-3-soumyadeep.hore@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260509015408.29188-1-soumyadeep.hore@intel.com>
References: <20260509015408.29188-1-soumyadeep.hore@intel.com>
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

Update the recommended MEV-ts release version corresponding to DPDK
release in the cpfl and idpf drivers documentation.

Signed-off-by: Soumyadeep Hore <soumyadeep.hore@intel.com>
---
 doc/guides/nics/cpfl.rst | 2 ++
 doc/guides/nics/idpf.rst | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/doc/guides/nics/cpfl.rst b/doc/guides/nics/cpfl.rst
index bc42c524ea..da884f5e3b 100644
--- a/doc/guides/nics/cpfl.rst
+++ b/doc/guides/nics/cpfl.rst
@@ -41,6 +41,8 @@ Here is the suggested matching list which has been tested and verified.
    +------------+------------------+
    |    25.07   |       2.0        |
    +------------+------------------+
+   |    26.07   |       2.2        |
+   +------------+------------------+
 
 
 Configuration
diff --git a/doc/guides/nics/idpf.rst b/doc/guides/nics/idpf.rst
index c7c76190c8..a6f611c09b 100644
--- a/doc/guides/nics/idpf.rst
+++ b/doc/guides/nics/idpf.rst
@@ -37,6 +37,8 @@ Here is the suggested matching list which has been tested and verified.
    +------------+---------------+------------------+
    |    25.07   |    0.0.772    |       2.0        |
    +------------+---------------+------------------+
+   |    26.07   |    0.0.780    |       2.2        |
+   +------------+---------------+------------------+
 
 
 Configuration
-- 
2.47.1

