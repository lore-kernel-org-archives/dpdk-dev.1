Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C72D7C88E67
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Sep 2026 05:51:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 31DEE40E1F;
	Mon, 14 Sep 2026 07:50:47 +0200 (CEST)
Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com
 [74.125.227.141])
 by mails.dpdk.org (Postfix) with ESMTP id 7AFFA4068A
 for <dev@dpdk.org>; Mon, 14 Sep 2026 07:50:45 +0200 (CEST)
Received: by mail-pj2-f13.google.com with SMTP id
 d9443c01a7336-2db1ca069c8so13403835ad.3
 for <dev@dpdk.org>; Sun, 13 Sep 2026 22:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789365044;
 x=1789969844; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9864fODZizXaTtbQ0KtRCgMRdepjCijI3EE67g0L+f4=;
 b=F6Fc/wA+WjPEIk0lnJnJ9Lvrt8RuyFMjk5yZW2b0AXhgel5WkHf4zdNW+lqa/c7t4M
 /PAuotgn0pnpBmtk6tbvrLcdTfy12OM89joIldBkAd8QvjOEZ/eKpgoNTVQ6armyaVOw
 pe0mQJ7VzAsKiaHmtz46XcBngPiGpkAh5RPiw7BYFHWrFtDDV0teSjWvwwgxV9mnRST1
 UOU44seI18C2210ldvA/KNJ8QIDUWMndtcXl7x690cwOIABcM7r7U4OSk2XsPcZPB27K
 v+IuGGqzrgDdpd3k7VSx2UGej6oMJ2/acI5G9lGBY7FMhLuxmT4UW3yeEqfQFYbOp3ie
 YlEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789365044; x=1789969844;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=9864fODZizXaTtbQ0KtRCgMRdepjCijI3EE67g0L+f4=;
 b=giF9By/weEoLwhYi4sKhlci/J/tqguFIVg6IVxD8fxNuFZEeuP++BHsw/GL4EWCR+x
 MX8IdcwoL+UZRWpnQy/yuGINwn1YA1BIaRkspuEITOkfTLwFuLm8LHOkXBDskdZkaZGa
 /sglY2p+BdgdWmDDhTv8HjOrGwPRN8T2J/dN4F8/VmcK8DYnz0rmNPBRN2GHdof9aDx0
 2H8qcFGpUyPVwX4z7HnLmZtOfkf7pcJYIPCbWRFYp9l7yDkWQpZOL53YkG4FWsu5bQzQ
 SQ3j0s0OJC9F4lfa8IC7MPc89JKacGFs4H+OD7bN4uFppNvMEc9IqDj1U5RXRW229MPk
 Go8g==
X-Gm-Message-State: AFuF++kSBhiqIMMiYdGEboWvStkdR0Iyc/k/fhA/8AR8SmQuYO3N1j/O
 OP+wjwgq0ovMNGahVaMhGWAXlHWJy34VuVvh+hRSJhiEhxbsvwF3IBLacaBb5na3yu5E+PDwemI
 5k5jZIZE=
X-Gm-Gg: AYBFou2qOf9bnGH8cVz7XbA8OkcMWGieL13KHTFMocgUByA06/jphcXz6BvisJMpunk
 cCdJ0eCXtO08Lzwiyp5/5/5faBt8ntue3iEZk+ldiDlRckYrmSVjnrlc+u2guVoLINlkUVAqIw5
 hjVPHcrLLghPrGTrjYHFZsNTu+zWWtxaULAav7K+ldbpVtOgrnIhnB0hB9Fr5fPCh1QYUx6p5ak
 PlGllbpQHJcccBlDGDGwRlcDFVXC41dhe+JewsNEiSHR8ZDt1orcTmw+kPUa01snB/0GN2Ua4qD
 Bdp4fRzawmG08VdR/okCltnutltV+/F+21IBCugnHv8wgZrS1d106dPFw0FMCizwB7BxVAF1YQV
 Q7rwl7m4mWcJhQrbKETUk1mZdDIjSqDUi/kQwRTdK41/F/cdi9hk6YHBw6s3RoXjfxbqMGwCjIl
 Si8ghnMfjZ4b/gl9eCncnqMZTCeMbXJ4M/l+DjqtXA51NFgYV0Cl9mlXFlX3shw2ddnBuIrIjnu
 moWy7fh5pvQT783AVTyfEpywAbOVkibXiSqpw==
X-Received: by 2002:a17:90b:5624:b0:38e:67e1:15b with SMTP id
 98e67ed59e1d1-39debf93f0dmr2675532a91.6.1789365044495; 
 Sun, 13 Sep 2026 22:50:44 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39d95864b4fsm19794492a91.15.2026.09.13.22.50.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 22:50:44 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH 25/62] net/iavf: use kvargs numeric helpers
Date: Sun, 13 Sep 2026 22:46:56 -0700
Message-ID: <20260914054912.755403-26-stephen@networkplumber.org>
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

parse_u16() ignores the end pointer, so "8junk" is accepted, and assigns
a u64 into a u16 without a range check, so "65536" wraps to zero. Zero
is still rejected, as it is the unset marker for quanta_size.

parse_bool() checks neither errno nor the end pointer.

iavf_parse_watchdog_period() uses atoi(), which cannot report an error
at all, so a malformed value becomes zero and the negative check never
fires.

no-poll-on-link-down, auto_reset, auto_reconfig and enable_ptype_lldp
are booleans, so make the fields bool and use rte_kvargs_handle_bool().
That is every caller of the local parse_bool(), so it goes away too. A
bare key now enables the option, and the usual spellings are accepted.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/intel/iavf/iavf.h        |  8 ++--
 drivers/net/intel/iavf/iavf_ethdev.c | 61 +++++++++-------------------
 2 files changed, 24 insertions(+), 45 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf.h b/drivers/net/intel/iavf/iavf.h
index 293adaf6c9..6bfe07e1b0 100644
--- a/drivers/net/intel/iavf/iavf.h
+++ b/drivers/net/intel/iavf/iavf.h
@@ -322,11 +322,11 @@ struct iavf_devargs {
 	uint8_t proto_xtr[IAVF_MAX_QUEUE_NUM];
 	uint16_t quanta_size;
 	uint32_t watchdog_period;
-	int auto_reset;
-	int auto_reconfig;
-	int no_poll_on_link_down;
+	bool auto_reset;
+	bool auto_reconfig;
+	bool no_poll_on_link_down;
 	uint64_t mbuf_check;
-	int enable_ptype_lldp;
+	bool enable_ptype_lldp;
 };
 
 struct iavf_security_ctx;
diff --git a/drivers/net/intel/iavf/iavf_ethdev.c b/drivers/net/intel/iavf/iavf_ethdev.c
index d601ec3b6a..273040d8a5 100644
--- a/drivers/net/intel/iavf/iavf_ethdev.c
+++ b/drivers/net/intel/iavf/iavf_ethdev.c
@@ -3,6 +3,7 @@
  */
 
 #include <ctype.h>
+#include <limits.h>
 #include <sys/queue.h>
 #include <stdalign.h>
 #include <stdio.h>
@@ -13,6 +14,7 @@
 #include <stdarg.h>
 #include <inttypes.h>
 #include <rte_byteorder.h>
+#include <rte_kvargs.h>
 #include <rte_common.h>
 #include <rte_os_shim.h>
 
@@ -2352,11 +2354,10 @@ static int
 parse_u16(__rte_unused const char *key, const char *value, void *args)
 {
 	u16 *num = (u16 *)args;
-	u16 tmp;
+	uint64_t tmp;
 
-	errno = 0;
-	tmp = strtoull(value, NULL, 10);
-	if (errno || !tmp) {
+	/* zero is not accepted, it is the "unset" marker for this argument */
+	if (rte_kvargs_to_uint(value, 1, UINT16_MAX, &tmp) < 0) {
 		PMD_DRV_LOG(WARNING, "%s: \"%s\" is not a valid u16",
 			    key, value);
 		return -1;
@@ -2367,35 +2368,13 @@ parse_u16(__rte_unused const char *key, const char *value, void *args)
 	return 0;
 }
 
-static int
-parse_bool(const char *key, const char *value, void *args)
-{
-	int *i = (int *)args;
-	char *end;
-	int num;
-
-	num = strtoul(value, &end, 10);
-
-	if (num != 0 && num != 1) {
-		PMD_DRV_LOG(WARNING, "invalid value:\"%s\" for key:\"%s\", "
-			"value must be 0 or 1",
-			value, key);
-		return -1;
-	}
-
-	*i = num;
-	return 0;
-}
-
 static int
 iavf_parse_watchdog_period(__rte_unused const char *key, const char *value, void *args)
 {
 	int *num = (int *)args;
-	int tmp;
+	uint64_t tmp;
 
-	errno = 0;
-	tmp = atoi(value);
-	if (tmp < 0) {
+	if (rte_kvargs_to_uint(value, 0, INT_MAX, &tmp) < 0) {
 		PMD_DRV_LOG(WARNING, "%s: \"%s\" is not greater than or equal to zero",
 				key, value);
 		return -1;
@@ -2466,9 +2445,9 @@ static int iavf_parse_devargs(struct rte_eth_dev *dev)
 	int ret;
 	int watchdog_period = -1;
 
-	ad->devargs.auto_reset = 1;
-	ad->devargs.no_poll_on_link_down = 1;
-	ad->devargs.auto_reconfig = 1;
+	ad->devargs.auto_reset = true;
+	ad->devargs.no_poll_on_link_down = true;
+	ad->devargs.auto_reconfig = true;
 
 	if (!devargs)
 		return 0;
@@ -2502,8 +2481,8 @@ static int iavf_parse_devargs(struct rte_eth_dev *dev)
 	else
 		ad->devargs.watchdog_period = watchdog_period;
 
-	ret = rte_kvargs_process(kvlist, IAVF_NO_POLL_ON_LINK_DOWN_ARG,
-				 &parse_bool, &ad->devargs.no_poll_on_link_down);
+	ret = rte_kvargs_process_opt(kvlist, IAVF_NO_POLL_ON_LINK_DOWN_ARG,
+				 rte_kvargs_handle_bool, &ad->devargs.no_poll_on_link_down);
 	if (ret)
 		goto bail;
 
@@ -2520,24 +2499,24 @@ static int iavf_parse_devargs(struct rte_eth_dev *dev)
 	if (ret)
 		goto bail;
 
-	ret = rte_kvargs_process(kvlist, IAVF_ENABLE_AUTO_RESET_ARG,
-				 &parse_bool, &ad->devargs.auto_reset);
+	ret = rte_kvargs_process_opt(kvlist, IAVF_ENABLE_AUTO_RESET_ARG,
+				 rte_kvargs_handle_bool, &ad->devargs.auto_reset);
 	if (ret)
 		goto bail;
 
-	if (ad->devargs.auto_reset != 0 && ad->devargs.no_poll_on_link_down == 0) {
+	if (ad->devargs.auto_reset && !ad->devargs.no_poll_on_link_down) {
 		PMD_INIT_LOG(WARNING,
 			"no-poll-on-link-down=0 is incompatible with auto_reset=1, ignoring");
-		ad->devargs.no_poll_on_link_down = 1;
+		ad->devargs.no_poll_on_link_down = true;
 	}
 
-	ret = rte_kvargs_process(kvlist, IAVF_ENABLE_AUTO_RECONFIG_ARG,
-				 &parse_bool, &ad->devargs.auto_reconfig);
+	ret = rte_kvargs_process_opt(kvlist, IAVF_ENABLE_AUTO_RECONFIG_ARG,
+				 rte_kvargs_handle_bool, &ad->devargs.auto_reconfig);
 	if (ret)
 		goto bail;
 
-	ret = rte_kvargs_process(kvlist, IAVF_ENABLE_PTYPE_LLDP_ARG,
-				 &parse_bool, &ad->devargs.enable_ptype_lldp);
+	ret = rte_kvargs_process_opt(kvlist, IAVF_ENABLE_PTYPE_LLDP_ARG,
+				 rte_kvargs_handle_bool, &ad->devargs.enable_ptype_lldp);
 	if (ret)
 		goto bail;
 
-- 
2.53.0

