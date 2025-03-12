Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACBF3C28B28
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Mar 2025 19:28:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7B37D40663;
	Wed, 12 Mar 2025 20:28:46 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 31A27402D3
 for <dev@dpdk.org>; Wed, 12 Mar 2025 20:28:44 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 599DB210B157; Wed, 12 Mar 2025 12:28:43 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 599DB210B157
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1741807723;
 bh=SHvbSJLTm7l7VaWqrMNd5Z47AiBj2lT2we7AoBTDYFI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=bAmbs3O+zZCH6uKTQXThI2qbs31C8DluAsimtuNrV9+Tbrx5vKWFHexxpbFaC0jTB
 wTzX/nzWxeIz8sR76pJiFhz9culRDRohWGG2hhhdgAR/i28Z+3w1j7wkA5c/JQ1vaL
 ruU99tihO+STjHmJKronqxHMjNWBWyUuWBRFgyQc=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: andremue@linux.microsoft.com
Cc: bruce.richardson@intel.com, dev@dpdk.org, sameh.gobriel@intel.com,
 vladimir.medvedkin@intel.com, yipeng1.wang@intel.com
Subject: [PATCH v3 0/3] fix how large numbers are printed by hash tests
Date: Wed, 12 Mar 2025 12:28:31 -0700
Message-Id: <1741807714-26748-1-git-send-email-andremue@linux.microsoft.com>
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

 app/test/test_hash_multiwriter.c       | 13 ++++++--
 app/test/test_hash_readwrite.c         | 13 ++++++--
 lib/eal/common/eal_common_string_fns.c | 44 ++++++++++++++++++++++++++
 lib/eal/include/rte_common.h           | 31 ++++++++++++++++++
 lib/eal/version.map                    |  3 ++
 5 files changed, 99 insertions(+), 5 deletions(-)

--
2.48.1.vfs.0.1

