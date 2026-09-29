Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AC9CCA5FB1
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 16:41:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 783FA42EE6;
	Tue, 29 Sep 2026 18:38:52 +0200 (CEST)
Received: from mail-pz2-f37.google.com (mail-pz2-f37.google.com
 [74.125.228.37]) by mails.dpdk.org (Postfix) with ESMTP id 6E07642670
 for <dev@dpdk.org>; Tue, 29 Sep 2026 18:38:31 +0200 (CEST)
Received: by mail-pz2-f37.google.com with SMTP id
 d2e1a72fcca58-8867466563eso90651b3a.0
 for <dev@dpdk.org>; Tue, 29 Sep 2026 09:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790699910;
 x=1791304710; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jfXICf2eAZrH5cVPglTlBbZqyF0HNCWEvqV4CqM39hU=;
 b=yjg+edHWcbwiU3o6sl5ya5EEK+fUy19B+oIFjXSNmR++YpbR+GqspJgN7Aj6iTrs5i
 uJxmBbfxT36YP5PghtGiXwjmO/NkOQeLjV+yqAoDN1lvVoR06ZSfODEIWPoC+9lnP8lB
 Lqas4vsKkFm5bKSKMwIA9ZUn3Nzs1RuwnzZuM9X8DXoN5Jcq7CH8JdWA4Xet3BINAH9h
 EY6qHOKMImES/RKNp9v266bio/khQ6E21QnVo3LEN17j4xPjyHsYj7gJyAZ9dyFm7iJV
 X0yYWulzFC9FCgvMpN7s6VjRe0eeM47fcAUcR7IQZ5wlogF4+UwKrh+PR1IK+jNT3n6P
 bG4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790699910; x=1791304710;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=jfXICf2eAZrH5cVPglTlBbZqyF0HNCWEvqV4CqM39hU=;
 b=lGVqSX9BVSP/EpD+/VZUPAnoNXQQLFSviVpm0/V9zqK8V4h1K2qntc/OWRynBZ1Jah
 MTg6NI3tzfPY+/OzNvNzCgTreVoA4syWvLNDN4RH7eLJZL5gPaehyxYM6qzkzaORhS6A
 4JZW3xKoj4FU4q/xv//wYfqTLMJ4QZpEX3h5nDujSLVz2pgDwPLEaScVUqmJsCtqwCL/
 nhuUNOgGRj5LqjlX8i4kiHKR5Vp0p8I7McfqzGD+z4ss+bL06vJSdI4PVbHnNp2lu5Cu
 opGwMpW31/TKMpJ+UwAgLClRGeRktT/FjhgYOc7Sf2G57PQK2V7k2DoM9N/PMWS/5khS
 kZsw==
X-Gm-Message-State: AFuF++mn+X2KtuQLrMg8p17kBnUjYYw9Ck3T45otLtU3ffkFhe1hMO8x
 svtMRyN2jFP0QiOLvSNB33YDaNXXQyvSZDOJqIOt0Ax4WZqI5wOgnj9S5WK0zGfUEocGwu3bdAT
 3cOsg6Bw=
X-Gm-Gg: AYBFou0okx/fNgfCwMknWal4bt1Ym4fKFxFBlTinbY33mBUSu7UezDE2Xf0G/iMZd+9
 4mqRPZpV4gRYY67kgz9fIQrR8pgben4G2v8UvEuoNOmIoCBA0tx1iKoxad5ourUStB6ZLTV8IOc
 pBNvn3Mmzv1c7q29jrvLSN++NxVdRABiAucYbQY1RnVd3kH7Obw7Apv8hwlDg+zHzEond7lCC9l
 2vljgkOFC05Fb3FIscfmrwF5DC0o9KujbVgJWr0Cw0it60M0nTR3wKu9wEGKZ4ZmVadxtFvlFO/
 px+RSEBhNpsyln7ToqQguI740teinAsTRST0XGw/YagwqKnR6hnFh504N/YQeDyiyBx2XB7dsDN
 bRhFwoOniHM97rEqpR32Y469JVDpnw0hL8AMQF3sEunMa74q4otfR7xZl2gESQWokbuq282bFPm
 Fr8HFOjxcgLZN0I3WsoFTMWOikn1R6LikofdIg+fm/UWMSOJQMjvBaBLMqTSX9z1zm0tnSUt6Yd
 jtWY6oPWfZqVQ3JfCecrhXuwXzFwBPRFGsTyQ==
X-Received: by 2002:a05:6a00:4488:b0:881:5d89:fb93 with SMTP id
 d2e1a72fcca58-8855fa8a8bbmr1971845b3a.15.1790699910515; 
 Tue, 29 Sep 2026 09:38:30 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8868ba02d02sm232392b3a.21.2026.09.29.09.38.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 09:38:30 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2 25/61] net/i40e: use kvargs numeric helpers
Date: Tue, 29 Sep 2026 09:36:28 -0700
Message-ID: <20260929163800.1108305-26-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929163800.1108305-1-stephen@networkplumber.org>
References: <20260914054912.755403-1-stephen@networkplumber.org>
 <20260929163800.1108305-1-stephen@networkplumber.org>
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

Replace the open coded errno and end pointer checks in the multi driver
and VF queue number handlers.

The VF queue number handler also used base 0, so a leading zero silently
selected octal. It is now parsed as a uint16_t, which is the width of
the field it feeds, so a value above 65535 is rejected outright rather
than warned about; anything in range still warns and returns success, so
that a later valid instance of the same argument takes effect.

support-multi-driver is a boolean and the field behind it is already a
bool, so drop i40e_parse_multi_drv_handler() and point
rte_kvargs_handle_bool() at the field.

Note that a value other than 0 or 1 used to log a warning and carry on
with the default. It now fails the probe, like every other malformed
devarg in this series.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/intel/i40e/i40e_ethdev.c | 45 ++++++----------------------
 1 file changed, 9 insertions(+), 36 deletions(-)

diff --git a/drivers/net/intel/i40e/i40e_ethdev.c b/drivers/net/intel/i40e/i40e_ethdev.c
index defdff0378..ad826467de 100644
--- a/drivers/net/intel/i40e/i40e_ethdev.c
+++ b/drivers/net/intel/i40e/i40e_ethdev.c
@@ -14,6 +14,7 @@
 #include <assert.h>
 
 #include <rte_common.h>
+#include <rte_kvargs.h>
 #include <rte_eal.h>
 #include <rte_string_fns.h>
 #include <rte_pci.h>
@@ -1267,33 +1268,6 @@ i40e_init_queue_region_conf(struct rte_eth_dev *dev)
 	memset(info, 0, sizeof(struct i40e_queue_regions));
 }
 
-static int
-i40e_parse_multi_drv_handler(__rte_unused const char *key,
-			       const char *value,
-			       void *opaque)
-{
-	struct i40e_pf *pf;
-	unsigned long support_multi_driver;
-	char *end;
-
-	pf = (struct i40e_pf *)opaque;
-
-	errno = 0;
-	support_multi_driver = strtoul(value, &end, 10);
-	if (errno != 0 || end == value || *end != 0) {
-		PMD_DRV_LOG(WARNING, "Wrong global configuration");
-		return -(EINVAL);
-	}
-
-	if (support_multi_driver == 1 || support_multi_driver == 0)
-		pf->support_multi_driver = (bool)support_multi_driver;
-	else
-		PMD_DRV_LOG(WARNING, "%s must be 1 or 0,",
-			    "enable global configuration by default."
-			    ETH_I40E_SUPPORT_MULTI_DRIVER);
-	return 0;
-}
-
 static int
 i40e_support_multi_driver(struct rte_eth_dev *dev)
 {
@@ -1322,8 +1296,9 @@ i40e_support_multi_driver(struct rte_eth_dev *dev)
 			    "the first invalid or last valid one is used !",
 			    ETH_I40E_SUPPORT_MULTI_DRIVER);
 
-	if (rte_kvargs_process(kvlist, ETH_I40E_SUPPORT_MULTI_DRIVER,
-			       i40e_parse_multi_drv_handler, pf) < 0) {
+	if (rte_kvargs_process_opt(kvlist, ETH_I40E_SUPPORT_MULTI_DRIVER,
+			       rte_kvargs_handle_bool,
+			       &pf->support_multi_driver) < 0) {
 		rte_kvargs_free(kvlist);
 		return -EINVAL;
 	}
@@ -4847,15 +4822,12 @@ static int i40e_pf_parse_vf_queue_number_handler(const char *key,
 		void *opaque)
 {
 	struct i40e_pf *pf;
-	unsigned long num;
-	char *end;
+	uint64_t num;
 
 	pf = (struct i40e_pf *)opaque;
 	RTE_SET_USED(key);
 
-	errno = 0;
-	num = strtoul(value, &end, 0);
-	if (errno != 0 || end == value || *end != 0) {
+	if (rte_kvargs_to_uint(value, 0, UINT16_MAX, &num) < 0) {
 		PMD_DRV_LOG(WARNING, "Wrong VF queue number = %s, Now it is "
 			    "kept the value = %hu", value, pf->vf_nb_qp_max);
 		return -(EINVAL);
@@ -4865,9 +4837,10 @@ static int i40e_pf_parse_vf_queue_number_handler(const char *key,
 		pf->vf_nb_qp_max = (uint16_t)num;
 	else
 		/* here return 0 to make next valid same argument work */
-		PMD_DRV_LOG(WARNING, "Wrong VF queue number = %lu, it must be "
+		PMD_DRV_LOG(WARNING, "Wrong VF queue number = %hu, it must be "
 			    "power of 2 and equal or less than 16 !, Now it is "
-			    "kept the value = %hu", num, pf->vf_nb_qp_max);
+			    "kept the value = %hu", (uint16_t)num,
+			    pf->vf_nb_qp_max);
 
 	return 0;
 }
-- 
2.53.0

