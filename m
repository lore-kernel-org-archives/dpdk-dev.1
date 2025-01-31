Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03958C02192
	for <dpdk-dev@archiver.kernel.org>; Fri, 31 Jan 2025 13:04:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3419042EA9;
	Fri, 31 Jan 2025 14:00:22 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 99617427B6
 for <dev@dpdk.org>; Fri, 31 Jan 2025 14:00:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738328414; x=1769864414;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=mx6PV+nznPWHjE9wVam8RnH8ZRoEKZm81h5cNO6uhb4=;
 b=e2tA0pxmRWywg5Dq4G9SJB+rLuxTjCgvhPx8SlA1V2POzyj8EETO3enp
 nUwD0zny9oYiB7utqrbeY55GzmZ8eNvYrZo9tq9GI6ekEOHsGx7p4hZC7
 jOaqeYFmhPHJM4fObll7BYaaudoRgOMtUYS49L09c091Zdgh6HCigtlYq
 nhtV5+czkPqSO+UsmLkwnCiNZANwJwwoOyRACSo5O9+DoYF4U3cPxZasJ
 2PDdCeecsOABgUdbUSA1tPoUNY0pBuVdwRkZBHiNDNNT1oEwiCwoxtXm+
 rKLu0uvpjQR/55n3xjKqLgubeR0OehA5m3AYR2tVDl065IBxsimfomu2f w==;
X-CSE-ConnectionGUID: ImM7tmicSpuZAI87YdycYQ==
X-CSE-MsgGUID: In5X2u3gTuOqcRaWsiGjfw==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="50315689"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; d="scan'208";a="50315689"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jan 2025 05:00:12 -0800
X-CSE-ConnectionGUID: wN01MUcITYKRzyviGqqYjQ==
X-CSE-MsgGUID: yksLWvKYQbCvjhkXUh8iHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="140503505"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa001.fm.intel.com with ESMTP; 31 Jan 2025 05:00:10 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v1 42/42] net/e1000/base: update readme
Date: Fri, 31 Jan 2025 12:58:55 +0000
Message-ID: <6e23653f2972e5e60ff3b80fe0ca72000126d8c2.1738328108.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1738328106.git.anatoly.burakov@intel.com>
References: <cover.1738328106.git.anatoly.burakov@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Update README with more up-to-date information.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/e1000/base/README | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/intel/e1000/base/README b/drivers/net/intel/e1000/base/README
index b84ee5ad6e..2a0696f3c4 100644
--- a/drivers/net/intel/e1000/base/README
+++ b/drivers/net/intel/e1000/base/README
@@ -2,9 +2,9 @@
  * Copyright(c) 2010-2020 Intel Corporation
  */
 
-This directory contains source code of FreeBSD em & igb drivers of version
-cid-gigabit.2020.06.05.tar.gz released by ND. The sub-directory of base/
-contains the original source package.
+This directory contains source code of FreeBSD em, igb, and igc drivers of
+snapshot generated on 2025-01-24-09.44. The sub-directory of base/ contains the
+original source package.
 
 This driver is valid for the product(s) listed below
 * Intel® Ethernet Controller 82540
@@ -24,6 +24,8 @@ This driver is valid for the product(s) listed below
 * Intel® Ethernet Controller I350 Series
 * Intel® Ethernet Controller I210 Series
 * Intel® Ethernet Controller I211
+* Intel® Ethernet Controller I225
+* Intel® Ethernet Controller I226
 * Intel® Ethernet Controller I354 Series
 * Intel® Ethernet Controller DH89XXCC Series
 
-- 
2.43.5

