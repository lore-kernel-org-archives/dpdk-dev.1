Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D64606A31A
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 Oct 2026 20:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=iol.unh.edu header.i=@iol.unh.edu header.a=rsa-sha256 header.s=unh-iol header.b=OevrBm+w
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EFE9D402E8;
	Mon, 26 Oct 2026 21:17:19 +0100 (CET)
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com
 [209.85.219.44])
 by mails.dpdk.org (Postfix) with ESMTPS id 490FB40041
 for <dev@dpdk.org>; Mon, 26 Oct 2026 21:17:18 +0100 (CET)
Received: by mail-qv1-f44.google.com with SMTP id
 6a1803df08f44-91bb5795792so40437926d6.2
 for <dev@dpdk.org>; Mon, 26 Oct 2026 13:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1793045837; x=1793650637; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/fis5eIKmhf7JlYuCywHKzzAoUjDZ3Z7HPWXStXwnj8=;
 b=OevrBm+wHVtSxtT/PKkEcQbl8JsBkcrFpcJLoBQurYw84vhLJQeoow4RqYuHtEYWdX
 SLN2PH4VU6TwzMduePeKIOJZh+Jja5omQ9A89YAPy7LAg6YjJgxtpV1hzf+1rsS58VEj
 hTOBO+yZpNQTx8jZpzTDZ9dJ4O0pfoonjoavg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793045837; x=1793650637;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=/fis5eIKmhf7JlYuCywHKzzAoUjDZ3Z7HPWXStXwnj8=;
 b=lUT4mfV/BsYXUBMKtFmDKjSpPdXeC0SbO3R5U0vjlx5LQHLVen0AtcYD6Y+WrtGHlq
 fvOnakXxzlAnAeMcI1QjKAeZiu/Ys97LQu2KJGtu/rLiYOvtOQK/A4hpjnU7DMerW9sU
 Xwfm69NINaSQbkzB+kJeKvGTPO/rEs6937FyW0IAaERnN+9BFADfYWlkYH5ArQBMvKcI
 Ptr2gTDrfapcElr2UKnxWzwv/ilZjVA+m1UR4rEC5uRKZ828tyhdPeODIWXhr/RCBXfQ
 T2GgMrZQ1i5c3WQs6FumS49gNjud6oOWJxX1/TYq6kxF5OLs7MN1bNmtOBfDVdThutW9
 mfog==
X-Gm-Message-State: AFq9FYJQcrtGW7ZlhWrf4H0dgInRxE4bO1MYtmZYfzfZjd1ULFip5E6C
 akYgm6P0e3NbBp5MqBBHjqlYK52bA1jeP4/WIuxWELYsPPv2u0EHwu/E7uvDRycEYGov1q+kH9v
 6OrfvHpchfs6yZvatq1iTtLOoRDLvP1NJE+riq5l3R7YTEeNC5wqa/ITfdl5Jwp+jw59jv1Qetn
 AQxev1PXcsXcsZyABRNbp87lJkyHE=
X-Gm-Gg: AYBFou3Glj9+Fiwv0lTgHt+6fEDDIgEqNDWM+C06NkQw/jk/t+QtjbNKRO/hxRuVOOb
 VdZCM8dXtTLUKrnCVwJYGyaT1lKfHRJNhFMWybG9zibyWCgtXUHaHqDiKVf2MBosyPG3g4QSZFl
 cE/k9pnvnboAJWNdRwigg8NlkKcqpTW27ZW2hROv0/qvDl+OzaTJNitsVb+JAji6RHZH+geXRiQ
 iZUJ0yHgWYoL0Pam3upxL+4yJcMjvxqycskRb6itjm7fvm1QeAkQUNZy8TJ8HuO/8I9u7xGkm+3
 T0EnVDNsrTqh6+qiD0j9XxNM84f7wtWLUB+yZtXlKR5ez0CVvdK2LKYUK4TCQIJh62rtH/vZu59
 jto76fEzmaje8gCSs+Z8Tw6FI59j936ZLlijpljqhDvrKj1p/g8sKwhG7S/KT0DoXq6MwUF6kNv
 P7KgaDNP8AdXtCG5mbbF/Eyn5/fkHiA+YiJ8B4J6NMRS3aOD4NZGxB79w4XzFdZrhTwaGr2dhRm
 bc4oNBHTBCNHWWwaxhGOduKC+OrsrSm9yeuT0yDe3Jscy8uJ7ZXsqgRLIhoyr3u06Uqb6us1Btb
 6IB479h2bL8dBspjS3quEN0lW0votpuXEtTlWbm8VOlX6CtosGo=
X-Received: by 2002:a05:6214:4292:b0:912:517b:844 with SMTP id
 6a1803df08f44-91c48e56a41mr128891186d6.40.1793045836808; 
 Mon, 26 Oct 2026 13:17:16 -0700 (PDT)
Received: from d121029.iol.unh.edu ([2606:4100:3880:1210::219])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91c47c50e10sm81969766d6.25.2026.10.26.13.17.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 13:17:16 -0700 (PDT)
From: Andrew Bailey <abailey@iol.unh.edu>
To: dev@dpdk.org,
	luca.vizzarro@arm.com,
	patrickrobb1997@gmail.com
Cc: knimoji@iol.unh.edu, lylavoie@iol.unh.edu, dladd@iol.unh.edu,
 Andrew Bailey <abailey@iol.unh.edu>
Subject: [PATCH v5 1/3] dts: add directory for test resources
Date: Mon, 26 Oct 2026 16:16:41 -0400
Message-ID: <20261026201643.72369-2-abailey@iol.unh.edu>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261026201643.72369-1-abailey@iol.unh.edu>
References: <20260428193541.79005-1-abailey@iol.unh.edu>
 <20261026201643.72369-1-abailey@iol.unh.edu>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Some tests can require additional data files for testing input.
This commit adds a dedicated space for data files that can be utilized
by test suites in DTS.

Signed-off-by: Andrew Bailey <abailey@iol.unh.edu>
---
 dts/api/cryptodev/__init__.py        |  2 +-
 dts/test_resources/test_aes_cbc.data | 27 +++++++++++++++++++++++++++
 dts/test_resources/test_aes_gcm.data | 19 +++++++++++++++++++
 3 files changed, 47 insertions(+), 1 deletion(-)
 create mode 100644 dts/test_resources/test_aes_cbc.data
 create mode 100644 dts/test_resources/test_aes_gcm.data

diff --git a/dts/api/cryptodev/__init__.py b/dts/api/cryptodev/__init__.py
index 496079c2af..a3ad59f7f0 100644
--- a/dts/api/cryptodev/__init__.py
+++ b/dts/api/cryptodev/__init__.py
@@ -76,7 +76,7 @@ def vector_directory(self) -> PurePath:
         Returns:
             The path to the cryptodev vector files.
         """
-        return get_ctx().dpdk_build.remote_dpdk_tree_path.joinpath("app/test-crypto-perf/data/")
+        return get_ctx().dpdk_build.remote_dpdk_tree_path.joinpath("dts/test_resources/")
 
     def run_app(self, num_vfs: int = 1) -> list[CryptodevResults]:
         """Run the cryptodev application with the given app parameters.
diff --git a/dts/test_resources/test_aes_cbc.data b/dts/test_resources/test_aes_cbc.data
new file mode 100644
index 0000000000..ac7a89942f
--- /dev/null
+++ b/dts/test_resources/test_aes_cbc.data
@@ -0,0 +1,27 @@
+# Global Section
+plaintext =
+0xff, 0xca, 0xfb, 0xf1, 0x38, 0x20, 0x2f, 0x7b, 0x24, 0x98, 0x26, 0x7d, 0x1d, 0x9f, 0xb3, 0x93,
+0xd9, 0xef, 0xbd, 0xad, 0x4e, 0x40, 0xbd, 0x60, 0xe9, 0x48, 0x59, 0x90, 0x67, 0xd7, 0x2b, 0x7b
+ciphertext =
+0x77, 0xF9, 0xF7, 0x7A, 0xA3, 0xCB, 0x68, 0x1A, 0x11, 0x70, 0xD8, 0x7A, 0xB6, 0xE2, 0x37, 0x7E,
+0xD1, 0x57, 0x1C, 0x8E, 0x85, 0xD8, 0x08, 0xBF, 0x57, 0x1F, 0x21, 0x6C, 0xAD, 0xAD, 0x47, 0x1E
+cipher_key =
+0xE4, 0x23, 0x33, 0x8A, 0x35, 0x64, 0x61, 0xE2, 0x49, 0x03, 0xDD, 0xC6, 0xB8, 0xCA, 0x55, 0x7A,
+0xd0, 0xe7, 0x4b, 0xfb, 0x5d, 0xe5, 0x0c, 0xe7, 0x6f, 0x21, 0xb5, 0x52, 0x2a, 0xbb, 0xc7, 0xf7
+auth_key =
+0xaf, 0x96, 0x42, 0xf1, 0x8c, 0x50, 0xdc, 0x67, 0x1a, 0x43, 0x47, 0x62, 0xc7, 0x04, 0xab, 0x05,
+0xf5, 0x0c, 0xe7, 0xa2, 0xa6, 0x23, 0xd5, 0x3d, 0x95, 0xd8, 0xcd, 0x86, 0x79, 0xf5, 0x01, 0x47,
+0x4f, 0xf9, 0x1d, 0x9d, 0x36, 0xf7, 0x68, 0x1a, 0x64, 0x44, 0x58, 0x5d, 0xe5, 0x81, 0x15, 0x2a,
+0x41, 0xe4, 0x0e, 0xaa, 0x1f, 0x04, 0x21, 0xff, 0x2c, 0xf3, 0x73, 0x2b, 0x48, 0x1e, 0xd2, 0xf7
+cipher_iv =
+0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09, 0x0A, 0x0B, 0x0C, 0x0D, 0x0E, 0x0F
+# Section sha 1 hmac buff 32
+[sha1_hmac_buff_32]
+digest =
+0x36, 0xCA, 0x49, 0x6A, 0xE3, 0x54, 0xD8, 0x4F, 0x0B, 0x76, 0xD8, 0xAA, 0x78, 0xEB, 0x9D, 0x65,
+0x2C, 0xCA, 0x1F, 0x97
+# Section sha 256 hmac buff 32
+[sha256_hmac_buff_32]
+digest =
+0x1C, 0xB2, 0x3D, 0xD1, 0xF9, 0xC7, 0x6C, 0x49, 0x2E, 0xDA, 0x94, 0x8B, 0xF1, 0xCF, 0x96, 0x43,
+0x67, 0x50, 0x39, 0x76, 0xB5, 0xA1, 0xCE, 0xA1, 0xD7, 0x77, 0x10, 0x07, 0x43, 0x37, 0x05, 0xB4
diff --git a/dts/test_resources/test_aes_gcm.data b/dts/test_resources/test_aes_gcm.data
new file mode 100644
index 0000000000..034f4fa91a
--- /dev/null
+++ b/dts/test_resources/test_aes_gcm.data
@@ -0,0 +1,19 @@
+# Global Section
+plaintext =
+0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11,
+0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11
+
+ciphertext =
+0x82, 0x7d, 0xb6, 0xdf, 0x77, 0x0a, 0xe6, 0x45, 0x5a, 0xc3, 0x70, 0x9b, 0x27, 0xb2, 0x61, 0x19,
+0xa2, 0x37, 0x0b, 0xf7, 0x42, 0xfc, 0xec, 0xe7, 0xf7, 0x30, 0xe0, 0x3c, 0x05, 0x55, 0xb3, 0x7d
+
+aead_key =
+0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09, 0x0A, 0x0B, 0x0C, 0x0D, 0x0E, 0x0F
+aead_iv =
+0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09, 0x0A, 0x0B
+aead_aad =
+0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09, 0x0A, 0x0B, 0x0C, 0x0D, 0x0E, 0x0F
+
+[aes_gcm_buff_32]
+digest =
+0x0f, 0xb2, 0x98, 0x59, 0x48, 0xbf, 0x6c, 0x37, 0x5a, 0xad, 0xcd, 0x97, 0x9f, 0xbb, 0xc8, 0x2a
-- 
2.56.0

