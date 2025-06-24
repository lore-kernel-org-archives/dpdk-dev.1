Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63E1AC77B7C
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Jun 2025 08:03:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 838224064E;
	Tue, 24 Jun 2025 10:03:44 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id C2A4440264
 for <dev@dpdk.org>; Tue, 24 Jun 2025 10:03:43 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 8617C20849;
 Tue, 24 Jun 2025 10:03:43 +0200 (CEST)
Received: from dkrd4.smartsharesys.local ([192.168.4.26]) by
 smartserver.smartsharesystems.com with Microsoft SMTPSVC(6.0.3790.4675); 
 Tue, 24 Jun 2025 10:03:40 +0200
From: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
To: Tyler Retzlaff <roretzla@linux.microsoft.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>, Tomasz Duszynski <tduszynski@marvell.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Thomas Monjalon <thomas@monjalon.net>, dev@dpdk.org
Cc: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
Subject: [PATCH v3 0/3] handle sysconf(_SC_PAGESIZE) negative return value
Date: Tue, 24 Jun 2025 08:03:30 +0000
Message-ID: <20250624080333.127618-1-mb@smartsharesystems.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250610131348.248800-1-mb@smartsharesystems.com>
References: <20250610131348.248800-1-mb@smartsharesystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 24 Jun 2025 08:03:40.0711 (UTC)
 FILETIME=[7F4BD370:01DBE4DE]
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

Coverity reports some defects, where the root cause seems to be negative
return value from sysconf(_SC_PAGESIZE) not being handled.
This series addresses those defects in the DPDK libraries.

PS: "_SC_PAGESIZE" has the alias "_SC_PAGE_SIZE". Both are covered here.

Morten Brørup (3):
  eal/unix: fix log message for madvise() failure
  eal: handle sysconf(_SC_PAGESIZE) negative return value
  pmu: handle sysconf(_SC_PAGESIZE) negative return value

 lib/eal/freebsd/eal.c          |  3 ++-
 lib/eal/freebsd/eal_memory.c   |  7 +++----
 lib/eal/linux/eal.c            |  3 ++-
 lib/eal/unix/eal_unix_memory.c | 16 ++++++++++++++--
 lib/pmu/pmu.c                  | 32 ++++++++++++++++++++++++++++++--
 lib/vhost/vduse.c              |  3 ++-
 6 files changed, 53 insertions(+), 11 deletions(-)

-- 
2.43.0

