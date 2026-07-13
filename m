Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1CB1C43458
	for <dpdk-dev@archiver.kernel.org>; Mon, 13 Jul 2026 09:17:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4E09540B8D;
	Mon, 13 Jul 2026 11:16:55 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id EE05F4067C
 for <dev@dpdk.org>; Mon, 13 Jul 2026 11:16:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783934214; x=1815470214;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=pbMU30aDIUJ1puFyFSukc+Zi5rzRTLWGHZrn/JOHft0=;
 b=PJ5C61qWFxlBUsi4aC8Ioi34clT/KkrWOKKndvsAzu6sjg7oAFiQnlmv
 FtrCeWFGQB2iiRPtmX02LIopJDsZYWRCnTWJr/xaJaswXoUp+E1/Of2l8
 ERnA5MW8jp1fnkritmOvlEcU2k0xtpyNUNUo78tQDclbNU8uvFXRrrPea
 R1CmXWUGJCia7rJnltwc3yU7sgBjqz5BEM4D8MkuS22qz2zvF4bc+s3Bi
 ZoEiBYaX8WH4bzfRpc4UJdq9m+kgKOzzhQP6SoS9TY6nJhEC4h1Vh4P28
 zlgn1cAQEL6uSNW/pSqEp+/xa+l8ulXALQm3tcnvtvlKtk5Ij0fC2uBLh A==;
X-CSE-ConnectionGUID: eWviatd2Q5KiwlEPx47DYA==
X-CSE-MsgGUID: idlKG3UxRsOEVhiVZdaHzQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="88218201"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="88218201"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jul 2026 02:16:53 -0700
X-CSE-ConnectionGUID: OarAlvnRRDqNMjF2qDWehg==
X-CSE-MsgGUID: sMF+vmkdQfyFhGtaWk9XVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="279911391"
Received: from unknown (HELO localhost.igk.intel.com) ([10.123.235.20])
 by fmviesa001.fm.intel.com with ESMTP; 13 Jul 2026 02:16:52 -0700
From: Dawid Wesierski <dawid.wesierski@intel.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, stephen@networkplumber.org,
 bruce.richardson@intel.com, marek.kasiewicz@intel.com,
 Dawid Wesierski <dawid.wesierski@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v6 1/2] doc: fix ice scheduler rate-limiter burst size
 description
Date: Mon, 13 Jul 2026 05:42:57 -0400
Message-ID: <20260713094259.1721234-2-dawid.wesierski@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260713094259.1721234-1-dawid.wesierski@intel.com>
References: <20260708231926.1550698-1-dawid.wesierski@intel.com>
 <20260713094259.1721234-1-dawid.wesierski@intel.com>
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

