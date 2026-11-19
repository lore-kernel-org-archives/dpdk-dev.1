Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232EE606A320
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Nov 2026 18:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cisco.com header.i=@cisco.com header.a=rsa-sha256 header.s=iport01 header.b=V3wmLeah
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7A20840151;
	Thu, 19 Nov 2026 19:05:06 +0100 (CET)
Received: from rcdn-iport-6.cisco.com (rcdn-iport-6.cisco.com [173.37.86.77])
 by mails.dpdk.org (Postfix) with ESMTPS id 78CE0400D7
 for <dev@dpdk.org>; Thu, 19 Nov 2026 19:05:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cisco.com; i=@cisco.com; l=4994; q=dns/txt;
 s=iport01; t=1795111504; x=1796321104;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=Z11tTTb8E86nYCJvnZNo1fisQjHp35cGfpvfhRL376w=;
 b=V3wmLeahv5hK0xNGyRrIpA8pdXh216NNJPod1tlM4sfpBPsXNmxALGyr
 gxp3BpL67SCTXveUbK1hzOwJ3UyXUM8aS5SGXcjK7cfCz0+1V+J3CommC
 O/+d4fOPQZkcdN7td+7t5Ooty1aT3B6dCM1B2Izu3SNVs/88+7WqMy51H
 62MRdy872kAbw83zT0F1OpbFZPTWfcMQWqFQLjePfnCxUJd97gr6OuHhc
 5ZK0Y3svJkrAjbQgiqtZwoBS2G4VjS01kgqmXVFSIb3Jm1ML/hVOU7/Ll
 Kg+izBoT77L+OzLAAQsHAfrIRRXSOthhKgTHSNk1QsrwGa609SkHE6HoK w==;
X-CSE-ConnectionGUID: /0uEaMztS32FgdVxxatgPw==
X-CSE-MsgGUID: 6hQvh9ZTR0GNOvj0teVUhA==
X-IPAS-Result: =?us-ascii?q?A0BHAgATOv9q/5X/Ja1aHgEBCxIMggULgleBVkJJhFeRd?=
 =?us-ascii?q?AOeKYF+DwEBAQ9RBAEBhQECAgKOIAImNAkOAQIEAwIDAQEBAQEBAQEBAQEBC?=
 =?us-ascii?q?gEBBQEBAQIBBwWBDhOGXJATAgEDIw8BRhAfAQUCJgICRhAZgwKCdQO6BXqBM?=
 =?us-ascii?q?oEBhH7ZS4FoAQsUAYEKLoVCgyABgXGECESEOScVBoFJRIEVMoM4iB+CagSCD?=
 =?us-ascii?q?YEhgVSNF4FRiBoJgUEcA1ksAVUTFwsHBWOBBQOBBm4yHYEjOxcvWBsGBYEcg?=
 =?us-ascii?q?QcEE4ESgQNdgSsoXQEhgQiBdgKCUYIAAgFJQQ4HRVMJJUMSRyQiCBIJARMaL?=
 =?us-ascii?q?AqBGjU8CSY/FQxnCxoFYQgCDQx0ORAwHiQvBRomPhsKgQwnHx4bDgIfCW09N?=
 =?us-ascii?q?xUZBD2UWIMZAVkJGBQTLz0CQgIzQj+THYNujCeCIZ9TgT6EK6F4M6pymQipR?=
 =?us-ascii?q?YFoPIFZTSMVgyJTGQ+OLhbSOCY1PwcCBw8Ck3EBAQ?=
IronPort-Data: A9a23:xhlSjq1ZS0zz8PJUmPbD5Ydwkn2cJEfYwER7XKvMYLTBsI5bp2AEm
 DcWXW2GOK2JNmKjfYglbd6z9UkAupeHyoJkTAVv3Hw8FHgiRegpqji6wuYcGwvIc6UvmWo+t
 512huHodZ5yEzmE4Ef3b9ANlFEkvYmQXL3wFeXYDS54QA5gWU8JhAlq8wIDqtYAbeORXUXX5
 rsen+WFYAX7gmctYzpJg06+gEoHUMra6WtwUmMWPZinjHeG/1EJAZQWI72GLneQauF8Au6gS
 u/f+6qy92Xf8g1FIovNfmHTKxBirhb6ZGBiu1IOM0SQqkEqSh8ajs7XAMEhhXJ/0F1lqTzeJ
 OJl7vRcQS9xVkHFdX90vxNwS0mSNoUekFPLzOTWXcG7lyX7n3XQL/pGSxkrEIQ96PpMWjtg+
 vAmOCAEch+7mLfjqF67YrEEasULNsLnOsYb/3pn1zycVKxgSpHYSKKM7thdtNsyrpkRRrCFO
 IxDNGcpNUiRC/FMEg9/5JYWhvupjXTXeDxDo1XTrq0yi4TW5FEtgeOwboKFJLRmQ+0Lnn+Gp
 jP0w16hLTc9Kt7H1Te7z3KF07qncSTTHdh6+KeD3vJnnnWf3mAQThoMWjOTuuW0kk6zXfpZJ
 lAL/TAttawv8UamVJ/6RRLQnZKflgQXV9wVF6gx7xuAj/OOpQ2YHWMDCDVGbbTKqfMLeNDj7
 XfR9/uBONClmOT9pa61nltMkQ6PBA==
IronPort-HdrOrdr: A9a23:Xv8h16xKChIyofA4Q6CqKrPwDL1zdoMgy1knxilNoNJuHvBw8P
 re+cjztCWE6gr5N0tPpTntAsO9qDbnlaKdgrNhWYtKIjOGhILAFugLhrcKgQeQeBEWndQz6U
 4PScVDIey1K0RmhsDn5wT9OdMhzN6btJ2Mv47lvhBQpcUAUdAY0++/YTzrdHFLeA==
X-Talos-CUID: 9a23:URtXm2wxxt65k+UoAvNeBgVTQt0Ie1jP0EyLeWG3BVh5WLSJRmePrfY=
X-Talos-MUID: 9a23:/qdq8AkblhSBXPyw0iX3dno8NP524/WcNHpVvrMhpcvcKSFOBje02WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.27,221,1787011200"; d="scan'208";a="549356086"
Received: from rcdn-l-core-12.cisco.com ([173.37.255.149])
 by rcdn-iport-6.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 19 Nov 2026 18:05:02 +0000
Received: from rtp-orb-10405.cisco.com (rtp-orb-10405.cisco.com [64.100.22.53])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by rcdn-l-core-12.cisco.com (Postfix) with ESMTPS id 9A1AD180001CB;
 Thu, 19 Nov 2026 18:05:02 +0000 (GMT)
From: Randy L Tice <rtice@cisco.com>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v2 1/1] log: add name query functions
Date: Thu, 19 Nov 2026 13:05:01 -0500
Message-Id: <179511150161.2.15201980620132329183.v2-0001-log-add-name-query-functions.patch@cisco.com>
In-Reply-To: <179511150161.2.2469579962132494369.v2-0000-cover-letter.patch@cisco.com>
References: <179269447225.66.14480121779058708237.0000-cover-letter.patch@cisco.com>
 <179511150161.2.2469579962132494369.v2-0000-cover-letter.patch@cisco.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Outbound-Client-TLS: ANONYMOUS; rtp-orb-10405.cisco.com [64.100.22.53];
 TLSv1.2; ECDHE-RSA-AES256-GCM-SHA384; 256
X-Outbound-SMTP-Client: 64.100.22.53, rtp-orb-10405.cisco.com
X-Outbound-Node: rcdn-l-core-12.cisco.com
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Randy L Tice <rtice@cisco.com>
Date: Thu, 22 Oct 2026 14:34:31 -0400

Applications can query the numeric level for a log type, but cannot map
a level or type identifier back to a human-readable name without parsing
log dump output.

Add experimental helpers for retrieving the canonical level name and the
registered log type name. Document ownership of the returned strings and
add unit test coverage.

The original downstream implementation was authored by Walt Robinson
<walrobin@cisco.com>.

Signed-off-by: Randy L Tice <rtice@cisco.com>
---
 app/test/test_logs.c                   | 11 +++++++++++
 doc/guides/prog_guide/log_lib.rst      |  7 +++++++
 doc/guides/rel_notes/release_26_11.rst |  5 +++++
 lib/log/log.c                          | 20 ++++++++++++++++++++
 lib/log/rte_log.h                      | 25 +++++++++++++++++++++++++
 5 files changed, 68 insertions(+)

diff --git a/app/test/test_logs.c b/app/test/test_logs.c
index 375b06a1b7..3f978b42d9 100644
--- a/app/test/test_logs.c
+++ b/app/test/test_logs.c
@@ -110,6 +110,17 @@ test_logs(void)
 		"invalid default level for logtype3 got %d, expecting %d\n",
 		ret, RTE_LOG_ERR);
 
+	TEST_ASSERT(strcmp(rte_log_get_level_name(RTE_LOG_ERR), "error") == 0,
+		"invalid name for error log level\n");
+	TEST_ASSERT(strcmp(rte_log_get_level_name(0), "disabled") == 0,
+		"invalid name for disabled log level\n");
+	TEST_ASSERT_NULL(rte_log_get_level_name(UINT32_MAX),
+		"invalid log level has a name\n");
+	TEST_ASSERT(strcmp(rte_log_get_type_name(logtype1), "logtype1") == 0,
+		"invalid name for logtype1\n");
+	TEST_ASSERT_NULL(rte_log_get_type_name(UINT32_MAX),
+		"invalid log type has a name\n");
+
 	rte_log_set_level(logtype1, RTE_LOG_ERR);
 	CHECK_LEVELS(RTE_LOG_ERR, RTE_LOG_INFO, RTE_LOG_ERR);
 
diff --git a/doc/guides/prog_guide/log_lib.rst b/doc/guides/prog_guide/log_lib.rst
index 67b9ec75cd..1251127a53 100644
--- a/doc/guides/prog_guide/log_lib.rst
+++ b/doc/guides/prog_guide/log_lib.rst
@@ -60,6 +60,13 @@ For example::
 
 Within an application, the same result can be achieved by using the ``rte_log_set_level_pattern()`` or ``rte_log_set_level_regex()`` APIs.
 
+Querying Log Names
+~~~~~~~~~~~~~~~~~~
+
+Applications can use ``rte_log_get_level_name()`` to convert a numeric log level
+to its display name, and ``rte_log_get_type_name()`` to retrieve the registered
+name for a log component type.
+
 
 Using Logging APIs to Generate Log Messages
 -------------------------------------------
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 8387949ef3..f8bfdd4ce4 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -73,6 +73,11 @@ New Features
   Added the experimental ``rte_cpu_socket_id()`` function
   to map an OS logical CPU ID to the NUMA socket containing that CPU.
 
+* **Added APIs to get log level and type names.**
+
+  Added the experimental ``rte_log_get_level_name()`` and
+  ``rte_log_get_type_name()`` functions to query human-readable log names.
+
 * **Added pile stack and mempool driver.**
 
   Introduced pile, a lock-free, stack-like implementation,
diff --git a/lib/log/log.c b/lib/log/log.c
index 8ad5250a13..8e4aeedfd6 100644
--- a/lib/log/log.c
+++ b/lib/log/log.c
@@ -126,6 +126,26 @@ rte_log_get_level(uint32_t type)
 	return rte_logs.dynamic_types[type].loglevel;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_log_get_level_name, 26.11)
+const char *
+rte_log_get_level_name(uint32_t level)
+{
+	if (level > RTE_LOG_MAX)
+		return NULL;
+
+	return eal_log_level2str(level);
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_log_get_type_name, 26.11)
+const char *
+rte_log_get_type_name(uint32_t type)
+{
+	if (type >= rte_logs.dynamic_types_len)
+		return NULL;
+
+	return rte_logs.dynamic_types[type].name;
+}
+
 RTE_EXPORT_SYMBOL(rte_log_can_log)
 bool
 rte_log_can_log(uint32_t logtype, uint32_t level)
diff --git a/lib/log/rte_log.h b/lib/log/rte_log.h
index 3735137150..bd15022b07 100644
--- a/lib/log/rte_log.h
+++ b/lib/log/rte_log.h
@@ -126,6 +126,31 @@ uint32_t rte_log_get_global_level(void);
  */
 int rte_log_get_level(uint32_t logtype);
 
+/**
+ * Get the name of a log level.
+ *
+ * @param level
+ *   The log level identifier.
+ * @return
+ *   The name of the log level, or NULL if level is not valid.
+ *   The returned string is owned by DPDK and must not be modified or freed.
+ */
+__rte_experimental
+const char *rte_log_get_level_name(uint32_t level);
+
+/**
+ * Get the name of a log type.
+ *
+ * @param logtype
+ *   The log type identifier.
+ * @return
+ *   The name of the log type, or NULL if logtype is not registered.
+ *   The returned string is owned by DPDK, remains valid for the lifetime of
+ *   the process, and must not be modified or freed.
+ */
+__rte_experimental
+const char *rte_log_get_type_name(uint32_t logtype);
+
 /**
  * For a given `logtype`, check if a log with `loglevel` can be printed.
  *
-- 
2.35.6

