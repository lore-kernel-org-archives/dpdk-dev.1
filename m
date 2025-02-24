Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27024C021A4
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Feb 2025 15:26:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4309F41104;
	Mon, 24 Feb 2025 16:26:22 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 86AC1410D5
 for <dev@dpdk.org>; Mon, 24 Feb 2025 16:26:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740410781; x=1771946781;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=A3gtq+NDigxHfwKi89feWpqJWpQyqHCJ9aPWhh4ProM=;
 b=Dt2t+JzvKib0DE2sjyOLiXNpcco8PlSpiZqCJ5uLNmhYnJ0XaCmHNDY1
 6c0rbaTgIlEbR7Mx/N+J1UdP2AKNWdi8QV5a1MVYzenh9ocl4qlEoYBvn
 j7oYypWm7SOfRRY8FowLd7s9KaLD6o1t7RoWlFoBcpBkwt6wfoThBjyHT
 d94d2o8gjO6AD015yXieG9l+Q9t4BSp15/+NdQ8IK63dr3YGkys0j85zD
 /eGtjXHcX8LIwdnjREqy4OgPLch2MBD58g8gIXu3U5kIMQEY+jj7UzEvn
 ltp3T1Bn9LZ3IezsE4GHBDBdxZmaII+L20YR5Es2RVP156md0SJDZ88uB Q==;
X-CSE-ConnectionGUID: qrMh7kG7SguV1BvPOir6Vg==
X-CSE-MsgGUID: fopfm9uvR6CnUUxRpScQGw==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="44823605"
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; d="scan'208";a="44823605"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Feb 2025 07:26:19 -0800
X-CSE-ConnectionGUID: rbimZYwPQqOM4CFag0BJyQ==
X-CSE-MsgGUID: 9wBF5sTKR7qhhoBlG8wrGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; d="scan'208";a="116107643"
Received: from unknown (HELO silpixa00401385.ir.intel.com) ([10.237.214.22])
 by fmviesa007.fm.intel.com with ESMTP; 24 Feb 2025 07:26:17 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Ian Stokes <ian.stokes@intel.com>, John McNamara <john.mcnamara@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH 0/3] improve documentation iavf driver
Date: Mon, 24 Feb 2025 15:26:04 +0000
Message-ID: <20250224152611.1012935-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.43.0
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

Some small cleanups and reformatting of the iavf driver documentation
to make it easier to read. Also add an additional note on large VF
support.

Bruce Richardson (3):
  doc/nics: improve structure of Intel VF section
  doc/nics: rework notes for iavf use
  doc/nics: document how to create large VFs for iavf

 doc/guides/nics/intel_vf.rst | 83 +++++++++++++++++++++++-------------
 1 file changed, 53 insertions(+), 30 deletions(-)

--
2.43.0

