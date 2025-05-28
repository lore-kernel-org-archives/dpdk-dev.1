Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C621C5AD49
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 May 2025 10:54:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A965F4028D;
	Wed, 28 May 2025 12:53:59 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 7938D40279
 for <dev@dpdk.org>; Wed, 28 May 2025 12:53:58 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54S7GDIB021154;
 Wed, 28 May 2025 03:53:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=byGzENY3zgzflqcgAeAaGTZ
 agy0PrzFQVnYMKXNMRXc=; b=Ik48XuIPBMbLfpraHs07OACFfqRGkvHFUDFIwlB
 afPeB2T1xQ8DamrhAp44+Lu3rPAyVtll5y5EPMJLTnYY41PnlR4gTED+p/2WVedi
 XZ33W7prb/vRkMC9T+n2iozRlqDwdJlv1gdLnvQotc73ehgHEEn2VsW1uBurBk8E
 gIZ41/Dq6tkRwWqeaWjkfSLdhcyN+rN/vqFP8jO6q3XVPtbAVQCKtVmfg+J6wu5D
 hPiH6C7N5s1yQO+L6hCfqEEF7ErVwUf/DpMyw73QhwXT6r3PMzJBDwiZb59je7tj
 lwBWfZ5Qn3xxVMplGW5bQtjFLSGINom6cId7ycR02FM/Irw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 46wwjqrdy4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 28 May 2025 03:53:57 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 28 May 2025 03:53:56 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 28 May 2025 03:53:56 -0700
Received: from Dell640-transport-1.sclab.marvell.com (unknown [10.106.48.36])
 by maili.marvell.com (Postfix) with ESMTP id 741B03F7060;
 Wed, 28 May 2025 03:53:56 -0700 (PDT)
From: Rajesh Mudimadugula <rmudimadugul@marvell.com>
To: <dev@dpdk.org>
CC: <jianjay.zhou@huawei.com>, Rajesh Mudimadugula <rmudimadugul@marvell.com>
Subject: [PATCH] crypto/virtio: fix driver ID for virtio
Date: Wed, 28 May 2025 10:53:47 +0000
Message-ID: <20250528105347.2014993-1-rmudimadugul@marvell.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI4MDA5NSBTYWx0ZWRfX3VW2Tf6O06Vw
 Fdy68Y32qQ77246PKDH5noCqJazG01ymDm3s/QsXpbo7XEFPqf1PnHEq3/r+CurUFq5p6kKfpD6
 hc6GkvME2zQlQoI9GfIkAXKMLJcbXvvDlzLI0FCusJ5v2SYBrgKo89RVMG3UH7K/NuUhkOIS8cq
 CeemmVHIgE4ZaqoAw6ciAzH9yac+pKTPHRkZd6QyBw7QFYHZrDVIBTcuBcGcTBeo67ebuJF5h1t
 syNkfvWBHNB4rJfhJcdKpnLf8UFnU/yr8HgJ4F2jnInUzt2HyymhrTEVhZ9d/SqVdCq82iUYpBc
 Gpdf013x/NkVomFHNlLrCvOzSeVy6dCp3sCWfS5/3LRLCq4yKB84PUw2SfkrOx+NXyrZiAD4Q/Y
 kio+X+5HcBh89KKdNc85alkRcTW6vNPcK495gbAoG6KkoUi8QW9jubXYVhxgq22Au9PiCb/9
X-Proofpoint-ORIG-GUID: 2_Q8gWsB6IJKl8RuunhJKy-U1MGHIvVa
X-Authority-Analysis: v=2.4 cv=M9pNKzws c=1 sm=1 tr=0 ts=6836eb45 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=FMSeyukeo32nUCDWLTYA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: 2_Q8gWsB6IJKl8RuunhJKy-U1MGHIvVa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-28_05,2025-05-27_01,2025-03-28_01
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

This patch corrects driver id for virtio and virtio_user
pmds.

Fixes: 25500d4b8076 ("crypto/virtio: support device init")

Signed-off-by: Rajesh Mudimadugula <rmudimadugul@marvell.com>
---
 drivers/crypto/virtio/virtio_cryptodev.c      | 4 ++--
 drivers/crypto/virtio/virtio_user_cryptodev.c | 5 +++--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/crypto/virtio/virtio_cryptodev.c b/drivers/crypto/virtio/virtio_cryptodev.c
index fa215fe528..ca06cf2e37 100644
--- a/drivers/crypto/virtio/virtio_cryptodev.c
+++ b/drivers/crypto/virtio/virtio_cryptodev.c
@@ -550,7 +550,6 @@ crypto_virtio_dev_init(struct rte_cryptodev *cryptodev, uint64_t features,
 {
 	struct virtio_crypto_hw *hw;
 
-	cryptodev->driver_id = cryptodev_virtio_driver_id;
 	cryptodev->dev_ops = &virtio_crypto_dev_ops;
 
 	cryptodev->enqueue_burst = virtio_crypto_pkt_tx_burst;
@@ -599,6 +598,7 @@ crypto_virtio_create(const char *name, struct rte_pci_device *pci_dev,
 	if (cryptodev == NULL)
 		return -ENODEV;
 
+	cryptodev->driver_id = cryptodev_virtio_driver_id;
 	if (crypto_virtio_dev_init(cryptodev, VIRTIO_CRYPTO_PMD_GUEST_FEATURES,
 			pci_dev) < 0)
 		return -1;
@@ -1666,7 +1666,7 @@ virtio_crypto_dev_info_get(struct rte_cryptodev *dev,
 	PMD_INIT_FUNC_TRACE();
 
 	if (info != NULL) {
-		info->driver_id = cryptodev_virtio_driver_id;
+		info->driver_id = dev->driver_id;
 		info->feature_flags = dev->feature_flags;
 		info->max_nb_queue_pairs = hw->max_dataqueues;
 		/* No limit of number of sessions */
diff --git a/drivers/crypto/virtio/virtio_user_cryptodev.c b/drivers/crypto/virtio/virtio_user_cryptodev.c
index 992e8fb43b..4daa188e1d 100644
--- a/drivers/crypto/virtio/virtio_user_cryptodev.c
+++ b/drivers/crypto/virtio/virtio_user_cryptodev.c
@@ -26,6 +26,8 @@
 
 #define virtio_user_get_dev(hwp) container_of(hwp, struct virtio_user_dev, hw)
 
+uint8_t cryptodev_virtio_user_driver_id;
+
 static void
 virtio_user_read_dev_config(struct virtio_crypto_hw *hw, size_t offset,
 		     void *dst, int length __rte_unused)
@@ -460,6 +462,7 @@ virtio_user_pmd_probe(struct rte_vdev_device *vdev)
 		goto end;
 	}
 
+	cryptodev->driver_id = cryptodev_virtio_user_driver_id;
 	if (crypto_virtio_dev_init(cryptodev, VIRTIO_USER_CRYPTO_PMD_GUEST_FEATURES,
 			NULL) < 0) {
 		PMD_INIT_LOG(ERR, "crypto_virtio_dev_init fails");
@@ -563,8 +566,6 @@ static struct rte_vdev_driver virtio_user_driver = {
 
 static struct cryptodev_driver virtio_crypto_drv;
 
-uint8_t cryptodev_virtio_user_driver_id;
-
 RTE_PMD_REGISTER_VDEV(crypto_virtio_user, virtio_user_driver);
 RTE_PMD_REGISTER_CRYPTO_DRIVER(virtio_crypto_drv,
 	virtio_user_driver.driver,
-- 
2.34.1

