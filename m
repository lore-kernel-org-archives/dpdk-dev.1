Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 407F9CD8CB9
	for <dpdk-dev@archiver.kernel.org>; Wed, 10 Jun 2026 10:39:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 571EE40270;
	Wed, 10 Jun 2026 12:39:46 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 2EE064026D
 for <dev@dpdk.org>; Wed, 10 Jun 2026 12:39:43 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.224.107])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4gb2Ms74q1zHnGh6;
 Wed, 10 Jun 2026 18:39:37 +0800 (CST)
Received: from dubpeml500001.china.huawei.com (unknown [7.214.147.241])
 by mail.maildlp.com (Postfix) with ESMTPS id 18F6840584;
 Wed, 10 Jun 2026 18:39:42 +0800 (CST)
Received: from localhost (10.220.239.45) by dubpeml500001.china.huawei.com
 (7.214.147.241) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 10 Jun
 2026 11:39:41 +0100
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: <dev@dpdk.org>
CC: <hofors@lysator.liu.se>, <mb@smartsharesystems.com>
Subject: [RFC] memtank: add memtank library
Date: Wed, 10 Jun 2026 11:39:17 +0100
Message-ID: <20260610103918.96857-1-konstantin.ananyev@huawei.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.220.239.45]
X-ClientProxiedBy: frapema100003.china.huawei.com (7.182.19.100) To
 dubpeml500001.china.huawei.com (7.214.147.241)
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

Introduce memtank, highly customizable fixed sized object allocator
for DPDK applications. It offers close to the mempool level performance
on the fast path.
Main difference with the mempool is the ability to grow/shrink at runtime
with user provided grow/shirnk threshold values, plus some extra
features for higher flexibility.

Key properties:

- relies on user to provide callbacks for actual memory reservations.
  User is free to choose whatever is most suitable way for his scenario,
  i.e: via malloc/rte_malloc/mmap/some custom memory allocator.
- user defined constructor callback for newly allocated objects.
- bulk alloc and free APIs.
- different alloc/free policies (specified by user via flags parameter):
  * lightweight as possible, but can fail
  * more robust, but heavyweight - causes call to user-provided backing
    memory allocator.
- backing memory grows/shrinks on demand, special API extensions
  to allow user control grow/shrink size, frequency and when/where it
  is going to happen (DP, CP, both, etc.).
- ability to pre-allocate all objects at memtank creation time
  (mempool like behavior).
- custom object size and alignment.
- per object runtime statistics and sanity-checks (boundary violation,
  double free, etc.) can be enabled/disabled at memtank creation time.

Known limitations (subject for further improvements):

- scalability:
  after 8+ lcores conventional mempool (with FIFO) starts to outperform
  memtank (which uses LIFO inside).
- mempool_cache integration is not part of the library and right now
  has to be implemented by used manually on top of memtank API.

Envisioned usage scenarios within DPDK-based apps:
various flow/session control structures (TCP PCB, CT, NAT sessions, etc.)
that needs to be allocated/freed at the data-path.
Also can be used by 'semi-fastpath' allocations:
TBL-8 blocks for LPM, hash buckets, etc.

Initial idea is inspired by Linux/Solaris SLAB allocators.
Also re-used some ideas from my previous work for TLDK project:
https://github.com/FDio/tldk
Signed-off-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
---
 app/test/meson.build                          |    2 +
 app/test/test_memtank.c                       |  160 +++
 app/test/test_memtank_stress.c                | 1075 +++++++++++++++++
 doc/api/doxy-api-index.md                     |    1 +
 doc/api/doxy-api.conf.in                      |    1 +
 .../prog_guide/img/memtank_internal.svg       |    1 +
 doc/guides/prog_guide/index.rst               |    1 +
 doc/guides/prog_guide/memtank_lib.rst         |  231 ++++
 lib/memtank/memtank.c                         |  630 ++++++++++
 lib/memtank/memtank.h                         |  110 ++
 lib/memtank/meson.build                       |   18 +
 lib/memtank/misc.c                            |  375 ++++++
 lib/memtank/rte_memtank.h                     |  303 +++++
 lib/meson.build                               |    1 +
 14 files changed, 2909 insertions(+)
 create mode 100644 app/test/test_memtank.c
 create mode 100644 app/test/test_memtank_stress.c
 create mode 100644 doc/guides/prog_guide/img/memtank_internal.svg
 create mode 100644 doc/guides/prog_guide/memtank_lib.rst
 create mode 100644 lib/memtank/memtank.c
 create mode 100644 lib/memtank/memtank.h
 create mode 100644 lib/memtank/meson.build
 create mode 100644 lib/memtank/misc.c
 create mode 100644 lib/memtank/rte_memtank.h

diff --git a/app/test/meson.build b/app/test/meson.build
index 61024125a7..d1b6203cf5 100644
--- a/app/test/meson.build
+++ b/app/test/meson.build
@@ -129,6 +129,8 @@ source_file_deps =3D {
     'test_memory.c': [],
     'test_mempool.c': [],
     'test_mempool_perf.c': [],
+    'test_memtank.c': ['memtank'],
+    'test_memtank_stress.c': ['memtank'],
     'test_memzone.c': [],
     'test_meter.c': ['meter'],
     'test_metrics.c': ['metrics'],
diff --git a/app/test/test_memtank.c b/app/test/test_memtank.c
new file mode 100644
index 0000000000..1cf55d65e6
--- /dev/null
+++ b/app/test/test_memtank.c
@@ -0,0 +1,160 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2018 Intel Corporation
+ */
+
+#include <stdio.h>
+#include <string.h>
+#include <stdint.h>
+#include <inttypes.h>
+
+#include <rte_memory.h>
+#include <rte_memtank.h>
+#include <rte_errno.h>
+#include "test.h"
+
+/* TEST SUITE */
+
+static int
+memtank_test_setup(void)
+{
+	return 0;
+}
+
+static void
+memtank_test_teardown(void)
+{
+}
+
+
+
+static void *
+test_alloc(size_t sz, void *p)
+{
+	RTE_SET_USED(p);
+	return malloc(sz);
+}
+
+static void
+test_free(void *buf, void *p)
+{
+	RTE_SET_USED(p);
+	return free(buf);
+}
+
+static int
+test_memtank_create_invalid(void)
+{
+	struct rte_memtank_prm prm;
+	struct rte_memtank *mt;
+
+	memset(&prm, 0, sizeof(prm));
+
+	rte_errno =3D 0;
+	mt =3D rte_memtank_create(&prm);
+	RTE_TEST_ASSERT_EQUAL(mt, NULL, "memtank create");
+	RTE_TEST_ASSERT_EQUAL(rte_errno, EINVAL, "errno EINVAL");
+
+	prm.alloc =3D test_alloc;
+	rte_errno =3D 0;
+	mt =3D rte_memtank_create(&prm);
+	RTE_TEST_ASSERT_EQUAL(mt, NULL, "memtank create");
+	RTE_TEST_ASSERT_EQUAL(rte_errno, EINVAL, "errno EINVAL");
+
+	prm.free =3D test_free;
+	rte_errno =3D 0;
+	mt =3D rte_memtank_create(&prm);
+	RTE_TEST_ASSERT_EQUAL(mt, NULL, "memtank create");
+	RTE_TEST_ASSERT_EQUAL(rte_errno, EINVAL, "errno EINVAL");
+
+	prm.obj_align =3D 2;
+	rte_errno =3D 0;
+	mt =3D rte_memtank_create(&prm);
+	RTE_TEST_ASSERT_EQUAL(mt, NULL, "memtank create");
+	RTE_TEST_ASSERT_EQUAL(rte_errno, EINVAL, "errno EINVAL");
+
+	prm.min_free =3D 2;
+	rte_errno =3D 0;
+	mt =3D rte_memtank_create(&prm);
+	RTE_TEST_ASSERT_EQUAL(mt, NULL, "memtank create");
+	RTE_TEST_ASSERT_EQUAL(rte_errno, EINVAL, "errno EINVAL");
+
+	prm.max_free =3D 2;
+	rte_errno =3D 0;
+	mt =3D rte_memtank_create(&prm);
+	RTE_TEST_ASSERT_EQUAL(mt, NULL, "memtank create");
+	RTE_TEST_ASSERT_EQUAL(rte_errno, EINVAL, "errno EINVAL");
+
+	prm.max_obj =3D 2;
+	rte_errno =3D 0;
+	mt =3D rte_memtank_create(&prm);
+	RTE_TEST_ASSERT_EQUAL(mt, NULL, "memtank create");
+	RTE_TEST_ASSERT_EQUAL(rte_errno, EINVAL, "errno EINVAL");
+
+	prm.nb_obj_chunk =3D 2;
+	rte_errno =3D 0;
+	mt =3D rte_memtank_create(&prm);
+	RTE_TEST_ASSERT_NOT_EQUAL(mt, NULL, "memtank create");
+
+	rte_memtank_destroy(mt);
+	return TEST_SUCCESS;
+}
+
+
+static int
+test_memtank_alloc(void)
+{
+	struct rte_memtank_prm prm;
+	struct rte_memtank *mt;
+
+	memset(&prm, 0, sizeof(prm));
+	prm.alloc =3D test_alloc;
+	prm.free =3D test_free;
+	prm.obj_align =3D 2;
+	prm.nb_obj_chunk =3D 2;
+	prm.min_free =3D 2;
+	prm.max_free =3D 2;
+	prm.max_obj =3D 10;
+
+	mt =3D rte_memtank_create(&prm);
+	RTE_TEST_ASSERT_NOT_EQUAL(mt, NULL, "memtank create");
+
+	void *obj[3] =3D { NULL };
+	uint32_t rc;
+
+	/* min_obj is 0 so this is expected to fail */
+	rc =3D rte_memtank_alloc(mt, obj, 1, RTE_MTANK_ALLOC_CHUNK);
+	RTE_TEST_ASSERT_EQUAL(rc, 0, "memtank alloc chunk 0 (%u)", rc);
+
+	rc =3D rte_memtank_alloc(mt, obj, 1, RTE_MTANK_ALLOC_GROW);
+	RTE_TEST_ASSERT_EQUAL(rc, 1, "memtank alloc 1 (%u)", rc);
+	RTE_TEST_ASSERT_NOT_EQUAL(obj[0], NULL, "alloc obj");
+
+	rc =3D rte_memtank_alloc(mt, obj, 3, RTE_MTANK_ALLOC_CHUNK);
+	RTE_TEST_ASSERT_EQUAL(rc, 3, "memtank alloc 3 (%u)", rc);
+
+	/* will fail - out of free objs */
+	rc =3D rte_memtank_alloc(mt, obj, 1, RTE_MTANK_ALLOC_CHUNK);
+	RTE_TEST_ASSERT_EQUAL(rc, 0, "memtank alloc chunk 0 (%u)", rc);
+
+	rte_memtank_destroy(mt);
+	return TEST_SUCCESS;
+}
+
+static struct unit_test_suite memtank_testsuite =3D {
+	.suite_name =3D "memtank library test suite",
+	.setup =3D memtank_test_setup,
+	.teardown =3D memtank_test_teardown,
+	.unit_test_cases =3D {
+		TEST_CASE(test_memtank_alloc),
+		TEST_CASE(test_memtank_create_invalid),
+		TEST_CASES_END(), /**< NULL terminate unit test array */
+	},
+};
+
+static int
+test_memtank(void)
+{
+	return unit_test_suite_runner(&memtank_testsuite);
+}
+
+REGISTER_FAST_TEST(memtank_autotest, NOHUGE_OK, ASAN_OK, test_memtank);
diff --git a/app/test/test_memtank_stress.c b/app/test/test_memtank_stress.c
new file mode 100644
index 0000000000..67b10c6611
--- /dev/null
+++ b/app/test/test_memtank_stress.c
@@ -0,0 +1,1075 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2019 Intel Corporation
+ * Copyright(c) 2025 Huawei Technologies Co., Ltd
+ */
+
+#include <string.h>
+#include <stdarg.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <stdint.h>
+#include <inttypes.h>
+#include <errno.h>
+#include <unistd.h>
+
+#include <rte_common.h>
+#include <rte_log.h>
+#include <rte_errno.h>
+#include <rte_launch.h>
+#include <rte_cycles.h>
+#include <rte_eal.h>
+#include <rte_ring.h>
+#include <rte_per_lcore.h>
+#include <rte_lcore.h>
+#include <rte_random.h>
+#include <rte_hexdump.h>
+#include <rte_malloc.h>
+#include <rte_memtank.h>
+
+#include "test.h"
+
+struct memstat {
+	struct {
+		rte_atomic64_t nb_call;
+		rte_atomic64_t nb_fail;
+		rte_atomic64_t sz;
+	} alloc;
+	struct {
+		rte_atomic64_t nb_call;
+		rte_atomic64_t nb_fail;
+	} free;
+	uint64_t nb_alloc_obj;
+};
+
+struct memtank_stat {
+	uint64_t nb_cycle;
+	struct {
+		uint64_t nb_call;
+		uint64_t nb_req;
+		uint64_t nb_alloc;
+		uint64_t nb_cycle;
+		uint64_t max_cycle;
+		uint64_t min_cycle;
+	} alloc;
+	struct {
+		uint64_t nb_call;
+		uint64_t nb_free;
+		uint64_t nb_cycle;
+		uint64_t max_cycle;
+		uint64_t min_cycle;
+	} free;
+	struct {
+		uint64_t nb_call;
+		uint64_t nb_chunk;
+		uint64_t nb_cycle;
+		uint64_t max_cycle;
+		uint64_t min_cycle;
+	} grow;
+	struct {
+		uint64_t nb_call;
+		uint64_t nb_chunk;
+		uint64_t nb_cycle;
+		uint64_t max_cycle;
+		uint64_t min_cycle;
+	} shrink;
+};
+
+struct master_args {
+	uint64_t run_cycles;
+	uint32_t delay_us;
+	uint32_t flags;
+};
+
+struct worker_args {
+	uint32_t max_obj;
+	uint32_t obj_size;
+	uint32_t alloc_flags;
+	uint32_t free_flags;
+	struct rte_ring *rng;
+};
+
+struct memtank_arg {
+	struct rte_memtank *mt;
+	union {
+		struct master_args master;
+		struct worker_args worker;
+	};
+	struct memtank_stat stats;
+} __rte_cache_aligned;
+
+#define BULK_NUM	32
+
+#define	OBJ_SZ_MIN	1
+#define	OBJ_SZ_MAX	0x100000
+#define	OBJ_SZ_DEF	(4 * RTE_CACHE_LINE_SIZE + 1)
+
+#define TEST_TIME	10
+#define CLEANUP_TIME	3
+
+#define FREE_THRSH_MIN	0
+#define FREE_THRSH_MAX	100
+
+enum {
+	WRK_CMD_STOP,
+	WRK_CMD_RUN,
+};
+
+enum {
+	MASTER_FLAG_GROW =3D 1,
+	MASTER_FLAG_SHRINK =3D 2,
+};
+
+enum {
+	MEM_FUNC_SYS,
+	MEM_FUNC_RTE,
+};
+
+static uint32_t wrk_cmd __rte_cache_aligned;
+
+static struct rte_memtank_prm mtnk_prm =3D {
+	.min_free =3D 4 * BULK_NUM,
+	.max_free =3D 32 * BULK_NUM,
+	.obj_size =3D OBJ_SZ_DEF,
+	.obj_align =3D RTE_CACHE_LINE_SIZE,
+	.nb_obj_chunk =3D BULK_NUM,
+	.flags =3D RTE_MTANK_OBJ_DBG,
+};
+
+static struct {
+	uint32_t run_time;       /* test run-time in seconds */
+	uint32_t wrk_max_obj;    /* max alloced objects per worker */
+	uint32_t wrk_fill_thrsh; /* wrk fill thresh % (0-100) */
+	uint32_t wrk_free_thrsh; /* wrk free thresh % (0-100) */
+	int32_t mem_func;        /* memory subsystem to use for alloc/free */
+	int32_t verbose;         /* verbose: print stat for each worker */
+} global_cfg =3D {
+	.run_time =3D TEST_TIME,
+	.wrk_max_obj =3D 2 * BULK_NUM,
+	.wrk_fill_thrsh =3D FREE_THRSH_MAX,
+	.wrk_free_thrsh =3D FREE_THRSH_MIN,
+	.mem_func =3D MEM_FUNC_SYS,
+	.verbose =3D 0,
+};
+
+static void *
+alloc_func(size_t sz)
+{
+	switch (global_cfg.mem_func) {
+	case MEM_FUNC_SYS:
+		return malloc(sz);
+	case MEM_FUNC_RTE:
+		return rte_malloc(NULL, sz, 0);
+	}
+
+	return NULL;
+}
+
+static void
+free_func(void *p)
+{
+	switch (global_cfg.mem_func) {
+	case MEM_FUNC_SYS:
+		return free(p);
+	case MEM_FUNC_RTE:
+		return rte_free(p);
+	}
+}
+
+static void *
+test_alloc1(size_t sz, void *p)
+{
+	struct memstat *ms;
+	void *buf;
+
+	ms =3D p;
+	buf =3D alloc_func(sz);
+	rte_atomic64_inc(&ms->alloc.nb_call);
+	if (buf !=3D NULL) {
+		memset(buf, 0, sz);
+		rte_atomic64_add(&ms->alloc.sz, sz);
+	} else
+		rte_atomic64_inc(&ms->alloc.nb_fail);
+
+	return buf;
+}
+
+static void
+test_free1(void *buf, void *p)
+{
+	struct memstat *ms;
+
+	ms =3D p;
+
+	free_func(buf);
+	rte_atomic64_inc(&ms->free.nb_call);
+	if (buf =3D=3D NULL)
+		rte_atomic64_inc(&ms->free.nb_fail);
+}
+
+static void
+global_cfg_dump(FILE *f)
+{
+	fprintf(f, "%s=3D{\n", __func__);
+	fprintf(f, "\t.run_time=3D%u\n", global_cfg.run_time);
+	fprintf(f, "\t.wrk_max_obj=3D%u\n", global_cfg.wrk_max_obj);
+	fprintf(f, "\t.wrk_fill_thrsh=3D%u\n", global_cfg.wrk_fill_thrsh);
+	fprintf(f, "\t.wrk_free_thrsh=3D%u\n", global_cfg.wrk_free_thrsh);
+	fprintf(f, "\t.mem_func=3D%d\n", global_cfg.mem_func);
+	fprintf(f, "\t.verbose=3D%d\n", global_cfg.verbose);
+	fprintf(f, "};\n");
+}
+
+static void
+memstat_dump(FILE *f, struct memstat *ms)
+{
+	uint64_t alloc_sz, nb_alloc;
+	long double muc, mut;
+
+	nb_alloc =3D rte_atomic64_read(&ms->alloc.nb_call) -
+		rte_atomic64_read(&ms->alloc.nb_fail);
+	alloc_sz =3D rte_atomic64_read(&ms->alloc.sz) / nb_alloc;
+	nb_alloc -=3D rte_atomic64_read(&ms->free.nb_call) -
+		rte_atomic64_read(&ms->free.nb_fail);
+	alloc_sz *=3D nb_alloc;
+	mut =3D (alloc_sz =3D=3D 0) ? 1 :
+		(long double)ms->nb_alloc_obj * mtnk_prm.obj_size / alloc_sz;
+	muc =3D (alloc_sz =3D=3D 0) ? 1 :
+		(long double)(ms->nb_alloc_obj + mtnk_prm.max_free) *
+		mtnk_prm.obj_size / alloc_sz;
+
+	fprintf(f, "%s(%p)=3D{\n", __func__, ms);
+	fprintf(f, "\talloc=3D{\n");
+	fprintf(f, "\t\tnb_call=3D%" PRIu64 ",\n",
+		rte_atomic64_read(&ms->alloc.nb_call));
+	fprintf(f, "\t\tnb_fail=3D%" PRIu64 ",\n",
+		rte_atomic64_read(&ms->alloc.nb_fail));
+	fprintf(f, "\t\tsz=3D%" PRIu64 ",\n",
+		rte_atomic64_read(&ms->alloc.sz));
+	fprintf(f, "\t},\n");
+	fprintf(f, "\tfree=3D{\n");
+	fprintf(f, "\t\tnb_call=3D%" PRIu64 ",\n",
+		rte_atomic64_read(&ms->free.nb_call));
+	fprintf(f, "\t\tnb_fail=3D%" PRIu64 ",\n",
+		rte_atomic64_read(&ms->free.nb_fail));
+	fprintf(f, "\t},\n");
+	fprintf(f, "\tnb_alloc_obj=3D%" PRIu64 ",\n", ms->nb_alloc_obj);
+	fprintf(f, "\tnb_alloc_chunk=3D%" PRIu64 ",\n", nb_alloc);
+	fprintf(f, "\talloc_sz=3D%" PRIu64 ",\n", alloc_sz);
+	fprintf(f, "\tmem_util(total)=3D%.2Lf %%,\n", mut * 100);
+	fprintf(f, "\tmem_util(cached)=3D%.2Lf %%,\n", muc * 100);
+	fprintf(f, "};\n");
+
+}
+
+static void
+memtank_stat_reset(struct memtank_stat *ms)
+{
+	static const struct memtank_stat init_stat =3D {
+		.alloc.min_cycle =3D UINT64_MAX,
+		.free.min_cycle =3D UINT64_MAX,
+		.grow.min_cycle =3D UINT64_MAX,
+		.shrink.min_cycle =3D UINT64_MAX,
+	};
+
+	*ms =3D init_stat;
+}
+
+static void
+memtank_stat_aggr(struct memtank_stat *as, const struct memtank_stat *ms)
+{
+	if (ms->alloc.nb_call !=3D 0) {
+		as->alloc.nb_call +=3D ms->alloc.nb_call;
+		as->alloc.nb_req +=3D ms->alloc.nb_req;
+		as->alloc.nb_alloc +=3D ms->alloc.nb_alloc;
+		as->alloc.nb_cycle +=3D ms->alloc.nb_cycle;
+		as->alloc.max_cycle =3D RTE_MAX(as->alloc.max_cycle,
+					ms->alloc.max_cycle);
+		as->alloc.min_cycle =3D RTE_MIN(as->alloc.min_cycle,
+					ms->alloc.min_cycle);
+	}
+	if (ms->free.nb_call !=3D 0) {
+		as->free.nb_call +=3D ms->free.nb_call;
+		as->free.nb_free +=3D ms->free.nb_free;
+		as->free.nb_cycle +=3D ms->free.nb_cycle;
+		as->free.max_cycle =3D RTE_MAX(as->free.max_cycle,
+					ms->free.max_cycle);
+		as->free.min_cycle =3D RTE_MIN(as->free.min_cycle,
+					ms->free.min_cycle);
+	}
+	if (ms->grow.nb_call !=3D 0) {
+		as->grow.nb_call +=3D ms->grow.nb_call;
+		as->grow.nb_chunk +=3D ms->grow.nb_chunk;
+		as->grow.nb_cycle +=3D ms->grow.nb_cycle;
+		as->grow.max_cycle =3D RTE_MAX(as->grow.max_cycle,
+					ms->grow.max_cycle);
+		as->grow.min_cycle =3D RTE_MIN(as->grow.min_cycle,
+					ms->grow.min_cycle);
+	}
+	if (ms->shrink.nb_call !=3D 0) {
+		as->shrink.nb_call +=3D ms->shrink.nb_call;
+		as->shrink.nb_chunk +=3D ms->shrink.nb_chunk;
+		as->shrink.nb_cycle +=3D ms->shrink.nb_cycle;
+		as->shrink.max_cycle =3D RTE_MAX(as->shrink.max_cycle,
+					ms->shrink.max_cycle);
+		as->shrink.min_cycle =3D RTE_MIN(as->shrink.min_cycle,
+					ms->shrink.min_cycle);
+	}
+}
+
+static void
+memtank_stat_dump(FILE *f, uint32_t lc, const struct memtank_stat *ms)
+{
+	uint64_t t;
+	long double st;
+
+	 st =3D (long double)rte_get_timer_hz() / US_PER_S;
+
+	if (lc =3D=3D UINT32_MAX)
+		fprintf(f, "%s(AGGREGATE)=3D{\n", __func__);
+	else
+		fprintf(f, "%s(lc=3D%u)=3D{\n", __func__, lc);
+
+	fprintf(f, "\tnb_cycle=3D%" PRIu64 ",\n", ms->nb_cycle);
+	if (ms->alloc.nb_call !=3D 0) {
+		fprintf(f, "\talloc=3D{\n");
+		fprintf(f, "\t\tnb_call=3D%" PRIu64 ",\n", ms->alloc.nb_call);
+		fprintf(f, "\t\tnb_req=3D%" PRIu64 ",\n", ms->alloc.nb_req);
+		fprintf(f, "\t\tnb_alloc=3D%" PRIu64 ",\n", ms->alloc.nb_alloc);
+		fprintf(f, "\t\tnb_cycle=3D%" PRIu64 ",\n", ms->alloc.nb_cycle);
+
+		t =3D ms->alloc.nb_req - ms->alloc.nb_alloc;
+		fprintf(f, "\t\tfailed req: %"PRIu64 "(%.2Lf %%)\n",
+			t, (long double)t * 100 /  ms->alloc.nb_req);
+		fprintf(f, "\t\tcycles/alloc: %.2Lf\n",
+			(long double)ms->alloc.nb_cycle / ms->alloc.nb_alloc);
+		fprintf(f, "\t\tobj/call(avg): %.2Lf\n",
+			(long double)ms->alloc.nb_alloc /  ms->alloc.nb_call);
+
+		fprintf(f, "\t\tmax cycles/call=3D%" PRIu64 "(%.2Lf usec),\n",
+			ms->alloc.max_cycle,
+			(long double)ms->alloc.max_cycle / st);
+		fprintf(f, "\t\tmin cycles/call=3D%" PRIu64 "(%.2Lf usec),\n",
+			ms->alloc.min_cycle,
+			(long double)ms->alloc.min_cycle / st);
+
+		fprintf(f, "\t},\n");
+	}
+	if (ms->free.nb_call !=3D 0) {
+		fprintf(f, "\tfree=3D{\n");
+		fprintf(f, "\t\tnb_call=3D%" PRIu64 ",\n", ms->free.nb_call);
+		fprintf(f, "\t\tnb_free=3D%" PRIu64 ",\n", ms->free.nb_free);
+		fprintf(f, "\t\tnb_cycle=3D%" PRIu64 ",\n", ms->free.nb_cycle);
+
+		fprintf(f, "\t\tcycles/free: %.2Lf\n",
+			(long double)ms->free.nb_cycle / ms->free.nb_free);
+		fprintf(f, "\t\tobj/call(avg): %.2Lf\n",
+			(long double)ms->free.nb_free /  ms->free.nb_call);
+
+		fprintf(f, "\t\tmax cycles/call=3D%" PRIu64 "(%.2Lf usec),\n",
+			ms->free.max_cycle,
+			(long double)ms->free.max_cycle / st);
+		fprintf(f, "\t\tmin cycles/call=3D%" PRIu64 "(%.2Lf usec),\n",
+			ms->free.min_cycle,
+			(long double)ms->free.min_cycle / st);
+
+		fprintf(f, "\t},\n");
+	}
+	if (ms->grow.nb_call !=3D 0) {
+		fprintf(f, "\tgrow=3D{\n");
+		fprintf(f, "\t\tnb_call=3D%" PRIu64 ",\n", ms->grow.nb_call);
+		fprintf(f, "\t\tnb_chunk=3D%" PRIu64 ",\n", ms->grow.nb_chunk);
+		fprintf(f, "\t\tnb_cycle=3D%" PRIu64 ",\n", ms->grow.nb_cycle);
+
+		fprintf(f, "\t\tcycles/chunk: %.2Lf\n",
+			(long double)ms->grow.nb_cycle / ms->grow.nb_chunk);
+		fprintf(f, "\t\tobj/call(avg): %.2Lf\n",
+			(long double)ms->grow.nb_chunk /  ms->grow.nb_call);
+
+		fprintf(f, "\t\tmax cycles/call=3D%" PRIu64 "(%.2Lf usec),\n",
+			ms->grow.max_cycle,
+			(long double)ms->grow.max_cycle / st);
+		fprintf(f, "\t\tmin cycles/call=3D%" PRIu64 "(%.2Lf usec),\n",
+			ms->grow.min_cycle,
+			(long double)ms->grow.min_cycle / st);
+
+		fprintf(f, "\t},\n");
+	}
+	if (ms->shrink.nb_call !=3D 0) {
+		fprintf(f, "\tshrink=3D{\n");
+		fprintf(f, "\t\tnb_call=3D%" PRIu64 ",\n", ms->shrink.nb_call);
+		fprintf(f, "\t\tnb_chunk=3D%" PRIu64 ",\n", ms->shrink.nb_chunk);
+		fprintf(f, "\t\tnb_cycle=3D%" PRIu64 ",\n", ms->shrink.nb_cycle);
+
+		fprintf(f, "\t\tcycles/chunk: %.2Lf\n",
+			(long double)ms->shrink.nb_cycle / ms->shrink.nb_chunk);
+		fprintf(f, "\t\tobj/call(avg): %.2Lf\n",
+			(long double)ms->shrink.nb_chunk /  ms->shrink.nb_call);
+
+		fprintf(f, "\t\tmax cycles/call=3D%" PRIu64 "(%.2Lf usec),\n",
+			ms->shrink.max_cycle,
+			(long double)ms->shrink.max_cycle / st);
+		fprintf(f, "\t\tmin cycles/call=3D%" PRIu64 "(%.2Lf usec),\n",
+			ms->shrink.min_cycle,
+			(long double)ms->shrink.min_cycle / st);
+
+		fprintf(f, "\t},\n");
+	}
+	fprintf(f, "};\n");
+}
+
+static int32_t
+check_fill_objs(void *obj[], uint32_t sz, uint32_t num,
+	uint8_t check, uint8_t fill)
+{
+	uint32_t i;
+	uint8_t buf[sz];
+
+	static rte_spinlock_t dump_lock;
+
+	memset(buf, check, sz);
+
+	for (i =3D 0; i !=3D num; i++) {
+		if (memcmp(buf, obj[i], sz) !=3D 0) {
+			rte_spinlock_lock(&dump_lock);
+			printf("%s(%u, %u, %hu, %hu) failed at %u-th iter, "
+				"offendig object: %p\n",
+				__func__, sz, num, check, fill, i, obj[i]);
+			rte_memdump(stdout, "expected", buf, sz);
+			rte_memdump(stdout, "result", obj[i], sz);
+			rte_spinlock_unlock(&dump_lock);
+			return -EINVAL;
+		}
+		memset(obj[i], fill, sz);
+	}
+	return 0;
+}
+
+static void
+destroy_worker_ring(struct worker_args *wa)
+{
+	free(wa->rng);
+	wa->rng =3D NULL;
+}
+
+static int
+create_worker_ring(struct worker_args *wa, uint32_t lc)
+{
+	int32_t rc;
+	size_t sz;
+	struct rte_ring *ring;
+
+	sz =3D rte_ring_get_memsize(wa->max_obj);
+	ring =3D aligned_alloc(alignof(typeof(*ring)), sz);
+	if (ring =3D=3D NULL) {
+		printf("%s(%u): alloc(%zu) for FIFO with %u elems failed",
+			__func__, lc, sz, wa->max_obj);
+		return -ENOMEM;
+	}
+	rc =3D rte_ring_init(ring, "", wa->max_obj,
+		RING_F_SP_ENQ | RING_F_SC_DEQ);
+	if (rc !=3D 0) {
+		printf("%s(%u): rte_ring_init(%p, %u) failed, error: %d(%s)\n",
+			__func__, lc, ring, wa->max_obj,
+			rc, strerror(-rc));
+		free(ring);
+		return rc;
+	}
+
+	wa->rng =3D ring;
+	return rc;
+}
+
+static int
+test_worker_cleanup(void *arg)
+{
+	void *obj[BULK_NUM];
+	int32_t rc;
+	uint32_t lc, n, num;
+	struct memtank_arg *ma;
+	struct rte_ring *ring;
+
+	ma =3D arg;
+	ring =3D ma->worker.rng;
+	lc =3D rte_lcore_id();
+
+	rc =3D 0;
+	for (n =3D rte_ring_count(ring); rc =3D=3D 0 && n !=3D 0; n -=3D num) {
+
+		num =3D rte_rand() % RTE_DIM(obj);
+		num =3D RTE_MIN(num, n);
+
+		if (num !=3D 0) {
+			/* retrieve objects to free */
+			rte_ring_dequeue_bulk(ring, obj, num, NULL);
+
+			/* check and fill contents of freeing objects */
+			rc =3D check_fill_objs(obj, ma->worker.obj_size, num,
+				lc, 0);
+			if (rc =3D=3D 0) {
+				rte_memtank_free(ma->mt, obj, num,
+					ma->worker.free_flags);
+				ma->stats.free.nb_free +=3D num;
+			}
+		}
+	}
+
+	return rc;
+}
+
+static int
+test_memtank_worker(void *arg)
+{
+	int32_t rc;
+	uint32_t lc, n, num, tfl, tfr;
+	uint64_t cl, tm0, tm1;
+	struct memtank_arg *ma;
+	struct rte_ring *ring;
+	void *obj[BULK_NUM];
+
+	ma =3D arg;
+	lc =3D rte_lcore_id();
+
+	/* calculate fill threshold */
+	tfl =3D (FREE_THRSH_MAX - global_cfg.wrk_fill_thrsh) *
+		ma->worker.max_obj / FREE_THRSH_MAX;
+
+	/* calculate free threshold */
+	tfr =3D ma->worker.max_obj * global_cfg.wrk_free_thrsh / FREE_THRSH_MAX;
+
+	ring =3D ma->worker.rng;
+
+	while (wrk_cmd !=3D WRK_CMD_RUN) {
+		rte_smp_rmb();
+		rte_pause();
+	}
+
+	cl =3D rte_rdtsc_precise();
+
+	do {
+		num =3D rte_rand() % RTE_DIM(obj);
+		n =3D rte_ring_free_count(ring);
+		num =3D (n >=3D tfl) ? RTE_MIN(num, n) : 0;
+
+		/* perform alloc*/
+		if (num !=3D 0) {
+			tm0 =3D rte_rdtsc_precise();
+			n =3D rte_memtank_alloc(ma->mt, obj, num,
+				ma->worker.alloc_flags);
+			tm1 =3D rte_rdtsc_precise();
+
+			/* check and fill contents of allocated objects */
+			rc =3D check_fill_objs(obj, ma->worker.obj_size, n,
+				0, lc);
+			if (rc !=3D 0)
+				break;
+
+			tm1 =3D tm1 - tm0;
+
+			/* collect alloc stat */
+			ma->stats.alloc.nb_call++;
+			ma->stats.alloc.nb_req +=3D num;
+			ma->stats.alloc.nb_alloc +=3D n;
+			ma->stats.alloc.nb_cycle +=3D tm1;
+			ma->stats.alloc.max_cycle =3D
+				RTE_MAX(ma->stats.alloc.max_cycle, tm1);
+			ma->stats.alloc.min_cycle =3D
+				RTE_MIN(ma->stats.alloc.min_cycle, tm1);
+
+			/* store allocated objects */
+			rte_ring_enqueue_bulk(ring, obj, n, NULL);
+		}
+
+		/* get some objects to free */
+		num =3D rte_rand() % RTE_DIM(obj);
+		n =3D rte_ring_count(ring);
+		num =3D (n >=3D tfr) ? RTE_MIN(num, n) : 0;
+
+		/* perform free*/
+		if (num !=3D 0) {
+
+			/* retrieve objects to free */
+			rte_ring_dequeue_bulk(ring, obj, num, NULL);
+
+			/* check and fill contents of freeing objects */
+			rc =3D check_fill_objs(obj, ma->worker.obj_size, num,
+				lc, 0);
+			if (rc !=3D 0)
+				break;
+
+			tm0 =3D rte_rdtsc_precise();
+			rte_memtank_free(ma->mt, obj, num,
+				ma->worker.free_flags);
+			tm1 =3D rte_rdtsc_precise();
+
+			tm1 =3D tm1 - tm0;
+
+			/* collect free stat */
+			ma->stats.free.nb_call++;
+			ma->stats.free.nb_free +=3D num;
+			ma->stats.free.nb_cycle +=3D tm1;
+			ma->stats.free.max_cycle =3D
+				RTE_MAX(ma->stats.free.max_cycle, tm1);
+			ma->stats.free.min_cycle =3D
+				RTE_MIN(ma->stats.free.min_cycle, tm1);
+		}
+
+		rte_smp_mb();
+	} while (wrk_cmd =3D=3D WRK_CMD_RUN);
+
+	ma->stats.nb_cycle =3D rte_rdtsc_precise() - cl;
+
+	return rc;
+}
+
+static int
+test_memtank_master(void *arg)
+{
+	struct memtank_arg *ma;
+	uint64_t cl, tm0, tm1, tm2;
+	uint32_t i, n;
+
+	ma =3D (struct memtank_arg *)arg;
+
+	for (cl =3D 0, i =3D 0; cl < ma->master.run_cycles;
+			cl +=3D tm2 - tm0, i++)  {
+
+		tm0 =3D rte_rdtsc_precise();
+
+		if (ma->master.flags & MASTER_FLAG_SHRINK) {
+
+			n =3D rte_memtank_shrink(ma->mt);
+			tm1 =3D rte_rdtsc_precise();
+			ma->stats.shrink.nb_call++;
+			ma->stats.shrink.nb_chunk +=3D n;
+			tm1 =3D tm1 - tm0;
+
+			if (n !=3D 0) {
+				ma->stats.shrink.nb_cycle +=3D tm1;
+				ma->stats.shrink.max_cycle =3D
+					RTE_MAX(ma->stats.shrink.max_cycle,
+						tm1);
+				ma->stats.shrink.min_cycle =3D
+					RTE_MIN(ma->stats.shrink.min_cycle,
+						tm1);
+			}
+		}
+
+		if (ma->master.flags & MASTER_FLAG_GROW) {
+
+			tm1 =3D rte_rdtsc_precise();
+			n =3D rte_memtank_grow(ma->mt);
+			tm2 =3D rte_rdtsc_precise();
+			ma->stats.grow.nb_call++;
+			ma->stats.grow.nb_chunk +=3D n;
+			tm2 =3D tm2 - tm1;
+
+			if (n !=3D 0) {
+				ma->stats.grow.nb_cycle +=3D tm2;
+				ma->stats.grow.max_cycle =3D
+					RTE_MAX(ma->stats.grow.max_cycle,
+						tm2);
+				ma->stats.grow.min_cycle =3D
+					RTE_MIN(ma->stats.grow.min_cycle,
+						tm2);
+			}
+		}
+
+		wrk_cmd =3D WRK_CMD_RUN;
+		rte_smp_mb();
+
+		rte_delay_us(ma->master.delay_us);
+		tm2 =3D rte_rdtsc_precise();
+	}
+
+	ma->stats.nb_cycle =3D cl;
+
+	rte_smp_mb();
+	wrk_cmd =3D WRK_CMD_STOP;
+
+	return 0;
+}
+
+static int
+fill_worker_args(struct worker_args *wa, uint32_t alloc_flags,
+	uint32_t free_flags, uint32_t lc)
+{
+	wa->max_obj =3D global_cfg.wrk_max_obj;
+	wa->obj_size =3D mtnk_prm.obj_size;
+	wa->alloc_flags =3D alloc_flags;
+	wa->free_flags =3D free_flags;
+
+	return create_worker_ring(wa, lc);
+}
+
+static void
+fill_master_args(struct master_args *ma, uint32_t flags)
+{
+	uint64_t tm;
+
+	tm =3D global_cfg.run_time * rte_get_timer_hz();
+
+	ma->run_cycles =3D tm;
+	ma->delay_us =3D US_PER_S / MS_PER_S;
+	ma->flags =3D flags;
+}
+
+static int
+test_memtank_cleanup(struct rte_memtank *mt, struct memstat *ms,
+	struct memtank_arg arg[], const char *tname)
+{
+	int32_t rc;
+	uint32_t lc;
+
+	printf("%s(%s)\n", __func__, tname);
+
+	RTE_LCORE_FOREACH_WORKER(lc)
+		rte_eal_remote_launch(test_worker_cleanup, &arg[lc], lc);
+
+	/* launch on master */
+	lc =3D rte_lcore_id();
+	arg[lc].master.run_cycles =3D CLEANUP_TIME * rte_get_timer_hz();
+	test_memtank_master(&arg[lc]);
+
+	rc =3D 0;
+	ms->nb_alloc_obj =3D 0;
+	RTE_LCORE_FOREACH_WORKER(lc) {
+		rc |=3D rte_eal_wait_lcore(lc);
+		ms->nb_alloc_obj +=3D arg[lc].stats.alloc.nb_alloc -
+			arg[lc].stats.free.nb_free;
+	}
+
+	rte_memtank_dump(stdout, mt, RTE_MTANK_DUMP_STAT);
+
+	memstat_dump(stdout, ms);
+	rc =3D rte_memtank_sanity_check(mt, 0);
+
+	return rc;
+}
+
+/*
+ * alloc/free by workers threads.
+ * grow/shrink by master
+ */
+static int
+test_memtank_mt(const char *tname, uint32_t alloc_flags, uint32_t free_fla=
gs)
+{
+	int32_t rc;
+	uint32_t lc;
+	struct rte_memtank *mt;
+	struct rte_memtank_prm prm;
+	struct memstat ms;
+	struct memtank_stat wrk_stats;
+	struct memtank_arg arg[RTE_MAX_LCORE];
+
+	printf("%s(%s) start\n", __func__, tname);
+
+	memset(&prm, 0, sizeof(prm));
+	memset(&ms, 0, sizeof(ms));
+
+	prm =3D mtnk_prm;
+	prm.alloc =3D test_alloc1;
+	prm.free =3D test_free1;
+	prm.udata =3D &ms;
+
+	mt =3D rte_memtank_create(&prm);
+	if (mt =3D=3D NULL) {
+		printf("%s(%s): memtank_create() failed\n", __func__, tname);
+		return -ENOMEM;
+	}
+
+	/* dump initial memory stats */
+	memstat_dump(stdout, &ms);
+
+	rc =3D 0;
+	memset(arg, 0, sizeof(arg));
+
+	/* prepare args on all slaves */
+	RTE_LCORE_FOREACH_WORKER(lc) {
+		arg[lc].mt =3D mt;
+		rc =3D fill_worker_args(&arg[lc].worker, alloc_flags,
+			free_flags, lc);
+		if (rc !=3D 0)
+			break;
+		memtank_stat_reset(&arg[lc].stats);
+	}
+
+	if (rc !=3D 0) {
+		rte_memtank_destroy(mt);
+		return rc;
+	}
+
+	/* launch on all slaves */
+	RTE_LCORE_FOREACH_WORKER(lc)
+		rte_eal_remote_launch(test_memtank_worker, &arg[lc], lc);
+
+	/* launch on master */
+	lc =3D rte_lcore_id();
+	arg[lc].mt =3D mt;
+	fill_master_args(&arg[lc].master,
+		MASTER_FLAG_GROW | MASTER_FLAG_SHRINK);
+	test_memtank_master(&arg[lc]);
+
+	/* wait for slaves and collect stats. */
+
+	memtank_stat_reset(&wrk_stats);
+
+	rc =3D 0;
+	RTE_LCORE_FOREACH_WORKER(lc) {
+		rc |=3D rte_eal_wait_lcore(lc);
+		if (global_cfg.verbose !=3D 0)
+			memtank_stat_dump(stdout, lc, &arg[lc].stats);
+		memtank_stat_aggr(&wrk_stats, &arg[lc].stats);
+		ms.nb_alloc_obj +=3D arg[lc].stats.alloc.nb_alloc -
+			arg[lc].stats.free.nb_free;
+	}
+
+	memtank_stat_dump(stdout, UINT32_MAX, &wrk_stats);
+
+	lc =3D rte_lcore_id();
+	memtank_stat_dump(stdout, lc, &arg[lc].stats);
+	rte_memtank_dump(stdout, mt, RTE_MTANK_DUMP_STAT);
+
+	memstat_dump(stdout, &ms);
+	rc |=3D rte_memtank_sanity_check(mt, 0);
+
+	/* run cleanup on all slave cores */
+	if (rc =3D=3D 0)
+		rc =3D test_memtank_cleanup(mt, &ms, arg, tname);
+
+	RTE_LCORE_FOREACH_WORKER(lc)
+		destroy_worker_ring(&arg[lc].worker);
+
+	rte_memtank_destroy(mt);
+	return rc;
+}
+
+/*
+ * alloc/free by workers threads.
+ * grow/shrink by master
+ */
+static int
+test_memtank_mt1(const char *tname)
+{
+	return test_memtank_mt(tname, 0, 0);
+}
+
+/*
+ * alloc/free with grow/shrink by worker threads.
+ * master does nothing
+ */
+static int
+test_memtank_mt2(const char *tname)
+{
+	const uint32_t alloc_flags =3D RTE_MTANK_ALLOC_CHUNK |
+				RTE_MTANK_ALLOC_GROW;
+	const uint32_t free_flags =3D RTE_MTANK_FREE_SHRINK;
+
+	return test_memtank_mt(tname, alloc_flags, free_flags);
+}
+
+static int
+parse_uint_val(const char *str, uint32_t *val, uint32_t min, uint32_t max)
+{
+	unsigned long v;
+	char *end;
+
+	errno =3D 0;
+	v =3D strtoul(str, &end, 0);
+	if (errno !=3D 0 || end[0] !=3D 0 || v < min || v > max)
+		return -EINVAL;
+
+	val[0] =3D v;
+	return 0;
+}
+
+static int
+parse_mem_str(const char *str)
+{
+	uint32_t i;
+
+	static const struct {
+		const char *name;
+		int32_t val;
+	} name2val[] =3D {
+		{
+			.name =3D "sys",
+			.val =3D MEM_FUNC_SYS,
+		},
+		{
+			.name =3D "rte",
+			.val =3D MEM_FUNC_RTE,
+		},
+	};
+
+	for (i =3D 0; i !=3D RTE_DIM(name2val); i++) {
+		if (strcmp(str, name2val[i].name) =3D=3D 0)
+			return name2val[i].val;
+	}
+	return -EINVAL;
+}
+
+/* update global values based on provided user input */
+static int
+update_global_cfg(void)
+{
+	mtnk_prm.max_obj =3D global_cfg.wrk_max_obj * rte_lcore_count();
+	return 0;
+}
+
+static int
+parse_opt(int argc, char * const argv[])
+{
+	int32_t opt, rc;
+	uint32_t v;
+
+	rc =3D 0;
+	optind =3D 0;
+	optarg =3D NULL;
+
+	while ((opt =3D getopt(argc, argv, "a:F:f:M:m:s:t:w:v")) !=3D EOF) {
+		switch (opt) {
+		case 'a':
+			rc =3D parse_mem_str(optarg);
+			if (rc >=3D 0)
+				global_cfg.mem_func =3D rc;
+			break;
+		case 'F':
+			rc =3D parse_uint_val(optarg, &v, FREE_THRSH_MIN,
+				FREE_THRSH_MAX);
+			if (rc =3D=3D 0)
+				global_cfg.wrk_fill_thrsh =3D v;
+			break;
+		case 'f':
+			rc =3D parse_uint_val(optarg, &v, FREE_THRSH_MIN,
+				FREE_THRSH_MAX);
+			if (rc =3D=3D 0)
+				global_cfg.wrk_free_thrsh =3D v;
+			break;
+		case 'M':
+			rc =3D parse_uint_val(optarg, &v, 0, UINT32_MAX);
+			if (rc =3D=3D 0)
+				mtnk_prm.max_free =3D v;
+			break;
+		case 'm':
+			rc =3D parse_uint_val(optarg, &v, 0, UINT32_MAX);
+			if (rc =3D=3D 0)
+				mtnk_prm.min_free =3D v;
+			break;
+		case 's':
+			rc =3D parse_uint_val(optarg, &v, OBJ_SZ_MIN,
+				OBJ_SZ_MAX);
+			if (rc =3D=3D 0)
+				mtnk_prm.obj_size =3D v;
+			break;
+		case 't':
+			rc =3D parse_uint_val(optarg, &v, 0, UINT32_MAX);
+			if (rc =3D=3D 0)
+				global_cfg.run_time =3D v;
+			break;
+		case 'w':
+			rc =3D parse_uint_val(optarg, &v, 0, UINT32_MAX);
+			if (rc =3D=3D 0)
+				global_cfg.wrk_max_obj =3D v;
+			break;
+		case 'v':
+			global_cfg.verbose =3D 1;
+			break;
+		default:
+			rc =3D -EINVAL;
+		}
+	}
+
+	if (rc < 0)
+		printf("%s: invalid value: \"%s\" for option: \'%c\'\n",
+			__func__, optarg, opt);
+
+	return  rc;
+}
+
+static int
+run_memtank_stress(int argc, char *argv[])
+{
+	int32_t rc;
+	uint32_t i, k;
+
+	const struct {
+		const char *name;
+		int (*func)(const char *tname);
+	} tests[] =3D {
+		{
+			.name =3D "MT1-WRK_ALLOC_FREE-MST_GROW_SHRINK",
+			.func =3D test_memtank_mt1,
+		},
+		{
+			.name =3D "MT1-WRK_ALLOC+GROW_FREE+SHRINK",
+			.func =3D test_memtank_mt2,
+		},
+	};
+
+	rc =3D parse_opt(argc, argv);
+	if (rc < 0) {
+		printf("%s: parse_op failed with error code: %d\n",
+			__func__, rc);
+		return rc;
+	}
+
+	/* update global values based on provided user input */
+	rc =3D update_global_cfg();
+	if (rc < 0)
+		return rc;
+
+	global_cfg_dump(stdout);
+
+	for (i =3D 0, k =3D 0; i !=3D RTE_DIM(tests); i++) {
+
+		printf("TEST %s START\n", tests[i].name);
+
+		rc =3D tests[i].func(tests[i].name);
+		k +=3D (rc =3D=3D 0);
+
+		if (rc !=3D 0)
+			printf("TEST %s FAILED\n", tests[i].name);
+		else
+			printf("TEST %s OK\n", tests[i].name);
+	}
+
+	printf("Number of tests:\t%u\nSuccess:\t%u\nFailed:\t%u\n",
+		i, k, i - k);
+	return (k !=3D i);
+}
+
+static int
+test_memtank_stress(void)
+{
+	int32_t rc;
+	uint32_t i;
+	const char *val;
+	char *sp, *str, *argv[16];
+	char buf[0x100];
+
+	static const char *dlm =3D " \t\n";
+	static const char *evar =3D "DPDK_MEMTANK_STRESS_TEST_PARAM";
+	static const char *eval =3D "";
+
+	val =3D getenv(evar);
+	if (val =3D=3D NULL)
+		val =3D eval;
+
+	snprintf(buf, sizeof(buf), "%s", val);
+
+	for (i =3D 0, str =3D buf; i !=3D RTE_DIM(argv); str =3D NULL, i++) {
+		argv[i] =3D strtok_r(str, dlm, &sp);
+		if (argv[i] =3D=3D NULL)
+			break;
+	}
+
+	if (i =3D=3D RTE_DIM(argv)) {
+		printf("invalid value: \"%s\" for $(%s)\n", val, evar);
+		return -EINVAL;
+	}
+
+	rc =3D run_memtank_stress(i, argv);
+	return rc;
+}
+
+REGISTER_STRESS_TEST(memtank_stress_autotest, test_memtank_stress);
diff --git a/doc/api/doxy-api-index.md b/doc/api/doxy-api-index.md
index 9296042119..68203b9d7b 100644
--- a/doc/api/doxy-api-index.md
+++ b/doc/api/doxy-api-index.md
@@ -71,6 +71,7 @@ The public API headers are grouped by topics:
   [mempool](@ref rte_mempool.h),
   [malloc](@ref rte_malloc.h),
   [memcpy](@ref rte_memcpy.h)
+  [memtank](@ref rte_memtank.h)
=20
 - **timers**:
   [cycles](@ref rte_cycles.h),
diff --git a/doc/api/doxy-api.conf.in b/doc/api/doxy-api.conf.in
index bedd944681..042482fe16 100644
--- a/doc/api/doxy-api.conf.in
+++ b/doc/api/doxy-api.conf.in
@@ -59,6 +59,7 @@ INPUT                   =3D @TOPDIR@/doc/api/doxy-api-ind=
ex.md \
                           @TOPDIR@/lib/mbuf \
                           @TOPDIR@/lib/member \
                           @TOPDIR@/lib/mempool \
+                          @TOPDIR@/lib/memtank \
                           @TOPDIR@/lib/meter \
                           @TOPDIR@/lib/metrics \
                           @TOPDIR@/lib/mldev \
diff --git a/doc/guides/prog_guide/img/memtank_internal.svg b/doc/guides/pr=
og_guide/img/memtank_internal.svg
new file mode 100644
index 0000000000..0f13242ed5
--- /dev/null
+++ b/doc/guides/prog_guide/img/memtank_internal.svg
@@ -0,0 +1 @@
+<svg width=3D"1280" height=3D"720" xmlns=3D"http://www.w3.org/2000/svg" xm=
lns:xlink=3D"http://www.w3.org/1999/xlink" overflow=3D"hidden"><defs><clipP=
ath id=3D"clip0"><rect x=3D"0" y=3D"0" width=3D"1280" height=3D"720"/></cli=
pPath></defs><g clip-path=3D"url(#clip0)"><rect x=3D"0" y=3D"0" width=3D"12=
80" height=3D"720" fill=3D"#FFFFFF"/><text font-family=3D"Calibri Light,Cal=
ibri Light_MSFontService,sans-serif" font-weight=3D"300" font-size=3D"59" t=
ransform=3D"translate(110.933 111)">memtank<tspan font-size=3D"59" x=3D"236=
.9" y=3D"0">(internal structure)</tspan></text><rect x=3D"392.5" y=3D"170.5=
" width=3D"86" height=3D"16" stroke=3D"#2F528F" stroke-width=3D"1.33333" st=
roke-miterlimit=3D"8" fill=3D"#D6DCE5"/><rect x=3D"392.5" y=3D"186.5" width=
=3D"86" height=3D"16" stroke=3D"#2F528F" stroke-width=3D"1.33333" stroke-mi=
terlimit=3D"8" fill=3D"#D6DCE5"/><rect x=3D"392.5" y=3D"202.5" width=3D"86"=
 height=3D"16" stroke=3D"#2F528F" stroke-width=3D"1.33333" stroke-miterlimi=
t=3D"8" fill=3D"#D6DCE5"/><rect x=3D"392.5" y=3D"218.5" width=3D"86" height=
=3D"16" stroke=3D"#2F528F" stroke-width=3D"1.33333" stroke-miterlimit=3D"8"=
 fill=3D"#D6DCE5"/><rect x=3D"392.5" y=3D"233.5" width=3D"86" height=3D"16"=
 stroke=3D"#2F528F" stroke-width=3D"1.33333" stroke-miterlimit=3D"8" fill=
=3D"#FFFFFF"/><rect x=3D"392.5" y=3D"249.5" width=3D"86" height=3D"16" stro=
ke=3D"#2F528F" stroke-width=3D"1.33333" stroke-miterlimit=3D"8" fill=3D"#FF=
FFFF"/><rect x=3D"392.5" y=3D"265.5" width=3D"86" height=3D"16" stroke=3D"#=
2F528F" stroke-width=3D"1.33333" stroke-miterlimit=3D"8" fill=3D"#FFFFFF"/>=
<rect x=3D"392.5" y=3D"281.5" width=3D"86" height=3D"16" stroke=3D"#2F528F"=
 stroke-width=3D"1.33333" stroke-miterlimit=3D"8" fill=3D"#FFFFFF"/><text f=
ont-family=3D"Calibri,Calibri_MSFontService,sans-serif" font-weight=3D"400"=
 font-size=3D"16" transform=3D"translate(205.267 215)">min_free<tspan font-=
size=3D"16" x=3D"62.62" y=3D"0">(grow thresh) </tspan><tspan font-family=3D=
"Wingdings,Wingdings_MSFontService,sans-serif" font-size=3D"16" x=3D"154" y=
=3D"0">=EF=83=A0</tspan><tspan font-size=3D"16" x=3D"-3.66667" y=3D"81">max=
_free</tspan><tspan font-size=3D"16" x=3D"61.4733" y=3D"81">(shrink thresh)=
 </tspan><tspan font-family=3D"Wingdings,Wingdings_MSFontService,sans-serif=
" font-size=3D"16" x=3D"159.593" y=3D"81">=EF=83=A0</tspan><tspan font-styl=
e=3D"italic" font-size=3D"24" x=3D"370.867" y=3D"-3">memtank_alloc</tspan><=
tspan font-style=3D"italic" font-size=3D"24" x=3D"520.973" y=3D"-3">(</tspa=
n><tspan font-style=3D"italic" font-size=3D"24" x=3D"528.307" y=3D"-3">mtnk=
</tspan><tspan font-style=3D"italic" font-size=3D"24" x=3D"578.24" y=3D"-3"=
>, </tspan><tspan font-style=3D"italic" font-size=3D"24" x=3D"589.74" y=3D"=
-3">obj</tspan><tspan font-style=3D"italic" font-size=3D"24" x=3D"620.073" =
y=3D"-3">[], </tspan><tspan font-style=3D"italic" font-size=3D"24" x=3D"646=
.24" y=3D"-3">num</tspan><tspan font-style=3D"italic" font-size=3D"24" x=3D=
"689.907" y=3D"-3">, flags) </tspan></text><path d=3D"M488.5 207.167 561.83=
3 207.167 561.833 207.833 488.5 207.833ZM560.5 203.5 568.5 207.5 560.5 211.=
5Z" fill=3D"#203864"/><text font-family=3D"Calibri,Calibri_MSFontService,sa=
ns-serif" font-style=3D"italic" font-weight=3D"400" font-size=3D"24" transf=
orm=3D"translate(577.2 274)">memtank_free(<tspan font-size=3D"24" x=3D"150.=
273" y=3D"0">mtnk</tspan><tspan font-size=3D"24" x=3D"200.207" y=3D"0">, </=
tspan>obj<tspan font-size=3D"24" x=3D"242.04" y=3D"0">[], </tspan><tspan fo=
nt-size=3D"24" x=3D"268.207" y=3D"0">num</tspan><tspan font-size=3D"24" x=
=3D"311.873" y=3D"0">, flags) </tspan></text><path d=3D"M496.167 269.167 56=
9.5 269.167 569.5 269.833 496.167 269.833ZM497.5 273.5 489.5 269.5 497.5 26=
5.5Z" fill=3D"#5B9BD5"/><rect x=3D"90" y=3D"353" width=3D"162" height=3D"29=
" fill=3D"#E7E6E6"/><text font-family=3D"Calibri,Calibri_MSFontService,sans=
-serif" font-weight=3D"400" font-size=3D"16" transform=3D"translate(99.9518=
 373)">mchunks<tspan font-size=3D"16" x=3D"58.1867" y=3D"0">[USED]</tspan><=
/text><path d=3D"M264.5 365.5 876.43 365.5 876.43 403.05 877.055 403.05" st=
roke=3D"#000000" stroke-width=3D"0.666667" stroke-miterlimit=3D"8" fill=3D"=
none" fill-rule=3D"evenodd"/><path d=3D"M847.5 383.5 910.397 383.5" stroke=
=3D"#000000" stroke-width=3D"0.666667" stroke-miterlimit=3D"8" fill=3D"none=
" fill-rule=3D"evenodd"/><path d=3D"M865.5 402.5 888.672 402.5" stroke=3D"#=
000000" stroke-width=3D"0.666667" stroke-miterlimit=3D"8" fill=3D"none" fil=
l-rule=3D"evenodd"/><path d=3D"M858.5 393.5 898.224 393.5" stroke=3D"#00000=
0" stroke-width=3D"0.666667" stroke-miterlimit=3D"8" fill=3D"none" fill-rul=
e=3D"evenodd"/><rect x=3D"325.5" y=3D"385.5" width=3D"85" height=3D"16" str=
oke=3D"#2F528F" stroke-width=3D"1.33333" stroke-miterlimit=3D"8" fill=3D"#D=
6DCE5"/><rect x=3D"325.5" y=3D"401.5" width=3D"85" height=3D"16" stroke=3D"=
#2F528F" stroke-width=3D"1.33333" stroke-miterlimit=3D"8" fill=3D"#FFFFFF"/=
><rect x=3D"325.5" y=3D"417.5" width=3D"85" height=3D"16" stroke=3D"#2F528F=
" stroke-width=3D"1.33333" stroke-miterlimit=3D"8" fill=3D"#FFFFFF"/><rect =
x=3D"325.5" y=3D"433.5" width=3D"85" height=3D"16" stroke=3D"#2F528F" strok=
e-width=3D"1.33333" stroke-miterlimit=3D"8" fill=3D"#FFFFFF"/><rect x=3D"50=
5.5" y=3D"383.5" width=3D"86" height=3D"16" stroke=3D"#2F528F" stroke-width=
=3D"1.33333" stroke-miterlimit=3D"8" fill=3D"#D6DCE5"/><rect x=3D"505.5" y=
=3D"399.5" width=3D"86" height=3D"16" stroke=3D"#2F528F" stroke-width=3D"1.=
33333" stroke-miterlimit=3D"8" fill=3D"#D6DCE5"/><rect x=3D"505.5" y=3D"415=
.5" width=3D"86" height=3D"16" stroke=3D"#2F528F" stroke-width=3D"1.33333" =
stroke-miterlimit=3D"8" fill=3D"#D6DCE5"/><rect x=3D"505.5" y=3D"431.5" wid=
th=3D"86" height=3D"16" stroke=3D"#2F528F" stroke-width=3D"1.33333" stroke-=
miterlimit=3D"8" fill=3D"#FFFFFF"/><rect x=3D"686.5" y=3D"385.5" width=3D"8=
5" height=3D"16" stroke=3D"#2F528F" stroke-width=3D"1.33333" stroke-miterli=
mit=3D"8" fill=3D"#FFFFFF"/><rect x=3D"686.5" y=3D"401.5" width=3D"85" heig=
ht=3D"16" stroke=3D"#2F528F" stroke-width=3D"1.33333" stroke-miterlimit=3D"=
8" fill=3D"#FFFFFF"/><rect x=3D"686.5" y=3D"417.5" width=3D"85" height=3D"1=
6" stroke=3D"#2F528F" stroke-width=3D"1.33333" stroke-miterlimit=3D"8" fill=
=3D"#FFFFFF"/><rect x=3D"686.5" y=3D"433.5" width=3D"85" height=3D"16" stro=
ke=3D"#2F528F" stroke-width=3D"1.33333" stroke-miterlimit=3D"8" fill=3D"#FF=
FFFF"/><path d=3D"M368.5 365.5 368.5 385.369" stroke=3D"#000000" stroke-wid=
th=3D"0.666667" stroke-miterlimit=3D"8" fill=3D"none" fill-rule=3D"evenodd"=
/><path d=3D"M548.5 365.5 548.5 384.022" stroke=3D"#000000" stroke-width=3D=
"0.666667" stroke-miterlimit=3D"8" fill=3D"none" fill-rule=3D"evenodd"/><pa=
th d=3D"M728.5 365.5 728.917 385.369" stroke=3D"#000000" stroke-width=3D"0.=
666667" stroke-miterlimit=3D"8" fill=3D"none" fill-rule=3D"evenodd"/><rect =
x=3D"90" y=3D"478" width=3D"162" height=3D"29" fill=3D"#E7E6E6"/><text font=
-family=3D"Calibri,Calibri_MSFontService,sans-serif" font-weight=3D"400" fo=
nt-size=3D"16" transform=3D"translate(99.5345 498)">mchunks<tspan font-size=
=3D"16" x=3D"58.1867" y=3D"0">[FULL]</tspan></text><path d=3D"M264.5 490.5 =
729.18 490.5 729.18 526.369 729.059 526.369" stroke=3D"#000000" stroke-widt=
h=3D"0.666667" stroke-miterlimit=3D"8" fill=3D"none" fill-rule=3D"evenodd"/=
><path d=3D"M699.5 507.5 762.397 507.5" stroke=3D"#000000" stroke-width=3D"=
0.666667" stroke-miterlimit=3D"8" fill=3D"none" fill-rule=3D"evenodd"/><pat=
h d=3D"M718.5 526.5 741.672 526.5" stroke=3D"#000000" stroke-width=3D"0.666=
667" stroke-miterlimit=3D"8" fill=3D"none" fill-rule=3D"evenodd"/><path d=
=3D"M710.5 517.5 750.224 517.5" stroke=3D"#000000" stroke-width=3D"0.666667=
" stroke-miterlimit=3D"8" fill=3D"none" fill-rule=3D"evenodd"/><rect x=3D"3=
25.5" y=3D"510.5" width=3D"85" height=3D"16" stroke=3D"#2F528F" stroke-widt=
h=3D"1.33333" stroke-miterlimit=3D"8" fill=3D"#D6DCE5"/><rect x=3D"325.5" y=
=3D"526.5" width=3D"85" height=3D"16" stroke=3D"#2F528F" stroke-width=3D"1.=
33333" stroke-miterlimit=3D"8" fill=3D"#D6DCE5"/><rect x=3D"325.5" y=3D"542=
.5" width=3D"85" height=3D"16" stroke=3D"#2F528F" stroke-width=3D"1.33333" =
stroke-miterlimit=3D"8" fill=3D"#D6DCE5"/><rect x=3D"325.5" y=3D"558.5" wid=
th=3D"85" height=3D"16" stroke=3D"#2F528F" stroke-width=3D"1.33333" stroke-=
miterlimit=3D"8" fill=3D"#D6DCE5"/><rect x=3D"505.5" y=3D"508.5" width=3D"8=
6" height=3D"16" stroke=3D"#2F528F" stroke-width=3D"1.33333" stroke-miterli=
mit=3D"8" fill=3D"#D6DCE5"/><rect x=3D"505.5" y=3D"524.5" width=3D"86" heig=
ht=3D"16" stroke=3D"#2F528F" stroke-width=3D"1.33333" stroke-miterlimit=3D"=
8" fill=3D"#D6DCE5"/><rect x=3D"505.5" y=3D"540.5" width=3D"86" height=3D"1=
6" stroke=3D"#2F528F" stroke-width=3D"1.33333" stroke-miterlimit=3D"8" fill=
=3D"#D6DCE5"/><rect x=3D"505.5" y=3D"556.5" width=3D"86" height=3D"16" stro=
ke=3D"#2F528F" stroke-width=3D"1.33333" stroke-miterlimit=3D"8" fill=3D"#D6=
DCE5"/><path d=3D"M367.5 490.5 367.5 510.369" stroke=3D"#000000" stroke-wid=
th=3D"0.666667" stroke-miterlimit=3D"8" fill=3D"none" fill-rule=3D"evenodd"=
/><path d=3D"M548.5 490.5 548.5 509.022" stroke=3D"#000000" stroke-width=3D=
"0.666667" stroke-miterlimit=3D"8" fill=3D"none" fill-rule=3D"evenodd"/><te=
xt font-family=3D"Calibri,Calibri_MSFontService,sans-serif" font-style=3D"i=
talic" font-weight=3D"400" font-size=3D"24" transform=3D"translate(178.705 =
644)">memtank_grow<tspan font-size=3D"24" x=3D"154.32" y=3D"0">(</tspan><ts=
pan font-size=3D"24" x=3D"161.653" y=3D"0">mtnk</tspan><tspan font-size=3D"=
24" x=3D"211.587" y=3D"0">) </tspan><tspan font-size=3D"24" x=3D"303.585" y=
=3D"0">memtank_shrink</tspan>(<tspan font-size=3D"24" x=3D"473.858" y=3D"0"=
>mtnk</tspan><tspan font-size=3D"24" x=3D"523.792" y=3D"0">) </tspan></text=
><path d=3D"M0.333333-8.08095e-07 0.333422 36.6397-0.333245 36.6397-0.33333=
3 8.08095e-07ZM4.00009 35.3063 0.000104987 43.3064-3.99991 35.3064Z" fill=
=3D"#203864" transform=3D"matrix(1 0 0 -1 367.5 620.806)"/><path d=3D"M548.=
833 577.5 548.833 615.486 548.167 615.486 548.167 577.5ZM552.5 614.153 548.=
5 622.153 544.5 614.153Z" fill=3D"#5B9BD5"/><path d=3D"M416.833 310.167 416=
.833 360.426 416.167 360.426 416.167 310.167ZM412.5 311.5 416.5 303.5 420.5=
 311.5Z" fill=3D"#203864"/><path d=3D"M0.333346 6.66666 0.333438 56.926-0.3=
33228 56.926-0.333321 6.66666ZM-3.99999 8.00001 0 0 4.00001 7.99999Z" fill=
=3D"#5B9BD5" transform=3D"matrix(1 0 0 -1 450.5 360.426)"/><text fill=3D"#2=
03864" font-family=3D"Calibri,Calibri_MSFontService,sans-serif" font-style=
=3D"italic" font-weight=3D"400" font-size=3D"16" transform=3D"translate(313=
.161 342)">ALLOC_CHUNK <tspan font-size=3D"16" x=3D"-51.8536" y=3D"264">ALL=
OC_GROW </tspan><tspan fill=3D"#4472C4" font-size=3D"16" x=3D"244.219" y=3D=
"260">FREE_SHRINK </tspan></text><rect x=3D"90" y=3D"161" width=3D"162" hei=
ght=3D"29" fill=3D"#E7E6E6"/><text font-family=3D"Calibri,Calibri_MSFontSer=
vice,sans-serif" font-weight=3D"400" font-size=3D"16" transform=3D"translat=
e(99.5345 181)">LIFO queue </text></g></svg>
\ No newline at end of file
diff --git a/doc/guides/prog_guide/index.rst b/doc/guides/prog_guide/index.=
rst
index e6f24945b0..834266f8de 100644
--- a/doc/guides/prog_guide/index.rst
+++ b/doc/guides/prog_guide/index.rst
@@ -26,6 +26,7 @@ Memory Management
=20
     lcore_var
     mempool_lib
+    memtank_lib
     mbuf_lib
     multi_proc_support
=20
diff --git a/doc/guides/prog_guide/memtank_lib.rst b/doc/guides/prog_guide/=
memtank_lib.rst
new file mode 100644
index 0000000000..51fe822572
--- /dev/null
+++ b/doc/guides/prog_guide/memtank_lib.rst
@@ -0,0 +1,231 @@
+..  SPDX-License-Identifier: BSD-3-Clause
+    Copyright(c) 2026 Huawei Technologies Co., Ltd
+
+Memtank Library
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+The memtank library is a fixed sized object allocator for DPDK application=
s.
+Same a s mempool it allows to alloc/free bulk of objects of fixed size in a
+lightweight manner.
+But in addition it can grow/shrink dynamically plus provides extra
+additional API for higher flexibility:
+
+* manual grow()/shrink() functions
+
+* different alloc/free policies
+  (can be specified by user via flags parameter):
+
+  * lightweight as possible, but can fail
+
+  * more robust, but heavyweight - might cause call to user-provided backi=
ng
+    memory allocator.
+
+* user provided callbacks for actual system-wide memory reservations.
+  User is free to choose whatever is most suitable way for his/her scenari=
o,
+  i.e: via malloc/rte_malloc/mmap/some custom allocator.
+
+* user defined constructor callback for newly allocated objects.
+
+* built-in per object runtime verify (boundary violation, double free, etc=
.) =E2=80=93
+  controlled by flags at memtank creation time.
+
+
+Memtank usage scenarios
+-----------------------
+
+Use memtank when:
+
+* Relatively small objects of the same size are allocated and freed on the
+  data path with low, predictable latency requirements.
+
+* Pre-allocation memory for maximum possible number of objects is not
+  feasible.
+
+
+Internals
+---------
+
+Internally each memtank consists of:
+
+* Fixed size LIFO queue that serves as a pool of free objects for fast
+  allocation/deallocation. It's internals and behavior are very similar
+  to current mempool LIFO driver.
+
+* Two lists (USED, FREE) of memchunks. Memchunk is an analog of SLAB:
+  For performance reasons memtank tries to allocate memory in relatively
+  big chunks (memchunks) and then split each memchunk in dozens (or hundre=
ds)
+  of objects. Objects from memchunks are used to populate pool of free
+  objects (see above).
+
+* Each memchunk consists of some metadata plus array of free objects (LIFO)
+  that belong to that chunk. As soon as number of free objects in the chunk
+  becomes equal to the total number of objects it considered as ```FREE```
+  and can be 'shrinked' - relased back to the memory subsystem.
+
+* Each object within memtank is a properly aligned and initialized data bu=
ffer
+  that will be provided to the user followed by the metadata that is used
+  to determine which memchunk it belongs to plus some extra fields used for
+  statisitics collection and runtime verification. Total size of the metad=
ata
+  for each object: 32B.
+
+There are two user defined thresholds that control memtank grow/shrink
+behavior:
+
+* ```min_free``` - grow threshold. That value controls two things: when it=
 is
+  time to request for more memory from the underlying memory subsystem and=
 how
+  many memory has to be requested/released in one go.
+
+* ```max_free``` - shrink threshold. That value determines when it is ok f=
or
+  memtank to start to release unused memory back to the underlying memory
+  subsystem.
+
+Also user can define a grow limit: ```max_obj``` - maximimum possible numb=
er
+of objects that given memtank can contain. By setting all these three
+parameters to the same value, memtank behaves like mempool with LIFO drive=
r.
+
+.. _figure_memtank-internals:
+
+.. figure:: img/memtank_internal.svg
+
+
+Brief API description
+---------------------
+
+* ```rte_memtank_create()```/```rte_memtank_destroy()``` are responsible f=
or
+creation/destroying the memntank.
+
+* ```rte_memtank_alloc()```/```rte_memtank_free()``` - perform objects
+  allocation/deallocation from/to the memntank. Note that both of them
+  operate in bulks and accept extra flag parameter to allow user to specify
+  exact behavior.
+
+* ```rte_memtank_chunk_alloc()```/```rte_memtank_chunk_free()``` also perf=
orm
+  allocation/deallocation from/to the memntank. Though these functions byp=
ass
+  pooll of free objects and allocate/free objects straight from/to the poo=
l.
+
+* ```rte_memtank_grow()```/```rte_memtank_shrink()``` are intended to
+  explicitly reserve/release memory from/to underlying memory subsystem and
+  add/remove objects to/from the tank. Possible usage scenario - either so=
me
+  house-keeping task, or even data-path thread  during idle periods.
+
+* ```rte_memtank_dump()```/```rte_memtank_sanity_check()``` - miscelanneous
+  API for statistics/internal dumping and sanity cheking.
+
+
+Aled public API functions except ```rte_memetank_destroy()``` are MT safe =
and
+can be called concurrently from different threads.
+
+Object allocation
+~~~~~~~~~~~~~~~~~
+
+By default ```rte_memtank_alloc()``` first tries to get objects from the f=
ree
+objects pool. If there are not enough free objects in the pool, then behav=
ior
+depends on the flag values user provided:
+
+* none - alloc() will simply return to the user obtained from the pool obj=
ects.
+
+* ```RTE_MTANK_ALLOC_CHUNK``` - alloc() will try to get remaining free obj=
ects
+  from already allocated memchunks.
+
+* If already allocated memchunks also don't contain enough
+  free objects and ```RTE_MTANK_ALLOC_GROW``` is specified, then it will t=
ry
+  to perform ```grow``` operation by allocating extra memory from the
+  underlying memory susbystem and creating new memchunks to satisfy user
+  request.
+
+In last two cases, it will try to refill free pool up to ```min_free```
+threshold value.
+
+Object de-allocation
+~~~~~~~~~~~~~~~~~~~~
+
+In reverse, ```ret_memtank_free()``` first tries to put objects back to
+the free pool. In case there is not enough room, it puts remaining free
+objects to the memchunks they belong to. After that, if
+```RTE_MTANK_FREE_SHRINK```` is specified it starts ```shrink``` operation
+to return unused memchunks back to the memory subsystem.
+
+
+Grow/Shrink
+~~~~~~~~~~~
+
+Apart from invoking ```grow```/```shrink``` implicitly (via alloc/free fla=
gs)
+there is an API for explicit invocation:
+
+* ```rte_memtank_grow(struct rte_memtank \*)``` - if number of objects in
+the free pool drops below ```min_free``` thershold, it requests next memory
+region from the udnerlying memory subsystem, creates new memchunks from it
+and populates the pool.
+
+* ```rte_memtank_shrink(struct memtank \*)``` - if total number of free ob=
jects
+in the tank exceeds ```max_free``` theshold it de-allocates unused memchun=
ks
+back to the underlying memory subsystem.
+
+
+Create/Destroy
+~~~~~~~~~~~~~~
+
+.. code-block:: c
+
+   sruct user_defined_type;
+
+   /*
+    * User defined callbacks to reserve/release memory from/to backing
+    * memory subsystem.
+    */
+
+   static void *
+   user_defined_alloc(size_t sz, void *udata)
+   {
+        RTE_SET_USED(udata);
+        return rte_malloc(NULL, sz, 0);
+   }
+
+   static void
+   user_defined_free(void *buf, void *udata)
+   {
+        RTE_SET_USED(udata);
+        rte_free(buf);
+   }
+
+   /*
+    * As used needs new memtank he fills memtank param structure and calls
+    *  rte_memtank_create():
+    */
+    static struct rte_memtank_prm prm =3D {
+        /* min number of free objs in the pool (grow threshold). */
+        .min_free =3D 1024,
+        /* max number of free objs (shrink threshold)a */
+        .max_free =3D 1024 * 1024,
+        .obj_size =3D sizeof(struct user_defined_type);
+        .obj_align =3D alignof(struct user_defined_type);
+        .nb_obj_chunk =3D 2 * 1024,
+        /* enable obj runtime verify and stats collection */
+        .flags =3D RTE_MTANK_OBJ_DBG,
+        /* user defined callbacks to reserve/release actual memory */
+        .alloc =3D user_defined_alloc,
+        .free =3D user_define_free,
+   };
+
+   struct rte_memtank *mt =3D rte_memtank_create(&prm);
+
+   ....
+
+   /* no more objects from the memtank are in use */
+   rte_memtank_destroy(mt);
+
+
+Known limitations (subject for further improvements):
+-----------------------------------------------------
+
+* scalability:
+  after 8+ lcores conventional mempool (with FIFO) starts to outperform
+  memtank (which by default uses LIFO inside).
+
+* mempool_cache integration is not part of the library and right now
+  has to be implemented by used manually on top of memtank API.
+
+* As pool of free objects might contain objects from different memchunks,
+  it can prevent some memchunks to get deallocated and returned back to
+  the memory subsystem.
+
diff --git a/lib/memtank/memtank.c b/lib/memtank/memtank.c
new file mode 100644
index 0000000000..2c6ec948a5
--- /dev/null
+++ b/lib/memtank/memtank.c
@@ -0,0 +1,630 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2019 Intel Corporation
+ * Copyright(c) 2025 Huawei Technologies Co., Ltd
+ */
+
+#include "memtank.h"
+#include <rte_bitops.h>
+#include <rte_errno.h>
+#include <eal_export.h>
+
+#define MEMTANK_OBJ_BULK	0x100
+#define MEMTANK_CHUNK_BULK	0x100
+
+#define	ALIGN_MUL_CEIL(v, mul)	\
+	((typeof(v))(((uint64_t)(v) + (mul) - 1) / (mul)))
+
+
+static inline size_t
+memtank_meta_size(uint32_t nb_free)
+{
+	size_t sz;
+	static const struct rte_memtank *mt;
+
+	sz =3D sizeof(*mt) + nb_free * sizeof(mt->mtf.free[0]);
+	sz =3D RTE_ALIGN_CEIL(sz, alignof(typeof(*mt)));
+	return sz;
+}
+
+static inline size_t
+memchunk_meta_size(uint32_t nb_obj)
+{
+	size_t sz;
+	static const struct memchunk *ch;
+
+	sz =3D sizeof(*ch) +  nb_obj * sizeof(ch->free[0]);
+	sz =3D RTE_ALIGN_CEIL(sz, alignof(typeof(*ch)));
+	return sz;
+}
+
+static inline size_t
+memobj_size(uint32_t obj_size, uint32_t obj_align)
+{
+	size_t sz;
+	static const struct memobj *obj;
+
+	sz =3D sizeof(*obj) + obj_size;
+	sz =3D RTE_ALIGN_CEIL(sz, obj_align);
+	return sz;
+}
+
+static inline size_t
+memchunk_size(uint32_t nb_obj, uint32_t obj_size, uint32_t obj_align)
+{
+	size_t algn, sz;
+	static const struct memchunk *ch;
+
+	algn =3D RTE_MAX(alignof(typeof(*ch)), obj_align);
+	sz =3D memchunk_meta_size(nb_obj);
+	sz +=3D nb_obj * memobj_size(obj_size, obj_align);
+	sz =3D RTE_ALIGN_CEIL(sz + algn - 1, algn);
+	return sz;
+}
+
+static void
+init_chunk(struct rte_memtank *mt, struct memchunk *ch)
+{
+	uint32_t i, n, sz;
+	uintptr_t p;
+	struct memobj *obj;
+
+	const struct memobj cobj =3D {
+		.red_zone1 =3D RED_ZONE_V1,
+		.chunk =3D ch,
+		.red_zone2 =3D RED_ZONE_V2,
+	};
+
+	n =3D mt->prm.nb_obj_chunk;
+	sz =3D mt->obj_size;
+
+	/* get start of memobj array */
+	p =3D (uintptr_t)ch + memchunk_meta_size(n);
+	p =3D RTE_ALIGN_CEIL(p, mt->prm.obj_align);
+
+	for (i =3D 0; i !=3D n; i++) {
+		obj =3D obj_pub_full(p, sz);
+		obj[0] =3D cobj;
+		ch->free[i] =3D (void *)p;
+		p +=3D sz;
+	}
+
+	ch->nb_total =3D n;
+	ch->nb_free =3D n;
+
+	if (mt->prm.init !=3D NULL)
+		mt->prm.init(ch->free, n, mt->prm.udata);
+}
+
+static __rte_always_inline void
+copy_objs(void *dst[], void * const src[], uint32_t num)
+{
+	memcpy(dst, src, num * sizeof(dst[0]));
+}
+
+static inline uint32_t
+get_free(struct memtank_free *t, void *obj[], uint32_t num)
+{
+	uint32_t len, n;
+
+	rte_spinlock_lock(&t->lock);
+
+	len =3D t->nb_free;
+	n =3D RTE_MIN(num, len);
+	len -=3D n;
+	copy_objs(obj, t->free + len, n);
+	t->nb_free =3D len;
+
+	rte_spinlock_unlock(&t->lock);
+	return n;
+}
+
+static inline uint32_t
+put_free(struct memtank_free *t, void * const obj[], uint32_t num)
+{
+	uint32_t len, n;
+
+	rte_spinlock_lock(&t->lock);
+
+	len =3D t->nb_free;
+	n =3D t->max_free - len;
+	n =3D RTE_MIN(num, n);
+	copy_objs(t->free + len, obj, n);
+	t->nb_free =3D len + n;
+
+	rte_spinlock_unlock(&t->lock);
+	return n;
+}
+
+static inline void
+fill_free(struct rte_memtank *mt, uint32_t num, uint32_t flags)
+{
+	uint32_t i, l, k, n;
+	void *free[MEMTANK_OBJ_BULK];
+
+	for (i =3D 0; i !=3D num; i +=3D n) {
+		/* how many objects we need to add into @free */
+		n =3D RTE_MIN(num - i, RTE_DIM(free));
+		k =3D rte_memtank_chunk_alloc(mt, free, n, flags);
+		l =3D put_free(&mt->mtf, free, k);
+
+		/* @free is full, return allocated objects back to chunks */
+		if (l !=3D k)
+			rte_memtank_chunk_free(mt, free + l, k - l, 0);
+
+		/* either free is full, or chunks are empty */
+		if (l !=3D n)
+			break;
+	}
+}
+
+static void
+put_chunk(struct rte_memtank *mt, struct memchunk *ch, void * const obj[],
+	uint32_t num)
+{
+	uint32_t k, n;
+	struct mchunk_list *ls;
+
+	/* chunk should be in the *used* list */
+	k =3D MC_USED;
+	ls =3D &mt->chl[k];
+	rte_spinlock_lock(&ls->lock);
+
+	n =3D ch->nb_free;
+	RTE_ASSERT(n + num <=3D ch->nb_total);
+
+	copy_objs(ch->free + n, obj, num);
+	ch->nb_free =3D n + num;
+
+	/* chunk is full now */
+	if (ch->nb_free =3D=3D ch->nb_total) {
+		TAILQ_REMOVE(&ls->chunk, ch, link);
+		k =3D MC_FULL;
+	/* chunk is not empty anymore, move it to the head */
+	} else if (n =3D=3D 0) {
+		TAILQ_REMOVE(&ls->chunk, ch, link);
+		TAILQ_INSERT_HEAD(&ls->chunk, ch, link);
+	}
+
+	rte_spinlock_unlock(&ls->lock);
+
+	/* insert this chunk into the *full* list */
+	if (k =3D=3D MC_FULL) {
+		ls =3D &mt->chl[k];
+		rte_spinlock_lock(&ls->lock);
+		TAILQ_INSERT_HEAD(&ls->chunk, ch, link);
+		rte_spinlock_unlock(&ls->lock);
+	}
+}
+
+static inline uint32_t
+_shrink_chunk(struct rte_memtank *mt, struct memchunk *ch[MEMTANK_CHUNK_BU=
LK],
+	uint32_t num)
+{
+	uint32_t i, k;
+	struct mchunk_list *ls;
+
+	ls =3D &mt->chl[MC_FULL];
+	rte_spinlock_lock(&ls->lock);
+
+	for (k =3D 0; k !=3D num; k++) {
+		ch[k] =3D TAILQ_LAST(&ls->chunk, mchunk_head);
+		if (ch[k] =3D=3D NULL)
+			break;
+		TAILQ_REMOVE(&ls->chunk, ch[k], link);
+	}
+
+	rte_spinlock_unlock(&ls->lock);
+
+	rte_atomic_fetch_sub_explicit(&mt->nb_chunks, k,
+		rte_memory_order_acq_rel);
+
+	for (i =3D 0; i !=3D k; i++)
+		mt->prm.free(ch[i]->raw, mt->prm.udata);
+
+	return k;
+}
+
+
+static uint32_t
+shrink_chunk(struct rte_memtank *mt, uint32_t num)
+{
+	uint32_t i, k, n;
+	struct memchunk *ch[MEMTANK_CHUNK_BULK];
+
+	k =3D 0;
+	n =3D 0;
+	for (i =3D 0; i !=3D num && n !=3D k; i +=3D k) {
+		n =3D RTE_MIN(num - i, RTE_DIM(ch));
+		k =3D _shrink_chunk(mt, ch, n);
+	}
+
+	return i;
+}
+
+static struct memchunk *
+alloc_chunk(struct rte_memtank *mt)
+{
+	void *p;
+	struct memchunk *ch;
+
+	p =3D mt->prm.alloc(mt->chunk_size, mt->prm.udata);
+	if (p =3D=3D NULL)
+		return NULL;
+	ch =3D RTE_PTR_ALIGN_CEIL(p, alignof(typeof(*ch)));
+	ch->raw =3D p;
+	return ch;
+}
+
+/* Determine by how many chunks we can actually grow */
+static inline uint32_t
+grow_num(struct rte_memtank *mt, uint32_t num)
+{
+	uint32_t k, n, max;
+
+	max =3D mt->max_chunk;
+	n =3D num + rte_atomic_fetch_add_explicit(&mt->nb_chunks, num,
+			rte_memory_order_acq_rel);
+
+	if (n <=3D max)
+		return num;
+
+	k =3D n - max;
+	return (k >=3D num) ? 0 : num - k;
+}
+
+static uint32_t
+grow_chunk(struct rte_memtank *mt, uint32_t num)
+{
+	uint32_t k, n;
+	struct mchunk_list *fls;
+	struct mchunk_head ls;
+	struct memchunk *ch;
+
+	/* check can we grow further */
+	k =3D grow_num(mt, num);
+
+	TAILQ_INIT(&ls);
+
+	for (n =3D 0; n !=3D k; n++) {
+		ch =3D alloc_chunk(mt);
+		if (ch =3D=3D NULL)
+			break;
+		init_chunk(mt, ch);
+		TAILQ_INSERT_HEAD(&ls, ch, link);
+	}
+
+	if (n !=3D 0) {
+		fls =3D &mt->chl[MC_FULL];
+		rte_spinlock_lock(&fls->lock);
+		TAILQ_CONCAT(&fls->chunk, &ls, link);
+		rte_spinlock_unlock(&fls->lock);
+	}
+
+	if (n !=3D num)
+		rte_atomic_fetch_sub_explicit(&mt->nb_chunks, num - n,
+			rte_memory_order_acq_rel);
+
+	return n;
+}
+
+static void
+obj_dbg_alloc(struct rte_memtank *mt, void * const obj[], uint32_t nb_obj)
+{
+	uint32_t i, sz;
+	struct memobj *po;
+
+	sz =3D mt->obj_size;
+	for (i =3D 0; i !=3D nb_obj; i++) {
+		po =3D obj_pub_full((uintptr_t)obj[i], sz);
+		RTE_VERIFY(memobj_verify(po, 0) =3D=3D 0);
+		po->dbg.nb_alloc++;
+	}
+}
+
+static void
+obj_dbg_free(struct rte_memtank *mt, void * const obj[], uint32_t nb_obj)
+{
+	uint32_t i, sz;
+	struct memobj *po;
+
+	sz =3D mt->obj_size;
+	for (i =3D 0; i !=3D nb_obj; i++) {
+		po =3D obj_pub_full((uintptr_t)obj[i], sz);
+		RTE_VERIFY(memobj_verify(po, 1) =3D=3D 0);
+		po->dbg.nb_free++;
+	}
+}
+
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_memtank_chunk_free, 26.11)
+void
+rte_memtank_chunk_free(struct rte_memtank *mt, void * const obj[],
+	uint32_t nb_obj, uint32_t flags)
+{
+	size_t csz;
+	uint32_t i, j, k, osz;
+	struct memobj *mo;
+	struct memchunk *ch;
+
+	csz =3D mt->chunk_size;
+	osz =3D mt->obj_size;
+
+	if (mt->flags & RTE_MTANK_OBJ_DBG)
+		obj_dbg_free(mt, obj, nb_obj);
+
+	k =3D 0;
+	for (i =3D 0; i !=3D nb_obj; i =3D j) {
+
+		mo =3D obj_pub_full((uintptr_t)obj[i], osz);
+		ch =3D mo->chunk;
+
+		/* find number of consequtive objs from the same chunk */
+		for (j =3D i + 1; j !=3D nb_obj; j++) {
+			if (obj_check_chunk((uintptr_t)obj[j], osz,
+					(uintptr_t)ch, csz) !=3D 0)
+				break;
+			RTE_ASSERT(ch =3D=3D
+				obj_pub_full((uintptr_t)obj[j], osz)->chunk);
+		}
+
+		put_chunk(mt, ch, obj + i, j - i);
+		k++;
+	}
+
+	if (flags & RTE_MTANK_FREE_SHRINK)
+		shrink_chunk(mt, k);
+}
+
+static uint32_t
+get_chunk(struct mchunk_list *ls, struct mchunk_head *els,
+	struct mchunk_head *uls, void *obj[], uint32_t nb_obj)
+{
+	uint32_t l, k, n;
+	struct memchunk *ch, *nch;
+
+	rte_spinlock_lock(&ls->lock);
+
+	n =3D 0;
+	for (ch =3D TAILQ_FIRST(&ls->chunk);
+			n !=3D nb_obj && ch !=3D NULL && ch->nb_free !=3D 0;
+			ch =3D nch, n +=3D k) {
+
+		k =3D RTE_MIN(nb_obj - n, ch->nb_free);
+		l =3D ch->nb_free - k;
+		copy_objs(obj + n, ch->free + l, k);
+		ch->nb_free =3D l;
+
+		nch =3D TAILQ_NEXT(ch, link);
+
+		/* chunk is empty now */
+		if (l =3D=3D 0) {
+			TAILQ_REMOVE(&ls->chunk, ch, link);
+			TAILQ_INSERT_TAIL(els, ch, link);
+		} else if (uls !=3D NULL) {
+			TAILQ_REMOVE(&ls->chunk, ch, link);
+			TAILQ_INSERT_HEAD(uls, ch, link);
+		}
+	}
+
+	rte_spinlock_unlock(&ls->lock);
+	return n;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_memtank_chunk_alloc, 26.11)
+uint32_t
+rte_memtank_chunk_alloc(struct rte_memtank *mt, void *obj[], uint32_t nb_o=
bj,
+	uint32_t flags)
+{
+	uint32_t k, n;
+	struct mchunk_head els, uls;
+
+	/* walk though the *used* list first */
+	n =3D get_chunk(&mt->chl[MC_USED], &mt->chl[MC_USED].chunk, NULL,
+		obj, nb_obj);
+
+	if (n !=3D nb_obj) {
+
+		TAILQ_INIT(&els);
+		TAILQ_INIT(&uls);
+
+		/* walk though the *full* list */
+		n +=3D get_chunk(&mt->chl[MC_FULL], &els, &uls,
+			obj + n, nb_obj - n);
+
+		if (n !=3D nb_obj && (flags & RTE_MTANK_ALLOC_GROW) !=3D 0) {
+
+			/*
+			 * try to allocate extra memchunks.
+			 * note that at rare situations with really high load
+			 * when number of allocated chunks is close to the
+			 * max allowed limit, when multiple threads are
+			 * trying to do grow_chunk() simultaneously, it
+			 * can fail for some of them leading to a failure
+			 * to allocate new elements.
+			 */
+			k =3D ALIGN_MUL_CEIL(nb_obj - n,
+				mt->prm.nb_obj_chunk);
+			k =3D grow_chunk(mt, k);
+
+			/* walk through the *full* list again */
+			if (k !=3D 0)
+				n +=3D get_chunk(&mt->chl[MC_FULL], &els, &uls,
+					obj + n, nb_obj - n);
+		}
+
+		/* concatenate with *used* list our temporary lists */
+		rte_spinlock_lock(&mt->chl[MC_USED].lock);
+
+		/* put new non-emtpy elems at head of the *used* list */
+		TAILQ_CONCAT(&uls, &mt->chl[MC_USED].chunk, link);
+		TAILQ_CONCAT(&mt->chl[MC_USED].chunk, &uls, link);
+
+		/* put new emtpy elems at tail of the *used* list */
+		TAILQ_CONCAT(&mt->chl[MC_USED].chunk, &els, link);
+
+		rte_spinlock_unlock(&mt->chl[MC_USED].lock);
+	}
+
+	if (mt->flags & RTE_MTANK_OBJ_DBG)
+		obj_dbg_alloc(mt, obj, n);
+
+	return n;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_memtank_grow, 26.11)
+int
+rte_memtank_grow(struct rte_memtank *mt)
+{
+	uint32_t k, n, num;
+	struct memtank_free *t;
+
+	t =3D &mt->mtf;
+
+	/* how many chunks we need to grow */
+	k =3D t->min_free - t->nb_free;
+	if ((int32_t)k <=3D 0)
+		return 0;
+
+	num =3D ALIGN_MUL_CEIL(k, mt->prm.nb_obj_chunk);
+
+	/* try to grow and refill the *free* */
+	n =3D grow_chunk(mt, num);
+	if (n !=3D 0)
+		fill_free(mt, k, 0);
+
+	return n;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_memtank_shrink, 26.11)
+int
+rte_memtank_shrink(struct rte_memtank *mt)
+{
+	uint32_t n;
+	struct memtank_free *t;
+
+	t =3D &mt->mtf;
+
+	/* how many chunks we need to shrink */
+	if (t->nb_free < t->max_free)
+		return 0;
+
+	/* how many chunks we need to free */
+	n =3D ALIGN_MUL_CEIL(t->min_free, mt->prm.nb_obj_chunk);
+
+	/* free up to *num* chunks */
+	return shrink_chunk(mt, n);
+}
+
+static int
+check_param(const struct rte_memtank_prm *prm)
+{
+	if (prm->alloc =3D=3D NULL || prm->free =3D=3D NULL ||
+			prm->min_free > prm->max_free ||
+			prm->max_free > prm->max_obj ||
+			rte_is_power_of_2(prm->obj_align) =3D=3D 0 ||
+			prm->min_free =3D=3D 0 ||
+			prm->nb_obj_chunk =3D=3D 0)
+		return -EINVAL;
+	return 0;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_memtank_create, 26.11)
+struct rte_memtank *
+rte_memtank_create(const struct rte_memtank_prm *prm)
+{
+	int32_t rc;
+	size_t sz;
+	void *p;
+	struct rte_memtank *mt;
+
+	rc =3D check_param(prm);
+	if (rc !=3D 0) {
+		rte_errno =3D -rc;
+		return NULL;
+	}
+
+	sz =3D memtank_meta_size(prm->max_free);
+	p =3D prm->alloc(sz, prm->udata);
+	if (p =3D=3D NULL) {
+		rte_errno =3D ENOMEM;
+		return NULL;
+	}
+
+	mt =3D RTE_PTR_ALIGN_CEIL(p, alignof(typeof(*mt)));
+
+	memset(mt, 0, sizeof(*mt));
+	mt->prm =3D *prm;
+
+	mt->raw =3D p;
+	mt->chunk_size =3D memchunk_size(prm->nb_obj_chunk, prm->obj_size,
+		prm->obj_align);
+	mt->obj_size =3D memobj_size(prm->obj_size, prm->obj_align);
+	mt->max_chunk =3D ALIGN_MUL_CEIL(prm->max_obj, prm->nb_obj_chunk);
+	mt->flags =3D prm->flags;
+
+	mt->mtf.min_free =3D prm->min_free;
+	mt->mtf.max_free =3D prm->max_free;
+
+	TAILQ_INIT(&mt->chl[MC_FULL].chunk);
+	TAILQ_INIT(&mt->chl[MC_USED].chunk);
+
+	return mt;
+}
+
+static void
+free_mchunk_list(struct rte_memtank *mt, struct mchunk_list *ls)
+{
+	struct memchunk *ch;
+
+	for (ch =3D TAILQ_FIRST(&ls->chunk); ch !=3D NULL;
+			ch =3D TAILQ_FIRST(&ls->chunk)) {
+		TAILQ_REMOVE(&ls->chunk, ch, link);
+		mt->prm.free(ch->raw, mt->prm.udata);
+	}
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_memtank_destroy, 26.11)
+void
+rte_memtank_destroy(struct rte_memtank *mt)
+{
+	if (mt !=3D NULL) {
+		free_mchunk_list(mt, &mt->chl[MC_FULL]);
+		free_mchunk_list(mt, &mt->chl[MC_USED]);
+		mt->prm.free(mt->raw, mt->prm.udata);
+	}
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_memtank_alloc, 26.11)
+uint32_t
+rte_memtank_alloc(struct rte_memtank *mt, void *obj[], uint32_t num,
+	uint32_t flags)
+{
+	uint32_t n;
+	struct memtank_free *t;
+
+	t =3D &mt->mtf;
+	n =3D get_free(t, obj, num);
+
+	/* not enough free objects, try to allocate via memchunks */
+	if (n !=3D num && flags !=3D 0) {
+		n +=3D rte_memtank_chunk_alloc(mt, obj + n, num - n, flags);
+
+		/* refill *free* tank */
+		if (n =3D=3D num)
+			fill_free(mt, t->min_free, flags);
+	}
+
+	return n;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_memtank_free, 26.11)
+void
+rte_memtank_free(struct rte_memtank *t, void * const obj[], uint32_t num,
+	uint32_t flags)
+{
+	uint32_t n;
+
+	n =3D put_free(&t->mtf, obj, num);
+	if (n !=3D num)
+		rte_memtank_chunk_free(t, obj + n, num - n, flags);
+}
diff --git a/lib/memtank/memtank.h b/lib/memtank/memtank.h
new file mode 100644
index 0000000000..872f2f7def
--- /dev/null
+++ b/lib/memtank/memtank.h
@@ -0,0 +1,110 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2019 Intel Corporation
+ * Copyright(c) 2025 Huawei Technologies Co., Ltd
+ */
+
+#ifndef	_MEMTANK_H_
+#define	_MEMTANK_H_
+
+#include <rte_memtank.h>
+#include <rte_atomic.h>
+#include <rte_spinlock.h>
+#include <rte_log.h>
+#include <stdalign.h>
+#include <errno.h>
+
+extern int memtank_logtype;
+#define RTE_LOGTYPE_MTANK memtank_logtype
+#define MTANK_LOG(level, ...) \
+	 RTE_LOG_LINE(level, MTANK, "" __VA_ARGS__)
+
+struct memobj {
+	uint64_t red_zone1;
+	struct memchunk *chunk; /* ptr to the chunk it belongs to */
+	struct {
+		uint32_t nb_alloc;
+		uint32_t nb_free;
+	} dbg;
+	uint64_t red_zone2;
+};
+
+#define RED_ZONE_V1	UINT64_C(0xBADECAFEBADECAFE)
+#define RED_ZONE_V2	UINT64_C(0xDEADBEEFDEADBEEF)
+
+struct memchunk {
+	TAILQ_ENTRY(memchunk) link;  /* link to the next chunk in the tank */
+	void *raw;		     /* un-aligned ptr returned by alloc() */
+	uint32_t nb_total;           /* total number of objects in the chunk */
+	uint32_t nb_free;            /* number of free object in the chunk */
+	void *free[];                /* array of free objects */
+} __rte_cache_aligned;
+
+
+TAILQ_HEAD(mchunk_head, memchunk);
+
+struct mchunk_list {
+	rte_spinlock_t lock;
+	struct mchunk_head chunk;  /* list of chunks */
+} __rte_cache_aligned;
+
+enum {
+	MC_FULL,  /* all memchunk objs are free */
+	MC_USED,  /* some of memchunk objs are allocated */
+	MC_NUM,
+};
+
+struct memtank_free {
+	rte_spinlock_t lock;
+	uint32_t min_free;
+	uint32_t max_free;
+	uint32_t nb_free;
+	void *free[];
+} __rte_cache_aligned;
+
+struct rte_memtank {
+	/* user provided data */
+	struct rte_memtank_prm prm;
+
+	/*run-time data */
+	void *raw;		        /* un-aligned ptr returned by alloc() */
+	size_t chunk_size;              /* full size of each memchunk */
+	uint32_t obj_size;	        /* full size of each memobj */
+	uint32_t max_chunk;             /* max allowed number of chunks */
+	uint32_t flags;                 /* behavior flags */
+	RTE_ATOMIC(uint32_t) nb_chunks; /* number of allocated chunks */
+	struct mchunk_list chl[MC_NUM]; /* lists of memchunks */
+	struct memtank_free mtf;        /* cached free objects */
+};
+
+/**
+ * Obtain pointer to internal memobj struct from public one
+ */
+static inline struct memobj *
+obj_pub_full(uintptr_t p, uint32_t obj_sz)
+{
+	uintptr_t v;
+
+	v =3D p + obj_sz - sizeof(struct memobj);
+	return (struct memobj *)v;
+}
+
+/**
+ * Fast check: does given object belongs to that memchunk.
+ * Returns zero, if object is within the chunk, non-zero value otherwise.
+ */
+static inline int
+obj_check_chunk(uintptr_t obj, size_t obj_sz, uintptr_t chn, size_t chn_sz)
+{
+	return (obj <=3D chn || obj + obj_sz > chn + chn_sz);
+}
+
+static inline int
+memobj_verify(const struct memobj *mo, uint32_t finc)
+{
+	if (mo->red_zone1 !=3D RED_ZONE_V1 || mo->red_zone2 !=3D RED_ZONE_V2 ||
+			mo->dbg.nb_alloc !=3D mo->dbg.nb_free + finc)
+		return -EINVAL;
+	return 0;
+}
+
+#endif	/* _MEMTANK_H_ */
diff --git a/lib/memtank/meson.build b/lib/memtank/meson.build
new file mode 100644
index 0000000000..a4c54c09bd
--- /dev/null
+++ b/lib/memtank/meson.build
@@ -0,0 +1,18 @@
+# SPDX-License-Identifier: BSD-3-Clause
+# Copyright(c) 2017 Intel Corporation
+
+extra_flags =3D []
+
+foreach flag: extra_flags
+    if cc.has_argument(flag)
+        cflags +=3D flag
+    endif
+endforeach
+
+sources =3D files('memtank.c',
+       'misc.c',
+)
+headers =3D files(
+        'rte_memtank.h',
+)
+deps +=3D ['ring', 'telemetry']
diff --git a/lib/memtank/misc.c b/lib/memtank/misc.c
new file mode 100644
index 0000000000..526bbbbcf1
--- /dev/null
+++ b/lib/memtank/misc.c
@@ -0,0 +1,375 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2019 Intel Corporation
+ * Copyright(c) 2025 Huawei Technologies Co., Ltd
+ */
+
+#include "memtank.h"
+#include <inttypes.h>
+#include <stdlib.h>
+#include <eal_export.h>
+
+#define CHUNK_OBJ_LT_NUM	4
+
+struct mchunk_stat {
+	uint32_t nb_empty;
+	uint32_t nb_full;
+	struct {
+		uint32_t nb_chunk;
+		uint32_t nb_obj;
+		struct {
+			uint32_t val;
+			uint32_t num;
+		} chunk_obj_lt[CHUNK_OBJ_LT_NUM];
+	} used;
+};
+
+struct mfree_stat {
+	uint32_t nb_chunk;
+	struct mchunk_stat chunk;
+};
+
+RTE_LOG_REGISTER_DEFAULT(memtank_logtype, INFO);
+
+static void
+mchunk_stat_dump(FILE *f, const struct mchunk_stat *st)
+{
+	uint32_t i;
+
+	fprintf(f, "\t\tstat=3D{\n");
+	fprintf(f, "\t\t\tnb_empty=3D%u,\n", st->nb_empty);
+	fprintf(f, "\t\t\tnb_full=3D%u,\n", st->nb_full);
+	fprintf(f, "\t\t\tused=3D{\n");
+	fprintf(f, "\t\t\t\tnb_chunk=3D%u,\n", st->used.nb_chunk);
+	fprintf(f, "\t\t\t\tnb_obj=3D%u,\n", st->used.nb_obj);
+
+	for (i =3D 0; i !=3D RTE_DIM(st->used.chunk_obj_lt); i++) {
+		if (st->used.chunk_obj_lt[i].num !=3D 0)
+			fprintf(f, "\t\t\t\tnb_chunk_obj_lt_%u=3D%u,\n",
+				st->used.chunk_obj_lt[i].val,
+				st->used.chunk_obj_lt[i].num);
+	}
+
+	fprintf(f, "\t\t\t},\n");
+	fprintf(f, "\t\t},\n");
+}
+
+static void
+mchunk_stat_init(struct mchunk_stat *st, uint32_t nb_obj_chunk)
+{
+	uint32_t i;
+
+	memset(st, 0, sizeof(*st));
+	for (i =3D 0; i !=3D RTE_DIM(st->used.chunk_obj_lt); i++) {
+		st->used.chunk_obj_lt[i].val =3D (i + 1) * nb_obj_chunk /
+			RTE_DIM(st->used.chunk_obj_lt);
+	}
+}
+
+static void
+mchunk_stat_collect(struct mchunk_stat *st, const struct memchunk *ch)
+{
+	uint32_t i, n;
+
+	n =3D ch->nb_total - ch->nb_free;
+
+	if (ch->nb_free =3D=3D 0)
+		st->nb_empty++;
+	else if (n =3D=3D 0)
+		st->nb_full++;
+	else {
+		st->used.nb_chunk++;
+		st->used.nb_obj +=3D n;
+
+		for (i =3D 0; i !=3D RTE_DIM(st->used.chunk_obj_lt); i++) {
+			if (n < st->used.chunk_obj_lt[i].val) {
+				st->used.chunk_obj_lt[i].num++;
+				break;
+			}
+		}
+	}
+}
+
+static void
+mchunk_list_dump(FILE *f, struct rte_memtank *mt, uint32_t idx, uint32_t f=
lags)
+{
+	struct mchunk_list *ls;
+	const struct memchunk *ch;
+	struct mchunk_stat mcs;
+
+	ls =3D &mt->chl[idx];
+	mchunk_stat_init(&mcs, mt->prm.nb_obj_chunk);
+
+	rte_spinlock_lock(&ls->lock);
+
+	for (ch =3D TAILQ_FIRST(&ls->chunk); ch !=3D NULL;
+			ch =3D TAILQ_NEXT(ch, link)) {
+
+		/* collect chunk stats */
+		if (flags & RTE_MTANK_DUMP_CHUNK_STAT)
+			mchunk_stat_collect(&mcs, ch);
+
+		/* dump chunk metadata */
+		if (flags & RTE_MTANK_DUMP_CHUNK) {
+			fprintf(f, "\t\tmemchunk@%p=3D{\n", ch);
+			fprintf(f, "\t\t\traw=3D%p,\n", ch->raw);
+			fprintf(f, "\t\t\tnb_total=3D%u,\n", ch->nb_total);
+			fprintf(f, "\t\t\tnb_free=3D%u,\n", ch->nb_free);
+			fprintf(f, "\t\t},\n");
+		}
+	}
+
+	rte_spinlock_unlock(&ls->lock);
+
+	/* print chunk stats */
+	if (flags & RTE_MTANK_DUMP_CHUNK_STAT)
+		mchunk_stat_dump(f, &mcs);
+}
+
+static void
+mfree_stat_init(struct mfree_stat *st, uint32_t nb_obj_chunk)
+{
+	st->nb_chunk =3D 0;
+	mchunk_stat_init(&st->chunk, nb_obj_chunk);
+}
+
+static int
+ptr_cmp(const void *p1, const void *p2)
+{
+	uintptr_t rc, v1, v2;
+
+	v1 =3D *(const uintptr_t *)p1;
+	v2 =3D *(const uintptr_t *)p2;
+	rc =3D v1 - v2;
+	return (rc > v1) ? -1 : ((rc > 0) ? 1 : 0);
+}
+
+static void
+mfree_stat_collect(struct mfree_stat *st, struct rte_memtank *mt)
+{
+	uint32_t i, j, n, sz;
+	uintptr_t *p;
+	const struct memobj *mo;
+
+	sz =3D mt->obj_size;
+
+	p =3D malloc(mt->mtf.max_free * sizeof(*p));
+	if (p =3D=3D NULL)
+		return;
+
+	/**
+	 * grab free lock and keep it till we analyze related memchunks,
+	 * to make sure none of these memchunks will be freed until
+	 * we are finished.
+	 */
+	rte_spinlock_lock(&mt->mtf.lock);
+
+	/* collect chunks for all objects in free[] */
+	n =3D mt->mtf.nb_free;
+	memcpy(p, mt->mtf.free, n * sizeof(*p));
+	for (i =3D 0; i !=3D n; i++) {
+		mo =3D obj_pub_full(p[i], sz);
+		p[i] =3D (uintptr_t)mo->chunk;
+	}
+
+	/* sort chunk pointers */
+	qsort(p, n, sizeof(*p), ptr_cmp);
+
+	/* for each chunk collect stats */
+	for (i =3D 0; i !=3D n; i =3D j) {
+
+		RTE_ASSERT(st->nb_chunk < mt->max_chunk);
+		st->nb_chunk++;
+		mchunk_stat_collect(&st->chunk, (const struct memchunk *)p[i]);
+		for (j =3D i + 1; j !=3D n && p[i] =3D=3D p[j]; j++)
+			;
+	}
+
+	rte_spinlock_unlock(&mt->mtf.lock);
+	free(p);
+}
+
+static void
+mfree_stat_dump(FILE *f, const struct mfree_stat *st)
+{
+	fprintf(f, "\tfree_stat=3D{\n");
+	fprintf(f, "\t\tnb_chunk=3D%u,\n", st->nb_chunk);
+	mchunk_stat_dump(f, &st->chunk);
+	fprintf(f, "\t},\n");
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_memtank_dump, 26.11)
+void
+rte_memtank_dump(FILE *f, struct rte_memtank *mt, uint32_t flags)
+{
+	uint32_t n;
+
+	if (f =3D=3D NULL || mt =3D=3D NULL)
+		return;
+
+	fprintf(f, "rte_memtank@%p=3D{\n", mt);
+	fprintf(f, "\tmin_free=3D%u,\n", mt->mtf.min_free);
+	fprintf(f, "\tmax_free=3D%u,\n", mt->mtf.max_free);
+	fprintf(f, "\tnb_free=3D%u,\n", mt->mtf.nb_free);
+	fprintf(f, "\tchunk_size=3D%zu,\n", mt->chunk_size);
+	fprintf(f, "\tobj_size=3D%u,\n", mt->obj_size);
+	fprintf(f, "\tmax_chunk=3D%u,\n", mt->max_chunk);
+	fprintf(f, "\tflags=3D%#x,\n", mt->flags);
+	n =3D rte_atomic_load_explicit(&mt->nb_chunks, rte_memory_order_relaxed);
+	fprintf(f, "\tnb_chunks=3D%u,\n", n);
+
+	if (flags & RTE_MTANK_DUMP_FREE_STAT) {
+		struct mfree_stat mfs;
+		mfree_stat_init(&mfs, mt->prm.nb_obj_chunk);
+		mfree_stat_collect(&mfs, mt);
+		mfree_stat_dump(f, &mfs);
+	}
+
+	if (flags & (RTE_MTANK_DUMP_CHUNK | RTE_MTANK_DUMP_CHUNK_STAT)) {
+
+		fprintf(f, "\t[FULL]=3D{\n");
+		mchunk_list_dump(f, mt, MC_FULL, flags);
+		fprintf(f, "\t},\n");
+
+		fprintf(f, "\t[USED]=3D{,\n");
+		mchunk_list_dump(f, mt, MC_USED, flags);
+		fprintf(f, "\t},\n");
+	}
+	fprintf(f, "};\n");
+}
+
+static int
+mobj_bulk_check(const char *fname, const struct rte_memtank *mt,
+	const uintptr_t p[], uint32_t num, uint32_t fmsk)
+{
+	int32_t ret;
+	uintptr_t align;
+	uint32_t i, k, sz;
+	const struct memobj *mo;
+
+	k =3D ((mt->flags & RTE_MTANK_OBJ_DBG) !=3D 0) & fmsk;
+	sz =3D mt->obj_size;
+	align =3D mt->prm.obj_align - 1;
+
+	ret =3D 0;
+	for (i =3D 0; i !=3D num; i++) {
+
+		if (p[i] =3D=3D (uintptr_t)NULL) {
+			ret--;
+			MTANK_LOG(ERR,
+				"%s(mt=3D%p, %p[%u]): NULL object",
+				fname, mt, p, i);
+		} else if ((p[i] & align) !=3D 0) {
+			ret--;
+			MTANK_LOG(ERR,
+				"%s(mt=3D%p, %p[%u]): object %#zx violates "
+				"expected alignment %#zx",
+				fname, mt, p, i, p[i], align);
+		} else {
+			mo =3D obj_pub_full(p[i], sz);
+			if (memobj_verify(mo, k) !=3D 0) {
+				ret--;
+				MTANK_LOG(ERR,
+					"%s(mt=3D%p, %p[%u]): "
+					"invalid object header @%#zx=3D{"
+					"red_zone1=3D%#" PRIx64 ","
+					"dbg=3D{nb_alloc=3D%u,nb_free=3D%u},"
+					"red_zone2=3D%#" PRIx64
+					"}",
+					fname, mt, p, i, p[i],
+					mo->red_zone1,
+					mo->dbg.nb_alloc, mo->dbg.nb_free,
+					mo->red_zone2);
+			}
+		}
+	}
+
+	return ret;
+}
+
+/* grab free lock and check objects in free[] */
+static int
+mfree_check(struct rte_memtank *mt)
+{
+	int32_t rc;
+
+	rte_spinlock_lock(&mt->mtf.lock);
+	rc =3D mobj_bulk_check(__func__, mt, (const uintptr_t *)mt->mtf.free,
+		mt->mtf.nb_free, 1);
+	rte_spinlock_unlock(&mt->mtf.lock);
+	return rc;
+}
+
+static int
+mchunk_check(const struct rte_memtank *mt, const struct memchunk *mc,
+	uint32_t tc)
+{
+	int32_t n, rc;
+
+	rc =3D 0;
+	n =3D mc->nb_total - mc->nb_free;
+
+	rc -=3D (mc->nb_total !=3D mt->prm.nb_obj_chunk);
+	rc -=3D (tc =3D=3D MC_FULL) ? (n !=3D 0) : (n <=3D 0);
+	rc -=3D (RTE_PTR_ALIGN_CEIL(mc->raw, alignof(typeof(*mc))) !=3D mc);
+
+	if (rc !=3D 0)
+		MTANK_LOG(ERR, "%s(mt=3D%p, tc=3D%u): invalid memchunk @%p=3D{"
+			"raw=3D%p, nb_total=3D%u, nb_free=3D%u}",
+			__func__, mt, tc, mc,
+			mc->raw, mc->nb_total, mc->nb_free);
+
+	rc +=3D mobj_bulk_check(__func__, mt, (const uintptr_t *)mc->free,
+		mc->nb_free, 0);
+	return rc;
+}
+
+static int
+mchunk_list_check(struct rte_memtank *mt, uint32_t tc, uint32_t *nb_chunk)
+{
+	int32_t rc;
+	uint32_t n;
+	struct mchunk_list *ls;
+	const struct memchunk *ch;
+
+	ls =3D &mt->chl[tc];
+	rte_spinlock_lock(&ls->lock);
+
+	rc =3D 0;
+	for (n =3D 0, ch =3D TAILQ_FIRST(&ls->chunk); ch !=3D NULL;
+			ch =3D TAILQ_NEXT(ch, link), n++)
+		rc +=3D mchunk_check(mt, ch, tc);
+
+	rte_spinlock_unlock(&ls->lock);
+
+	*nb_chunk =3D n;
+	return rc;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_memtank_sanity_check, 26.11)
+int
+rte_memtank_sanity_check(struct rte_memtank *mt, int32_t ct)
+{
+	int32_t rc;
+	uint32_t n, nf, nu;
+
+	rc =3D mfree_check(mt);
+
+	nf =3D 0;
+	nu =3D 0;
+	rc +=3D mchunk_list_check(mt, MC_FULL, &nf);
+	rc +=3D mchunk_list_check(mt, MC_USED, &nu);
+
+	/*
+	 * if some other threads concurently do alloc/free/grow/shrink
+	 * these numbers can still not match.
+	 */
+	n =3D rte_atomic_load_explicit(&mt->nb_chunks, rte_memory_order_relaxed);
+	if (nf + nu !=3D n && ct =3D=3D 0) {
+		MTANK_LOG(ERR,
+			"%s(mt=3D%p) nb_chunks: expected=3D%u, full=3D%u, used=3D%u",
+			__func__, mt, n, nf, nu);
+		rc--;
+	}
+
+	return rc;
+}
diff --git a/lib/memtank/rte_memtank.h b/lib/memtank/rte_memtank.h
new file mode 100644
index 0000000000..7359b39840
--- /dev/null
+++ b/lib/memtank/rte_memtank.h
@@ -0,0 +1,303 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2019 Intel Corporation
+ * Copyright(c) 2025 Huawei Technologies Co., Ltd
+ */
+
+#ifndef _RTE_MEMTANK_H_
+#define _RTE_MEMTANK_H_
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+#include <rte_common.h>
+#include <rte_compat.h>
+#include <stdio.h>
+
+/**
+ * @file
+ * RTE memtank
+ *
+ * Same a s mempool it allows to alloc/free objects of fixed size
+ * in a lightweight manner (probably not as lightweight as mempool,
+ * but hopefully close enough).
+ * But in addition it can grow/shrink dynamically plus provides extra
+ * additional API for higher flexibility:
+ *	- manual grow()/shrink() functions
+ *	- different alloc/free policies
+ *        (can be specified by user via flags parameter).
+ *
+ * Internally it consists of:
+ *	- LIFO queue (fast allocator/deallocator)
+ *	- lists of memchunks (USED, FREE).
+ *
+ * For performance reasons memtank tries to allocate memory in
+ * relatively big chunks (memchunks) and then split each memchunk
+ * in dozens (or hundreds) of objects.
+ * There are two thresholds:
+ *	- min_free (grow threshold)
+ *	- max_free (shrink threshold)
+ */
+
+struct rte_memtank;
+
+/** generic memtank behavior flags */
+enum {
+	/** Enable obj debugging */
+	RTE_MTANK_OBJ_DBG =3D 1,
+};
+
+struct rte_memtank_prm {
+	/** min number of free objs in the ring (grow threshold). */
+	uint32_t min_free;
+	uint32_t max_free;  /**< max number of free objs (empty threshold) */
+	uint32_t max_obj; /**< max number of objs (grow limit) */
+	uint32_t obj_size;  /**< size of each mem object */
+	uint32_t obj_align;  /**< alignment of each mem object */
+	uint32_t nb_obj_chunk; /**< number of objects per chunk */
+	uint32_t flags; /**< behavior flags */
+	/** user provided function to alloc chunk of memory */
+	void * (*alloc)(size_t len, void *udata);
+	/** user provided function to free chunk of memory */
+	void (*free)(void *mem, void *udata);
+	/** user provided function to initialiaze an object */
+	void (*init)(void *obj[], uint32_t num, void *udata);
+	void *udata;        /**< opaque user data for alloc/free/init */
+};
+
+/**
+ * @warning
+ * @b EXPERIMENTAL: this API may change without prior notice.
+ *
+ * Allocate and intitialize new memtank instance, based on the
+ * parameters provided. Note that it uses user-provided *alloc()* function
+ * to allocate space for the memtank metadata.
+ * @param prm
+ *   Parameters used to create and initialise new memtank.
+ * @return
+ *   - Pointer to new memtank insteance created, if operation completed
+ *     successfully.
+ *   - NULL on error with rte_errno set appropriately.
+ */
+__rte_experimental
+struct rte_memtank *
+rte_memtank_create(const struct rte_memtank_prm *prm);
+
+/**
+ * @warning
+ * @b EXPERIMENTAL: this API may change without prior notice.
+ *
+ * Destroy the memtank and free all memory referenced by the memtank.
+ * The objects must not be used by other cores as they will be freed.
+ *
+ * @param t
+ *   A pointer to the memtank instance.
+ */
+__rte_experimental
+void
+rte_memtank_destroy(struct rte_memtank *t);
+
+
+/** alloc flags */
+enum {
+	RTE_MTANK_ALLOC_CHUNK =3D 1,
+	/** Allocate extra memchunks if needed */
+	RTE_MTANK_ALLOC_GROW =3D 2,
+};
+
+/**
+ * @warning
+ * @b EXPERIMENTAL: this API may change without prior notice.
+ *
+ * Allocate up to requested number of objects from the memtank.
+ * Note that depending on *alloc* behavior (flags) some new memory chunks
+ * can be allocated from the underlying memory subsystem.
+ *
+ * @param t
+ *   A pointer to the memtank instance.
+ * @param obj
+ *   An array of void * pointers (objects) that will be filled.
+ * @param num
+ *   Number of objects to allocate from the memtank.
+ * @param flags
+ *   Flags that control allocation behavior.
+ * @return
+ *   Number of allocated objects.
+ */
+__rte_experimental
+uint32_t
+rte_memtank_alloc(struct rte_memtank *t, void *obj[], uint32_t num,
+		uint32_t flags);
+
+/**
+ * @warning
+ * @b EXPERIMENTAL: this API may change without prior notice.
+ *
+ * Allocate up to requested number of objects from the memtank.
+ * Note that this function bypasses *free* cache(s) and tries to allocate
+ * objects straight from the memory chunks.
+ * Note that depending on *alloc* behavior (flags) some new memory chunks
+ * can be allocated from the underlying memory subsystem.
+ *
+ * @param t
+ *   A pointer to the memtank instance.
+ * @param obj
+ *   An array of void * pointers (objects) that will be filled.
+ * @param nb_obj
+ *   Number of objects to allocate from the memtank.
+ * @param flags
+ *   Flags that control allocation behavior.
+ * @return
+ *   Number of allocated objects.
+ */
+__rte_experimental
+uint32_t
+rte_memtank_chunk_alloc(struct rte_memtank *t, void *obj[], uint32_t nb_ob=
j,
+		uint32_t flags);
+
+/** free flags */
+enum {
+	/** Free unneeded chunk of memory */
+	RTE_MTANK_FREE_SHRINK =3D 1,
+};
+
+/**
+ * @warning
+ * @b EXPERIMENTAL: this API may change without prior notice.
+ *
+ * Free (put) provided objects back to the memtank.
+ * Note that depending on *free* behavior (flags) some memory chunks can be
+ * returned (freed) to the underlying memory subsystem.
+ *
+ * @param t
+ *   A pointer to the memtank instance.
+ * @param obj
+ *   An array of object pointers to be freed.
+ * @param num
+ *   Number of objects to free.
+ * @param flags
+ *   Flags that control free behavior.
+ */
+__rte_experimental
+void
+rte_memtank_free(struct rte_memtank *t, void * const obj[],  uint32_t num,
+		uint32_t flags);
+
+/**
+ * @warning
+ * @b EXPERIMENTAL: this API may change without prior notice.
+ *
+ * Free (put) provided objects back to the memtank.
+ * Note that this function bypasses *free* cache(s) and tries to put
+ * objects straight to the memory chunks.
+ * Note that depending on *free* behavior (flags) some memory chunks can be
+ * returned (freed) to the underlying memory subsystem.
+ *
+ * @param t
+ *   A pointer to the memtank instance.
+ * @param obj
+ *   An array of object pointers to be freed.
+ * @param nb_obj
+ *   Number of objects to allocate from the memtank.
+ * @param flags
+ *   Flags that control allocation behavior.
+ */
+__rte_experimental
+void
+rte_memtank_chunk_free(struct rte_memtank *t, void * const obj[],
+		uint32_t nb_obj, uint32_t flags);
+
+/**
+ * @warning
+ * @b EXPERIMENTAL: this API may change without prior notice.
+ *
+ * Check does number of objects in *free* cache is below memtank grow
+ * threshold (min_free). If yes, then tries to allocate memory for new
+ * objects from the underlying memory subsystem.
+ *
+ * @param t
+ *   A pointer to the memtank instance.
+ * @return
+ *   Number of newly allocated memory chunks.
+ */
+__rte_experimental
+int
+rte_memtank_grow(struct rte_memtank *t);
+
+/**
+ * @warning
+ * @b EXPERIMENTAL: this API may change without prior notice.
+ *
+ * Check does number of objects in *free* cache have reached memtank shrink
+ * threshold (max_free). If yes, then tries to return excessive memory to
+ * the underlying memory subsystem.
+ *
+ * @param t
+ *   A pointer to the memtank instance.
+ * @return
+ *   Number of freed memory chunks.
+ */
+__rte_experimental
+int
+rte_memtank_shrink(struct rte_memtank *t);
+
+/** dump flags */
+enum {
+	RTE_MTANK_DUMP_FREE_STAT =3D 1,
+	RTE_MTANK_DUMP_CHUNK_STAT =3D 2,
+	RTE_MTANK_DUMP_CHUNK =3D 4,
+	/* first not used power of two */
+	RTE_MTANK_DUMP_END =3D 8,
+
+	/** dump all stats */
+	RTE_MTANK_DUMP_STAT =3D
+		(RTE_MTANK_DUMP_FREE_STAT | RTE_MTANK_DUMP_CHUNK_STAT),
+	/** dump everything */
+	RTE_MTANK_DUMP_ALL =3D RTE_MTANK_DUMP_END - 1,
+};
+
+/**
+ * @warning
+ * @b EXPERIMENTAL: this API may change without prior notice.
+ *
+ * Dump information about the memtank to the file.
+ * Note that depending of *flags* value it might cause some internal locks
+ * grabbing, and might affect performance of others threads that
+ * concurently use same memtank.
+ *
+ * @param f
+ *   A pinter to the file.
+ * @param t
+ *   A pointer to the memtank instance.
+ * @param flags
+ *   Flags that control dump behavior.
+ */
+__rte_experimental
+void
+rte_memtank_dump(FILE *f, struct rte_memtank *t, uint32_t flags);
+
+/**
+ * @warning
+ * @b EXPERIMENTAL: this API may change without prior notice.
+ *
+ * Check the consistency of the given memtank instance.
+ * Dumps error messages to the RTE log subsystem, if some inconsitency
+ * is detected.
+ *
+ * @param t
+ *   A pointer to the memtank instance.
+ * @param ct
+ *   Value greater then zero, if some other threads do concurently use
+ *   that memtank.
+ * @return
+ *   Zero on success, or negative value otherwise.
+ */
+__rte_experimental
+int
+rte_memtank_sanity_check(struct rte_memtank *t, int32_t ct);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* _RTE_MEMTANK_H_ */
diff --git a/lib/meson.build b/lib/meson.build
index af5c160cb8..3b13dfee6c 100644
--- a/lib/meson.build
+++ b/lib/meson.build
@@ -19,6 +19,7 @@ libraries =3D [
         'ring',
         'rcu', # rcu depends on ring
         'mempool',
+        'memtank',
         'mbuf',
         'net',
         'meter',
--=20
2.51.0

