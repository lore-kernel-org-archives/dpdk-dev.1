Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 371B1CD3439
	for <dpdk-dev@archiver.kernel.org>; Thu,  7 May 2026 15:00:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 16A5F4066B;
	Thu,  7 May 2026 17:00:01 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 51CFB40662;
 Thu,  7 May 2026 16:59:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778166000; x=1809702000;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=apXWrsqW3tlcpe6xh+Y4/H1h+7GfMVVkxf16uUTIuAI=;
 b=Wo+7hs5w5Dx8vZdcRwy9o3DlOSjmIUxRq+GzmjB76uRcza863NPKA9Fx
 4dwPtYnqn529syX0AHCvWI6y41VJ/12D8NB8DGi/XJ3DYbsxMkRVDWojW
 oPg53VdX1mQTCwMzRVTkGf9y0at3QDSTnAu7BzlcMi3of4yCqSRIBZzv7
 ELmPBhCTzenPkZkNhtyWnXfe7PKQFMCkGAjP2c/v7e8tPO9+txaZwN1Ex
 em0Ik4nJA1+U3lEy+5mVKIZP7YFHQfpiL2sNAG6fC4HiqXF2Vl0HaojAS
 TjifSoYbV2J104bqie2A0+EA9OlqSb6qXyhpTJ/m+/9/y3uns39INnwth w==;
X-CSE-ConnectionGUID: bb/duqN2Sy+pVsA5ClXVmg==
X-CSE-MsgGUID: lnfhWH5VSRKKjtiOPGZhIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11779"; a="82738157"
X-IronPort-AV: E=Sophos;i="6.23,221,1770624000"; d="scan'208";a="82738157"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 May 2026 07:59:59 -0700
X-CSE-ConnectionGUID: iq64SSddRkeM1gYOWFMpRw==
X-CSE-MsgGUID: LJFyktSMRYqpexpimSbsFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,221,1770624000"; d="scan'208";a="233818179"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa008.fm.intel.com with ESMTP; 07 May 2026 07:59:57 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>, stable@dpdk.org,
 Cristian Dumitrescu <cristian.dumitrescu@intel.com>,
 Pablo de Lara <pablo.de.lara.guarch@intel.com>
Subject: [PATCH 2/6] cfgfile: prevent issues with overflow on resize
Date: Thu,  7 May 2026 15:59:45 +0100
Message-ID: <20260507145950.197753-3-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260507145950.197753-1-bruce.richardson@intel.com>
References: <20260507145950.197753-1-bruce.richardson@intel.com>
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

When resizing a cfgfile object to store more sections or entries, the
multiplication in the realloc call could lead to overflow and hence an
incorrect/smaller size being allocated. Prevent this by tightening up
sizing in the library:

- use size_t for sizes rather than int, avoiding negative values
- explicitly limit the number of entries to INT_MAX < SIZE_MAX, ensuring
  that all int indexes from the API will work.
- add range checks on allocation before multiplication, to avoid
  overflow.
  - This means a lower max entry count on 32-bit to avoid 32-bit
    allocation overflow.

Fixes: eaafbad419bf ("cfgfile: library to interpret config files")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 lib/cfgfile/rte_cfgfile.c | 87 ++++++++++++++++++++++-----------------
 1 file changed, 49 insertions(+), 38 deletions(-)

diff --git a/lib/cfgfile/rte_cfgfile.c b/lib/cfgfile/rte_cfgfile.c
index 25fc792274..040351ab4d 100644
--- a/lib/cfgfile/rte_cfgfile.c
+++ b/lib/cfgfile/rte_cfgfile.c
@@ -9,6 +9,7 @@
 #include <ctype.h>
 #include <errno.h>
 #include <limits.h>
+#include <stdint.h>
 
 #ifndef LINE_MAX
 #define LINE_MAX 2048
@@ -23,15 +24,15 @@
 
 struct rte_cfgfile_section {
 	char name[CFG_NAME_LEN];
-	int num_entries;
-	int allocated_entries;
+	size_t num_entries;
+	size_t allocated_entries;
 	struct rte_cfgfile_entry *entries;
 };
 
 struct rte_cfgfile {
 	int flags;
-	int num_sections;
-	int allocated_sections;
+	size_t num_sections;
+	size_t allocated_sections;
 	struct rte_cfgfile_section *sections;
 };
 
@@ -43,12 +44,27 @@ RTE_LOG_REGISTER_DEFAULT(cfgfile_logtype, INFO);
 	RTE_LOG_LINE_PREFIX(level, CFGFILE, "%s(): ", __func__, __VA_ARGS__)
 /* >8 End of setting up dynamic logging */
 
+/** define a max allocation limit for entry and section types
+ * for 64-bit systems, this is based on INT_MAX since APIs all work on int values.
+ * For 32-bit systems, this is based on SIZE_MAX / sizeof(type) to prevent overflow on allocation.
+ */
+#define CFG_ALLOC_MAX(type) \
+	(sizeof(int) == sizeof(size_t) ? (SIZE_MAX / sizeof(type)) : ((size_t)INT_MAX))
+
 /** when we resize a file structure, how many extra entries
  * for new sections do we add in */
 #define CFG_ALLOC_SECTION_BATCH 8
+/** max number of section entries we can possibly have.
+ * Used to prevent overflow on allocation. Based on INT_MAX since APIs all work on int values
+ */
+#define CFG_ALLOC_SECTION_MAX CFG_ALLOC_MAX(struct rte_cfgfile_section)
 /** when we resize a section structure, how many extra entries
  * for new entries do we add in */
 #define CFG_ALLOC_ENTRY_BATCH 16
+/** max number of data entries we can possibly have.
+ * Used to prevent overflow on allocation. Based on INT_MAX since APIs all work on int values
+ */
+#define CFG_ALLOC_ENTRY_MAX CFG_ALLOC_MAX(struct rte_cfgfile_entry)
 
 /**
  * Default cfgfile load parameters.
@@ -99,9 +115,7 @@ _strip(char *str, unsigned len)
 static struct rte_cfgfile_section *
 _get_section(struct rte_cfgfile *cfg, const char *sectionname)
 {
-	int i;
-
-	for (i = 0; i < cfg->num_sections; i++) {
+	for (size_t i = 0; i < cfg->num_sections; i++) {
 		if (strncmp(cfg->sections[i].name, sectionname,
 				sizeof(cfg->sections[0].name)) == 0)
 			return &cfg->sections[i];
@@ -118,6 +132,9 @@ _add_entry(struct rte_cfgfile_section *section, const char *entryname,
 
 	/* resize entry structure if we don't have room for more entries */
 	if (section->num_entries == section->allocated_entries) {
+		if (section->allocated_entries > CFG_ALLOC_ENTRY_MAX - CFG_ALLOC_ENTRY_BATCH)
+			return -ENOMEM;
+
 		struct rte_cfgfile_entry *n_entries = realloc(
 				section->entries,
 				sizeof(struct rte_cfgfile_entry) *
@@ -305,7 +322,6 @@ RTE_EXPORT_SYMBOL(rte_cfgfile_create)
 struct rte_cfgfile *
 rte_cfgfile_create(int flags)
 {
-	int i;
 	struct rte_cfgfile *cfg;
 
 	/* future proof flags usage */
@@ -328,7 +344,7 @@ rte_cfgfile_create(int flags)
 
 	cfg->allocated_sections = CFG_ALLOC_SECTION_BATCH;
 
-	for (i = 0; i < CFG_ALLOC_SECTION_BATCH; i++) {
+	for (size_t i = 0; i < CFG_ALLOC_SECTION_BATCH; i++) {
 		cfg->sections[i].entries = calloc(CFG_ALLOC_ENTRY_BATCH,
 					  sizeof(struct rte_cfgfile_entry));
 
@@ -345,7 +361,7 @@ rte_cfgfile_create(int flags)
 	return cfg;
 error1:
 	if (cfg->sections != NULL) {
-		for (i = 0; i < cfg->allocated_sections; i++) {
+		for (size_t i = 0; i < cfg->allocated_sections; i++) {
 			if (cfg->sections[i].entries != NULL) {
 				free(cfg->sections[i].entries);
 				cfg->sections[i].entries = NULL;
@@ -362,8 +378,6 @@ RTE_EXPORT_SYMBOL(rte_cfgfile_add_section)
 int
 rte_cfgfile_add_section(struct rte_cfgfile *cfg, const char *sectionname)
 {
-	int i;
-
 	if (cfg == NULL)
 		return -EINVAL;
 
@@ -375,6 +389,8 @@ rte_cfgfile_add_section(struct rte_cfgfile *cfg, const char *sectionname)
 
 	/* resize overall struct if we don't have room for more	sections */
 	if (cfg->num_sections == cfg->allocated_sections) {
+		if (cfg->allocated_sections > CFG_ALLOC_SECTION_MAX - CFG_ALLOC_SECTION_BATCH)
+			return -ENOMEM;
 
 		struct rte_cfgfile_section *n_sections =
 				realloc(cfg->sections,
@@ -385,7 +401,7 @@ rte_cfgfile_add_section(struct rte_cfgfile *cfg, const char *sectionname)
 		if (n_sections == NULL)
 			return -ENOMEM;
 
-		for (i = 0; i < CFG_ALLOC_SECTION_BATCH; i++) {
+		for (size_t i = 0; i < CFG_ALLOC_SECTION_BATCH; i++) {
 			n_sections[i + cfg->allocated_sections].num_entries = 0;
 			n_sections[i +
 				 cfg->allocated_sections].allocated_entries = 0;
@@ -428,8 +444,6 @@ RTE_EXPORT_SYMBOL(rte_cfgfile_set_entry)
 int rte_cfgfile_set_entry(struct rte_cfgfile *cfg, const char *sectionname,
 		const char *entryname, const char *entryvalue)
 {
-	int i;
-
 	if ((cfg == NULL) || (sectionname == NULL) || (entryname == NULL))
 		return -EINVAL;
 
@@ -442,7 +456,7 @@ int rte_cfgfile_set_entry(struct rte_cfgfile *cfg, const char *sectionname,
 	if (entryvalue == NULL)
 		entryvalue = "";
 
-	for (i = 0; i < curr_section->num_entries; i++)
+	for (size_t i = 0; i < curr_section->num_entries; i++)
 		if (!strcmp(curr_section->entries[i].name, entryname)) {
 			strlcpy(curr_section->entries[i].value, entryvalue,
 				sizeof(curr_section->entries[i].value));
@@ -456,8 +470,6 @@ int rte_cfgfile_set_entry(struct rte_cfgfile *cfg, const char *sectionname,
 RTE_EXPORT_SYMBOL(rte_cfgfile_save)
 int rte_cfgfile_save(struct rte_cfgfile *cfg, const char *filename)
 {
-	int i, j;
-
 	if ((cfg == NULL) || (filename == NULL))
 		return -EINVAL;
 
@@ -466,10 +478,10 @@ int rte_cfgfile_save(struct rte_cfgfile *cfg, const char *filename)
 	if (f == NULL)
 		return -EINVAL;
 
-	for (i = 0; i < cfg->num_sections; i++) {
+	for (size_t i = 0; i < cfg->num_sections; i++) {
 		fprintf(f, "[%s]\n", cfg->sections[i].name);
 
-		for (j = 0; j < cfg->sections[i].num_entries; j++) {
+		for (size_t j = 0; j < cfg->sections[i].num_entries; j++) {
 			fprintf(f, "%s=%s\n",
 					cfg->sections[i].entries[j].name,
 					cfg->sections[i].entries[j].value);
@@ -481,13 +493,11 @@ int rte_cfgfile_save(struct rte_cfgfile *cfg, const char *filename)
 RTE_EXPORT_SYMBOL(rte_cfgfile_close)
 int rte_cfgfile_close(struct rte_cfgfile *cfg)
 {
-	int i;
-
 	if (cfg == NULL)
 		return -1;
 
 	if (cfg->sections != NULL) {
-		for (i = 0; i < cfg->allocated_sections; i++) {
+		for (size_t i = 0; i < cfg->allocated_sections; i++) {
 			if (cfg->sections[i].entries != NULL) {
 				free(cfg->sections[i].entries);
 				cfg->sections[i].entries = NULL;
@@ -507,20 +517,20 @@ int
 rte_cfgfile_num_sections(struct rte_cfgfile *cfg, const char *sectionname,
 	size_t length)
 {
-	int num_sections = 0;
-	int i;
+	size_t num_sections = 0;
 
 	if (cfg == NULL)
 		return -1;
 
 	if (sectionname == NULL)
-		return cfg->num_sections;
+		return (int)cfg->num_sections;
 
-	for (i = 0; i < cfg->num_sections; i++) {
+	for (size_t i = 0; i < cfg->num_sections; i++) {
 		if (strncmp(cfg->sections[i].name, sectionname, length) == 0)
 			num_sections++;
 	}
-	return num_sections;
+
+	return (int)num_sections;
 }
 
 RTE_EXPORT_SYMBOL(rte_cfgfile_sections)
@@ -533,7 +543,7 @@ rte_cfgfile_sections(struct rte_cfgfile *cfg, char *sections[],
 	if (cfg == NULL || sections == NULL || max_sections < 0)
 		return -1;
 
-	for (i = 0; i < cfg->num_sections && i < max_sections; i++) {
+	for (i = 0; (size_t)i < cfg->num_sections && i < max_sections; i++) {
 		if (sections[i] == NULL)
 			return -1;
 		strlcpy(sections[i], cfg->sections[i].name, CFG_NAME_LEN);
@@ -563,7 +573,8 @@ rte_cfgfile_section_num_entries(struct rte_cfgfile *cfg,
 	const struct rte_cfgfile_section *s = _get_section(cfg, sectionname);
 	if (s == NULL)
 		return -1;
-	return s->num_entries;
+
+	return (int)s->num_entries;
 }
 
 RTE_EXPORT_SYMBOL(rte_cfgfile_section_num_entries_by_index)
@@ -574,13 +585,13 @@ rte_cfgfile_section_num_entries_by_index(struct rte_cfgfile *cfg,
 	if (cfg == NULL || sectionname == NULL)
 		return -1;
 
-	if (index < 0 || index >= cfg->num_sections)
+	if (index < 0 || (size_t)index >= cfg->num_sections)
 		return -1;
 
 	const struct rte_cfgfile_section *sect = &(cfg->sections[index]);
 
 	strlcpy(sectionname, sect->name, CFG_NAME_LEN);
-	return sect->num_entries;
+	return (int)sect->num_entries;
 }
 RTE_EXPORT_SYMBOL(rte_cfgfile_section_entries)
 int
@@ -595,7 +606,7 @@ rte_cfgfile_section_entries(struct rte_cfgfile *cfg, const char *sectionname,
 	const struct rte_cfgfile_section *sect = _get_section(cfg, sectionname);
 	if (sect == NULL)
 		return -1;
-	for (i = 0; i < max_entries && i < sect->num_entries; i++)
+	for (i = 0; i < max_entries && (size_t)i < sect->num_entries; i++)
 		entries[i] = sect->entries[i];
 	return i;
 }
@@ -611,12 +622,14 @@ rte_cfgfile_section_entries_by_index(struct rte_cfgfile *cfg, int index,
 
 	if (cfg == NULL || sectionname == NULL || entries == NULL)
 		return -1;
+	if (max_entries < 0)
+		return -1;
 
-	if (index < 0 || index >= cfg->num_sections)
+	if (index < 0 || (size_t)index >= cfg->num_sections)
 		return -1;
 	sect = &cfg->sections[index];
 	strlcpy(sectionname, sect->name, CFG_NAME_LEN);
-	for (i = 0; i < max_entries && i < sect->num_entries; i++)
+	for (i = 0; i < max_entries && (size_t)i < sect->num_entries; i++)
 		entries[i] = sect->entries[i];
 	return i;
 }
@@ -626,15 +639,13 @@ const char *
 rte_cfgfile_get_entry(struct rte_cfgfile *cfg, const char *sectionname,
 		const char *entryname)
 {
-	int i;
-
 	if (cfg == NULL || sectionname == NULL || entryname == NULL)
 		return NULL;
 
 	const struct rte_cfgfile_section *sect = _get_section(cfg, sectionname);
 	if (sect == NULL)
 		return NULL;
-	for (i = 0; i < sect->num_entries; i++)
+	for (size_t i = 0; i < sect->num_entries; i++)
 		if (strncmp(sect->entries[i].name, entryname, CFG_NAME_LEN)
 									== 0)
 			return sect->entries[i].value;
-- 
2.51.0

