Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D97A1CFA466
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Nov 2025 09:32:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8DAE74060F;
	Mon, 24 Nov 2025 10:32:51 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id C7AC3400D7
 for <dev@dpdk.org>; Mon, 24 Nov 2025 10:32:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763976770; x=1795512770;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ObMc2xy/j6/VfR5NC/SJfRzAv/k0+MNKoho8YCaXCcA=;
 b=hOKW4ZLVRC39oEYqrL1K2MsBNCniCsCRZwxLKxOkWmvGa3nE9HUHOztk
 PQRvdhw12+1oQqXSEb0Ka+/Q9b3oMqD/RleLRVd2J/fPcQq43sf3onpAu
 N5PF8dpkFu0x900lLcv8/zUKCVPvFLvqinJshfan4/4RQLAlJPHLVoyqT
 yG+FNYzbKXvcoqMBNqfv3coZWWI7bYJJGmMznQ4iZADjTfWjNpyZv422v
 H7AkyHJzHu4gwYaRHm99jd1ogbIsyd8ErsXKYeUFPvUzymtK/9lOQpakc
 1Jy1xRcWk+djnouy/Em9t2D06ad1DMDDZ+HPjmr7lySXZk/1qip0g3h8+ g==;
X-CSE-ConnectionGUID: CbK9mFfYT7GRYIqIyS8mng==
X-CSE-MsgGUID: YW08DqHFTWum0czBndi2Bg==
X-IronPort-AV: E=McAfee;i="6800,10657,11622"; a="65864772"
X-IronPort-AV: E=Sophos;i="6.20,222,1758610800"; d="scan'208";a="65864772"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Nov 2025 01:32:49 -0800
X-CSE-ConnectionGUID: Hmeh8iGCRbqw1bFpwLY+hw==
X-CSE-MsgGUID: mF/EU6+lTB6dvmoFLpkK4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,222,1758610800"; d="scan'208";a="223251990"
Received: from unknown (HELO tester12..) ([10.239.252.12])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Nov 2025 01:32:48 -0800
From: hailinxx <hailinx.xu@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, rajesh.t.puttaswamy@intel.com,
 john.mcnamara@intel.com, hailinxx <hailinx.xu@intel.com>
Subject: [PATCH v1 1/2] net/ice: updated latest recommended matching list
Date: Mon, 24 Nov 2025 08:50:09 +0000
Message-Id: <20251124085010.707091-2-hailinx.xu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251124085010.707091-1-hailinx.xu@intel.com>
References: <20251124085010.707091-1-hailinx.xu@intel.com>
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

Signed-off-by: hailinxx <hailinx.xu@intel.com>
---
 doc/guides/nics/ice.rst | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/doc/guides/nics/ice.rst b/doc/guides/nics/ice.rst
index 2d555d2943..cde31a5694 100644
--- a/doc/guides/nics/ice.rst
+++ b/doc/guides/nics/ice.rst
@@ -63,14 +63,6 @@ For E810,
    +-----------+---------------+-----------------+-----------+--------------+-----------+
    |    DPDK   | Kernel Driver | OS Default DDP  | COMMS DDP | Wireless DDP | Firmware  |
    +===========+===============+=================+===========+==============+===========+
-   |    20.11  |     1.3.2     |      1.3.20     |  1.3.24   |      N/A     |    2.3    |
-   +-----------+---------------+-----------------+-----------+--------------+-----------+
-   |    21.02  |     1.4.11    |      1.3.24     |  1.3.28   |    1.3.4     |    2.4    |
-   +-----------+---------------+-----------------+-----------+--------------+-----------+
-   |    21.05  |     1.6.5     |      1.3.26     |  1.3.30   |    1.3.6     |    3.0    |
-   +-----------+---------------+-----------------+-----------+--------------+-----------+
-   |    21.08  |     1.7.16    |      1.3.27     |  1.3.31   |    1.3.7     |    3.1    |
-   +-----------+---------------+-----------------+-----------+--------------+-----------+
    |    21.11  |     1.7.16    |      1.3.27     |  1.3.31   |    1.3.7     |    3.1    |
    +-----------+---------------+-----------------+-----------+--------------+-----------+
    |    22.03  |     1.8.3     |      1.3.28     |  1.3.35   |    1.3.8     |    3.2    |
@@ -95,6 +87,8 @@ For E810,
    +-----------+---------------+-----------------+-----------+--------------+-----------+
    |    25.07  |     2.2.8     |      1.3.43     |  1.3.55   |    1.3.23    |    4.8    |
    +-----------+---------------+-----------------+-----------+--------------+-----------+
+   |    25.11  |     2.3.14    |      1.3.43     |  1.3.55   |    1.3.25    |    4.9    |
+   +-----------+---------------+-----------------+-----------+--------------+-----------+
 
 For E830,
 
@@ -103,7 +97,8 @@ For E830,
    +===========+===============+=================+===========+==============+===========+
    |    25.07  |     2.2.8     |      1.3.43     |  1.3.55   |    1.3.23    |    1.0    |
    +-----------+---------------+-----------------+-----------+--------------+-----------+
-
+   |    25.11  |     2.3.14    |      1.3.43     |  1.3.55   |    1.3.25    |    1.2    |
+   +-----------+---------------+-----------------+-----------+--------------+-----------+
 
 Dynamic Device Personalization (DDP) package loading
 ----------------------------------------------------
-- 
2.34.1

