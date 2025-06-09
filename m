Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40717C5B552
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Jun 2025 10:40:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8676040E17;
	Mon,  9 Jun 2025 12:40:45 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id E287140658
 for <dev@dpdk.org>; Mon,  9 Jun 2025 12:40:43 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5597RWsZ004582
 for <dev@dpdk.org>; Mon, 9 Jun 2025 03:40:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=fET6sv8MZoTfmjiyDTN9Ox9
 WmHJCTU2JHYAhSnIo++s=; b=lGi4nstKNZH2u4plmIEv2ON5QuW76xcSPkdLReK
 00/btr0RzylYXq/Hb/Oe3eOv9QPwyfS+pDca4hMFsI6bE97N8S8L5xES/CsRufxq
 qU9lH8f1+BsPjXnGBB0c+3ft2+ZLzS1hv1cbXiQaseDjweZGn1f/D5DlyvodU5Gn
 BuVluY0rMvjf5BgvniDrx88IEbUJEn0oBmOU/YgfQKcmsYCmod3o6cp6OUa1GyPo
 08q9YGMfkUzMxlykT6WIwQ7vCc+tff7dnEnbqS3K7tX6WHGcxTD4CXLjUpbfpoty
 PfmiMy3DwfzDqWzY56KE0YMQ6Ihm8n1BeMAQqVEEH1reutQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 475u84g9na-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 09 Jun 2025 03:40:42 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 9 Jun 2025 03:40:42 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 9 Jun 2025 03:40:42 -0700
Received: from hyd1554.caveonetworks.com (unknown [10.29.56.32])
 by maili.marvell.com (Postfix) with ESMTP id C3C5A3F707D;
 Mon,  9 Jun 2025 03:40:39 -0700 (PDT)
From: Tejasree Kondoj <ktejasree@marvell.com>
To: Akhil Goyal <gakhil@marvell.com>
CC: Anoob Joseph <anoobj@marvell.com>, Nithinsen Kaithakadan
 <nkaithakadan@marvell.com>, Rupesh Chiluka <rchiluka@marvell.com>, "Vidya
 Sagar Velumuri" <vvelumuri@marvell.com>, <dev@dpdk.org>
Subject: [PATCH v2 0/7] fixes and new features to cnxk crypto PMD
Date: Mon, 9 Jun 2025 16:10:31 +0530
Message-ID: <20250609104038.3102767-1-ktejasree@marvell.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=CLoqXQrD c=1 sm=1 tr=0 ts=6846ba2b cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=6IFa9wvqVegA:10 a=dLGLtkjP_ksHsy5g4tYA:9
X-Proofpoint-ORIG-GUID: Z34fHot9EAHR30hnmmusa9EbJdBK225Q
X-Proofpoint-GUID: Z34fHot9EAHR30hnmmusa9EbJdBK225Q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA5MDA4MSBTYWx0ZWRfX/Zo+3Wd2cymx
 4Y+b7yiBV3XsgMMcRnWVdCG8o2R1vq2pO1qJetxnJqStA2yGb4n7NhGMwei86fwENHw4Cp6PkpM
 ghUPEtgs81dtLydaVQWy1+J1CIJV9VErvF86R1hiMSDpsz37GjrviXOaa5juFjiWpQMGfCc+Jpr
 zieC5elNFEzJm3kxwNh3xjbdbc/Cg1OHu/gEcPDP0pxKKV0tByAXVWCxTqEIs6aAoyBdRdeuhfc
 4qmSI+a23dwFazcDLOLTOgAxVskF0Q9OYQoCBvDCiVjVziu+Pi4nQV418LWbzIjiV4sSLnba3cg
 QuDQHzj7xZVeSQFpnkBMYSCmfcmvfMoSQCq83qndY0QK6vUmLFR/Yco1HxDeDI6umM3UOFO7oBk
 Ic0k5LyNTZ+rDxOkkBJ4gs2YQM6d3jGM+BgDOw0CeFkX2sAsTjh5UxQ5nJpkSa6bbT4VzTRx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-09_04,2025-06-05_01,2025-03-28_01
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

This series adds fixes and new features to cnxk crypto PMD.

v2:
* Combined few patches into one.
* Updated patch titles and description.
* Updated doc and release notes.

Nithinsen Kaithakadan (3):
  common/cnxk: fix salt handling with aes-ctr
  common/cnxk: update qsize in CPT iq enable
  crypto/cnxk: copy 8B iv into sess in aes ctr

Rupesh Chiluka (2):
  crypto/cnxk: extend check for max supported gather entries
  crypto/cnxk: support asymmetric sessionless mode

Tejasree Kondoj (2):
  crypto/cnxk: fix compilation error
  crypto/cnxk: add meta variable in CPT structure

 doc/guides/cryptodevs/features/cn10k.ini  |  1 +
 doc/guides/cryptodevs/features/cn9k.ini   |  1 +
 doc/guides/rel_notes/release_25_07.rst    |  1 +
 drivers/common/cnxk/cnxk_security.c       |  8 ++
 drivers/common/cnxk/roc_cpt.c             |  5 ++
 drivers/common/cnxk/roc_cpt_sg.h          |  1 +
 drivers/crypto/cnxk/cn10k_cryptodev_ops.c | 91 +++++++++++++++++++++--
 drivers/crypto/cnxk/cn10k_ipsec_la_ops.h  | 17 ++++-
 drivers/crypto/cnxk/cn10k_tls_ops.h       | 10 +++
 drivers/crypto/cnxk/cn20k_ipsec_la_ops.h  | 17 ++++-
 drivers/crypto/cnxk/cn20k_tls_ops.h       | 10 +++
 drivers/crypto/cnxk/cn9k_cryptodev_ops.c  | 77 ++++++++++++++++++-
 drivers/crypto/cnxk/cn9k_ipsec_la_ops.h   | 10 +++
 drivers/crypto/cnxk/cnxk_cryptodev.c      |  3 +-
 drivers/crypto/cnxk/cnxk_cryptodev_ops.c  |  5 +-
 drivers/crypto/cnxk/cnxk_cryptodev_ops.h  |  4 +
 drivers/crypto/cnxk/rte_pmd_cnxk_crypto.h |  3 +
 17 files changed, 247 insertions(+), 17 deletions(-)

-- 
2.25.1

