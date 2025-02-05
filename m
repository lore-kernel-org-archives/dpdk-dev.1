Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93AEAC02198
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Feb 2025 18:53:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C96BB402F2;
	Wed,  5 Feb 2025 19:53:17 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 10E87402F2
 for <dev@dpdk.org>; Wed,  5 Feb 2025 19:53:16 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 4344F2037186; Wed,  5 Feb 2025 10:53:15 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4344F2037186
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1738781595;
 bh=GTr6IxUD5Idvnnk6+NeAWh462pgLQRFRW6k/CgZOiEM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=kVn30Qrn7/v7riZEmK2lutAN5KmPrDiM/wmKRvp7NAGXNjz0mzllczl0DVFzzCaC5
 w5pfncaUcXr6rBwqU5X8U2LWxYHo4xPdYlep4CbvLI9Zzt2lnluwGgDWZvTRfPMk4r
 jYCNEZgygEEmCAEfxEiGWLr2sUdal8DFC7EV/j+M=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: andremue@linux.microsoft.com
Cc: anatoly.burakov@intel.com, bruce.richardson@intel.com, dev@dpdk.org,
 dsinghrawat@marvell.com, palok@marvell.com, stephen@networkplumber.org
Subject: [PATCH v3 0/2] remove unused variables and add MSVC compiler flag
Date: Wed,  5 Feb 2025 10:53:08 -0800
Message-Id: <1738781590-2408-1-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1735238504-15597-3-git-send-email-andremue@linux.microsoft.com>
References: <1735238504-15597-3-git-send-email-andremue@linux.microsoft.com>
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

v3:
 * rebased.

Removed unused variables and added MSVC specific compiler flag to
ignore warnings about unused variables, like is being done for
other compilers.

Andre Muezerie (2):
  drivers/common: remove unused variables and add MSVC compiler flag
  drivers/net: add MSVC compiler flag for unused variables

 drivers/common/idpf/base/meson.build       | 13 +++--
 drivers/common/idpf/idpf_common_rxtx.c     |  2 -
 drivers/common/idpf/idpf_common_virtchnl.c |  4 +-
 drivers/common/sfc_efx/base/efx_mae.c      |  2 +-
 drivers/common/sfc_efx/base/efx_table.c    |  1 -
 drivers/common/sfc_efx/base/meson.build    | 20 +++++---
 drivers/net/qede/base/meson.build          | 57 ++++++++++++----------
 7 files changed, 58 insertions(+), 41 deletions(-)

--
2.47.2.vfs.0.1

