Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 682EDCD6E7B
	for <dpdk-dev@archiver.kernel.org>; Fri,  5 Jun 2026 20:53:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1ADA840666;
	Fri,  5 Jun 2026 22:53:03 +0200 (CEST)
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com
 [209.85.219.46]) by mails.dpdk.org (Postfix) with ESMTP id E7B5640652
 for <dev@dpdk.org>; Fri,  5 Jun 2026 22:53:00 +0200 (CEST)
Received: by mail-qv1-f46.google.com with SMTP id
 6a1803df08f44-8ced8f44da0so24784556d6.2
 for <dev@dpdk.org>; Fri, 05 Jun 2026 13:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1780692780;
 x=1781297580; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e0iOQTbxvMDaVqt7HU9vRSjz4rUmxM5hvqC5d83Vdo0=;
 b=IAXPPoBSdrXV/a6huezUDDHwssoSdsjyuXoUpeifoZF9dvYzVuHmLSRSLY3Sp/FOue
 EQQ+MqQHcUHC0NPxOQjSn/m7KKcDNiK6HVvPSWXWgo76anGVbkeXk8BpFS81pO30usgq
 Q7RV8QIhNP4MCb2OGjlbiXruRaEg6ZpH4oNz6frke+BOeC3PXVFz+fcFi6aoYlNnID7s
 MNQb9EzPxACfKJg02wYamJwU4oMKUpzq4h+/daOTuf+Oa94+58GByRyQ6dPdbyf8touQ
 Z7uJa6YnAU3KrTHcTdN7HkD4za6f1LuyFRo3hnNieMDjy39E7VqwHZ+SJ8MQGnH6qzs2
 bKOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780692780; x=1781297580;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=e0iOQTbxvMDaVqt7HU9vRSjz4rUmxM5hvqC5d83Vdo0=;
 b=Ru96Bf3v2AZzub9ko/6y5QAyaAdc7t78B0pQTYKKVC+q7RcF5BYclF3brcpG3gKZkq
 P4i4J1z2dbgWrPAKNylPqLkzQyDxgqolFGtEAdJiKu/H2QwHngxfS7Hlw/Q2jCPh9j/d
 rxwrQWzmjKuC2wPWNmsqnEd3ivQK3yTNBupsdOpUVhiEzdaA4b/aHvvoQarxzbj254At
 NI4/V1DcSxI0QnXisd9OYbd4vjjVUamj4k3SWJhZvIoKestnrHz/LAkHm9+P+5b5p+rf
 W9FHPjFsXWX7gKm+MtT4OCV34YvEP+LRc9+5v2g6nJp3eil26G0BVt6ZvcvpJm631mMo
 l7Ew==
X-Gm-Message-State: AOJu0YyjqT7Oj4qRlWBHOhetp6OxpddLblPFzei2aqY2Rw7QI6XNf9fh
 led5+oHWQ4jeJ9xb2e6xeiEh/jz1fhy3/GfFO9OwtQCaebFdhyPRcfSgbfMYXfNcjsreMYYVkIO
 EHBaa
X-Gm-Gg: Acq92OF+gqcqB8TN5EYFZxkCNosqwCb9vHIgjQLwkqxZFWHKk4uDCgbVpCfaWG7tF7B
 hDC4HrZ6O9g8Y/LrV4ILgP8LSWNoIjCTuaAX9SKlDS28+1+jsNZOEL62AIkVjVbI+m19DaxNduz
 K0CflkW3ZNvhpS57JHZYs4JAiyqW0zg8gT6eX5SeErDQIdYbjbts7ZwrN8PREunmizcobVpWD64
 9qqjLXPwyXVW4xrirRcrLOuLHvz7nJyhEIDEd21wAxOn5kSI9kvM1T2KvRowUkQ++2GfEZUW5gW
 PMI/qul13tSZoePmxy87z9Bhbr4RiY1Wy4Np34uOnYNFdq4pOCsMRk9LiQ9AqhbwilZd1Djiozs
 EbdMvqhhEhnvTX6TgMChfKXN1KVW3NxX/t2RH/aGcaeH4Gpzd6c3ZI4X2IPEsR2gzCovB9J+/6E
 mOsGI1rm/lJgvdAAjy53k9jBf3n9A8AI9grSnWj5VlW6rm1wEZQo5MKZr6ceeAdhedTCjz+fb1
X-Received: by 2002:ad4:4689:0:b0:8cc:f3bb:e16a with SMTP id
 6a1803df08f44-8cee5fe928dmr66938536d6.13.1780692780279; 
 Fri, 05 Jun 2026 13:53:00 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8cecd2629cesm90072906d6.41.2026.06.05.13.52.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2026 13:52:59 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Thomas Monjalon <thomas@monjalon.net>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Ferruh Yigit <ferruh.yigit@amd.com>, Jie Hai <haijie1@huawei.com>
Subject: [PATCH 2/8] ethdev: make telemetry parameter parsing thread-safe
Date: Fri,  5 Jun 2026 13:50:59 -0700
Message-ID: <20260605205253.520196-3-stephen@networkplumber.org>
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

The ethdev telemetry handlers run in a per-connection thread.
Two of the parameter parsers used strtok(), which keeps its state in a
process-global static shared across threads.
Use strtok_r() with a local save pointer.

Also pass an unsigned char to isdigit(),
which is undefined for characters with high-bit set.

Fixes: 9e7533aeb80a ("ethdev: add telemetry command for TM level capabilities")
Fixes: f38f62650f7b ("ethdev: add Rx queue telemetry query")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/ethdev/rte_ethdev_telemetry.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/lib/ethdev/rte_ethdev_telemetry.c b/lib/ethdev/rte_ethdev_telemetry.c
index a910864bc5..ca7f4681c9 100644
--- a/lib/ethdev/rte_ethdev_telemetry.c
+++ b/lib/ethdev/rte_ethdev_telemetry.c
@@ -32,7 +32,7 @@ eth_dev_parse_port_params(const char *params, uint16_t *port_id,
 	uint64_t pi;
 
 	if (params == NULL || strlen(params) == 0 ||
-		!isdigit(*params) || port_id == NULL)
+		!isdigit((unsigned char)*params) || port_id == NULL)
 		return -EINVAL;
 
 	pi = strtoul(params, end_param, 0);
@@ -459,6 +459,7 @@ ethdev_parse_queue_params(const char *params, bool is_rx,
 	const char *qid_param;
 	uint16_t nb_queues;
 	char *end_param;
+	char *saveptr = NULL;
 	uint64_t qid;
 	int ret;
 
@@ -471,8 +472,8 @@ ethdev_parse_queue_params(const char *params, bool is_rx,
 	if (nb_queues == 1 && *end_param == '\0')
 		qid = 0;
 	else {
-		qid_param = strtok(end_param, ",");
-		if (!qid_param || strlen(qid_param) == 0 || !isdigit(*qid_param))
+		qid_param = strtok_r(end_param, ",", &saveptr);
+		if (!qid_param || strlen(qid_param) == 0 || !isdigit((unsigned char)*qid_param))
 			return -EINVAL;
 
 		qid = strtoul(qid_param, &end_param, 0);
@@ -1207,10 +1208,11 @@ static int
 eth_dev_parse_tm_params(char *params, uint32_t *result)
 {
 	const char *splited_param;
+	char *saveptr = NULL;
 	uint64_t ret;
 
-	splited_param = strtok(params, ",");
-	if (!splited_param || strlen(splited_param) == 0 || !isdigit(*splited_param))
+	splited_param = strtok_r(params, ",", &saveptr);
+	if (!splited_param || strlen(splited_param) == 0 || !isdigit((unsigned char)*splited_param))
 		return -EINVAL;
 
 	ret = strtoul(splited_param, &params, 0);
-- 
2.53.0

