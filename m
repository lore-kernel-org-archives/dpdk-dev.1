Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACB7DC43458
	for <dpdk-dev@archiver.kernel.org>; Wed,  8 Jul 2026 22:52:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 71D0740268;
	Thu,  9 Jul 2026 00:52:30 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id 774D740265
 for <dev@dpdk.org>; Thu,  9 Jul 2026 00:52:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783551149; x=1815087149;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ebcduRmT94WT1JJVsqilAXvPWh5Ei/ftM1K1PApc1Pw=;
 b=fFaZnRbpgON8JR23lLYCk86aRjtI5u5/qZedHemf/JH6VD2LDKvpI3Wy
 aTf9XEQgpW4n2IFe4UXF+DoSATRBZsg9fwmRvzbP5hswTw5uujxhOI/tn
 gauav9abyOpm5iFQmvoeiuPel3xabSUYDCZEuBIPTDgKMsMnmwI09xmfJ
 /eRb7jFNIX6jrsgL8tlDCO5b8R2WSu2pN2efumZtGWtcoOmDGAWehfr/3
 vPQ1hLCxtRsU2kg9Eqb+wnpdyovfcWqnaT+p2m3LI39bXRr8d9RWqqvOR
 2IZWOcsj66F6O6pW+XCiFPR5GrEoPpjJhQN2NU5eQSD0TXNDI37fE04uL A==;
X-CSE-ConnectionGUID: nLwFx0ojTxSOzNXdpEfv1w==
X-CSE-MsgGUID: hKdZ4xDdRDG4wtiUNnYegg==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="88051202"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="88051202"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jul 2026 15:52:28 -0700
X-CSE-ConnectionGUID: GkmvGaIPS1241pdofTgstQ==
X-CSE-MsgGUID: w22rYqIDS5Kj2+EZrW6BzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; d="scan'208";a="259313116"
Received: from unknown (HELO localhost.igk.intel.com) ([10.123.235.20])
 by fmviesa005.fm.intel.com with ESMTP; 08 Jul 2026 15:52:26 -0700
From: Dawid Wesierski <dawid.wesierski@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, thomas@monjalon.net,
 stephen@networkplumber.org, marek.kasiewicz@intel.com
Subject: Re: [PATCH v3 5/6] net/iavf: disable runtime queue setup capability
Date: Wed,  8 Jul 2026 19:18:45 -0400
Message-ID: <20260708231845.1549877-1-dawid.wesierski@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260630120657.1046588-6-dawid.wesierski@intel.com>
References: <20260630120657.1046588-6-dawid.wesierski@intel.com>
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

Thanks for the review, Bruce.

> Do we really need a commandline arg for this? If it's known enough to have
> the extra arg passed at device init, is it not also known enough to have
> the app not do dynamic reconfiguration in the first place?
>
> Alternatively, if the user configures packet pacing through rte_tm, can we
> not at that point adjust the driver to disallow runtime config by returning
> -ENOTSUP when reconfig is attempted, and no longer advertising the capabilities?
> Runtime configuration, whether with or without user interaction, should be
> preferred over devargs whenever possible.
>
> /Bruce

Agreed. v5 drops the no_runtime_queue_setup devarg entirely.
iavf_dev_info_get() now only advertises RTE_ETH_DEV_CAPA_RUNTIME_RX_QUEUE_SETUP
and RTE_ETH_DEV_CAPA_RUNTIME_TX_QUEUE_SETUP while no per-queue bandwidth
rte_tm hierarchy is committed; once one is committed, the capabilities are
withdrawn and the ethdev layer rejects a subsequent rx/tx_queue_setup() call
on a running port with -EBUSY, re-advertising automatically once the
hierarchy is torn down. No application opt-in is required anymore.

v5 (2 patches, replacing v4 3/5 and 4/5) is posted separately.

/Dawid
---------------------------------------------------------------------
Intel Technology Poland sp. z o.o.
ul. Slowackiego 173 | 80-298 Gdansk | Sad Rejonowy Gdansk Polnoc | VII Wydzial Gospodarczy Krajowego Rejestru Sadowego - KRS 101882 | NIP 957-07-52-316 | Kapital zakladowy 200.000 PLN.
Spolka oswiadcza, ze posiada status duzego przedsiebiorcy w rozumieniu ustawy z dnia 8 marca 2013 r. o przeciwdzialaniu nadmiernym opoznieniom w transakcjach handlowych.

Ta wiadomosc wraz z zalacznikami jest przeznaczona dla okreslonego adresata i moze zawierac informacje poufne. W razie przypadkowego otrzymania tej wiadomosci, prosimy o powiadomienie nadawcy oraz trwale jej usuniecie; jakiekolwiek przegladanie lub rozpowszechnianie jest zabronione.
This e-mail and any attachments may contain confidential material for the sole use of the intended recipient(s). If you are not the intended recipient, please contact the sender and delete all copies; any review or distribution by others is strictly prohibited.

