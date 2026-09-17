Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34536C982CD
	for <dpdk-dev@archiver.kernel.org>; Thu, 17 Sep 2026 07:15:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E60E542DC1;
	Thu, 17 Sep 2026 09:15:09 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id C0102427E5;
 Thu, 17 Sep 2026 09:15:08 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68H68Zbr086035; Thu, 17 Sep 2026 00:15:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=s
 6Mze9W8GnJECnV15ek720j9j3/wo1Q5WHEn70eUvgM=; b=UuTFu82IYsrcIUkqa
 RKTzWn5hNCjcHvCp8vAsrbHwXlMR6Te/gzjeQlWHfPBWi0Swryt3CFqGNC20wy5x
 aLA15L5vELf9JjiAYrCKYKvTUiJPL1i90Y3DBAl8wrjeLJTDUrZPEtdmNfVbmAE6
 qsTUCgjHDC9EQjGcGGeGvDxJjmLIgezQki6+yaPs4YpfAR9N4x98uRXxcoTkyn7e
 SZXONpjHYoGi0TaHJ/SmN51wyXo2XdPYv3a1KWsZ7nyF6Sk4iMYzYdBDKCqzhajA
 fK+WkZmN8X7bb0amH3nBc3MB0aGnNhvX0axE/+fp5IbVq4l2UQ6la+Aab+p2E517
 aVImg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4gqqujq6xq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 17 Sep 2026 00:15:07 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 17 Sep 2026 00:15:06 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 17 Sep 2026 00:15:06 -0700
Received: from cavium-RAHUL-BM.. (unknown [10.28.36.48])
 by maili.marvell.com (Postfix) with ESMTP id E3BA35C68EF;
 Thu, 17 Sep 2026 00:15:02 -0700 (PDT)
From: Rahul Bhansali <rbhansali@marvell.com>
To: <dev@dpdk.org>, Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, Rakesh Kudurumalla <rkudurumalla@marvell.com>,
 <stable@dpdk.org>
Subject: [PATCH 14/14] net/cnxk: fix custom inbound SA condition check
Date: Thu, 17 Sep 2026 12:40:16 +0530
Message-ID: <20260917071016.2366467-14-rbhansali@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260917071016.2366467-1-rbhansali@marvell.com>
References: <20260917071016.2366467-1-rbhansali@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDA5NiBTYWx0ZWRfXw9M06LczS5Ms
 o/VOtCguq85j/H6gdpX06XJ9Wg79DgzpxST2GbSai43abToU6q2+J3n8RYCDE35Oockt+6yu6PJ
 /F1Z+yWB9CGZz1JeNMj8S0gGlwZ86yB6qjPEJf10t3ncJ1agLXM9F9k+5hNcyBn9+DYRXIAlFOM
 3Wy0Mzq3sH0rZy6nIBN3N1hM5ySN/YGPVnJuhJwfZWAsLFdjAJS9dgHKTOfAwGKQkrEJpnpEG0z
 CuPgjmN31zvnp0Pgrl9VApIaxALC2zb/fFkaiZtPBQq0BDImcVs2iFdWckiVEGuXk7Vf1Su3dKv
 d8kdyyV6c1avQ4OogXDKe0JPn87RMLk1DVOchMAuybRMVN4ChL8IImht8ml87bG1jHPuqwN3AYv
 JX6OZn9tL3r90GUgZACq8uCfQrMTQxflUoOBgNDP/9W4Edgn+z3IdPnRXoUq0cBW9cthjxc6KRL
 nbq1tTSfMuDWgSQ7CpQ==
X-Proofpoint-GUID: HC8q1ofHlX2mMX4QPEhayz0HxTfH53ak
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDA5NiBTYWx0ZWRfX6zTFJVbEyMPF
 CspypJwro1d2bNlWD5SRIVBXuc7HmWZVNOxusbe1vLP08Nj/x7no9g39xZwOcNt4TW0/N89pU9q
 wUkwFi7DHzd7HE51lz4gjV/1KC3eXLU=
X-Authority-Analysis: v=2.4 cv=F6LC5ahN c=1 sm=1 tr=0 ts=6aab937b cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=M5GUcnROAAAA:8 a=8rWy6zfcAAAA:8
 a=We5yoBRLiO0NRZErAZ4A:9 a=OBjm3rFKGHvpk9ecZwUJ:22 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-ORIG-GUID: HC8q1ofHlX2mMX4QPEhayz0HxTfH53ak
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_01,2026-09-16_02,2025-10-01_01
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

From: Rakesh Kudurumalla <rkudurumalla@marvell.com>

Custom inbound SA condition should be check when inbound SA create
and destroy.

Fixes: 7eaa499dd0c2 ("net/cnxk: support CN20K inline IPsec session")
Cc: stable@dpdk.org

Signed-off-by: Rakesh Kudurumalla <rkudurumalla@marvell.com>
---
 drivers/net/cnxk/cn20k_ethdev_sec.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/cnxk/cn20k_ethdev_sec.c b/drivers/net/cnxk/cn20k_ethdev_sec.c
index b365426065..f648340445 100644
--- a/drivers/net/cnxk/cn20k_ethdev_sec.c
+++ b/drivers/net/cnxk/cn20k_ethdev_sec.c
@@ -805,9 +805,6 @@ cn20k_eth_sec_session_create(void *device, struct rte_security_session_conf *con
 	if (conf->protocol != RTE_SECURITY_PROTOCOL_IPSEC)
 		return -ENOTSUP;
 
-	if (nix->custom_inb_sa)
-		return -ENOTSUP;
-
 	if (rte_security_dynfield_register() < 0)
 		return -ENOTSUP;
 
@@ -832,6 +829,9 @@ cn20k_eth_sec_session_create(void *device, struct rte_security_session_conf *con
 	ipsec = &conf->ipsec;
 	crypto = conf->crypto_xform;
 
+	if (nix->custom_inb_sa && ipsec->direction == RTE_SECURITY_IPSEC_SA_DIR_INGRESS)
+		return -ENOTSUP;
+
 	rc = cnxk_ipsec_xform_verify(ipsec, crypto);
 	if (rc) {
 		plt_err("Crypto xform verify failed, rc=%d", rc);
@@ -1083,7 +1083,7 @@ cn20k_eth_sec_session_destroy(void *device, struct rte_security_session *sess)
 	eth_sec = cnxk_eth_sec_sess_get_by_sess(dev, sess);
 	if (!eth_sec)
 		return -ENOENT;
-	if (dev->nix.custom_inb_sa)
+	if (dev->nix.custom_inb_sa && eth_sec->inb)
 		return -ENOTSUP;
 
 	lock = eth_sec->inb ? &dev->inb.lock : &dev->outb.lock;
-- 
2.34.1

