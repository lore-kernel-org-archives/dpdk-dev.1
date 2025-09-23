Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60CE0CAC5A7
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Sep 2025 14:32:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B299E402CB;
	Tue, 23 Sep 2025 16:32:33 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id 4C420402B3
 for <dev@dpdk.org>; Tue, 23 Sep 2025 16:32:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758637952; x=1790173952;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=nLBl/oD94TCLPug2gXX/rGCU2iA4uWAGIHVxX1EI6Og=;
 b=YzPxXyZ3tjhdCSNGa0Gp5i7cNEOgh7RfEgHXYkW8Uhvl3JcE1N1Qo3N7
 X33w5Rbi3leLBMl2zq3eop1NMjvexJNk165SuPl2H0hzGgh9td6mKx5bB
 lSxBE/0g80YZz5OuCxAw32DcNIBooQe1Tn5hfuPwhYUqeHdKhwRkdpHgQ
 pZJ4Sore0u3Wj/GeQUlUhgD+vAdWJynDAo5r+7P0AR0mYPN4oB8wLmv2j
 zYQpbTacuGVNV67kj874jb9lDW0qrOPVA+fuxJEN/zyZokrPjwHdv36sY
 hJxpY70pi/n9rX5Zqx4YtsGerV6bUmZpUeb5hH7jcpxctcQv4uJvCHHVr w==;
X-CSE-ConnectionGUID: yI6piVLfTiOWW02eUaKLHA==
X-CSE-MsgGUID: E9BuLYspTM61rd8ajLtafw==
X-IronPort-AV: E=McAfee;i="6800,10657,11561"; a="64745146"
X-IronPort-AV: E=Sophos;i="6.18,288,1751266800"; d="scan'208";a="64745146"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Sep 2025 07:32:31 -0700
X-CSE-ConnectionGUID: dpi/L7icSayt0rG+x4vASA==
X-CSE-MsgGUID: WrUfaYcnQ5uYJNb80DqtKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,288,1751266800"; d="scan'208";a="175903731"
Received: from silpixa00401385.ir.intel.com (HELO silpixa00401385..)
 ([10.20.224.226])
 by orviesa006.jf.intel.com with ESMTP; 23 Sep 2025 07:32:30 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 David Marchand <david.marchand@redhat.com>
Subject: [PATCH v2] telemetry: remove deprecated functions
Date: Tue, 23 Sep 2025 15:32:25 +0100
Message-ID: <20250923143225.12252-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250919075654.220920-1-bruce.richardson@intel.com>
References: <20250919075654.220920-1-bruce.richardson@intel.com>
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

[1] https://doc.dpdk.org/guides-23.03/rel_notes/deprecation.html

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
Acked-by: David Marchand <david.marchand@redhat.com>
---
 doc/guides/rel_notes/deprecation.rst   |  5 ----
 doc/guides/rel_notes/release_25_11.rst |  4 +++
 lib/telemetry/rte_telemetry.h          | 35 --------------------------
 lib/telemetry/telemetry_data.c         | 14 -----------
 4 files changed, 4 insertions(+), 54 deletions(-)

diff --git a/doc/guides/rel_notes/deprecation.rst b/doc/guides/rel_notes/deprecation.rst
index bdcd2775b6..483030cda8 100644
--- a/doc/guides/rel_notes/deprecation.rst
+++ b/doc/guides/rel_notes/deprecation.rst
@@ -20,11 +20,6 @@ Deprecation Notices
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
diff --git a/doc/guides/rel_notes/release_25_11.rst b/doc/guides/rel_notes/release_25_11.rst
index efb88bbbb0..03cee47369 100644
--- a/doc/guides/rel_notes/release_25_11.rst
+++ b/doc/guides/rel_notes/release_25_11.rst
@@ -89,6 +89,10 @@ Removed Items
    Also, make sure to start the actual text at the margin.
    =======================================================
 
+* telemetry: As previously announced in the deprecation notices,
+  the functions ``rte_tel_data_add_array_u64`` and ``rte_tel_data_add_dict_u64`` are removed.
+  They are replaced by ``rte_tel_data_add_array_uint`` and ``rte_tel_data_add_dict_uint`` respectively.
+
 
 API Changes
 -----------
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

