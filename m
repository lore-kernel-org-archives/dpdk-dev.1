Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B69BCD6E7C
	for <dpdk-dev@archiver.kernel.org>; Fri,  5 Jun 2026 22:45:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BB6B6402E5;
	Sat,  6 Jun 2026 00:45:21 +0200 (CEST)
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com
 [74.125.82.178]) by mails.dpdk.org (Postfix) with ESMTP id ED55740298
 for <dev@dpdk.org>; Sat,  6 Jun 2026 00:45:19 +0200 (CEST)
Received: by mail-dy1-f178.google.com with SMTP id
 5a478bee46e88-304ddfcf72cso2490458eec.0
 for <dev@dpdk.org>; Fri, 05 Jun 2026 15:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1780699519;
 x=1781304319; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w75PfzCTOyXM9ty3FpUDKzYu3dn/kaV6NIDyJRt6bZc=;
 b=DdWe5g1V3LfuUOjXNP/k4ReA9ZMZ6dlSO5pNc058eTFKkmVuY+sxolIi0HXcB2Utwg
 cMmwzbNF8tlJVhVyWL0rgHljhxerENzFpTS2WP7bl8elp2RTScFKOQKiq83uzmm37eZm
 /uI/JteRAhFH+nfjcvhB4kw/rTRJDNc0w3JNXReLlEp8Dctoz8W5DHje5K//f4vsZZ8b
 pFEan7WCqLZlhK6LVx1MUV2+ER/3KyZSaqzl8VFVXcZwLhTam78UFVTGR50F4vqPNuVj
 eF9tttUWJ8RxvxBn5lELvlTUrL1dkwkXD7zivibQpjrnH6U3jblhvDl5ufMdCpaO4WIk
 AX0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780699519; x=1781304319;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=w75PfzCTOyXM9ty3FpUDKzYu3dn/kaV6NIDyJRt6bZc=;
 b=f/eBYK1XNEOvRb1+GTDedckzY0lCnxLrSvcxDxk3ttdNTt1wxsu042mcC60J1kbw35
 tGhvP+qappgJMTaJ/GqGd0S7VxmIq6xt78v4zeBniKkCiuPAgfbCQ6UZhLowQyz7o674
 BSoZPj10hEaZgJZoeHNgbrjWeyVzvgpc59p0bPdzXm/Ai8Vu2RgHnqEhsgDuYvky+jew
 16J5fYCABhv85tBoCDXkzlSHF0Ls8oATU4D8t3+Xp2SzqiclI4A/L7RbsUrEy3ql2oHf
 fKi8qaoB/JYigWXMFWTUKqVqNvTpJ5IFNDMF84Q9GRYjCHXBUpYivZX4N6jruAEvqsce
 rjbg==
X-Gm-Message-State: AOJu0YwPgGcHwxFAF2STZyj75J2ZSds0/Uvng9V1RussY4j+zbemt0MU
 +9ij7R1JMVTxbqXA5FrBF7DA2IJb2v1GE8SO5LN5TKtx4JYxPBHP2CTSfJt/iS3gZahjr/ZzqX/
 xGkwW
X-Gm-Gg: Acq92OHFVS828X6Q2U52LjzLzePCV3ef0B8ftoKheI+elYMlWwLOzQLTPrBVSTJ5iVh
 6QYQhx6odpZcsrrnUseweFkTIyhXTRC1dnGt6zCSafM1IygdLN/ZigZtKPv61qLKhKeM+knGMUB
 46d+KUVOs1AL8qw16nQeH+B6q+5rfkuZG2sJ9r1Smny9VrEs2XzKsDGHILWYuPm0TMIEHupwq2H
 LVQIp/3XegDxUhcOICX7Gw4X3uy7aW77o+Zna4xPWHHl4jVnA6TsBQ3mJL+bzc+dgkdypQw8iYU
 rNvTI4c8T5JoCiRE41RPiJrwEaUf+GHCGPx7zByUn1VVNQho0NQXFobhpZ3gG9ySsKHZ8vkBsfg
 +hWJQ4nrDRVsPeiG8KD8JtcESXsDbraIZsUAJjgED2vENZBpHRuE5ioAE+cDmYe+Z1JUW/xYx/G
 MnYkkmjg8hjULMLUJOsLWUF7onSWLxNhOSvqXoihcf83gl/B1waZLOm1UX2bqk8ZXhPgTPOo9M
X-Received: by 2002:a05:7300:320c:b0:304:e7c9:b528 with SMTP id
 5a478bee46e88-3077b2f4881mr2618961eec.30.1780699518660; 
 Fri, 05 Jun 2026 15:45:18 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3074df8076csm9681306eec.29.2026.06.05.15.45.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2026 15:45:18 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>,
 Sunil Kumar Kori <skori@marvell.com>, Satha Rao <skoteshwar@marvell.com>,
 Harman Kalra <hkalra@marvell.com>,
 Rakesh Kudurumalla <rkudurumalla@marvell.com>
Subject: [PATCH 1/2] net/cnxk: fix telemetry SA info parameter parsing
Date: Fri,  5 Jun 2026 15:44:39 -0700
Message-ID: <20260605224514.651081-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260605224514.651081-1-stephen@networkplumber.org>
References: <20260605224514.651081-1-stephen@networkplumber.org>
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

The /cnxk/ipsec/sa_info handler would silently wrap 32 bit value
to 16 bit port id.
An out-of-range port such as 65536 narrowed to a valid port
for the check and then read past the array.
Reject port ids >= RTE_MAX_ETHPORTS before the lookup.

The /cnxk/ipsec/info handler has similar issue with
strtoul().

Rework parse_params() to walk the string with strtoul()/endptr
rather than strtok(), which is not thread safe and races when the
telemetry callbacks run on per-connection threads. This drops the
strdup()/free(), range checks each value against UINT32_MAX, and
passes an unsigned char to isdigit().

Fixes: d74ed1628f7e ("net/cnxk: add SA info telemetry")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/cnxk/cnxk_ethdev_sec_telemetry.c | 50 ++++++++++----------
 1 file changed, 24 insertions(+), 26 deletions(-)

diff --git a/drivers/net/cnxk/cnxk_ethdev_sec_telemetry.c b/drivers/net/cnxk/cnxk_ethdev_sec_telemetry.c
index 86c2453c09..0c1533e3d7 100644
--- a/drivers/net/cnxk/cnxk_ethdev_sec_telemetry.c
+++ b/drivers/net/cnxk/cnxk_ethdev_sec_telemetry.c
@@ -211,33 +211,30 @@ copy_inb_sa_10k(struct rte_tel_data *d, uint32_t i, void *sa)
 static int
 parse_params(const char *params, uint32_t *vals, size_t n_vals)
 {
-	char dlim[2] = ",";
-	char *params_args;
 	size_t count = 0;
-	char *token;
 
-	if (vals == NULL || params == NULL || strlen(params) == 0)
+	if (params == NULL || !isdigit((unsigned char)params[0]))
 		return -1;
 
-	/* strtok expects char * and param is const char *. Hence on using
-	 * params as "const char *" compiler throws warning.
-	 */
-	params_args = strdup(params);
-	if (params_args == NULL)
-		return -1;
+	while (count < n_vals) {
+		char *end;
+		unsigned long v;
 
-	token = strtok(params_args, dlim);
-	while (token && isdigit(*token) && count < n_vals) {
-		vals[count++] = strtoul(token, NULL, 10);
-		token = strtok(NULL, dlim);
-	}
+		errno = 0;
+		v = strtoul(params, &end, 10);
+		if (errno != 0 || v > UINT32_MAX)
+			return -EINVAL;
+		vals[count++] = v;
 
-	free(params_args);
+		if (*end == '\0')
+			break;
 
-	if (count < n_vals)
-		return -1;
+		if (*end != ',' || !isdigit((unsigned char)end[1]))
+			return -EINVAL;
+		params = end + 1;
+	}
 
-	return 0;
+	return count == n_vals ? 0 : -EINVAL;
 }
 
 static int
@@ -252,13 +249,13 @@ ethdev_sec_tel_handle_sa_info(const char *cmd __rte_unused, const char *params,
 	uint32_t i;
 	int ret;
 
-	if (params == NULL || strlen(params) == 0 || !isdigit(*params))
-		return -EINVAL;
-
 	if (parse_params(params, vals, RTE_DIM(vals)) < 0)
 		return -EINVAL;
 
 	port_id = vals[0];
+	if (port_id >= RTE_MAX_ETHPORTS)
+		return -EINVAL;
+
 	sa_idx = vals[1];
 
 	if (!rte_eth_dev_is_valid_port(port_id)) {
@@ -320,12 +317,13 @@ ethdev_sec_tel_handle_info(const char *cmd __rte_unused, const char *params,
 	struct cnxk_eth_sec_sess *eth_sec, *tvar;
 	struct rte_eth_dev *eth_dev;
 	struct cnxk_eth_dev *dev;
-	uint16_t port_id;
+	unsigned long port_id;
 	char *end_p;
 
-	if (params == NULL || strlen(params) == 0 || !isdigit(*params))
+	if (params == NULL || !isdigit((unsigned char)*params))
 		return -EINVAL;
 
+	errno = 0;
 	port_id = strtoul(params, &end_p, 0);
 	if (errno != 0)
 		return -EINVAL;
@@ -333,8 +331,8 @@ ethdev_sec_tel_handle_info(const char *cmd __rte_unused, const char *params,
 	if (*end_p != '\0')
 		plt_err("Extra parameters passed to telemetry, ignoring it");
 
-	if (!rte_eth_dev_is_valid_port(port_id)) {
-		plt_err("Invalid port id %u", port_id);
+	if (port_id >= RTE_MAX_ETHPORTS || !rte_eth_dev_is_valid_port(port_id)) {
+		plt_err("Invalid port id %lu", port_id);
 		return -EINVAL;
 	}
 
-- 
2.53.0

