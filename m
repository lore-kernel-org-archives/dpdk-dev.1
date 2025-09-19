Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 516EECAC59A
	for <dpdk-dev@archiver.kernel.org>; Fri, 19 Sep 2025 07:57:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3B45F40611;
	Fri, 19 Sep 2025 09:57:08 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id 5AE67402B7
 for <dev@dpdk.org>; Fri, 19 Sep 2025 09:57:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758268626; x=1789804626;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=uGVb8yWs06gQ3MEnUDUuls6DQhGgRoCceinsWCBTAGY=;
 b=OW7SxWTaimtBxz3gTR32qfcnYaePUgdygYcIZ5+Z6HTqDXy906LcLMzW
 mYX06gsEksubAuqcwnr7Ys2W/uUIdbNQGQYZ08l4uoFDUbSjJP3yILNbn
 8Skf+VJ9QEntlnBtphR7ERp+Af6WCOXwQ6k9IkJ5qltVokV527NQNd+SL
 IlGLxPdx7oGULefv6Y7dxBG0hH+YnOA/czsxCNW27rNXYLFV5LIe4LVzb
 bn5QZemJK+tWeLWnuMoOA4VnKDLf2RXXPu9/xrwEM+95AtMksFxI15him
 RWaX2OcEOv86I6vyAdZoIJvtqWtl+k4Bra465HAzC/uTIzcUr9O3YkOtd Q==;
X-CSE-ConnectionGUID: kBQ3HCS4S6+Pdf7aDPxpyw==
X-CSE-MsgGUID: KAFYfP7eR6KGCHE+L7Np0Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11557"; a="78217591"
X-IronPort-AV: E=Sophos;i="6.18,277,1751266800"; d="scan'208";a="78217591"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Sep 2025 00:57:05 -0700
X-CSE-ConnectionGUID: OMZbJpn3TZO7OB4xK5iNXA==
X-CSE-MsgGUID: Zp8zYEkLSAWlU98rrR/XGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,277,1751266800"; d="scan'208";a="174891453"
Received: from silpixa00401385.ir.intel.com (HELO silpixa00401385..)
 ([10.237.214.33])
 by orviesa006.jf.intel.com with ESMTP; 19 Sep 2025 00:57:05 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH] telemetry: remove deprecated functions
Date: Fri, 19 Sep 2025 08:56:54 +0100
Message-ID: <20250919075654.220920-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
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

The "_u64" telemetry functions were replaced by the "_uint" versions
back in 2023 [1], so can be removed from the release.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>

[1] https://doc.dpdk.org/guides-23.03/rel_notes/deprecation.html
---
 doc/guides/rel_notes/deprecation.rst |  5 ----
 lib/telemetry/rte_telemetry.h        | 35 ----------------------------
 lib/telemetry/telemetry_data.c       | 14 -----------
 3 files changed, 54 deletions(-)

diff --git a/doc/guides/rel_notes/deprecation.rst b/doc/guides/rel_notes/deprecation.rst
index 5aaeb1052a..0fcdd02d3c 100644
--- a/doc/guides/rel_notes/deprecation.rst
+++ b/doc/guides/rel_notes/deprecation.rst
@@ -27,11 +27,6 @@ Deprecation Notices
 * kvargs: The function ``rte_kvargs_process`` will get a new parameter
   for returning key match count. It will ease handling of no-match case.
 
-* telemetry: The functions ``rte_tel_data_add_array_u64`` and ``rte_tel_data_add_dict_u64``,
-  used by telemetry callbacks for adding unsigned integer values to be returned to the user,
-  are renamed to ``rte_tel_data_add_array_uint`` and ``rte_tel_data_add_dict_uint`` respectively.
-  As such, the old function names are deprecated and will be removed in a future release.
-
 * eal: The ``-c <coremask>`` commandline parameter is deprecated
   and will be removed in a future release.
   Use the ``-l <corelist>`` or ``--lcores=<corelist>`` parameters instead
diff --git a/lib/telemetry/rte_telemetry.h b/lib/telemetry/rte_telemetry.h
index c4554e4028..b9662a5213 100644
--- a/lib/telemetry/rte_telemetry.h
+++ b/lib/telemetry/rte_telemetry.h
@@ -136,22 +136,6 @@ rte_tel_data_add_array_int(struct rte_tel_data *d, int64_t x);
 int
 rte_tel_data_add_array_uint(struct rte_tel_data *d, uint64_t x);
 
- /**
- * Add a uint64_t to an array.
- * The array must have been started by rte_tel_data_start_array() with
- * RTE_TEL_UINT_VAL as the type parameter.
- *
- * @param d
- *   The data structure passed to the callback
- * @param x
- *   The number to be returned in the array
- * @return
- *   0 on success, negative errno on error
- */
-int
-rte_tel_data_add_array_u64(struct rte_tel_data *d, uint64_t x)
-	__rte_deprecated_msg("use 'rte_tel_data_add_array_uint' instead");
-
 /**
  * Add a container to an array. A container is an existing telemetry data
  * array. The array the container is to be added to must have been started by
@@ -249,25 +233,6 @@ int
 rte_tel_data_add_dict_uint(struct rte_tel_data *d,
 		const char *name, uint64_t val);
 
- /**
- * Add a uint64_t value to a dictionary.
- * The dict must have been started by rte_tel_data_start_dict().
- *
- * @param d
- *   The data structure passed to the callback
- * @param name
- *   The name the value is to be stored under in the dict
- *   Must contain only alphanumeric characters or the symbols: '_' or '/'
- * @param val
- *   The number to be stored in the dict
- * @return
- *   0 on success, negative errno on error, E2BIG on string truncation of name.
- */
-int
-rte_tel_data_add_dict_u64(struct rte_tel_data *d,
-		const char *name, uint64_t val)
-	__rte_deprecated_msg("use 'rte_tel_data_add_dict_uint' instead");
-
 /**
  * Add a container to a dictionary. A container is an existing telemetry data
  * array. The dict the container is to be added to must have been started by
diff --git a/lib/telemetry/telemetry_data.c b/lib/telemetry/telemetry_data.c
index c120600622..0354a06548 100644
--- a/lib/telemetry/telemetry_data.c
+++ b/lib/telemetry/telemetry_data.c
@@ -91,13 +91,6 @@ rte_tel_data_add_array_uint(struct rte_tel_data *d, uint64_t x)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_tel_data_add_array_u64)
-int
-rte_tel_data_add_array_u64(struct rte_tel_data *d, uint64_t x)
-{
-	return rte_tel_data_add_array_uint(d, x);
-}
-
 RTE_EXPORT_SYMBOL(rte_tel_data_add_array_container)
 int
 rte_tel_data_add_array_container(struct rte_tel_data *d,
@@ -229,13 +222,6 @@ rte_tel_data_add_dict_uint(struct rte_tel_data *d,
 	return bytes < RTE_TEL_MAX_STRING_LEN ? 0 : E2BIG;
 }
 
-RTE_EXPORT_SYMBOL(rte_tel_data_add_dict_u64)
-int
-rte_tel_data_add_dict_u64(struct rte_tel_data *d, const char *name, uint64_t val)
-{
-	return rte_tel_data_add_dict_uint(d, name, val);
-}
-
 RTE_EXPORT_SYMBOL(rte_tel_data_add_dict_container)
 int
 rte_tel_data_add_dict_container(struct rte_tel_data *d, const char *name,
-- 
2.48.1

