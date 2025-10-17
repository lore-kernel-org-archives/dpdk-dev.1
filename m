Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95743CCD195
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Oct 2025 13:38:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AA75A40A7A;
	Fri, 17 Oct 2025 15:38:20 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id D7D0940269
 for <dev@dpdk.org>; Fri, 17 Oct 2025 15:38:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760708299; x=1792244299;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=jUzB1YN0SD/K/S2Oqq3Ph7/C7+ht+e/5xJ9TgcIX+SQ=;
 b=NJ6vGPkcL2Y81mRkUOeIh26sbpz80mukQ4qmAD77ug+abirwbSXznGe9
 9sLn2g6LXts/9M4hRQjjHGQE8zevXV4GqG04+c4HETw9yUaSX1LnAup3a
 ztYZx2bbM/NMschQIywDwvqNItXa+2+Voe5/zmYcvhiXHI7hSnXo4iuG6
 2UQXxv7QM2V2GjDi13Gmj/e1TDidIcKK71AFYYzWh1t48f3glFT7NPMVm
 j1pp3mYfDSftcuk95cpaRtPwNwwi49FMtCPeyFpk4qpWawuYVmlq6J/yY
 2+Hv0dZsEOXimCTCLUhdj20IeOfy52Xs7HkCUlbMj2cixNlxBFT8uEh3w w==;
X-CSE-ConnectionGUID: +FCInIE7TWqopuxzUupZyA==
X-CSE-MsgGUID: nlNaOFDRTAyrcw0KftA9rQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11585"; a="74262092"
X-IronPort-AV: E=Sophos;i="6.19,236,1754982000"; d="scan'208";a="74262092"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Oct 2025 06:38:18 -0700
X-CSE-ConnectionGUID: VvtpUAyORyydzbFZff4dug==
X-CSE-MsgGUID: yR1uloyLTku0A9gPd7HfRA==
X-ExtLoop1: 1
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa003.fm.intel.com with ESMTP; 17 Oct 2025 06:38:17 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: rjarry@redhat.com,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v3 0/2] Improve mailmap file
Date: Fri, 17 Oct 2025 14:38:06 +0100
Message-ID: <20251017133812.1109638-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250808142721.408998-1-bruce.richardson@intel.com>
References: <20250808142721.408998-1-bruce.richardson@intel.com>
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

The mailmap file in DPDK is not always correctly sorted, and standard
cmdline sorting tools don't always do the job correctly. To improve
things, add a new script to devtools for working with the mailmap file,
to make it easier to add new entries in the correct place, to check the
file for correctness, and lastly to sort the file in place (hopefully a
one-off operation).

Once that is done, commit the changes to the mailmap file to ensure it
is correctly sorted in the repository.

V3:
* feedback from Robin's review:
  - used builtin type annotations
  - used argparse subparsers and callbacks for individual commands
* re-sorted latest mailmap in patch 2

V2:
* address multiple feedback items on V1.
* fix bug whereby adding an extra actually sorted the whole file

Bruce Richardson (2):
  devtools/mailmap_ctl: script to work with mailmap
  mailmap: sort mailmap

 .mailmap                | 356 ++++++++++++++++++++--------------------
 devtools/mailmap_ctl.py | 211 ++++++++++++++++++++++++
 2 files changed, 389 insertions(+), 178 deletions(-)
 create mode 100755 devtools/mailmap_ctl.py

--
2.48.1

