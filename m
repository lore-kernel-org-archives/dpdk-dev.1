Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C177606A324
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Nov 2026 10:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=lp329+PN
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 97E4F40264;
	Mon,  2 Nov 2026 11:35:20 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTPS id E93DC4003C
 for <dev@dpdk.org>; Mon,  2 Nov 2026 11:35:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793615719; x=1825151719;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Ap0VIthrOb/O06g6e5ymyIcWnfLZg/P8vKG60LruhMY=;
 b=lp329+PNMlTAvOaDiuKOfv9vDwp5xfH2gftfV6J/HmZmf6I6VxZGalOx
 s4C2RdQCaHs/ir6Je3oz4ykkfZnRiVw67VK4cj89XiY9R+ypNzNCOi6zG
 aOItPB9kVj0eUpTQScEk1TYMSp1fXCKjL6IohX6DEelw74UHnlSYi1+Sh
 CqtrivptUOPlJrY7R2Qoe+7SDcqpcAg0MTvM0NqNkUq+CSEiTOly6Ea+K
 H4MOnnqX3Cmlil7mcORLh2qokY7HTW5GnlIY6VHDXRbnunsh4EfnSflP8
 QmcPnbSidJtRjdBsnLmKnyCjCvjHquhjaExsX96RLo9ikQLBCQpgY1+TS A==;
X-CSE-ConnectionGUID: vOSqXngBQeehRl/D61/+yQ==
X-CSE-MsgGUID: MHF7bgmuS1CSlvMaC/+R5Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11953"; a="2295634"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2295634"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2026 02:35:17 -0800
X-CSE-ConnectionGUID: eAI4hLZQQJ+P6trCkLMIcg==
X-CSE-MsgGUID: IdPowMwWRimeuEe8ztjpFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="7881900"
Received: from mtldev4.igk.intel.com ([10.123.233.187])
 by fmviesa011.fm.intel.com with ESMTP; 02 Nov 2026 02:35:16 -0800
From: Dawid Wesierski <dawid.wesierski@intel.com>
To: dev@dpdk.org
Cc: stephen@networkplumber.org
Subject: Re: [PATCH 3/3] pcapng: add user-supplied timestamp support
Date: Mon,  2 Nov 2026 10:35:57 +0000
Message-ID: <20261102103557.2059495-1-dawid.wesierski@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261020175732.1552406-4-stephen@networkplumber.org>
References: <20261020175732.1552406-4-stephen@networkplumber.org>
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
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Thanks, Stephen.

The proposed rte_pcapng_copy_ts() API matches the interface used by MTL. OpenVisualCloud/Media-Transport-Library#1849 checks MTL's packet timestamp output.

I have no objections to patch 3/3.
---------------------------------------------------------------------
Intel Technology Poland sp. z o.o.
ul. Slowackiego 173 | 80-298 Gdansk | Sad Rejonowy Gdansk Polnoc | VII Wydzial Gospodarczy Krajowego Rejestru Sadowego - KRS 101882 | NIP 957-07-52-316 | Kapital zakladowy 200.000 PLN.
Spolka oswiadcza, ze posiada status duzego przedsiebiorcy w rozumieniu ustawy z dnia 8 marca 2013 r. o przeciwdzialaniu nadmiernym opoznieniom w transakcjach handlowych.

Ta wiadomosc wraz z zalacznikami jest przeznaczona dla okreslonego adresata i moze zawierac informacje poufne. W razie przypadkowego otrzymania tej wiadomosci, prosimy o powiadomienie nadawcy oraz trwale jej usuniecie; jakiekolwiek przegladanie lub rozpowszechnianie jest zabronione.
This e-mail and any attachments may contain confidential material for the sole use of the intended recipient(s). If you are not the intended recipient, please contact the sender and delete all copies; any review or distribution by others is strictly prohibited.

