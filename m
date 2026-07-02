Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2251AC43458
	for <dpdk-dev@archiver.kernel.org>; Thu,  2 Jul 2026 04:06:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B4BD4402C5;
	Thu,  2 Jul 2026 06:06:13 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id C25EA402A3;
 Thu,  2 Jul 2026 06:06:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782965172; x=1814501172;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=mQbMode/aJjkTNEAVWmfk/E9ZfQLX1sYGPJ2h37hPDA=;
 b=acQgo4Tl/O2rtj1ngnto0v4slQUA6Zt12FywQ4LviQeOSjpTQgq8OKyi
 esUl0E/0TpWtkkFyz/1Z7/QBk/X994LPgNLxcppKdGC6qMT/HQwFwH68F
 dLB68yxl8QPlqAjRLFVyEvB9/LiqCav9a4c3FzzR/O0rUr+XPFiCnmdAx
 hQezihYMxwAGXh1QUbhb8u3iAkG2i0pxYqWGhTqgKCUQKo59hdhY8o0JN
 aCKwEBNRnCD+YlgvXmL3KvgE4ki6Bvf7WgXKD9o5GCQWivpo9IZM/Y5ca
 GLmydVP2yCH1ewRpT+HanzLc83GRibR3b5akurRRws0nVDa5eV5WD0a30 w==;
X-CSE-ConnectionGUID: zjwPuHcMQQ6nw0//XxbkqA==
X-CSE-MsgGUID: hZz69ZmsRoGSK66uQuRkOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11834"; a="83838273"
X-IronPort-AV: E=Sophos;i="6.25,143,1779174000"; d="scan'208";a="83838273"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jul 2026 21:06:11 -0700
X-CSE-ConnectionGUID: ookr9G8sRXOVyliL1Ta5cA==
X-CSE-MsgGUID: cuUw0bLYS+GMInc6hI3Axw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,143,1779174000"; d="scan'208";a="248768505"
Received: from smserver2row47.iind.intel.com ([10.138.138.56])
 by fmviesa010.fm.intel.com with ESMTP; 01 Jul 2026 21:06:08 -0700
From: Pushpendra Kumar <pushpendra1x.kumar@intel.com>
To: dev@dpdk.org
Cc: pushpendra.kumar@tieto.com, reshma.pattan@intel.com,
 stephen@networkplumber.org, stable@dpdk.org
Subject: Re: [PATCH] pdump: fix request timeout on unresponsive secondary
Date: Thu,  2 Jul 2026 09:31:38 +0530
Message-ID: <20260702040140.634986-1-pushpendra1x.kumar@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260701060257.562895-1-pushpendra1x.kumar@intel.com>
References: <20260701060257.562895-1-pushpendra1x.kumar@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Hi all,

Please hold review of this patch for now.

While validating this approach, I found a race condition in ENABLE/DISABLE forwarding behavior. In the DISABLE path, a delayed forwarded secondary (S2) can crash if requester-side teardown in S1 (the secondary that initiates DISABLE) proceeds first and shared resources are released.

I reproduced this with dpdk-dumpcap by injecting delay on S2. In my setup, it appears around the 5-second timeout mark (similar to MP_TIMEOUT_S), but the issue is about ordering and lifecycle guarantees, not a specific delay value or application.

The same teardown-safety risk can also exist in the original behavior if a secondary handles DISABLE late enough that the control plane fails or times out, and requester-side teardown still proceeds.

The root issue is:
- If S2 is slow/unresponsive on DISABLE, requester-side DISABLE can fail/timeout.
- If S1 app ignores that failure and frees shared capture resources anyway, S2 may still touch stale pointers and crash.
- So the root issue is teardown safety after failed/partial DISABLE completion, not only async forwarding itself.

I am pausing this patch to investigate a cleaner lifecycle fix for the DISABLE path. I will send a v2 after a more robust solution is verified.

Suggestions and feedback are very welcome.

Best regards,
Pushpendra
