Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EF90C282DE
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Mar 2025 16:51:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7DD8C4114B;
	Thu, 13 Mar 2025 17:51:55 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id B0F7C41141
 for <dev@dpdk.org>; Thu, 13 Mar 2025 17:51:54 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id EA4862033424; Thu, 13 Mar 2025 09:51:53 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EA4862033424
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1741884713;
 bh=KSdPnmxiVxgsKcEOO7NgptOl6tn5BUaJcH/8bQE5yGA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=qYQQWQ9fwdB0dZTRCTFcwH12rGZQREXk33Ljf3CZq6v7xhQIMo+p/Jqi5vIJA5prv
 0pms4DMXWGjNXYRs5khcbmuL0O/zNh7IK+krwkGSf2p35aL/kIGONvIf+9ZqnBehVt
 NN0tm/9bIbLbkjlnQli3OzLiAyIltxBoFfPS579c=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: andremue@linux.microsoft.com
Cc: bruce.richardson@intel.com, dev@dpdk.org, sameh.gobriel@intel.com,
 vladimir.medvedkin@intel.com, yipeng1.wang@intel.com
Subject: [PATCH v4 0/3] fix how large numbers are printed by hash tests
Date: Thu, 13 Mar 2025 09:51:43 -0700
Message-Id: <1741884706-21546-1-git-send-email-andremue@linux.microsoft.com>
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
 lib/eal/common/eal_common_string_fns.c | 53 ++++++++++++++++++++++++++
 lib/eal/include/rte_common.h           | 34 +++++++++++++++++
 lib/eal/version.map                    |  3 ++
 5 files changed, 113 insertions(+), 5 deletions(-)

--
2.48.1.vfs.0.1

