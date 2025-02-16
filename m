Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1764C021A4
	for <dpdk-dev@archiver.kernel.org>; Sun, 16 Feb 2025 17:02:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B3A7840ED2;
	Sun, 16 Feb 2025 18:01:36 +0100 (CET)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by mails.dpdk.org (Postfix) with ESMTP id E875A40E37
 for <dev@dpdk.org>; Sun, 16 Feb 2025 18:01:29 +0100 (CET)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-220e83d65e5so51015395ad.1
 for <dev@dpdk.org>; Sun, 16 Feb 2025 09:01:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739725289;
 x=1740330089; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c8mVx65OZgwlPD3YqCSP4AJR4DoGBjJVIPIjf98KaNw=;
 b=Rk9NXfxX9bshNuibx/07c+o1fV4mI97LUAsaj0Ee8Ln75m0kvZGrsNrqAhGg4Eib1m
 /TKw3SR6pozGqhCsAt3EdH9IsYs+oucBKDiJ2DOO014R0TttTziSZU48k1K9ZGCFACI8
 YP1MTfJrj9bNomPnRakye6UThRMO08rNBbs24armVFJnjlWpsP2uc/B9pzCCbyctSPrN
 v3GDaFismx/cOUTVwi1kXEMY3SGp3zklAUiMlE5gNRXPBPt3csKTx1zGLRLftoqayPbb
 SWjC2sBdEWlZSLd+6xEmGsAf1tE2MKPtUTpI+sKfzEpRoXcRNwDCpO9nX4ZOTlUBI8ha
 BT4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739725289; x=1740330089;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c8mVx65OZgwlPD3YqCSP4AJR4DoGBjJVIPIjf98KaNw=;
 b=ErOFat+yHkQwOiSHW9N5iko6SlwvwAR9e5g0rSDk/RnU40SZ3+1oA9H42HPonfVLFu
 +zVmX7K0Q/Za/n9zxn5CoMFt4UTf55ktslJeoKLI8J0GP2BJrZTf+jAO+J1fD8Vw3mWN
 sMW+kPkJt3omErU5JZPbAS9Vh0hRHzE257rovmajjk5s6+hnhyH0NkbG83ofXdIo88Bm
 mF1rRQyQ+p9ZEov3s7c2BRhfZbkiLhdKHtxtIF0rJhYyMt/fEEt3/12BtRFJ7iOYGL5x
 2uTp1w+frChV3ys0Glkl22xZKnOHLnapbUs/uotOcTeqYtd+tQ5QvK/orgzPhJnNvOQc
 qwJA==
X-Gm-Message-State: AOJu0YynAG689xPZK/2Uzg3tVgGNqKOueS0BRbKHd0aR/3YdVJRJ26ah
 UVrFPs0pfKHiP86gnk5zrMEjf1ww3nfxWagC9do2vg03yf6Vno5qoABER2O5biGeGs+ZpkqHJIK
 k
X-Gm-Gg: ASbGncv9yiK7h1oNCr3j3IoXFEdwYrREJ2XqEZgIi1ldrNq64NLqLb1/596oKboL0zO
 6DrCTZmU99CoeXAOM2rMJyTOoPvb2a6JoGu1bcp54cX9a4jjf1racQBVlQEOSyiB+b/cvAkk7Bu
 MyRktLqSFoMTY8PoY2lNVaxDIEfXkvL30hykHx8wqw/PJkoMiwdkpALZufiSkoMlmonJa1zjxCZ
 lR5pgFmd4H3e7XQv88s3cPU8oqXnbX1T0fE77M7rnLIm4smYwfTaDekuYMiUUe1JpX/TEBL3+Vq
 HC7NI4g9uQReCavSf+1zUdlIY41SLWrzd7TwzjHrLhy1AEfRdpK1NLdBw7MRV6lmCWvs
X-Google-Smtp-Source: AGHT+IFdmOJwFsMuEc8aiwFbtI4nPUo6JodbZ9v1KZjETRRECBEiusMIGi4uBTOUHIx1C20ptWCIhg==
X-Received: by 2002:a17:902:ecc7:b0:220:c2a8:6fbc with SMTP id
 d9443c01a7336-221040ac132mr86211975ad.34.1739725288972; 
 Sun, 16 Feb 2025 09:01:28 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2211eafd20dsm11196805ad.182.2025.02.16.09.01.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 09:01:28 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Bruce Richardson <bruce.richardson@intel.com>, Kai Ji <kai.ji@intel.com>,
 Ciara Power <ciara.power@intel.com>, Fan Zhang <fanzhang.oss@gmail.com>
Subject: [PATCH v8 10/17] crypto/qat: fix size calculation for memset
Date: Sun, 16 Feb 2025 08:53:09 -0800
Message-ID: <20250216170110.7230-11-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250216170110.7230-1-stephen@networkplumber.org>
References: <20241114011129.451243-1-stephen@networkplumber.org>
 <20250216170110.7230-1-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The memset was always doing 0 bytes since size computed later.

Link: https://pvs-studio.com/en/blog/posts/cpp/1179/

Fixes: 3a80d7fb2ecd ("crypto/qat: support SHA3 plain hash")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/crypto/qat/qat_sym_session.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/crypto/qat/qat_sym_session.c b/drivers/crypto/qat/qat_sym_session.c
index 3564a33484..7836c95064 100644
--- a/drivers/crypto/qat/qat_sym_session.c
+++ b/drivers/crypto/qat/qat_sym_session.c
@@ -2347,7 +2347,7 @@ int qat_sym_cd_cipher_set(struct qat_sym_session *cdesc,
 	return 0;
 }
 
-int qat_sym_cd_auth_set(struct qat_sym_session *cdesc,
+static int qat_sym_cd_auth_set(struct qat_sym_session *cdesc,
 		const uint8_t *authkey,
 		uint32_t authkeylen,
 		uint32_t aad_length,
@@ -2620,27 +2620,27 @@ int qat_sym_cd_auth_set(struct qat_sym_session *cdesc,
 		break;
 	case ICP_QAT_HW_AUTH_ALGO_SHA3_224:
 		/* Plain SHA3-224 */
-		memset(cdesc->cd_cur_ptr, 0, state1_size);
 		state1_size = qat_hash_get_state1_size(
 				cdesc->qat_hash_alg);
+		memset(cdesc->cd_cur_ptr, 0, state1_size);
 		break;
 	case ICP_QAT_HW_AUTH_ALGO_SHA3_256:
 		/* Plain SHA3-256 */
-		memset(cdesc->cd_cur_ptr, 0, state1_size);
 		state1_size = qat_hash_get_state1_size(
 				cdesc->qat_hash_alg);
+		memset(cdesc->cd_cur_ptr, 0, state1_size);
 		break;
 	case ICP_QAT_HW_AUTH_ALGO_SHA3_384:
 		/* Plain SHA3-384 */
-		memset(cdesc->cd_cur_ptr, 0, state1_size);
 		state1_size = qat_hash_get_state1_size(
 				cdesc->qat_hash_alg);
+		memset(cdesc->cd_cur_ptr, 0, state1_size);
 		break;
 	case ICP_QAT_HW_AUTH_ALGO_SHA3_512:
 		/* Plain SHA3-512 */
-		memset(cdesc->cd_cur_ptr, 0, state1_size);
 		state1_size = qat_hash_get_state1_size(
 				cdesc->qat_hash_alg);
+		memset(cdesc->cd_cur_ptr, 0, state1_size);
 		break;
 	case ICP_QAT_HW_AUTH_ALGO_AES_XCBC_MAC:
 		state1_size = ICP_QAT_HW_AES_XCBC_MAC_STATE1_SZ;
-- 
2.47.2

