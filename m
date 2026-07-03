Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC8D4C43458
	for <dpdk-dev@archiver.kernel.org>; Fri,  3 Jul 2026 19:35:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 751C5402C5;
	Fri,  3 Jul 2026 21:35:00 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id 47CD84026F
 for <dev@dpdk.org>; Fri,  3 Jul 2026 21:34:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783107299; x=1814643299;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=GnEEg6bphTUL44TooxJ8E6rTNO/jU8Aijq84llb/bFU=;
 b=mZ4DuqnlpbFRB4UCtUxWUNA9/bDVArCVf+gxMdKa82bgJrRzksA3eez0
 cCvVq9eP5XeCHNWxj1W+UA5k/OhZZ+nTtNW6ufjDXr7c0JV2ZetUMKDk0
 alKxq9gMrSio5Abm1+g7almnRwEtcoRMI1cmY5W0mVUIt66HhxcLPzTks
 bAousPWhfgR/On4Ph+InNYXoNRzGCp1yXiBySc0pZxW2j6+QiumMVCst6
 MU3HinOkDIADzPnThcaff4gRtYDD4umRJ27gP9ljohKaHMnURs5xSvQRy
 jCe/A3BSlGLEZk2ljWmQIrlvHFY84Splr9vmqlLgg0Hz+sXJmbbwD5Mp1 g==;
X-CSE-ConnectionGUID: t2YAWA7yT7i01LyzA8XQnw==
X-CSE-MsgGUID: jwHR4XQISF+VPuXcQ6Qx+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11836"; a="94217170"
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; d="scan'208";a="94217170"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2026 12:34:58 -0700
X-CSE-ConnectionGUID: Kxp8i5hqTKW4KgSnKPg/bg==
X-CSE-MsgGUID: 9OCkssisQBmopx3JyhKpvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; d="scan'208";a="252114006"
Received: from unknown (HELO localhost.igk.intel.com) ([10.123.235.20])
 by orviesa010.jf.intel.com with ESMTP; 03 Jul 2026 12:34:57 -0700
From: Dawid Wesierski <dawid.wesierski@intel.com>
To: dawid.wesierski@intel.com
Cc: dev@dpdk.org,
	bruce.richardson@intel.com
Subject: Re: [PATCH v3 4/6] net/ice: timestamp all received packets when PTP
 is enabled
Date: Fri,  3 Jul 2026 16:00:29 -0400
Message-ID: <20260703200128.1364461-1-dawid.wesierski@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260630120657.1046588-5-dawid.wesierski@intel.com>
References: <20260630120657.1046588-5-dawid.wesierski@intel.com>
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

I agree with Bruce's.
Mislabeling all packets with the PTP flag (RTE_MBUF_F_RX_IEEE1588_PTP) is incorrect.

The goal is to provide hardware timestamps for all received traffic (for high-resolution packet capture),
the existing RTE_ETH_RX_OFFLOAD_TIMESTAMP offload flag is the appropriate way to achieve this.
I am testing the "proper" way and it seems to be working, will drop this patch from the series.
---------------------------------------------------------------------
Intel Technology Poland sp. z o.o.
ul. Slowackiego 173 | 80-298 Gdansk | Sad Rejonowy Gdansk Polnoc | VII Wydzial Gospodarczy Krajowego Rejestru Sadowego - KRS 101882 | NIP 957-07-52-316 | Kapital zakladowy 200.000 PLN.
Spolka oswiadcza, ze posiada status duzego przedsiebiorcy w rozumieniu ustawy z dnia 8 marca 2013 r. o przeciwdzialaniu nadmiernym opoznieniom w transakcjach handlowych.

Ta wiadomosc wraz z zalacznikami jest przeznaczona dla okreslonego adresata i moze zawierac informacje poufne. W razie przypadkowego otrzymania tej wiadomosci, prosimy o powiadomienie nadawcy oraz trwale jej usuniecie; jakiekolwiek przegladanie lub rozpowszechnianie jest zabronione.
This e-mail and any attachments may contain confidential material for the sole use of the intended recipient(s). If you are not the intended recipient, please contact the sender and delete all copies; any review or distribution by others is strictly prohibited.

