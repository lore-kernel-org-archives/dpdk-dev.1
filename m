Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C1A606A320
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Oct 2026 15:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=K7TMSu+I
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1FDB740A79;
	Tue, 20 Oct 2026 17:21:44 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id 49CF84069F;
 Tue, 20 Oct 2026 17:21:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792509702; x=1824045702;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=6jSh+U9Dkvnud8E9A09F9L9awcrFD+qjVlgW8tWUcEI=;
 b=K7TMSu+IQcO72pDF880Q7YGjMziU89fcJQOHZkpLx3t/mosdsZz6tzRr
 HVvH3riCIaI0jLUBJ/sn+Q1qgErxoeibGFv2UhN4WlICGvVznCE3cgs6R
 uj0lcFsTS1Pd6484gtMrwOhQcIl4IzMGGCmRVI14inj1fa+DY4FPpWIPY
 ECf3tXvrDIdp/LYU+nWrHCRqYRxjmuDTFHAgjb1V0Tt4otCX2IhsG6D0R
 l+a8ZIsdie+vRJwGai8E343t9r1v5eB49bEsO8sCgjwwdEua2nvAy7P6P
 UxVf2eXfaKei/kDEWbb5QiEz8/Y3BjXFu4Y7unu9wbwfkgG3nY+YFR143 Q==;
X-CSE-ConnectionGUID: vjoxSGrPTmOY6lmFCoV65A==
X-CSE-MsgGUID: M41AyDTWQWi0jWva/WhEXA==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1226882"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1226882"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Oct 2026 08:21:41 -0700
X-CSE-ConnectionGUID: 7DyqWLU1TzmELTSTpDdsug==
X-CSE-MsgGUID: +lhx74msQ/qDQ8NYEPTs5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="3241044"
Received: from mtldev4.igk.intel.com ([10.123.233.187])
 by orviesa010.jf.intel.com with ESMTP; 20 Oct 2026 08:21:40 -0700
From: Dawid Wesierski <dawid.wesierski@intel.com>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, vladimir.medvedkin@intel.com, anatoly.burakov@intel.com,
 marek.kasiewicz@intel.com, stable@dpdk.org
Subject: Re: [PATCH 2/3] net/iavf: fix bandwidth config of unshaped queues
Date: Tue, 20 Oct 2026 15:22:29 +0000
Message-ID: <20261020152229.2599038-1-dawid.wesierski@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <atc1dgrGiIpn3APl@bricha3-mobl1.ger.corp.intel.com>
References: <20261014122419.631288-3-dawid.wesierski@intel.com>
 <atc1dgrGiIpn3APl@bricha3-mobl1.ger.corp.intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Oct 20, 2026 at 10:33:42AM +0100, Bruce Richardson wrote:
> I find the commit log of this patch a bit confusing to read and understand.
> I asked AI to try and make things clearer and it suggests this as a
> rewording, which I personally find clearer. WDYT?

Agreed, your text is clearer. v2 uses it with no change.

Dawid
---------------------------------------------------------------------
Intel Technology Poland sp. z o.o.
ul. Slowackiego 173 | 80-298 Gdansk | Sad Rejonowy Gdansk Polnoc | VII Wydzial Gospodarczy Krajowego Rejestru Sadowego - KRS 101882 | NIP 957-07-52-316 | Kapital zakladowy 200.000 PLN.
Spolka oswiadcza, ze posiada status duzego przedsiebiorcy w rozumieniu ustawy z dnia 8 marca 2013 r. o przeciwdzialaniu nadmiernym opoznieniom w transakcjach handlowych.

Ta wiadomosc wraz z zalacznikami jest przeznaczona dla okreslonego adresata i moze zawierac informacje poufne. W razie przypadkowego otrzymania tej wiadomosci, prosimy o powiadomienie nadawcy oraz trwale jej usuniecie; jakiekolwiek przegladanie lub rozpowszechnianie jest zabronione.
This e-mail and any attachments may contain confidential material for the sole use of the intended recipient(s). If you are not the intended recipient, please contact the sender and delete all copies; any review or distribution by others is strictly prohibited.

