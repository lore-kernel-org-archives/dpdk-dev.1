Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B612CD3439
	for <dpdk-dev@archiver.kernel.org>; Thu,  7 May 2026 15:00:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1DA014065B;
	Thu,  7 May 2026 16:59:59 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 63E404026A
 for <dev@dpdk.org>; Thu,  7 May 2026 16:59:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778165998; x=1809701998;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=CfXDy+wULiBMQcW0lXiuE3L38iKqY1Vr73MQUm0gDQc=;
 b=dV7v+iCHK6PiHBOIesSgpTaZRzx6IRSwqA4XetZv6ATRiVsYbfIZTOyr
 T0gwjGF+yZvOZCHzelWz2TWw4mSEEf/7ubQxOdfZUBekVMs37iinqfzxQ
 mYxURIs3qfrdulACQW6K8oN0P/BEAE9+KTUZEuHsMa9W1ZLHsCtpfg9RU
 zV5avsMHe/YC/VUPVNM9sWLjQ6TlRVlATHfNY3gbIziAutVSr6LjXtTez
 GCbqWR6eHPvshd8Cy6WO5e8oi8dGXH4lZwAWzliqAETHpoI/1NbSLFpO1
 kk06jkMdQ/JSGKf/CXmBlCEHXt/1cOix55b25n4C7/wnjlDVgy1dpheRW g==;
X-CSE-ConnectionGUID: yPaZDIg8QEqGAUcc5zqEgw==
X-CSE-MsgGUID: wxo8z8gfRya27yxziHfNBQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11779"; a="82738155"
X-IronPort-AV: E=Sophos;i="6.23,221,1770624000"; d="scan'208";a="82738155"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 May 2026 07:59:57 -0700
X-CSE-ConnectionGUID: 4bCJmU4LRkmB8DwJ8E0ljA==
X-CSE-MsgGUID: y1QANFZIT36tOkMtwsQWBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,221,1770624000"; d="scan'208";a="233818175"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa008.fm.intel.com with ESMTP; 07 May 2026 07:59:56 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Cristian Dumitrescu <cristian.dumitrescu@intel.com>
Subject: [PATCH 1/6] cfgfile: add null checks to public APIs
Date: Thu,  7 May 2026 15:59:44 +0100
Message-ID: <20260507145950.197753-2-bruce.richardson@intel.com>
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

For safety, add NULL checks to each of the public APIs to avoid crashes
in the library. Even though NULL values are likely symptoms of a wider
problem, this is not a datapath library so there is no harm in taking a
few cycles for additional parameter checking.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 lib/cfgfile/rte_cfgfile.c | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/lib/cfgfile/rte_cfgfile.c b/lib/cfgfile/rte_cfgfile.c
index c495bdf6ae..25fc792274 100644
--- a/lib/cfgfile/rte_cfgfile.c
+++ b/lib/cfgfile/rte_cfgfile.c
@@ -198,6 +198,10 @@ rte_cfgfile_load_with_params(const char *filename, int flags,
 		return NULL;
 
 	cfg = rte_cfgfile_create(flags);
+	if (cfg == NULL) {
+		fclose(f);
+		return NULL;
+	}
 
 	while (fgets(buffer, sizeof(buffer), f) != NULL) {
 		char *pos;
@@ -506,6 +510,9 @@ rte_cfgfile_num_sections(struct rte_cfgfile *cfg, const char *sectionname,
 	int num_sections = 0;
 	int i;
 
+	if (cfg == NULL)
+		return -1;
+
 	if (sectionname == NULL)
 		return cfg->num_sections;
 
@@ -523,8 +530,14 @@ rte_cfgfile_sections(struct rte_cfgfile *cfg, char *sections[],
 {
 	int i;
 
-	for (i = 0; i < cfg->num_sections && i < max_sections; i++)
+	if (cfg == NULL || sections == NULL || max_sections < 0)
+		return -1;
+
+	for (i = 0; i < cfg->num_sections && i < max_sections; i++) {
+		if (sections[i] == NULL)
+			return -1;
 		strlcpy(sections[i], cfg->sections[i].name, CFG_NAME_LEN);
+	}
 
 	return i;
 }
@@ -533,6 +546,9 @@ RTE_EXPORT_SYMBOL(rte_cfgfile_has_section)
 int
 rte_cfgfile_has_section(struct rte_cfgfile *cfg, const char *sectionname)
 {
+	if (cfg == NULL || sectionname == NULL)
+		return 0;
+
 	return _get_section(cfg, sectionname) != NULL;
 }
 
@@ -541,6 +557,9 @@ int
 rte_cfgfile_section_num_entries(struct rte_cfgfile *cfg,
 	const char *sectionname)
 {
+	if (cfg == NULL || sectionname == NULL)
+		return -1;
+
 	const struct rte_cfgfile_section *s = _get_section(cfg, sectionname);
 	if (s == NULL)
 		return -1;
@@ -552,6 +571,9 @@ int
 rte_cfgfile_section_num_entries_by_index(struct rte_cfgfile *cfg,
 	char *sectionname, int index)
 {
+	if (cfg == NULL || sectionname == NULL)
+		return -1;
+
 	if (index < 0 || index >= cfg->num_sections)
 		return -1;
 
@@ -566,6 +588,10 @@ rte_cfgfile_section_entries(struct rte_cfgfile *cfg, const char *sectionname,
 		struct rte_cfgfile_entry *entries, int max_entries)
 {
 	int i;
+
+	if (cfg == NULL || sectionname == NULL || entries == NULL)
+		return -1;
+
 	const struct rte_cfgfile_section *sect = _get_section(cfg, sectionname);
 	if (sect == NULL)
 		return -1;
@@ -583,6 +609,9 @@ rte_cfgfile_section_entries_by_index(struct rte_cfgfile *cfg, int index,
 	int i;
 	const struct rte_cfgfile_section *sect;
 
+	if (cfg == NULL || sectionname == NULL || entries == NULL)
+		return -1;
+
 	if (index < 0 || index >= cfg->num_sections)
 		return -1;
 	sect = &cfg->sections[index];
@@ -598,6 +627,10 @@ rte_cfgfile_get_entry(struct rte_cfgfile *cfg, const char *sectionname,
 		const char *entryname)
 {
 	int i;
+
+	if (cfg == NULL || sectionname == NULL || entryname == NULL)
+		return NULL;
+
 	const struct rte_cfgfile_section *sect = _get_section(cfg, sectionname);
 	if (sect == NULL)
 		return NULL;
-- 
2.51.0

