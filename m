Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 199CBCCD193
	for <dpdk-dev@archiver.kernel.org>; Mon, 20 Oct 2025 14:08:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E61F3402C6;
	Mon, 20 Oct 2025 16:08:14 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id D80E3400D6
 for <dev@dpdk.org>; Mon, 20 Oct 2025 16:08:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760969294; x=1792505294;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=+5rH/ywScVZpzkBcRa/pMBI1kUry4d2vTF+Nuoo8bBw=;
 b=MH1zA4rlOn13F67e1GhunbbShJ9rBA4JSHZf5MkeHYKYBcf+rb1ejhm8
 5dSilNMXZ5w4DfGnEWKt0J/U/f1cVpdfvJ3Zm8XD1cRFdV0t/RGY9xceb
 S7He+aRbtjus7qYwg0jP31KS3OxxU0eFeOQt99sjROmdYRMkeDmegl2o8
 TfrekqPq7muRyorP3MpZd2ULHxQ326cXD8a1scU3CukADJvcAQQvNXR6A
 IghNdW0bm/MalQmsGStox26FRbzedvCNbbG7/6iW0bEN4s+v42yyB1aR5
 pyeDuQf4ZGn/dxuO/HDc3ailKmRrzjkVmiAsCFOMzqCusCoQ796LikXxs Q==;
X-CSE-ConnectionGUID: wNT3lJxsQnmpn/DLDjMKnA==
X-CSE-MsgGUID: FGOB8nAqSke7+mKom4QyOA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63179538"
X-IronPort-AV: E=Sophos;i="6.19,242,1754982000"; d="scan'208";a="63179538"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Oct 2025 07:08:13 -0700
X-CSE-ConnectionGUID: ss8I9Aw0Tfi3h7jmH/fttw==
X-CSE-MsgGUID: lMIB49RaSPqa5aLDOpYD7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,242,1754982000"; d="scan'208";a="220487472"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa001.jf.intel.com with ESMTP; 20 Oct 2025 07:08:10 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v4 0/2] improve mailmap file
Date: Mon, 20 Oct 2025 15:08:00 +0100
Message-ID: <20251020140805.1361249-1-bruce.richardson@intel.com>
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

V4: minor changes based on more feedback:
 - sort imports alphabetically
 - remove unused "operations" map

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
 devtools/mailmap_ctl.py | 209 +++++++++++++++++++++++
 2 files changed, 387 insertions(+), 178 deletions(-)
 create mode 100755 devtools/mailmap_ctl.py

--
2.48.1

