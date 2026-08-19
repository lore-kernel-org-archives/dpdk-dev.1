Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05EEFC5DF86
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Aug 2026 12:32:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0614F402CE;
	Wed, 19 Aug 2026 14:32:59 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id F092F402C4
 for <dev@dpdk.org>; Wed, 19 Aug 2026 14:32:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787142777; x=1818678777;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=eBy4iZbpf4lELMia2iglh8C3oC821Pbi0YCDwy/52jY=;
 b=lxlohiLeMz6mqJlb88pmfEbawfN9E4eJaTEQYp8/eL5jIEfOry5V/1TP
 0qODYLL4OIDISGQsfBfBHO1Q99nry/6VLMlwLx5b87uxV9D9Njv/bEW6j
 65dfvkc+c0wXFJAAe5yBbWhj3TP8kxjpYr4i0ht69iy8bo4HDmMH1cNtz
 jszunYapOnxKLcMF4d6xH5UI/CmKzJRaeIzvM300vEDr7r/OqaHSDZMZu
 +pNorEIh8dA4EetO1tqzat7xNGgnnD25eUqUTpdJybUGsDRtBFgok2azT
 YE9kNYwNZFbyCbNcZyfknij7Wy5lM0AiPDAf2qxR0XbhB7+wKMDUav3L/ A==;
X-CSE-ConnectionGUID: qTZzFDUGTbWeDzkZ8HM5Rg==
X-CSE-MsgGUID: wTjTgVHeRgipz0TuH3CLLg==
X-IronPort-AV: E=McAfee;i="6800,10657,11879"; a="87775525"
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; d="scan'208";a="87775525"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Aug 2026 05:32:55 -0700
X-CSE-ConnectionGUID: AKSM8PfnTcuxPcuH8P11Pg==
X-CSE-MsgGUID: e7Dk8rSwSRSF7BkeNqDFaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; d="scan'208";a="269382536"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa004.jf.intel.com with ESMTP; 19 Aug 2026 05:32:55 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v2 0/7] IXGBE IPsec fixes
Date: Wed, 19 Aug 2026 13:32:32 +0100
Message-ID: <cover.1787142684.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1787059137.git.anatoly.burakov@intel.com>
References: <cover.1787059137.git.anatoly.burakov@intel.com>
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

Small array of fixes and refactors for IXGBE IPsec implementation.

v1 -> v2:
- Added rte_memzero_explicit calls on account of AI review
- Added a small patch fixing wrong variable usage
- Reworked patch 7 (was 6) to not perform SPI byteswap until register writes

Anatoly Burakov (7):
  net/ixgbe: add key length check in IPsec
  net/ixgbe: remove unnecessary dev pointer
  net/ixgbe: harmonize return values in IPsec
  net/ixgbe: get rid of unnecessary malloc in IPsec
  net/ixgbe: use correct index variable in IPsec
  net/ixgbe: fix missing HW write in IPsec
  net/ixgbe: refactor IPsec code

 drivers/net/intel/ixgbe/ixgbe_ipsec.c | 355 ++++++++++++--------------
 drivers/net/intel/ixgbe/ixgbe_ipsec.h |   1 +
 2 files changed, 163 insertions(+), 193 deletions(-)

-- 
2.52.0

