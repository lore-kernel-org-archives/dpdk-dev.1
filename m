Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D872C77B7F
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Jun 2025 10:19:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EB26E4064C;
	Fri, 27 Jun 2025 12:19:22 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 33CB640613;
 Fri, 27 Jun 2025 12:19:19 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55R1PXou013496;
 Fri, 27 Jun 2025 03:19:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=VEeDcoOMB5z3Tlb66mHd5Po
 9qQRA9sOGpv3o5MA7uY0=; b=D75mbqzu4/av59Kyo8b7vuFqd4Oz1ONo2OKPaX3
 GCAGNzDjHYb+SY16R4/hTBb7hrb/vNPIKWBR0DCzU347nd4DWbuQy7VPW6ZRB86D
 J7x11vz7I2aWtBA1bw1VQm++vwlgEt0a3/EUqqt/7l3gu+PgFarm5tUcme2Gumvq
 A8rWf4eGjNOUUqaOKVNLJ2TWmjBzuhNqHC64LiiuAGdQdjUy2u55nCbWr9fARmY6
 LsODaCfMBFOe45zmOLCeDmf4AI5zh5TBHf0lfgMMWS7QDqVq0EivNR/Z07MVNmLi
 4IiAGEo6Bc7jGAotC+qb+EXtSDEUB5QkE4MEQQo9/wtgl7A==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 47hfx693eg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 27 Jun 2025 03:19:18 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 27 Jun 2025 03:19:17 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 27 Jun 2025 03:19:17 -0700
Received: from hyd1smc1171.caveonetworks.com (unknown [10.29.44.112])
 by maili.marvell.com (Postfix) with ESMTP id 366CA5C68E3;
 Fri, 27 Jun 2025 03:19:14 -0700 (PDT)
From: Mohamed Feroz Abdul Majeeth <mabdulmajeet@marvell.com>
To: <dev@dpdk.org>
CC: <jerinj@marvell.com>, <vattunuru@marvell.com>, Mohamed Feroz Abdul Majeeth
 <mabdulmajeet@marvell.com>, <stable@dpdk.org>
Subject: [PATCH v0 1/1] net/octeon_ep: fix increase mbox timeout
Date: Fri, 27 Jun 2025 15:48:53 +0530
Message-ID: <20250627101853.5632-1-mabdulmajeet@marvell.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI3MDA4NCBTYWx0ZWRfX3avn4Fhlc35L
 QfowlhHlUY9yZWWq1IDgL0ubJCHN9vhP5LgjBkywhEczt6STLleebtBDFyxeMGU5oNmW7P7+HqB
 Lmtoy8VjsH93cdcscTTdXMeem5yy8SS7sNC45Fv7ArtnGANlaj/enBCuOPiCHmYJcHNN0FhrDv3
 dhhYq32GWluZMghk8Ry61Utao9PoVbYn8qkRxKUxw1S5Wxp7ZY88SMlb9/zaP3o5ZzCyCpTE3bK
 TMUeKaCST+dRdciFedgJ9rxhgwTqaIIVYAoeaONuetS4Ua3svDR6uW0FiwK9lVr8lhCsMmrLOLI
 UAHtduCnMxW0ifeNhMbGu4PDnk6+c2cOaQZPukmhmOq18bCSk4pPrB6oEn6WwcUsgBilA14fi0o
 kuv4YeDxw/TvefRTHr2+j5l4zyQjQ1gnj9Vorb6D7TLgGGYNkd16ugNFCR0C2MHI9ilxrJ7E
X-Proofpoint-GUID: DihjaV0epCo7cQwe3i-fm26De-X42cjP
X-Proofpoint-ORIG-GUID: DihjaV0epCo7cQwe3i-fm26De-X42cjP
X-Authority-Analysis: v=2.4 cv=N+4pF39B c=1 sm=1 tr=0 ts=685e7026 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=6IFa9wvqVegA:10 a=8rWy6zfcAAAA:8 a=M5GUcnROAAAA:8 a=QyXUC8HyAAAA:8
 a=KKAkSRfTAAAA:8 a=vggBfdFIAAAA:8 a=oCJs8q-oAAAA:8
 a=2GBw5BhrixcMllT8lyYA:9 a=YjdVzJdQTyZRADMV7wFX:22 a=OBjm3rFKGHvpk9ecZwUJ:22
 a=cvBusfyB2V15izCimMoJ:22 a=qUF70SbvcHBaGhGVny9j:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-27_03,2025-06-26_05,2025-03-28_01
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

Extend the mailbox timeout to 2500 ms in the Octeon driver
to ensure firmware responses are received, preventing premature
timeouts in mailbox request handling. This improves reliability
of control network APIs, addressing issues where the previous
timeout was too short for consistent operation.

Fixes: c836a7ba33ee ("net/octeon_ep: support mailbox between VF and PF")
Cc: stable@dpdk.org

Signed-off-by: Mohamed Feroz Abdul Majeeth <mabdulmajeet@marvell.com>
---
 .mailmap                            | 1 +
 drivers/net/octeon_ep/otx_ep_mbox.h | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index 8483d96ec5..753853b396 100644
--- a/.mailmap
+++ b/.mailmap
@@ -1850,3 +1850,4 @@ Ziye Yang <ziye.yang@intel.com>
 Zoltan Kiss <zoltan.kiss@schaman.hu> <zoltan.kiss@linaro.org>
 Zorik Machulsky <zorik@amazon.com>
 Zyta Szpak <zyta@marvell.com> <zr@semihalf.com> <zyta.szpak@semihalf.com>
+Mohamed Feroz Abdul Majeeth <mabdulmajeet@marvell.com>
diff --git a/drivers/net/octeon_ep/otx_ep_mbox.h b/drivers/net/octeon_ep/otx_ep_mbox.h
index 4f7afe7635..1a49780ce1 100644
--- a/drivers/net/octeon_ep/otx_ep_mbox.h
+++ b/drivers/net/octeon_ep/otx_ep_mbox.h
@@ -69,7 +69,7 @@ enum otx_ep_link_autoneg {
 	OTX_EP_LINK_AUTONEG,
 };
 
-#define OTX_EP_MBOX_TIMEOUT_MS     1200
+#define OTX_EP_MBOX_TIMEOUT_MS     2500
 #define OTX_EP_MBOX_MAX_RETRIES    2
 #define OTX_EP_MBOX_MAX_DATA_SIZE  6
 #define OTX_EP_MBOX_MAX_DATA_BUF_SIZE 256
-- 
2.34.1

