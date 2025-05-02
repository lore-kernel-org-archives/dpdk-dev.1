Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84D69C3ABAA
	for <dpdk-dev@archiver.kernel.org>; Fri,  2 May 2025 15:12:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8F92D4067A;
	Fri,  2 May 2025 17:12:13 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id 975EF4066F
 for <dev@dpdk.org>; Fri,  2 May 2025 17:12:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746198732; x=1777734732;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=E+PTYXosRNo8L6ZNERSmcC5+fYFwTwjQzsaFDUUsnwQ=;
 b=mSHGmRpZm6VBKNhcvYEcBx46KQ2B1e0ftfcTFqhIYC6FybvrH2H0K+rx
 TjMvfLLht5jfwmG5V4dHOlw7y3hKDi/NsjK7IiI/RahiixE1ZqK/TIw74
 IdJb+mRn9fjjoIBD5KZAZ8QyNyfCu29ACLYPIygk8lfMOBoLcQrYwvp15
 yZN98STHrwLHYB+5YZYbA6sqzicuwMdtJcDDnP7P+Po0VC8vl1wKWcsjA
 lwVi5XP53y0q8QFQ/ZSQh6AVqv0VJvzHF8nMEyPRhitQloMC9dsE/1j4Y
 ThmSQq7RKcupd795tAZJ/a7pgmQsHuMTKyq+Be/6yE4VQ5GT81Vlx2BOd A==;
X-CSE-ConnectionGUID: S+2lCzgUReyBRQOTKVh3yg==
X-CSE-MsgGUID: nkfxZeGuSQOEeFJ6fvE4QA==
X-IronPort-AV: E=McAfee;i="6700,10204,11421"; a="47970536"
X-IronPort-AV: E=Sophos;i="6.15,256,1739865600"; d="scan'208";a="47970536"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 May 2025 08:12:12 -0700
X-CSE-ConnectionGUID: HLo5GF20Rd2w3rvfLhP4gA==
X-CSE-MsgGUID: 2YH8xkegTkK8V7ML3np6dw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,256,1739865600"; d="scan'208";a="135172801"
Received: from unknown (HELO silpixa00401385.ir.intel.com) ([10.237.214.31])
 by orviesa007.jf.intel.com with ESMTP; 02 May 2025 08:12:10 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: david.marchand@redhat.com, mb@smartsharesystems.com,
 stephen@networkplumber.org, Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v3 4/4] eal: add option for auto-mapping cpu ids to low lcore
 ids
Date: Fri,  2 May 2025 16:11:34 +0100
Message-ID: <20250502151134.536799-5-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250502151134.536799-1-bruce.richardson@intel.com>
References: <20250313113829.1480907-1-bruce.richardson@intel.com>
 <20250502151134.536799-1-bruce.richardson@intel.com>
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

When attempting to run DPDK with cpu ids > RTE_MAX_LCORE, it can be
awkward to build up a command-line parameter specifying the cpu to lcore
mappings core-by-core. To simplify things for the common case, add in
the -L, --lcores-automap option, to take a list of cpu ids, which may or
may not be >= RTE_MAX_LCORE, and map them to lcore ids starting at zero.

For example, running lcores_autotest with dpdk-test on cores 140-143
with a build where RTE_MAX_LCORE is 128, is now as simple as:

  $ ./dpdk-test -L 140-143 -- lcores_autotest
  ...
  EAL threads count: 4, RTE_MAX_LCORE=128
  lcore 0, socket 1, role RTE, cpuset 140
  lcore 1, socket 1, role RTE, cpuset 141
  lcore 2, socket 1, role RTE, cpuset 142
  lcore 3, socket 1, role RTE, cpuset 143
  ...

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 doc/guides/linux_gsg/eal_args.include.rst | 16 +++++-
 lib/eal/common/eal_common_options.c       | 69 +++++++++++++++++++++--
 lib/eal/common/eal_options.h              |  2 +
 lib/eal/windows/include/sched.h           |  1 +
 4 files changed, 81 insertions(+), 7 deletions(-)

diff --git a/doc/guides/linux_gsg/eal_args.include.rst b/doc/guides/linux_gsg/eal_args.include.rst
index d530215784..d8257fe8fc 100644
--- a/doc/guides/linux_gsg/eal_args.include.rst
+++ b/doc/guides/linux_gsg/eal_args.include.rst
@@ -34,6 +34,7 @@ Lcore-related options
 
     ``--lcores='1@31,2@32,3@33'``: Run threads having internal lcore ids of 1, 2 and 3,
     but with the threads being bound to physical CPUs 31, 32 and 33 respectively.
+    [See also the ``-L/--lcores-automap`` option below.]
 
     ``--lcores='(1-3)@(31-33)'``: Run three threads with lcore ids 1, 2 and 3.
     Unlike the previous example above,
@@ -50,9 +51,20 @@ Lcore-related options
     or deadlock when using DPDK rings or memory pools or spinlocks.
     Such a configuration should only be used with care.
 
+*   ``-L/--lcores-automap <core list>``
+
+    List of CPUs to run on, using lcore ids starting at 0.
+
+    Argument format is as <c1>[-c2][,c3[-c4],...]
+
+    One lcore thread will be spawned per cpu id specified,
+    and pinned to the specified cpu id, but with the lowest available lcore id.
+
+    This provides a convenient way to use CPU cores with ids greater than RTE_MAX_LCORE value.
+
 .. Note::
-    At a given instance only one core option ``--lcores``, ``-l`` or ``-c`` can
-    be used.
+    At a given instance only one core option ``--lcores``, ``-l``,
+    ``--lcores-automap``, ``-L`` or ``-c`` can be used.
 
 *   ``--main-lcore <core ID>``
 
diff --git a/lib/eal/common/eal_common_options.c b/lib/eal/common/eal_common_options.c
index ed514ec1d1..c77654c365 100644
--- a/lib/eal/common/eal_common_options.c
+++ b/lib/eal/common/eal_common_options.c
@@ -56,6 +56,7 @@ eal_short_options[] =
 	"d:" /* driver */
 	"h"  /* help */
 	"l:" /* corelist */
+	"L:" /* corelist with auto lcore id remapping */
 	"S:" /* service corelist */
 	"m:" /* memory size */
 	"n:" /* memory channels */
@@ -1223,6 +1224,52 @@ eal_parse_lcores(const char *lcores)
 	return ret;
 }
 
+static int
+eal_parse_remapped_lcores(const char *optarg)
+{
+	struct rte_config *cfg = rte_eal_get_configuration();
+	const size_t optarg_len = strlen(optarg);
+	rte_cpuset_t cpuset;
+
+	/* Reset lcore config */
+	for (unsigned int idx = 0; idx < RTE_MAX_LCORE; idx++) {
+		cfg->lcore_role[idx] = ROLE_OFF;
+		lcore_config[idx].core_index = -1;
+		CPU_ZERO(&lcore_config[idx].cpuset);
+	}
+
+	/* the eal_parse_set API only handles "," within (), so wrap string */
+	char *tmp_optarg = malloc(optarg_len + 3);
+	if (tmp_optarg == NULL) {
+		EAL_LOG(ERR, "Error with malloc for temporary optarg string");
+		return -1;
+	}
+	snprintf(tmp_optarg, optarg_len + 3, "(%s)", optarg);
+
+	/* parse wrapped string */
+	int parsed_chars = eal_parse_set(tmp_optarg, &cpuset);
+	free(tmp_optarg);
+	if (parsed_chars == -1 || CPU_COUNT(&cpuset) == 0) {
+		EAL_LOG(ERR, "Invalid corelist for remapping: %s", optarg);
+		return -1;
+	}
+
+	unsigned int lcore_id = 0;
+	unsigned int cpu_id = 0;
+	while (CPU_COUNT(&cpuset) > 0) {
+		if (CPU_ISSET(cpu_id, &cpuset)) {
+			cfg->lcore_role[lcore_id] = ROLE_RTE;
+			lcore_config[lcore_id].core_index = lcore_id;
+			CPU_SET(cpu_id, &lcore_config[lcore_id].cpuset);
+			CPU_CLR(cpu_id, &cpuset);
+			lcore_id++;
+		}
+		cpu_id++;
+	}
+
+	return 0;
+}
+
 static void
 eal_log_usage(void)
 {
@@ -1634,21 +1681,25 @@ eal_parse_common_option(int opt, const char *optarg,
 		break;
 	}
 	/* corelist */
+	case 'L':
 	case 'l': {
 		if (eal_service_cores_parsed())
 			EAL_LOG(WARNING,
 				"Service cores parsed before dataplane cores. Please ensure -l is before -s or -S");
 
-		if (eal_parse_lcores(optarg) < 0) {
-			EAL_LOG(ERR, "invalid parameter for -l/--" OPT_LCORES);
+		int retval = opt == 'l' ?
+			eal_parse_lcores(optarg) :
+			eal_parse_remapped_lcores(optarg);
+		if (retval < 0) {
+			EAL_LOG(ERR, "invalid parameter for lcore list option: '%s'", optarg);
 			return -1;
 		}
 
 		if (core_parsed) {
 			if (core_parsed == LCORE_OPT_LST)
-				EAL_LOG(ERR, "Core list option passed multiple times to EAL");
+				EAL_LOG(ERR, "Multiple core list options passed to EAL");
 			else
-				EAL_LOG(ERR, "Option '-l/--lcores' is ignored, because coremask option used");
+				EAL_LOG(ERR, "Core list option is ignored, because coremask option used");
 			return -1;
 		}
 
@@ -2118,6 +2169,14 @@ eal_common_usage(void)
 	       "                      ',' is used for single number separator.\n"
 	       "                      '( )' can be omitted for single element group,\n"
 	       "                      '@' can be omitted if cpus and lcores have the same value\n"
+	       "  -L, --"OPT_LCORES_AUTOMAP" CORELIST\n"
+	       "                      List of CPUs to run on, using lcore ids starting at 0.\n"
+	       "                      Argument format is as <c1>[-c2][,c3[-c4],...]\n"
+	       "                      One lcore thread will be spawned per cpu id specified,\n"
+	       "                      and pinned to the specified cpu id, but with the lowest\n"
+	       "                      available lcore id.\n"
+	       "                      This provides a convenient way to use CPU cores with ids\n"
+	       "                      greater than RTE_MAX_LCORE value (%d)\n"
 	       "  -s SERVICE COREMASK Hexadecimal bitmask of cores to be used as service cores\n"
 	       "  --"OPT_MAIN_LCORE" ID     Core ID that is used as main\n"
 	       "  --"OPT_MBUF_POOL_OPS_NAME" Pool ops name for mbuf to use\n"
@@ -2191,5 +2250,5 @@ eal_common_usage(void)
 	       "  --"OPT_NO_PCI"            Disable PCI\n"
 	       "  --"OPT_NO_HPET"           Disable HPET\n"
 	       "  --"OPT_NO_SHCONF"         No shared config (mmap'd files)\n"
-	       "\n", RTE_MAX_LCORE);
+	       "\n", RTE_MAX_LCORE, RTE_MAX_LCORE);
 }
diff --git a/lib/eal/common/eal_options.h b/lib/eal/common/eal_options.h
index 7b84b7d778..cdea876635 100644
--- a/lib/eal/common/eal_options.h
+++ b/lib/eal/common/eal_options.h
@@ -19,6 +19,8 @@ enum {
 	OPT_DEV_BLOCK_NUM      = 'b',
 #define OPT_LCORES            "lcores"
 	OPT_LCORES_NUM         = 'l',
+#define OPT_LCORES_AUTOMAP    "lcores-automap"
+	OPT_LCORES_AUTOMAP_NUM = 'L',
 
 	/* first long only option value must be >= 256, so that we won't
 	 * conflict with short options */
diff --git a/lib/eal/windows/include/sched.h b/lib/eal/windows/include/sched.h
index 912fed12c2..04ee046bb7 100644
--- a/lib/eal/windows/include/sched.h
+++ b/lib/eal/windows/include/sched.h
@@ -31,6 +31,7 @@ typedef struct _rte_cpuset_s {
 #define RTE_HAS_CPUSET
 
 #define CPU_SET(b, s) ((s)->_bits[_WHICH_SET(b)] |= (1LL << _WHICH_BIT(b)))
+#define CPU_CLR(b, s) ((s)->_bits[_WHICH_SET(b)] &= ~(1LL << _WHICH_BIT(b)))
 
 #define CPU_ZERO(s)							\
 	do {								\
-- 
2.45.2

