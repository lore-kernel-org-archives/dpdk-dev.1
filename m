Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15B2EC36014
	for <dpdk-dev@archiver.kernel.org>; Tue,  1 Apr 2025 15:01:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E5ACF40E1C;
	Tue,  1 Apr 2025 17:00:59 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 8FF6440275
 for <dev@dpdk.org>; Tue,  1 Apr 2025 17:00:57 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 5E53F237EC;
 Tue,  1 Apr 2025 17:00:56 +0200 (CEST)
Received: from dkrd4.smartsharesys.local ([192.168.4.26]) by
 smartserver.smartsharesystems.com with Microsoft SMTPSVC(6.0.3790.4675); 
 Tue, 1 Apr 2025 17:00:55 +0200
From: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
To: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Bruce Richardson <bruce.richardson@intel.com>, dev@dpdk.org
Cc: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
Subject: [PATCH v2 0/4] mempool perf test: test random bulk sizes
Date: Tue,  1 Apr 2025 15:00:44 +0000
Message-ID: <20250401150049.4968-1-mb@smartsharesystems.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250228164858.274204-1-mb@smartsharesystems.com>
References: <20250228164858.274204-1-mb@smartsharesystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 01 Apr 2025 15:00:56.0178 (UTC)
 FILETIME=[DEE5ED20:01DBA316]
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

Bulk requests to get or put objects in a mempool often vary in size.
A series of tests with pseudo random request sizes, to mitigate the
benefits of the CPU's dynamic branch predictor, was added.

Also, various other minor changes:
- Improved the output formatting for readability.
- Added test for the "default" mempool with cache.
- Skip the tests for the "default" mempool, if it happens to use the same
  driver (i.e. operations) as already tested.
- Replaced bare use of "unsigned" with "unsigned int",
  to make checkpatches happy.

v3:
* Fix code style for checking variable is set or zero. (Andrew Rybchenko)
v2:
* Split patch into individual patches. (Andrew Rybchenko)

Morten Brørup (4):
  mempool perf test: replace bare unsigned with unsigned int
  mempool perf test: test default mempool with cache
  mempool perf test: improve output readability
  mempool perf test: test random bulk sizes

 app/test/test_mempool_perf.c | 222 +++++++++++++++++++++++++++--------
 1 file changed, 173 insertions(+), 49 deletions(-)

-- 
2.43.0

