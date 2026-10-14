Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E9F6CC6B1A
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Oct 2026 18:40:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6A32640B92;
	Wed, 14 Oct 2026 20:39:39 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id D108640659
 for <dev@dpdk.org>; Wed, 14 Oct 2026 20:39:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792003178; x=1823539178;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=xTUPzhBOrBA1XUOM/y2nX5NvZyXx/QzeJUQWkTSX2Qg=;
 b=YU1HNbTGx6IuitGJhmOEDy6Km56kMLrUipfKmRjc+6+ZLmS/eGlvReiB
 nzycvq9NbU0ymzbQAd2Gu5z+/uibrw55rPfqZqskLyXru1N/7rpbVySqL
 tiuVzYM6Vwa3tZ9AAxdfTnvRrKf3efJG/Avcxp6ZmR/qAhAcql4/9LMkS
 AXC59GRfDpxNnujKTBhH7eLBumE4PZsJOiYbM5dnOhBrFY0jHh3SOBBva
 5HB56SYpdVujjd/8Uv48Xm1ukKOK8YR/5YRXGGOyW1S4NGeg3THVO9NIN
 NBHbOSjcmLQobGoA5ECgAuG8ry//33LAapDPQiyNadWIl0cc+ghiJBqAz w==;
X-CSE-ConnectionGUID: WTA7NDk+Rj+fDPhrm9yQdQ==
X-CSE-MsgGUID: 8DbB+dQSTu2YAOjaCCHDQA==
X-IronPort-AV: E=McAfee;i="6800,10657,11935"; a="753372"
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="753372"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2026 11:39:33 -0700
X-CSE-ConnectionGUID: 8wZIshmOSSiGW1hvhxAskg==
X-CSE-MsgGUID: xtfZiQgUQG+ra5RA1NgH4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="1419880"
Received: from silpixa00401176.ir.intel.com ([10.20.224.212])
 by orviesa009.jf.intel.com with ESMTP; 14 Oct 2026 11:39:31 -0700
From: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
To: dev@dpdk.org
Cc: rjarry@redhat.com, mb@smartsharesystems.com, maxime@leroys.fr,
 konstantin.ananyev@huawei.com
Subject: [RFC PATCH v2 5/7] fib: add multi-VRF support
Date: Wed, 14 Oct 2026 18:39:19 +0000
Message-ID: <20261014183921.495158-6-vladimir.medvedkin@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261014183921.495158-1-vladimir.medvedkin@intel.com>
References: <20260322154215.3686528-1-vladimir.medvedkin@intel.com>
 <20261014183921.495158-1-vladimir.medvedkin@intel.com>
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

Allow a FIB to hold several independent routing tables (VRFs):

- rte_fib_conf gains the number of VRFs (max_vrfs, 0 or 1 meaning a
  single VRF as before) and optional per-VRF default nexthops;
- rte_fib_vrf_add(), rte_fib_vrf_delete() and rte_fib_vrf_lookup_bulk()
  take a VRF ID (one per address for the lookup), rte_fib_vrf_get_rib()
  returns the RIB of a VRF. The legacy functions operate on VRF 0;
- the dataplane modify and lookup callbacks gain a VRF argument, a NULL
  VRF array meaning VRF 0 for every address.

The FIB keeps one RIB per VRF. The DIR8_16_8 algorithm supports
multiple VRFs natively: its 2 KB root table is replicated per VRF while
the tbl16 and tbl8 pools are shared, and the scalar and AVX512 lookup
functions index the root table with the VRF ID when more than one VRF
is configured. The other algorithms reject max_vrfs >= 2.

Add a VRF mode to test-fib, enabled by the new "-V <number of VRFs>"
option or by a routes or lookup file with a leading VRF field
("<vrf> <prefix>/<depth> <nexthop>", "<vrf> <address>"), the format
being detected from the number of fields. The FIB is created with that
many VRFs and exercised through the VRF API: generated routes are
spread randomly over the VRFs and each generated lookup address is
looked up in the VRF of the route it is derived from (or in a random
VRF for the random ones), -w and -u dump the VRF formats, and the
comparison with LPM (-c) uses one LPM table per VRF, demultiplexing
every burst by VRF as an application would do.

A multi-VRF deployment usually has a full view in VRF 0 and much smaller
tables in the other VRFs, which a random VRF per route does not
reproduce. The "--vrfconf" option, a list of "<vrf> <n>%" items, gives
every listed VRF a random n% of the VRF 0 routes (read from the file or
generated), with their next hops. The routes of the other VRFs are
appended to the table, so that the lookup addresses derived from the
routes are spread over the VRFs like the routes are.

Signed-off-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
---
 app/test-fib/main.c                    | 557 +++++++++++++++----
 app/test/test_fib.c                    | 714 ++++++++++++++++++++++++-
 app/test/test_fib_perf.c               | 350 +++---------
 app/test/test_fib_routes.h             | 282 ++++++++++
 doc/guides/prog_guide/fib_lib.rst      |  33 +-
 doc/guides/rel_notes/release_26_11.rst |  15 +
 lib/fib/dir24_8.c                      |   4 +-
 lib/fib/dir24_8.h                      |  39 +-
 lib/fib/dir24_8_avx512.c               |  18 +-
 lib/fib/dir24_8_avx512.h               |  32 +-
 lib/fib/dir24_8_rvv.c                  |   3 +-
 lib/fib/dir24_8_rvv.h                  |  16 +-
 lib/fib/dir8_16_8.c                    | 127 +++--
 lib/fib/dir8_16_8.h                    |  63 ++-
 lib/fib/dir8_16_8_avx512.c             |  79 ++-
 lib/fib/dir8_16_8_avx512.h             |  16 +-
 lib/fib/rte_fib.c                      | 192 +++++--
 lib/fib/rte_fib.h                      |  98 +++-
 18 files changed, 2077 insertions(+), 561 deletions(-)
 create mode 100644 app/test/test_fib_routes.h

diff --git a/app/test-fib/main.c b/app/test-fib/main.c
index be1ba20277..96efe0d618 100644
--- a/app/test-fib/main.c
+++ b/app/test-fib/main.c
@@ -2,7 +2,9 @@
  * Copyright(c) 2019 Intel Corporation
  */
 
+#include <ctype.h>
 #include <getopt.h>
+#include <stdbool.h>
 #include <stdlib.h>
 #include <string.h>
 
@@ -54,16 +56,33 @@
 #define SHUFFLE_FLAG		(1 << 7)
 #define DRY_RUN_FLAG		(1 << 8)
 #define ENT_SZ_FLAG		(1 << 9)
+#define VRF_FLAG		(1 << 10)
+
+/* Maximum number of VRFs derived from VRF 0 with --vrfconf. */
+#define MAX_VRF_CONF		64
 
 static char *distrib_string;
 static char line[LINE_MAX];
 
 enum {
+	RT_VRF,
 	RT_PREFIX,
 	RT_NEXTHOP,
 	RT_NUM
 };
 
+enum {
+	LK_VRF,
+	LK_IP,
+	LK_NUM
+};
+
+/* A VRF holding a random share of the VRF 0 routes. */
+struct vrf_conf {
+	uint16_t	vrf;
+	uint8_t		pct;
+};
+
 #ifndef NIPQUAD
 #define NIPQUAD_FMT "%u.%u.%u.%u"
 #define NIPQUAD(addr)				\
@@ -81,12 +100,20 @@ static struct {
 	const char	*lookup_ips_file_s;
 	void		*rt;
 	void		*lookup_tbl;
-	uint32_t	nb_routes;
+	uint16_t	*lookup_vrfs;	/**< Per lookup address VRF (VRF mode). */
+	struct vrf_conf	vrf_conf[MAX_VRF_CONF];
+	unsigned int	nb_vrf_conf;
+	uint32_t	nb_routes;	/**< All the routes, VRF copies included. */
+	uint32_t	nb_base_routes;	/**< Routes read from the file or generated. */
 	uint32_t	nb_lookup_ips;
 	uint32_t	nb_lookup_ips_rnd;
 	uint32_t	nb_routes_per_depth[128 + 1];
 	uint32_t	flags;
 	uint32_t	tbl8;
+	uint16_t	nb_vrfs;	/**< Number of VRFs, 0 = VRF mode off. */
+	uint32_t	*nb_vrf_routes;	/**< Number of routes of every VRF. */
+	bool		routes_file_vrf;	/**< Routes file has a VRF field. */
+	bool		lookup_file_vrf;	/**< Lookup file has a VRF field. */
 	uint8_t		ent_sz;
 	uint8_t		rnd_lookup_ips_ratio;
 	uint8_t		print_fract;
@@ -100,6 +127,7 @@ static struct {
 	.nb_routes_per_depth = {0},
 	.flags = FIB_V4_DIR_TYPE,
 	.tbl8 = DEFAULT_LPM_TBL8,
+	.nb_vrfs = 0,
 	.ent_sz = 4,
 	.rnd_lookup_ips_ratio = 0,
 	.print_fract = 10,
@@ -109,15 +137,39 @@ static struct {
 struct rt_rule_4 {
 	uint32_t	addr;
 	uint8_t		depth;
+	uint16_t	vrf;
 	uint64_t	nh;
 };
 
 struct rt_rule_6 {
 	struct rte_ipv6_addr addr;
 	uint8_t		depth;
+	uint16_t	vrf;
 	uint64_t	nh;
 };
 
+static inline bool
+vrf_enabled(void)
+{
+	return (config.flags & VRF_FLAG) != 0;
+}
+
+static inline uint16_t
+rnd_vrf(void)
+{
+	return vrf_enabled() ? rte_rand() % config.nb_vrfs : 0;
+}
+
+/* Generated routes go to VRF 0 when the other VRFs are derived from it. */
+static inline uint16_t
+gen_vrf(void)
+{
+	uint16_t vrf = (config.nb_vrf_conf != 0) ? 0 : rnd_vrf();
+
+	config.nb_vrf_routes[vrf]++;
+	return vrf;
+}
+
 static uint64_t
 get_rnd_rng(uint64_t l, uint64_t u)
 {
@@ -276,17 +328,9 @@ shuffle_rt_4(struct rt_rule_4 *rt, int n)
 
 	for (i = 0; i < n; i++) {
 		j = rte_rand() % n;
-		tmp.addr = rt[i].addr;
-		tmp.depth = rt[i].depth;
-		tmp.nh = rt[i].nh;
-
-		rt[i].addr = rt[j].addr;
-		rt[i].depth = rt[j].depth;
-		rt[i].nh = rt[j].nh;
-
-		rt[j].addr = tmp.addr;
-		rt[j].depth = tmp.depth;
-		rt[j].nh = tmp.nh;
+		tmp = rt[i];
+		rt[i] = rt[j];
+		rt[j] = tmp;
 	}
 }
 
@@ -298,17 +342,9 @@ shuffle_rt_6(struct rt_rule_6 *rt, int n)
 
 	for (i = 0; i < n; i++) {
 		j = rte_rand() % n;
-		tmp.addr = rt[i].addr;
-		tmp.depth = rt[i].depth;
-		tmp.nh = rt[i].nh;
-
-		rt[i].addr = rt[j].addr;
-		rt[i].depth = rt[j].depth;
-		rt[i].nh = rt[j].nh;
-
-		rt[j].addr = tmp.addr;
-		rt[j].depth = tmp.depth;
-		rt[j].nh = tmp.nh;
+		tmp = rt[i];
+		rt[i] = rt[j];
+		rt[j] = tmp;
 	}
 }
 
@@ -320,6 +356,7 @@ gen_random_rt_4(struct rt_rule_4 *rt, int nh_sz)
 	if (config.nb_routes_per_depth[0] != 0) {
 		rt[k].addr = 0;
 		rt[k].depth = 0;
+		rt[k].vrf = gen_vrf();
 		rt[k++].nh = rte_rand() & get_max_nh(nh_sz);
 	}
 
@@ -333,6 +370,7 @@ gen_random_rt_4(struct rt_rule_4 *rt, int nh_sz)
 				(uint64_t)(edge + step));
 			rt[k].addr = rnd_val << (32 - i);
 			rt[k].depth = i;
+			rt[k].vrf = gen_vrf();
 			rt[k].nh = rte_rand() & get_max_nh(nh_sz);
 		}
 	}
@@ -358,6 +396,7 @@ gen_random_rt_6(struct rt_rule_6 *rt, int nh_sz)
 	if (config.nb_routes_per_depth[0] != 0) {
 		memset(&rt[k].addr, 0, 16);
 		rt[k].depth = 0;
+		rt[k].vrf = gen_vrf();
 		rt[k++].nh = rte_rand() & get_max_nh(nh_sz);
 	}
 
@@ -375,6 +414,7 @@ gen_random_rt_6(struct rt_rule_6 *rt, int nh_sz)
 				complete_v6_addr((uint32_t *)&rt[k].addr,
 					rnd, a);
 				rt[k].depth = (a * 32) + i;
+				rt[k].vrf = gen_vrf();
 				rt[k].nh = rte_rand() & get_max_nh(nh_sz);
 			}
 		}
@@ -415,19 +455,24 @@ gen_rnd_lookup_tbl(int af)
 				i++, j = (j + 1) % config.nb_routes) {
 			if ((rte_rand() % 100) < config.rnd_lookup_ips_ratio) {
 				tbl4[i] = rte_rand();
+				config.lookup_vrfs[i] = rnd_vrf();
 				config.nb_lookup_ips_rnd++;
-			} else
+			} else {
 				tbl4[i] = rt4[j].addr | (rte_rand() &
 					((1ULL << (32 - rt4[j].depth)) - 1));
+				config.lookup_vrfs[i] = rt4[j].vrf;
+			}
 		}
 	} else {
 		for (i = 0, j = 0; i < config.nb_lookup_ips;
 				i++, j = (j + 1) % config.nb_routes) {
 			if ((rte_rand() % 100) < config.rnd_lookup_ips_ratio) {
 				set_rnd_ipv6(&tbl6[i], &rt6[j].addr, 0);
+				config.lookup_vrfs[i] = rnd_vrf();
 				config.nb_lookup_ips_rnd++;
 			} else {
 				set_rnd_ipv6(&tbl6[i], &rt6[j].addr, rt6[j].depth);
+				config.lookup_vrfs[i] = rt6[j].vrf;
 			}
 		}
 	}
@@ -459,33 +504,159 @@ _inet_net_pton(int af, char *prefix, void *addr)
 	return depth;
 }
 
+/*
+ * Split a line into its fields: "[<vrf>] <prefix>/<depth> <nexthop>" for
+ * routes, "[<vrf>] <address>" for lookups. The VRF field is validated
+ * against the number of VRFs.
+ */
 static int
-parse_rt_4(FILE *f)
+parse_fields(char *s, char **in, int nb_fields, bool has_vrf, uint16_t *vrf)
 {
-	int ret, i, j = 0;
-	char *s, *sp, *in[RT_NUM];
 	static const char *dlm = " \t\n";
-	int string_tok_nb = RTE_DIM(in);
+	char *sp, *tok;
+	int i, first = has_vrf ? 0 : 1;
+
+	for (i = first; i < nb_fields; i++) {
+		tok = strtok_r(s, dlm, &sp);
+		if (tok == NULL)
+			return -EINVAL;
+		in[i] = tok;
+		s = NULL;
+	}
+	if (strtok_r(NULL, dlm, &sp) != NULL)
+		return -EINVAL;
+
+	*vrf = 0;
+	if (has_vrf) {
+		tok = in[0];
+		GET_CB_FIELD(tok, *vrf, 0,
+			(unsigned long)RTE_MAX(config.nb_vrfs, 1) - 1, 0);
+	}
+	return 0;
+}
+
+/*
+ * Count the lines of a file and detect its format: a line with one more
+ * field than the plain format starts with a VRF, the biggest one is returned.
+ */
+static uint32_t
+scan_file(FILE *f, int nb_plain_fields, bool *has_vrf, uint16_t *max_vrf)
+{
+	uint32_t nb_lines = 0;
+	int nb_fields;
+	char *s;
+
+	*has_vrf = false;
+	*max_vrf = 0;
+	while (fgets(line, sizeof(line), f) != NULL) {
+		nb_fields = 0;
+		for (s = line; *s != '\0'; s++) {
+			if (!isspace((unsigned char)*s) &&
+					(s == line || isspace((unsigned char)s[-1])))
+				nb_fields++;
+		}
+		if (nb_fields == 0)
+			continue;
+		if (nb_lines == 0)
+			*has_vrf = (nb_fields == nb_plain_fields + 1);
+		if (*has_vrf) {
+			unsigned long vrf;
+			char *end;
+
+			errno = 0;
+			vrf = strtoul(line, &end, 0);
+			if (errno != 0 || end == line || vrf >= UINT16_MAX)
+				rte_exit(-EINVAL, "Bad VRF at line %u\n",
+					nb_lines + 1);
+			*max_vrf = RTE_MAX(*max_vrf, (uint16_t)vrf);
+		}
+		nb_lines++;
+	}
+	rewind(f);
+	return nb_lines;
+}
+
+/* Number of routes of a VRF derived from VRF 0 with --vrfconf. */
+static uint32_t
+nb_vrf_conf_routes(const struct vrf_conf *vc)
+{
+	return RTE_MAX((uint64_t)config.nb_base_routes * vc->pct / 100, 1U);
+}
+
+/*
+ * Every VRF of --vrfconf gets a random subset of the VRF 0 routes, with their
+ * next hops, appended after the base routes.
+ */
+static void
+gen_vrf_copies(int af)
+{
+	struct rt_rule_4 *rt4 = config.rt;
+	struct rt_rule_6 *rt6 = config.rt;
+	uint64_t *copied;
+	uint32_t i, j, k, n;
+	unsigned int c;
+
+	if (config.nb_vrf_conf == 0)
+		return;
+
+	/* Bitmap of the base routes already copied to the current VRF. */
+	copied = malloc(RTE_ALIGN_CEIL(config.nb_base_routes, 64) / 8);
+	if (copied == NULL)
+		rte_exit(-ENOMEM, "Can not alloc the VRF copies bitmap\n");
+
+	k = config.nb_base_routes;
+	for (c = 0; c < config.nb_vrf_conf; c++) {
+		uint16_t vrf = config.vrf_conf[c].vrf;
+
+		n = RTE_MIN(nb_vrf_conf_routes(&config.vrf_conf[c]),
+			config.nb_vrf_routes[0]);
+		memset(copied, 0, RTE_ALIGN_CEIL(config.nb_base_routes, 64) / 8);
+		for (i = 0; i < n; i++, k++) {
+			/* A random VRF 0 route not copied to this VRF yet. */
+			do {
+				j = rte_rand() % config.nb_base_routes;
+			} while ((copied[j / 64] & RTE_BIT64(j % 64)) != 0 ||
+				((af == AF_INET) ? rt4[j].vrf : rt6[j].vrf) != 0);
+			copied[j / 64] |= RTE_BIT64(j % 64);
+			if (af == AF_INET) {
+				rt4[k] = rt4[j];
+				rt4[k].vrf = vrf;
+				config.nb_routes_per_depth[rt4[k].depth]++;
+			} else {
+				rt6[k] = rt6[j];
+				rt6[k].vrf = vrf;
+				config.nb_routes_per_depth[rt6[k].depth]++;
+			}
+		}
+		config.nb_vrf_routes[vrf] += n;
+	}
+	config.nb_routes = k;
+	free(copied);
+}
+
+static int
+parse_rt_4(FILE *f)
+{
+	int ret, j = 0;
+	char *in[RT_NUM];
 	struct rt_rule_4 *rt;
 
 	rt = (struct rt_rule_4 *)config.rt;
 
 	while (fgets(line, sizeof(line), f) != NULL) {
-		s = line;
-		for (i = 0; i != string_tok_nb; i++) {
-			in[i] = strtok_r(s, dlm, &sp);
-			if (in[i] == NULL)
-				return -EINVAL;
-			s = NULL;
-		}
+		ret = parse_fields(line, in, RT_NUM, config.routes_file_vrf,
+			&rt[j].vrf);
+		if (ret != 0)
+			return ret;
 
 		ret = _inet_net_pton(AF_INET, in[RT_PREFIX], &rt[j].addr);
-		if (ret == -1)
-			return -errno;
+		if (ret < 0)
+			return ret;
 
 		rt[j].addr = rte_be_to_cpu_32(rt[j].addr);
 		rt[j].depth = ret;
 		config.nb_routes_per_depth[ret]++;
+		config.nb_vrf_routes[rt[j].vrf]++;
 		GET_CB_FIELD(in[RT_NEXTHOP], rt[j].nh, 0,
 				UINT32_MAX, 0);
 		j++;
@@ -496,22 +667,17 @@ parse_rt_4(FILE *f)
 static int
 parse_rt_6(FILE *f)
 {
-	int ret, i, j = 0;
-	char *s, *sp, *in[RT_NUM];
-	static const char *dlm = " \t\n";
-	int string_tok_nb = RTE_DIM(in);
+	int ret, j = 0;
+	char *in[RT_NUM];
 	struct rt_rule_6 *rt;
 
 	rt = (struct rt_rule_6 *)config.rt;
 
 	while (fgets(line, sizeof(line), f) != NULL) {
-		s = line;
-		for (i = 0; i != string_tok_nb; i++) {
-			in[i] = strtok_r(s, dlm, &sp);
-			if (in[i] == NULL)
-				return -EINVAL;
-			s = NULL;
-		}
+		ret = parse_fields(line, in, RT_NUM, config.routes_file_vrf,
+			&rt[j].vrf);
+		if (ret != 0)
+			return ret;
 
 		ret = _inet_net_pton(AF_INET6, in[RT_PREFIX], &rt[j].addr);
 		if (ret < 0)
@@ -519,6 +685,7 @@ parse_rt_6(FILE *f)
 
 		rt[j].depth = ret;
 		config.nb_routes_per_depth[ret]++;
+		config.nb_vrf_routes[rt[j].vrf]++;
 		GET_CB_FIELD(in[RT_NEXTHOP], rt[j].nh, 0,
 				UINT32_MAX, 0);
 		j++;
@@ -534,21 +701,29 @@ parse_lookup(FILE *f, int af)
 	uint32_t i;
 	uint8_t *tbl = (uint8_t *)config.lookup_tbl;
 	int step = (af == AF_INET) ? 4 : 16;
-	char *s;
+	char *in[LK_NUM];
 
 	/* Only the addresses of the full bursts are read. */
 	for (i = 0; i < config.nb_lookup_ips &&
 			fgets(line, sizeof(line), f) != NULL; i++) {
-		s = strtok(line, " \t\n");
-		if (s == NULL)
-			return -EINVAL;
-		ret = inet_pton(af, s, &tbl[(size_t)i * step]);
+		ret = parse_fields(line, in, LK_NUM, config.lookup_file_vrf,
+			&config.lookup_vrfs[i]);
+		if (ret != 0)
+			return ret;
+		ret = inet_pton(af, in[LK_IP], &tbl[(size_t)i * step]);
 		if (ret != 1)
 			return -EINVAL;
 	}
 	return 0;
 }
 
+static void
+fprint_vrf(FILE *f, uint16_t vrf)
+{
+	if (vrf_enabled())
+		fprintf(f, "%u ", vrf);
+}
+
 static int
 dump_lookup(int af)
 {
@@ -564,11 +739,16 @@ dump_lookup(int af)
 	}
 
 	if (af == AF_INET) {
-		for (i = 0; i < config.nb_lookup_ips; i++)
+		for (i = 0; i < config.nb_lookup_ips; i++) {
+			fprint_vrf(f, config.lookup_vrfs[i]);
 			fprintf(f, NIPQUAD_FMT"\n", NIPQUAD(tbl4[i]));
+		}
 	} else {
-		for (i = 0; i < config.nb_lookup_ips; i++)
-			fprintf(f, RTE_IPV6_ADDR_FMT"\n", RTE_IPV6_ADDR_SPLIT(&tbl6[i * 16]));
+		for (i = 0; i < config.nb_lookup_ips; i++) {
+			fprint_vrf(f, config.lookup_vrfs[i]);
+			fprintf(f, RTE_IPV6_ADDR_FMT"\n",
+				RTE_IPV6_ADDR_SPLIT(&tbl6[i]));
+		}
 	}
 	fclose(f);
 	return 0;
@@ -603,6 +783,14 @@ print_config(void)
 		"Random lookup ips: %u\n",
 		config.nb_lookup_ips, config.rnd_lookup_ips_ratio,
 		config.nb_lookup_ips_rnd);
+	if (vrf_enabled()) {
+		uint32_t j;
+
+		fprintf(stdout, "VRFs: %u, routes per VRF:", config.nb_vrfs);
+		for (j = 0; j < RTE_MIN(config.nb_vrfs, 16U); j++)
+			fprintf(stdout, " %u", config.nb_vrf_routes[j]);
+		fprintf(stdout, (config.nb_vrfs > 16) ? " ...\n" : "\n");
+	}
 }
 
 static void
@@ -634,6 +822,13 @@ print_usage(void)
 		"[-e <entry size (valid only for dir and trie fib types): "
 		"1/2/4/8 (default 4)>]\n"
 		"[-g <number of tbl8's for dir24_8, dir8_16_8 or trie FIBs>]\n"
+		"[-V <number of VRFs (2 to 65535)>]\n"
+		"[--vrfconf <\",\" separated \"<vrf> <n>%%\" list: every listed "
+		"VRF gets a random n%% of the VRF 0 routes>]\n"
+		"\tVRF mode (valid for the dir8_16_8 FIB) is "
+		"enabled by -V, by --vrfconf or by a routes or lookup file with "
+		"a leading VRF field (\"<vrf> <prefix>/<depth> <nexthop>\", "
+		"\"<vrf> <address>\"), the other files put everything in VRF 0\n"
 		"[-w <path to the file to dump routing table>]\n"
 		"[-u <path to the file to dump ip's for lookup>]\n"
 		"[-v <type of lookup function:"
@@ -693,15 +888,89 @@ check_config(void)
 	return 0;
 }
 
+/* "<vrf> <percent>%[, ...]": VRFs holding a random share of VRF 0. */
+static int
+parse_vrf_conf(char *s)
+{
+	char *item, *sp, *end;
+	unsigned long vrf, pct;
+	unsigned int i;
+
+	for (item = strtok_r(s, ",", &sp); item != NULL;
+			item = strtok_r(NULL, ",", &sp)) {
+		if (config.nb_vrf_conf == MAX_VRF_CONF)
+			return -EINVAL;
+		errno = 0;
+		vrf = strtoul(item, &end, 0);
+		if (errno != 0 || end == item || vrf == 0 || vrf >= UINT16_MAX)
+			return -EINVAL;
+		item = end;
+		pct = strtoul(item, &end, 0);
+		if (errno != 0 || end == item || pct == 0 || pct > 100)
+			return -EINVAL;
+		if (*end == '%')
+			end++;
+		while (isspace((unsigned char)*end))
+			end++;
+		if (*end != '\0')
+			return -EINVAL;
+		for (i = 0; i < config.nb_vrf_conf; i++) {
+			if (config.vrf_conf[i].vrf == vrf)
+				return -EINVAL;
+		}
+		config.vrf_conf[config.nb_vrf_conf].vrf = vrf;
+		config.vrf_conf[config.nb_vrf_conf].pct = pct;
+		config.nb_vrf_conf++;
+	}
+	return (config.nb_vrf_conf != 0) ? 0 : -EINVAL;
+}
+
+/*
+ * VRF mode is enabled by the files with a VRF field, by --vrfconf and by -V,
+ * which can only raise the number of VRFs they need.
+ */
+static void
+setup_vrfs(uint16_t max_file_vrf)
+{
+	uint32_t nb_vrfs = (uint32_t)max_file_vrf + 1;
+	unsigned int i;
+
+	for (i = 0; i < config.nb_vrf_conf; i++)
+		nb_vrfs = RTE_MAX(nb_vrfs, (uint32_t)config.vrf_conf[i].vrf + 1);
+	if (config.nb_vrfs != 0 && config.nb_vrfs < nb_vrfs)
+		rte_exit(-EINVAL, "-V %u is less than the %u VRFs used\n",
+			config.nb_vrfs, nb_vrfs);
+	if (config.nb_vrfs == 0 && nb_vrfs > 1)
+		config.nb_vrfs = nb_vrfs;
+	if (config.nb_vrfs == 0)
+		return;
+	if ((config.flags & IPV6_FLAG) ||
+			(config.flags & FIB_TYPE_MASK) != FIB_V4_DIR_8_16_8_TYPE)
+		rte_exit(-EINVAL, "VRFs are only supported by the dir8_16_8 FIB "
+			"type\n");
+	config.flags |= VRF_FLAG;
+}
+
 static void
 parse_opts(int argc, char **argv)
 {
-	int opt;
+	static const struct option long_opts[] = {
+		{ "vrfconf", required_argument, NULL, 0 },
+		{ NULL, 0, NULL, 0 }
+	};
+	int opt, opt_idx;
 	char *endptr;
+	unsigned long val;
 
-	while ((opt = getopt(argc, argv, "f:t:n:d:l:r:c6ab:e:g:w:u:sv:")) !=
-			-1) {
+	while ((opt = getopt_long(argc, argv, "f:t:n:d:l:r:c6ab:e:g:w:u:sv:V:",
+			long_opts, &opt_idx)) != -1) {
 		switch (opt) {
+		case 0:
+			if (parse_vrf_conf(optarg) != 0) {
+				print_usage();
+				rte_exit(-EINVAL, "Invalid option --vrfconf\n");
+			}
+			break;
 		case 'f':
 			config.routes_file = optarg;
 			break;
@@ -795,6 +1064,16 @@ parse_opts(int argc, char **argv)
 				rte_exit(-EINVAL, "Invalid option -g\n");
 			}
 			break;
+		case 'V':
+			errno = 0;
+			val = strtoul(optarg, &endptr, 10);
+			if ((errno != 0) || (*endptr != '\0') || (val < 2) ||
+					(val > UINT16_MAX)) {
+				print_usage();
+				rte_exit(-EINVAL, "Invalid option -V\n");
+			}
+			config.nb_vrfs = val;
+			break;
 		case 'v':
 			if ((strcmp(optarg, "s1") == 0) ||
 					(strcmp(optarg, "s") == 0)) {
@@ -831,9 +1110,11 @@ dump_rt_4(struct rt_rule_4 *rt)
 		return -1;
 	}
 
-	for (i = 0; i < config.nb_routes; i++)
+	for (i = 0; i < config.nb_routes; i++) {
+		fprint_vrf(f, rt[i].vrf);
 		fprintf(f, NIPQUAD_FMT"/%d %"PRIu64"\n", NIPQUAD(rt[i].addr),
 			rt[i].depth, rt[i].nh);
+	}
 
 	fclose(f);
 	return 0;
@@ -846,6 +1127,43 @@ print_depth_err(void)
 		"-d 0:0 option or remove /0 prefix from routes file\n");
 }
 
+/* Number of LPM tables needed for the comparison: one per VRF. */
+static inline unsigned int
+nb_lpm_tables(void)
+{
+	return vrf_enabled() ? config.nb_vrfs : 1;
+}
+
+/*
+ * Per-VRF LPM lookup of a burst: the addresses are demultiplexed by VRF,
+ * looked up in bulk in the matching LPM table and the results put back in
+ * place. This is what an application would do with one LPM table per VRF.
+ */
+static void
+lpm_vrf_lookup_burst(struct rte_lpm **lpm, const uint16_t *vrfs,
+	const uint32_t *ips, uint32_t *nhs, unsigned int n)
+{
+	uint32_t tmp_ips[BURST_SZ], tmp_nhs[BURST_SZ];
+	unsigned int idx[BURST_SZ];
+	uint64_t done = 0;
+	unsigned int i, j, k;
+
+	for (i = 0; i < n; i++) {
+		if (done & (1ULL << i))
+			continue;
+		for (j = i, k = 0; j < n; j++) {
+			if (vrfs[j] != vrfs[i])
+				continue;
+			done |= 1ULL << j;
+			idx[k] = j;
+			tmp_ips[k++] = ips[j];
+		}
+		rte_lpm_lookup_bulk(lpm[vrfs[i]], tmp_ips, tmp_nhs, k);
+		for (j = 0; j < k; j++)
+			nhs[idx[j]] = tmp_nhs[j];
+	}
+}
+
 static int
 select_lookup_fn_v4(struct rte_fib *fib, enum rte_fib_type type)
 {
@@ -885,11 +1203,13 @@ run_v4(void)
 	struct rt_rule_4 *rt;
 	uint32_t i, j, k;
 	int ret = 0;
-	struct rte_lpm	*lpm = NULL;
+	struct rte_lpm	**lpm = NULL;
 	struct rte_lpm_config lpm_conf;
 	uint32_t *tbl4 = config.lookup_tbl;
+	const uint16_t *vrfs = vrf_enabled() ? config.lookup_vrfs : NULL;
 	uint64_t fib_nh[BURST_SZ];
 	uint32_t lpm_nh[BURST_SZ];
+	char name[32];
 
 	rt = (struct rt_rule_4 *)config.rt;
 
@@ -905,8 +1225,9 @@ run_v4(void)
 
 	conf.type = get_fib_type();
 	conf.default_nh = def_nh;
-	conf.max_routes = config.nb_routes * 2;
+	conf.max_routes = config.nb_base_routes * 2;
 	conf.rib_ext_sz = 0;
+	conf.max_vrfs = config.nb_vrfs;
 	if (conf.type == RTE_FIB_DIR24_8) {
 		conf.dir24_8.nh_sz = rte_ctz32(config.ent_sz);
 		conf.dir24_8.num_tbl8 = RTE_MIN(config.tbl8,
@@ -914,11 +1235,12 @@ run_v4(void)
 	} else if (conf.type == RTE_FIB_DIR8_16_8) {
 		/*
 		 * DIR8_16_8 only supports 8 byte next hops. The first stride
-		 * (8 bits) needs at most one second level group per /8, so 256
-		 * groups always suffice. The third level (last 8 bits) groups
-		 * are sized like the DIR24_8 tbl8s.
+		 * (8 bits) needs at most one second level group per /8 and
+		 * VRF, so 256 groups per VRF always suffice. The third level
+		 * (last 8 bits) groups are sized like the DIR24_8 tbl8s.
 		 */
-		conf.dir8_16_8.num_tbl16 = DIR8_16_8_MAX_TBL16;
+		conf.dir8_16_8.num_tbl16 = DIR8_16_8_MAX_TBL16 *
+			RTE_MAX(config.nb_vrfs, 1);
 		conf.dir8_16_8.num_tbl8 = config.tbl8;
 	}
 
@@ -939,8 +1261,8 @@ run_v4(void)
 	for (k = config.print_fract, i = 0; k > 0; k--) {
 		start = rte_rdtsc_precise();
 		for (j = 0; j < (config.nb_routes - i) / k; j++) {
-			ret = rte_fib_add(fib, rt[i + j].addr, rt[i + j].depth,
-				rt[i + j].nh);
+			ret = rte_fib_vrf_add(fib, rt[i + j].vrf, rt[i + j].addr,
+				rt[i + j].depth, rt[i + j].nh);
 			if (unlikely(ret != 0)) {
 				printf("Can not add a route to FIB, err %d\n",
 					ret);
@@ -957,16 +1279,23 @@ run_v4(void)
 		lpm_conf.number_tbl8s = RTE_MAX(conf.dir24_8.num_tbl8,
 			config.tbl8);
 
-		lpm = rte_lpm_create("test_lpm", -1, &lpm_conf);
-		if (lpm == NULL) {
-			printf("Can not alloc LPM, err %d\n", rte_errno);
-			return -rte_errno;
+		lpm = calloc(nb_lpm_tables(), sizeof(*lpm));
+		if (lpm == NULL)
+			return -ENOMEM;
+		for (i = 0; i < nb_lpm_tables(); i++) {
+			snprintf(name, sizeof(name), "test_lpm%u", i);
+			lpm[i] = rte_lpm_create(name, -1, &lpm_conf);
+			if (lpm[i] == NULL) {
+				printf("Can not alloc LPM, err %d\n", rte_errno);
+				return -rte_errno;
+			}
 		}
 		for (k = config.print_fract, i = 0; k > 0; k--) {
 			start = rte_rdtsc_precise();
 			for (j = 0; j < (config.nb_routes - i) / k; j++) {
-				ret = rte_lpm_add(lpm, rt[i + j].addr,
-					rt[i + j].depth, rt[i + j].nh);
+				ret = rte_lpm_add(lpm[rt[i + j].vrf],
+					rt[i + j].addr, rt[i + j].depth,
+					rt[i + j].nh);
 				if (ret != 0) {
 					if (rt[i + j].depth == 0)
 						print_depth_err();
@@ -984,7 +1313,8 @@ run_v4(void)
 	acc = 0;
 	for (i = 0; i < config.nb_lookup_ips; i += BURST_SZ) {
 		start = rte_rdtsc_precise();
-		ret = rte_fib_lookup_bulk(fib, tbl4 + i, fib_nh, BURST_SZ);
+		ret = rte_fib_vrf_lookup_bulk(fib, vrfs ? vrfs + i : NULL,
+			tbl4 + i, fib_nh, BURST_SZ);
 		acc += rte_rdtsc_precise() - start;
 		if (ret != 0) {
 			printf("FIB lookup fails, err %d\n", ret);
@@ -997,8 +1327,12 @@ run_v4(void)
 		acc = 0;
 		for (i = 0; i < config.nb_lookup_ips; i += BURST_SZ) {
 			start = rte_rdtsc_precise();
-			ret = rte_lpm_lookup_bulk(lpm, tbl4 + i, lpm_nh,
-				BURST_SZ);
+			if (vrfs != NULL)
+				lpm_vrf_lookup_burst(lpm, vrfs + i, tbl4 + i,
+					lpm_nh, BURST_SZ);
+			else
+				ret = rte_lpm_lookup_bulk(lpm[0], tbl4 + i,
+					lpm_nh, BURST_SZ);
 			acc += rte_rdtsc_precise() - start;
 			if (ret != 0) {
 				printf("LPM lookup fails, err %d\n", ret);
@@ -1008,8 +1342,14 @@ run_v4(void)
 		printf("AVG LPM lookup %.1f\n", (double)acc / (double)i);
 
 		for (i = 0; i < config.nb_lookup_ips; i += BURST_SZ) {
-			rte_fib_lookup_bulk(fib, tbl4 + i, fib_nh, BURST_SZ);
-			rte_lpm_lookup_bulk(lpm, tbl4 + i, lpm_nh, BURST_SZ);
+			rte_fib_vrf_lookup_bulk(fib, vrfs ? vrfs + i : NULL,
+				tbl4 + i, fib_nh, BURST_SZ);
+			if (vrfs != NULL)
+				lpm_vrf_lookup_burst(lpm, vrfs + i, tbl4 + i,
+					lpm_nh, BURST_SZ);
+			else
+				rte_lpm_lookup_bulk(lpm[0], tbl4 + i, lpm_nh,
+					BURST_SZ);
 			for (j = 0; j < BURST_SZ; j++) {
 				struct rte_lpm_tbl_entry *tbl;
 				tbl = (struct rte_lpm_tbl_entry *)&lpm_nh[j];
@@ -1027,7 +1367,8 @@ run_v4(void)
 	for (k = config.print_fract, i = 0; k > 0; k--) {
 		start = rte_rdtsc_precise();
 		for (j = 0; j < (config.nb_routes - i) / k; j++)
-			rte_fib_delete(fib, rt[i + j].addr, rt[i + j].depth);
+			rte_fib_vrf_delete(fib, rt[i + j].vrf, rt[i + j].addr,
+				rt[i + j].depth);
 
 		printf("AVG FIB delete %"PRIu64"\n",
 			(rte_rdtsc_precise() - start) / j);
@@ -1038,7 +1379,7 @@ run_v4(void)
 		for (k = config.print_fract, i = 0; k > 0; k--) {
 			start = rte_rdtsc_precise();
 			for (j = 0; j < (config.nb_routes - i) / k; j++)
-				rte_lpm_delete(lpm, rt[i + j].addr,
+				rte_lpm_delete(lpm[rt[i + j].vrf], rt[i + j].addr,
 					rt[i + j].depth);
 
 			printf("AVG LPM delete %"PRIu64"\n",
@@ -1063,9 +1404,9 @@ dump_rt_6(struct rt_rule_6 *rt)
 	}
 
 	for (i = 0; i < config.nb_routes; i++) {
-		fprintf(f, RTE_IPV6_ADDR_FMT"/%d %"PRIu64"\n", RTE_IPV6_ADDR_SPLIT(&rt[i].addr),
-			rt[i].depth, rt[i].nh);
-
+		fprint_vrf(f, rt[i].vrf);
+		fprintf(f, RTE_IPV6_ADDR_FMT"/%d %"PRIu64"\n",
+			RTE_IPV6_ADDR_SPLIT(&rt[i].addr), rt[i].depth, rt[i].nh);
 	}
 	fclose(f);
 	return 0;
@@ -1254,6 +1595,8 @@ main(int argc, char **argv)
 	int ret, af, rt_ent_sz, lookup_ent_sz;
 	FILE *fr = NULL;
 	FILE *fl = NULL;
+	uint16_t max_vrf, max_file_vrf = 0;
+	unsigned int i;
 	uint8_t depth_lim;
 
 	ret = rte_eal_init(argc, argv);
@@ -1284,14 +1627,9 @@ main(int argc, char **argv)
 			rte_exit(-errno, "Can not open file with routes %s\n",
 				config.routes_file);
 
-		config.nb_routes = 0;
-		while (fgets(line, sizeof(line), fr) != NULL)
-			config.nb_routes++;
-
-		if (config.nb_routes < config.print_fract)
-			config.print_fract = config.nb_routes;
-
-		rewind(fr);
+		config.nb_routes = scan_file(fr, RT_NUM - 1,
+			&config.routes_file_vrf, &max_vrf);
+		max_file_vrf = RTE_MAX(max_file_vrf, max_vrf);
 	}
 
 	/* Count number of ip's in file*/
@@ -1301,12 +1639,24 @@ main(int argc, char **argv)
 			rte_exit(-errno, "Can not open file with ip's %s\n",
 				config.lookup_ips_file);
 
-		config.nb_lookup_ips = 0;
-		while (fgets(line, sizeof(line), fl) != NULL)
-			config.nb_lookup_ips++;
-		rewind(fl);
+		config.nb_lookup_ips = scan_file(fl, LK_NUM - 1,
+			&config.lookup_file_vrf, &max_vrf);
+		max_file_vrf = RTE_MAX(max_file_vrf, max_vrf);
 	}
 
+	setup_vrfs(max_file_vrf);
+	config.nb_vrf_routes = calloc(RTE_MAX(config.nb_vrfs, 1),
+		sizeof(*config.nb_vrf_routes));
+	if (config.nb_vrf_routes == NULL)
+		rte_exit(-ENOMEM, "Can not alloc the per VRF route counts\n");
+
+	/* The VRFs of --vrfconf hold copies of the VRF 0 routes. */
+	config.nb_base_routes = config.nb_routes;
+	for (i = 0; i < config.nb_vrf_conf; i++)
+		config.nb_routes += nb_vrf_conf_routes(&config.vrf_conf[i]);
+	if (config.nb_routes < config.print_fract)
+		config.print_fract = config.nb_routes;
+
 	/* Lookups are done in full bursts, the leftovers are dropped. */
 	config.nb_lookup_ips = RTE_ALIGN_FLOOR(config.nb_lookup_ips, BURST_SZ);
 	if (config.nb_lookup_ips == 0)
@@ -1324,14 +1674,20 @@ main(int argc, char **argv)
 	if (config.lookup_tbl == NULL)
 		rte_exit(-ENOMEM, "Can not alloc lookup table\n");
 
+	/* Alloc table with the VRF of every ip for lookup (VRF 0 otherwise) */
+	config.lookup_vrfs = rte_zmalloc(NULL, sizeof(uint16_t) *
+		config.nb_lookup_ips, 0);
+	if (config.lookup_vrfs == NULL)
+		rte_exit(-ENOMEM, "Can not alloc lookup VRF table\n");
+
 	/* Fill routes table */
 	if (fr == NULL) {
 		if (distrib_string != NULL)
-			ret = parse_distrib(depth_lim, config.nb_routes);
+			ret = parse_distrib(depth_lim, config.nb_base_routes);
 		else {
 			uint8_t rpd[129] = {0};
 			uint32_t nrpd[129] = {0};
-			ret = complete_distrib(depth_lim, config.nb_routes,
+			ret = complete_distrib(depth_lim, config.nb_base_routes,
 				rpd, nrpd);
 		}
 		if (ret != 0)
@@ -1341,12 +1697,12 @@ main(int argc, char **argv)
 			gen_random_rt_4(config.rt,
 				rte_ctz32(config.ent_sz));
 			if (config.flags & SHUFFLE_FLAG)
-				shuffle_rt_4(config.rt, config.nb_routes);
+				shuffle_rt_4(config.rt, config.nb_base_routes);
 		} else {
 			gen_random_rt_6(config.rt,
 				rte_ctz32(config.ent_sz));
 			if (config.flags & SHUFFLE_FLAG)
-				shuffle_rt_6(config.rt, config.nb_routes);
+				shuffle_rt_6(config.rt, config.nb_base_routes);
 		}
 	} else {
 		if (af == AF_INET)
@@ -1359,6 +1715,7 @@ main(int argc, char **argv)
 				config.routes_file);
 		}
 	}
+	gen_vrf_copies(af);
 
 	/* Fill lookup table with ip's*/
 	if (fl == NULL)
diff --git a/app/test/test_fib.c b/app/test/test_fib.c
index bb8021c818..ce5e48264a 100644
--- a/app/test/test_fib.c
+++ b/app/test/test_fib.c
@@ -8,6 +8,7 @@
 #include <stdlib.h>
 #include <string.h>
 #include <inttypes.h>
+#include <errno.h>
 
 #include <rte_ip.h>
 #include <rte_log.h>
@@ -16,6 +17,7 @@
 #include <rte_malloc.h>
 
 #include "test.h"
+#include "test_fib_routes.h"
 
 typedef int32_t (*rte_fib_test)(void);
 
@@ -621,13 +623,479 @@ test_fib_rcu_sync_rw(void)
 	return status == 0 ? TEST_SUCCESS : TEST_FAILED;
 }
 
+/*
+ * VRF (Virtual Routing and Forwarding) tests for the DIR8_16_8 FIB.
+ * A VRF-capable FIB is created with max_vrfs >= 2; every VRF holds an
+ * independent routing table while sharing the underlying table pools.
+ */
+#define TEST_MAX_VRFS	4
 #define TEST_NUM_TBL16	16
 #define TEST_NUM_TBL8	64
+#define VRF_BURST_SZ	16
 #define DEF_NH		77
 
+static struct rte_fib *
+vrf_fib_create(const char *name, uint64_t *vrf_default_nh)
+{
+	struct rte_fib_conf cfg = {0};
+	char fib_name[24];
+
+	cfg.type = RTE_FIB_DIR8_16_8;
+	cfg.max_routes = 1000;
+	cfg.default_nh = DEF_NH;
+	cfg.max_vrfs = TEST_MAX_VRFS;
+	cfg.vrf_default_nh = vrf_default_nh;
+	cfg.dir8_16_8.num_tbl16 = TEST_NUM_TBL16;
+	cfg.dir8_16_8.num_tbl8 = TEST_NUM_TBL8;
+
+	snprintf(fib_name, sizeof(fib_name), "%.20s", name);
+	return rte_fib_create(fib_name, SOCKET_ID_ANY, &cfg);
+}
+
+static uint64_t
+vrf_lookup1(struct rte_fib *fib, uint16_t vrf, uint32_t ip)
+{
+	uint32_t ips[1] = { ip };
+	uint16_t vrfs[1] = { vrf };
+	uint64_t nhs[1] = { 0 };
+
+	if (rte_fib_vrf_lookup_bulk(fib, vrfs, ips, nhs, 1) != 0)
+		return UINT64_MAX;
+	return nhs[0];
+}
+
+static int32_t
+test_vrf_create_invalid(void)
+{
+	struct rte_fib *fib;
+	struct rte_fib_conf cfg = {0};
+	const char *name = "vrf_bad";
+
+	cfg.max_routes = 100;
+	cfg.default_nh = 0;
+	cfg.max_vrfs = TEST_MAX_VRFS;
+
+	cfg.type = RTE_FIB_DIR24_8;
+	cfg.dir24_8.nh_sz = RTE_FIB_DIR24_8_4B;
+	cfg.dir24_8.num_tbl8 = 128;
+	fib = rte_fib_create(name, SOCKET_ID_ANY, &cfg);
+	RTE_TEST_ASSERT(fib == NULL, "DIR24_8 must reject max_vrfs >= 2\n");
+
+	cfg.type = RTE_FIB_DUMMY;
+	fib = rte_fib_create(name, SOCKET_ID_ANY, &cfg);
+	RTE_TEST_ASSERT(fib == NULL, "DUMMY must reject max_vrfs >= 2\n");
+
+	cfg.type = RTE_FIB_DIR8_16_8;
+	cfg.dir8_16_8.num_tbl16 = 0;
+	cfg.dir8_16_8.num_tbl8 = TEST_NUM_TBL8;
+	fib = rte_fib_create(name, SOCKET_ID_ANY, &cfg);
+	RTE_TEST_ASSERT(fib == NULL, "num_tbl16 == 0 must fail\n");
+
+	return TEST_SUCCESS;
+}
+
+/*
+ * Same prefixes in each VRF resolve to that VRF's own nexthop, and a delete
+ * in one VRF does not affect the others.
+ */
+static int32_t
+test_vrf_isolation(void)
+{
+	struct rte_fib *fib;
+	uint16_t v;
+	uint64_t nh;
+
+	fib = vrf_fib_create(__func__, NULL);
+	RTE_TEST_ASSERT(fib != NULL, "Failed to create VRF FIB\n");
+
+	for (v = 0; v < TEST_MAX_VRFS; v++) {
+		RTE_TEST_ASSERT(rte_fib_vrf_add(fib, v, RTE_IPV4(10, 0, 0, 0),
+			8, 100 + v) == 0, "add /8 vrf %u\n", v);
+		RTE_TEST_ASSERT(rte_fib_vrf_add(fib, v, RTE_IPV4(192, 168, 0, 0),
+			16, 200 + v) == 0, "add /16 vrf %u\n", v);
+		RTE_TEST_ASSERT(rte_fib_vrf_add(fib, v, RTE_IPV4(10, 1, 1, 0),
+			24, 300 + v) == 0, "add /24 vrf %u\n", v);
+	}
+
+	for (v = 0; v < TEST_MAX_VRFS; v++) {
+		nh = vrf_lookup1(fib, v, RTE_IPV4(10, 2, 3, 4));
+		RTE_TEST_ASSERT(nh == (uint64_t)(100 + v),
+			"vrf %u /8 lookup got %"PRIu64"\n", v, nh);
+		nh = vrf_lookup1(fib, v, RTE_IPV4(192, 168, 5, 5));
+		RTE_TEST_ASSERT(nh == (uint64_t)(200 + v),
+			"vrf %u /16 lookup got %"PRIu64"\n", v, nh);
+		nh = vrf_lookup1(fib, v, RTE_IPV4(10, 1, 1, 7));
+		RTE_TEST_ASSERT(nh == (uint64_t)(300 + v),
+			"vrf %u /24 lookup got %"PRIu64"\n", v, nh);
+		nh = vrf_lookup1(fib, v, RTE_IPV4(8, 8, 8, 8));
+		RTE_TEST_ASSERT(nh == DEF_NH,
+			"vrf %u default lookup got %"PRIu64"\n", v, nh);
+	}
+
+	/* Delete the /8 from VRF 1 only. */
+	RTE_TEST_ASSERT(rte_fib_vrf_delete(fib, 1, RTE_IPV4(10, 0, 0, 0),
+		8) == 0, "del /8 vrf 1\n");
+	nh = vrf_lookup1(fib, 1, RTE_IPV4(10, 2, 3, 4));
+	RTE_TEST_ASSERT(nh == DEF_NH, "vrf 1 /8 after delete got %"PRIu64"\n",
+		nh);
+	/* The more specific /24 in VRF 1 still matches. */
+	nh = vrf_lookup1(fib, 1, RTE_IPV4(10, 1, 1, 7));
+	RTE_TEST_ASSERT(nh == 301, "vrf 1 /24 after /8 delete got %"PRIu64"\n",
+		nh);
+	/* Other VRFs are unaffected. */
+	for (v = 0; v < TEST_MAX_VRFS; v++) {
+		if (v == 1)
+			continue;
+		nh = vrf_lookup1(fib, v, RTE_IPV4(10, 2, 3, 4));
+		RTE_TEST_ASSERT(nh == (uint64_t)(100 + v),
+			"vrf %u /8 unexpectedly changed to %"PRIu64"\n", v, nh);
+	}
+
+	rte_fib_free(fib);
+	return TEST_SUCCESS;
+}
+
+/*
+ * The same network owned by a different prefix length in each VRF resolves
+ * independently; a VRF with no matching route returns its default.
+ */
+static int32_t
+test_vrf_overlapping_prefixes(void)
+{
+	struct rte_fib *fib;
+	uint64_t nh;
+
+	fib = vrf_fib_create(__func__, NULL);
+	RTE_TEST_ASSERT(fib != NULL, "Failed to create VRF FIB\n");
+
+	RTE_TEST_ASSERT(rte_fib_vrf_add(fib, 0, RTE_IPV4(10, 0, 0, 0), 8, 10)
+		== 0, "add /8 vrf 0\n");
+	RTE_TEST_ASSERT(rte_fib_vrf_add(fib, 1, RTE_IPV4(10, 1, 0, 0), 16, 20)
+		== 0, "add /16 vrf 1\n");
+	RTE_TEST_ASSERT(rte_fib_vrf_add(fib, 2, RTE_IPV4(10, 1, 1, 0), 24, 30)
+		== 0, "add /24 vrf 2\n");
+	/* VRF 3 has no matching route. */
+	nh = vrf_lookup1(fib, 0, RTE_IPV4(10, 1, 1, 5));
+	RTE_TEST_ASSERT(nh == 10, "vrf 0 /8 got %"PRIu64"\n", nh);
+	nh = vrf_lookup1(fib, 1, RTE_IPV4(10, 1, 1, 5));
+	RTE_TEST_ASSERT(nh == 20, "vrf 1 /16 got %"PRIu64"\n", nh);
+	nh = vrf_lookup1(fib, 2, RTE_IPV4(10, 1, 1, 5));
+	RTE_TEST_ASSERT(nh == 30, "vrf 2 /24 got %"PRIu64"\n", nh);
+	nh = vrf_lookup1(fib, 3, RTE_IPV4(10, 1, 1, 5));
+	RTE_TEST_ASSERT(nh == DEF_NH, "vrf 3 miss got %"PRIu64"\n", nh);
+
+	rte_fib_free(fib);
+	return TEST_SUCCESS;
+}
+
+/*
+ * A single bulk lookup carrying an interleaved per-IP VRF array resolves
+ * each address in its own VRF, with every available lookup implementation.
+ */
+static int32_t
+test_vrf_mixed_lookup(void)
+{
+	const enum rte_fib_lookup_type types[] = {
+		RTE_FIB_LOOKUP_DIR8_16_8_SCALAR,
+		RTE_FIB_LOOKUP_DIR8_16_8_VECTOR_AVX512,
+	};
+	struct rte_fib *fib;
+	uint32_t ips[VRF_BURST_SZ];
+	uint16_t vrfs[VRF_BURST_SZ];
+	uint64_t nhs[VRF_BURST_SZ];
+	unsigned int i, t;
+
+	fib = vrf_fib_create(__func__, NULL);
+	RTE_TEST_ASSERT(fib != NULL, "Failed to create VRF FIB\n");
+
+	/* Same prefix in every VRF, a distinct nexthop per VRF. */
+	for (i = 0; i < TEST_MAX_VRFS; i++)
+		RTE_TEST_ASSERT(rte_fib_vrf_add(fib, i, RTE_IPV4(20, 0, 0, 0),
+			8, i + 1) == 0, "add vrf %u\n", i);
+
+	for (i = 0; i < VRF_BURST_SZ; i++) {
+		ips[i] = RTE_IPV4(20, 0, 0, i + 1);
+		vrfs[i] = i % TEST_MAX_VRFS;
+	}
+
+	for (t = 0; t < RTE_DIM(types); t++) {
+		/* The vector lookup needs a 512 bit SIMD width. */
+		if (rte_fib_select_lookup(fib, types[t]) != 0)
+			continue;
+		memset(nhs, 0, sizeof(nhs));
+		RTE_TEST_ASSERT(rte_fib_vrf_lookup_bulk(fib, vrfs, ips, nhs,
+			VRF_BURST_SZ) == 0, "mixed lookup failed\n");
+
+		for (i = 0; i < VRF_BURST_SZ; i++)
+			RTE_TEST_ASSERT(nhs[i] == (i % TEST_MAX_VRFS) + 1,
+				"lookup type %u: pkt %u vrf %u got %"PRIu64"\n",
+				types[t], i, vrfs[i], nhs[i]);
+	}
+
+	rte_fib_free(fib);
+	return TEST_SUCCESS;
+}
+
+/* A lookup miss returns that VRF's configured default nexthop. */
+static int32_t
+test_vrf_default_nh(void)
+{
+	struct rte_fib *fib;
+	uint64_t vrf_def[TEST_MAX_VRFS];
+	uint16_t v;
+	uint64_t nh;
+
+	for (v = 0; v < TEST_MAX_VRFS; v++)
+		vrf_def[v] = 1000 + v;
+
+	fib = vrf_fib_create(__func__, vrf_def);
+	RTE_TEST_ASSERT(fib != NULL, "Failed to create VRF FIB\n");
+
+	for (v = 0; v < TEST_MAX_VRFS; v++) {
+		nh = vrf_lookup1(fib, v, RTE_IPV4(8, 8, 8, 8));
+		RTE_TEST_ASSERT(nh == (uint64_t)(1000 + v),
+			"vrf %u default nh got %"PRIu64"\n", v, nh);
+	}
+
+	rte_fib_free(fib);
+	return TEST_SUCCESS;
+}
+
+/* Re-adding an existing prefix updates its nexthop in place, per VRF. */
+static int32_t
+test_vrf_update_route(void)
+{
+	struct rte_fib *fib;
+	uint64_t nh;
+
+	fib = vrf_fib_create(__func__, NULL);
+	RTE_TEST_ASSERT(fib != NULL, "Failed to create VRF FIB\n");
+
+	RTE_TEST_ASSERT(rte_fib_vrf_add(fib, 2, RTE_IPV4(40, 0, 0, 0), 8, 5)
+		== 0, "initial add\n");
+	nh = vrf_lookup1(fib, 2, RTE_IPV4(40, 1, 1, 1));
+	RTE_TEST_ASSERT(nh == 5, "initial nh got %"PRIu64"\n", nh);
+
+	/* Re-add the same prefix with a new nexthop. */
+	RTE_TEST_ASSERT(rte_fib_vrf_add(fib, 2, RTE_IPV4(40, 0, 0, 0), 8, 99)
+		== 0, "update add\n");
+	nh = vrf_lookup1(fib, 2, RTE_IPV4(40, 1, 1, 1));
+	RTE_TEST_ASSERT(nh == 99, "updated nh got %"PRIu64"\n", nh);
+
+	/* The update stays within its VRF. */
+	nh = vrf_lookup1(fib, 0, RTE_IPV4(40, 1, 1, 1));
+	RTE_TEST_ASSERT(nh == DEF_NH, "vrf 0 leaked update %"PRIu64"\n", nh);
+
+	rte_fib_free(fib);
+	return TEST_SUCCESS;
+}
+
+/* Out-of-range VRF IDs are rejected by the VRF API. */
+static int32_t
+test_vrf_bounds(void)
+{
+	struct rte_fib *fib;
+	uint32_t ips[1] = { RTE_IPV4(1, 2, 3, 4) };
+	uint16_t vrfs[1];
+	uint64_t nhs[1];
+
+	fib = vrf_fib_create(__func__, NULL);
+	RTE_TEST_ASSERT(fib != NULL, "Failed to create VRF FIB\n");
+
+	RTE_TEST_ASSERT(rte_fib_vrf_add(fib, TEST_MAX_VRFS,
+		RTE_IPV4(1, 0, 0, 0), 8, 1) == -EINVAL,
+		"add with out-of-range vrf must fail\n");
+	RTE_TEST_ASSERT(rte_fib_vrf_delete(fib, TEST_MAX_VRFS,
+		RTE_IPV4(1, 0, 0, 0), 8) == -EINVAL,
+		"delete with out-of-range vrf must fail\n");
+	RTE_TEST_ASSERT(rte_fib_vrf_get_rib(fib, TEST_MAX_VRFS) == NULL,
+		"get_rib with out-of-range vrf must return NULL\n");
+
+	RTE_TEST_ASSERT(rte_fib_vrf_add(fib, TEST_MAX_VRFS - 1,
+		RTE_IPV4(1, 0, 0, 0), 8, 1) == 0,
+		"add to the last valid vrf must succeed\n");
+
+	/* A valid per-IP VRF lookup in the last VRF returns the new nexthop. */
+	vrfs[0] = TEST_MAX_VRFS - 1;
+	RTE_TEST_ASSERT(rte_fib_vrf_lookup_bulk(fib, vrfs, ips, nhs, 1) == 0,
+		"valid vrf lookup must succeed\n");
+	RTE_TEST_ASSERT(nhs[0] == 1, "lookup must return the added nexthop\n");
+
+	rte_fib_free(fib);
+	return TEST_SUCCESS;
+}
+
+/* Each VRF exposes a distinct, non-NULL RIB; VRF 0 is the main RIB. */
+static int32_t
+test_vrf_get_rib(void)
+{
+	struct rte_fib *fib;
+	struct rte_rib *ribs[TEST_MAX_VRFS];
+	uint16_t v, w;
+
+	fib = vrf_fib_create(__func__, NULL);
+	RTE_TEST_ASSERT(fib != NULL, "Failed to create VRF FIB\n");
+
+	for (v = 0; v < TEST_MAX_VRFS; v++) {
+		ribs[v] = rte_fib_vrf_get_rib(fib, v);
+		RTE_TEST_ASSERT(ribs[v] != NULL, "vrf %u rib is NULL\n", v);
+	}
+	RTE_TEST_ASSERT(rte_fib_vrf_get_rib(fib, 0) == rte_fib_get_rib(fib),
+		"vrf 0 rib must be the main rib\n");
+	for (v = 0; v < TEST_MAX_VRFS; v++)
+		for (w = v + 1; w < TEST_MAX_VRFS; w++)
+			RTE_TEST_ASSERT(ribs[v] != ribs[w],
+				"vrf %u and %u share a rib\n", v, w);
+
+	rte_fib_free(fib);
+	return TEST_SUCCESS;
+}
+
 /*
- * Network order lookups with every lookup implementation of DIR8_16_8, with a
- * burst of two vector groups and a leftover.
+ * RCU QSBR can be attached to a VRF FIB in both SYNC and DQ modes, and a
+ * second attach is rejected.
+ */
+static int32_t
+test_vrf_rcu(void)
+{
+	struct rte_fib *fib;
+	struct rte_rcu_qsbr *qsv, *qsv2;
+	struct rte_fib_rcu_config rcu_cfg = {0};
+	size_t sz;
+	int32_t status;
+
+	fib = vrf_fib_create(__func__, NULL);
+	RTE_TEST_ASSERT(fib != NULL, "Failed to create VRF FIB\n");
+
+	sz = rte_rcu_qsbr_get_memsize(RTE_MAX_LCORE);
+	qsv = (struct rte_rcu_qsbr *)rte_zmalloc_socket(NULL, sz,
+		RTE_CACHE_LINE_SIZE, SOCKET_ID_ANY);
+	RTE_TEST_ASSERT(qsv != NULL, "Can not allocate memory for RCU\n");
+	RTE_TEST_ASSERT(rte_rcu_qsbr_init(qsv, RTE_MAX_LCORE) == 0,
+		"Can not initialize RCU\n");
+
+	rcu_cfg.v = qsv;
+	rcu_cfg.mode = RTE_FIB_QSBR_MODE_SYNC;
+	status = rte_fib_rcu_qsbr_add(fib, &rcu_cfg);
+	RTE_TEST_ASSERT(status == 0, "Can not attach RCU to VRF FIB\n");
+
+	/* A second attach must be rejected. */
+	qsv2 = (struct rte_rcu_qsbr *)rte_zmalloc_socket(NULL, sz,
+		RTE_CACHE_LINE_SIZE, SOCKET_ID_ANY);
+	RTE_TEST_ASSERT(qsv2 != NULL, "Can not allocate memory for RCU\n");
+	rcu_cfg.v = qsv2;
+	status = rte_fib_rcu_qsbr_add(fib, &rcu_cfg);
+	RTE_TEST_ASSERT(status == -EEXIST,
+		"Secondary RCU was mistakenly attached\n");
+
+	rte_fib_free(fib);
+	rte_free(qsv);
+	rte_free(qsv2);
+
+	/* DQ (defer queue) mode must also attach to a VRF FIB. */
+	fib = vrf_fib_create("vrf_rcu_dq", NULL);
+	RTE_TEST_ASSERT(fib != NULL, "Failed to create VRF FIB\n");
+	qsv = (struct rte_rcu_qsbr *)rte_zmalloc_socket(NULL, sz,
+		RTE_CACHE_LINE_SIZE, SOCKET_ID_ANY);
+	RTE_TEST_ASSERT(qsv != NULL, "Can not allocate memory for RCU\n");
+	RTE_TEST_ASSERT(rte_rcu_qsbr_init(qsv, RTE_MAX_LCORE) == 0,
+		"Can not initialize RCU\n");
+	rcu_cfg.v = qsv;
+	rcu_cfg.mode = RTE_FIB_QSBR_MODE_DQ;
+	status = rte_fib_rcu_qsbr_add(fib, &rcu_cfg);
+	RTE_TEST_ASSERT(status == 0, "Can not attach DQ-mode RCU to VRF FIB\n");
+
+	rte_fib_free(fib);
+	rte_free(qsv);
+
+	return TEST_SUCCESS;
+}
+
+/*
+ * RCU sync reader/writer test for a VRF FIB. The reader looks up g_ip via
+ * the legacy bulk API (which targets VRF 0) while the writer churns the
+ * same route in VRF 0 with depth > 24 to force tbl8 group reclamation.
+ */
+static int32_t
+test_vrf_rcu_sync_rw(void)
+{
+	struct rte_fib_conf config = { 0 };
+	struct rte_fib_rcu_config rcu_cfg = {0};
+	size_t sz;
+	int32_t status;
+	uint32_t i, next_hop;
+	uint8_t depth;
+
+	if (rte_lcore_count() < 2) {
+		printf("Not enough cores for %s, expecting at least 2\n",
+			__func__);
+		return TEST_SKIPPED;
+	}
+
+	config.max_routes = MAX_ROUTES;
+	config.default_nh = DEF_NH;
+	config.type = RTE_FIB_DIR8_16_8;
+	config.max_vrfs = TEST_MAX_VRFS;
+	config.dir8_16_8.num_tbl16 = TEST_NUM_TBL16;
+	config.dir8_16_8.num_tbl8 = 1;
+
+	g_fib = rte_fib_create(__func__, SOCKET_ID_ANY, &config);
+	RTE_TEST_ASSERT(g_fib != NULL, "Failed to create VRF FIB\n");
+
+	sz = rte_rcu_qsbr_get_memsize(1);
+	g_v = (struct rte_rcu_qsbr *)rte_zmalloc_socket(NULL, sz,
+		RTE_CACHE_LINE_SIZE, SOCKET_ID_ANY);
+	RTE_TEST_ASSERT(g_v != NULL, "Can not allocate memory for RCU\n");
+
+	status = rte_rcu_qsbr_init(g_v, 1);
+	RTE_TEST_ASSERT(status == 0, "Can not initialize RCU\n");
+
+	rcu_cfg.v = g_v;
+	rcu_cfg.mode = RTE_FIB_QSBR_MODE_SYNC;
+	status = rte_fib_rcu_qsbr_add(g_fib, &rcu_cfg);
+	RTE_TEST_ASSERT(status == 0, "Can not attach RCU to VRF FIB\n");
+
+	writer_done = 0;
+	rte_eal_remote_launch(test_fib_rcu_qsbr_reader, NULL,
+		rte_get_next_lcore(-1, 1, 0));
+
+	depth = 28;
+	next_hop = 1;
+	status = rte_fib_vrf_add(g_fib, 0, g_ip, depth, next_hop);
+	if (status != 0) {
+		printf("%s: Failed to add rule\n", __func__);
+		goto error;
+	}
+
+	for (i = 0; i < WRITER_ITERATIONS; i++) {
+		status = rte_fib_vrf_delete(g_fib, 0, g_ip, depth);
+		if (status != 0) {
+			printf("%s: Failed to delete rule at iteration %d\n",
+				__func__, i);
+			goto error;
+		}
+
+		status = rte_fib_vrf_add(g_fib, 0, g_ip, depth, next_hop);
+		if (status != 0) {
+			printf("%s: Failed to add rule at iteration %d\n",
+				__func__, i);
+			goto error;
+		}
+	}
+
+error:
+	writer_done = 1;
+	rte_eal_mp_wait_lcore();
+
+	rte_fib_free(g_fib);
+	rte_free(g_v);
+
+	return status == 0 ? TEST_SUCCESS : TEST_FAILED;
+}
+
+/*
+ * Network order lookups with every lookup implementation of DIR8_16_8, in
+ * single and multi VRF FIBs, with a burst of two vector groups and a leftover.
  */
 static int32_t
 test_lookup_network_order(void)
@@ -645,9 +1113,11 @@ test_lookup_network_order(void)
 	const uint64_t probe_nhs[] = { 100, 300, 400, DEF_NH };
 	struct rte_fib_conf cfg = { 0 };
 	struct rte_fib *fib;
-	uint32_t ips[17];
-	uint64_t nhs[17];
-	unsigned int i, t;
+	uint32_t ips[VRF_BURST_SZ + 1];
+	uint16_t vrfs[VRF_BURST_SZ + 1];
+	uint64_t nhs[VRF_BURST_SZ + 1];
+	unsigned int i, t, nb_vrfs;
+	uint16_t v;
 
 	cfg.type = RTE_FIB_DIR8_16_8;
 	cfg.max_routes = 100;
@@ -656,34 +1126,217 @@ test_lookup_network_order(void)
 	cfg.dir8_16_8.num_tbl16 = TEST_NUM_TBL16;
 	cfg.dir8_16_8.num_tbl8 = TEST_NUM_TBL8;
 
-	fib = rte_fib_create("fib_be", SOCKET_ID_ANY, &cfg);
-	RTE_TEST_ASSERT(fib != NULL, "Failed to create FIB\n");
+	for (nb_vrfs = 1; nb_vrfs <= TEST_MAX_VRFS; nb_vrfs += TEST_MAX_VRFS - 1) {
+		cfg.max_vrfs = nb_vrfs;
+		fib = rte_fib_create("fib_be", SOCKET_ID_ANY, &cfg);
+		RTE_TEST_ASSERT(fib != NULL, "Failed to create FIB\n");
 
-	RTE_TEST_ASSERT(rte_fib_add(fib, RTE_IPV4(10, 0, 0, 0), 8, 100) == 0,
-		"add /8\n");
-	RTE_TEST_ASSERT(rte_fib_add(fib, RTE_IPV4(10, 1, 1, 0), 24, 300) == 0,
-		"add /24\n");
-	RTE_TEST_ASSERT(rte_fib_add(fib, RTE_IPV4(10, 1, 1, 7), 32, 400) == 0,
-		"add /32\n");
-	for (i = 0; i < RTE_DIM(ips); i++)
-		ips[i] = rte_cpu_to_be_32(probes[i % RTE_DIM(probes)]);
+		for (v = 0; v < nb_vrfs; v++) {
+			RTE_TEST_ASSERT(rte_fib_vrf_add(fib, v,
+				RTE_IPV4(10, 0, 0, 0), 8, 100 + v) == 0,
+				"add /8 vrf %u\n", v);
+			RTE_TEST_ASSERT(rte_fib_vrf_add(fib, v,
+				RTE_IPV4(10, 1, 1, 0), 24, 300 + v) == 0,
+				"add /24 vrf %u\n", v);
+			RTE_TEST_ASSERT(rte_fib_vrf_add(fib, v,
+				RTE_IPV4(10, 1, 1, 7), 32, 400 + v) == 0,
+				"add /32 vrf %u\n", v);
+		}
+		for (i = 0; i < RTE_DIM(ips); i++) {
+			ips[i] = rte_cpu_to_be_32(probes[i % RTE_DIM(probes)]);
+			vrfs[i] = i % nb_vrfs;
+		}
+
+		for (t = 0; t < RTE_DIM(types); t++) {
+			/* The vector lookup needs a 512 bit SIMD width. */
+			if (rte_fib_select_lookup(fib, types[t]) != 0)
+				continue;
+
+			memset(nhs, 0, sizeof(nhs));
+			RTE_TEST_ASSERT(rte_fib_vrf_lookup_bulk(fib, vrfs, ips,
+				nhs, RTE_DIM(ips)) == 0, "lookup failed\n");
+			for (i = 0; i < RTE_DIM(ips); i++) {
+				uint64_t exp = probe_nhs[i % RTE_DIM(probes)];
+
+				if (exp != DEF_NH)
+					exp += vrfs[i];
+				RTE_TEST_ASSERT(nhs[i] == exp, "%u vrfs, lookup "
+					"type %u: ip %u vrf %u got %"PRIu64
+					" expected %"PRIu64"\n", nb_vrfs,
+					types[t], i, vrfs[i], nhs[i], exp);
+			}
+
+			/* A NULL VRF array (and the legacy lookup) select VRF 0. */
+			memset(nhs, 0, sizeof(nhs));
+			RTE_TEST_ASSERT(rte_fib_vrf_lookup_bulk(fib, NULL, ips,
+				nhs, RTE_DIM(ips)) == 0, "lookup failed\n");
+			for (i = 0; i < RTE_DIM(ips); i++)
+				RTE_TEST_ASSERT(nhs[i] ==
+					probe_nhs[i % RTE_DIM(probes)],
+					"%u vrfs, lookup type %u: ip %u vrf 0 "
+					"got %"PRIu64"\n", nb_vrfs, types[t], i,
+					nhs[i]);
+		}
+		rte_fib_free(fib);
+	}
+
+	return TEST_SUCCESS;
+}
+
+#define ITERATIONS	(1 << 10)
+#define BATCH_SIZE	(1 << 12)
+#define BULK_SIZE	32
+
+/*
+ * VRF cross-validation.
+ *
+ * Build one VRF-capable DIR8_16_8 FIB with N VRFs and N independent reference
+ * DIR8_16_8 FIBs. The same large route table is added to each VRF and its
+ * matching reference, using a per-VRF distinct unique next hop. Each VRF lookup
+ * must match its reference exactly, which proves both per-VRF correctness and
+ * isolation (no VRF bleeds into another), with every available lookup
+ * implementation.
+ */
+static int
+vrf_validate_lookups_type(struct rte_fib *dut, struct rte_fib **ref,
+	enum rte_fib_lookup_type type)
+{
+	uint64_t mism = 0, total = 0;
+	unsigned int i, j;
+
+	/* Compare mixed per-IP VRF lookups against the matching references. */
+	for (i = 0; i < ITERATIONS; i++) {
+		static uint32_t ip_batch[BATCH_SIZE];
+		static uint16_t vrf_batch[BATCH_SIZE];
+		uint64_t nh_dut[BULK_SIZE];
+		uint64_t nh_ref[BULK_SIZE];
+
+		for (j = 0; j < BATCH_SIZE; j++) {
+			ip_batch[j] = rte_rand();
+			vrf_batch[j] = rte_rand() % TEST_MAX_VRFS;
+		}
+
+		for (j = 0; j < BATCH_SIZE; j += BULK_SIZE) {
+			uint32_t k;
+
+			rte_fib_vrf_lookup_bulk(dut, &vrf_batch[j],
+				&ip_batch[j], nh_dut, BULK_SIZE);
+			/* Reference: each IP resolved in its own VRF's FIB. */
+			for (k = 0; k < BULK_SIZE; k++)
+				rte_fib_lookup_bulk(ref[vrf_batch[j + k]],
+					&ip_batch[j + k], &nh_ref[k], 1);
+			for (k = 0; k < BULK_SIZE; k++) {
+				total++;
+				if (nh_dut[k] != nh_ref[k]) {
+					if (mism < 20)
+						printf("Mismatch vrf=%u "
+						"ip=0x%08x dut=%" PRIu64
+						" ref=%" PRIu64 "\n",
+						vrf_batch[j + k],
+						ip_batch[j + k],
+						nh_dut[k], nh_ref[k]);
+					mism++;
+				}
+			}
+		}
+	}
+
+	printf("Lookup type %u: validated %" PRIu64 " lookups across %u VRFs, "
+		"%" PRIu64 " mismatches\n", type, total, TEST_MAX_VRFS, mism);
+	return (mism != 0) ? -1 : 0;
+}
+
+/* Validate the lookups with every lookup implementation of the algorithm. */
+static int
+vrf_validate_lookups(struct rte_fib *dut, struct rte_fib **ref)
+{
+	const enum rte_fib_lookup_type types[] = {
+		RTE_FIB_LOOKUP_DIR8_16_8_SCALAR,
+		RTE_FIB_LOOKUP_DIR8_16_8_VECTOR_AVX512,
+	};
+	unsigned int t;
+	int ret;
 
 	for (t = 0; t < RTE_DIM(types); t++) {
 		/* The vector lookup needs a 512 bit SIMD width. */
-		if (rte_fib_select_lookup(fib, types[t]) != 0)
+		if (rte_fib_select_lookup(dut, types[t]) != 0)
 			continue;
+		ret = vrf_validate_lookups_type(dut, ref, types[t]);
+		if (ret != 0)
+			return ret;
+	}
+	return 0;
+}
 
-		memset(nhs, 0, sizeof(nhs));
-		RTE_TEST_ASSERT(rte_fib_lookup_bulk(fib, ips, nhs,
-			RTE_DIM(ips)) == 0, "lookup failed\n");
-		for (i = 0; i < RTE_DIM(ips); i++)
-			RTE_TEST_ASSERT(nhs[i] == probe_nhs[i % RTE_DIM(probes)],
-				"lookup type %u: ip %u got %"PRIu64"\n",
-				types[t], i, nhs[i]);
+static int
+test_fib_vrf_validate_dir8_16_8(void)
+{
+	struct rte_fib *dut = NULL;
+	struct rte_fib *ref[TEST_MAX_VRFS] = { NULL };
+	struct rte_fib_conf cfg = { 0 };
+	struct rte_fib_conf cfg_ref = { 0 };
+	unsigned int i;
+	uint16_t v;
+	int ret = 0;
+	char name[64];
+
+	generate_large_route_rule_table();
+
+	printf("No. routes = %u, VRFs = %u\n",
+		(unsigned int) NUM_ROUTE_ENTRIES, TEST_MAX_VRFS);
+
+	cfg.max_routes = 2000000;
+	cfg.default_nh = 0;
+	cfg.type = RTE_FIB_DIR8_16_8;
+	cfg.max_vrfs = TEST_MAX_VRFS;
+	cfg.dir8_16_8.num_tbl16 = 256 * TEST_MAX_VRFS;
+	cfg.dir8_16_8.num_tbl8 = 1 << 18;
+
+	dut = rte_fib_create("vrf_validate_dut", SOCKET_ID_ANY, &cfg);
+	RTE_TEST_ASSERT(dut != NULL, "Failed to create VRF FIB\n");
+
+	cfg_ref.max_routes = 2000000;
+	cfg_ref.default_nh = 0;
+	cfg_ref.type = RTE_FIB_DIR8_16_8;
+	cfg_ref.dir8_16_8.num_tbl16 = 256;
+	cfg_ref.dir8_16_8.num_tbl8 = 1 << 16;
+	for (v = 0; v < TEST_MAX_VRFS; v++) {
+		snprintf(name, sizeof(name), "vrf_validate_ref%u", v);
+		ref[v] = rte_fib_create(name, SOCKET_ID_ANY, &cfg_ref);
+		if (ref[v] == NULL) {
+			printf("Failed to create reference FIB %u\n", v);
+			ret = -1;
+			goto out;
+		}
 	}
-	rte_fib_free(fib);
 
-	return TEST_SUCCESS;
+	/* Add the same routes to each VRF and its reference, per-VRF unique nh. */
+	for (i = 0; i < NUM_ROUTE_ENTRIES; i++) {
+		for (v = 0; v < TEST_MAX_VRFS; v++) {
+			uint64_t nh = (uint64_t)i + 1 +
+				(uint64_t)v * ((uint64_t)MAX_RULE_NUM + 1);
+			int r_dut = rte_fib_vrf_add(dut, v,
+				large_route_table[i].ip,
+				large_route_table[i].depth, nh);
+			int r_ref = rte_fib_add(ref[v],
+				large_route_table[i].ip,
+				large_route_table[i].depth, nh);
+			if (r_dut != r_ref) {
+				printf("Add status mismatch i=%u vrf=%u "
+					"dut=%d ref=%d\n", i, v, r_dut, r_ref);
+				ret = -1;
+				goto out;
+			}
+		}
+	}
+
+	ret = vrf_validate_lookups(dut, ref);
+out:
+	rte_fib_free(dut);
+	for (v = 0; v < TEST_MAX_VRFS; v++)
+		rte_fib_free(ref[v]);
+
+	return ret;
 }
 
 static struct unit_test_suite fib_fast_tests = {
@@ -699,6 +1352,16 @@ static struct unit_test_suite fib_fast_tests = {
 	TEST_CASE(test_lookup_network_order),
 	TEST_CASE(test_invalid_rcu),
 	TEST_CASE(test_fib_rcu_sync_rw),
+	TEST_CASE(test_vrf_create_invalid),
+	TEST_CASE(test_vrf_isolation),
+	TEST_CASE(test_vrf_overlapping_prefixes),
+	TEST_CASE(test_vrf_mixed_lookup),
+	TEST_CASE(test_vrf_default_nh),
+	TEST_CASE(test_vrf_update_route),
+	TEST_CASE(test_vrf_bounds),
+	TEST_CASE(test_vrf_get_rib),
+	TEST_CASE(test_vrf_rcu),
+	TEST_CASE(test_vrf_rcu_sync_rw),
 	TEST_CASES_END()
 	}
 };
@@ -709,6 +1372,7 @@ static struct unit_test_suite fib_slow_tests = {
 	.teardown = NULL,
 	.unit_test_cases = {
 	TEST_CASE(test_multiple_create),
+	TEST_CASE(test_fib_vrf_validate_dir8_16_8),
 	TEST_CASES_END()
 	}
 };
diff --git a/app/test/test_fib_perf.c b/app/test/test_fib_perf.c
index 0967644316..ff8240aabf 100644
--- a/app/test/test_fib_perf.c
+++ b/app/test/test_fib_perf.c
@@ -6,17 +6,16 @@
 #include <stdio.h>
 #include <stdint.h>
 #include <stdlib.h>
-#include <math.h>
 #include <inttypes.h>
 
 #include <rte_cycles.h>
 #include <rte_random.h>
 #include <rte_branch_prediction.h>
-#include <rte_ip.h>
 #include <rte_fib.h>
 
 #include "test.h"
 #include "test_xmmt_ops.h"
+#include "test_fib_routes.h"
 
 #define TEST_FIB_ASSERT(cond) do {				\
 	if (!(cond)) {						\
@@ -29,270 +28,6 @@
 #define BATCH_SIZE (1 << 12)
 #define BULK_SIZE 32
 
-#define MAX_RULE_NUM (1200000)
-
-struct route_rule {
-	uint32_t ip;
-	uint8_t depth;
-};
-
-static struct route_rule large_route_table[MAX_RULE_NUM];
-
-static uint32_t num_route_entries;
-#define NUM_ROUTE_ENTRIES num_route_entries
-
-enum {
-	IP_CLASS_A,
-	IP_CLASS_B,
-	IP_CLASS_C
-};
-#define RTE_FIB_MAX_DEPTH	32
-/* struct route_rule_count defines the total number of rules in following a/b/c
- * each item in a[]/b[]/c[] is the number of common IP address class A/B/C, not
- * including the ones for private local network.
- */
-struct route_rule_count {
-	uint32_t a[RTE_FIB_MAX_DEPTH];
-	uint32_t b[RTE_FIB_MAX_DEPTH];
-	uint32_t c[RTE_FIB_MAX_DEPTH];
-};
-
-/* All following numbers of each depth of each common IP class are just
- * got from previous large constant table in app/test/test_lpm_routes.h .
- * In order to match similar performance, they keep same depth and IP
- * address coverage as previous constant table. These numbers don't
- * include any private local IP address. As previous large const rule
- * table was just dumped from a real router, there are no any IP address
- * in class C or D.
- */
-static struct route_rule_count rule_count = {
-	.a = { /* IP class A in which the most significant bit is 0 */
-		    0, /* depth =  1 */
-		    0, /* depth =  2 */
-		    1, /* depth =  3 */
-		    0, /* depth =  4 */
-		    2, /* depth =  5 */
-		    1, /* depth =  6 */
-		    3, /* depth =  7 */
-		  185, /* depth =  8 */
-		   26, /* depth =  9 */
-		   16, /* depth = 10 */
-		   39, /* depth = 11 */
-		  144, /* depth = 12 */
-		  233, /* depth = 13 */
-		  528, /* depth = 14 */
-		  866, /* depth = 15 */
-		 3856, /* depth = 16 */
-		 3268, /* depth = 17 */
-		 5662, /* depth = 18 */
-		17301, /* depth = 19 */
-		22226, /* depth = 20 */
-		11147, /* depth = 21 */
-		16746, /* depth = 22 */
-		17120, /* depth = 23 */
-		77578, /* depth = 24 */
-		  401, /* depth = 25 */
-		  656, /* depth = 26 */
-		 1107, /* depth = 27 */
-		 1121, /* depth = 28 */
-		 2316, /* depth = 29 */
-		  717, /* depth = 30 */
-		   10, /* depth = 31 */
-		   66  /* depth = 32 */
-	},
-	.b = { /* IP class A in which the most 2 significant bits are 10 */
-		    0, /* depth =  1 */
-		    0, /* depth =  2 */
-		    0, /* depth =  3 */
-		    0, /* depth =  4 */
-		    1, /* depth =  5 */
-		    1, /* depth =  6 */
-		    1, /* depth =  7 */
-		    3, /* depth =  8 */
-		    3, /* depth =  9 */
-		   30, /* depth = 10 */
-		   25, /* depth = 11 */
-		  168, /* depth = 12 */
-		  305, /* depth = 13 */
-		  569, /* depth = 14 */
-		 1129, /* depth = 15 */
-		50800, /* depth = 16 */
-		 1645, /* depth = 17 */
-		 1820, /* depth = 18 */
-		 3506, /* depth = 19 */
-		 3258, /* depth = 20 */
-		 3424, /* depth = 21 */
-		 4971, /* depth = 22 */
-		 6885, /* depth = 23 */
-		39771, /* depth = 24 */
-		  424, /* depth = 25 */
-		  170, /* depth = 26 */
-		  433, /* depth = 27 */
-		   92, /* depth = 28 */
-		  366, /* depth = 29 */
-		  377, /* depth = 30 */
-		    2, /* depth = 31 */
-		  200  /* depth = 32 */
-	},
-	.c = { /* IP class A in which the most 3 significant bits are 110 */
-		     0, /* depth =  1 */
-		     0, /* depth =  2 */
-		     0, /* depth =  3 */
-		     0, /* depth =  4 */
-		     0, /* depth =  5 */
-		     0, /* depth =  6 */
-		     0, /* depth =  7 */
-		    12, /* depth =  8 */
-		     8, /* depth =  9 */
-		     9, /* depth = 10 */
-		    33, /* depth = 11 */
-		    69, /* depth = 12 */
-		   237, /* depth = 13 */
-		  1007, /* depth = 14 */
-		  1717, /* depth = 15 */
-		 14663, /* depth = 16 */
-		  8070, /* depth = 17 */
-		 16185, /* depth = 18 */
-		 48261, /* depth = 19 */
-		 36870, /* depth = 20 */
-		 33960, /* depth = 21 */
-		 50638, /* depth = 22 */
-		 61422, /* depth = 23 */
-		466549, /* depth = 24 */
-		  1829, /* depth = 25 */
-		  4824, /* depth = 26 */
-		  4927, /* depth = 27 */
-		  5914, /* depth = 28 */
-		 10254, /* depth = 29 */
-		  4905, /* depth = 30 */
-		     1, /* depth = 31 */
-		   716  /* depth = 32 */
-	}
-};
-
-static void generate_random_rule_prefix(uint32_t ip_class, uint8_t depth)
-{
-/* IP address class A, the most significant bit is 0 */
-#define IP_HEAD_MASK_A			0x00000000
-#define IP_HEAD_BIT_NUM_A		1
-
-/* IP address class B, the most significant 2 bits are 10 */
-#define IP_HEAD_MASK_B			0x80000000
-#define IP_HEAD_BIT_NUM_B		2
-
-/* IP address class C, the most significant 3 bits are 110 */
-#define IP_HEAD_MASK_C			0xC0000000
-#define IP_HEAD_BIT_NUM_C		3
-
-	uint32_t class_depth;
-	uint32_t range;
-	uint32_t mask;
-	uint32_t step;
-	uint32_t start;
-	uint32_t fixed_bit_num;
-	uint32_t ip_head_mask;
-	uint32_t rule_num;
-	uint32_t k;
-	struct route_rule *ptr_rule;
-
-	if (ip_class == IP_CLASS_A) {        /* IP Address class A */
-		fixed_bit_num = IP_HEAD_BIT_NUM_A;
-		ip_head_mask = IP_HEAD_MASK_A;
-		rule_num = rule_count.a[depth - 1];
-	} else if (ip_class == IP_CLASS_B) { /* IP Address class B */
-		fixed_bit_num = IP_HEAD_BIT_NUM_B;
-		ip_head_mask = IP_HEAD_MASK_B;
-		rule_num = rule_count.b[depth - 1];
-	} else {                             /* IP Address class C */
-		fixed_bit_num = IP_HEAD_BIT_NUM_C;
-		ip_head_mask = IP_HEAD_MASK_C;
-		rule_num = rule_count.c[depth - 1];
-	}
-
-	if (rule_num == 0)
-		return;
-
-	/* the number of rest bits which don't include the most significant
-	 * fixed bits for this IP address class
-	 */
-	class_depth = depth - fixed_bit_num;
-
-	/* range is the maximum number of rules for this depth and
-	 * this IP address class
-	 */
-	range = 1 << class_depth;
-
-	/* only mask the most depth significant generated bits
-	 * except fixed bits for IP address class
-	 */
-	mask = range - 1;
-
-	/* Widen coverage of IP address in generated rules */
-	if (range <= rule_num)
-		step = 1;
-	else
-		step = round((double)range / rule_num);
-
-	/* Only generate rest bits except the most significant
-	 * fixed bits for IP address class
-	 */
-	start = rte_rand() & mask;
-	ptr_rule = &large_route_table[num_route_entries];
-	for (k = 0; k < rule_num; k++) {
-		ptr_rule->ip = (start << (RTE_FIB_MAX_DEPTH - depth))
-			| ip_head_mask;
-		ptr_rule->depth = depth;
-		ptr_rule++;
-		start = (start + step) & mask;
-	}
-	num_route_entries += rule_num;
-}
-
-static void insert_rule_in_random_pos(uint32_t ip, uint8_t depth)
-{
-	uint32_t pos;
-	int try_count = 0;
-	struct route_rule tmp;
-
-	do {
-		pos = rte_rand();
-		try_count++;
-	} while ((try_count < 10) && (pos > num_route_entries));
-
-	if ((pos > num_route_entries) || (pos >= MAX_RULE_NUM))
-		pos = num_route_entries >> 1;
-
-	tmp = large_route_table[pos];
-	large_route_table[pos].ip = ip;
-	large_route_table[pos].depth = depth;
-	if (num_route_entries < MAX_RULE_NUM)
-		large_route_table[num_route_entries++] = tmp;
-}
-
-static void generate_large_route_rule_table(void)
-{
-	uint32_t ip_class;
-	uint8_t  depth;
-
-	num_route_entries = 0;
-	memset(large_route_table, 0, sizeof(large_route_table));
-
-	for (ip_class = IP_CLASS_A; ip_class <= IP_CLASS_C; ip_class++) {
-		for (depth = 1; depth <= RTE_FIB_MAX_DEPTH; depth++)
-			generate_random_rule_prefix(ip_class, depth);
-	}
-
-	/* Add following rules to keep same as previous large constant table,
-	 * they are 4 rules with private local IP address and 1 all-zeros prefix
-	 * with depth = 8.
-	 */
-	insert_rule_in_random_pos(RTE_IPV4(0, 0, 0, 0), 8);
-	insert_rule_in_random_pos(RTE_IPV4(10, 2, 23, 147), 32);
-	insert_rule_in_random_pos(RTE_IPV4(192, 168, 100, 10), 24);
-	insert_rule_in_random_pos(RTE_IPV4(192, 168, 25, 100), 24);
-	insert_rule_in_random_pos(RTE_IPV4(192, 168, 129, 124), 32);
-}
-
 static void
 print_route_distribution(const struct route_rule *table, uint32_t n)
 {
@@ -437,5 +172,88 @@ test_fib_perf_dir8_16_8(void)
 	return measure_fib_perf("fib_perf_dir8_16_8", &config);
 }
 
+#define VRF_PERF_NB_VRFS	4
+
+static int
+test_fib_perf_vrf_dir8_16_8(void)
+{
+	struct rte_fib *fib = NULL;
+	struct rte_fib_conf config = { 0 };
+	uint64_t begin, total_time;
+	unsigned int i, j;
+	uint16_t v;
+	int status = 0;
+	int64_t count = 0;
+
+	config.max_routes = 2000000;
+	config.rib_ext_sz = 0;
+	config.type = RTE_FIB_DIR8_16_8;
+	config.default_nh = 0;
+	config.max_vrfs = VRF_PERF_NB_VRFS;
+	config.dir8_16_8.num_tbl16 = 256 * VRF_PERF_NB_VRFS;
+	config.dir8_16_8.num_tbl8 = 1 << 18;
+
+	generate_large_route_rule_table();
+
+	printf("No. routes = %u, VRFs = %u\n",
+		(unsigned int) NUM_ROUTE_ENTRIES, VRF_PERF_NB_VRFS);
+
+	fib = rte_fib_create("vrf_perf_d8", SOCKET_ID_ANY, &config);
+	TEST_FIB_ASSERT(fib != NULL);
+
+	begin = rte_rdtsc();
+	for (i = 0; i < NUM_ROUTE_ENTRIES; i++)
+		for (v = 0; v < VRF_PERF_NB_VRFS; v++)
+			if (rte_fib_vrf_add(fib, v, large_route_table[i].ip,
+					large_route_table[i].depth,
+					(uint64_t)i | ((uint64_t)v << 32)) == 0)
+				status++;
+	total_time = rte_rdtsc() - begin;
+	printf("Unique added entries = %d\n", status);
+	printf("Average VRF FIB Add: %g cycles\n", (double)total_time /
+		((double)NUM_ROUTE_ENTRIES * VRF_PERF_NB_VRFS));
+
+	total_time = 0;
+	count = 0;
+	for (i = 0; i < ITERATIONS; i++) {
+		static uint32_t ip_batch[BATCH_SIZE];
+		static uint16_t vrf_batch[BATCH_SIZE];
+		uint64_t next_hops[BULK_SIZE];
+
+		for (j = 0; j < BATCH_SIZE; j++) {
+			ip_batch[j] = rte_rand();
+			vrf_batch[j] = rte_rand() % VRF_PERF_NB_VRFS;
+		}
+
+		begin = rte_rdtsc();
+		for (j = 0; j < BATCH_SIZE; j += BULK_SIZE) {
+			uint32_t k;
+			rte_fib_vrf_lookup_bulk(fib, &vrf_batch[j], &ip_batch[j],
+				next_hops, BULK_SIZE);
+			for (k = 0; k < BULK_SIZE; k++)
+				if (unlikely(!(next_hops[k] != 0)))
+					count++;
+		}
+		total_time += rte_rdtsc() - begin;
+	}
+	printf("BULK VRF FIB Lookup: %.1f cycles (fails = %.1f%%)\n",
+		(double)total_time / ((double)ITERATIONS * BATCH_SIZE),
+		(count * 100.0) / (double)(ITERATIONS * BATCH_SIZE));
+
+	begin = rte_rdtsc();
+	for (i = 0; i < NUM_ROUTE_ENTRIES; i++)
+		for (v = 0; v < VRF_PERF_NB_VRFS; v++)
+			rte_fib_vrf_delete(fib, v, large_route_table[i].ip,
+				large_route_table[i].depth);
+	total_time = rte_rdtsc() - begin;
+	printf("Average VRF FIB Delete: %g cycles\n", (double)total_time /
+		((double)NUM_ROUTE_ENTRIES * VRF_PERF_NB_VRFS));
+
+	rte_fib_free(fib);
+
+	return 0;
+}
+
 REGISTER_PERF_TEST(fib_perf_autotest, test_fib_perf);
 REGISTER_PERF_TEST(fib_perf_dir8_16_8_autotest, test_fib_perf_dir8_16_8);
+REGISTER_PERF_TEST(fib_perf_vrf_dir8_16_8_autotest, test_fib_perf_vrf_dir8_16_8);
diff --git a/app/test/test_fib_routes.h b/app/test/test_fib_routes.h
new file mode 100644
index 0000000000..c03eaede05
--- /dev/null
+++ b/app/test/test_fib_routes.h
@@ -0,0 +1,282 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2018 Vladimir Medvedkin <medvedkinv@gmail.com>
+ * Copyright(c) 2019 Intel Corporation
+ */
+
+#ifndef _TEST_FIB_ROUTES_H_
+#define _TEST_FIB_ROUTES_H_
+
+#include <math.h>
+#include <stdint.h>
+#include <string.h>
+
+#include <rte_ip.h>
+#include <rte_random.h>
+
+/* Large IPv4 route table generator shared by the FIB tests. */
+
+#define MAX_RULE_NUM (1200000)
+
+struct route_rule {
+	uint32_t ip;
+	uint8_t depth;
+};
+
+static struct route_rule large_route_table[MAX_RULE_NUM];
+
+static uint32_t num_route_entries;
+#define NUM_ROUTE_ENTRIES num_route_entries
+
+enum {
+	IP_CLASS_A,
+	IP_CLASS_B,
+	IP_CLASS_C
+};
+#define RTE_FIB_MAX_DEPTH	32
+/* struct route_rule_count defines the total number of rules in following a/b/c
+ * each item in a[]/b[]/c[] is the number of common IP address class A/B/C, not
+ * including the ones for private local network.
+ */
+struct route_rule_count {
+	uint32_t a[RTE_FIB_MAX_DEPTH];
+	uint32_t b[RTE_FIB_MAX_DEPTH];
+	uint32_t c[RTE_FIB_MAX_DEPTH];
+};
+
+/* All following numbers of each depth of each common IP class are just
+ * got from previous large constant table in app/test/test_lpm_routes.h .
+ * In order to match similar performance, they keep same depth and IP
+ * address coverage as previous constant table. These numbers don't
+ * include any private local IP address. As previous large const rule
+ * table was just dumped from a real router, there are no any IP address
+ * in class C or D.
+ */
+static struct route_rule_count rule_count = {
+	.a = { /* IP class A in which the most significant bit is 0 */
+		    0, /* depth =  1 */
+		    0, /* depth =  2 */
+		    1, /* depth =  3 */
+		    0, /* depth =  4 */
+		    2, /* depth =  5 */
+		    1, /* depth =  6 */
+		    3, /* depth =  7 */
+		  185, /* depth =  8 */
+		   26, /* depth =  9 */
+		   16, /* depth = 10 */
+		   39, /* depth = 11 */
+		  144, /* depth = 12 */
+		  233, /* depth = 13 */
+		  528, /* depth = 14 */
+		  866, /* depth = 15 */
+		 3856, /* depth = 16 */
+		 3268, /* depth = 17 */
+		 5662, /* depth = 18 */
+		17301, /* depth = 19 */
+		22226, /* depth = 20 */
+		11147, /* depth = 21 */
+		16746, /* depth = 22 */
+		17120, /* depth = 23 */
+		77578, /* depth = 24 */
+		  401, /* depth = 25 */
+		  656, /* depth = 26 */
+		 1107, /* depth = 27 */
+		 1121, /* depth = 28 */
+		 2316, /* depth = 29 */
+		  717, /* depth = 30 */
+		   10, /* depth = 31 */
+		   66  /* depth = 32 */
+	},
+	.b = { /* IP class A in which the most 2 significant bits are 10 */
+		    0, /* depth =  1 */
+		    0, /* depth =  2 */
+		    0, /* depth =  3 */
+		    0, /* depth =  4 */
+		    1, /* depth =  5 */
+		    1, /* depth =  6 */
+		    1, /* depth =  7 */
+		    3, /* depth =  8 */
+		    3, /* depth =  9 */
+		   30, /* depth = 10 */
+		   25, /* depth = 11 */
+		  168, /* depth = 12 */
+		  305, /* depth = 13 */
+		  569, /* depth = 14 */
+		 1129, /* depth = 15 */
+		50800, /* depth = 16 */
+		 1645, /* depth = 17 */
+		 1820, /* depth = 18 */
+		 3506, /* depth = 19 */
+		 3258, /* depth = 20 */
+		 3424, /* depth = 21 */
+		 4971, /* depth = 22 */
+		 6885, /* depth = 23 */
+		39771, /* depth = 24 */
+		  424, /* depth = 25 */
+		  170, /* depth = 26 */
+		  433, /* depth = 27 */
+		   92, /* depth = 28 */
+		  366, /* depth = 29 */
+		  377, /* depth = 30 */
+		    2, /* depth = 31 */
+		  200  /* depth = 32 */
+	},
+	.c = { /* IP class A in which the most 3 significant bits are 110 */
+		     0, /* depth =  1 */
+		     0, /* depth =  2 */
+		     0, /* depth =  3 */
+		     0, /* depth =  4 */
+		     0, /* depth =  5 */
+		     0, /* depth =  6 */
+		     0, /* depth =  7 */
+		    12, /* depth =  8 */
+		     8, /* depth =  9 */
+		     9, /* depth = 10 */
+		    33, /* depth = 11 */
+		    69, /* depth = 12 */
+		   237, /* depth = 13 */
+		  1007, /* depth = 14 */
+		  1717, /* depth = 15 */
+		 14663, /* depth = 16 */
+		  8070, /* depth = 17 */
+		 16185, /* depth = 18 */
+		 48261, /* depth = 19 */
+		 36870, /* depth = 20 */
+		 33960, /* depth = 21 */
+		 50638, /* depth = 22 */
+		 61422, /* depth = 23 */
+		466549, /* depth = 24 */
+		  1829, /* depth = 25 */
+		  4824, /* depth = 26 */
+		  4927, /* depth = 27 */
+		  5914, /* depth = 28 */
+		 10254, /* depth = 29 */
+		  4905, /* depth = 30 */
+		     1, /* depth = 31 */
+		   716  /* depth = 32 */
+	}
+};
+
+static void generate_random_rule_prefix(uint32_t ip_class, uint8_t depth)
+{
+/* IP address class A, the most significant bit is 0 */
+#define IP_HEAD_MASK_A			0x00000000
+#define IP_HEAD_BIT_NUM_A		1
+
+/* IP address class B, the most significant 2 bits are 10 */
+#define IP_HEAD_MASK_B			0x80000000
+#define IP_HEAD_BIT_NUM_B		2
+
+/* IP address class C, the most significant 3 bits are 110 */
+#define IP_HEAD_MASK_C			0xC0000000
+#define IP_HEAD_BIT_NUM_C		3
+
+	uint32_t class_depth;
+	uint32_t range;
+	uint32_t mask;
+	uint32_t step;
+	uint32_t start;
+	uint32_t fixed_bit_num;
+	uint32_t ip_head_mask;
+	uint32_t rule_num;
+	uint32_t k;
+	struct route_rule *ptr_rule;
+
+	if (ip_class == IP_CLASS_A) {        /* IP Address class A */
+		fixed_bit_num = IP_HEAD_BIT_NUM_A;
+		ip_head_mask = IP_HEAD_MASK_A;
+		rule_num = rule_count.a[depth - 1];
+	} else if (ip_class == IP_CLASS_B) { /* IP Address class B */
+		fixed_bit_num = IP_HEAD_BIT_NUM_B;
+		ip_head_mask = IP_HEAD_MASK_B;
+		rule_num = rule_count.b[depth - 1];
+	} else {                             /* IP Address class C */
+		fixed_bit_num = IP_HEAD_BIT_NUM_C;
+		ip_head_mask = IP_HEAD_MASK_C;
+		rule_num = rule_count.c[depth - 1];
+	}
+
+	if (rule_num == 0)
+		return;
+
+	/* the number of rest bits which don't include the most significant
+	 * fixed bits for this IP address class
+	 */
+	class_depth = depth - fixed_bit_num;
+
+	/* range is the maximum number of rules for this depth and
+	 * this IP address class
+	 */
+	range = 1 << class_depth;
+
+	/* only mask the most depth significant generated bits
+	 * except fixed bits for IP address class
+	 */
+	mask = range - 1;
+
+	/* Widen coverage of IP address in generated rules */
+	if (range <= rule_num)
+		step = 1;
+	else
+		step = round((double)range / rule_num);
+
+	/* Only generate rest bits except the most significant
+	 * fixed bits for IP address class
+	 */
+	start = rte_rand() & mask;
+	ptr_rule = &large_route_table[num_route_entries];
+	for (k = 0; k < rule_num; k++) {
+		ptr_rule->ip = (start << (RTE_FIB_MAX_DEPTH - depth))
+			| ip_head_mask;
+		ptr_rule->depth = depth;
+		ptr_rule++;
+		start = (start + step) & mask;
+	}
+	num_route_entries += rule_num;
+}
+
+static void insert_rule_in_random_pos(uint32_t ip, uint8_t depth)
+{
+	uint32_t pos;
+	int try_count = 0;
+	struct route_rule tmp;
+
+	do {
+		pos = rte_rand();
+		try_count++;
+	} while ((try_count < 10) && (pos > num_route_entries));
+
+	if ((pos > num_route_entries) || (pos >= MAX_RULE_NUM))
+		pos = num_route_entries >> 1;
+
+	tmp = large_route_table[pos];
+	large_route_table[pos].ip = ip;
+	large_route_table[pos].depth = depth;
+	if (num_route_entries < MAX_RULE_NUM)
+		large_route_table[num_route_entries++] = tmp;
+}
+
+static void generate_large_route_rule_table(void)
+{
+	uint32_t ip_class;
+	uint8_t  depth;
+
+	num_route_entries = 0;
+	memset(large_route_table, 0, sizeof(large_route_table));
+
+	for (ip_class = IP_CLASS_A; ip_class <= IP_CLASS_C; ip_class++) {
+		for (depth = 1; depth <= RTE_FIB_MAX_DEPTH; depth++)
+			generate_random_rule_prefix(ip_class, depth);
+	}
+
+	/* Add following rules to keep same as previous large constant table,
+	 * they are 4 rules with private local IP address and 1 all-zeros prefix
+	 * with depth = 8.
+	 */
+	insert_rule_in_random_pos(RTE_IPV4(0, 0, 0, 0), 8);
+	insert_rule_in_random_pos(RTE_IPV4(10, 2, 23, 147), 32);
+	insert_rule_in_random_pos(RTE_IPV4(192, 168, 100, 10), 24);
+	insert_rule_in_random_pos(RTE_IPV4(192, 168, 25, 100), 24);
+	insert_rule_in_random_pos(RTE_IPV4(192, 168, 129, 124), 32);
+}
+
+#endif /* _TEST_FIB_ROUTES_H_ */
diff --git a/doc/guides/prog_guide/fib_lib.rst b/doc/guides/prog_guide/fib_lib.rst
index c20759faaf..888c1acdfa 100644
--- a/doc/guides/prog_guide/fib_lib.rst
+++ b/doc/guides/prog_guide/fib_lib.rst
@@ -46,6 +46,31 @@ The main methods within the ``rte_fib`` API are:
   for a set of IP addresses, it will return a set of corresponding next hop IDs.
 
 
+Virtual Routing and Forwarding (VRF)
+------------------------------------
+
+A FIB can hold several independent routing tables, one per VRF, selected by
+``max_vrfs`` in the configuration struct (0 or 1 means a single VRF).
+Every VRF has its own default next hop ID (``vrf_default_nh``, or ``default_nh``
+for all of them when it is NULL) and is addressed by a VRF ID from 0 to
+``max_vrfs - 1``.
+
+The VRF aware methods are:
+
+* ``rte_fib_vrf_add()``, ``rte_fib_vrf_delete()``: Same as ``rte_fib_add()``
+  and ``rte_fib_delete()`` for a given VRF.
+
+* ``rte_fib_vrf_lookup_bulk()``: Bulk LPM lookup with a VRF ID per IP address.
+
+* ``rte_fib_vrf_get_rib()``: Get the ``rte_rib`` of a given VRF.
+
+The legacy methods operate on VRF 0.
+Multi-VRF FIBs are supported by the ``RTE_FIB_DIR8_16_8`` algorithm, which keeps
+an independent ``rte_rib`` and an independent root table per VRF, while the lower
+level tables are allocated from pools shared by all the VRFs.
+The VRF ID selects the root table, then the lookup proceeds as for a single VRF.
+
+
 Implementation details
 ----------------------
 
@@ -143,13 +168,13 @@ dataplane algorithm on FIB creation.
 The main FIB configuration struct stores the dataplane parameters inside ``dir8_16_8``
 within the ``rte_fib_conf`` and it consists of:
 
-* ``num_tbl16``: The number of second level groups, at most one per /8 is ever
-  needed.
+* ``num_tbl16``: The number of second level groups, at most one per /8 and VRF is
+  ever needed.
 
 * ``num_tbl8``: The number of third level groups.
 
-Compared to DIR-24-8, the root table is small (2 KB), which makes it suitable
-when many tables must be kept, at the price of an extra memory access for
+Compared to DIR-24-8, the root table is small (2 KB per VRF), which makes it
+suitable for a large number of VRFs, at the price of an extra memory access for
 prefixes longer than 8 bits.
 
 
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 04781a2761..5f77116d8c 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -211,6 +211,13 @@ New Features
   * Added the ``RTE_FIB_DIR8_16_8`` IPv4 algorithm, a three level variant of
     DIR-24-8 with a small root table, with scalar and AVX512 lookup functions.
 
+* **Added VRF support to the FIB library.**
+
+  A FIB can now hold several independent routing tables (VRFs), configured with
+  the ``max_vrfs`` and ``vrf_default_nh`` fields of ``rte_fib_conf`` and
+  accessed with the ``rte_fib_vrf_*`` functions. ``RTE_FIB_DIR8_16_8`` keeps a
+  root table per VRF.
+
 
 Removed Items
 -------------
@@ -466,6 +473,11 @@ API Changes
   * ``rte_tel_data_add_dict_uint_hex``
   * ``rte_telemetry_register_cmd_arg``
 
+* fib: Added a VRF ID argument to the dataplane callbacks.
+
+  The ``rte_fib_modify_fn_t`` and ``rte_fib_lookup_fn_t`` function types gained
+  a VRF argument.
+
 
 ABI Changes
 -----------
@@ -488,6 +500,9 @@ ABI Changes
 * cryptodev: The struct ``rte_crypto_rsa_op_param``
   was updated to include ``pss_salt``.
 
+* fib: ``struct rte_fib_conf`` was extended with the ``max_vrfs`` and
+  ``vrf_default_nh`` fields.
+
 
 Known Issues
 ------------
diff --git a/lib/fib/dir24_8.c b/lib/fib/dir24_8.c
index bb7975eca1..9b14693320 100644
--- a/lib/fib/dir24_8.c
+++ b/lib/fib/dir24_8.c
@@ -465,7 +465,7 @@ modify_fib(struct dir24_8_tbl *dp, struct rte_rib *rib, uint32_t ip,
 }
 
 int
-dir24_8_modify(struct rte_fib *fib, uint32_t ip, uint8_t depth,
+dir24_8_modify(struct rte_fib *fib, uint16_t vrf_id, uint32_t ip, uint8_t depth,
 	uint64_t next_hop, int op)
 {
 	struct dir24_8_tbl *dp;
@@ -476,6 +476,8 @@ dir24_8_modify(struct rte_fib *fib, uint32_t ip, uint8_t depth,
 	int ret = 0;
 	uint64_t par_nh, node_nh;
 
+	RTE_SET_USED(vrf_id);
+
 	if ((fib == NULL) || (depth > RTE_FIB_MAXDEPTH))
 		return -EINVAL;
 
diff --git a/lib/fib/dir24_8.h b/lib/fib/dir24_8.h
index b343b5d686..88c47072d9 100644
--- a/lib/fib/dir24_8.h
+++ b/lib/fib/dir24_8.h
@@ -116,7 +116,8 @@ is_entry_extended(uint64_t ent)
 }
 
 #define LOOKUP_FUNC(suffix, type, bulk_prefetch, nh_sz)			\
-static inline void dir24_8_lookup_bulk_##suffix(void *p, const uint32_t *ips, \
+static inline void dir24_8_lookup_bulk_##suffix(void *p,			\
+	const uint16_t *vrf_ids, const uint32_t *ips,			\
 	uint64_t *next_hops, const unsigned int n)			\
 {									\
 	struct dir24_8_tbl *dp = (struct dir24_8_tbl *)p;		\
@@ -125,6 +126,7 @@ static inline void dir24_8_lookup_bulk_##suffix(void *p, const uint32_t *ips, \
 	uint32_t prefetch_offset =					\
 		RTE_MIN((unsigned int)bulk_prefetch, n);		\
 									\
+	RTE_SET_USED(vrf_ids);						\
 	for (i = 0; i < prefetch_offset; i++)				\
 		rte_prefetch0(get_tbl24_p(dp, ips[i], nh_sz));		\
 	for (i = 0; i < (n - prefetch_offset); i++) {			\
@@ -179,43 +181,47 @@ dir24_8_lookup_bulk(struct dir24_8_tbl *dp, const uint32_t *ips,
 }
 
 static inline void
-dir24_8_lookup_bulk_0(void *p, const uint32_t *ips,
+dir24_8_lookup_bulk_0(void *p, const uint16_t *vrf_ids, const uint32_t *ips,
 	uint64_t *next_hops, const unsigned int n)
 {
 	struct dir24_8_tbl *dp = (struct dir24_8_tbl *)p;
 
+	RTE_SET_USED(vrf_ids);
 	dir24_8_lookup_bulk(dp, ips, next_hops, n, 0);
 }
 
 static inline void
-dir24_8_lookup_bulk_1(void *p, const uint32_t *ips,
+dir24_8_lookup_bulk_1(void *p, const uint16_t *vrf_ids, const uint32_t *ips,
 	uint64_t *next_hops, const unsigned int n)
 {
 	struct dir24_8_tbl *dp = (struct dir24_8_tbl *)p;
 
+	RTE_SET_USED(vrf_ids);
 	dir24_8_lookup_bulk(dp, ips, next_hops, n, 1);
 }
 
 static inline void
-dir24_8_lookup_bulk_2(void *p, const uint32_t *ips,
+dir24_8_lookup_bulk_2(void *p, const uint16_t *vrf_ids, const uint32_t *ips,
 	uint64_t *next_hops, const unsigned int n)
 {
 	struct dir24_8_tbl *dp = (struct dir24_8_tbl *)p;
 
+	RTE_SET_USED(vrf_ids);
 	dir24_8_lookup_bulk(dp, ips, next_hops, n, 2);
 }
 
 static inline void
-dir24_8_lookup_bulk_3(void *p, const uint32_t *ips,
+dir24_8_lookup_bulk_3(void *p, const uint16_t *vrf_ids, const uint32_t *ips,
 	uint64_t *next_hops, const unsigned int n)
 {
 	struct dir24_8_tbl *dp = (struct dir24_8_tbl *)p;
 
+	RTE_SET_USED(vrf_ids);
 	dir24_8_lookup_bulk(dp, ips, next_hops, n, 3);
 }
 
 static inline void
-dir24_8_lookup_bulk_uni(void *p, const uint32_t *ips,
+dir24_8_lookup_bulk_uni(void *p, const uint16_t *vrf_ids, const uint32_t *ips,
 	uint64_t *next_hops, const unsigned int n)
 {
 	struct dir24_8_tbl *dp = (struct dir24_8_tbl *)p;
@@ -224,6 +230,8 @@ dir24_8_lookup_bulk_uni(void *p, const uint32_t *ips,
 	uint32_t prefetch_offset = RTE_MIN(15U, n);
 	uint8_t nh_sz = dp->nh_sz;
 
+	RTE_SET_USED(vrf_ids);
+
 	for (i = 0; i < prefetch_offset; i++)
 		rte_prefetch0(get_tbl24_p(dp, ips[i], nh_sz));
 	for (i = 0; i < (n - prefetch_offset); i++) {
@@ -246,34 +254,35 @@ dir24_8_lookup_bulk_uni(void *p, const uint32_t *ips,
 
 #define BSWAP_MAX_LENGTH	64
 
-typedef void (*dir24_8_lookup_bulk_be_cb)(void *p, const uint32_t *ips, uint64_t *next_hops,
-	const unsigned int n);
+typedef void (*dir24_8_lookup_bulk_be_cb)(void *p, const uint16_t *vrf_ids,
+	const uint32_t *ips, uint64_t *next_hops, const unsigned int n);
 
 static inline void
-dir24_8_lookup_bulk_be(void *p, const uint32_t *ips, uint64_t *next_hops, const unsigned int n,
-	dir24_8_lookup_bulk_be_cb cb)
+dir24_8_lookup_bulk_be(void *p, const uint16_t *vrf_ids, const uint32_t *ips,
+	uint64_t *next_hops, const unsigned int n, dir24_8_lookup_bulk_be_cb cb)
 {
 	uint32_t le_ips[BSWAP_MAX_LENGTH];
 	unsigned int i;
 
 #if RTE_BYTE_ORDER == RTE_BIG_ENDIAN
-	cb(p, ips, next_hops, n);
+	cb(p, vrf_ids, ips, next_hops, n);
 #else
 	for (i = 0; i < n; i += BSWAP_MAX_LENGTH) {
 		int j;
 		for (j = 0; j < BSWAP_MAX_LENGTH && i + j < n; j++)
 			le_ips[j] = rte_be_to_cpu_32(ips[i + j]);
 
-		cb(p, le_ips, next_hops + i, j);
+		cb(p, vrf_ids, le_ips, next_hops + i, j);
 	}
 #endif
 }
 
 #define DECLARE_BE_LOOKUP_FN(name) \
 static inline void \
-name##_be(void *p, const uint32_t *ips, uint64_t *next_hops, const unsigned int n) \
+name##_be(void *p, const uint16_t *vrf_ids, const uint32_t *ips, \
+	uint64_t *next_hops, const unsigned int n) \
 { \
-	dir24_8_lookup_bulk_be(p, ips, next_hops, n, name); \
+	dir24_8_lookup_bulk_be(p, vrf_ids, ips, next_hops, n, name); \
 }
 
 DECLARE_BE_LOOKUP_FN(dir24_8_lookup_bulk_1b)
@@ -296,7 +305,7 @@ rte_fib_lookup_fn_t
 dir24_8_get_lookup_fn(void *p, enum rte_fib_lookup_type type, bool be_addr);
 
 int
-dir24_8_modify(struct rte_fib *fib, uint32_t ip, uint8_t depth,
+dir24_8_modify(struct rte_fib *fib, uint16_t vrf_id, uint32_t ip, uint8_t depth,
 	uint64_t next_hop, int op);
 
 int
diff --git a/lib/fib/dir24_8_avx512.c b/lib/fib/dir24_8_avx512.c
index 89b43583c7..77b7a8b3de 100644
--- a/lib/fib/dir24_8_avx512.c
+++ b/lib/fib/dir24_8_avx512.c
@@ -133,14 +133,14 @@ dir24_8_vec_lookup_x8_8b(void *p, const uint32_t *ips,
 
 #define DECLARE_VECTOR_FN(suffix, nh_type, be_addr) \
 void \
-rte_dir24_8_vec_lookup_bulk_##suffix(void *p, const uint32_t *ips, uint64_t *next_hops, \
-	const unsigned int n) \
+rte_dir24_8_vec_lookup_bulk_##suffix(void *p, const uint16_t *vrf_ids, \
+	const uint32_t *ips, uint64_t *next_hops, const unsigned int n) \
 { \
 	uint32_t i; \
 	for (i = 0; i < (n / 16); i++) \
 		dir24_8_vec_lookup_x16(p, ips + i * 16, next_hops + i * 16, sizeof(nh_type), \
 			be_addr); \
-	dir24_8_lookup_bulk_##suffix(p, ips + i * 16, next_hops + i * 16, n - i * 16); \
+	dir24_8_lookup_bulk_##suffix(p, vrf_ids, ips + i * 16, next_hops + i * 16, n - i * 16); \
 }
 
 DECLARE_VECTOR_FN(1b, uint8_t, false)
@@ -151,21 +151,21 @@ DECLARE_VECTOR_FN(4b, uint32_t, false)
 DECLARE_VECTOR_FN(4b_be, uint32_t, true)
 
 void
-rte_dir24_8_vec_lookup_bulk_8b(void *p, const uint32_t *ips,
-	uint64_t *next_hops, const unsigned int n)
+rte_dir24_8_vec_lookup_bulk_8b(void *p, const uint16_t *vrf_ids,
+	const uint32_t *ips, uint64_t *next_hops, const unsigned int n)
 {
 	uint32_t i;
 	for (i = 0; i < (n / 8); i++)
 		dir24_8_vec_lookup_x8_8b(p, ips + i * 8, next_hops + i * 8, false);
-	dir24_8_lookup_bulk_8b(p, ips + i * 8, next_hops + i * 8, n - i * 8);
+	dir24_8_lookup_bulk_8b(p, vrf_ids, ips + i * 8, next_hops + i * 8, n - i * 8);
 }
 
 void
-rte_dir24_8_vec_lookup_bulk_8b_be(void *p, const uint32_t *ips,
-	uint64_t *next_hops, const unsigned int n)
+rte_dir24_8_vec_lookup_bulk_8b_be(void *p, const uint16_t *vrf_ids,
+	const uint32_t *ips, uint64_t *next_hops, const unsigned int n)
 {
 	uint32_t i;
 	for (i = 0; i < (n / 8); i++)
 		dir24_8_vec_lookup_x8_8b(p, ips + i * 8, next_hops + i * 8, true);
-	dir24_8_lookup_bulk_8b_be(p, ips + i * 8, next_hops + i * 8, n - i * 8);
+	dir24_8_lookup_bulk_8b_be(p, vrf_ids, ips + i * 8, next_hops + i * 8, n - i * 8);
 }
diff --git a/lib/fib/dir24_8_avx512.h b/lib/fib/dir24_8_avx512.h
index 3e2bbc2490..7681cac436 100644
--- a/lib/fib/dir24_8_avx512.h
+++ b/lib/fib/dir24_8_avx512.h
@@ -6,35 +6,35 @@
 #define _DIR248_AVX512_H_
 
 void
-rte_dir24_8_vec_lookup_bulk_1b(void *p, const uint32_t *ips,
-	uint64_t *next_hops, const unsigned int n);
+rte_dir24_8_vec_lookup_bulk_1b(void *p, const uint16_t *vrf_ids,
+	const uint32_t *ips, uint64_t *next_hops, const unsigned int n);
 
 void
-rte_dir24_8_vec_lookup_bulk_2b(void *p, const uint32_t *ips,
-	uint64_t *next_hops, const unsigned int n);
+rte_dir24_8_vec_lookup_bulk_2b(void *p, const uint16_t *vrf_ids,
+	const uint32_t *ips, uint64_t *next_hops, const unsigned int n);
 
 void
-rte_dir24_8_vec_lookup_bulk_4b(void *p, const uint32_t *ips,
-	uint64_t *next_hops, const unsigned int n);
+rte_dir24_8_vec_lookup_bulk_4b(void *p, const uint16_t *vrf_ids,
+	const uint32_t *ips, uint64_t *next_hops, const unsigned int n);
 
 void
-rte_dir24_8_vec_lookup_bulk_8b(void *p, const uint32_t *ips,
-	uint64_t *next_hops, const unsigned int n);
+rte_dir24_8_vec_lookup_bulk_8b(void *p, const uint16_t *vrf_ids,
+	const uint32_t *ips, uint64_t *next_hops, const unsigned int n);
 
 void
-rte_dir24_8_vec_lookup_bulk_1b_be(void *p, const uint32_t *ips,
-	uint64_t *next_hops, const unsigned int n);
+rte_dir24_8_vec_lookup_bulk_1b_be(void *p, const uint16_t *vrf_ids,
+	const uint32_t *ips, uint64_t *next_hops, const unsigned int n);
 
 void
-rte_dir24_8_vec_lookup_bulk_2b_be(void *p, const uint32_t *ips,
-	uint64_t *next_hops, const unsigned int n);
+rte_dir24_8_vec_lookup_bulk_2b_be(void *p, const uint16_t *vrf_ids,
+	const uint32_t *ips, uint64_t *next_hops, const unsigned int n);
 
 void
-rte_dir24_8_vec_lookup_bulk_4b_be(void *p, const uint32_t *ips,
-	uint64_t *next_hops, const unsigned int n);
+rte_dir24_8_vec_lookup_bulk_4b_be(void *p, const uint16_t *vrf_ids,
+	const uint32_t *ips, uint64_t *next_hops, const unsigned int n);
 
 void
-rte_dir24_8_vec_lookup_bulk_8b_be(void *p, const uint32_t *ips,
-	uint64_t *next_hops, const unsigned int n);
+rte_dir24_8_vec_lookup_bulk_8b_be(void *p, const uint16_t *vrf_ids,
+	const uint32_t *ips, uint64_t *next_hops, const unsigned int n);
 
 #endif /* _DIR248_AVX512_H_ */
diff --git a/lib/fib/dir24_8_rvv.c b/lib/fib/dir24_8_rvv.c
index 9c14ca0481..53158e42e8 100644
--- a/lib/fib/dir24_8_rvv.c
+++ b/lib/fib/dir24_8_rvv.c
@@ -13,7 +13,7 @@
 #define DECLARE_VECTOR_FN(SFX, NH_SZ) \
 void \
 rte_dir24_8_vec_lookup_bulk_##SFX(void *p, \
-		const uint32_t *ips, uint64_t *next_hops, unsigned int n) \
+		const uint16_t *vrf_ids, const uint32_t *ips, uint64_t *next_hops, unsigned int n) \
 { \
 	const uint8_t  idx_bits = 3 - NH_SZ; \
 	const uint32_t idx_mask = (1u << (3 - NH_SZ)) - 1u; \
@@ -21,6 +21,7 @@ rte_dir24_8_vec_lookup_bulk_##SFX(void *p, \
 	struct dir24_8_tbl *tbl = (struct dir24_8_tbl *)p; \
 	const uint64_t *tbl24   = tbl->tbl24; \
 	size_t vl; \
+	RTE_SET_USED(vrf_ids); \
 	for (unsigned int i = 0; i < n; i += vl) { \
 		vl = __riscv_vsetvl_e32m4(n - i); \
 		vuint32m4_t v_ips = __riscv_vle32_v_u32m4(&ips[i], vl); \
diff --git a/lib/fib/dir24_8_rvv.h b/lib/fib/dir24_8_rvv.h
index 7be99f7882..7064665d60 100644
--- a/lib/fib/dir24_8_rvv.h
+++ b/lib/fib/dir24_8_rvv.h
@@ -6,19 +6,19 @@
 #define _DIR248_RVV_H_
 
 void
-rte_dir24_8_vec_lookup_bulk_1b(void *p, const uint32_t *ips,
-	uint64_t *next_hops, const unsigned int n);
+rte_dir24_8_vec_lookup_bulk_1b(void *p, const uint16_t *vrf_ids,
+	const uint32_t *ips, uint64_t *next_hops, const unsigned int n);
 
 void
-rte_dir24_8_vec_lookup_bulk_2b(void *p, const uint32_t *ips,
-	uint64_t *next_hops, const unsigned int n);
+rte_dir24_8_vec_lookup_bulk_2b(void *p, const uint16_t *vrf_ids,
+	const uint32_t *ips, uint64_t *next_hops, const unsigned int n);
 
 void
-rte_dir24_8_vec_lookup_bulk_4b(void *p, const uint32_t *ips,
-	uint64_t *next_hops, const unsigned int n);
+rte_dir24_8_vec_lookup_bulk_4b(void *p, const uint16_t *vrf_ids,
+	const uint32_t *ips, uint64_t *next_hops, const unsigned int n);
 
 void
-rte_dir24_8_vec_lookup_bulk_8b(void *p, const uint32_t *ips,
-	uint64_t *next_hops, const unsigned int n);
+rte_dir24_8_vec_lookup_bulk_8b(void *p, const uint16_t *vrf_ids,
+	const uint32_t *ips, uint64_t *next_hops, const unsigned int n);
 
 #endif /* _DIR248_RVV_H_ */
diff --git a/lib/fib/dir8_16_8.c b/lib/fib/dir8_16_8.c
index 7207cd4748..533aaf6cce 100644
--- a/lib/fib/dir8_16_8.c
+++ b/lib/fib/dir8_16_8.c
@@ -57,13 +57,16 @@ struct dir8_16_8_rcu_dq_entry {
 };
 
 static rte_fib_lookup_fn_t
-get_scalar_fn(bool be_addr)
+get_scalar_fn(const struct dir8_16_8_tbl *dp, bool be_addr)
 {
+	if (dp->num_vrfs > 1)
+		return be_addr ? dir8_16_8_vrf_lookup_bulk_be :
+			dir8_16_8_vrf_lookup_bulk;
 	return be_addr ? dir8_16_8_lookup_bulk_be : dir8_16_8_lookup_bulk;
 }
 
 static rte_fib_lookup_fn_t
-get_vector_fn(bool be_addr)
+get_vector_fn(const struct dir8_16_8_tbl *dp, bool be_addr)
 {
 #ifdef CC_AVX512_SUPPORT
 	if (rte_cpu_get_flag_enabled(RTE_CPUFLAG_AVX512F) <= 0 ||
@@ -74,9 +77,13 @@ get_vector_fn(bool be_addr)
 	if (be_addr && rte_cpu_get_flag_enabled(RTE_CPUFLAG_AVX512BW) <= 0)
 		return NULL;
 
+	if (dp->num_vrfs > 1)
+		return be_addr ? rte_dir8_16_8_vrf_vec_lookup_bulk_be :
+			rte_dir8_16_8_vrf_vec_lookup_bulk;
 	return be_addr ? rte_dir8_16_8_vec_lookup_bulk_be :
 		rte_dir8_16_8_vec_lookup_bulk;
 #else
+	RTE_SET_USED(dp);
 	RTE_SET_USED(be_addr);
 	return NULL;
 #endif
@@ -93,12 +100,12 @@ dir8_16_8_get_lookup_fn(void *p, enum rte_fib_lookup_type type, bool be_addr)
 
 	switch (type) {
 	case RTE_FIB_LOOKUP_DIR8_16_8_SCALAR:
-		return get_scalar_fn(be_addr);
+		return get_scalar_fn(dp, be_addr);
 	case RTE_FIB_LOOKUP_DIR8_16_8_VECTOR_AVX512:
-		return get_vector_fn(be_addr);
+		return get_vector_fn(dp, be_addr);
 	case RTE_FIB_LOOKUP_DEFAULT:
-		fn = get_vector_fn(be_addr);
-		return (fn != NULL) ? fn : get_scalar_fn(be_addr);
+		fn = get_vector_fn(dp, be_addr);
+		return (fn != NULL) ? fn : get_scalar_fn(dp, be_addr);
 	default:
 		return NULL;
 	}
@@ -336,8 +343,8 @@ install_to_fib(struct dir8_16_8_tbl *dp, int level, uint64_t base,
 }
 
 static int
-modify_fib(struct dir8_16_8_tbl *dp, struct rte_rib *rib, uint32_t ip,
-	uint8_t depth, uint64_t next_hop)
+modify_fib(struct dir8_16_8_tbl *dp, struct rte_rib *rib, uint32_t tbl0_base,
+	uint32_t ip, uint8_t depth, uint64_t next_hop)
 {
 	struct rte_rib_node *tmp = NULL;
 	uint64_t ledge, redge;
@@ -360,8 +367,7 @@ modify_fib(struct dir8_16_8_tbl *dp, struct rte_rib *rib, uint32_t ip,
 				ledge = redge + (1ULL << (32 - tmp_depth));
 				continue;
 			}
-
-			ret = install_to_fib(dp, 0, 0, ledge, redge, next_hop);
+			ret = install_to_fib(dp, 0, tbl0_base, ledge, redge, next_hop);
 			if (ret != 0)
 				return ret;
 
@@ -376,8 +382,7 @@ modify_fib(struct dir8_16_8_tbl *dp, struct rte_rib *rib, uint32_t ip,
 			redge = (uint64_t)ip + (1ULL << (32 - depth));
 			if (ledge == redge && ledge != 0)
 				break;
-
-			ret = install_to_fib(dp, 0, 0, ledge, redge, next_hop);
+			ret = install_to_fib(dp, 0, tbl0_base, ledge, redge, next_hop);
 			if (ret != 0)
 				return ret;
 		}
@@ -386,24 +391,16 @@ modify_fib(struct dir8_16_8_tbl *dp, struct rte_rib *rib, uint32_t ip,
 	return 0;
 }
 
-int
-dir8_16_8_modify(struct rte_fib *fib, uint32_t ip, uint8_t depth,
+static int
+dir8_16_8_modify_core(struct dir8_16_8_tbl *dp, struct rte_rib *rib,
+	uint32_t tbl0_base, uint64_t def_nh, uint32_t ip, uint8_t depth,
 	uint64_t next_hop, int op)
 {
-	struct dir8_16_8_tbl *dp;
-	struct rte_rib *rib;
 	struct rte_rib_node *node;
 	struct rte_rib_node *parent;
 	int ret = 0;
 	uint64_t par_nh, node_nh;
 
-	if ((fib == NULL) || (depth > RTE_FIB_MAXDEPTH))
-		return -EINVAL;
-
-	dp = rte_fib_get_dp(fib);
-	rib = rte_fib_get_rib(fib);
-	RTE_ASSERT((dp != NULL) && (rib != NULL));
-
 	if (next_hop > dir8_16_8_get_max_nh())
 		return -EINVAL;
 
@@ -416,8 +413,7 @@ dir8_16_8_modify(struct rte_fib *fib, uint32_t ip, uint8_t depth,
 			rte_rib_get_nh(node, &node_nh);
 			if (node_nh == next_hop)
 				return 0;
-
-			ret = modify_fib(dp, rib, ip, depth, next_hop);
+			ret = modify_fib(dp, rib, tbl0_base, ip, depth, next_hop);
 			if (ret == 0)
 				rte_rib_set_nh(node, next_hop);
 
@@ -434,7 +430,7 @@ dir8_16_8_modify(struct rte_fib *fib, uint32_t ip, uint8_t depth,
 			if (par_nh == next_hop)
 				return 0;
 		}
-		ret = modify_fib(dp, rib, ip, depth, next_hop);
+		ret = modify_fib(dp, rib, tbl0_base, ip, depth, next_hop);
 		if (ret != 0) {
 			rte_rib_remove(rib, ip, depth);
 			return ret;
@@ -450,9 +446,10 @@ dir8_16_8_modify(struct rte_fib *fib, uint32_t ip, uint8_t depth,
 			rte_rib_get_nh(parent, &par_nh);
 			rte_rib_get_nh(node, &node_nh);
 			if (par_nh != node_nh)
-				ret = modify_fib(dp, rib, ip, depth, par_nh);
+				ret = modify_fib(dp, rib, tbl0_base, ip, depth,
+					par_nh);
 		} else
-			ret = modify_fib(dp, rib, ip, depth, dp->def_nh);
+			ret = modify_fib(dp, rib, tbl0_base, ip, depth, def_nh);
 		if (ret == 0)
 			rte_rib_remove(rib, ip, depth);
 		return ret;
@@ -463,15 +460,38 @@ dir8_16_8_modify(struct rte_fib *fib, uint32_t ip, uint8_t depth,
 	return -EINVAL;
 }
 
+int
+dir8_16_8_modify(struct rte_fib *fib, uint16_t vrf_id, uint32_t ip, uint8_t depth,
+	uint64_t next_hop, int op)
+{
+	struct dir8_16_8_tbl *dp;
+	struct rte_rib *rib;
+
+	if ((fib == NULL) || (depth > RTE_FIB_MAXDEPTH))
+		return -EINVAL;
+
+	dp = rte_fib_get_dp(fib);
+	RTE_ASSERT(dp != NULL);
+
+	if (vrf_id >= dp->num_vrfs)
+		return -EINVAL;
+
+	rib = rte_fib_vrf_get_rib(fib, vrf_id);
+	RTE_ASSERT(rib != NULL);
+
+	return dir8_16_8_modify_core(dp, rib,
+		(uint32_t)vrf_id * DIR8_16_8_TBL0_NUM_ENT,
+		dp->def_nh[vrf_id], ip, depth, next_hop, op);
+}
+
 void *
 dir8_16_8_create(const char *name, int socket_id, struct rte_fib_conf *fib_conf)
 {
 	char mem_name[DIR8_16_8_NAMESIZE];
 	struct dir8_16_8_tbl *dp;
-	uint64_t def_nh;
-	uint32_t num_tbl16, num_tbl8;
-	uint32_t i;
-	uint64_t tbl16_sz, tbl8_sz;
+	uint64_t def_nh, tbl16_sz, tbl8_sz;
+	uint32_t num_tbl16, num_tbl8, i;
+	uint16_t num_vrfs, v;
 
 	if ((name == NULL) || (fib_conf == NULL) || (fib_conf->dir8_16_8.num_tbl16 == 0) ||
 			(fib_conf->dir8_16_8.num_tbl8 == 0) ||
@@ -480,27 +500,56 @@ dir8_16_8_create(const char *name, int socket_id, struct rte_fib_conf *fib_conf)
 		return NULL;
 	}
 
+	num_vrfs = RTE_MAX(fib_conf->max_vrfs, 1);
 	def_nh = fib_conf->default_nh;
 	num_tbl16 = fib_conf->dir8_16_8.num_tbl16;
 	num_tbl8 = fib_conf->dir8_16_8.num_tbl8;
 
+	/* Validate the per-VRF default nexthops, if provided. */
+	if (fib_conf->vrf_default_nh != NULL) {
+		for (v = 0; v < num_vrfs; v++) {
+			if (fib_conf->vrf_default_nh[v] > dir8_16_8_get_max_nh()) {
+				rte_errno = EINVAL;
+				return NULL;
+			}
+		}
+	}
+
 	dp = rte_zmalloc_socket(name, sizeof(struct dir8_16_8_tbl) +
-		DIR8_16_8_TBL0_NUM_ENT * sizeof(uint64_t), RTE_CACHE_LINE_SIZE, socket_id);
+		(size_t)num_vrfs * DIR8_16_8_TBL0_NUM_ENT * sizeof(uint64_t),
+		RTE_CACHE_LINE_SIZE, socket_id);
 	if (dp == NULL) {
 		rte_errno = ENOMEM;
 		return NULL;
 	}
+	dp->num_vrfs = num_vrfs;
 
-	/* Init first level table with the default nexthop. */
-	for (i = 0; i < DIR8_16_8_TBL0_NUM_ENT; i++)
-		dp->tbl0[i] = def_nh << 1;
+	/* Per-VRF default nexthop array. */
+	snprintf(mem_name, sizeof(mem_name), "DEFNH_%p", dp);
+	dp->def_nh = rte_zmalloc_socket(mem_name,
+		(size_t)num_vrfs * sizeof(uint64_t),
+		RTE_CACHE_LINE_SIZE, socket_id);
+	if (dp->def_nh == NULL) {
+		rte_errno = ENOMEM;
+		goto free_dp;
+	}
+	for (v = 0; v < num_vrfs; v++)
+		dp->def_nh[v] = (fib_conf->vrf_default_nh != NULL) ?
+			fib_conf->vrf_default_nh[v] : def_nh;
+
+	/* Init each VRF's tbl0 block with that VRF's default nexthop. */
+	for (v = 0; v < num_vrfs; v++) {
+		uint32_t base = (uint32_t)v * DIR8_16_8_TBL0_NUM_ENT;
+		for (i = 0; i < DIR8_16_8_TBL0_NUM_ENT; i++)
+			dp->tbl0[base + i] = dp->def_nh[v] << 1;
+	}
 
 	snprintf(mem_name, sizeof(mem_name), "TBL16_%p", dp);
 	tbl16_sz = (uint64_t)DIR8_16_8_TBL16_GRP_NUM_ENT * sizeof(uint64_t) * num_tbl16;
 	dp->tbl16 = rte_zmalloc_socket(mem_name, tbl16_sz, RTE_CACHE_LINE_SIZE, socket_id);
 	if (dp->tbl16 == NULL) {
 		rte_errno = ENOMEM;
-		goto free_dp;
+		goto free_defnh;
 	}
 
 	snprintf(mem_name, sizeof(mem_name), "TBL8_%p", dp);
@@ -532,7 +581,6 @@ dir8_16_8_create(const char *name, int socket_id, struct rte_fib_conf *fib_conf)
 	for (i = 0; i < num_tbl8; i++)
 		dp->tbl8_pool[i] = i;
 
-	dp->def_nh = def_nh;
 	dp->number_tbl16s = num_tbl16;
 	dp->number_tbl8s = num_tbl8;
 
@@ -544,6 +592,8 @@ dir8_16_8_create(const char *name, int socket_id, struct rte_fib_conf *fib_conf)
 	rte_free(dp->tbl8);
 free_tbl16:
 	rte_free(dp->tbl16);
+free_defnh:
+	rte_free(dp->def_nh);
 free_dp:
 	rte_free(dp);
 	return NULL;
@@ -558,6 +608,7 @@ dir8_16_8_free(void *p)
 		return;
 
 	rte_rcu_qsbr_dq_delete(dp->dq);
+	rte_free(dp->def_nh);
 	rte_free(dp->tbl8_pool);
 	rte_free(dp->tbl16_pool);
 	rte_free(dp->tbl8);
diff --git a/lib/fib/dir8_16_8.h b/lib/fib/dir8_16_8.h
index 31ca5162de..1ea867d4ba 100644
--- a/lib/fib/dir8_16_8.h
+++ b/lib/fib/dir8_16_8.h
@@ -36,7 +36,8 @@ struct dir8_16_8_tbl {
 	uint32_t	cur_tbl16s;	/**< Current number of tbl16 groups. */
 	uint32_t	number_tbl8s;	/**< Total number of tbl8 groups. */
 	uint32_t	cur_tbl8s;	/**< Current number of tbl8 groups. */
-	uint64_t	def_nh;		/**< Default next hop. */
+	uint16_t	num_vrfs;	/**< Number of VRFs (1 = single VRF). */
+	uint64_t	*def_nh;	/**< Per-VRF default nexthops (num_vrfs). */
 	uint64_t	*tbl16;		/**< Second level table. */
 	uint64_t	*tbl8;		/**< Third level table. */
 	uint32_t	*tbl16_pool;	/**< Stack of free tbl16 group idxes. */
@@ -47,7 +48,7 @@ struct dir8_16_8_tbl {
 	enum rte_fib_qsbr_mode rcu_mode;/* Blocking, defer queue. */
 	struct rte_rcu_qsbr *v;		/* RCU QSBR variable. */
 	struct rte_rcu_qsbr_dq *dq;	/* RCU QSBR defer queue. */
-	/* First level table (top 8 bits). */
+	/* First level table (top 8 bits), sized num_vrfs * 256. */
 	alignas(RTE_CACHE_LINE_SIZE) uint64_t	tbl0[];
 };
 
@@ -83,13 +84,14 @@ dir8_16_8_is_entry_extended(uint64_t ent)
 }
 
 static inline void
-dir8_16_8_lookup_bulk(void *p, const uint32_t *ips,
+dir8_16_8_lookup_bulk(void *p, const uint16_t *vrf_ids, const uint32_t *ips,
 	uint64_t *next_hops, const unsigned int n)
 {
 	struct dir8_16_8_tbl *dp = (struct dir8_16_8_tbl *)p;
 	uint64_t tmp;
 	uint32_t i;
 
+	RTE_SET_USED(vrf_ids);
 	for (i = 0; i < n; i++) {
 		tmp = dp->tbl0[dir8_16_8_get_tbl0_idx(ips[i])];
 		/* Prefixes are usually longer than /8. */
@@ -104,11 +106,11 @@ dir8_16_8_lookup_bulk(void *p, const uint32_t *ips,
 #define DIR8_16_8_BSWAP_MAX_LENGTH	64
 
 static inline void
-dir8_16_8_lookup_bulk_be(void *p, const uint32_t *ips,
+dir8_16_8_lookup_bulk_be(void *p, const uint16_t *vrf_ids, const uint32_t *ips,
 	uint64_t *next_hops, const unsigned int n)
 {
 #if RTE_BYTE_ORDER == RTE_BIG_ENDIAN
-	dir8_16_8_lookup_bulk(p, ips, next_hops, n);
+	dir8_16_8_lookup_bulk(p, vrf_ids, ips, next_hops, n);
 #else
 	uint32_t le_ips[DIR8_16_8_BSWAP_MAX_LENGTH];
 	unsigned int i;
@@ -118,7 +120,54 @@ dir8_16_8_lookup_bulk_be(void *p, const uint32_t *ips,
 		for (j = 0; j < DIR8_16_8_BSWAP_MAX_LENGTH && i + j < n; j++)
 			le_ips[j] = rte_be_to_cpu_32(ips[i + j]);
 
-		dir8_16_8_lookup_bulk(p, le_ips, next_hops + i, j);
+		dir8_16_8_lookup_bulk(p, vrf_ids, le_ips, next_hops + i, j);
+	}
+#endif
+}
+
+static inline void
+dir8_16_8_vrf_lookup_bulk(void *p, const uint16_t *vrf_ids, const uint32_t *ips,
+	uint64_t *next_hops, const unsigned int n)
+{
+	struct dir8_16_8_tbl *dp = (struct dir8_16_8_tbl *)p;
+	uint64_t tmp;
+	uint32_t i;
+
+	/* A NULL vrf_ids array selects VRF 0 for every IP. */
+	if (unlikely(vrf_ids == NULL)) {
+		dir8_16_8_lookup_bulk(p, NULL, ips, next_hops, n);
+		return;
+	}
+
+	for (i = 0; i < n; i++) {
+		tmp = dp->tbl0[vrf_ids[i] * DIR8_16_8_TBL0_NUM_ENT +
+			dir8_16_8_get_tbl0_idx(ips[i])];
+		if (dir8_16_8_is_entry_extended(tmp))
+			tmp = dp->tbl16[dir8_16_8_get_tbl16_idx(tmp, ips[i])];
+		if (unlikely(dir8_16_8_is_entry_extended(tmp)))
+			tmp = dp->tbl8[dir8_16_8_get_tbl8_idx(tmp, ips[i])];
+		next_hops[i] = tmp >> 1;
+	}
+}
+
+static inline void
+dir8_16_8_vrf_lookup_bulk_be(void *p, const uint16_t *vrf_ids,
+	const uint32_t *ips, uint64_t *next_hops, const unsigned int n)
+{
+#if RTE_BYTE_ORDER == RTE_BIG_ENDIAN
+	dir8_16_8_vrf_lookup_bulk(p, vrf_ids, ips, next_hops, n);
+#else
+	uint32_t le_ips[DIR8_16_8_BSWAP_MAX_LENGTH];
+	unsigned int i;
+
+	for (i = 0; i < n; i += DIR8_16_8_BSWAP_MAX_LENGTH) {
+		unsigned int j;
+		for (j = 0; j < DIR8_16_8_BSWAP_MAX_LENGTH && i + j < n; j++)
+			le_ips[j] = rte_be_to_cpu_32(ips[i + j]);
+
+		dir8_16_8_vrf_lookup_bulk(p,
+			(vrf_ids != NULL) ? vrf_ids + i : NULL,
+			le_ips, next_hops + i, j);
 	}
 #endif
 }
@@ -133,7 +182,7 @@ rte_fib_lookup_fn_t
 dir8_16_8_get_lookup_fn(void *p, enum rte_fib_lookup_type type, bool be_addr);
 
 int
-dir8_16_8_modify(struct rte_fib *fib, uint32_t ip, uint8_t depth,
+dir8_16_8_modify(struct rte_fib *fib, uint16_t vrf_id, uint32_t ip, uint8_t depth,
 	uint64_t next_hop, int op);
 
 int
diff --git a/lib/fib/dir8_16_8_avx512.c b/lib/fib/dir8_16_8_avx512.c
index c147451252..2a9c6b6a15 100644
--- a/lib/fib/dir8_16_8_avx512.c
+++ b/lib/fib/dir8_16_8_avx512.c
@@ -8,6 +8,9 @@
 #include "dir8_16_8.h"
 #include "dir8_16_8_avx512.h"
 
+/* VRF IDs used when the caller passes no vrf_ids array: VRF 0 for every IP. */
+static const rte_xmm_t dir8_16_8_def_vrf_ids;
+
 static inline __m256i
 dir8_16_8_vec_load_ips(const uint32_t *ips, bool be_addr)
 {
@@ -21,9 +24,14 @@ dir8_16_8_vec_load_ips(const uint32_t *ips, bool be_addr)
 }
 
 static inline __m256i
-dir8_16_8_vec_get_tbl0_idx(__m256i ip_vec)
+dir8_16_8_vec_get_tbl0_idx(const uint16_t *vrf_ids, __m256i ip_vec)
 {
-	return _mm256_srli_epi32(ip_vec, 24);
+	__m256i vrf_vec = _mm256_cvtepu16_epi32(
+		_mm_loadu_si128((const void *)vrf_ids));
+
+	/* vrf_id * DIR8_16_8_TBL0_NUM_ENT + (ip >> 24) */
+	return _mm256_add_epi32(_mm256_slli_epi32(vrf_vec, 8),
+		_mm256_srli_epi32(ip_vec, 24));
 }
 
 /* Second lookup stage input for 8 IPs, filled by the first stage. */
@@ -43,11 +51,11 @@ struct dir8_16_8_vec_stage {
  * some CPUs a gather costs much more than the 8 loads it replaces.
  */
 static inline void
-dir8_16_8_vec_prefetch_x8(const struct dir8_16_8_tbl *dp, const uint32_t *ips, bool be_addr,
-	struct dir8_16_8_vec_stage *st)
+dir8_16_8_vec_prefetch_x8(const struct dir8_16_8_tbl *dp, const uint16_t *vrf_ids,
+	const uint32_t *ips, bool be_addr, struct dir8_16_8_vec_stage *st)
 {
 	const __m256i ip_vec = dir8_16_8_vec_load_ips(ips, be_addr);
-	const rte_ymm_t idx0 = { .y = dir8_16_8_vec_get_tbl0_idx(ip_vec) };
+	const rte_ymm_t idx0 = { .y = dir8_16_8_vec_get_tbl0_idx(vrf_ids, ip_vec) };
 	const rte_ymm_t ip = { .y = ip_vec };
 	const uint64_t *tbl0 = dp->tbl0;
 	const uint64_t *tbl16 = dp->tbl16;
@@ -90,7 +98,8 @@ dir8_16_8_vec_lookup_x8(const struct dir8_16_8_tbl *dp, const struct dir8_16_8_v
 }
 
 static inline void
-vec_lookup_bulk(void *p, const uint32_t *ips, uint64_t *next_hops, unsigned int n, bool be_addr)
+vec_lookup_bulk(void *p, const uint16_t *vrf_ids, const uint32_t *ips,
+	uint64_t *next_hops, unsigned int n, bool be_addr)
 {
 	const struct dir8_16_8_tbl *dp = p;
 	struct dir8_16_8_vec_stage stage[3];
@@ -98,13 +107,26 @@ vec_lookup_bulk(void *p, const uint32_t *ips, uint64_t *next_hops, unsigned int
 	struct dir8_16_8_vec_stage *st1 = &stage[1];
 	struct dir8_16_8_vec_stage *st2 = &stage[2];
 	struct dir8_16_8_vec_stage *tmp;
+	const uint16_t *vrfs = vrf_ids;
+	unsigned int vrf_inc = 1;
 	unsigned int i = 0;
 
+	/*
+	 * A NULL vrf_ids array selects VRF 0 for every IP: keep reading
+	 * the zeroed default VRF vector instead of checking vrf_ids per batch.
+	 */
+	if (vrf_ids == NULL) {
+		vrfs = dir8_16_8_def_vrf_ids.u16;
+		vrf_inc = 0;
+	}
+
 	if (n >= 16) {
-		dir8_16_8_vec_prefetch_x8(dp, ips, be_addr, st0);
-		dir8_16_8_vec_prefetch_x8(dp, &ips[8], be_addr, st1);
+		dir8_16_8_vec_prefetch_x8(dp, vrfs, ips, be_addr, st0);
+		dir8_16_8_vec_prefetch_x8(dp, &vrfs[8 * vrf_inc], &ips[8],
+			be_addr, st1);
 		for (; i + 24 <= n; i += 8) {
-			dir8_16_8_vec_prefetch_x8(dp, &ips[i + 16], be_addr, st2);
+			dir8_16_8_vec_prefetch_x8(dp, &vrfs[(i + 16) * vrf_inc],
+				&ips[i + 16], be_addr, st2);
 			dir8_16_8_vec_lookup_x8(dp, st0, &ips[i], be_addr, &next_hops[i]);
 			tmp = st0;
 			st0 = st1;
@@ -115,28 +137,47 @@ vec_lookup_bulk(void *p, const uint32_t *ips, uint64_t *next_hops, unsigned int
 		dir8_16_8_vec_lookup_x8(dp, st1, &ips[i + 8], be_addr, &next_hops[i + 8]);
 		i += 16;
 	} else if (n >= 8) {
-		dir8_16_8_vec_prefetch_x8(dp, ips, be_addr, st0);
+		dir8_16_8_vec_prefetch_x8(dp, vrfs, ips, be_addr, st0);
 		dir8_16_8_vec_lookup_x8(dp, st0, ips, be_addr, next_hops);
 		i = 8;
 	}
 
-	/* Scalar lookup of the last n % 8 IPs. */
+	/* Scalar lookup of the last n % 8 IPs, the default VRF vector covers them. */
+	vrfs += i * vrf_inc;
 	if (be_addr)
-		dir8_16_8_lookup_bulk_be(p, &ips[i], &next_hops[i], n - i);
+		dir8_16_8_vrf_lookup_bulk_be(p, vrfs, &ips[i], &next_hops[i],
+			n - i);
 	else
-		dir8_16_8_lookup_bulk(p, &ips[i], &next_hops[i], n - i);
+		dir8_16_8_vrf_lookup_bulk(p, vrfs, &ips[i], &next_hops[i],
+			n - i);
+}
+
+void
+rte_dir8_16_8_vec_lookup_bulk(void *p, const uint16_t *vrf_ids,
+	const uint32_t *ips, uint64_t *next_hops, const unsigned int n)
+{
+	RTE_SET_USED(vrf_ids);
+	vec_lookup_bulk(p, NULL, ips, next_hops, n, false);
+}
+
+void
+rte_dir8_16_8_vec_lookup_bulk_be(void *p, const uint16_t *vrf_ids,
+	const uint32_t *ips, uint64_t *next_hops, const unsigned int n)
+{
+	RTE_SET_USED(vrf_ids);
+	vec_lookup_bulk(p, NULL, ips, next_hops, n, true);
 }
 
 void
-rte_dir8_16_8_vec_lookup_bulk(void *p, const uint32_t *ips,
-	uint64_t *next_hops, const unsigned int n)
+rte_dir8_16_8_vrf_vec_lookup_bulk(void *p, const uint16_t *vrf_ids,
+	const uint32_t *ips, uint64_t *next_hops, const unsigned int n)
 {
-	vec_lookup_bulk(p, ips, next_hops, n, false);
+	vec_lookup_bulk(p, vrf_ids, ips, next_hops, n, false);
 }
 
 void
-rte_dir8_16_8_vec_lookup_bulk_be(void *p, const uint32_t *ips,
-	uint64_t *next_hops, const unsigned int n)
+rte_dir8_16_8_vrf_vec_lookup_bulk_be(void *p, const uint16_t *vrf_ids,
+	const uint32_t *ips, uint64_t *next_hops, const unsigned int n)
 {
-	vec_lookup_bulk(p, ips, next_hops, n, true);
+	vec_lookup_bulk(p, vrf_ids, ips, next_hops, n, true);
 }
diff --git a/lib/fib/dir8_16_8_avx512.h b/lib/fib/dir8_16_8_avx512.h
index d468481029..d1ab4ab128 100644
--- a/lib/fib/dir8_16_8_avx512.h
+++ b/lib/fib/dir8_16_8_avx512.h
@@ -6,11 +6,19 @@
 #define _DIR8_16_8_AVX512_H_
 
 void
-rte_dir8_16_8_vec_lookup_bulk(void *p, const uint32_t *ips,
-	uint64_t *next_hops, const unsigned int n);
+rte_dir8_16_8_vec_lookup_bulk(void *p, const uint16_t *vrf_ids,
+	const uint32_t *ips, uint64_t *next_hops, const unsigned int n);
 
 void
-rte_dir8_16_8_vec_lookup_bulk_be(void *p, const uint32_t *ips,
-	uint64_t *next_hops, const unsigned int n);
+rte_dir8_16_8_vec_lookup_bulk_be(void *p, const uint16_t *vrf_ids,
+	const uint32_t *ips, uint64_t *next_hops, const unsigned int n);
+
+void
+rte_dir8_16_8_vrf_vec_lookup_bulk(void *p, const uint16_t *vrf_ids,
+	const uint32_t *ips, uint64_t *next_hops, const unsigned int n);
+
+void
+rte_dir8_16_8_vrf_vec_lookup_bulk_be(void *p, const uint16_t *vrf_ids,
+	const uint32_t *ips, uint64_t *next_hops, const unsigned int n);
 
 #endif /* _DIR8_16_8_AVX512_H_ */
diff --git a/lib/fib/rte_fib.c b/lib/fib/rte_fib.c
index fcc28899cb..795031edcd 100644
--- a/lib/fib/rte_fib.c
+++ b/lib/fib/rte_fib.c
@@ -42,23 +42,24 @@ struct rte_fib {
 	char			name[RTE_FIB_NAMESIZE];
 	enum rte_fib_type	type;	/**< Type of FIB struct */
 	unsigned int flags;		/**< Flags */
-	struct rte_rib		*rib;	/**< RIB helper datastructure */
+	struct rte_rib		**ribs;	/**< Per-VRF RIBs; ribs[0] is the main RIB. */
 	void			*dp;	/**< pointer to the dataplane struct*/
 	rte_fib_lookup_fn_t	lookup;	/**< FIB lookup function */
 	rte_fib_modify_fn_t	modify; /**< modify FIB datastructure */
 	uint64_t		def_nh;
+	uint16_t		max_vrfs; /**< Number of VRFs (0/1 = single). */
 };
 
 static void
-dummy_lookup(void *fib_p, const uint32_t *ips, uint64_t *next_hops,
-	const unsigned int n)
+dummy_lookup(void *fib_p, const uint16_t *vrf_ids __rte_unused,
+	const uint32_t *ips, uint64_t *next_hops, const unsigned int n)
 {
 	unsigned int i;
 	struct rte_fib *fib = fib_p;
 	struct rte_rib_node *node;
 
 	for (i = 0; i < n; i++) {
-		node = rte_rib_lookup(fib->rib, ips[i]);
+		node = rte_rib_lookup(fib->ribs[0], ips[i]);
 		if (node != NULL)
 			rte_rib_get_nh(node, &next_hops[i]);
 		else
@@ -67,26 +68,26 @@ dummy_lookup(void *fib_p, const uint32_t *ips, uint64_t *next_hops,
 }
 
 static int
-dummy_modify(struct rte_fib *fib, uint32_t ip, uint8_t depth,
-	uint64_t next_hop, int op)
+dummy_modify(struct rte_fib *fib, uint16_t vrf_id __rte_unused,
+	uint32_t ip, uint8_t depth, uint64_t next_hop, int op)
 {
 	struct rte_rib_node *node;
 	if ((fib == NULL) || (depth > RTE_FIB_MAXDEPTH))
 		return -EINVAL;
 
-	node = rte_rib_lookup_exact(fib->rib, ip, depth);
+	node = rte_rib_lookup_exact(fib->ribs[0], ip, depth);
 
 	switch (op) {
 	case RTE_FIB_ADD:
 		if (node == NULL)
-			node = rte_rib_insert(fib->rib, ip, depth);
+			node = rte_rib_insert(fib->ribs[0], ip, depth);
 		if (node == NULL)
 			return -rte_errno;
 		return rte_rib_set_nh(node, next_hop);
 	case RTE_FIB_DEL:
 		if (node == NULL)
 			return -ENOENT;
-		rte_rib_remove(fib->rib, ip, depth);
+		rte_rib_remove(fib->ribs[0], ip, depth);
 		return 0;
 	}
 	return -EINVAL;
@@ -118,7 +119,8 @@ init_dataplane(struct rte_fib *fib, __rte_unused int socket_id,
 		if (fib->dp == NULL)
 			return -rte_errno;
 		fib->lookup = dir8_16_8_get_lookup_fn(fib->dp,
-			RTE_FIB_LOOKUP_DEFAULT, !!(fib->flags & RTE_FIB_F_LOOKUP_NETWORK_ORDER));
+			RTE_FIB_LOOKUP_DEFAULT,
+			!!(fib->flags & RTE_FIB_F_LOOKUP_NETWORK_ORDER));
 		fib->modify = dir8_16_8_modify;
 		return 0;
 	default:
@@ -134,7 +136,7 @@ rte_fib_add(struct rte_fib *fib, uint32_t ip, uint8_t depth, uint64_t next_hop)
 	if ((fib == NULL) || (fib->modify == NULL) ||
 			(depth > RTE_FIB_MAXDEPTH))
 		return -EINVAL;
-	return fib->modify(fib, ip, depth, next_hop, RTE_FIB_ADD);
+	return fib->modify(fib, 0, ip, depth, next_hop, RTE_FIB_ADD);
 }
 
 RTE_EXPORT_SYMBOL(rte_fib_delete)
@@ -144,7 +146,7 @@ rte_fib_delete(struct rte_fib *fib, uint32_t ip, uint8_t depth)
 	if ((fib == NULL) || (fib->modify == NULL) ||
 			(depth > RTE_FIB_MAXDEPTH))
 		return -EINVAL;
-	return fib->modify(fib, ip, depth, 0, RTE_FIB_DEL);
+	return fib->modify(fib, 0, ip, depth, 0, RTE_FIB_DEL);
 }
 
 RTE_EXPORT_SYMBOL(rte_fib_lookup_bulk)
@@ -155,10 +157,65 @@ rte_fib_lookup_bulk(struct rte_fib *fib, uint32_t *ips,
 	FIB_RETURN_IF_TRUE(((fib == NULL) || (ips == NULL) ||
 		(next_hops == NULL) || (fib->lookup == NULL)), -EINVAL);
 
-	fib->lookup(fib->dp, ips, next_hops, n);
+	/* A NULL vrf_ids array selects VRF 0 for every IP. */
+	fib->lookup(fib->dp, NULL, ips, next_hops, n);
+	return 0;
+}
+
+static void
+free_dataplane(struct rte_fib *fib);
+
+/*
+ * Allocate the RIB array and create the FIB's RIBs: ribs[0] is the main RIB
+ * (named after the FIB), plus one independent RIB per extra VRF. A single-VRF
+ * FIB still keeps a one-element array so ribs[0] is always the main RIB.
+ */
+static int
+fib_create_ribs(struct rte_fib *fib, const char *name,
+	const struct rte_rib_conf *rib_conf, int socket_id)
+{
+	uint16_t v, num_vrfs = RTE_MAX(fib->max_vrfs, 1);
+
+	fib->ribs = rte_zmalloc_socket(NULL,
+		(size_t)num_vrfs * sizeof(struct rte_rib *),
+		RTE_CACHE_LINE_SIZE, socket_id);
+	if (fib->ribs == NULL)
+		return -ENOMEM;
+
+	fib->ribs[0] = rte_rib_create(name, socket_id, rib_conf);
+	if (fib->ribs[0] == NULL)
+		return -rte_errno;
+
+	for (v = 1; v < num_vrfs; v++) {
+		/*
+		 * Derive a short unique RIB name from the FIB pointer: the
+		 * user name plus a "_vN" suffix could overflow the RIB name
+		 * length limit.
+		 */
+		char rib_name[RTE_FIB_NAMESIZE];
+
+		snprintf(rib_name, sizeof(rib_name), "%p-v%u", (void *)fib, v);
+		fib->ribs[v] = rte_rib_create(rib_name, socket_id, rib_conf);
+		if (fib->ribs[v] == NULL)
+			return -rte_errno;
+	}
 	return 0;
 }
 
+/* Free every RIB and the RIB array. */
+static void
+fib_free_ribs(struct rte_fib *fib)
+{
+	uint16_t v, num_vrfs = RTE_MAX(fib->max_vrfs, 1);
+
+	if (fib->ribs == NULL)
+		return;
+	for (v = 0; v < num_vrfs; v++)
+		rte_rib_free(fib->ribs[v]);
+	rte_free(fib->ribs);
+	fib->ribs = NULL;
+}
+
 RTE_EXPORT_SYMBOL(rte_fib_create)
 struct rte_fib *
 rte_fib_create(const char *name, int socket_id, struct rte_fib_conf *conf)
@@ -166,15 +223,17 @@ rte_fib_create(const char *name, int socket_id, struct rte_fib_conf *conf)
 	char mem_name[RTE_FIB_NAMESIZE];
 	int ret;
 	struct rte_fib *fib = NULL;
-	struct rte_rib *rib = NULL;
 	struct rte_tailq_entry *te;
+	struct rte_tailq_entry *tmp_te;
 	struct rte_fib_list *fib_list;
 	struct rte_rib_conf rib_conf;
 
 	/* Check user arguments. */
 	if ((name == NULL) || (conf == NULL) ||	(conf->max_routes < 0) ||
 			(conf->flags & ~RTE_FIB_ALLOWED_FLAGS) ||
-			(conf->type > RTE_FIB_DIR8_16_8)) {
+			(conf->type > RTE_FIB_DIR8_16_8) ||
+			(conf->max_vrfs >= 2 &&
+				conf->type != RTE_FIB_DIR8_16_8)) {
 		rte_errno = EINVAL;
 		return NULL;
 	}
@@ -182,29 +241,7 @@ rte_fib_create(const char *name, int socket_id, struct rte_fib_conf *conf)
 	rib_conf.ext_sz = conf->rib_ext_sz;
 	rib_conf.max_nodes = conf->max_routes * 2;
 
-	rib = rte_rib_create(name, socket_id, &rib_conf);
-	if (rib == NULL) {
-		FIB_LOG(ERR,
-			"Can not allocate RIB %s", name);
-		return NULL;
-	}
-
 	snprintf(mem_name, sizeof(mem_name), "FIB_%s", name);
-	fib_list = RTE_TAILQ_CAST(rte_fib_tailq.head, rte_fib_list);
-
-	rte_mcfg_tailq_write_lock();
-
-	/* guarantee there's no existing */
-	TAILQ_FOREACH(te, fib_list, next) {
-		fib = (struct rte_fib *)te->data;
-		if (strncmp(name, fib->name, RTE_FIB_NAMESIZE) == 0)
-			break;
-	}
-	fib = NULL;
-	if (te != NULL) {
-		rte_errno = EEXIST;
-		goto exit;
-	}
 
 	/* allocate tailq entry */
 	te = rte_zmalloc("FIB_TAILQ_ENTRY", sizeof(*te), 0);
@@ -212,7 +249,7 @@ rte_fib_create(const char *name, int socket_id, struct rte_fib_conf *conf)
 		FIB_LOG(ERR,
 			"Can not allocate tailq entry for FIB %s", name);
 		rte_errno = ENOMEM;
-		goto exit;
+		return NULL;
 	}
 
 	/* Allocate memory to store the FIB data structures. */
@@ -225,10 +262,11 @@ rte_fib_create(const char *name, int socket_id, struct rte_fib_conf *conf)
 	}
 
 	rte_strlcpy(fib->name, name, sizeof(fib->name));
-	fib->rib = rib;
 	fib->type = conf->type;
 	fib->flags = conf->flags;
 	fib->def_nh = conf->default_nh;
+	fib->max_vrfs = conf->max_vrfs;
+
 	ret = init_dataplane(fib, socket_id, conf);
 	if (ret < 0) {
 		FIB_LOG(ERR,
@@ -238,6 +276,27 @@ rte_fib_create(const char *name, int socket_id, struct rte_fib_conf *conf)
 		goto free_fib;
 	}
 
+	ret = fib_create_ribs(fib, name, &rib_conf, socket_id);
+	if (ret < 0) {
+		FIB_LOG(ERR, "Can not allocate RIBs for FIB %s", name);
+		rte_errno = -ret;
+		goto free_ribs;
+	}
+
+	fib_list = RTE_TAILQ_CAST(rte_fib_tailq.head, rte_fib_list);
+
+	rte_mcfg_tailq_write_lock();
+
+	/* guarantee there's no existing */
+	TAILQ_FOREACH(tmp_te, fib_list, next) {
+		if (strncmp(name, ((struct rte_fib *)tmp_te->data)->name,
+				RTE_FIB_NAMESIZE) == 0) {
+			rte_errno = EEXIST;
+			rte_mcfg_tailq_write_unlock();
+			goto free_ribs;
+		}
+	}
+
 	te->data = (void *)fib;
 	TAILQ_INSERT_TAIL(fib_list, te, next);
 
@@ -245,13 +304,13 @@ rte_fib_create(const char *name, int socket_id, struct rte_fib_conf *conf)
 
 	return fib;
 
+free_ribs:
+	fib_free_ribs(fib);
+	free_dataplane(fib);
 free_fib:
 	rte_free(fib);
 free_te:
 	rte_free(te);
-exit:
-	rte_mcfg_tailq_write_unlock();
-	rte_rib_free(rib);
 
 	return NULL;
 }
@@ -324,7 +383,7 @@ rte_fib_free(struct rte_fib *fib)
 	rte_mcfg_tailq_write_unlock();
 
 	free_dataplane(fib);
-	rte_rib_free(fib->rib);
+	fib_free_ribs(fib);
 	rte_free(fib);
 	rte_free(te);
 }
@@ -340,7 +399,7 @@ RTE_EXPORT_SYMBOL(rte_fib_get_rib)
 struct rte_rib *
 rte_fib_get_rib(struct rte_fib *fib)
 {
-	return (fib == NULL) ? NULL : fib->rib;
+	return (fib == NULL) ? NULL : fib->ribs[0];
 }
 
 RTE_EXPORT_SYMBOL(rte_fib_select_lookup)
@@ -386,3 +445,48 @@ rte_fib_rcu_qsbr_add(struct rte_fib *fib, struct rte_fib_rcu_config *cfg)
 		return -ENOTSUP;
 	}
 }
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_fib_vrf_add, 26.11)
+int
+rte_fib_vrf_add(struct rte_fib *fib, uint16_t vrf_id, uint32_t ip,
+	uint8_t depth, uint64_t next_hop)
+{
+	if ((fib == NULL) || (fib->modify == NULL) ||
+			(depth > RTE_FIB_MAXDEPTH) ||
+			(vrf_id >= RTE_MAX(fib->max_vrfs, 1)))
+		return -EINVAL;
+	return fib->modify(fib, vrf_id, ip, depth, next_hop, RTE_FIB_ADD);
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_fib_vrf_delete, 26.11)
+int
+rte_fib_vrf_delete(struct rte_fib *fib, uint16_t vrf_id, uint32_t ip,
+	uint8_t depth)
+{
+	if ((fib == NULL) || (fib->modify == NULL) ||
+			(depth > RTE_FIB_MAXDEPTH) ||
+			(vrf_id >= RTE_MAX(fib->max_vrfs, 1)))
+		return -EINVAL;
+	return fib->modify(fib, vrf_id, ip, depth, 0, RTE_FIB_DEL);
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_fib_vrf_lookup_bulk, 26.11)
+int
+rte_fib_vrf_lookup_bulk(struct rte_fib *fib, const uint16_t *vrf_ids,
+	uint32_t *ips, uint64_t *next_hops, int n)
+{
+	FIB_RETURN_IF_TRUE(((fib == NULL) || (ips == NULL) ||
+		(next_hops == NULL) || (fib->lookup == NULL)), -EINVAL);
+
+	fib->lookup(fib->dp, vrf_ids, ips, next_hops, n);
+	return 0;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_fib_vrf_get_rib, 26.11)
+struct rte_rib *
+rte_fib_vrf_get_rib(struct rte_fib *fib, uint16_t vrf_id)
+{
+	if ((fib == NULL) || (vrf_id >= RTE_MAX(fib->max_vrfs, 1)))
+		return NULL;
+	return fib->ribs[vrf_id];
+}
diff --git a/lib/fib/rte_fib.h b/lib/fib/rte_fib.h
index 68ee6f0652..948bef7600 100644
--- a/lib/fib/rte_fib.h
+++ b/lib/fib/rte_fib.h
@@ -54,11 +54,11 @@ enum rte_fib_type {
 };
 
 /** Modify FIB function */
-typedef int (*rte_fib_modify_fn_t)(struct rte_fib *fib, uint32_t ip,
-	uint8_t depth, uint64_t next_hop, int op);
+typedef int (*rte_fib_modify_fn_t)(struct rte_fib *fib, uint16_t vrf_id,
+	uint32_t ip, uint8_t depth, uint64_t next_hop, int op);
 /** FIB bulk lookup function */
-typedef void (*rte_fib_lookup_fn_t)(void *fib, const uint32_t *ips,
-	uint64_t *next_hops, const unsigned int n);
+typedef void (*rte_fib_lookup_fn_t)(void *fib, const uint16_t *vrf_ids,
+	const uint32_t *ips, uint64_t *next_hops, const unsigned int n);
 
 enum rte_fib_op {
 	RTE_FIB_ADD,
@@ -123,6 +123,16 @@ struct rte_fib_conf {
 		} dir8_16_8;
 	};
 	unsigned int flags; /**< Optional feature flags from RTE_FIB_F_* */
+	/**
+	 * Number of VRFs to support. 0 or 1 means a single (default) VRF.
+	 * Values >= 2 require RTE_FIB_DIR8_16_8.
+	 */
+	uint16_t max_vrfs;
+	/**
+	 * Array of per-VRF default nexthops, indexed by VRF ID (max_vrfs
+	 * entries). NULL means use default_nh for every VRF.
+	 */
+	uint64_t *vrf_default_nh;
 };
 
 /** FIB RCU QSBR configuration structure. */
@@ -237,6 +247,86 @@ rte_fib_delete(struct rte_fib *fib, uint32_t ip, uint8_t depth);
 int
 rte_fib_lookup_bulk(struct rte_fib *fib, uint32_t *ips,
 		uint64_t *next_hops, int n);
+
+/**
+ * Add a route to a specific VRF of the FIB.
+ *
+ * @param fib
+ *   FIB object handle
+ * @param vrf_id
+ *   VRF ID (0 to max(max_vrfs, 1) - 1)
+ * @param ip
+ *   IPv4 prefix address to be added to the FIB
+ * @param depth
+ *   Prefix length
+ * @param next_hop
+ *   Next hop to be added to the FIB
+ * @return
+ *   0 on success, negative value otherwise
+ */
+__rte_experimental
+int
+rte_fib_vrf_add(struct rte_fib *fib, uint16_t vrf_id, uint32_t ip,
+	uint8_t depth, uint64_t next_hop);
+
+/**
+ * Delete a route from a specific VRF of the FIB.
+ *
+ * @param fib
+ *   FIB object handle
+ * @param vrf_id
+ *   VRF ID (0 to max(max_vrfs, 1) - 1)
+ * @param ip
+ *   IPv4 prefix address to be deleted from the FIB
+ * @param depth
+ *   Prefix length
+ * @return
+ *   0 on success, negative value otherwise
+ */
+__rte_experimental
+int
+rte_fib_vrf_delete(struct rte_fib *fib, uint16_t vrf_id, uint32_t ip,
+	uint8_t depth);
+
+/**
+ * Lookup multiple IP addresses, each in its own VRF, in the FIB.
+ *
+ * @param fib
+ *   FIB object handle
+ * @param vrf_ids
+ *   Array of VRF IDs, one per IP: ips[i] is looked up in VRF vrf_ids[i].
+ *   Each entry must be in the range 0 to max(max_vrfs, 1) - 1.
+ *   A NULL pointer is treated as VRF 0 for every IP.
+ * @param ips
+ *   Array of IPs to be looked up in the FIB
+ * @param next_hops
+ *   Next hop of the most specific rule found for IP in its VRF.
+ *   If the lookup fails, the element contains that VRF's default nexthop.
+ * @param n
+ *   Number of elements in the vrf_ids, ips and next_hops arrays to lookup.
+ * @return
+ *   -EINVAL for incorrect arguments, otherwise 0
+ */
+__rte_experimental
+int
+rte_fib_vrf_lookup_bulk(struct rte_fib *fib, const uint16_t *vrf_ids,
+	uint32_t *ips, uint64_t *next_hops, int n);
+
+/**
+ * Get pointer to the RIB of a specific VRF.
+ *
+ * @param fib
+ *   FIB object handle
+ * @param vrf_id
+ *   VRF ID (0 to max(max_vrfs, 1) - 1)
+ * @return
+ *   Pointer to the VRF RIB on success
+ *   NULL otherwise
+ */
+__rte_experimental
+struct rte_rib *
+rte_fib_vrf_get_rib(struct rte_fib *fib, uint16_t vrf_id);
+
 /**
  * Get pointer to the dataplane specific struct
  *
-- 
2.43.0

