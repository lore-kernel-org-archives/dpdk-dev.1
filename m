Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86D1CC61DB9
	for <dpdk-dev@archiver.kernel.org>; Sat, 29 Aug 2026 02:45:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0C6ED402E3;
	Sat, 29 Aug 2026 04:45:11 +0200 (CEST)
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com
 [209.85.216.54]) by mails.dpdk.org (Postfix) with ESMTP id A5A33402B6
 for <dev@dpdk.org>; Sat, 29 Aug 2026 04:45:09 +0200 (CEST)
Received: by mail-pj1-f54.google.com with SMTP id
 98e67ed59e1d1-38e42560ebcso1545941a91.1
 for <dev@dpdk.org>; Fri, 28 Aug 2026 19:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787971509;
 x=1788576309; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=q0W8CROQJB2jL0KoQhyYY467hTz+7Rn5FyID67+ABqs=;
 b=X6FtYNbYoWKYW86y9PhflRApxP0Cm6PyOOyxBqLbpmJRn5bfp63d3Acr5/eNp9vZ00
 g7ovYDvImtfMXKg6MCoIYDIunjbRf3yLQDI0NW/C7eVNcQHtukNKp5dco97Sz75xgy5Z
 CBBf9gmOldHMlfyj2bXwM+ICfL9cLtknZ3nAGj1BeR8u0VKblgetDkoAdsZGWNdkKMoa
 DCGYBsK2qJ/NFCGtdSy5SNEdKC30Z7dHz5T9fyYKJk6W3EzfSMp8k90liX4NeRHjA239
 lscgK/FdkIPQbf2ZXVtPkeRvI018y6HYll+erRNsw89AbultnHd0HX3J9oSfaaVOvZ62
 boWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787971509; x=1788576309;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=q0W8CROQJB2jL0KoQhyYY467hTz+7Rn5FyID67+ABqs=;
 b=RocAC3s2zZNuexKMJ7R9Xu3pVxMJE7KQ6H8RjsJTtr0CttH21jqe8oDz0tHat//6YW
 l6XTNVUf8SENSRoTCjA8pZama1RzewSvUwTAwCyuFJE85LMFBuONUClcFK6LJWTpkHiY
 SnieGCsRv7rdec5B/5ro+aAwmu5CjV2wirjNTc/bnlHijC87q69flPoNbGCkuJPxSBSp
 tDepXEHXbCMed1UupVW9DXuCuOqUSDCTKgC0UMjBCUO0gwBch8cydzOVfsLAv62DKY5B
 WN2+Pj2f9Ze9kOXO1nn6qMMoYncMN+7C2xEMEVFY/SFi4gV3wpZBYe2MpR29Rb8q2yLK
 g9eQ==
X-Gm-Message-State: AFuF++l9pZNjQjzVQ5BwzvQ5ndxZvxRya2SIHmwM00HnwFd4h1FNrmib
 i+RRbEy1HE5RVtWyNB4QeqRSifejVozEo00n/tFhDd9TGEGz0ujFpbyd1jLKvoGhlDV3ECp/vTv
 hc0zR
X-Gm-Gg: AYBFou3RvtnsrhMj8hqcokiUhijRiLJMKYNqsmo8Vs3c2qA+Qvu8wPrJZHk9fqcJXjz
 2F4Q8o6MGxhfBWBZAGcg+VQvaKcfMi9kqv8NIWdedBNiMok1bLN5C2T2u+mh2c8uPX7Nk9ld2JP
 RuxGRyhGwTcdbIvayWncBsmYM8UbdkxJZfsp4IEhUyeHg26Vphz2R9RQuwvwtXre5BItqbXZyZK
 h/9v3E7ymWDcclA7lfIfcaA5V3fklN9TfLiXLX/iXg9KWN2zlzdzyHf1Tnu1z0SPP7SbYTwjPWQ
 bEAz9rFtknAlypnaMqOcR622mEZkL/sRWHs0eqVv+QtK+AVLQUpOVIAeebb+rAISBPO7MLWnAp6
 W2tpriY9dtu11bBIJdKp92wyniQbbOa+XFobtkerlynML8W2nuPAgoDIlSrxvLA8m/4NAYW8ztI
 B7JN9d/NsuRJ/JuZWSvNZyE4j1+seHM9srsgNLbjpRP5EZMT8iGY9fgqGue9NUOzqB6W8T2xMAl
 MCn5Klj3vqV7jOKzCHC45Uh/Wk=
X-Received: by 2002:a17:90a:2ca4:b0:398:a2a3:b631 with SMTP id
 98e67ed59e1d1-398a2a3b659mr2749120a91.19.1787971508594; 
 Fri, 28 Aug 2026 19:45:08 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-396b1992e05sm9651374a91.15.2026.08.28.19.45.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 19:45:08 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Sivaprasad Tummala <sivaprasad.tummala@amd.com>
Subject: [PATCH 2/2] examples/vm_power_manager: fix vCPU number parsing
Date: Fri, 28 Aug 2026 19:43:53 -0700
Message-ID: <20260829024455.1557201-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260829024455.1557201-1-stephen@networkplumber.org>
References: <20260828215350.2861715-1-thomas.petazzoni@bootlin.com>
 <20260829024455.1557201-1-stephen@networkplumber.org>
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

The guest CLI parsed the vCPU argument of the query_cpu_freq and
query_cpu_caps commands with strtol(), storing the result in an
unsigned variable. Use strtoul() to match the type, and parse into
an unsigned long so the range check applies to the value strtoul()
returned rather than to an already truncated one.

The original code also accepted trailing garbage, so "3xyz"
and "3 4" parsed as 3; reject any unconsumed input.

Both commands duplicated this parsing along with the "all" handling.
Factor it into parse_vcpu_arg() and report the offending string and
the valid range instead of "Invalid parameter provided".

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 .../guest_cli/vm_power_cli_guest.c            | 113 +++++++++---------
 1 file changed, 59 insertions(+), 54 deletions(-)

diff --git a/examples/vm_power_manager/guest_cli/vm_power_cli_guest.c b/examples/vm_power_manager/guest_cli/vm_power_cli_guest.c
index cd0d87d1e7..f7ffda1381 100644
--- a/examples/vm_power_manager/guest_cli/vm_power_cli_guest.c
+++ b/examples/vm_power_manager/guest_cli/vm_power_cli_guest.c
@@ -145,6 +145,47 @@ struct cmd_freq_list_result {
 	cmdline_fixed_string_t cpu_num;
 };
 
+/*
+ * Parse the vCPU argument of a query command, which is either "all" or a
+ * single vCPU number. A number indexes the per-vCPU arrays in the channel
+ * reply packets, so it must be below RTE_POWER_MAX_VCPU_PER_VM.
+ *
+ * Returns 1 for "all", 0 for a single vCPU, or -1 on error after printing
+ * the reason. On success *lcore_id is the lcore to communicate over, which
+ * for "all" is the first enabled lcore.
+ */
+static int
+parse_vcpu_arg(struct cmdline *cl, const char *str, unsigned int *lcore_id)
+{
+	unsigned long val;
+	char *ep;
+
+	if (!strcmp(str, "all")) {
+		/* Get first enabled lcore. */
+		*lcore_id = rte_get_next_lcore(-1, 0, 0);
+		if (*lcore_id == RTE_MAX_LCORE) {
+			cmdline_printf(cl, "Enabled core not found.\n");
+			return -1;
+		}
+		return 1;
+	}
+
+	errno = 0;
+	val = strtoul(str, &ep, 10);
+	if (errno != 0 || ep == str || *ep != '\0') {
+		cmdline_printf(cl, "Invalid vCPU number \"%s\".\n", str);
+		return -1;
+	}
+	if (val >= RTE_POWER_MAX_VCPU_PER_VM) {
+		cmdline_printf(cl, "vCPU number \"%s\" is out of range (max %u).\n",
+				str, RTE_POWER_MAX_VCPU_PER_VM - 1);
+		return -1;
+	}
+
+	*lcore_id = val;
+	return 0;
+}
+
 static int
 query_data(struct rte_power_channel_packet *pkt, unsigned int lcore_id)
 {
@@ -179,46 +220,28 @@ receive_freq_list(struct rte_power_channel_packet_freq_list *pkt_freq_list,
 
 static void
 cmd_query_freq_list_parsed(void *parsed_result,
-		__rte_unused struct cmdline *cl,
+		struct cmdline *cl,
 		__rte_unused void *data)
 {
 	struct cmd_freq_list_result *res = parsed_result;
 	unsigned int lcore_id;
 	struct rte_power_channel_packet_freq_list pkt_freq_list;
 	struct rte_power_channel_packet pkt;
-	bool query_list = false;
+	bool query_list;
 	int ret;
-	char *ep;
 
 	memset(&pkt, 0, sizeof(pkt));
 	memset(&pkt_freq_list, 0, sizeof(pkt_freq_list));
 
-	if (!strcmp(res->cpu_num, "all")) {
-
-		/* Get first enabled lcore. */
-		lcore_id = rte_get_next_lcore(-1,
-				0,
-				0);
-		if (lcore_id == RTE_MAX_LCORE) {
-			cmdline_printf(cl, "Enabled core not found.\n");
-			return;
-		}
+	ret = parse_vcpu_arg(cl, res->cpu_num, &lcore_id);
+	if (ret < 0)
+		return;
 
-		pkt.command = RTE_POWER_QUERY_FREQ_LIST;
-		strlcpy(pkt.vm_name, policy.vm_name, sizeof(pkt.vm_name));
-		query_list = true;
-	} else {
-		errno = 0;
-		lcore_id = (unsigned int)strtol(res->cpu_num, &ep, 10);
-		if (errno != 0 || lcore_id >= RTE_POWER_MAX_VCPU_PER_VM ||
-			ep == res->cpu_num) {
-			cmdline_printf(cl, "Invalid parameter provided.\n");
-			return;
-		}
-		pkt.command = RTE_POWER_QUERY_FREQ;
-		strlcpy(pkt.vm_name, policy.vm_name, sizeof(pkt.vm_name));
+	query_list = (ret == 1);
+	pkt.command = query_list ? RTE_POWER_QUERY_FREQ_LIST : RTE_POWER_QUERY_FREQ;
+	strlcpy(pkt.vm_name, policy.vm_name, sizeof(pkt.vm_name));
+	if (!query_list)
 		pkt.resource_id = lcore_id;
-	}
 
 	ret = query_data(&pkt, lcore_id);
 	if (ret < 0) {
@@ -289,46 +312,28 @@ receive_capabilities(struct rte_power_channel_packet_caps_list *pkt_caps_list,
 
 static void
 cmd_query_caps_list_parsed(void *parsed_result,
-		__rte_unused struct cmdline *cl,
+		struct cmdline *cl,
 		__rte_unused void *data)
 {
 	struct cmd_query_caps_result *res = parsed_result;
 	unsigned int lcore_id;
 	struct rte_power_channel_packet_caps_list pkt_caps_list;
 	struct rte_power_channel_packet pkt;
-	bool query_list = false;
+	bool query_list;
 	int ret;
-	char *ep;
 
 	memset(&pkt, 0, sizeof(pkt));
 	memset(&pkt_caps_list, 0, sizeof(pkt_caps_list));
 
-	if (!strcmp(res->cpu_num, "all")) {
-
-		/* Get first enabled lcore. */
-		lcore_id = rte_get_next_lcore(-1,
-				0,
-				0);
-		if (lcore_id == RTE_MAX_LCORE) {
-			cmdline_printf(cl, "Enabled core not found.\n");
-			return;
-		}
+	ret = parse_vcpu_arg(cl, res->cpu_num, &lcore_id);
+	if (ret < 0)
+		return;
 
-		pkt.command = RTE_POWER_QUERY_CAPS_LIST;
-		strlcpy(pkt.vm_name, policy.vm_name, sizeof(pkt.vm_name));
-		query_list = true;
-	} else {
-		errno = 0;
-		lcore_id = (unsigned int)strtol(res->cpu_num, &ep, 10);
-		if (errno != 0 || lcore_id >= RTE_POWER_MAX_VCPU_PER_VM ||
-			ep == res->cpu_num) {
-			cmdline_printf(cl, "Invalid parameter provided.\n");
-			return;
-		}
-		pkt.command = RTE_POWER_QUERY_CAPS;
-		strlcpy(pkt.vm_name, policy.vm_name, sizeof(pkt.vm_name));
+	query_list = (ret == 1);
+	pkt.command = query_list ? RTE_POWER_QUERY_CAPS_LIST : RTE_POWER_QUERY_CAPS;
+	strlcpy(pkt.vm_name, policy.vm_name, sizeof(pkt.vm_name));
+	if (!query_list)
 		pkt.resource_id = lcore_id;
-	}
 
 	ret = query_data(&pkt, lcore_id);
 	if (ret < 0) {
-- 
2.53.0

