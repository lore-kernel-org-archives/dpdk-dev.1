Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C3E606A319
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 Oct 2026 18:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cisco.com header.i=@cisco.com header.a=rsa-sha256 header.s=iport01 header.b=JUOj4r0f
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5856E4027D;
	Thu, 22 Oct 2026 20:41:30 +0200 (CEST)
Received: from alln-iport-2.cisco.com (alln-iport-2.cisco.com [173.37.142.89])
 by mails.dpdk.org (Postfix) with ESMTP id B03234027D
 for <dev@dpdk.org>; Thu, 22 Oct 2026 20:41:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cisco.com; i=@cisco.com; l=4979; q=dns/txt;
 s=iport01; t=1792694488; x=1793904088;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=G9JJkEz1WmsWe42G3nH6mqwhBUBRyWwrVNj5XwwoTSQ=;
 b=JUOj4r0fQyKaSmYKM+KL9cxLcRMSzAbMYlTcMNXyNzvHUcuf1VME68Vn
 /SB7dA5/gW6+K5Q2yn9QWYRxF/uFIzUtJezr4LHY05qQ2kOV2X2bO43KA
 1zaf2QznZ5fbj55dQ31yixrKg4CUkly/IFSHVXwJ9CMuJW1+c26+Y/NIb
 tShTjq5DObo14vrWEz5M61S2twDgy5668jSmGJrW+vHvjiWeIPWAj/7hV
 bfBli/EzXI74jv6N5YgPPnw3O5vYd940uY+3rP1wG13KuhPtiYfzRBUYR
 9dkyhCZEUHJGxqPej3tJpf51Z1eY0h88wtkrcTSHNgcBfWqBByk5MTKQA w==;
X-CSE-ConnectionGUID: l4K51kl6SVWAbaMvScS4uQ==
X-CSE-MsgGUID: qWI/YojbQGGTHuVEVgsn8Q==
X-IPAS-Result: =?us-ascii?q?A0BGAgB6WNpq/44QJK1aglmCV4FWQkmEV5F0A54cgX4PA?=
 =?us-ascii?q?QEBD1EEAQGFBQKOFQImNAkOAQIEAwIDAQEBAQEBAQEBAQEBCgEBBQEBAQIBB?=
 =?us-ascii?q?wWBDhOGXJATAgEDIw8BRhAfAQUCJgICRhAZgwKCdQO2F3qBMoEBhH7ZSoFoA?=
 =?us-ascii?q?QsUAYEKLoVAgx8BgXGECESEOCcVBoFJRIEVg2mIHoJqBIINgSGBWo4MhmMJg?=
 =?us-ascii?q?UEcA1ksAVUTFwsHBWOBBQOBBm4yHYEjPhcvWBsGBYEdgQcEE4EWIxk2a4EJX?=
 =?us-ascii?q?YErKWABIYEIgXYCglGCAAIBSUEOB0VTCSVDEkckIggSCQETGi4LgRo4PAkmQ?=
 =?us-ascii?q?RUMZgsaBWIIAg0MfzkJbT03FRkEPZJTgwkBWQkYFBMvPQJCAjNCP5Mdg26MK?=
 =?us-ascii?q?KFygT6EKKF2M6pvmQipQ4FoPIFZTSMVgyJTGQ+OLhbSNig1PwcCBw8Ck3EBA?=
 =?us-ascii?q?Q?=
IronPort-Data: A9a23:ohP0zq9NgZ4eRxjENDRcDrUD1X+TJUtcMsCJ2f8bNWPcYEJGY0x3n
 GofCm+Bbq6Namfzf912YIzn9B4DuMDQydVrGgQ9/yhEQiMRo6IpJzg2wmQcns+2BpeeJK6yx
 5xGMrEsFOhtEDmB4E/rbei5xZVF/fngbqLmD+LZMTxGSwZhSSMw4TpugOdRbrRA2bBVOCvT/
 4mtyyHjEAX9gWAtajhOs//rRC5H5ZwehhtJ5jTSWtgT1LPuvyF9JI4SI6i3M0z5TuF8dsamR
 /zOxa2O5WjQ+REgELuNyt4XpWVTH9Y+lSDX4pZnc/DKbipq/0Te4Y5nXBYoUnq7vh3S9zxHJ
 HqhgrTrIeshFvWkdO3wyHC0GQkmVUFN0OevzXRSLaV/wmWeG0YAzcmCA2kyYa5Fo+VzX1pwy
 tUSIRUTVRu42/+PlefTpulE3qzPLeHiOIcZ/3UlxjbDALN+HNbIQr7B4plT2zJYasJmRKmFI
 ZFHL2MxKk2cOXWjOX9PYH46tP20h3LyWzZZs1mS46Ew5gA/ySQhj+KzYIKFI4DiqcN9h3m54
 VPB/W7ALT4mFMGh5ASK6XT8v7qa9c/8cMdIfFGizdZmjUO7ynQfC1sRT1TTieKlh1a+VtR3L
 UEI5S00rrA26UmhQ8O7WAe3yENopTYVX95WVul/4waXx++MvkCSB3MPSXhKb9lOWNIKeAHGH
 2Shx7vBbQGDepXPIZ5B3t94dQ+PBBU=
IronPort-HdrOrdr: A9a23:XNSyjaqvCrw0eby1wEa+cmUaV5oLeYIsimQD101hICG9vPb1qy
 nIpoV/6faUskdyZJhOo7690cW7K080sKQU3WBzB8bHYOCZggqVxehZhOOI/9SjIVycygc378
 hdmsZFZeHYPBxdkdvw5hW+HpILxdmK973tuMLlpk0dKj2Dr8pbnn5E4sHxKDwReDV7
X-Talos-CUID: 9a23:WlM4A2E5A4K6UTKIqmJjqG1JQ8MhLEbj817aKmqmMm1SFKCsHAo=
X-Talos-MUID: 9a23:FvaMzAa5wjPw4eBTrgDNwwBlNs1RzIuSKF0zvKsJoM/UDHkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.27,172,1787011200"; d="scan'208";a="872680814"
Received: from alln-l-core-05.cisco.com ([173.36.16.142])
 by alln-iport-2.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 22 Oct 2026 18:41:13 +0000
Received: from rtp-orb-10405.cisco.com (rtp-orb-10405.cisco.com [64.100.22.53])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alln-l-core-05.cisco.com (Postfix) with ESMTPS id 2D20218000165;
 Thu, 22 Oct 2026 18:41:13 +0000 (GMT)
From: Randy L Tice <rtice@cisco.com>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 1/1] log: add name query functions
Date: Thu, 22 Oct 2026 14:41:12 -0400
Message-Id: <179269447225.66.503181230751464930.0001-log-add-name-query-functions.patch@cisco.com>
In-Reply-To: <179269447225.66.14480121779058708237.0000-cover-letter.patch@cisco.com>
References: <179269447225.66.14480121779058708237.0000-cover-letter.patch@cisco.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Outbound-Client-TLS: ANONYMOUS; rtp-orb-10405.cisco.com [64.100.22.53];
 TLSv1.2; ECDHE-RSA-AES256-GCM-SHA384; 256
X-Outbound-SMTP-Client: 64.100.22.53, rtp-orb-10405.cisco.com
X-Outbound-Node: alln-l-core-05.cisco.com
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
 lib/log/log.c                          | 17 +++++++++++++++++
 lib/log/rte_log.h                      | 25 +++++++++++++++++++++++++
 5 files changed, 65 insertions(+)

diff --git a/app/test/test_logs.c b/app/test/test_logs.c
index 375b06a1b7..ecc9f36f47 100644
--- a/app/test/test_logs.c
+++ b/app/test/test_logs.c
@@ -110,6 +110,17 @@ test_logs(void)
 		"invalid default level for logtype3 got %d, expecting %d\n",
 		ret, RTE_LOG_ERR);
 
+	TEST_ASSERT(strcmp(rte_log_get_level_name(RTE_LOG_ERR), "error") == 0,
+		"invalid name for error log level\n");
+	TEST_ASSERT(strcmp(rte_log_get_level_name(0), "disabled") == 0,
+		"invalid name for disabled log level\n");
+	TEST_ASSERT(strcmp(rte_log_get_level_name(UINT32_MAX), "unknown") == 0,
+		"invalid name for unknown log level\n");
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
index be758a0c02..fac585ddd1 100644
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
index 8ad5250a13..a4ecfa0436 100644
--- a/lib/log/log.c
+++ b/lib/log/log.c
@@ -126,6 +126,23 @@ rte_log_get_level(uint32_t type)
 	return rte_logs.dynamic_types[type].loglevel;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_log_get_level_name, 26.11)
+const char *
+rte_log_get_level_name(uint32_t level)
+{
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
index 3735137150..e7a0349b6e 100644
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
+ *   The name of the log level, or "unknown" if level is not recognized.
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

