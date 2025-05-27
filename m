Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4485C54ED1
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 May 2025 13:01:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BCEC74028D;
	Tue, 27 May 2025 15:01:42 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id D22454027A
 for <dev@dpdk.org>; Tue, 27 May 2025 15:01:40 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54QNX8ou005905
 for <dev@dpdk.org>; Tue, 27 May 2025 06:01:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=j5/t2dj3Zo1QjplF1VxzUyU
 qP1AY2Hyk3s14Bgze5zU=; b=S88/cpr9+TOmkLtTXRk3JpblW0yP2il/unjqacA
 3ErL6SYO6yh1dcNPpBgM+k/tBFX/KeYoy4kWqW0MimaOMe+pk4iZbduhtfJ1fMeW
 DPdO/h15hjkFTmuP8Tz44RG1N8nUGhtmfehF1Y2wA3m2/rACsKdLPLers2etKufF
 ssQA7QaTQgjO12gvcgAKl3sGpvveWWctkh/Egh5HOYt4v1govZJthSBGGjijvv4e
 gswbXpSvmPTxTO2Y3FA1qGlDkRjzPNjjAcLvyYSyHj1FPj6RaVw9H4k5ba75E0Dj
 JJHOhjmQMI7f8ZEGIB7XleZTkDobfYacaTSMF31R8b6Eehw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 46w21299pd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Tue, 27 May 2025 06:01:39 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 27 May 2025 06:01:38 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 27 May 2025 06:01:38 -0700
Received: from hyd1554.caveonetworks.com (unknown [10.29.56.32])
 by maili.marvell.com (Postfix) with ESMTP id 5B8B13F705D;
 Tue, 27 May 2025 06:01:36 -0700 (PDT)
From: Tejasree Kondoj <ktejasree@marvell.com>
To: Akhil Goyal <gakhil@marvell.com>
CC: Anoob Joseph <anoobj@marvell.com>, Nithinsen Kaithakadan
 <nkaithakadan@marvell.com>, Rupesh Chiluka <rchiluka@marvell.com>, "Vidya
 Sagar Velumuri" <vvelumuri@marvell.com>, <dev@dpdk.org>
Subject: [PATCH 0/9] fixes and new features to cnxk crypto PMD
Date: Tue, 27 May 2025 18:31:26 +0530
Message-ID: <20250527130135.2301726-1-ktejasree@marvell.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=H6zbw/Yi c=1 sm=1 tr=0 ts=6835b7b3 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=dt9VzEwgFbYA:10 a=8rWy6zfcAAAA:8 a=dLGLtkjP_ksHsy5g4tYA:9
 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-GUID: Gv1et-m8W5es9ZN84ip3dBX4YR_fWk1w
X-Proofpoint-ORIG-GUID: Gv1et-m8W5es9ZN84ip3dBX4YR_fWk1w
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI3MDEwNiBTYWx0ZWRfXzqCTReUkhmzU
 PWGT3dBw6zkkBhOWfR2kghYv/KXaWiU9XVegBdmLddRvf1TI+LBMpja72gKirkjVAD61NC2uAhr
 1zEyWtvXA5NAweb9y56N83V1oGznaARLS1QwcoZy7j37bHCGR/eJ8ZQbBHMqlLZ1vA+DUyWn+hF
 RZrpGvphog06BoN9MTuEtTMhci3Ny3Ie5QORBhptpMG/hOqoT6YDWsJ26gNyr7guNd7FgtTZPMg
 ISAvIb1tlvyIrQ0BCtECfMEf4PL13mLMLe/74vDH3w5jn+glaGHoeFJsIjM3RyPEHLrxXa9F7n0
 J1aFHeYz6BGeYvHMlx2/iLhW3TwnE+Z2uioRXib/1vXTBUkSlVn2XpWeo1/kYAqGBV72a3PThTJ
 9yeFxAT+x199YHoQSa0yuTVI15Gj26RvHNsFkERYWCjsdlJqQuyFainUb8FmZli8OWkdfl7f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-27_06,2025-05-27_01,2025-03-28_01
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
It is dependent on below series:
https://patches.dpdk.org/project/dpdk/list/?series=35294

Nithinsen Kaithakadan (4):
  common/cnxk: fix salt handling with aes-ctr
  common/cnxk: set correct salt value for ctr algos
  common/cnxk: update qsize in CPT iq enable
  crypto/cnxk: copy 8B iv into sess in aes ctr

Rupesh Chiluka (2):
  crypto/cnxk: extend check for max supported gather entries
  crypto/cnxk: add asym sessionless handling

Tejasree Kondoj (2):
  crypto/cnxk: include required headers
  crypto/cnxk: add struct variable for custom metadata

Vidya Sagar Velumuri (1):
  crypto/cnxk: add support for sessionless asym

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
 14 files changed, 244 insertions(+), 17 deletions(-)

-- 
2.25.1

