Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E28ADCA5FC5
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Sep 2026 22:46:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1011442EEF;
	Thu,  1 Oct 2026 00:44:14 +0200 (CEST)
Received: from mail-pj2-f39.google.com (mail-pj2-f39.google.com
 [74.125.227.167])
 by mails.dpdk.org (Postfix) with ESMTP id 4016442EDA
 for <dev@dpdk.org>; Thu,  1 Oct 2026 00:44:11 +0200 (CEST)
Received: by mail-pj2-f39.google.com with SMTP id
 98e67ed59e1d1-3a4805e15cfso2016639a91.0
 for <dev@dpdk.org>; Wed, 30 Sep 2026 15:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790808250;
 x=1791413050; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jfXICf2eAZrH5cVPglTlBbZqyF0HNCWEvqV4CqM39hU=;
 b=HAB6Sbu5aTYkoPk0LJYCc7RaJelikXKWFahqc74//6bFfIB0SQ8ohFaMdGy6i6S5Vb
 gFSINg9S3u4SJjvdZg5dfMzyDYvuXxpVP2XJqDyFC+jcWvCmRiiHcBJeLnOMytT5lLws
 hVFADHLJWyYHH03buMztVty4mBvAjLBGj2TtWgncX//wp31SSQ6QoP6BjldVvr/pBMW9
 a/hG4KWFL4ZG8i0+faZBNQcq2U1D/s4Q3gxAzjktNGtj/NceVVHSjfOkdYZFE17HLHxO
 LeR5M5ZXMESRc3muOh9xld3Hho71vofaPi6C1M81D9UvX/O0DF1DO66BoOr72hEaJGD5
 jBfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790808250; x=1791413050;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=jfXICf2eAZrH5cVPglTlBbZqyF0HNCWEvqV4CqM39hU=;
 b=hzL043wZ699111IK+TnvS92Z5BvWEXmdvuC6QyybL2mSHWlteZgicMuBGWgshhGpUG
 vScWuvDScSZvFIxwIxe45GuKlxRbOgUCdWr0uKkVUzrVUzb7s9UAcwEEQ5pZSQcquG7F
 CusRc01Pv7C5/KIRWDBJG+MlC1uR1ujluBGNrb/kqcPQMAqTf6ATy+FRq+0oGghJr2OM
 oAwNfv6GzEHd7BYbKktyZueTWpsUx+NGS4QqgYdWpYPcHYN1WdMW71g/p/DbqoeQ8UVk
 Yt+pBx0a5vDCvv6m+cas08VDin7AZ27hB+pjoqsO4oQfOXPUkjrylG4dZz5hEqcuFU4R
 a1YA==
X-Gm-Message-State: AFq9FYKiHvkP/toEwOzyxU2eK4vC0S6G1prnkCs/My5rhCZ4g6rQ1sGh
 yZ/kreTASNhnW5KXAOBWHDImwtRoYztqWpGSSAXNzVlyF3UHSqtmlq5IfTSHbwG38fGPUV9RiUy
 Ioff8u1s=
X-Gm-Gg: AYBFou0xlpAOYr3+5qRr99vkdrOXw9CyXPoCp2w/3L4X3zOOxff3iT/SdKpmnwXBjoA
 ahTwrdU4YDEFcKVqo8rH3P1rx/Ssb7nYaBKDG1ar7T2Qo4zYrfHNr83UenLzpqk0kzTv0aOh28K
 0NUTrjBjGRpxCOjy1bXKZ9b7vgwTlWaFuB3yAWvZZHA7g8U7V7m8g0mQOvxhf5ctzocHsPjp7iS
 f9kdQGecfOlK4het1VJeZ3+h7FXyhKS4iMCTH1IGIiO7ms7iAQuQsHuAJdWuVuPQM980SkASszi
 iRBfa7+6vnWwPG/w4ifSxYp3uvGeS8We1tZnq5ALYfcXY/uokTU7PdcwB99eDEXWD/xy2VKJqeN
 /4Izmb7WWASJs283lVwnNipQ3/C127Qa32PQpN7WJMB324rZu+TQJh88a29TUHT1qemI8P5VdU3
 +aAnktYmwP4Wu0xUgSTrQ/KjVuLE4jejfjerXIBxYl1ICEgQOIPrm1+gHU0bxqgpnWVXsIWhPHh
 NcXyMfu03qaGbhiGlWRJPIe6JfYVFIWDVKbnw==
X-Received: by 2002:a17:90b:5384:b0:3a4:96f7:583e with SMTP id
 98e67ed59e1d1-3a4d18f39f2mr2366032a91.60.1790808250379; 
 Wed, 30 Sep 2026 15:44:10 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a4f4371383sm1258985a91.2.2026.09.30.15.44.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 15:44:10 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v3 26/65] net/i40e: use kvargs numeric helpers
Date: Wed, 30 Sep 2026 15:40:44 -0700
Message-ID: <20260930224340.58580-27-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930224340.58580-1-stephen@networkplumber.org>
References: <20260914054912.755403-1-stephen@networkplumber.org>
 <20260930224340.58580-1-stephen@networkplumber.org>
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

