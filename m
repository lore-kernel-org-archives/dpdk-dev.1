Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FC00CCD195
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Oct 2025 14:19:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8EB9C427DD;
	Fri, 17 Oct 2025 16:19:34 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id 6F5B740269
 for <dev@dpdk.org>; Fri, 17 Oct 2025 16:19:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760710772; x=1792246772;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=+s8XUS83Fxp/nGmxofHVbwxjQXkqX3k7WhR1MV0QfTc=;
 b=j3vudUi01mk9rV09oHuCiachMlj5BKQmBVhvWtxHffd1Efi0n4oy11lw
 6HQYele8Nw5ibWAnJwmZzEo3ncCPgEkRiOG8FneEMMnomaFKJ4JhNVDWF
 FX3j9MJyvHG6cV4zxoYppGQHz/yvmqe4gi5Y2uYAhcXVcDVQc28tF+HDs
 xTiW8XbT08vU9O2JS3gTp7yqU6g8sfVb/sR+o+G9cVeWZK4CGKk6rpUQZ
 Ks5eXdXZtLG18drPUQWESyu1vSm7e6HANq3VusETGEtp6592foBK5nl3Y
 UPvfiLld24dwVJzz7sj7XXHxUs+255hDAQpGQ2Y/L4yfJ0FOttSl9EYJn g==;
X-CSE-ConnectionGUID: ZTb+wu39QTC5LBUx6E9UfA==
X-CSE-MsgGUID: +T0x8zkWQy6x06C2QyFzqA==
X-IronPort-AV: E=McAfee;i="6800,10657,11585"; a="63011636"
X-IronPort-AV: E=Sophos;i="6.19,236,1754982000"; d="scan'208";a="63011636"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Oct 2025 07:19:31 -0700
X-CSE-ConnectionGUID: uPAeDIawSPW6brdh90RmIA==
X-CSE-MsgGUID: LZGhlWfMSEqTu5StqlsLLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,236,1754982000"; d="scan'208";a="187840831"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa005.jf.intel.com with ESMTP; 17 Oct 2025 07:19:30 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2 0/2] format telemetry scripts using black
Date: Fri, 17 Oct 2025 15:19:25 +0100
Message-ID: <20251017141927.1156370-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251017135622.1152341-1-bruce.richardson@intel.com>
References: <20251017135622.1152341-1-bruce.richardson@intel.com>
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

Run "black" tool on the dpdk-telemetry scripts to enforce coding style
for python scripts.

V2:
* use correct baseline of "main" for patches

Bruce Richardson (2):
  usertools/dpdk-telemetry.py: correct script formatting
  usertools/dpdk-telemetry-client: correct script formatting

 usertools/dpdk-telemetry-client.py | 49 +++++++++--------
 usertools/dpdk-telemetry.py        | 86 ++++++++++++++++--------------
 2 files changed, 75 insertions(+), 60 deletions(-)

--
2.48.1

