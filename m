Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 893DED185C2
	for <dpdk-dev@archiver.kernel.org>; Thu,  8 Jan 2026 10:50:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 75C9640616;
	Thu,  8 Jan 2026 11:50:51 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id AB07140613
 for <dev@dpdk.org>; Thu,  8 Jan 2026 11:50:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767869450;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jAnYEICLrzeywAt7yIbQQ+g8FOoXCLQ8pZSTChBpQko=;
 b=eLADaufVn+8yovv78i4SPfEx49oay0YO31oGSWSf9zX2hEwiWSB+ELW0PnLqyS5rnJhbKp
 Iin6xmGNaWeLbfhRW0ZDdDyl1tFmmibCrD0GaGPWlXqfmxzU23U4558sK1cGYyxFfnJUpl
 m90ZSwNJYa4MF4UOnfg4A9rphaFkWZQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-64-KI2tBepfO2m4Hz_rFxhuzA-1; Thu,
 08 Jan 2026 05:50:47 -0500
X-MC-Unique: KI2tBepfO2m4Hz_rFxhuzA-1
X-Mimecast-MFC-AGG-ID: KI2tBepfO2m4Hz_rFxhuzA_1767869446
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0A03518005B3; Thu,  8 Jan 2026 10:50:46 +0000 (UTC)
Received: from ringo.home (unknown [10.45.226.149])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F16A61956048; Thu,  8 Jan 2026 10:50:43 +0000 (UTC)
From: Robin Jarry <rjarry@redhat.com>
To: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>,
 Ciara Power <ciara.power@intel.com>
Cc: stable@dpdk.org
Subject: [PATCH dpdk v2] telemetry: fix adding dicts in container arrays
Date: Thu,  8 Jan 2026 11:50:37 +0100
Message-ID: <20260108105036.1341037-2-rjarry@redhat.com>
In-Reply-To: <20260107215129.1329960-2-rjarry@redhat.com>
References: <20260107215129.1329960-2-rjarry@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: nbTGf4g-SBKbuq9tVMHT6aH-m3gJlLcsTOk5i2XQQ7w_1767869446
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
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

Currently, adding TEL_DICT containers in TEL_ARRAY_CONTAINER containers
is not supported by rte_tel_data_add_array_container. It wrongfully
returns -EINVAL where it should allow it.

This is supported by the JSON formatter.

Allow the same value types than rte_tel_data_add_dict_container().

Add test case to verify it works as expected.

Fixes: c933bb5177ca ("telemetry: support array values in data object")
Cc: stable@dpdk.org

Signed-off-by: Robin Jarry <rjarry@redhat.com>
---

Notes:
    v2: added test case

 app/test/test_telemetry_data.c | 21 +++++++++++++++++++++
 lib/telemetry/telemetry_data.c |  6 +++---
 2 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/app/test/test_telemetry_data.c b/app/test/test_telemetry_data.c
index 59898ff5e983..e904b5a7f210 100644
--- a/app/test/test_telemetry_data.c
+++ b/app/test/test_telemetry_data.c
@@ -405,6 +405,26 @@ test_array_with_array_uint_hex_values_nopadding(void)
 	return CHECK_OUTPUT("[[\"0x888\"],[\"0x8888\"]]");
 }
 
+static int
+test_array_with_dict_values(void)
+{
+	rte_tel_data_start_array(&response_data, RTE_TEL_CONTAINER);
+
+	struct rte_tel_data *d1 = rte_tel_data_alloc();
+	rte_tel_data_start_dict(d1);
+	rte_tel_data_add_dict_string(d1, "name", "foo");
+	rte_tel_data_add_dict_uint(d1, "size", 42);
+	rte_tel_data_add_array_container(&response_data, d1, 0);
+
+	struct rte_tel_data *d2 = rte_tel_data_alloc();
+	rte_tel_data_start_dict(d2);
+	rte_tel_data_add_dict_string(d2, "name", "bar");
+	rte_tel_data_add_dict_uint(d2, "size", 666);
+	rte_tel_data_add_array_container(&response_data, d2, 0);
+
+	return CHECK_OUTPUT("[{\"name\":\"foo\",\"size\":42},{\"name\":\"bar\",\"size\":666}]");
+}
+
 static int
 test_case_array_u64(void)
 {
@@ -597,6 +617,7 @@ telemetry_data_autotest(void)
 			test_array_with_array_string_values,
 			test_array_with_array_uint_hex_values_padding,
 			test_array_with_array_uint_hex_values_nopadding,
+			test_array_with_dict_values,
 			test_string_char_escaping,
 			test_array_char_escaping,
 			test_dict_char_escaping,
diff --git a/lib/telemetry/telemetry_data.c b/lib/telemetry/telemetry_data.c
index 0354a0654804..0a006559ab42 100644
--- a/lib/telemetry/telemetry_data.c
+++ b/lib/telemetry/telemetry_data.c
@@ -96,10 +96,10 @@ int
 rte_tel_data_add_array_container(struct rte_tel_data *d,
 		struct rte_tel_data *val, int keep)
 {
-	if (d->type != TEL_ARRAY_CONTAINER ||
-			(val->type != TEL_ARRAY_UINT
+	if (d->type != TEL_ARRAY_CONTAINER || (val->type != TEL_ARRAY_UINT
 			&& val->type != TEL_ARRAY_INT
-			&& val->type != TEL_ARRAY_STRING))
+			&& val->type != TEL_ARRAY_STRING
+			&& val->type != TEL_DICT))
 		return -EINVAL;
 	if (d->data_len >= RTE_TEL_MAX_ARRAY_ENTRIES)
 		return -ENOSPC;
-- 
2.52.0

