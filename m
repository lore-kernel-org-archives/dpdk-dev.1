Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFD84C5AE59
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Jun 2025 14:47:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 38F3240270;
	Thu,  5 Jun 2025 16:47:30 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id B1B4A40150
 for <dev@dpdk.org>; Thu,  5 Jun 2025 16:47:28 +0200 (CEST)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id E6E37201FF21; Thu,  5 Jun 2025 07:47:27 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E6E37201FF21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1749134847;
 bh=uKqTF2G2tWKKm9h70BlpcCJdSRRp5XUt+gR4wBjSzcY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=jEQ4PSaUi6e5I4iIzwCkTnab+ZG/89YVwj65sKJuug9dIx9hMryWipfUu3knumqGJ
 ZhUlbMEB+pvEucrKu1C41rolkB5Hj8D/FHuG69kiOXNjWB1GIXEERsEbGfvX44IWgc
 uut4oErir9kCAqezybZhKM15HbcPY4GkEc4LCDXo=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: andremue@linux.microsoft.com
Cc: dev@dpdk.org,
	mb@smartsharesystems.com
Subject: [PATCH v6 0/1] define __builtin_add_overflow for MSVC
Date: Thu,  5 Jun 2025 07:47:24 -0700
Message-Id: <1749134845-30062-1-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1735857169-19131-1-git-send-email-andremue@linux.microsoft.com>
References: <1735857169-19131-1-git-send-email-andremue@linux.microsoft.com>
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

__builtin_add_overflow is gcc specific. A macro needs to be defined
for code using this to be compiled with MSVC.
Since only one driver is using this, this patch adds the macro to
that driver only. It can be moved to some common place if/when
needed.

v6:
- Moved definition of __builtin_add_overflow to the only driver that
  needs it, making it private to that driver.

v5:
- Combined patches 1 with 5 and 2 with 3.

v4:
- Added define in ice_osdep.h to use portable version of
  __builtin_add_overflow when using MSVC.
- Undid all changes from drivers/net/intel/ice/base/ice_nvm.c.

v3:
- Rebase on top of latest main.

Andre Muezerie (1):
  net/intel: define __builtin_add_overflow for MSVC

 drivers/net/intel/ice/base/ice_osdep.h | 9 +++++++++
 1 file changed, 9 insertions(+)

--
2.49.0.vfs.0.3

