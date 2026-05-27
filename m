Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC791CD5BDE
	for <dpdk-dev@archiver.kernel.org>; Wed, 27 May 2026 09:14:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0A44640285;
	Wed, 27 May 2026 11:14:15 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 69D614026C;
 Wed, 27 May 2026 11:14:13 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64R7BA531466513; Wed, 27 May 2026 02:14:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=Z
 /tGIdkdARWXfRo1IYnPJImY6dnjTax4Bu8kf9gvWVM=; b=gnKCLLeIuZes+1dwT
 s5qQP/hNJYzH1IqgrqE0ML+3j4CwOPO60442Y7tQN+z5XTMD+FMBBGGslxzVHRje
 IHYIFjIog2jnO9XkcVbYJ/Yvt5WJFcJGEsFP4dxMoukZBB6E2kszZOFfgoOKWtK8
 R97ZrjkCpjMyMCyp+k/EwIg2kLrJfXjo+xSB7g4cCdQuB0u0VgZ+UleJgM1LW4gn
 qSw6fvj9NfpXpQfsR985wlcEeyFTCVkXX80Chum+ht33pxpS7JBUbLByREUWcZ9i
 9aLuV2Pg68F/ZBjdwNH9iBo0/4auYmAdSnEUIWExCroI5SrlN0mui2LlEnMxbql1
 w+60Q==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4ebbrfbbyx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 27 May 2026 02:14:12 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 27 May 2026 02:14:11 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 27 May 2026 02:14:11 -0700
Received: from IN-lckQE5Rwctls.marvell.com (IN-lckQE5Rwctls.marvell.com
 [10.28.167.66])
 by maili.marvell.com (Postfix) with ESMTP id 09FC93F704B;
 Wed, 27 May 2026 02:14:07 -0700 (PDT)
From: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
To: <dev@dpdk.org>, Akhil Goyal <gakhil@marvell.com>, Fan Zhang
 <fanzhang.oss@gmail.com>, Gowrishankar Muthukrishnan
 <gmuthukrishn@marvell.com>
CC: <stable@dpdk.org>
Subject: [v2 1/2] test/crypto: validate ML crypto keys
Date: Wed, 27 May 2026 14:43:59 +0530
Message-ID: <20260527091405.2105-1-gmuthukrishn@marvell.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260527085257.1933-1-gmuthukrishn@marvell.com>
References: <20260527085257.1933-1-gmuthukrishn@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=epTvCIpX c=1 sm=1 tr=0 ts=6a16b5e4 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=8rWy6zfcAAAA:8 a=M5GUcnROAAAA:8
 a=4oYLaZdSTXjDlawoNDMA:9 a=YjdVzJdQTyZRADMV7wFX:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: 7QxTyn06wbeuGlGTKFA6cSkn0o7RY-OT
X-Proofpoint-GUID: 7QxTyn06wbeuGlGTKFA6cSkn0o7RY-OT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI3MDA4OCBTYWx0ZWRfX6SANvu1b5KYV
 rsWcgnEhGXEnAn2GsWxUvfld/TNx7ku3abZcYG6k+RU7P0jq3WZXKyhieteJcwHdmYivXBQHDrW
 dnO3Wh0b8FVkS6jXLLf7vFduCsixPEaxAHoOwk6+7DgMPs+vXaHDjCq0jtHkH8M6+0Vz2gzPCUO
 SpvhcoFRlld/AcHLu1RYS/RzB2j+BfgoqqHjz6J2DO6oE080os6qQdr5w5CnPaEFMDJQFrJ/faM
 pIPIwAt/la2+kKTc/vxNwnGGFj64w0D29Z1fxB0zn9yt9viDwgxjfwxom4rWUdXqsCsaGIgxbMO
 0Cq2h6hkPWW2eLMdCfQq3xd1WZ1rDjOrzIeMU8+0yQfo+9sZYZVRHMKBCbxCop7oFlPBEI3FPei
 ChMxE+hlwX1E1cTost42fq9Ua93MBPpH6BBYWRj5f+jsKuYmCjc4FlJwR2vhzn7E2cA0zilDlnX
 //eIl5RH/QsO608roGw==
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

Fixes: 76a5877072c0 ("test/crypto: add ML-KEM and ML-DSA cases")
Cc: stable@dpdk.org

Signed-off-by: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
---
v2:
 - corrected Fixes tag.
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

