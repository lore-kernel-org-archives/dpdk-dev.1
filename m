Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC5C2CD4F26
	for <dpdk-dev@archiver.kernel.org>; Fri, 19 Jun 2026 18:44:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 63C0540280;
	Fri, 19 Jun 2026 20:44:30 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id 52AE240279
 for <dev@dpdk.org>; Fri, 19 Jun 2026 20:44:29 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 11CC320001E;
 Fri, 19 Jun 2026 20:44:29 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id CCDBC200004;
 Fri, 19 Jun 2026 20:44:28 +0200 (CEST)
Received: from lsv03457.swis.in-blr01.nxp.com (lsv03457.swis.in-blr01.nxp.com
 [92.120.147.250])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 082C3180007B;
 Sat, 20 Jun 2026 02:44:27 +0800 (+08)
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org
Cc: hemant.agrawal@nxp.com
Subject: [PATCH 00/10] NXP ENETC driver related changes
Date: Sat, 20 Jun 2026 00:14:17 +0530
Message-Id: <20260619184427.522518-1-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
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

ENETC driver related changes series

Gagandeep Singh (8):
  net/enetc: fix TX BD structure
  net/enetc: fix TX BDs flag overwrite issue
  net/enetc: fix queue initialization
  net/enetc: support ESP packet type in packet parsing
  net/enetc: update random MAC generation code
  net/enetc: add option to disable VSI messaging
  net/enetc: add devargs to control VSI-PSI timeout and delay
  net/enetc4: add cacheable BD ring support with SW cache maintenance

Vanshika Shukla (2):
  net/enetc: support scatter-gather
  net/enetc: set user configurable priority to TX rings

 drivers/net/enetc/base/enetc_hw.h |  13 +-
 drivers/net/enetc/enetc.h         |  28 +-
 drivers/net/enetc/enetc4_ethdev.c | 123 +++++++--
 drivers/net/enetc/enetc4_vf.c     | 159 ++++++++++--
 drivers/net/enetc/enetc_ethdev.c  |  26 +-
 drivers/net/enetc/enetc_rxtx.c    | 411 ++++++++++++++++++++++++++----
 6 files changed, 649 insertions(+), 111 deletions(-)

-- 
2.25.1

