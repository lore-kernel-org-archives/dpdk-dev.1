Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18AEDC02194
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Feb 2025 15:15:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A43C542DB1;
	Tue,  4 Feb 2025 16:12:22 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 3420E427C3
 for <dev@dpdk.org>; Tue,  4 Feb 2025 16:12:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738681929; x=1770217929;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=sO/Dw3E92ngpJrnKVWoxm1KWwiWZXKiQmZ6+unTDaG8=;
 b=Aw3VoVTJArqE6puXTYkqenv/ej5SihUnBxFDYs4VHZ4Ay/HdTnLeZrnA
 v8YSpmLKjRqTSTBWNXhCSX64ZAOz6QYUvrXpm4sdTRyQPf/IMb6StCRyl
 NLsogQ9yM+unXrVZ5O3WnfZtZQVbYI3ubNT8YD4qkbclu/D9nFoqW0kFN
 AOe0ElCegPlpCYb/8ZKrWkgvUrMA6i9PQwrtZq7eD1icawDkMoflAHgnW
 kh+cILSc7R+VL/XaNF8ySzovwp9rvQPAlVduVkgy1s1iHhV7PmBWD74/b
 eo1cESvIZKiKnIYQwF9X0DEN955MZADuFSg6/wQLQ9TpwP6KUErlCnNLm w==;
X-CSE-ConnectionGUID: NqLxwV5UQDmbkb3/qT1HPg==
X-CSE-MsgGUID: vBMRqCbGTCOZ9KANSjpGTg==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="39097150"
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; d="scan'208";a="39097150"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Feb 2025 07:12:08 -0800
X-CSE-ConnectionGUID: J5m4y/qTQK+5TgRaYWg9hg==
X-CSE-MsgGUID: Dz6ufTcZTjKL5rQSuNf4gQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; d="scan'208";a="110792717"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa008.fm.intel.com with ESMTP; 04 Feb 2025 07:12:06 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com
Subject: [PATCH v2 32/54] net/e1000/base: add profile information field
Date: Tue,  4 Feb 2025 15:10:38 +0000
Message-ID: <3f9abd90af71abf07871d69585dc6f1bb234409f.1738681726.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1738681725.git.anatoly.burakov@intel.com>
References: <cover.1738328106.git.anatoly.burakov@intel.com>
 <cover.1738681725.git.anatoly.burakov@intel.com>
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

From: Sasha Neftin <sasha.neftin@intel.com>

Some tools require device profile information to be present, so add it.

Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/e1000/base/e1000_hw.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/intel/e1000/base/e1000_hw.h b/drivers/net/intel/e1000/base/e1000_hw.h
index b3af96977c..7ef856226d 100644
--- a/drivers/net/intel/e1000/base/e1000_hw.h
+++ b/drivers/net/intel/e1000/base/e1000_hw.h
@@ -1056,6 +1056,7 @@ struct e1000_dev_spec_i225 {
 struct e1000_hw {
 	void *back;
 
+	u8 pf_id;               /* device profile info */
 	u8 *hw_addr;
 	u8 *flash_address;
 	unsigned long io_base;
-- 
2.43.5

