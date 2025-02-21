Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E339EC021B5
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Feb 2025 17:30:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4D493411F3;
	Fri, 21 Feb 2025 18:30:46 +0100 (CET)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 470484113C
 for <dev@dpdk.org>; Fri, 21 Feb 2025 18:30:44 +0100 (CET)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51L8OaZk019470;
 Fri, 21 Feb 2025 09:30:43 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=8
 YgM82bgyTm9DKATS8nToWpeEIuiNGeeUdL1+Ix71xw=; b=BWxZcATiLc1qr5FNq
 58vkKdBWFIGgP+5rgvnOkejO1+pka6jBDq4fd1RTqIlonpS1Qsuk7L1cMWd6LpjQ
 o89cyCWTMPkJtmdLgBE3FNay96j+4zuSG9gT4QHR5am8B/aJQ0JUBB/Vec1B3b1y
 czCTuLNr1ZYmZFdbzplpR6mvpuCyI15hhrMAuKBHzfY+B4JyGU0A+wfxREMrjiUn
 r7wjKOYz0F86vQ5TU5aniuHwHKxmRqhhs99pLaSYYsTuMe6CiKkePhpmLC6eJU+5
 u7QfCyAbVRHidO/Nx6q2xze/z3I/0cI10hpaCzgXvf97vNU6gBQ4bftBg93Puavk
 4nWtQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 44xnxu91c8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 21 Feb 2025 09:30:43 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 21 Feb 2025 09:30:42 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 21 Feb 2025 09:30:42 -0800
Received: from IN-lckQE5Rwctls.marvell.com (unknown [10.193.66.72])
 by maili.marvell.com (Postfix) with ESMTP id AF4123F7090;
 Fri, 21 Feb 2025 09:30:39 -0800 (PST)
From: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
To: <dev@dpdk.org>, <maxime.coquelin@redhat.com>, Chenbo Xia
 <chenbox@nvidia.com>
CC: <anoobj@marvell.com>, Akhil Goyal <gakhil@marvell.com>, "Gowrishankar
 Muthukrishnan" <gmuthukrishn@marvell.com>
Subject: [v3 2/5] vhost: update vhost_user crypto session parameters
Date: Fri, 21 Feb 2025 23:00:10 +0530
Message-ID: <c4c8430e62eff1d67863bc89b1a309e435aa2c2f.1740156665.git.gmuthukrishn@marvell.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <cover.1740156665.git.gmuthukrishn@marvell.com>
References: <cover.1740156665.git.gmuthukrishn@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: os_iRIM-F50qbDDHonfPzL8ASgktSl4k
X-Proofpoint-ORIG-GUID: os_iRIM-F50qbDDHonfPzL8ASgktSl4k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-21_05,2025-02-20_02,2024-11-22_01
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

Update VhostUserCryptoSessionParam structure to support newer QEMU.
Due to additional parameters added in QEMU, received payload from
QEMU would be larger than existing payload, hence breaks parsing
vhost_user message.

This patch addresses both of the above problems.

Signed-off-by: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
---
v3:
 - decoupled originally from v2 series single patch.
---

 lib/vhost/vhost_crypto.c | 12 ++++++------
 lib/vhost/vhost_user.h   | 33 +++++++++++++++++++++++++++++----
 2 files changed, 35 insertions(+), 10 deletions(-)

diff --git a/lib/vhost/vhost_crypto.c b/lib/vhost/vhost_crypto.c
index 55ea24710e..05f3c85884 100644
--- a/lib/vhost/vhost_crypto.c
+++ b/lib/vhost/vhost_crypto.c
@@ -237,7 +237,7 @@ struct vhost_crypto_data_req {
 
 static int
 transform_cipher_param(struct rte_crypto_sym_xform *xform,
-		VhostUserCryptoSessionParam *param)
+		VhostUserCryptoSymSessionParam *param)
 {
 	int ret;
 
@@ -273,7 +273,7 @@ transform_cipher_param(struct rte_crypto_sym_xform *xform,
 
 static int
 transform_chain_param(struct rte_crypto_sym_xform *xforms,
-		VhostUserCryptoSessionParam *param)
+		VhostUserCryptoSymSessionParam *param)
 {
 	struct rte_crypto_sym_xform *xform_cipher, *xform_auth;
 	int ret;
@@ -341,10 +341,10 @@ vhost_crypto_create_sess(struct vhost_crypto *vcrypto,
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
@@ -352,7 +352,7 @@ vhost_crypto_create_sess(struct vhost_crypto *vcrypto,
 		}
 		break;
 	case VIRTIO_CRYPTO_SYM_OP_ALGORITHM_CHAINING:
-		if (unlikely(sess_param->hash_mode !=
+		if (unlikely(sess_param->u.sym_sess.hash_mode !=
 				VIRTIO_CRYPTO_SYM_HASH_MODE_AUTH)) {
 			sess_param->session_id = -VIRTIO_CRYPTO_NOTSUPP;
 			VC_LOG_ERR("Error transform session message (%i)",
@@ -362,7 +362,7 @@ vhost_crypto_create_sess(struct vhost_crypto *vcrypto,
 
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

