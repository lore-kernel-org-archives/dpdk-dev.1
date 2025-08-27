Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8694FCA0FFD
	for <dpdk-dev@archiver.kernel.org>; Wed, 27 Aug 2025 23:15:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6E58140662;
	Thu, 28 Aug 2025 01:15:40 +0200 (CEST)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52]) by mails.dpdk.org (Postfix) with ESMTP id 542CE4065E
 for <dev@dpdk.org>; Thu, 28 Aug 2025 01:15:39 +0200 (CEST)
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-3c79f0a5c29so289002f8f.0
 for <dev@dpdk.org>; Wed, 27 Aug 2025 16:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1756336539;
 x=1756941339; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r1tHECMIRZIiQKgyfiRHRbexuwJfKf8Er+ea2KGMdiE=;
 b=dYlU+9B1I5qPnsgOu26aehew+clH0aER933D61+Z8Owg/ykwbdx9Z6tTdqNICiheUP
 UzQfYC8BF0qJb2bTRo/JaPd7qfXvlP2qHKq03gYq26jmcfju5Y2lIHvkW08Llm/x8Cza
 W8K+O4mNeGqn1flFUgHaPiKGqQCxZoPs9aui6nN4FvNBomLWcgELjELdrI6YO6o+faeG
 y33+/rr90nghgG+K/5OC8t9Iggvb8i3IMMfPnbiJrEqml/UHQIyF8kTADwL17elugYG/
 yDbgFySTUL60GPjr5F40RTocYjNixrNre7b98GsNnD2137Uo6YZ8/6XH6LRqyMdes/M9
 ydIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756336539; x=1756941339;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r1tHECMIRZIiQKgyfiRHRbexuwJfKf8Er+ea2KGMdiE=;
 b=KHUe1N528AbBHQkoQ2HraU6L43uIV82vuIww/wv0tY3WpddmhgoVXp5pZAnE6IHYMJ
 0I2Jy2rxuu0pdjF7XhoKNPYy5E+v77CJ1LZNwTm8ni04DxR6MKmd264BunMKSGURSqNW
 4o2dywZAlXaEx48an6ADHpEMpArBmsdYdNicPpdokygM0Li68SEk/0FoyXPeYvbgP8lR
 VZYENoWp13ia83xoPeP9IOGyCtlodqtj/1ZUdUkoiWH3/Xu5WtWR9q4EHMW8zuaMeDAj
 xrhd46FVXUF2f86VlV04vJHdub3sb+SkBjU25RdGFwkwdY12CdkCFb6H/qcP54OmulNK
 bpNQ==
X-Gm-Message-State: AOJu0YwGc0BrlUl7SC1r5u0CcOwbn0qVUwkjoOMQji+//8AEjyHLreE6
 eKw5ihuVjfBnqqYvEUmjxLER0ouqXCRFygxS5dh5/p0D5PHV7qfOBFd5xiHb+LMLQYvqXb30k7X
 Xkjl5
X-Gm-Gg: ASbGncuuFXfuj+FldCg9uzI5fYN+FI8UUJg4AAVEQLJuwrR0cVlxOBvWQrWkoABJUW1
 rSv3kaHn3dlEasd8xso6ae/pdKIl1/9FLc9W+/V44ga2xjSITSQ2gKwFFxHoZSRm20Njn2ejdx7
 urKtXBVP/cMpbysROl/HtKdQaXUa/Ht0o7o3XuRa97R+Jxdv7/APYufefPILuwDL8JM/OVscyhS
 AgMHzirawsZsaeL74HJWm3VziUStsHTyyKtY1XHzBuVt8xFOccFIVYtWmyS+YyMKPCb/3VK9ERH
 iYtR+WctockGadImQ+JPXgFaQX0kqhMnH5Mvq9GD8o33effj9X6BgJiT4TPvvUcPFH2hUm9xkmM
 9n4jsoQrkhC/mQ3hapbFm3SFUhRnZlNI/hBrfybBWvoOtUUg19QcGxMoEcP7uzFoETCmLrFxvA1
 KWNXJs2YI=
X-Google-Smtp-Source: AGHT+IG6eCTLxGvuv5LcVE0NKc5xr6/w+yYWww9/ZcckiUNGboSLt1aN8R5b3IC7Yyz4nvF8U5ADUw==
X-Received: by 2002:a05:6000:288a:b0:3b9:55b:5bbe with SMTP id
 ffacd0b85a97d-3c5da73f54amr16315065f8f.10.1756336538820; 
 Wed, 27 Aug 2025 16:15:38 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c70e4ba046sm24254652f8f.1.2025.08.27.16.15.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Aug 2025 16:15:37 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Cristian Dumitrescu <cristian.dumitrescu@intel.com>
Subject: [RFC 2/8] test/table: replace conflicting variable name
Date: Wed, 27 Aug 2025 16:14:05 -0700
Message-ID: <20250827231528.236172-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250827231528.236172-1-stephen@networkplumber.org>
References: <20250827231528.236172-1-stephen@networkplumber.org>
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

The variable name table_id is used in several places causing
warnings if -Wshadow is enabled. Rename it to table_ids.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test/test_table.c          |  2 +-
 app/test/test_table.h          |  2 +-
 app/test/test_table_acl.c      | 28 ++++++++++++++--------------
 app/test/test_table_pipeline.c | 22 +++++++++++-----------
 4 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/app/test/test_table.c b/app/test/test_table.c
index 27d2407517..6da0012944 100644
--- a/app/test/test_table.c
+++ b/app/test/test_table.c
@@ -33,7 +33,7 @@ struct rte_mempool *pool = NULL;
 uint32_t port_in_id[N_PORTS];
 uint32_t port_out_id[N_PORTS];
 uint32_t port_out_id_type[3];
-uint32_t table_id[N_PORTS*2];
+uint32_t table_ids[N_PORTS*2];
 uint64_t override_hit_mask = 0xFFFFFFFF;
 uint64_t override_miss_mask = 0xFFFFFFFF;
 uint64_t non_reserved_actions_hit = 0;
diff --git a/app/test/test_table.h b/app/test/test_table.h
index 209bdbff2c..b8fdd98281 100644
--- a/app/test/test_table.h
+++ b/app/test/test_table.h
@@ -120,7 +120,7 @@ extern struct rte_mempool *pool;
 extern uint32_t port_in_id[N_PORTS];
 extern uint32_t port_out_id[N_PORTS];
 extern uint32_t port_out_id_type[3];
-extern uint32_t table_id[N_PORTS*2];
+extern uint32_t table_ids[N_PORTS*2];
 extern uint64_t override_hit_mask;
 extern uint64_t override_miss_mask;
 extern uint64_t non_reserved_actions_hit;
diff --git a/app/test/test_table_acl.c b/app/test/test_table_acl.c
index dff9bddfb9..4076c513fb 100644
--- a/app/test/test_table_acl.c
+++ b/app/test/test_table_acl.c
@@ -427,14 +427,14 @@ setup_acl_pipeline(void)
 		table_params.ops = &rte_table_acl_ops;
 		table_params.arg_create = &acl_params;
 
-		if (rte_pipeline_table_create(p, &table_params, &table_id[i])) {
+		if (rte_pipeline_table_create(p, &table_params, &table_ids[i])) {
 			rte_panic("Unable to configure table %u\n", i);
 			goto fail;
 		}
 
 		if (connect_miss_action_to_table) {
 			if (rte_pipeline_table_create(p, &table_params,
-				&table_id[i+2])) {
+				&table_ids[i+2])) {
 				rte_panic("Unable to configure table %u\n", i);
 				goto fail;
 			}
@@ -443,10 +443,10 @@ setup_acl_pipeline(void)
 
 	for (i = 0; i < N_PORTS; i++) {
 		if (rte_pipeline_port_in_connect_to_table(p, port_in_id[i],
-			table_id[i])) {
+			table_ids[i])) {
 			rte_panic("Unable to connect input port %u to "
 				"table %u\n",
-				port_in_id[i],  table_id[i]);
+				port_in_id[i],  table_ids[i]);
 			goto fail;
 		}
 	}
@@ -485,11 +485,11 @@ setup_acl_pipeline(void)
 			table_entries_ptr[n] = &entries_ptr[n];
 		}
 
-		ret = rte_pipeline_table_entry_add_bulk(p, table_id[i],
+		ret = rte_pipeline_table_entry_add_bulk(p, table_ids[i],
 				(void **)key_array, table_entries, 5, key_found, table_entries_ptr);
 		if (ret < 0) {
 			rte_panic("Add entry bulk to table %u failed (%d)\n",
-				table_id[i], ret);
+				table_ids[i], ret);
 			goto fail;
 		}
 	}
@@ -519,11 +519,11 @@ setup_acl_pipeline(void)
 			}
 		}
 
-		ret = rte_pipeline_table_entry_delete_bulk(p, table_id[i],
+		ret = rte_pipeline_table_entry_delete_bulk(p, table_ids[i],
 			(void **)key_array, 5, key_found, table_entries);
 		if (ret < 0) {
 			rte_panic("Delete bulk entries from table %u failed (%d)\n",
-				table_id[i], ret);
+				table_ids[i], ret);
 			goto fail;
 		} else
 			printf("Bulk deleted rules.\n");
@@ -555,12 +555,12 @@ setup_acl_pipeline(void)
 
 			rule_params.priority = RTE_ACL_MAX_PRIORITY - n;
 
-			ret = rte_pipeline_table_entry_add(p, table_id[i],
+			ret = rte_pipeline_table_entry_add(p, table_ids[i],
 				&rule_params,
 				&table_entry, &key_found, &entry_ptr);
 			if (ret < 0) {
 				rte_panic("Add entry to table %u failed (%d)\n",
-					table_id[i], ret);
+					table_ids[i], ret);
 				goto fail;
 			}
 		}
@@ -581,11 +581,11 @@ setup_acl_pipeline(void)
 			delete_params = (struct
 				rte_pipeline_table_acl_rule_delete_params *)
 				&(rule_params.field_value[0]);
-			ret = rte_pipeline_table_entry_delete(p, table_id[i],
+			ret = rte_pipeline_table_entry_delete(p, table_ids[i],
 				delete_params, &key_found, NULL);
 			if (ret < 0) {
 				rte_panic("Add entry to table %u failed (%d)\n",
-					table_id[i], ret);
+					table_ids[i], ret);
 				goto fail;
 			} else
 				printf("Deleted Rule.\n");
@@ -607,12 +607,12 @@ setup_acl_pipeline(void)
 
 			rule_params.priority = RTE_ACL_MAX_PRIORITY - n;
 
-			ret = rte_pipeline_table_entry_add(p, table_id[i],
+			ret = rte_pipeline_table_entry_add(p, table_ids[i],
 				&rule_params,
 				&table_entry, &key_found, &entry_ptr);
 			if (ret < 0) {
 				rte_panic("Add entry to table %u failed (%d)\n",
-					table_id[i], ret);
+					table_ids[i], ret);
 				goto fail;
 			}
 		}
diff --git a/app/test/test_table_pipeline.c b/app/test/test_table_pipeline.c
index 960f730cf2..318ef1ac6c 100644
--- a/app/test/test_table_pipeline.c
+++ b/app/test/test_table_pipeline.c
@@ -311,14 +311,14 @@ setup_pipeline(int test_type)
 				.action_data_size = 0,
 		};
 
-		if (rte_pipeline_table_create(p, &table_params, &table_id[i])) {
+		if (rte_pipeline_table_create(p, &table_params, &table_ids[i])) {
 			rte_panic("Unable to configure table %u\n", i);
 			goto fail;
 		}
 
 		if (connect_miss_action_to_table)
 			if (rte_pipeline_table_create(p, &table_params,
-				&table_id[i+2])) {
+				&table_ids[i+2])) {
 				rte_panic("Unable to configure table %u\n", i);
 				goto fail;
 			}
@@ -326,9 +326,9 @@ setup_pipeline(int test_type)
 
 	for (i = 0; i < N_PORTS; i++)
 		if (rte_pipeline_port_in_connect_to_table(p, port_in_id[i],
-			table_id[i])) {
+			table_ids[i])) {
 			rte_panic("Unable to connect input port %u to "
-				"table %u\n", port_in_id[i],  table_id[i]);
+				"table %u\n", port_in_id[i],  table_ids[i]);
 			goto fail;
 		}
 
@@ -344,20 +344,20 @@ setup_pipeline(int test_type)
 		if (connect_miss_action_to_table) {
 			printf("Setting first table to output to next table\n");
 			default_entry.action = RTE_PIPELINE_ACTION_TABLE;
-			default_entry.table_id = table_id[i+2];
+			default_entry.table_id = table_ids[i+2];
 		}
 
 		/* Add the default action for the table. */
-		ret = rte_pipeline_table_default_entry_add(p, table_id[i],
+		ret = rte_pipeline_table_default_entry_add(p, table_ids[i],
 			&default_entry, &default_entry_ptr);
 		if (ret < 0) {
 			rte_panic("Unable to add default entry to table %u "
-				"code %d\n", table_id[i], ret);
+				"code %d\n", table_ids[i], ret);
 			goto fail;
 		} else
 			printf("Added default entry to table id %d with "
 				"action %x\n",
-				table_id[i], default_entry.action);
+				table_ids[i], default_entry.action);
 
 		if (connect_miss_action_to_table) {
 			/* We create a second table so the first can pass
@@ -370,17 +370,17 @@ setup_pipeline(int test_type)
 
 			/* Add the default action for the table. */
 			ret = rte_pipeline_table_default_entry_add(p,
-				table_id[i+2],
+				table_ids[i+2],
 				&default_entry, &default_entry_ptr);
 			if (ret < 0) {
 				rte_panic("Unable to add default entry to "
 					"table %u code %d\n",
-					table_id[i], ret);
+					table_ids[i], ret);
 				goto fail;
 			} else
 				printf("Added default entry to table id %d "
 					"with action %x\n",
-					table_id[i], default_entry.action);
+					table_ids[i], default_entry.action);
 		}
 	}
 
-- 
2.47.2

