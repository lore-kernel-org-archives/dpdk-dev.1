Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25058606A31B
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 Oct 2026 20:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=iol.unh.edu header.i=@iol.unh.edu header.a=rsa-sha256 header.s=unh-iol header.b=QeEbOCfX
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 661E740297;
	Mon, 19 Oct 2026 22:22:58 +0200 (CEST)
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com
 [209.85.219.49]) by mails.dpdk.org (Postfix) with ESMTP id 5CCD74021E
 for <dev@dpdk.org>; Mon, 19 Oct 2026 22:22:57 +0200 (CEST)
Received: by mail-qv1-f49.google.com with SMTP id
 6a1803df08f44-91986c5cb75so27113206d6.0
 for <dev@dpdk.org>; Mon, 19 Oct 2026 13:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1792441376; x=1793046176; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=h/STup6nH7hwtN6j5TOswizARK6iStHGZ54sQzSt+2Q=;
 b=QeEbOCfXHY6n+8N8C9tYSt1w90WfCFE+dsdiLORtpI+VooRk4BV+3TEC2QAL4IcKDH
 38yxXZfo658QlDVCeGPlzSamj2m+KQyiwe+wn9zcGqjWF0ZorC1hWCHsJFOf9FvImXlL
 NF5b9QEhSZoKgWndynwUE5w1w7XM/Q/mTxP/M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792441376; x=1793046176;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=h/STup6nH7hwtN6j5TOswizARK6iStHGZ54sQzSt+2Q=;
 b=AtmEgfiyxpx8TK9taNchJMr0mPOPvFZr50IjagtO/i0YLnU6ihFxYs+ohxbkvuHJKJ
 F43wQcUdRRe9omhR3q+BREMuEi0cw0b5VHsTtQeamtmlxmFcb1XLtEbDs3JaWPVX4eJG
 lyNaPzzOrnW43ELd8y8moQd55q8kUMlcKY3zXjSiGKrVHyiqyPkauO23BpE5jjoRzsfi
 6bF9zkfwbNKcpfpKv0wxyvct6HRjtY9ymQbsz40A9aTY/ez/O1hZiX9kiv+p37IuRTQ3
 Wgty5pHrXnE5vKsZrdm35eN5aUzOxSQSm/HS3QweCUYNj39hFjqRESuxioHyZczT2O/m
 vUNw==
X-Gm-Message-State: AFq9FYJgxqhR9pXGLrzOMhIevx1hjAdAh6oC+yS6p5QunTzI1NuMTqvq
 4eK64FQx7N6FTPQ8t9o0yC2xhSxIIy6Io9iRDBrz69sMlhU8QlqjjOMgg3SxLy59ZO1ZH/fY21a
 oORoZvf5p0o+vD8CxY7nFg592WymXiou0U8JdBamaxlAOK6ni3T/LYFslYzYyufhkyuegFpXlBM
 xWQ1qSEXV7R2Dbj1PMUR0lHUZZLPk=
X-Gm-Gg: AYBFou2JmeyaYymqaN9vvcIIA31nhiW3hGe5kOdnJxZoegCOH5S1ADWhAMC+4QLKEkU
 rLliYOsOLN8uBCuPiXzKY7rQZ3FhQ8ootUSHre7Sgcx2j9PYFcyyFeWcpZ5acnGAhIVfo5nVnCp
 jiWGeTZGGt+EKg5ws3ZZ9eC8tzluYcA+q3fcnd8IPepDjzqs8dGetSiuHfvRQWP+EYy0oQR58QN
 bSc+rc5qwvE+xF60/YH33SdH9hgSICaVCUicgIJIxjhYCVyXCkBEMNQ2lGOfwFudpT1YJi7AJZ6
 8yb/ryQLEv2bgzBUJAzadMyAN8meh+mis+FIQSzHRZBTuFS4ZB2xiOcMxoTSuGIeKwFSNR6uWr6
 7L3sCS3vp3CBqvYmG1cSyEqkLp+O/VgIqgFjMRjELZx0g2wyAs37frjKfoz3lQhooe16iewkgHi
 PKYxcotBUJs68ajUcOcb3DNbNd5uCCKmykQ1P7/4oQVCSVFRHOC6/m8fNCvUKgHxiUKq462Y4FH
 nnWQ6ns2akB5RgSqwY/
X-Received: by 2002:a05:6214:6342:b0:91b:f655:4e54 with SMTP id
 6a1803df08f44-91bf6555006mr52612706d6.52.1792441376565; 
 Mon, 19 Oct 2026 13:22:56 -0700 (PDT)
Received: from d121029.iol.unh.edu ([2606:4100:3880:1210::219])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91c040b4915sm5510666d6.26.2026.10.19.13.22.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 13:22:55 -0700 (PDT)
From: Andrew Bailey <abailey@iol.unh.edu>
To: dev@dpdk.org, luca.vizzarro@arm.com, patrickrobb1997@gmail.com,
 dladd@iol.unh.edu
Cc: knimoji@iol.unh.edu, lylavoie@iol.unh.edu,
 Andrew Bailey <abailey@iol.unh.edu>
Subject: [PATCH v4 1/3] dts: add directory for test resources
Date: Mon, 19 Oct 2026 16:22:50 -0400
Message-ID: <20261019202252.907692-1-abailey@iol.unh.edu>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260514172553.191331-1-abailey@iol.unh.edu>
References: <20260514172553.191331-1-abailey@iol.unh.edu>
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

The crypto verify test suite being added in this series requires an
input vector file. The two vector files added in this commit are
relocated from old DTS to new DTS. This will allow the crypto verify
test suite to access the required vector files for verify testing.

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
2.55.0

