Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20A57C88E50
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Sep 2026 05:52:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3321640E21;
	Mon, 14 Sep 2026 07:50:49 +0200 (CEST)
Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com
 [74.125.227.141])
 by mails.dpdk.org (Postfix) with ESMTP id 4F5E4406B4
 for <dev@dpdk.org>; Mon, 14 Sep 2026 07:50:48 +0200 (CEST)
Received: by mail-pj2-f13.google.com with SMTP id
 98e67ed59e1d1-396ccc09d65so1581449a91.3
 for <dev@dpdk.org>; Sun, 13 Sep 2026 22:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789365047;
 x=1789969847; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/825DAaqlangLKnMdov/F5Ofwis15Us/eDETpHQTFu8=;
 b=h+JWohCusQzf8PIhpPA7HYdPPN8CYhhbr4678rr6YjcRdxE5rhYalrbhh9Uw0M+GNF
 98kxuj6AahYpenurEidNFpjI2AXRUUrHtbmyfSCVZdHUsTFDuaN2IlBva8ltCcnZ/RrJ
 vbqVEBvX+mG091bMUL0bwOpc0LnylrIyDmbX9aUGPB6TvCk6VwZ2Uemcgl/RtWyC1R1i
 UWBz1Wx+w18xpkN6Onyu4m2n/ix/XOpwIA530oybXq9C/WjYHtqbTw4+96yX7ALp8duA
 NCh2VYaPGJ6e7ruIzWNOT2wJ2w7Jw2Dxu0JpcQcw5/Yp5MSjlb+cGkd7gsOEruvIT2zt
 nMsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789365047; x=1789969847;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=/825DAaqlangLKnMdov/F5Ofwis15Us/eDETpHQTFu8=;
 b=AZUQN+AWiOStkYG/vve/YhVyV4OU8WKJxM+8j2wYggtqcDjxRuI9D2YpIrrn16V00P
 7TCNKlOjrzzs4RZVcAFP/H/dxImBRtr5XYzPe3Z3+r4JZTHc9rqJ63QyGl4jotOjuKYX
 cJc84e0YGEqCJ67IFpJF8YzZHMz17VoEyyDS5w2OlWLUtw06+yzFAhzbxBNp5AwLcjZz
 i75E0N5HiOcYdUrpNgYpiuncYQebnjbjdE6wXBuC/n86DzcYz0ng81jvdibEIJvbZqpz
 ibqcXPiJTc6Nbtg7D8zpsOs0V/8cag+/DHvnIscxblFO5l1f4pUTCb6OwOm25AYc2Uea
 dvDQ==
X-Gm-Message-State: AFuF++k8L2qF6YN4f9TjGCfCVMjbG8qIrAFj2Vvwy6Z0IkV7n4ztzqw9
 aDfydyYnxQYN4v5rfWNoxIv2mcidSDnM+VrYUoLrOc1TyRtQJoc05pDJOj8KJvDg1gSIUAAfXpi
 NhBj0hsc=
X-Gm-Gg: AYBFou2EJ8YGzwX3I1MELbdosSxSx4mT3JYc//wCHywXTU5duFoX+krWAn3xZnhAlQW
 1dX4NJZXbiDI4xcav+rMbIS7TWSqMjLl6sv1LOU40qqcSe5VhgNQ183JOxZO6aBicsoo3B2xvHi
 4hCWl+cdbYZM4jyYX9boh+Qs4cOqG0xK+o5DtTm5GpWvWkW4ZS8Ocv/QlJ/q3iYRzCOvicVBJho
 /1y/banFwMeG+S1xv4giHfSw0KHHu3OYHMZii1NSRPIfgiZUm4LwyDDxSyWGnRnmQ3kWG28tsz6
 uNx/ALud17LkrPYB6Q7W3HimSUxJ/3kvYt5aTrJ0LOXXyq6S3xoN94k3WCawGmJ2wB+28CcP5N4
 t8flNx9HoVl/lNQl7phxHtUEdjkqTkuwPrXuAvFdtO8e8ZSBM+y6otdVROaMHC0pCbisUvPcvi+
 4sUFvN0bWBr8Y1ax5LeWQAbAUEs5hGT6LtrgA3m+W82c+avYAfYjT2hCmBEnoSLzUASfSIBqE2V
 93KqIsDEb/xYRvO1TUJAwi82ILslDD7U76YCA==
X-Received: by 2002:a17:90b:3e4f:b0:398:ba96:1afd with SMTP id
 98e67ed59e1d1-39debfa303amr2752349a91.8.1789365047425; 
 Sun, 13 Sep 2026 22:50:47 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39d95864b4fsm19794492a91.15.2026.09.13.22.50.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 22:50:47 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH 26/62] net/i40e: use kvargs numeric helpers
Date: Sun, 13 Sep 2026 22:46:57 -0700
Message-ID: <20260914054912.755403-27-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260914054912.755403-1-stephen@networkplumber.org>
References: <20260914054912.755403-1-stephen@networkplumber.org>
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
index b6b2d291ee..3b17281952 100644
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
@@ -4831,15 +4806,12 @@ static int i40e_pf_parse_vf_queue_number_handler(const char *key,
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
@@ -4849,9 +4821,10 @@ static int i40e_pf_parse_vf_queue_number_handler(const char *key,
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

