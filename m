Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10E66CD98F2
	for <dpdk-dev@archiver.kernel.org>; Thu, 18 Jun 2026 14:11:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 16FFD40670;
	Thu, 18 Jun 2026 16:11:45 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id 986884027C
 for <dev@dpdk.org>; Thu, 18 Jun 2026 16:11:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781791903; x=1813327903;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=xQQW5pN1Wx/4LXKg3/fIR+9VtY0Khl264cL+T6EGsKA=;
 b=lm+mXmWhJLjQi9FK+QtrNLhKz9K9rMW2/6qpOzQU6EIqtU9aW9Mb820R
 xFOqdUJqMD/iIvOtZERARHgRNypGgcGfEUwkNuRI51+iFfeMaYdEXuJfS
 EQLz9ddwDf4nsKvTPObsmGxJzg9u43p8sLzDgSn+zyztuj4rmAxjwVbnf
 oDaF+aV30jl/E/F51e/Cg5haU3NOL+OgMvVJQvblMZ5UBHzzNcY3vXqvH
 nl3J/03WxHhH82arMs48wzbQgoFSXZzq3eeW4whYW45I8MKxK9uPvB/Et
 IsEp6COGAA2ozy4xhzxbznJHSHgJULzRZ/wNv/C0cqM8+2OEaG9xplNaO w==;
X-CSE-ConnectionGUID: DMeu8rOQTPOZ8Z3gdodx0w==
X-CSE-MsgGUID: nJ/rsPbjSNmnbJq2MkA3YA==
X-IronPort-AV: E=McAfee;i="6800,10657,11820"; a="82628728"
X-IronPort-AV: E=Sophos;i="6.24,211,1774335600"; d="scan'208";a="82628728"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jun 2026 07:11:43 -0700
X-CSE-ConnectionGUID: 6dA1YxyjQhGMOHhxww/jng==
X-CSE-MsgGUID: BAi8PSUOSh6f8Uu+9uUAQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,211,1774335600"; d="scan'208";a="244211216"
Received: from unknown (HELO localhost.igk.intel.com) ([10.123.235.20])
 by fmviesa010.fm.intel.com with ESMTP; 18 Jun 2026 07:11:42 -0700
From: Dawid Wesierski <dawid.wesierski@intel.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, david.marchand@redhat.com,
 Marek Kasiewicz <marek.kasiewicz@intel.com>,
 Dawid Wesierski <dawid.wesierski@intel.com>
Subject: [PATCH v2 2/7] net/iavf: increase max ring descriptors to hardware
 limit
Date: Thu, 18 Jun 2026 10:38:32 -0400
Message-ID: <20260618143837.310156-3-dawid.wesierski@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260618143837.310156-1-dawid.wesierski@intel.com>
References: <20260618143837.310156-1-dawid.wesierski@intel.com>
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

