Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0CF1C36010
	for <dpdk-dev@archiver.kernel.org>; Wed,  9 Apr 2025 01:21:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AED5F402C5;
	Wed,  9 Apr 2025 03:21:06 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id CE080402D7
 for <dev@dpdk.org>; Wed,  9 Apr 2025 03:21:04 +0200 (CEST)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id EA3972113E97; Tue,  8 Apr 2025 18:21:03 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EA3972113E97
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1744161663;
 bh=3Xy5twV4bZtsekm1fM7YsLDuwjlTUwb+58Kxus1DD4w=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=i/Zouh5K8VSLBXWRcm27HmotC6vCInHGUoQIOBfcewX1dOJ5XGiUOIXfifcOTiouj
 3ljrsgZ1SXt4yTm8LnjzT0MJ6N29K0rZOQe9Wzcv/Cm+D2I6KqH1NeiaGIUmcqntlT
 jk2A1KKqRS9qG6zzk9ltthZuoMG6lEIyM2IA087M=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: andremue@linux.microsoft.com
Cc: bruce.richardson@intel.com, dev@dpdk.org, sameh.gobriel@intel.com,
 vladimir.medvedkin@intel.com, yipeng1.wang@intel.com
Subject: [PATCH v5 0/3] fix how large numbers are printed by hash tests
Date: Tue,  8 Apr 2025 18:20:55 -0700
Message-Id: <1744161658-7874-1-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1741291408-26509-1-git-send-email-andremue@linux.microsoft.com>
References: <1741291408-26509-1-git-send-email-andremue@linux.microsoft.com>
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

v5:
 - Rebased and updated to conform to new function versioning mechanism.

v4:
 - Added parameter "unit", which allows rte_size_to_str() to be smarter
   about the need to append a space after the number. This keeps the
   function easy to use and avoids the need for complex explanations
   about the space that could be needed between number and multiple/unit.
 - Changed the return type of rte_size_to_str() to be buf, or NULL on
   error, allowing the function to be inlined.
 - Removed a line wrap.

 v3:
 - Added rte_size_to_str to version.map (marked experimental for 25.07) so
   that symbol gets exported when building with -Ddefault_library=shared
 - Added sample outputs
 - Added a space between the number and the postfix (if a postfix is
   present)

Andre Muezerie (3):
  eal: add function rte_size_to_str
  hash_multiwriter_autotest: fix printf parameters
  hash_readwrite_autotest: fix printf parameters

 app/test/test_hash_multiwriter.c       | 14 +++++--
 app/test/test_hash_readwrite.c         | 14 ++++++-
 lib/eal/common/eal_common_string_fns.c | 54 ++++++++++++++++++++++++++
 lib/eal/include/rte_common.h           | 34 ++++++++++++++++
 4 files changed, 111 insertions(+), 5 deletions(-)

--
2.49.0.vfs.0.0

