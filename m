Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75C89D29DDE
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Jan 2026 07:41:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 19FEB4028C;
	Tue, 13 Jan 2026 08:41:01 +0100 (CET)
Received: from mx0b-00190b01.pphosted.com (mx0b-00190b01.pphosted.com
 [67.231.157.127])
 by mails.dpdk.org (Postfix) with ESMTP id C8AA34013F
 for <dev@dpdk.org>; Sun, 11 Jan 2026 00:15:31 +0100 (CET)
Received: from pps.filterd (m0050096.ppops.net [127.0.0.1])
 by m0050096.ppops.net-00190b01. (8.18.1.11/8.18.1.11) with ESMTP id
 60AN0h9T1999941; Sat, 10 Jan 2026 23:15:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=jan2016.eng; bh=VxSLWU9XuFQyj3PA/s41
 KlSBNfI/J81dt6h5d565Esg=; b=Sb345fxwEJ+k5hVR05tRHeqlxXoSq70usr8j
 Cja/RG9eQjuOYmFiW2/4GMFrZNp9L/As4mK4dR7E7l3d8sUWP2qMFU6AFTmbKasW
 9f2uiQJQYFAi4b1VNv/BjAmK+F+/iSfnqu+tzSibYBG3GJ3rbRnSwBtAsTgc3/Ux
 7PuDU0554sZlADdhSoZz1apSN1HjQEZLTetHFR8nvJt6RT6uQiBmTlEO/HJDNzFr
 So47mEB0wqe0COvLayT+iQIgBHamCckTdaKePwAOJDeJn8148bvWgUxNaJJmY7nl
 k9l+fthkXG2JVRiASeYpeE+uW+LnUjH/QMxH8dX+tYFlLuP5pA==
Received: from prod-mail-ppoint1 (prod-mail-ppoint1.akamai.com [184.51.33.18])
 by m0050096.ppops.net-00190b01. (PPS) with ESMTPS id 4bkg279rsy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 10 Jan 2026 23:15:30 +0000 (GMT)
Received: from pps.filterd (prod-mail-ppoint1.akamai.com [127.0.0.1])
 by prod-mail-ppoint1.akamai.com (8.18.1.2/8.18.1.2) with ESMTP id
 60ACwVph003167; Sat, 10 Jan 2026 18:15:30 -0500
Received: from email.msg.corp.akamai.com ([172.27.91.41])
 by prod-mail-ppoint1.akamai.com (PPS) with ESMTPS id 4bkk00sjbj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 10 Jan 2026 18:15:29 -0500
Received: from usma1ex-dag5mb2.msg.corp.akamai.com (172.27.91.41) by
 usma1ex-dag5mb2.msg.corp.akamai.com (172.27.91.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Sat, 10 Jan 2026 15:15:29 -0800
Received: from lon-lph85swt.london.corp.akamai.com (172.27.118.139) by
 usma1ex-dag5mb2.msg.corp.akamai.com (172.27.91.41) with Microsoft SMTP Server
 id 15.2.2562.29 via Frontend Transport; Sat, 10 Jan 2026 15:15:29 -0800
Received: by lon-lph85swt.london.corp.akamai.com (Postfix, from userid 37336)
 id E43C91560791; Sat, 10 Jan 2026 23:15:28 +0000 (GMT)
From: Max Tottenham <mtottenh@akamai.com>
To: <dev@dpdk.org>
CC: <dsosnowski@nvidia.com>, <viacheslavo@nvidia.com>, <bingz@nvidia.com>,
 <orika@nvidia.com>, <suanmingm@nvidia.com>, <matan@nvidia.com>,
 Max Tottenham <mtottenh@akamai.com>
Subject: [PATCH] common/mlx5: skip ROCE disable for auxiliary SF devices
Date: Sat, 10 Jan 2026 23:15:10 +0000
Message-ID: <20260110231510.39095-1-mtottenh@akamai.com>
X-Mailer: git-send-email 2.51.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-10_07,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 bulkscore=0 mlxlogscore=867
 spamscore=0 phishscore=0 adultscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2512120000
 definitions=main-2601100205
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEwMDIwNyBTYWx0ZWRfX2icgSkMFmUvx
 6MiuA59+PaRdWMh1wd8F2YuuHbeW7sexw1fGhoZNVegRckdmyTfcgdY3uEbsl6WTmY0ZtNnB88L
 luCswo3EocqrdXOyuX6Q4nTvYQT934oAcMvFCaBEbUGozjbnNHZikOBhKzaCptiRKzJz/Vdn4JG
 HsPMNINxOafl9rFlmN6OpLnlNNhEU6l3XFimIIq0urZR8iTPIrheatRD7nhVadFDuRhwedIm8/N
 ukA92t7z3Sb3co51gWsswnCxdvJ1wG4wFFAw1SygDssYpQ0F9EzFELvBfmKvT9/hF+Rre1GrVM2
 Sq2XofzEp6v1KlzIBXmFNb8irHoNjsAFAjCIfH4ukKNYG2Gogi0wn/4Om+gLWTNgP/Elodf6xD6
 MKJNVXdDhVD+9PTj+8EfUE3Ou2QCmBo6ckgh2zc4a4q75ttKjTYXanZml4uGefGdoZN+SLQdp9I
 CH265ZGpdD7/YvglraQ==
X-Proofpoint-GUID: 2d3QC0ncnYyPxBpOXZLDYFMeczxXG4hC
X-Proofpoint-ORIG-GUID: 2d3QC0ncnYyPxBpOXZLDYFMeczxXG4hC
X-Authority-Analysis: v=2.4 cv=ScD6t/Ru c=1 sm=1 tr=0 ts=6962dd92 cx=c_pps
 a=StLZT/nZ0R8Xs+spdojYmg==:117 a=StLZT/nZ0R8Xs+spdojYmg==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=X7Ea-ya5AAAA:8
 a=KJ5unKwt9qGGm7TnCQ0A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-10_07,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501
 clxscore=1011 bulkscore=0 phishscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601100207
X-Mailman-Approved-At: Tue, 13 Jan 2026 08:40:59 +0100
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

When probing an SF as a vDPA device, mlx5_roce_disable() targets the
parent PF address (via mlx5_dev_to_pci_str). This incorrectly attempts
to disable ROCE on the parent PF rather than the SF itself.

This causes vDPA probe failures when the parent PF already has an open
IB context (e.g., probed for uplink ports or SF representors).

For SubFunctions, ROCE is configured via devlink parameters
(enable_roce) before device creation. Skip the runtime ROCE disable
for auxiliary devices since the devlink configuration is already in
effect and targeting the parent PF is incorrect.

Signed-off-by: Max Tottenham <mtottenh@akamai.com>
---
 drivers/common/mlx5/linux/mlx5_common_os.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/common/mlx5/linux/mlx5_common_os.c b/drivers/common/mlx5/linux/mlx5_common_os.c
index 2867e21618..6fa12e06eb 100644
--- a/drivers/common/mlx5/linux/mlx5_common_os.c
+++ b/drivers/common/mlx5/linux/mlx5_common_os.c
@@ -690,6 +690,19 @@ mlx5_roce_disable(const struct rte_device *dev)
 {
 	char pci_addr[PCI_PRI_STR_SIZE] = { 0 };
 
+	/*
+	 * For auxiliary devices (SFs), ROCE is configured via devlink
+	 * parameters (enable_roce) before device creation. Skip runtime
+	 * ROCE disable since mlx5_dev_to_pci_str() returns the parent PF
+	 * address, not the SF - disabling ROCE on the parent PF is both
+	 * incorrect and may fail if the PF already has an active IB context.
+	 */
+	if (!mlx5_dev_is_pci(dev)) {
+		DRV_LOG(INFO, "Skipping ROCE disable for auxiliary device \"%s\"",
+			dev->name);
+		return 0;
+	}
+
 	if (mlx5_dev_to_pci_str(dev, pci_addr, sizeof(pci_addr)) < 0)
 		return -rte_errno;
 	/* Firstly try to disable ROCE by Netlink and fallback to sysfs. */
-- 
2.51.2

