Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08251CCD195
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Oct 2025 13:56:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 428D5427AA;
	Fri, 17 Oct 2025 15:56:29 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id 609C740269
 for <dev@dpdk.org>; Fri, 17 Oct 2025 15:56:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760709388; x=1792245388;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=WrHh3kp775esaGcPGOK9npFGbWcMb6ye380kWe3CvDI=;
 b=FHXn38W4RfTbCvlIhFgeOQVYacfZaE5pgHwppMu1FQDzCl7ow4L+7nZH
 yG1ICsfxfgmSCVdSkIBDip0b1MHoARAkLL0rjAc1btkZ2Ewc+0FaVhPeS
 wc0Q3TZO9qBXagHxbK6IL1eBw70Nubxg1AphGjGNEpbVJHkR2Cc1ZNlgj
 BdYTDvMZdhmKk5M1bDcP4dL0iQl4Ni0nd+d4q5WRtpaZ2g/37+UpvHq+B
 S/qf9PNQnm/jrwCQCKVXCufD3vIZBDxUW883rSuGaIb2tWHAhbvmimVkS
 U1E2IsZPEglUDeDthyjfxb66ZcrGhCE+QsYczQFqzjA8Jm9TrCBmy6NEe g==;
X-CSE-ConnectionGUID: B8f3p+j4Sj+Jo8uQCon3qQ==
X-CSE-MsgGUID: jQKjmGfKT4OxULIJF9ap0w==
X-IronPort-AV: E=McAfee;i="6800,10657,11585"; a="73522787"
X-IronPort-AV: E=Sophos;i="6.19,236,1754982000"; d="scan'208";a="73522787"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Oct 2025 06:56:27 -0700
X-CSE-ConnectionGUID: yCNAdmsVSQy11OAeMaQaCQ==
X-CSE-MsgGUID: bwYKB40/TIieuGYQ3ojDqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,236,1754982000"; d="scan'208";a="181878236"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa006.jf.intel.com with ESMTP; 17 Oct 2025 06:56:26 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH 0/2] format telemetry scripts using black
Date: Fri, 17 Oct 2025 14:56:20 +0100
Message-ID: <20251017135622.1152341-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
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

Run "black" tool on the dpdk-telemetry scripts to enforce coding style for python scripts.

Bruce Richardson (2):
  usertools/dpdk-telemetry: correct script formatting
  usertools/dpdk-telemetry-client: correct script formatting

 usertools/dpdk-telemetry-client.py | 49 +++++++++-------
 usertools/dpdk-telemetry.py        | 90 +++++++++++++++++-------------
 2 files changed, 79 insertions(+), 60 deletions(-)

--
2.48.1

