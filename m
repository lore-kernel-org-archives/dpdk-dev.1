Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89E31CD6E7C
	for <dpdk-dev@archiver.kernel.org>; Fri,  5 Jun 2026 20:53:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0AD3B40695;
	Fri,  5 Jun 2026 22:53:07 +0200 (CEST)
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com
 [209.85.219.50]) by mails.dpdk.org (Postfix) with ESMTP id AEB4D40677
 for <dev@dpdk.org>; Fri,  5 Jun 2026 22:53:05 +0200 (CEST)
Received: by mail-qv1-f50.google.com with SMTP id
 6a1803df08f44-8ccd1f57b32so22790496d6.2
 for <dev@dpdk.org>; Fri, 05 Jun 2026 13:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1780692785;
 x=1781297585; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8wNO5RFbrhgW8QZU9blP2dClilx5NljROwNQaSnwQlY=;
 b=pwErbjoRVzvOqvolmldV5Rf4cVFxQSa2YOKa3fjVYfKtJfhG7dST++dXFmK+O92oKx
 PA8RrzJMbbyO9M8ty/jHqd2OlGe5BsfZ9Hn9jumzBwjYvPCkGKot3CJb8CXXjHZf2hNa
 EJ3QaKuLt0PNPiEGYXTRU7z0nZqi93bd88V3W7eXlUBQyg7f3Ne1m3zcHVERXwxtufnS
 FcnhrELzdUho1umm6wQLfokSME+1ngo35/5DaxtTtUVl7t3Tdh/aTORcZDLnyKLdH0rq
 PjkJfGYTKFDYUktXFpkjeAK3x8FB5Cm5FQAN3Bstn+gMbMTjn33PpMtTq4jiReIAcsUd
 oZ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780692785; x=1781297585;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8wNO5RFbrhgW8QZU9blP2dClilx5NljROwNQaSnwQlY=;
 b=Y3Q28esbv8kwBF1wcPc4I2V8PYezG/oJDl7ANxLnLXPMPL1DKwlF21BcxUD07vFM/a
 SzgqPsSERhmiUL6lSEG2cWzp/KzptxTTgh0tnGLp9yfIxnpriqFA/r6IwBgHhemLtqGP
 BIP8rASnOzIKXvjF+1KJgjbvOFqK6hFq/s2Y5ZNKfWlV0vK7NN3/szN/E9UhX3gPWFBG
 twbRuD/h721Hc7s5euqEoj3y1xKBIVvnNhWP7UGx4SRTOPQJvRXlBQ+fr69H53kEmH1d
 R+m0B4fAqN59ea4Th4Xh9s34+sqTs7XuLnpObs2Dd+4bYqWfwrDDCaGdd9uheUzbnb3L
 7wMg==
X-Gm-Message-State: AOJu0YwOsj9SK1mhTJQfA1tf6ipYKgv1J+yO8kx9m1ooNU65e7vrypEM
 iTISZ0xGtBqNRjdMdyhdBW/9SloCjslrbG0hNOE9LL6mf8Z5fOGl2mES8R1TImavrL2cVzsGmiw
 QDDFp
X-Gm-Gg: Acq92OGXr/ZdkLwnHr5Q1Qg/xXhAwaXXw6H0F96uBdR9uC6EyN4rlacA6OdZeZWF9pa
 Vrhsotlftz9C38PbJXbS0N84HYobSgR67x9F2+BQO86ero9/0iD0lg27s1diz4k2bzOVZS0bYlt
 +1sinBPrLFhVHTB+tUu3k6+9sVJWXxiENZg90Jb89YZ8kSdZgUlywHFvJL8w8nAVdMZT2tbsqyj
 RAcK3oSqjfcfIOAtx/UzCk+kZsRu3W1lFYIeKQ/LlEsZNsqpQcAlefV6tCR8NiSuruWai3INwFR
 ZLGuJldi5QdFSx54M720NG4lpyOo34lnOyIUBhXHepWt6JY3nk28NshCPrgVnf4kmxcCZMGVkhU
 QtYTqRZrkUBGZC8kuk/0UrCqLWToJBp+Al7MW+xteH+EdTYvWKjJ/GMbiVMa74ZgKp/snhqUHrI
 qp7Nf8zJm6lP+Gd9g28QVa4gI6MlyG+RWQqHWsXRMfdKXQvJ/qm3twv9ldNYJAcWr2Lnsz3mht
X-Received: by 2002:a05:6214:8109:b0:8ca:10cc:fdbc with SMTP id
 6a1803df08f44-8cee611feebmr61726356d6.23.1780692784822; 
 Fri, 05 Jun 2026 13:53:04 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8cecd2629cesm90072906d6.41.2026.06.05.13.53.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2026 13:53:04 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Jerin Jacob <jerinj@marvell.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH 5/8] eventdev: remove strtok from telemetry handlers
Date: Fri,  5 Jun 2026 13:51:02 -0700
Message-ID: <20260605205253.520196-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260605205253.520196-1-stephen@networkplumber.org>
References: <20260605205253.520196-1-stephen@networkplumber.org>
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

The eventdev telemetry command handlers parsed parameters with strtok()
which is not thread safe. The code also has silent truncation
issues since it assigns result of strtoul() to smaller types.

Introduce common helper that checks parameter string
and gets a device id. Make sure and range check values
to the appropriate upper bound for that parameter.

Fixes: feaea0573429 ("eventdev: add device info telemetry command")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/eventdev/rte_eventdev.c | 136 +++++++++++++++++-------------------
 1 file changed, 64 insertions(+), 72 deletions(-)

diff --git a/lib/eventdev/rte_eventdev.c b/lib/eventdev/rte_eventdev.c
index 572cd5bd7d..a6f6b6879e 100644
--- a/lib/eventdev/rte_eventdev.c
+++ b/lib/eventdev/rte_eventdev.c
@@ -1790,6 +1790,34 @@ handle_dev_list(const char *cmd __rte_unused,
 	return 0;
 }
 
+/* Get dev ID from parameter string */
+static int
+parse_dev_id(const char *params, uint8_t *dev_id, char **next_param)
+{
+	char *end_param;
+	unsigned long id;
+
+	if (params == NULL || *params == '\0' ||
+	    !isdigit((unsigned char)*params))
+		return -1;
+
+	id = strtoul(params, &end_param, 10);
+	if (next_param != NULL) {
+		*next_param = end_param;
+	} else if (*end_param != '\0') {
+		RTE_EDEV_LOG_DEBUG(
+			"Extra parameters passed to eventdev telemetry command, ignoring");
+	}
+
+	if (id >= RTE_EVENT_MAX_DEVS) {
+		RTE_EDEV_LOG_DEBUG(
+			"Invalid device id out of range %lu", id);
+		return -1;
+	}
+	*dev_id = id;
+	return 0;
+}
+
 static int
 handle_dev_info(const char *cmd __rte_unused,
 		const char *params,
@@ -1797,16 +1825,10 @@ handle_dev_info(const char *cmd __rte_unused,
 {
 	uint8_t dev_id;
 	struct rte_eventdev *dev;
-	char *end_param;
 
-	if (params == NULL || strlen(params) == 0 || !isdigit(*params))
+	if (parse_dev_id(params, &dev_id, NULL) < 0)
 		return -1;
 
-	dev_id = strtoul(params, &end_param, 10);
-	if (*end_param != '\0')
-		RTE_EDEV_LOG_DEBUG(
-			"Extra parameters passed to eventdev telemetry command, ignoring");
-
 	RTE_EVENTDEV_VALID_DEVID_OR_ERR_RET(dev_id, -EINVAL);
 	dev = &rte_eventdevs[dev_id];
 
@@ -1833,16 +1855,10 @@ handle_port_list(const char *cmd __rte_unused,
 	int i;
 	uint8_t dev_id;
 	struct rte_eventdev *dev;
-	char *end_param;
 
-	if (params == NULL || strlen(params) == 0 || !isdigit(*params))
+	if (parse_dev_id(params, &dev_id, NULL) < 0)
 		return -1;
 
-	dev_id = strtoul(params, &end_param, 10);
-	if (*end_param != '\0')
-		RTE_EDEV_LOG_DEBUG(
-			"Extra parameters passed to eventdev telemetry command, ignoring");
-
 	RTE_EVENTDEV_VALID_DEVID_OR_ERR_RET(dev_id, -EINVAL);
 	dev = &rte_eventdevs[dev_id];
 
@@ -1861,16 +1877,10 @@ handle_queue_list(const char *cmd __rte_unused,
 	int i;
 	uint8_t dev_id;
 	struct rte_eventdev *dev;
-	char *end_param;
 
-	if (params == NULL || strlen(params) == 0 || !isdigit(*params))
+	if (parse_dev_id(params, &dev_id, NULL) != 0)
 		return -1;
 
-	dev_id = strtoul(params, &end_param, 10);
-	if (*end_param != '\0')
-		RTE_EDEV_LOG_DEBUG(
-			"Extra parameters passed to eventdev telemetry command, ignoring");
-
 	RTE_EVENTDEV_VALID_DEVID_OR_ERR_RET(dev_id, -EINVAL);
 	dev = &rte_eventdevs[dev_id];
 
@@ -1886,27 +1896,28 @@ handle_queue_links(const char *cmd __rte_unused,
 		   const char *params,
 		   struct rte_tel_data *d)
 {
-	int i, ret, port_id = 0;
+	int i, ret;
 	char *end_param;
 	uint8_t dev_id;
 	uint8_t queues[RTE_EVENT_MAX_QUEUES_PER_DEV];
 	uint8_t priorities[RTE_EVENT_MAX_QUEUES_PER_DEV];
-	const char *p_param;
+	unsigned long port_id;
 
-	if (params == NULL || strlen(params) == 0 || !isdigit(*params))
+	if (parse_dev_id(params, &dev_id, &end_param) != 0)
 		return -1;
 
-	/* Get dev ID from parameter string */
-	dev_id = strtoul(params, &end_param, 10);
 	RTE_EVENTDEV_VALID_DEVID_OR_ERR_RET(dev_id, -EINVAL);
 
-	p_param = strtok(end_param, ",");
-	if (p_param == NULL || strlen(p_param) == 0 || !isdigit(*p_param))
+	if (*end_param != ',' || !isdigit((unsigned char)end_param[1]))
 		return -1;
 
-	port_id = strtoul(p_param, &end_param, 10);
-	p_param = strtok(NULL, "\0");
-	if (p_param != NULL)
+	port_id = strtoul(end_param + 1, &end_param, 10);
+	if (port_id >= RTE_EVENT_MAX_PORTS_PER_DEV) {
+		RTE_EDEV_LOG_DEBUG("Invalid port id out of range %lu", port_id);
+		return -1;
+	}
+
+	if (*end_param != '\0')
 		RTE_EDEV_LOG_DEBUG(
 			"Extra parameters passed to eventdev telemetry command, ignoring");
 
@@ -1998,19 +2009,12 @@ handle_dev_xstats(const char *cmd __rte_unused,
 		  const char *params,
 		  struct rte_tel_data *d)
 {
-	int dev_id;
+	uint8_t dev_id;
 	enum rte_event_dev_xstats_mode mode;
-	char *end_param;
 
-	if (params == NULL || strlen(params) == 0 || !isdigit(*params))
+	if (parse_dev_id(params, &dev_id, NULL) != 0)
 		return -1;
 
-	/* Get dev ID from parameter string */
-	dev_id = strtoul(params, &end_param, 10);
-	if (*end_param != '\0')
-		RTE_EDEV_LOG_DEBUG(
-			"Extra parameters passed to eventdev telemetry command, ignoring");
-
 	RTE_EVENTDEV_VALID_DEVID_OR_ERR_RET(dev_id, -EINVAL);
 
 	mode = RTE_EVENT_DEV_XSTATS_DEVICE;
@@ -2022,29 +2026,25 @@ handle_port_xstats(const char *cmd __rte_unused,
 		   const char *params,
 		   struct rte_tel_data *d)
 {
-	int dev_id;
-	int port_queue_id = 0;
+	uint8_t dev_id;
 	enum rte_event_dev_xstats_mode mode;
+	unsigned long port_queue_id;
 	char *end_param;
-	const char *p_param;
 
-	if (params == NULL || strlen(params) == 0 || !isdigit(*params))
+	if (parse_dev_id(params, &dev_id, &end_param) != 0)
 		return -1;
-
-	/* Get dev ID from parameter string */
-	dev_id = strtoul(params, &end_param, 10);
 	RTE_EVENTDEV_VALID_DEVID_OR_ERR_RET(dev_id, -EINVAL);
 
-	p_param = strtok(end_param, ",");
 	mode = RTE_EVENT_DEV_XSTATS_PORT;
 
-	if (p_param == NULL || strlen(p_param) == 0 || !isdigit(*p_param))
+	if (*end_param != ',' || !isdigit((unsigned char)end_param[1]))
 		return -1;
 
-	port_queue_id = strtoul(p_param, &end_param, 10);
+	port_queue_id = strtoul(end_param + 1, &end_param, 10);
+	if (port_queue_id >= RTE_EVENT_MAX_PORTS_PER_DEV)
+		return -1;
 
-	p_param = strtok(NULL, "\0");
-	if (p_param != NULL)
+	if (*end_param != '\0')
 		RTE_EDEV_LOG_DEBUG(
 			"Extra parameters passed to eventdev telemetry command, ignoring");
 
@@ -2056,29 +2056,26 @@ handle_queue_xstats(const char *cmd __rte_unused,
 		    const char *params,
 		    struct rte_tel_data *d)
 {
-	int dev_id;
-	int port_queue_id = 0;
+	uint8_t dev_id;
+	unsigned long port_queue_id;
 	enum rte_event_dev_xstats_mode mode;
 	char *end_param;
-	const char *p_param;
 
-	if (params == NULL || strlen(params) == 0 || !isdigit(*params))
+	if (parse_dev_id(params, &dev_id, &end_param) != 0)
 		return -1;
 
-	/* Get dev ID from parameter string */
-	dev_id = strtoul(params, &end_param, 10);
 	RTE_EVENTDEV_VALID_DEVID_OR_ERR_RET(dev_id, -EINVAL);
 
-	p_param = strtok(end_param, ",");
 	mode = RTE_EVENT_DEV_XSTATS_QUEUE;
 
-	if (p_param == NULL || strlen(p_param) == 0 || !isdigit(*p_param))
+	if (*end_param != ',' || !isdigit((unsigned char)end_param[1]))
 		return -1;
 
-	port_queue_id = strtoul(p_param, &end_param, 10);
+	port_queue_id = strtoul(end_param + 1, &end_param, 10);
+	if (port_queue_id >= RTE_EVENT_MAX_QUEUES_PER_DEV)
+		return -1;
 
-	p_param = strtok(NULL, "\0");
-	if (p_param != NULL)
+	if (*end_param != '\0')
 		RTE_EDEV_LOG_DEBUG(
 			"Extra parameters passed to eventdev telemetry command, ignoring");
 
@@ -2090,19 +2087,14 @@ handle_dev_dump(const char *cmd __rte_unused,
 		const char *params,
 		struct rte_tel_data *d)
 {
-	char *buf, *end_param;
-	int dev_id, ret;
+	char *buf;
+	uint8_t dev_id;
+	int ret;
 	FILE *f;
 
-	if (params == NULL || strlen(params) == 0 || !isdigit(*params))
+	if (parse_dev_id(params, &dev_id, NULL) != 0)
 		return -1;
 
-	/* Get dev ID from parameter string */
-	dev_id = strtoul(params, &end_param, 10);
-	if (*end_param != '\0')
-		RTE_EDEV_LOG_DEBUG(
-			"Extra parameters passed to eventdev telemetry command, ignoring");
-
 	RTE_EVENTDEV_VALID_DEVID_OR_ERR_RET(dev_id, -EINVAL);
 
 	buf = calloc(RTE_TEL_MAX_SINGLE_STRING_LEN, sizeof(char));
-- 
2.53.0

