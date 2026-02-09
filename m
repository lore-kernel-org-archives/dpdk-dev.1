Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABCC8EA3F27
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Feb 2026 15:04:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9848540648;
	Wed, 11 Feb 2026 16:04:49 +0100 (CET)
Received: from mx0b-00190b01.pphosted.com (mx0b-00190b01.pphosted.com
 [67.231.157.127])
 by mails.dpdk.org (Postfix) with ESMTP id 8A73C4028F
 for <dev@dpdk.org>; Mon,  9 Feb 2026 17:16:01 +0100 (CET)
Received: from pps.filterd (m0050102.ppops.net [127.0.0.1])
 by m0050102.ppops.net-00190b01. (8.18.1.11/8.18.1.11) with ESMTP id
 6196k3De2880281; Mon, 9 Feb 2026 16:16:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=jan2016.eng; bh=FSqJpvqau15Rm7kxdxv/
 d/ERtBKj2YgVEeH4lhWozLA=; b=YCvlrWZKdB7x8M6Jpv45l44tpyK3cz4OinjX
 5PXkeCIIXJcaLMr9DC5RjvFUbc/T5f5Mz2Pnyvjj75nGmVnkX9YxMB1IobqsJEQV
 9bxaZ9d3XE0Jn00e1JNR8NahbNJp8SR6lY29DAhbTRQYTQAqj0TR+bcqwZlBr85R
 Fqph5gd12RmpLx7jCU2cqbuV7YgdhUcXqvwEkHa1bKT0s15CpASrO20uxuo8gbjR
 Lwm0FG1Kt87j6LpjhD/kx8l81g70DMJBKxYiQTclXBRA9Bd4kinyr9sFGZ/tfzzu
 7d71W2cnbSk0RApCHGHEopx3o1AP0umZQNgC7BpP61/0+Uf2EQ==
Received: from prod-mail-ppoint1 (prod-mail-ppoint1.akamai.com [184.51.33.18])
 by m0050102.ppops.net-00190b01. (PPS) with ESMTPS id 4c5xdsmgpe-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Feb 2026 16:16:00 +0000 (GMT)
Received: from pps.filterd (prod-mail-ppoint1.akamai.com [127.0.0.1])
 by prod-mail-ppoint1.akamai.com (8.18.1.2/8.18.1.2) with ESMTP id
 619F5iVA021038; Mon, 9 Feb 2026 11:15:59 -0500
Received: from email.msg.corp.akamai.com ([172.27.91.41])
 by prod-mail-ppoint1.akamai.com (PPS) with ESMTPS id 4c61m3fev0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Feb 2026 11:15:59 -0500
Received: from usma1ex-dag5mb2.msg.corp.akamai.com (172.27.91.41) by
 usma1ex-dag5mb2.msg.corp.akamai.com (172.27.91.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 9 Feb 2026 08:15:59 -0800
Received: from lon-lph85swt.london.corp.akamai.com (172.27.164.43) by
 usma1ex-dag5mb2.msg.corp.akamai.com (172.27.91.41) with Microsoft SMTP Server
 id 15.2.2562.29 via Frontend Transport; Mon, 9 Feb 2026 08:15:59 -0800
Received: by lon-lph85swt.london.corp.akamai.com (Postfix, from userid 37336)
 id A74C415634D2; Mon,  9 Feb 2026 16:15:58 +0000 (GMT)
From: Max Tottenham <mtottenh@akamai.com>
To: <dev@dpdk.org>
CC: <dsosnowski@nvidia.com>, <viacheslavo@nvidia.com>, <bingz@nvidia.com>,
 <orika@nvidia.com>, <suanmingm@nvidia.com>, <matan@nvidia.com>,
 <mtottenh@akamai.com>, <johunt@akamai.com>
Subject: [PATCH v2 0/3] net/mlx5: SF/representor hotplug fixes
Date: Mon, 9 Feb 2026 16:14:37 +0000
Message-ID: <20260209161440.1947052-1-mtottenh@akamai.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-09_01,2026-02-09_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 phishscore=0 malwarescore=0
 mlxscore=0 spamscore=0 suspectscore=0 adultscore=0 mlxlogscore=492
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2602090135
X-Proofpoint-ORIG-GUID: yQeOrZ0cVwRvqomI_6rsPEzewfGnihKo
X-Authority-Analysis: v=2.4 cv=K+8v3iWI c=1 sm=1 tr=0 ts=698a0840 cx=c_pps
 a=StLZT/nZ0R8Xs+spdojYmg==:117 a=StLZT/nZ0R8Xs+spdojYmg==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=8rWy6zfcAAAA:8 a=Fq-yfA6pwpVZH-30ZpIA:9
 a=unaBcKCsHl4A:10 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA5MDEzNyBTYWx0ZWRfX4huhs6rp5kZn
 KX4enp3kNVODssg77T+IRdHrSSKXn+6q/+j4uxsgDkJdXbw+2jBi9cB+UZ5BXd7ghXkyjjpU9RT
 A665MLhDl8M8iwM11ZlV1LijGU0ewL2MRq64yw6/jaOrajWBIrqSv/ksvJYCVBctVeyj1/4/hd8
 P8+FILAkRpzY0tRa2y0rEoXA4+stYQ2eAzaRnDiTcBuhhFvMfbeF5RvT8KCkQba9fPXgY2vbH32
 RHcWpiVX90kpsk6bZu6pqTFw3yHCZ7+5i1pT6jA4iHf0CqGUmKVCz3UfvCXDmFYQXSjxSmbVq35
 lsfo5JkeLusILVzGnCXrTxEjIb077X2EfFk5TGovtcjQyqvYOhq7ydFPZZWWaZqTJWVNOtjH3uu
 JCbRUmxr2Sob8eVw/10urd3yJ7ahCAeL5D3X39dXOvaZ48aorepUfzPw5q5BNiHZrmDePrRoWcg
 do0sVJI9Feln5SLsDuw==
X-Proofpoint-GUID: yQeOrZ0cVwRvqomI_6rsPEzewfGnihKo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-09_01,2026-02-09_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015
 spamscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 priorityscore=1501
 phishscore=0 adultscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602090137
X-Mailman-Approved-At: Wed, 11 Feb 2026 16:04:47 +0100
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

This series fixes several issues encountered when hotplugging SF
devices and their representors at runtime.

Patch 1 fixes ROCE disable for auxiliary (SF) devices by using the
correct devlink attributes (auxiliary bus + device name) instead of
incorrectly targeting the parent PF.

Patch 2 ensures switch info is queried during auxiliary probe so that
SF representors are properly identified and vport metadata is initialized.

Patch 3 fixes vport action flag selection for hotplugged representors
to use the proxy port's FDB mode rather than the representor's.

v1: https://mails.dpdk.org/archives/dev/2026-January/330009.html

Changes since v1:
- Attempt to disable ROCE on the SF auxiliary device when hotplugging SF representors
- Fixes for vport metadata querying during hotplug

Max Tottenham (3):
  common/mlx5: fix ROCE disable for auxiliary SF devices
  net/mlx5: fix vport metadata for auxiliary bus devices
  net/mlx5: fix vport action flags for hotplugged representors

 drivers/common/mlx5/linux/mlx5_common_os.c | 37 ++++++++---
 drivers/common/mlx5/linux/mlx5_nl.c        | 72 ++++++++++++----------
 drivers/common/mlx5/linux/mlx5_nl.h        |  8 +--
 drivers/net/mlx5/linux/mlx5_os.c           | 15 +++++
 drivers/net/mlx5/mlx5_flow_hw.c            |  2 +-
 5 files changed, 85 insertions(+), 49 deletions(-)

--
2.52.0

