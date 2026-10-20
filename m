Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69E94606A327
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Oct 2026 15:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=PM80prL8
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2EF084068E;
	Tue, 20 Oct 2026 17:21:42 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id 3708440A67
 for <dev@dpdk.org>; Tue, 20 Oct 2026 17:21:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792509700; x=1824045700;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=RaymeAWLux5G5szYZbVnUCJ8F7wAj4vKe6YV6dq+a0E=;
 b=PM80prL8F8vro0Fl0K7zKTEgAZ2S8JWkWZf9tGMVHx+WhjVuAoyIZ8up
 oXgHdDJODhpSewL4rxbyFUnDHZZdzRBRK2LacWu051eL2d8E4D0bjM+wE
 sIwbj4vXLxeFyH83NdHl+Gc73MT0bWCb8pHQGAEX205nLl0V0ym+r2Ojn
 kS2+jX0kcg8yfho3rRSVkBFTaZ7PtPmpW99rPoR2jW0oaCEzNP6dgZ7vx
 iiQkRB3BXd7bbx541F4V5WAYJ3rjFkrziLRw9Y9OfeGlAqDJ0VvPsHUXy
 /CTD2+fLMvAhh/kLEcI1EqvTikMPrCwMraj9j72vajgdELjDXOGoGNysw w==;
X-CSE-ConnectionGUID: 8i9kRLHOTZa/edNjWP5MdA==
X-CSE-MsgGUID: 8c0iFpYhQ3SHHENNV6DoyQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1226877"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1226877"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Oct 2026 08:21:39 -0700
X-CSE-ConnectionGUID: BgIm/KkESJyy/ijuFf2qoA==
X-CSE-MsgGUID: oXpQvr7HSVKfdRfdOAwxOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="3241036"
Received: from mtldev4.igk.intel.com ([10.123.233.187])
 by orviesa010.jf.intel.com with ESMTP; 20 Oct 2026 08:21:38 -0700
From: Dawid Wesierski <dawid.wesierski@intel.com>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, vladimir.medvedkin@intel.com, anatoly.burakov@intel.com,
 marek.kasiewicz@intel.com
Subject: Re: [PATCH 1/3] net/iavf: fix invalid free of queue TC map
Date: Tue, 20 Oct 2026 15:22:27 +0000
Message-ID: <20261020152227.2599008-1-dawid.wesierski@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <atZOKGtUlpulSC11@bricha3-mobl1.ger.corp.intel.com>
References: <20261014122419.631288-2-dawid.wesierski@intel.com>
 <atZJlMewvnJu781L@bricha3-mobl1.ger.corp.intel.com>
 <atZOKGtUlpulSC11@bricha3-mobl1.ger.corp.intel.com>
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

On Mon, Oct 19, 2026 at 06:06:48PM +0100, Bruce Richardson wrote:
> AI review flags the fact that this commit also introduces an erroneous
> rte_free call in iavf_uninit_vf() in iavf_ethdev.c. While the call is
> harmless (and earler free is done and the pointer is set to NULL making
> rte_free a no-op) it would be good to remove that too.

Thanks, Bruce. Yes, f6e33f09f766 added that rte_free() after the
free() and the NULL that the leak fix had put there. v2 removes it in
the same patch, and the commit message tells it.

I tested v2 with an ASan build of testpmd on an E830 VF: hierarchy
commit, port stop, port reset, port start, and close. There is no ASan
report, and the VF advertises runtime queue setup again after the
reset.

Dawid
---------------------------------------------------------------------
Intel Technology Poland sp. z o.o.
ul. Slowackiego 173 | 80-298 Gdansk | Sad Rejonowy Gdansk Polnoc | VII Wydzial Gospodarczy Krajowego Rejestru Sadowego - KRS 101882 | NIP 957-07-52-316 | Kapital zakladowy 200.000 PLN.
Spolka oswiadcza, ze posiada status duzego przedsiebiorcy w rozumieniu ustawy z dnia 8 marca 2013 r. o przeciwdzialaniu nadmiernym opoznieniom w transakcjach handlowych.

Ta wiadomosc wraz z zalacznikami jest przeznaczona dla okreslonego adresata i moze zawierac informacje poufne. W razie przypadkowego otrzymania tej wiadomosci, prosimy o powiadomienie nadawcy oraz trwale jej usuniecie; jakiekolwiek przegladanie lub rozpowszechnianie jest zabronione.
This e-mail and any attachments may contain confidential material for the sole use of the intended recipient(s). If you are not the intended recipient, please contact the sender and delete all copies; any review or distribution by others is strictly prohibited.

