Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACE24C3ABC9
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 May 2025 20:45:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4BDAA4065C;
	Fri, 16 May 2025 22:45:45 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id A9F7B40615
 for <dev@dpdk.org>; Fri, 16 May 2025 22:45:42 +0200 (CEST)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 90A30201DB35; Fri, 16 May 2025 13:45:41 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 90A30201DB35
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1747428341;
 bh=SrIUYXA/uu1oPydNonwcf8EXu8nBT5831KYmJRJq/Wc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ZVujaS05WdGD1vH0lQa3BYjAO3BijDCuLOf/erPC+YVRfhiqA2FuJBnhFl5qMuMIZ
 LUaW6r6NCuBGWvdT7u4OK0Q42HVckMscWrqZ6APbiTNdujt+rlj2yR6J54kpO8V/8d
 z50nQ8q73BJ7LsToWCAqgzSTEECeElEYwsBlWeUI=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: andremue@linux.microsoft.com
Cc: dev@dpdk.org,
	vladimir.medvedkin@intel.com
Subject: [PATCH v5 0/2] enable fib to be compiled with MSVC
Date: Fri, 16 May 2025 13:45:33 -0700
Message-Id: <1747428335-3736-1-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1733281010-23780-1-git-send-email-andremue@linux.microsoft.com>
References: <1733281010-23780-1-git-send-email-andremue@linux.microsoft.com>
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

This patchset addresses the issues in lib/fib that were preventing
compilation with MSVC. The first patch removes a warning about
implicit 64-bit conversion, and the second patch enables the
compilation of fib with MSVC.

v5:
- enabled fib to be compiled with MSVC

Andre Muezerie (2):
  lib/fib: remove warning about implicit 64-bit conversion
  lib/fib: enable fib to be compiled with MSVC

 lib/fib/meson.build | 6 ------
 lib/fib/trie.c      | 2 +-
 2 files changed, 1 insertion(+), 7 deletions(-)

--
2.49.0.vfs.0.3

