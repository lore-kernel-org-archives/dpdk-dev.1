Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8389C79FA0
	for <dpdk-dev@archiver.kernel.org>; Mon,  7 Sep 2026 18:26:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3C61640BA6;
	Mon,  7 Sep 2026 20:26:26 +0200 (CEST)
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com
 [209.85.210.181])
 by mails.dpdk.org (Postfix) with ESMTP id 83FD240A84
 for <dev@dpdk.org>; Mon,  7 Sep 2026 20:26:24 +0200 (CEST)
Received: by mail-pf1-f181.google.com with SMTP id
 d2e1a72fcca58-852c481415fso4435511b3a.3
 for <dev@dpdk.org>; Mon, 07 Sep 2026 11:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788805584;
 x=1789410384; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KfMjtZEMT7dTp4Y9+GRknD5jSn8IRMFZXgE7YGbOBsk=;
 b=IJhzRFil7Ge8LWQlXfoMQo1E3mCSb0zt6Oflf0oVOPDkxhsioORVGeQ0Rgcx8Htxhe
 R6yEHSkQ6w25za/OJe4FhrG9jqHJoS+L7obfl7y2iFJQNYZ/2XjicBQglZrOSfoMkSnQ
 VhPXES6eFRuKFb5y1J0cCQyT0VwhduouRKe1CbRD68q/wRJ8KAGC8ffHda9NAMQbjuQj
 JsVKXyRohbbyir77zipokLg/Tdisv+P7sl6vLBivA/MChr/XwG5RdbtHBUUz5ACjCzOs
 4bbREEP6RA7CCXHubOrcS0CaCwUHOU/k7k5krvEVTXtom3VB00qC10zSmNKJePmoDtIj
 FeXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788805584; x=1789410384;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=KfMjtZEMT7dTp4Y9+GRknD5jSn8IRMFZXgE7YGbOBsk=;
 b=pDxTFhpOQ9d81Igx+nT4GQMgtcjUZAzF5az40fTbmryzq0NuzDFuRZLn0LN5Txfgx0
 ZVYmjFK+lKuXsrMwM/MKxSg6UBMbK/sKfZukKV5AXjDG4LBd9fl8C9JTzh/xZRnKoj2p
 aNDUN77mh2ut61OZflH1jkNaGdj9KBll2IUObwDvzGagfzHWDKEleXrMOFcLWQmH9C+e
 VTel76f8wekfhwfBKW52S1y5jLWRNzZoWMJS1NYcXmKg/LW01qUzOcpEVlIu/M832zuB
 bzbXMAjh+krspHfgULGohDLXo+b3zE/a3OLPkccexe+lWmAxyLJhKb2JD0sLqt847PSr
 zHnQ==
X-Gm-Message-State: AFuF++mqa5zgPeWh6A3facATVuA3J1xcUl+Fllw2mJLgIUDn9fM1hJ2a
 z8/P0zx1F43Nff0qXHcccIsTi9d+dy/4+w7t43lF2xlXuFoNfF/SaC+0yIDnYgU3XB+zVbXnNuG
 2dVvA
X-Gm-Gg: AYBFou1tU1sbVrK47w2gTFg9PTEiC4Y62Lr9hr1eIsQhlMViaKRy3nHv/7G6l6yZ47z
 +B4sndCK045SFcyycRNlEknK3Zc+E63Ba6oN/k1tvx+7GPoGv/v+Ss1wXbSHpwsgiiVa5kML2HC
 JpC8HbN+l8T9dlme0DiXS6tGRD8BVnbrKK5osVHiRqoqkuNeCHlE1oSg8ictOK+QdD+xQ/KtcuV
 HqOA68Zq78JvGBP9kNkaRquMbjT5NDlJfhAVuqoIi2c/xUKTHDP1KKXxBp2eYfwwS70unfAf4IH
 AttmQc46znG+5pvg3dsq35Ose9d6kIyl7DHFTKDNEIyh1E6ueXGkuj3Sbpla/tEZWIueMfrFkOa
 Zvqr24rvLsqmukPLZQAu+YUTsd78g9DGduOuUsVNCG8O0zTB5QKtheMBI8R/dJ7w2yDuhxjIPBK
 kwT+dcw7ET2sH7UHEt2ihHxxSWXGsCLBRBmmMZI+Ih2B6c+7Kbg2L3duEwT+oDbtCyCCksWOT8Z
 VzNb01ACvAQpLQcu5CWUUIVLxI=
X-Received: by 2002:a05:6a00:1709:b0:853:6571:9567 with SMTP id
 d2e1a72fcca58-861677b29a7mr30889795b3a.4.1788805583672; 
 Mon, 07 Sep 2026 11:26:23 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-86152f32447sm4553302b3a.38.2026.09.07.11.26.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 11:26:23 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Kiran Kumar K <kirankumark@marvell.com>,
 Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Aman Singh <aman.deep.singh@intel.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Gregory Etelson <getelson@nvidia.com>
Subject: [PATCH 3/3] app/testpmd: fix null dereference parsing flex item link
Date: Mon,  7 Sep 2026 11:22:04 -0700
Message-ID: <20260907182317.570481-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260907182317.570481-1-stephen@networkplumber.org>
References: <20260907182317.570481-1-stephen@networkplumber.org>
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

flex_item_init() hands the spec and mask buffers to the input links by
storing them in item.spec and item.mask, which are const pointers, and
never allocates anything for item.last.  A link item with a range then
copies into a null pointer:

  {"item": "eth type spec 2048 type last 2304 type mask 65535"}

The FLEX_LINK_IN check for item.last in flex_link_parse() runs after
flex_link_item_parse() has already copied, so it cannot prevent this.

Keep the buffers in the flex item as writable storage and pass them
down to the parser, which assigns them to the item only for what it
actually copied.  A range is rejected, and the copy is bounded by the
buffer size: the widest flow item mask is currently exactly
FLEX_MAX_FLOW_PATTERN_LENGTH bytes, so a new wider item would overflow
silently.

Fixes: 59f3a8acbcdb ("app/testpmd: add flex item commands")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test-pmd/cmd_flex_item.c | 75 ++++++++++++++++++++----------------
 app/test-pmd/testpmd.h       |  7 ++++
 2 files changed, 48 insertions(+), 34 deletions(-)

diff --git a/app/test-pmd/cmd_flex_item.c b/app/test-pmd/cmd_flex_item.c
index f4560d2cec..3e55189a2d 100644
--- a/app/test-pmd/cmd_flex_item.c
+++ b/app/test-pmd/cmd_flex_item.c
@@ -124,12 +124,13 @@ enum flex_link_type {
 };
 
 static int
-flex_link_item_parse(const char *src, struct rte_flow_item *item)
+flex_link_item_parse(const char *src, struct rte_flow_item *item,
+		     struct flex_link_pattern *buf)
 {
 #define  FLEX_PARSE_DATA_SIZE 1024
 
 	int ret;
-	uint8_t *ptr, data[FLEX_PARSE_DATA_SIZE] = {0,};
+	uint8_t data[FLEX_PARSE_DATA_SIZE] = {0,};
 	char flow_rule[256];
 	struct rte_flow_attr *attr;
 	struct rte_flow_item *pattern;
@@ -146,31 +147,42 @@ flex_link_item_parse(const char *src, struct rte_flow_item *item)
 	if (ret)
 		return ret;
 	item->type = pattern->type;
+	item->spec = NULL;
+	item->mask = NULL;
+	item->last = NULL;
+	/* Only input links carry a value to match. */
+	if (buf == NULL)
+		return 0;
+	/* rte_flow_conv() reports the item size only if a mask is set. */
+	item->mask = buf->mask;
 	ret = rte_flow_conv(RTE_FLOW_CONV_OP_ITEM_MASK, NULL, 0, item, NULL);
-	if ((ret > 0) && pattern->spec) {
-		ptr = (void *)(uintptr_t)item->spec;
-		memcpy(ptr, pattern->spec, ret);
-	} else {
-		item->spec = NULL;
-	}
-	if ((ret > 0) && pattern->mask) {
-		ptr = (void *)(uintptr_t)item->mask;
-		memcpy(ptr, pattern->mask, ret);
-	} else {
+	if (ret <= 0) {
 		item->mask = NULL;
+		return 0;
 	}
-	if ((ret > 0) && pattern->last) {
-		ptr = (void *)(uintptr_t)item->last;
-		memcpy(ptr, pattern->last, ret);
-	} else {
-		item->last = NULL;
+	if (ret > FLEX_MAX_FLOW_PATTERN_LENGTH) {
+		printf("Flex item link \"%s\" needs %d bytes, maximum is %d\n",
+		       src, ret, FLEX_MAX_FLOW_PATTERN_LENGTH);
+		return -ENOSPC;
+	}
+	if (pattern->last != NULL) {
+		printf("Flex item link \"%s\" can not be a range\n", src);
+		return -ENOTSUP;
+	}
+	if (pattern->spec != NULL) {
+		memcpy(buf->spec, pattern->spec, ret);
+		item->spec = buf->spec;
 	}
+	if (pattern->mask != NULL)
+		memcpy(buf->mask, pattern->mask, ret);
+	else
+		item->mask = NULL;
 	return 0;
 }
 
 static int
 flex_link_parse(json_t *jobj, struct rte_flow_item_flex_link *link,
-		enum flex_link_type link_type)
+		struct flex_link_pattern *buf, enum flex_link_type link_type)
 {
 	const char *key;
 	json_t *je;
@@ -180,7 +192,7 @@ flex_link_parse(json_t *jobj, struct rte_flow_item_flex_link *link,
 			if (!json_is_string(je))
 				return -EINVAL;
 			ret = flex_link_item_parse(json_string_value(je),
-						   &link->item);
+						   &link->item, buf);
 			if (ret)
 				return -EINVAL;
 			if (link_type == FLEX_LINK_IN) {
@@ -204,9 +216,9 @@ flex_link_parse(json_t *jobj, struct rte_flow_item_flex_link *link,
 	return 0;
 }
 
-static int flex_item_config(json_t *jroot,
-			    struct rte_flow_item_flex_conf *flex_conf)
+static int flex_item_config(json_t *jroot, struct flex_item *fp)
 {
+	struct rte_flow_item_flex_conf *flex_conf = &fp->flex_conf;
 	const char *key;
 	json_t *jobj = NULL;
 	int ret = 0;
@@ -263,6 +275,7 @@ static int flex_item_config(json_t *jroot,
 				ji = json_array_get(jobj, i);
 				ret = flex_link_parse(ji,
 						      flex_conf->input_link + i,
+						      fp->link_pattern + i,
 						      FLEX_LINK_IN);
 				if (ret) {
 					printf("Can't parse input_link(s)\n");
@@ -283,7 +296,7 @@ static int flex_item_config(json_t *jroot,
 				ji = json_array_get(jobj, i);
 				ret = flex_link_parse
 					(ji, flex_conf->output_link + i,
-					 FLEX_LINK_OUT);
+					 NULL, FLEX_LINK_OUT);
 				if (ret) {
 					printf("Can't parse output_link(s)\n");
 					goto out;
@@ -299,11 +312,9 @@ static int flex_item_config(json_t *jroot,
 static struct flex_item *
 flex_item_init(void)
 {
-	size_t base_size, samples_size, links_size, spec_size;
+	size_t base_size, samples_size, links_size, pattern_size;
 	struct rte_flow_item_flex_conf *conf;
 	struct flex_item *fp;
-	uint8_t (*pattern)[FLEX_MAX_FLOW_PATTERN_LENGTH];
-	int i;
 
 	base_size = RTE_ALIGN(sizeof(*fp), sizeof(uintptr_t));
 	samples_size = RTE_ALIGN(FLEX_ITEM_MAX_SAMPLES_NUM *
@@ -313,8 +324,8 @@ flex_item_init(void)
 			       sizeof(conf->input_link[0]),
 			       sizeof(uintptr_t));
 	/* spec & mask for all input links */
-	spec_size = 2 * FLEX_MAX_FLOW_PATTERN_LENGTH * FLEX_ITEM_MAX_LINKS_NUM;
-	fp = calloc(1, base_size + samples_size + 2 * links_size + spec_size);
+	pattern_size = FLEX_ITEM_MAX_LINKS_NUM * sizeof(*fp->link_pattern);
+	fp = calloc(1, base_size + samples_size + 2 * links_size + pattern_size);
 	if (fp == NULL) {
 		printf("Can't allocate memory for flex item\n");
 		return NULL;
@@ -326,12 +337,8 @@ flex_item_init(void)
 			   ((uint8_t *)conf->sample_data + samples_size);
 	conf->output_link = (typeof(conf->output_link))
 			    ((uint8_t *)conf->input_link + links_size);
-	pattern = (typeof(pattern))((uint8_t *)conf->output_link + links_size);
-	for (i = 0; i < FLEX_ITEM_MAX_LINKS_NUM; i++) {
-		struct rte_flow_item_flex_link *in = conf->input_link + i;
-		in->item.spec = pattern++;
-		in->item.mask = pattern++;
-	}
+	fp->link_pattern = (typeof(fp->link_pattern))
+			   ((uint8_t *)conf->output_link + links_size);
 	return fp;
 }
 
@@ -346,7 +353,7 @@ flex_item_build_config(struct flex_item *fp, const char *filename)
 		printf("Bad JSON file \"%s\": %s\n", filename, json_error.text);
 		return -1;
 	}
-	ret = flex_item_config(jroot, &fp->flex_conf);
+	ret = flex_item_config(jroot, fp);
 	json_decref(jroot);
 	return ret;
 }
diff --git a/app/test-pmd/testpmd.h b/app/test-pmd/testpmd.h
index d23950ab9d..3a81464bab 100644
--- a/app/test-pmd/testpmd.h
+++ b/app/test-pmd/testpmd.h
@@ -445,8 +445,15 @@ void common_fwd_stream_init(struct fwd_stream *fs);
 #define FLEX_MAX_PATTERNS_NUM 64
 #define FLEX_PARSER_ERR ((struct flex_item *)-1)
 
+/** Spec and mask storage for one flex item input link. */
+struct flex_link_pattern {
+	uint8_t spec[FLEX_MAX_FLOW_PATTERN_LENGTH];
+	uint8_t mask[FLEX_MAX_FLOW_PATTERN_LENGTH];
+};
+
 struct flex_item {
 	struct rte_flow_item_flex_conf flex_conf;
+	struct flex_link_pattern *link_pattern;
 	struct rte_flow_item_flex_handle *flex_handle;
 	uint32_t flex_id;
 };
-- 
2.53.0

