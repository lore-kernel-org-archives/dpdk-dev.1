Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E61F8C02194
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Feb 2025 17:41:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 05BF442EC4;
	Fri,  7 Feb 2025 18:41:17 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id DC30942EB1
 for <dev@dpdk.org>; Fri,  7 Feb 2025 18:41:14 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 350FF2107302; Fri,  7 Feb 2025 09:41:14 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 350FF2107302
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1738950074;
 bh=tOqJXg1+eQV0axrTXB2zjREX/WfKCkDr/0GzqJ/pjhY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=CcFBOcFCfkcPvcB3mijcXqIo3aVJ3sKG1bXHWbCh2fUi7FkNdbvPp/NXpjK0ZCO90
 YGEMEqBYFLR/R0gHePe0F5ZIZCanqevTmyJhfvvIvJ0JBEXRdfjv3Oev3a1UZivlrO
 EEBiGjuLXkBtQ4lTK2orHftDKRfEjVuVpU9qDBAw=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: andremue@linux.microsoft.com
Cc: anatoly.burakov@intel.com, bruce.richardson@intel.com, dev@dpdk.org,
 ian.stokes@intel.com, jochen.behrens@broadcom.com,
 vladimir.medvedkin@intel.com, stephen@networkplumber.org
Subject: [PATCH v5 0/1] use 64-bit shift, avoid signed/unsigned mismatch
Date: Fri,  7 Feb 2025 09:41:08 -0800
Message-Id: <1738950069-21059-1-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1735246770-731-1-git-send-email-andremue@linux.microsoft.com>
References: <1735246770-731-1-git-send-email-andremue@linux.microsoft.com>
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

This patch avoids warnings like the ones below emitted by MSVC:

1)
../drivers/net/ice/base/ice_flg_rd.c(71): warning C4334: '<<':
    result of 32-bit shift implicitly converted to 64 bits
    (was 64-bit shift intended?)

2)
../drivers/net/ice/ice_dcf_sched.c(177): warning C4018: '>=':
    signed/unsigned mismatch

The fix for (1) is to use 64-bit shifting when appropriate
(according to what the result is used for).

The fix for (2) is to explicitly cast the variables used in the
comparison.

v5:
 * rebase
 * use uint32_t instead of uint32, to better conform to DPDK standards
 * rename variable rqID to rq_id to better conform to DPDK standards
   and avoid checkpatch warning
 * use 2U instead of (uint32)2, which is shorter
 * simplify expression in meson.build using compiler id "gcc"

Andre Muezerie (1):
  drivers/net: use 64-bit shift and avoid signed/unsigned mismatch

 drivers/net/intel/i40e/i40e_ethdev.c   | 22 +++++++++++-----------
 drivers/net/intel/iavf/iavf_ethdev.c   |  2 +-
 drivers/net/intel/iavf/iavf_rxtx.c     |  2 +-
 drivers/net/intel/iavf/iavf_vchnl.c    |  2 +-
 drivers/net/intel/ice/base/meson.build | 19 +++++++++++++------
 drivers/net/intel/ice/ice_dcf_sched.c  |  2 +-
 drivers/net/intel/ice/ice_ethdev.c     |  4 ++--
 drivers/net/intel/ice/ice_rxtx.c       |  2 +-
 drivers/net/intel/ixgbe/ixgbe_ethdev.c |  2 +-
 9 files changed, 32 insertions(+), 25 deletions(-)

--
2.47.2.vfs.0.1

