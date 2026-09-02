Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6232EC624D4
	for <dpdk-dev@archiver.kernel.org>; Wed,  2 Sep 2026 23:26:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3D3804028D;
	Thu,  3 Sep 2026 01:26:43 +0200 (CEST)
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com
 [209.85.210.175])
 by mails.dpdk.org (Postfix) with ESMTP id DE01E40285
 for <dev@dpdk.org>; Thu,  3 Sep 2026 01:26:41 +0200 (CEST)
Received: by mail-pf1-f175.google.com with SMTP id
 d2e1a72fcca58-8534d507f59so2136069b3a.0
 for <dev@dpdk.org>; Wed, 02 Sep 2026 16:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788391601;
 x=1788996401; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=MhDvDGEfd/SDwHTQ/nDmt/II6gIDBlmHUA0Odn4m4XA=;
 b=c9MC1fFRLcdepr91ctGbPJ4BNUTxt7Xzq9wj/LcWtFCnxO8dD/EETojKtIXBIfk2+4
 XDisbyPmqWRq+FVdoKc+Q0if2+2gtDnzLUHX4gP9/Rx3jDl/t7izExMTx0ye2qJDZsA6
 VRcVd9+jT3RcCnOeZVTLefGS9AR587lfM1GgG0DvK3lnpaFXcZSnoEj6LqmhX8LKqRMk
 oGtA1i3NwdaewAWIjZ4fzpoZSPnIhr4b2cZHrLE/rmueZ9BfGuFoAh9PfxKtZxn0cTzm
 ze7FfCIaJMv75f7hdrW9SzHHXaPh71CbYNfCyfKFjTgNhY/3tNMQTJAb/fMdp9l1RofL
 gpNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788391601; x=1788996401;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MhDvDGEfd/SDwHTQ/nDmt/II6gIDBlmHUA0Odn4m4XA=;
 b=D+8A9AgzHT3MZPRCwfDYEPFB5/DPBcDQ+uK61weEmKlxEzH5Qay4yoXnZ/T9AwP/6/
 q9PybaNsK1pfe9uVv0DaHaxZR0YpVsovt5z+tq/VhQwv2Q2Gzidmk3KKGeh7sUQJ2ytM
 Oer17P3nr+Xxn6iIjDMJdWPDmoCjxQRNK25DuNGRjW7YgQ7qAq1xvUpxTJKkDaCxNDIF
 t1KYbwmN5eDEZZSWgn4GPbIJ/Y7ulbIcklXJFIpMj10U/ZVCgWZSVR7Pz5k1rNzVSTKI
 Zpnuhu/L/TdS/cxMlQVLzUVG4i0+Rt9r2F29/Y17oIdgMd7XD9nHELQtplj9TCBtkEZY
 Rjwg==
X-Gm-Message-State: AFuF++lKUEwh/IFPmBDf82AQyIukIMJvLJX4v8fZ3gmNCjo1S6zX6uyO
 g4Ir0qOXqkqSr0cJtVGNBwxdKMKEe+v4UkCRNtxEH2kS14L5t7cswpW4O/LGNNBjm1ehRd+Qx/z
 pyrqc
X-Gm-Gg: AYBFou0spq+dCTW9+5XIyzxZHdifJEm2//EcYFrO3Z9h+2/nDOu4TpmUpv8M5Bz/Mvp
 /S36jh2xdaAtFi2GT9rav2qjbZcsHjry711qhc7JCbZPHXcZj0vXVv4jY9jiZOmfCmgY9jsskjE
 OWCK6l+1p6Qd5cwmhDD+TymF9S/ea8U3oXyZuZh0LdPsnyv5ISBDXh242TlbDAnXCT20Ci6xrKU
 nSGC0pRJQC7Q7PPnA2uZQyQ1rMXwkFUAXY2AV58ncn23Vv11nkR77qWJYll/fvdKRTLubjQID09
 qZNxMVlwuUwo8QxgdUKH89ck1Mp7PdfKxq6nn2XnV/FkgPV+lIZZRwXA4hgix4SC/Y5C6OtML4M
 OE2FeVLB0+xr240RVLGKMZgoFABOMBWphLptOY/d2su2SzW0qrokA+K6Mx4uqYQwf6ecn3Lvt6A
 ryzZPEIlKit4ES1eBV3j22MKOShoSEiOFPHs+n+QfxlSZ9mOVZIjhhof2DsunSGwnRFCpunPf/f
 opLVe1yVDDB0e93PZb3IrD0Nis=
X-Received: by 2002:a05:6a00:4601:b0:84f:a7bf:8fb9 with SMTP id
 d2e1a72fcca58-85ed7743221mr10763440b3a.3.1788391600597; 
 Wed, 02 Sep 2026 16:26:40 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-85db2ad8d39sm2011420b3a.19.2026.09.02.16.26.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 16:26:38 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH] telemetry: promote experimental API to stable
Date: Wed,  2 Sep 2026 16:26:30 -0700
Message-ID: <20260902232630.543215-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
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

The remaining experimental telemetry functions have been present without
interface changes for several releases: the hexadecimal helpers
rte_tel_data_add_array_uint_hex() and rte_tel_data_add_dict_uint_hex()
since v23.03, and rte_telemetry_register_cmd_arg() since v24.11.
Promote all three to the stable ABI.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/rel_notes/release_26_11.rst | 6 ++++++
 lib/telemetry/rte_telemetry.h          | 3 ---
 lib/telemetry/telemetry.c              | 2 +-
 lib/telemetry/telemetry_data.c         | 4 ++--
 4 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 87c7e81bde..edca1f445c 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -95,6 +95,12 @@ API Changes
    Also, make sure to start the actual text at the margin.
    =======================================================
 
+* telemetry: Promoted the following functions to stable:
+
+  * ``rte_tel_data_add_array_uint_hex``
+  * ``rte_tel_data_add_dict_uint_hex``
+  * ``rte_telemetry_register_cmd_arg``
+
 
 ABI Changes
 -----------
diff --git a/lib/telemetry/rte_telemetry.h b/lib/telemetry/rte_telemetry.h
index 0a58e518f7..f5b2aa1415 100644
--- a/lib/telemetry/rte_telemetry.h
+++ b/lib/telemetry/rte_telemetry.h
@@ -174,7 +174,6 @@ rte_tel_data_add_array_container(struct rte_tel_data *d,
  * @return
  *   0 on success, negative errno on error.
  */
-__rte_experimental
 int
 rte_tel_data_add_array_uint_hex(struct rte_tel_data *d, uint64_t val,
 		uint8_t display_bitwidth);
@@ -276,7 +275,6 @@ rte_tel_data_add_dict_container(struct rte_tel_data *d, const char *name,
  * @return
  *   0 on success, negative errno on error.
  */
-__rte_experimental
 int
 rte_tel_data_add_dict_uint_hex(struct rte_tel_data *d, const char *name,
 		uint64_t val, uint8_t display_bitwidth);
@@ -364,7 +362,6 @@ rte_telemetry_register_cmd(const char *cmd, telemetry_cb fn, const char *help);
  * @return
  *   -ENOMEM for mem allocation failure.
  */
-__rte_experimental
 int
 rte_telemetry_register_cmd_arg(const char *cmd, telemetry_arg_cb fn, void *arg, const char *help);
 
diff --git a/lib/telemetry/telemetry.c b/lib/telemetry/telemetry.c
index e591c1e283..379dbf4ce3 100644
--- a/lib/telemetry/telemetry.c
+++ b/lib/telemetry/telemetry.c
@@ -122,7 +122,7 @@ rte_telemetry_register_cmd(const char *cmd, telemetry_cb fn, const char *help)
 	return register_cmd(cmd, help, fn, NULL, NULL);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_telemetry_register_cmd_arg, 24.11)
+RTE_EXPORT_SYMBOL(rte_telemetry_register_cmd_arg)
 int
 rte_telemetry_register_cmd_arg(const char *cmd, telemetry_arg_cb fn, void *arg, const char *help)
 {
diff --git a/lib/telemetry/telemetry_data.c b/lib/telemetry/telemetry_data.c
index 0a006559ab..8e0f4c515b 100644
--- a/lib/telemetry/telemetry_data.c
+++ b/lib/telemetry/telemetry_data.c
@@ -124,7 +124,7 @@ rte_tel_uint_to_hex_encoded_str(char *buf, size_t buf_len, uint64_t val,
 	return len < (int)buf_len ? 0 : -EINVAL;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_tel_data_add_array_uint_hex, 23.03)
+RTE_EXPORT_SYMBOL(rte_tel_data_add_array_uint_hex)
 int
 rte_tel_data_add_array_uint_hex(struct rte_tel_data *d, uint64_t val,
 				uint8_t display_bitwidth)
@@ -248,7 +248,7 @@ rte_tel_data_add_dict_container(struct rte_tel_data *d, const char *name,
 	return bytes < RTE_TEL_MAX_STRING_LEN ? 0 : E2BIG;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_tel_data_add_dict_uint_hex, 23.03)
+RTE_EXPORT_SYMBOL(rte_tel_data_add_dict_uint_hex)
 int
 rte_tel_data_add_dict_uint_hex(struct rte_tel_data *d, const char *name,
 			       uint64_t val, uint8_t display_bitwidth)
-- 
2.53.0

