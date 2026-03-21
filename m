Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB6E2EC01A1
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Mar 2026 08:19:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C8B724060C;
	Mon, 23 Mar 2026 09:19:04 +0100 (CET)
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
 by mails.dpdk.org (Postfix) with ESMTP id 88E414026A
 for <dev@dpdk.org>; Sat, 21 Mar 2026 03:16:30 +0100 (CET)
Received: from localhost.localdomain (unknown [111.196.245.197])
 by APP-05 (Coremail) with SMTP id zQCowAC3Sg57_71pQBoGCw--.9389S2;
 Sat, 21 Mar 2026 10:16:28 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: dev@dpdk.org
Cc: Cristian Dumitrescu <cristian.dumitrescu@intel.com>, pengpeng@iscas.ac.cn
Subject: [PATCH 1/2] lib/pipeline: bound token concatenation when parsing
 instructions
Date: Sat, 21 Mar 2026 10:16:27 +0800
Message-ID: <20260321021627.96424-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowAC3Sg57_71pQBoGCw--.9389S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Xr4kKFWftw4xZry5Gw1fCrg_yoWxuFW5pa
 1Uu3W5Xr1UtrnrKwn7tw4kWr43KrsY9w1jgFWDJ3sayFWxt3s7Wa17AF97Cr1DKFW3ursx
 ArsxGFn8uFs7WF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUyl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
 6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr
 1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
 6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
 0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxAIw28IcxkI7VAK
 I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
 xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAwCIc40Y0x0EwIxGrwCI42IY6xII
 jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
 0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
 67AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfUYwIDUUUUU
X-Originating-IP: [111.196.245.197]
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/
X-Mailman-Approved-At: Mon, 23 Mar 2026 09:19:03 +0100
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

action_block_parse() and apply_block_parse() build instruction strings by concatenating untrusted tokens into a fixed-size stack buffer. Replace the open-coded strcat() loop with a helper that tracks the remaining capacity and fails when the assembled instruction would exceed RTE_SWX_INSTRUCTION_SIZE.

Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 lib/pipeline/rte_swx_pipeline.c      | 30 ++++++++++++---------
 lib/pipeline/rte_swx_pipeline_spec.c | 40 ++++++++++++++++++----------
 2 files changed, 43 insertions(+), 27 deletions(-)

diff --git a/lib/pipeline/rte_swx_pipeline.c b/lib/pipeline/rte_swx_pipeline.c
index a915781..500b9d7 100644
--- a/lib/pipeline/rte_swx_pipeline.c
+++ b/lib/pipeline/rte_swx_pipeline.c
@@ -11,6 +11,7 @@
 #include <rte_eal_memconfig.h>
 #include <rte_jhash.h>
 #include <rte_hash_crc.h>
+#include <rte_string_fns.h>
 
 #include <rte_swx_port_ethdev.h>
 #include <rte_swx_port_fd.h>
@@ -42,6 +43,9 @@ do {                                                                           \
 	       RTE_SWX_INSTRUCTION_SIZE),                                      \
 	      err_code)
 
+#define CHECK_STRLCPY(dst, src, err_code)                                     \
+	CHECK(strlcpy((dst), (src), sizeof(dst)) < sizeof(dst), err_code)
+
 /*
  * Environment.
  */
@@ -5680,7 +5684,7 @@ instr_jmp_translate(struct rte_swx_pipeline *p __rte_unused,
 {
 	CHECK(n_tokens == 2, EINVAL);
 
-	strcpy(data->jmp_label, tokens[1]);
+	CHECK_STRLCPY(data->jmp_label, tokens[1], EINVAL);
 
 	instr->type = INSTR_JMP;
 	instr->jmp.ip = NULL; /* Resolved later. */
@@ -5699,7 +5703,7 @@ instr_jmp_valid_translate(struct rte_swx_pipeline *p,
 
 	CHECK(n_tokens == 3, EINVAL);
 
-	strcpy(data->jmp_label, tokens[1]);
+	CHECK_STRLCPY(data->jmp_label, tokens[1], EINVAL);
 
 	h = header_parse(p, tokens[2]);
 	CHECK(h, EINVAL);
@@ -5722,7 +5726,7 @@ instr_jmp_invalid_translate(struct rte_swx_pipeline *p,
 
 	CHECK(n_tokens == 3, EINVAL);
 
-	strcpy(data->jmp_label, tokens[1]);
+	CHECK_STRLCPY(data->jmp_label, tokens[1], EINVAL);
 
 	h = header_parse(p, tokens[2]);
 	CHECK(h, EINVAL);
@@ -5744,7 +5748,7 @@ instr_jmp_hit_translate(struct rte_swx_pipeline *p __rte_unused,
 	CHECK(!action, EINVAL);
 	CHECK(n_tokens == 2, EINVAL);
 
-	strcpy(data->jmp_label, tokens[1]);
+	CHECK_STRLCPY(data->jmp_label, tokens[1], EINVAL);
 
 	instr->type = INSTR_JMP_HIT;
 	instr->jmp.ip = NULL; /* Resolved later. */
@@ -5762,7 +5766,7 @@ instr_jmp_miss_translate(struct rte_swx_pipeline *p __rte_unused,
 	CHECK(!action, EINVAL);
 	CHECK(n_tokens == 2, EINVAL);
 
-	strcpy(data->jmp_label, tokens[1]);
+	CHECK_STRLCPY(data->jmp_label, tokens[1], EINVAL);
 
 	instr->type = INSTR_JMP_MISS;
 	instr->jmp.ip = NULL; /* Resolved later. */
@@ -5782,7 +5786,7 @@ instr_jmp_action_hit_translate(struct rte_swx_pipeline *p,
 	CHECK(!action, EINVAL);
 	CHECK(n_tokens == 3, EINVAL);
 
-	strcpy(data->jmp_label, tokens[1]);
+	CHECK_STRLCPY(data->jmp_label, tokens[1], EINVAL);
 
 	a = action_find(p, tokens[2]);
 	CHECK(a, EINVAL);
@@ -5806,7 +5810,7 @@ instr_jmp_action_miss_translate(struct rte_swx_pipeline *p,
 	CHECK(!action, EINVAL);
 	CHECK(n_tokens == 3, EINVAL);
 
-	strcpy(data->jmp_label, tokens[1]);
+	CHECK_STRLCPY(data->jmp_label, tokens[1], EINVAL);
 
 	a = action_find(p, tokens[2]);
 	CHECK(a, EINVAL);
@@ -5832,7 +5836,7 @@ instr_jmp_eq_translate(struct rte_swx_pipeline *p,
 
 	CHECK(n_tokens == 4, EINVAL);
 
-	strcpy(data->jmp_label, tokens[1]);
+	CHECK_STRLCPY(data->jmp_label, tokens[1], EINVAL);
 
 	fa = struct_field_parse(p, action, a, &a_struct_id);
 	CHECK(fa, EINVAL);
@@ -5892,7 +5896,7 @@ instr_jmp_neq_translate(struct rte_swx_pipeline *p,
 
 	CHECK(n_tokens == 4, EINVAL);
 
-	strcpy(data->jmp_label, tokens[1]);
+	CHECK_STRLCPY(data->jmp_label, tokens[1], EINVAL);
 
 	fa = struct_field_parse(p, action, a, &a_struct_id);
 	CHECK(fa, EINVAL);
@@ -5952,7 +5956,7 @@ instr_jmp_lt_translate(struct rte_swx_pipeline *p,
 
 	CHECK(n_tokens == 4, EINVAL);
 
-	strcpy(data->jmp_label, tokens[1]);
+	CHECK_STRLCPY(data->jmp_label, tokens[1], EINVAL);
 
 	fa = struct_field_parse(p, action, a, &a_struct_id);
 	CHECK(fa, EINVAL);
@@ -6012,7 +6016,7 @@ instr_jmp_gt_translate(struct rte_swx_pipeline *p,
 
 	CHECK(n_tokens == 4, EINVAL);
 
-	strcpy(data->jmp_label, tokens[1]);
+	CHECK_STRLCPY(data->jmp_label, tokens[1], EINVAL);
 
 	fa = struct_field_parse(p, action, a, &a_struct_id);
 	CHECK(fa, EINVAL);
@@ -6437,7 +6441,7 @@ instr_translate(struct rte_swx_pipeline *p,
 
 	/* Handle the optional instruction label. */
 	if ((n_tokens >= 2) && !strcmp(tokens[1], ":")) {
-		strcpy(data->label, tokens[0]);
+		CHECK_STRLCPY(data->label, tokens[0], EINVAL);
 
 		tpos += 2;
 		CHECK(n_tokens - tpos, EINVAL);
@@ -8541,7 +8545,7 @@ rte_swx_pipeline_table_config(struct rte_swx_pipeline *p,
 	/* Node initialization. */
 	strcpy(t->name, name);
 	if (args && args[0])
-		strcpy(t->args, args);
+		CHECK_STRLCPY(t->args, args, EINVAL);
 	t->type = type;
 
 	for (i = 0; i < params->n_fields; i++) {
diff --git a/lib/pipeline/rte_swx_pipeline_spec.c b/lib/pipeline/rte_swx_pipeline_spec.c
index 986bbe5..3df191e 100644
--- a/lib/pipeline/rte_swx_pipeline_spec.c
+++ b/lib/pipeline/rte_swx_pipeline_spec.c
@@ -39,6 +39,28 @@
 #define LEARNER_TIMEOUT_BLOCK 10
 #define APPLY_BLOCK 11
 
+static int
+buffer_append_tokens(char *buffer, size_t buffer_size, char **tokens,
+		     uint32_t n_tokens)
+{
+	size_t len = 0;
+	uint32_t i;
+
+	buffer[0] = 0;
+	for (i = 0; i < n_tokens; i++) {
+		int ret;
+
+		ret = snprintf(buffer + len, buffer_size - len, "%s%s",
+			       i ? " " : "", tokens[i]);
+		if ((ret < 0) || ((size_t)ret >= buffer_size - len))
+			return -ENAMETOOLONG;
+
+		len += (size_t)ret;
+	}
+
+	return 0;
+}
+
 /*
  * extobj.
  */
@@ -454,7 +476,6 @@ action_block_parse(struct action_spec *s,
 {
 	char buffer[RTE_SWX_INSTRUCTION_SIZE], *instr;
 	const char **new_instructions;
-	uint32_t i;
 
 	/* Handle end of block. */
 	if ((n_tokens == 1) && !strcmp(tokens[0], "}")) {
@@ -463,12 +484,8 @@ action_block_parse(struct action_spec *s,
 	}
 
 	/* spec. */
-	buffer[0] = 0;
-	for (i = 0; i < n_tokens; i++) {
-		if (i)
-			strcat(buffer, " ");
-		strcat(buffer, tokens[i]);
-	}
+	if (buffer_append_tokens(buffer, sizeof(buffer), tokens, n_tokens))
+		return -ENAMETOOLONG;
 
 	instr = strdup(buffer);
 	if (!instr) {
@@ -2142,7 +2159,6 @@ apply_block_parse(struct apply_spec *s,
 {
 	char buffer[RTE_SWX_INSTRUCTION_SIZE], *instr;
 	const char **new_instructions;
-	uint32_t i;
 
 	/* Handle end of block. */
 	if ((n_tokens == 1) && !strcmp(tokens[0], "}")) {
@@ -2151,12 +2167,8 @@ apply_block_parse(struct apply_spec *s,
 	}
 
 	/* spec. */
-	buffer[0] = 0;
-	for (i = 0; i < n_tokens; i++) {
-		if (i)
-			strcat(buffer, " ");
-		strcat(buffer, tokens[i]);
-	}
+	if (buffer_append_tokens(buffer, sizeof(buffer), tokens, n_tokens))
+		return -ENAMETOOLONG;
 
 	instr = strdup(buffer);
 	if (!instr) {
-- 
2.50.1 (Apple Git-155)

