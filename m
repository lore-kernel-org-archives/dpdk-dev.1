Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65DA5C5DF88
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Aug 2026 13:03:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6E29E40664;
	Thu, 20 Aug 2026 15:03:26 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id 32C7E40150
 for <dev@dpdk.org>; Thu, 20 Aug 2026 15:03:24 +0200 (CEST)
Received: from localhost.localdomain (unknown [78.109.79.191])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id 92B3FE07BF;
 Thu, 20 Aug 2026 17:03:22 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am 92B3FE07BF
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1787231003;
 bh=wH9Qd3e6k7uFTZjlXMdc1UbeV/LkI4c2HHZUvVmedoc=;
 h=From:To:Cc:Subject:Date:From;
 b=T+j8BVNZpolSPrGvTquhIlgOJFW7ux9c3HU6h6TlKGbLCDldASFy3Gg6Pqjd7VZ5M
 Bsc7l5wElraRJBf5UoOCcaACIzla13wsQfty3SN0g519K9IVfK03tkFR9hjvVVD44h
 LHzyMEyJoslvsiweI/mJu/+Xd1nmNS7WPshLJygG0HqiSY4GhuEuDz8Gtii1/Wisoy
 Nzk3yg1qNPOkW4VN62uVKpOekZk6wghz5/SuTMDahhbNif6aBuKGwQT2v3f+hXiNCJ
 MAz0RDp91nFEXw/4AxPFx3u4pL8qbKYYipFPm8JwRLzpfQ/4xdmYTuNNjADZJcKNoJ
 zwycicQWIFWRA==
From: Ivan Malov <ivan.malov@arknetworks.am>
To: dev@dpdk.org
Cc: Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>,
 Roman Zhukov <Roman.Zhukov@arknetworks.am>,
 Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH 0/2] net/sfc: fix and extend secondary process support
Date: Thu, 20 Aug 2026 17:03:12 +0400
Message-ID: <20260820130314.12251-1-ivan.malov@arknetworks.am>
X-Mailer: git-send-email 2.47.3
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

The series addresses two secondary process deficiencies.

Patch 1 adds a missing shared adapter pointer assignment to
the secondary process init path, preventing a NULL pointer
dereference at device close time.

Patch 2 pre-populates a primary-process device info cache
to satisfy the 'dev_infos_get' requirement now imposed by
the 'test-pmd' application on secondary processes.


Ivan Malov (2):
  net/sfc: fix shared adapter pointer set in secondary process
  net/sfc: provide cached dev info to use in secondary process

 drivers/net/sfc/sfc.h        |  7 +++++++
 drivers/net/sfc/sfc_ethdev.c | 30 ++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+)

-- 
2.47.3

