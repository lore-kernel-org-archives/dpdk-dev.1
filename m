Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67360C5DF94
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Aug 2026 23:45:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2A3934060C;
	Sat, 22 Aug 2026 01:45:20 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id 1D30440289
 for <dev@dpdk.org>; Sat, 22 Aug 2026 01:45:16 +0200 (CEST)
Received: from localhost.localdomain (unknown [78.109.67.244])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id 62ED9E039D;
 Sat, 22 Aug 2026 03:45:14 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am 62ED9E039D
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1787355914;
 bh=TdaLkx6Vv5E9COi185HSao/o13ZOTkfjg6kcdx87nqo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Dax2nssllgZI8GhvlUXM4O2R7Yd17o0qHzdws0hRasfeQqYdEhOiMtdF1Jwso5tZd
 mFtnqUfsJOq/TgbzpKlUl0Y7akYZz1zlQXt0YZpv2gLLh05Prd6yF2ApxFrXwATdfJ
 J+XbOcNU8bdrOUIIWbmqBi0a/h9+B+czqvu0d45M+6/lE/3HRm11fvUbXJazvCVxCI
 9XKq0vFJATRzz7BzA/ZTHP+MEAeeD9ZNsGYJjZIhumTFT7ZrJp8htdTvYKRyjI6K3V
 Oa5K1FWwCoerPemg9Qvrb3zTwBzWX2MUDl8JY2h7XH2SK8CA+5/qer79NgQOZT+nFl
 pk5tj0z3l9xZg==
From: Ivan Malov <ivan.malov@arknetworks.am>
To: dev@dpdk.org
Cc: Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>,
 Roman Zhukov <Roman.Zhukov@arknetworks.am>,
 Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH v2 0/2] net/sfc: fix and extend secondary process support
Date: Sat, 22 Aug 2026 03:45:04 +0400
Message-ID: <20260821234506.12049-1-ivan.malov@arknetworks.am>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260820130314.12251-1-ivan.malov@arknetworks.am>
References: <20260820130314.12251-1-ivan.malov@arknetworks.am>
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


v2:

- addressed https://mails.dpdk.org/archives/dev/2026-August/343941.html


Ivan Malov (2):
  net/sfc: fix shared adapter pointer set in secondary process
  net/sfc: provide cached dev info to use in secondary process

 drivers/net/sfc/sfc.h        | 19 ++++++++++++++
 drivers/net/sfc/sfc_ethdev.c | 50 ++++++++++++++++++++++++++++++++++++
 2 files changed, 69 insertions(+)

-- 
2.47.3

