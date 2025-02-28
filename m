Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2904EC282CD
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Feb 2025 13:47:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 82A6E40E44;
	Fri, 28 Feb 2025 14:47:56 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 1E30240E3F
 for <dev@dpdk.org>; Fri, 28 Feb 2025 14:47:55 +0100 (CET)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51SB1MBB025997;
 Fri, 28 Feb 2025 05:47:54 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=y
 fN6brKmKqGRBsdDEz9HirT1w+KRwrfGVpffZjII0yY=; b=bdEUayYbgn1Mbgt8C
 UCYTu6AB/Zkdw5jRCqV8gVt528aAHURWMHQpcuNfI+84QN/gHpyNr/TNcZf89k6H
 OK8VKyYFNJkV9g1+chGj1bJEq+lm6/plzCgbBfG/Up5abru9cAwY5iTd8KM6dkNx
 +tpTJkXRtiST2y83H86uUYkXthy/Vw24wSvvn/MfuPFpeBsQXTjtjqhsO9LVqekw
 4fTLysg2baMBd8dWtZ3WcLlrmUHE0DiYJYF8fmmAXGXs7YjK1+Dm0ALRt/fJKoLi
 wM5IZ/XlbYEknnYu2sJr2Hx+1uPxoE8pmwBYd2IUe9XVcE+zadWTIyQEp87qZsKB
 TircQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4537rcgmn7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 28 Feb 2025 05:47:54 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 28 Feb 2025 05:47:53 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 28 Feb 2025 05:47:53 -0800
Received: from IN-lckQE5Rwctls.marvell.com (unknown [10.28.163.68])
 by maili.marvell.com (Postfix) with ESMTP id 908655B692E;
 Fri, 28 Feb 2025 05:47:50 -0800 (PST)
From: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
To: <dev@dpdk.org>, <maxime.coquelin@redhat.com>, Chenbo Xia
 <chenbox@nvidia.com>
CC: <anoobj@marvell.com>, Akhil Goyal <gakhil@marvell.com>, David Marchand
 <david.marchand@redhat.com>, Gowrishankar Muthukrishnan
 <gmuthukrishn@marvell.com>
Subject: [v9 3/6] vhost: update vhost_user crypto session parameters
Date: Fri, 28 Feb 2025 19:17:10 +0530
Message-ID: <97a98ed53d1ca36d3d4f2cfee9958d804e2a5966.1740749809.git.gmuthukrishn@marvell.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <cover.1740749809.git.gmuthukrishn@marvell.com>
References: <cover.1740749809.git.gmuthukrishn@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: S14YIBTw84ZwXrWZfRFAriOs_uyWaAWt
X-Proofpoint-ORIG-GUID: S14YIBTw84ZwXrWZfRFAriOs_uyWaAWt
X-Authority-Analysis: v=2.4 cv=GcvtnRXL c=1 sm=1 tr=0 ts=67c1be8a cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=T2h4t0Lz3GQA:10 a=M5GUcnROAAAA:8 a=laCGInfEmNnMqFV-ZLIA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-28_03,2025-02-27_01,2024-11-22_01
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

As per requirements on vhost_user spec, session id should be
located at the end of session parameter.

Update VhostUserCryptoSessionParam structure to support newer QEMU
versions (v9). Due to additional parameters added in QEMU,
received payload from QEMU would be larger than existing payload.
Hence, it would break parsing vhost_user messages.

This patch addresses both of the above problems.

Signed-off-by: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
Acked-by: Akhil Goyal <gakhil@marvell.com>
---
 lib/vhost/vhost_crypto.c | 12 ++++++------
 lib/vhost/vhost_user.h   | 33 +++++++++++++++++++++++++++++----
 2 files changed, 35 insertions(+), 10 deletions(-)

diff --git a/lib/vhost/vhost_crypto.c b/lib/vhost/vhost_crypto.c
index 38c5a7f06f..5050c2c7b3 100644
--- a/lib/vhost/vhost_crypto.c
+++ b/lib/vhost/vhost_crypto.c
@@ -238,7 +238,7 @@ struct vhost_crypto_data_req {
 
 static int
 transform_cipher_param(struct rte_crypto_sym_xform *xform,
-		VhostUserCryptoSessionParam *param)
+		VhostUserCryptoSymSessionParam *param)
 {
 	int ret;
 
@@ -274,7 +274,7 @@ transform_cipher_param(struct rte_crypto_sym_xform *xform,
 
 static int
 transform_chain_param(struct rte_crypto_sym_xform *xforms,
-		VhostUserCryptoSessionParam *param)
+		VhostUserCryptoSymSessionParam *param)
 {
 	struct rte_crypto_sym_xform *xform_cipher, *xform_auth;
 	int ret;
@@ -342,10 +342,10 @@ vhost_crypto_create_sess(struct vhost_crypto *vcrypto,
 	struct rte_cryptodev_sym_session *session;
 	int ret;
 
-	switch (sess_param->op_type) {
+	switch (sess_param->u.sym_sess.op_type) {
 	case VIRTIO_CRYPTO_SYM_OP_NONE:
 	case VIRTIO_CRYPTO_SYM_OP_CIPHER:
-		ret = transform_cipher_param(&xform1, sess_param);
+		ret = transform_cipher_param(&xform1, &sess_param->u.sym_sess);
 		if (unlikely(ret)) {
 			VC_LOG_ERR("Error transform session msg (%i)", ret);
 			sess_param->session_id = ret;
@@ -353,7 +353,7 @@ vhost_crypto_create_sess(struct vhost_crypto *vcrypto,
 		}
 		break;
 	case VIRTIO_CRYPTO_SYM_OP_ALGORITHM_CHAINING:
-		if (unlikely(sess_param->hash_mode !=
+		if (unlikely(sess_param->u.sym_sess.hash_mode !=
 				VIRTIO_CRYPTO_SYM_HASH_MODE_AUTH)) {
 			sess_param->session_id = -VIRTIO_CRYPTO_NOTSUPP;
 			VC_LOG_ERR("Error transform session message (%i)",
@@ -363,7 +363,7 @@ vhost_crypto_create_sess(struct vhost_crypto *vcrypto,
 
 		xform1.next = &xform2;
 
-		ret = transform_chain_param(&xform1, sess_param);
+		ret = transform_chain_param(&xform1, &sess_param->u.sym_sess);
 		if (unlikely(ret)) {
 			VC_LOG_ERR("Error transform session message (%i)", ret);
 			sess_param->session_id = ret;
diff --git a/lib/vhost/vhost_user.h b/lib/vhost/vhost_user.h
index 9a905ee5f4..ef486545ba 100644
--- a/lib/vhost/vhost_user.h
+++ b/lib/vhost/vhost_user.h
@@ -99,11 +99,10 @@ typedef struct VhostUserLog {
 /* Comply with Cryptodev-Linux */
 #define VHOST_USER_CRYPTO_MAX_HMAC_KEY_LENGTH	512
 #define VHOST_USER_CRYPTO_MAX_CIPHER_KEY_LENGTH	64
+#define VHOST_USER_CRYPTO_MAX_KEY_LENGTH	1024
 
 /* Same structure as vhost-user backend session info */
-typedef struct VhostUserCryptoSessionParam {
-	int64_t session_id;
-	uint32_t op_code;
+typedef struct VhostUserCryptoSymSessionParam {
 	uint32_t cipher_algo;
 	uint32_t cipher_key_len;
 	uint32_t hash_algo;
@@ -114,10 +113,36 @@ typedef struct VhostUserCryptoSessionParam {
 	uint8_t dir;
 	uint8_t hash_mode;
 	uint8_t chaining_dir;
-	uint8_t *ciphe_key;
+	uint8_t *cipher_key;
 	uint8_t *auth_key;
 	uint8_t cipher_key_buf[VHOST_USER_CRYPTO_MAX_CIPHER_KEY_LENGTH];
 	uint8_t auth_key_buf[VHOST_USER_CRYPTO_MAX_HMAC_KEY_LENGTH];
+} VhostUserCryptoSymSessionParam;
+
+
+typedef struct VhostUserCryptoAsymRsaParam {
+	uint32_t padding_algo;
+	uint32_t hash_algo;
+} VhostUserCryptoAsymRsaParam;
+
+typedef struct VhostUserCryptoAsymSessionParam {
+	uint32_t algo;
+	uint32_t key_type;
+	uint32_t key_len;
+	uint8_t *key;
+	union {
+		VhostUserCryptoAsymRsaParam rsa;
+	} u;
+	uint8_t key_buf[VHOST_USER_CRYPTO_MAX_KEY_LENGTH];
+} VhostUserCryptoAsymSessionParam;
+
+typedef struct VhostUserCryptoSessionParam {
+	uint32_t op_code;
+	union {
+		VhostUserCryptoSymSessionParam sym_sess;
+		VhostUserCryptoAsymSessionParam asym_sess;
+	} u;
+	int64_t session_id;
 } VhostUserCryptoSessionParam;
 
 typedef struct VhostUserVringArea {
-- 
2.25.1

