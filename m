Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04B17C5DF9C
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Aug 2026 16:30:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 164A140270;
	Mon, 24 Aug 2026 18:30:38 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id 53E8F400D6
 for <dev@dpdk.org>; Mon, 24 Aug 2026 18:30:36 +0200 (CEST)
Received: from localhost.localdomain (unknown [78.109.64.182])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id 9C30DE0753;
 Mon, 24 Aug 2026 20:30:35 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am 9C30DE0753
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1787589036;
 bh=huOR+oMTGHYCzgG1QBWV/ddtqeL2hmiBD1AwQg8AqKA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=gmaT9+WnQE/J+xjUh/FQFK2haEsM1ofPUAdfvwX4XGnGvNnTRedFb7SrnbKyUOqz3
 JSv6UjcocBSkg03O2TJE6ZwAZ4FSbLIPJUY0/JlXkajziHiSWbYQSw7mxLlm3yym1h
 zyvh0igGImtoOVREmzV0u9TMyTlAGzXfxF+wxYyW9Lx9+dxP4u897Aq0/7FoYAl/uZ
 FOIy4SZv0AH8t7MofLaEXNKFiZHK/iSl9TBwKr4b+kh3Yh9G6oHg7+GMAYZoGUHNFD
 2Bz/VVN/kf9UVVUCnqrWSA+nSWcHRU7Gf8kp4w8GrZm8ifCldEM1v8ztZw+r6lGFkG
 3C+BOlASrzS6w==
From: Ivan Malov <ivan.malov@arknetworks.am>
To: dev@dpdk.org
Cc: Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>,
 Roman Zhukov <Roman.Zhukov@arknetworks.am>,
 Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH v4 0/2] net/sfc: fix and extend secondary process support
Date: Mon, 24 Aug 2026 20:30:31 +0400
Message-ID: <20260824163033.31893-1-ivan.malov@arknetworks.am>
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


v4:

- addressed https://mails.dpdk.org/archives/dev/2026-August/344068.html


v3:

- cosmetic fix


v2:

- addressed https://mails.dpdk.org/archives/dev/2026-August/343941.html


Ivan Malov (2):
  net/sfc: fix shared adapter pointer set in secondary process
  net/sfc: provide cached dev info to use in secondary process

 drivers/net/sfc/sfc.h        | 19 ++++++++++++++
 drivers/net/sfc/sfc_ethdev.c | 49 ++++++++++++++++++++++++++++++++++++
 2 files changed, 68 insertions(+)

-- 
2.47.3

