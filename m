Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A172C43327
	for <dpdk-dev@archiver.kernel.org>; Mon, 29 Jun 2026 15:06:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D6663402B5;
	Mon, 29 Jun 2026 17:06:40 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 02C8D40299
 for <dev@dpdk.org>; Mon, 29 Jun 2026 17:06:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782745600; x=1814281600;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=FRyb6gOHK9e/HxB/kgoo6yL4cjQHXaOdANF7qdu9YxI=;
 b=lIMmTDWfvHCo9Lfxt/R8BNA0+Gw2i+AAFrRfUfjuTY01MLD8LEFY8Mdx
 ZBiT77ThQjem2JsPU2Fz5jQ7M4iZcO1JwzzvI0dYbiKJ34d4rukY+hK32
 chblOJoOJ4BXcTrWKq/hbwptdtCoLc6wytc6veihxlSHyU/ffVi9J9Fa2
 DEcamVfSRw06GNLXUUuFj7Y26ijN43m8b4NWsPxI6OjTKJ8UCoLnzIY+I
 CRUDMm3LD15m1B+P76Qcr2jTXm0T9JN6z+AInfcYeAH0w530KfaYJ8zhI
 I3L5lO/QtBHaxl/byJjIE6ST8Rz/A+qhnkjZMg52PIj8ZY9N5CMO84K9g w==;
X-CSE-ConnectionGUID: /lS2GUjiTmiAkmy9u+pK5A==
X-CSE-MsgGUID: CBxltSGCQyW0vZDT0wk94w==
X-IronPort-AV: E=McAfee;i="6800,10657,11832"; a="87130823"
X-IronPort-AV: E=Sophos;i="6.24,232,1774335600"; d="scan'208";a="87130823"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jun 2026 08:06:39 -0700
X-CSE-ConnectionGUID: vOvQzm5DRgG6P5mbU7m0gw==
X-CSE-MsgGUID: 4r6O1Xf+Qh2J4yklEaBKNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,232,1774335600"; d="scan'208";a="253884878"
Received: from unknown (HELO localhost.igk.intel.com) ([10.123.235.20])
 by fmviesa004.fm.intel.com with ESMTP; 29 Jun 2026 08:06:36 -0700
From: Dawid Wesierski <dawid.wesierski@intel.com>
To: dev@dpdk.org
Cc: dawid.wesierski@intel.com, marek.kasiewicz@intel.com,
 stephen@networkplumber.org, bruce.richardson@intel.com
Subject: Tested the v3 series on Intel E810-C (Columbiaville) hardware.
Date: Mon, 29 Jun 2026 11:33:15 -0400
Message-ID: <20260629153315.1005879-1-dawid.wesierski@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260618144442.312844-8-dawid.wesierski@intel.com>
References: <20260618144442.312844-8-dawid.wesierski@intel.com>
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

app/testpmd: The 'create pinned-rxpool' command successfully creates 
   pinned external-buffer mempools for buffer-split segments.
 net/ice: The 'rl_burst_size' devarg correctly configures the scheduler 
   burst size, verified via debug traces.
net/iavf: The 'no_runtime_queue_setup' devarg successfully disables
   the advertisement of runtime queue setup capabilities.
net/iavf: Verified max ring descriptors increased to 8160.

Tested-by: Dawid Wesierski <dawid.wesierski@intel.com>
---------------------------------------------------------------------
Intel Technology Poland sp. z o.o.
ul. Slowackiego 173 | 80-298 Gdansk | Sad Rejonowy Gdansk Polnoc | VII Wydzial Gospodarczy Krajowego Rejestru Sadowego - KRS 101882 | NIP 957-07-52-316 | Kapital zakladowy 200.000 PLN.
Spolka oswiadcza, ze posiada status duzego przedsiebiorcy w rozumieniu ustawy z dnia 8 marca 2013 r. o przeciwdzialaniu nadmiernym opoznieniom w transakcjach handlowych.

Ta wiadomosc wraz z zalacznikami jest przeznaczona dla okreslonego adresata i moze zawierac informacje poufne. W razie przypadkowego otrzymania tej wiadomosci, prosimy o powiadomienie nadawcy oraz trwale jej usuniecie; jakiekolwiek przegladanie lub rozpowszechnianie jest zabronione.
This e-mail and any attachments may contain confidential material for the sole use of the intended recipient(s). If you are not the intended recipient, please contact the sender and delete all copies; any review or distribution by others is strictly prohibited.

