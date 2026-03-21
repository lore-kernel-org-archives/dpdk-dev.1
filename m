Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74466EC01A1
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Mar 2026 08:19:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B19B140655;
	Mon, 23 Mar 2026 09:19:05 +0100 (CET)
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
 by mails.dpdk.org (Postfix) with ESMTP id EF7274026A
 for <dev@dpdk.org>; Sat, 21 Mar 2026 03:16:36 +0100 (CET)
Received: from localhost.localdomain (unknown [111.196.245.197])
 by APP-05 (Coremail) with SMTP id zQCowAAXpQiC_71p6hoGCw--.24557S2;
 Sat, 21 Mar 2026 10:16:35 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: dev@dpdk.org
Cc: Praveen Shetty <praveen.shetty@intel.com>,
	pengpeng@iscas.ac.cn
Subject: [PATCH 2/2] net/cpfl: validate fieldvector offsets before copying keys
Date: Sat, 21 Mar 2026 10:16:34 +0800
Message-ID: <20260321021634.96514-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowAAXpQiC_71p6hoGCw--.24557S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAF17XrWUJr1rAr1kAF1DKFg_yoW5WFWxpa
 1jkry7Cr4DXr4UWrs3tF18ZFW5Xw18JFW3CFy3Gas09rW7twsrWF15Ka45uF90krn5CrW8
 Crs8CFy7CFn8ZrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUym14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
 6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVWxJr
 0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
 2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
 W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1l42xK82IYc2Ij64vI
 r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
 xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0xvE2Ix0
 cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
 AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E
 14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JUkKsUUUUUU=
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

The CPFL JSON parser accepts fieldvector offsets and SEM key sizes straight from the input description. Reject offsets that would write past the 64-byte SEM fieldvector storage and reject key sizes that would later overread the fixed source buffer or overflow the destination key buffer.

Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 drivers/net/intel/cpfl/cpfl_flow_engine_fxp.c |  6 ++++++
 drivers/net/intel/cpfl/cpfl_flow_parser.c     | 12 ++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/drivers/net/intel/cpfl/cpfl_flow_engine_fxp.c b/drivers/net/intel/cpfl/cpfl_flow_engine_fxp.c
index 361827c..d0bd909 100644
--- a/drivers/net/intel/cpfl/cpfl_flow_engine_fxp.c
+++ b/drivers/net/intel/cpfl/cpfl_flow_engine_fxp.c
@@ -173,6 +173,12 @@ cpfl_fxp_parse_pattern(const struct cpfl_flow_pr_action *pr_action,
 	if (pr_action->type == CPFL_JS_PR_ACTION_TYPE_SEM) {
 		struct cpfl_rule_info *rinfo = &rim->rules[i];
 
+		if (pr_action->sem.keysize > sizeof(pr_action->sem.cpfl_flow_pr_fv) ||
+		    pr_action->sem.keysize > sizeof(rinfo->sem.key)) {
+			PMD_DRV_LOG(ERR, "Invalid SEM key size.");
+			return false;
+		}
+
 		rinfo->type = CPFL_RULE_TYPE_SEM;
 		rinfo->sem.prof_id = pr_action->sem.prof;
 		rinfo->sem.sub_prof_id = pr_action->sem.subprof;
diff --git a/drivers/net/intel/cpfl/cpfl_flow_parser.c b/drivers/net/intel/cpfl/cpfl_flow_parser.c
index e7deb61..7fb2e7e 100644
--- a/drivers/net/intel/cpfl/cpfl_flow_parser.c
+++ b/drivers/net/intel/cpfl/cpfl_flow_parser.c
@@ -323,6 +323,10 @@ cpfl_flow_js_pattern_act_fv_proto(json_t *ob_value, struct cpfl_flow_js_fv *js_f
 		PMD_DRV_LOG(ERR, "Can not parse 'offset'.");
 		return -EINVAL;
 	}
+	if (offset >= CPFL_JS_SEM_FV_KEY_NUM_MAX / 2) {
+		PMD_DRV_LOG(ERR, "The 'offset' is too large.");
+		return -EINVAL;
+	}
 	ret = cpfl_json_t_to_uint16(ob_value, "mask", &mask);
 	if (ret < 0) {
 		PMD_DRV_LOG(ERR, "Can not parse 'mask'.");
@@ -391,6 +395,10 @@ cpfl_flow_js_pattern_act_fv(json_t *ob_fvs, struct cpfl_flow_js_pr_action *js_ac
 			PMD_DRV_LOG(ERR, "Can not parse 'offset'.");
 			goto err;
 		}
+		if (offset >= CPFL_JS_SEM_FV_KEY_NUM_MAX / 2) {
+			PMD_DRV_LOG(ERR, "The 'offset' is too large.");
+			goto err;
+		}
 		js_fv->offset = offset;
 
 		type = cpfl_json_t_to_string(object, "type");
@@ -454,6 +462,10 @@ cpfl_flow_js_pattern_per_act(json_t *ob_per_act, struct cpfl_flow_js_pr_action *
 			PMD_DRV_LOG(ERR, "Can not parse 'keysize'.");
 			return -EINVAL;
 		}
+		if (js_act->sem.keysize > sizeof(js_act->sem.cpfl_flow_pr_fv)) {
+			PMD_DRV_LOG(ERR, "The 'keysize' is too large.");
+			return -EINVAL;
+		}
 		ob_fvs = json_object_get(ob_sem, "fieldvectors");
 		ret = cpfl_flow_js_pattern_act_fv(ob_fvs, js_act);
 		if (ret < 0)
-- 
2.50.1 (Apple Git-155)

