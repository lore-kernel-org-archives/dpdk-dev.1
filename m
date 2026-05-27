Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EC14CD5BDE
	for <dpdk-dev@archiver.kernel.org>; Wed, 27 May 2026 08:53:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 47DC84028A;
	Wed, 27 May 2026 10:53:22 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id BFF8F40285;
 Wed, 27 May 2026 10:53:20 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64QMs1F41192236; Wed, 27 May 2026 01:53:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=gY+89MlaI4CcjTasjeo6w05
 ze5QVfkCxGfFYPbovmtQ=; b=BEH77v1c48TPxEEVZJrPt5eYuUBwKDGtmrkEAxT
 8lyXbPEcv29JQt2k06uI4RFPAfWzbF81iT6a5IveWpxo+Z7VzpQVMze3ZrOyz5Wl
 ZOe8ruYNMnLhnrGhu5PiJq+GSiAM3sHyfGs2ef+obLrIQr0dqKNyy9a/AEGu5Um6
 q6Mm540hsILR9V40ijOXZVI4nKbN8gIWS/oyZx6v7ccfItd5rOH4EMya+hkJNLfF
 7eTU95jTS+3Ma2awcGTATRp/wR8ErFxcVCSoocZ7RuvuUkig5k4SdnowGcXzyN7l
 MoH/CIxlvHkCwY0PRl07tjyPLn0Qz2b66LqEYl+K35sNyyg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4edd8njvty-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 27 May 2026 01:53:19 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 27 May 2026 01:53:18 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 27 May 2026 01:53:18 -0700
Received: from IN-lckQE5Rwctls.marvell.com (IN-lckQE5Rwctls.marvell.com
 [10.28.167.66])
 by maili.marvell.com (Postfix) with ESMTP id ADA223F7068;
 Wed, 27 May 2026 01:53:16 -0700 (PDT)
From: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
To: <dev@dpdk.org>, Akhil Goyal <gakhil@marvell.com>, Fan Zhang
 <fanzhang.oss@gmail.com>, Gowrishankar Muthukrishnan
 <gmuthukrishn@marvell.com>
CC: <stable@dpdk.org>
Subject: [PATCH 1/2] test/crypto: validate ML crypto keys
Date: Wed, 27 May 2026 14:22:52 +0530
Message-ID: <20260527085257.1933-1-gmuthukrishn@marvell.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: Xu05-xfEbfPhaA3SD3770UmLyMMm8Bnz
X-Authority-Analysis: v=2.4 cv=VZrH+lp9 c=1 sm=1 tr=0 ts=6a16b100 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=8rWy6zfcAAAA:8 a=M5GUcnROAAAA:8
 a=4oYLaZdSTXjDlawoNDMA:9 a=YjdVzJdQTyZRADMV7wFX:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI3MDA4NSBTYWx0ZWRfXwq+ACG1hgB4u
 zJIEwF+okK1HBaOVd7SE5lQBOAV7yd1T4nTEX6B7BsOdZieMchj4hVFt8PoSe+0RmwcnXSd2O7M
 s0yx4UpI9klfDnuL6mlL7Uexzc+8n+pCwNrK2evwVEWBmBksVKwPG7IzLd6WoZI4GF31QPw4uTs
 3NbjCw7hR5IHurRruK/gIGFl5JwUiZQkZAqEfkp/A4zmy0yYtRagi2VLQ+lgrIbj0gycqeRnKbX
 lK/ErwON4e6M1nVTvFxrenvmi9k5AcVHTykIn7VUEpZzryCBQjK/Y0LbB7HXQlfKBcGrjHPd7iV
 WEpw7RU5C7rqN/4OEGpmoRO0HdUtscj+DEyqto4SL9wyfNtFkKzxc/0crznQPxvWegKRrrbWRRE
 //CTxp2T2HBVpu82YuJ/cir0186FtpQh4fjd5RssPdJ9xZoU3z+FppwpWqK01HCj4aBgrCg6L7D
 l/eF/EcGe87Ex10fPsg==
X-Proofpoint-ORIG-GUID: Xu05-xfEbfPhaA3SD3770UmLyMMm8Bnz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-27_01,2026-05-26_03,2025-10-01_01
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

Validate ML-KEM and ML-DSA keys.

Fixes: 76a5877072c ("test/crypto: add ML-KEM and ML-DSA cases")
Cc: stable@dpdk.org

Signed-off-by: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
---
 app/test/test_cryptodev_asym.c                | 48 ++++++++-----------
 app/test/test_cryptodev_ml_dsa_test_vectors.h |  8 ++++
 app/test/test_cryptodev_ml_kem_test_vectors.h |  8 ++++
 3 files changed, 36 insertions(+), 28 deletions(-)

diff --git a/app/test/test_cryptodev_asym.c b/app/test/test_cryptodev_asym.c
index bf1a1fc417..73a8198e53 100644
--- a/app/test/test_cryptodev_asym.c
+++ b/app/test/test_cryptodev_asym.c
@@ -3949,19 +3949,15 @@ mlkem_keygen(const void *test_data)
 		rte_crypto_ml_kem_pubkey_size[vector->type],
 		"Incorrect Encapsulation key length\n");
 
-	/* If the seed is all zero, keys are deterministic */
-	if (memcmp(vector->d.data, (uint8_t [32]) {0},
-			vector->d.length) == 0) {
-		TEST_ASSERT_BUFFERS_ARE_EQUAL(vector->dk.data,
-			self->result_op->asym->mlkem.keygen.dk.data,
-			self->result_op->asym->mlkem.keygen.dk.length,
-			"Incorrect Decapsulation key\n");
-		TEST_ASSERT_BUFFERS_ARE_EQUAL(vector->ek.data,
-			self->result_op->asym->mlkem.keygen.ek.data,
-			self->result_op->asym->mlkem.keygen.ek.length,
-			"Incorrect Encapsulation key\n");
-		RTE_LOG(DEBUG, USER1, "Deterministic keygen test passed\n");
-	}
+	TEST_ASSERT_BUFFERS_ARE_EQUAL(vector->dk.data,
+		self->result_op->asym->mlkem.keygen.dk.data,
+		self->result_op->asym->mlkem.keygen.dk.length,
+		"Incorrect Decapsulation key\n");
+	TEST_ASSERT_BUFFERS_ARE_EQUAL(vector->ek.data,
+		self->result_op->asym->mlkem.keygen.ek.data,
+		self->result_op->asym->mlkem.keygen.ek.length,
+		"Incorrect Encapsulation key\n");
+	RTE_LOG(DEBUG, USER1, "Deterministic keygen test passed\n");
 
 	rte_cryptodev_asym_session_free(dev_id, self->sess);
 	return TEST_SUCCESS;
@@ -4071,7 +4067,7 @@ mlkem_encap(const void *test_data)
 	self->op->asym->mlkem.decap.sk.data = sk;
 	self->op->asym->mlkem.decap.sk.length = 32;
 
-	TEST_ASSERT_SUCCESS(send_one(),
+	TEST_ASSERT_SUCCESS(send_one_no_status_check(),
 		"Failed to process crypto op (ML-KEM Decap)");
 
 	debug_hexdump(stdout, "Shared secret from negative test",
@@ -4149,7 +4145,7 @@ mlkem_decap(const void *test_data)
 	self->op->asym->mlkem.decap.sk.data = sk;
 	self->op->asym->mlkem.decap.sk.length = 32;
 
-	TEST_ASSERT_SUCCESS(send_one(),
+	TEST_ASSERT_SUCCESS(send_one_no_status_check(),
 		"Failed to process crypto op (ML-KEM Decap)");
 
 	debug_hexdump(stdout, "Shared secret from negative test",
@@ -4214,19 +4210,15 @@ mldsa_keygen(const void *test_data)
 		rte_crypto_ml_dsa_pubkey_size[vector->type],
 		"Incorrect Public key length\n");
 
-	/* If the seed is all zero, keys are deterministic */
-	if (memcmp(vector->seed.data, (uint8_t [32]) {0},
-			vector->seed.length) == 0) {
-		TEST_ASSERT_BUFFERS_ARE_EQUAL(vector->privkey.data,
-			self->result_op->asym->mldsa.keygen.privkey.data,
-			self->result_op->asym->mldsa.keygen.privkey.length,
-			"Incorrect Private key\n");
-		TEST_ASSERT_BUFFERS_ARE_EQUAL(vector->pubkey.data,
-			self->result_op->asym->mldsa.keygen.pubkey.data,
-			self->result_op->asym->mldsa.keygen.pubkey.length,
-			"Incorrect Public key\n");
-		RTE_LOG(DEBUG, USER1, "Deterministic keygen test passed\n");
-	}
+	TEST_ASSERT_BUFFERS_ARE_EQUAL(vector->privkey.data,
+		self->result_op->asym->mldsa.keygen.privkey.data,
+		self->result_op->asym->mldsa.keygen.privkey.length,
+		"Incorrect Private key\n");
+	TEST_ASSERT_BUFFERS_ARE_EQUAL(vector->pubkey.data,
+		self->result_op->asym->mldsa.keygen.pubkey.data,
+		self->result_op->asym->mldsa.keygen.pubkey.length,
+		"Incorrect Public key\n");
+	RTE_LOG(DEBUG, USER1, "Deterministic keygen test passed\n");
 
 	rte_cryptodev_asym_session_free(dev_id, self->sess);
 	return TEST_SUCCESS;
diff --git a/app/test/test_cryptodev_ml_dsa_test_vectors.h b/app/test/test_cryptodev_ml_dsa_test_vectors.h
index f2453b9f34..675a6fad04 100644
--- a/app/test/test_cryptodev_ml_dsa_test_vectors.h
+++ b/app/test/test_cryptodev_ml_dsa_test_vectors.h
@@ -1653,6 +1653,14 @@ struct crypto_testsuite_mldsa_params mldsa_keygen_test_vectors[] = {
 			.data = mldsa_44_seed,
 			.length = sizeof(mldsa_44_seed),
 		},
+		.privkey = {
+			.data = mldsa_44_privkey,
+			.length = sizeof(mldsa_44_privkey),
+		},
+		.pubkey = {
+			.data = mldsa_44_pubkey,
+			.length = sizeof(mldsa_44_pubkey),
+		},
 	},
 	{
 		.name = "mldsa_44_keygen (deterministic)",
diff --git a/app/test/test_cryptodev_ml_kem_test_vectors.h b/app/test/test_cryptodev_ml_kem_test_vectors.h
index 8294acc29e..a1d727b969 100644
--- a/app/test/test_cryptodev_ml_kem_test_vectors.h
+++ b/app/test/test_cryptodev_ml_kem_test_vectors.h
@@ -785,6 +785,14 @@ struct crypto_testsuite_mlkem_params mlkem_keygen_test_vectors[] = {
 			.data = mlkem_512_z,
 			.length = sizeof(mlkem_512_z),
 		},
+		.dk = {
+			.data = mlkem_512_dk,
+			.length = sizeof(mlkem_512_dk),
+		},
+		.ek = {
+			.data = mlkem_512_ek,
+			.length = sizeof(mlkem_512_ek),
+		}
 	},
 	{
 		.name = "mlkem_512_keygen (deterministic)",
-- 
2.37.1

