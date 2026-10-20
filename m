Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2A23606A321
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Oct 2026 15:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=LMCSNNpe
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E1EA540A87;
	Tue, 20 Oct 2026 17:21:46 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id CB8BA409FA
 for <dev@dpdk.org>; Tue, 20 Oct 2026 17:21:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792509705; x=1824045705;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=pxllPwiQBAshIAxvhKrFX03kwdtLMrYKRvCx3Qr/Y6I=;
 b=LMCSNNpeaV5n+7DJdv40PL081PorkLTS2zMRqcC5tNf3aWMG7CQEnDtu
 LGFolEIJcd9wOTTpc2KhARAYQ9LZvXPpRihujZTeqPL1b7iqYzk/sbbWO
 Go/6RFJMws2n+Tg8Mv8Jxyl51zi7UlCmVcUfsRy0eAB9BEKg+iGmj2A9P
 GCMb6tzCAOyB4YVMGtGCyY2QeUmop5NSIbFxEUC4WTtMKtx3eOcTh8xXa
 ok19DxvcQuEsjCmvjuDYPt9plquGX21lyUXraknw38OjVD4UkWaRg+5yx
 wnJb49KcrEIWWG5rXRpNsXeMx+X4eAAwuXafu8PGUOccZL8AvZdLTZJBc A==;
X-CSE-ConnectionGUID: figik4R6RzuEiEYFrVAlQw==
X-CSE-MsgGUID: 2fhsMg8RTp2M2GDDs6HR1Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1226888"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1226888"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Oct 2026 08:21:44 -0700
X-CSE-ConnectionGUID: fYODsirFTKWl8TYqMdrtQA==
X-CSE-MsgGUID: GOE2LVPRTUy0YKaL2P5Tbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="3241053"
Received: from mtldev4.igk.intel.com ([10.123.233.187])
 by orviesa010.jf.intel.com with ESMTP; 20 Oct 2026 08:21:43 -0700
From: Dawid Wesierski <dawid.wesierski@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, vladimir.medvedkin@intel.com,
 anatoly.burakov@intel.com, marek.kasiewicz@intel.com
Subject: Re: [PATCH] net/iavf: fix interrupt callback race on close
Date: Tue, 20 Oct 2026 15:22:32 +0000
Message-ID: <20261020152232.2599084-1-dawid.wesierski@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261014122427.631805-1-dawid.wesierski@intel.com>
References: <20261014122427.631805-1-dawid.wesierski@intel.com>
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

Recheck-request: rebase=main, iol-compile-amd64-testing, iol-unit-amd64-testing

The failures come from the baseline, not from this patch. The Windows
clang build stops on -Wsign-compare in
drivers/net/intel/i40e/i40e_flow_fdir.c:901 and :948 of next-net-intel
b39ee12b030f. The current next-net-intel has a uint8_t raw_id there,
and this patch applies to it, and to main, with no change.
---------------------------------------------------------------------
Intel Technology Poland sp. z o.o.
ul. Slowackiego 173 | 80-298 Gdansk | Sad Rejonowy Gdansk Polnoc | VII Wydzial Gospodarczy Krajowego Rejestru Sadowego - KRS 101882 | NIP 957-07-52-316 | Kapital zakladowy 200.000 PLN.
Spolka oswiadcza, ze posiada status duzego przedsiebiorcy w rozumieniu ustawy z dnia 8 marca 2013 r. o przeciwdzialaniu nadmiernym opoznieniom w transakcjach handlowych.

Ta wiadomosc wraz z zalacznikami jest przeznaczona dla okreslonego adresata i moze zawierac informacje poufne. W razie przypadkowego otrzymania tej wiadomosci, prosimy o powiadomienie nadawcy oraz trwale jej usuniecie; jakiekolwiek przegladanie lub rozpowszechnianie jest zabronione.
This e-mail and any attachments may contain confidential material for the sole use of the intended recipient(s). If you are not the intended recipient, please contact the sender and delete all copies; any review or distribution by others is strictly prohibited.

