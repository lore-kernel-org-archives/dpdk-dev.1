Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EB88C43458
	for <dpdk-dev@archiver.kernel.org>; Mon, 13 Jul 2026 09:16:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 40BC040685;
	Mon, 13 Jul 2026 11:16:46 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 073A84028A
 for <dev@dpdk.org>; Mon, 13 Jul 2026 11:16:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783934203; x=1815470203;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=pbMU30aDIUJ1puFyFSukc+Zi5rzRTLWGHZrn/JOHft0=;
 b=H1GJ23A4fO8QiFmE365rshazOhkty2ZRZrvRb1jmSHk5+ibptNl+u1oJ
 HycQUlqYMnMZrVk1yafpC7HlL8nUcYk5ns3254vAtW/PPm4vVLoKEp5hW
 bCF3vL3mr6VCrOa72MI885kskC7X0nNRBlhuUgAztgrn/aEfiecrMUZMZ
 iccdmfdLozttTQQxfOYK//EIbEL7UaTNKnrNXCGD99bet+v/kxqwndG1c
 lCo9T31aNhvmLN0HT9tk8aS43wn2tqJDDi2s7cwWJ9MXSCHqZhC54HOrU
 L7QPTk7emjQAcuIIgzjUcx5huEj8CtfsJJszkUvVI+CpMjqpjGQ1UVn9q g==;
X-CSE-ConnectionGUID: Yc7/iyd3TVmVSDR6c8u5Uw==
X-CSE-MsgGUID: /LKaZHxsQtebxv8E8pjpfg==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="88218167"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="88218167"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jul 2026 02:16:34 -0700
X-CSE-ConnectionGUID: 51iQhuGtTTeRtN83TYZEHw==
X-CSE-MsgGUID: z6W3QhQESkmevJoDehX0HA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="279911368"
Received: from unknown (HELO localhost.igk.intel.com) ([10.123.235.20])
 by fmviesa001.fm.intel.com with ESMTP; 13 Jul 2026 02:16:33 -0700
From: Dawid Wesierski <dawid.wesierski@intel.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, stephen@networkplumber.org,
 bruce.richardson@intel.com, marek.kasiewicz@intel.com,
 Dawid Wesierski <dawid.wesierski@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v6 1/2] doc: fix ice scheduler rate-limiter burst size
 description
Date: Mon, 13 Jul 2026 05:42:39 -0400
Message-ID: <20260713094240.1721105-2-dawid.wesierski@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260713094240.1721105-1-dawid.wesierski@intel.com>
References: <20260708231926.1550698-1-dawid.wesierski@intel.com>
 <20260713094240.1721105-1-dawid.wesierski@intel.com>
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

The paragraph describing the rl_burst_size devarg did not mention
that out-of-range values are rejected, which can otherwise look like
a silent no-op to a reader. Add a note that such values cause the
driver to fail to initialize, since ice_cfg_rl_burst_size() validates
the value and dev_probe() bails out with -EINVAL if it is rejected.

Fixes: b3f2afb3b7ea ("net/ice: add scheduler rate-limiter burst size devarg")

Signed-off-by: Dawid Wesierski <dawid.wesierski@intel.com>
---
 doc/guides/nics/ice.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/doc/guides/nics/ice.rst b/doc/guides/nics/ice.rst
index 5589ce934f..2f7c9e6f7c 100644
--- a/doc/guides/nics/ice.rst
+++ b/doc/guides/nics/ice.rst
@@ -164,6 +164,7 @@ Runtime Configuration
   Time-sensitive applications can lower this value to reduce Tx latency jitter
   at the cost of throughput by setting the ``rl_burst_size`` devargs parameter, in bytes.
   A value of ``0`` (the default) keeps the hardware default.
+  Values outside the range supported by the hardware cause the driver to fail to initialize.
 
   For example::
 
-- 
2.47.3

---------------------------------------------------------------------
Intel Technology Poland sp. z o.o.
ul. Slowackiego 173 | 80-298 Gdansk | Sad Rejonowy Gdansk Polnoc | VII Wydzial Gospodarczy Krajowego Rejestru Sadowego - KRS 101882 | NIP 957-07-52-316 | Kapital zakladowy 200.000 PLN.
Spolka oswiadcza, ze posiada status duzego przedsiebiorcy w rozumieniu ustawy z dnia 8 marca 2013 r. o przeciwdzialaniu nadmiernym opoznieniom w transakcjach handlowych.

Ta wiadomosc wraz z zalacznikami jest przeznaczona dla okreslonego adresata i moze zawierac informacje poufne. W razie przypadkowego otrzymania tej wiadomosci, prosimy o powiadomienie nadawcy oraz trwale jej usuniecie; jakiekolwiek przegladanie lub rozpowszechnianie jest zabronione.
This e-mail and any attachments may contain confidential material for the sole use of the intended recipient(s). If you are not the intended recipient, please contact the sender and delete all copies; any review or distribution by others is strictly prohibited.

