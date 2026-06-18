Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A800CD98ED
	for <dpdk-dev@archiver.kernel.org>; Thu, 18 Jun 2026 14:17:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6138F40DCE;
	Thu, 18 Jun 2026 16:17:42 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id 91BC940268
 for <dev@dpdk.org>; Thu, 18 Jun 2026 16:17:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781792261; x=1813328261;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=xQQW5pN1Wx/4LXKg3/fIR+9VtY0Khl264cL+T6EGsKA=;
 b=gjKQEI505zZ8MuLNr7ONlbhWYb4O1tq1VBQi0XgbQRL8B2cy//MN1HXq
 bEfmScX8KK7fpNBviGdQzbzmiahA3kk8o7VFP5rUs45L8ZCqxNsvy6dGZ
 U9JcprLSwh1HR6npoGSF9ZyHpxCr7VKxRaFoBE9SZY79Mk8E6SstR5tcn
 +O+Ib9mDjkEsPqIaJr26hPbvr+BbBlzEOZql5MtysH9oIlNK0MBacVilz
 USHyGZmSP34EKk03znTGZw3+8bELsddsDCgDfsQETQ9YjPxPwfXFmSJTF
 dhgv9Gv4a92jxLHyCoBr94W/1Wb3x7+jI92HxcmZwBCkqRXgiejrxxL8e w==;
X-CSE-ConnectionGUID: i/5vdauVTsSkFQDbmNPoGA==
X-CSE-MsgGUID: h1LX6MFpSGWPUiDA4Cot1Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11820"; a="81736960"
X-IronPort-AV: E=Sophos;i="6.24,211,1774335600"; d="scan'208";a="81736960"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jun 2026 07:17:40 -0700
X-CSE-ConnectionGUID: OpGmmzS/QayLufNb8Qo1JQ==
X-CSE-MsgGUID: HOxv8tbmQjmMOkzDn1TUGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,211,1774335600"; d="scan'208";a="248457623"
Received: from unknown (HELO localhost.igk.intel.com) ([10.123.235.20])
 by orviesa009.jf.intel.com with ESMTP; 18 Jun 2026 07:17:39 -0700
From: Dawid Wesierski <dawid.wesierski@intel.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, david.marchand@redhat.com,
 Marek Kasiewicz <marek.kasiewicz@intel.com>,
 Dawid Wesierski <dawid.wesierski@intel.com>
Subject: [PATCH v2 2/7] net/iavf: increase max ring descriptors to hardware
 limit
Date: Thu, 18 Jun 2026 10:44:37 -0400
Message-ID: <20260618144442.312844-3-dawid.wesierski@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260618144442.312844-1-dawid.wesierski@intel.com>
References: <20260608164059.65420-1-dawid.wesierski@intel.com>
 <20260618144442.312844-1-dawid.wesierski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
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

From: Marek Kasiewicz <marek.kasiewicz@intel.com>

The Intel E810 hardware supports up to 8160 (8K - 32) descriptors per
TX/RX ring, but IAVF_MAX_RING_DESC caps it at 4096. Applications that
need deep descriptor rings for hardware rate-limited pacing (e.g.,
ST2110 video with thousands of packets per frame) cannot queue enough
packets before the pacing epoch begins.

Increase IAVF_MAX_RING_DESC to the hardware maximum of 8160 to allow
full utilization of the ring depth on E810 VFs.

Signed-off-by: Marek Kasiewicz <marek.kasiewicz@intel.com>
Signed-off-by: Dawid Wesierski <dawid.wesierski@intel.com>
---
 drivers/net/intel/iavf/iavf_rxtx.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/intel/iavf/iavf_rxtx.h b/drivers/net/intel/iavf/iavf_rxtx.h
index 8449236d4d..22ea415f44 100644
--- a/drivers/net/intel/iavf/iavf_rxtx.h
+++ b/drivers/net/intel/iavf/iavf_rxtx.h
@@ -16,7 +16,7 @@
 /* In QLEN must be whole number of 32 descriptors. */
 #define IAVF_ALIGN_RING_DESC      32
 #define IAVF_MIN_RING_DESC        64
-#define IAVF_MAX_RING_DESC        4096
+#define IAVF_MAX_RING_DESC        (8192 - 32)
 #define IAVF_DMA_MEM_ALIGN        4096
 /* Base address of the HW descriptor ring should be 128B aligned. */
 #define IAVF_RING_BASE_ALIGN      128
-- 
2.47.3

---------------------------------------------------------------------
Intel Technology Poland sp. z o.o.
ul. Slowackiego 173 | 80-298 Gdansk | Sad Rejonowy Gdansk Polnoc | VII Wydzial Gospodarczy Krajowego Rejestru Sadowego - KRS 101882 | NIP 957-07-52-316 | Kapital zakladowy 200.000 PLN.
Spolka oswiadcza, ze posiada status duzego przedsiebiorcy w rozumieniu ustawy z dnia 8 marca 2013 r. o przeciwdzialaniu nadmiernym opoznieniom w transakcjach handlowych.

Ta wiadomosc wraz z zalacznikami jest przeznaczona dla okreslonego adresata i moze zawierac informacje poufne. W razie przypadkowego otrzymania tej wiadomosci, prosimy o powiadomienie nadawcy oraz trwale jej usuniecie; jakiekolwiek przegladanie lub rozpowszechnianie jest zabronione.
This e-mail and any attachments may contain confidential material for the sole use of the intended recipient(s). If you are not the intended recipient, please contact the sender and delete all copies; any review or distribution by others is strictly prohibited.

