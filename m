Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D525EC43458
	for <dpdk-dev@archiver.kernel.org>; Wed,  8 Jul 2026 22:53:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6C6044068A;
	Thu,  9 Jul 2026 00:53:12 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id 4065940265
 for <dev@dpdk.org>; Thu,  9 Jul 2026 00:53:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783551192; x=1815087192;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=4+AiOXATL7iCYWxYJlLjHTNnOlRy/h/sj2VEMO6atmQ=;
 b=niy9QzFE64ppnOzPSMKXPjZSWw5dpvtEPxDuWWSYh9sTY4UMTrETkQ9n
 yiMNZeZWThjzxajwaoAzwT57slXxFJT98qW8/74qHhL+hCiIeVG5b84Um
 IOQPj3qoGo4k8CNBklnY2Rp2KP9aT0JMx2T4d1kK7+ER240yOolGGE8Ie
 ziCQDjBVn5Qnoa+EBCMw3AQ0j8R3Y7l+CQpnGgNRNjgqnL7j7hn4GByUE
 Ah7XYbId8jKJMhAE2rTPL/9Fg/KszNij4XStYIPjX97cCvdKoxaE/Tqgp
 zUtAk7HsQ2M+un65Xr9znog0VCS1mdngmA3JasZMVq9FWc1ZRpkQfODLr A==;
X-CSE-ConnectionGUID: aCU6+FAnQvS80VLKJ1c8vg==
X-CSE-MsgGUID: mHH2DUkTQlCtnT7+iapN6Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84342802"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="84342802"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jul 2026 15:53:10 -0700
X-CSE-ConnectionGUID: PiD9IxxJQcCwgwxdjWbGrQ==
X-CSE-MsgGUID: vdPkWPCAQaSPuJA4+1aINw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; d="scan'208";a="292608236"
Received: from unknown (HELO localhost.igk.intel.com) ([10.123.235.20])
 by orviesa001.jf.intel.com with ESMTP; 08 Jul 2026 15:53:09 -0700
From: Dawid Wesierski <dawid.wesierski@intel.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, stephen@networkplumber.org,
 bruce.richardson@intel.com, marek.kasiewicz@intel.com,
 Dawid Wesierski <dawid.wesierski@intel.com>
Subject: [PATCH 1/2] doc: fix ice scheduler rate-limiter burst size description
Date: Wed,  8 Jul 2026 19:19:25 -0400
Message-ID: <20260708231926.1550698-2-dawid.wesierski@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260708231926.1550698-1-dawid.wesierski@intel.com>
References: <20260703121952.1277387-6-dawid.wesierski@intel.com>
 <20260708231926.1550698-1-dawid.wesierski@intel.com>
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

The paragraph describing the ``rl_burst_size`` devarg was mangled
(a mid-sentence line break split "favours throughput" across two
lines with no space), and it did not mention that out-of-range
values are rejected by the driver, which can otherwise look like a
silent no-op to a reader.

Fixes: b3f2afb3b7ea ("net/ice: add scheduler rate-limiter burst size devarg")

Signed-off-by: Dawid Wesierski <dawid.wesierski@intel.com>
---
 doc/guides/nics/ice.rst | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/doc/guides/nics/ice.rst b/doc/guides/nics/ice.rst
index 5589ce934f..6c2063d47e 100644
--- a/doc/guides/nics/ice.rst
+++ b/doc/guides/nics/ice.rst
@@ -160,9 +160,10 @@ Runtime Configuration
 
 - ``Scheduler rate-limiter burst size`` (default ``0``)
 
-  The hardware Tx scheduler uses a default rate-limiter burst size that favours throughput.
-  Time-sensitive applications can lower this value to reduce Tx latency jitter
-  at the cost of throughput by setting the ``rl_burst_size`` devargs parameter, in bytes.
+  The hardware Tx scheduler uses a default rate-limiter burst size that favours
+  throughput. Time-sensitive applications can lower this value to reduce Tx
+  latency jitter at the cost of throughput by setting the ``rl_burst_size``
+  devargs parameter, in bytes. Values that are out of range are rejected.
   A value of ``0`` (the default) keeps the hardware default.
 
   For example::
-- 
2.47.3

---------------------------------------------------------------------
Intel Technology Poland sp. z o.o.
ul. Slowackiego 173 | 80-298 Gdansk | Sad Rejonowy Gdansk Polnoc | VII Wydzial Gospodarczy Krajowego Rejestru Sadowego - KRS 101882 | NIP 957-07-52-316 | Kapital zakladowy 200.000 PLN.
Spolka oswiadcza, ze posiada status duzego przedsiebiorcy w rozumieniu ustawy z dnia 8 marca 2013 r. o przeciwdzialaniu nadmiernym opoznieniom w transakcjach handlowych.

Ta wiadomosc wraz z zalacznikami jest przeznaczona dla okreslonego adresata i moze zawierac informacje poufne. W razie przypadkowego otrzymania tej wiadomosci, prosimy o powiadomienie nadawcy oraz trwale jej usuniecie; jakiekolwiek przegladanie lub rozpowszechnianie jest zabronione.
This e-mail and any attachments may contain confidential material for the sole use of the intended recipient(s). If you are not the intended recipient, please contact the sender and delete all copies; any review or distribution by others is strictly prohibited.

