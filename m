Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F79DCFC295
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Nov 2025 17:10:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C3D2840611;
	Fri, 21 Nov 2025 18:10:04 +0100 (CET)
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com
 [209.85.215.171])
 by mails.dpdk.org (Postfix) with ESMTP id 8B980402E3
 for <dev@dpdk.org>; Fri, 21 Nov 2025 18:09:56 +0100 (CET)
Received: by mail-pg1-f171.google.com with SMTP id
 41be03b00d2f7-b98983bae80so1904503a12.0
 for <dev@dpdk.org>; Fri, 21 Nov 2025 09:09:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1763744996;
 x=1764349796; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Fm0fKRDS4YRVts/D6rPe52eqre9y2vs0bibayAdUECg=;
 b=eBxRWNDmXKlByQExgNHvuEwjmT20PDF0RrrAX9PL8RCSmwuwF+eNlI9V1eQAMy4S5M
 cVDEvSVQ7SAQUh1zJzP/yoVlkgGDPE3ayVC1G04nstecFGTPdm0M+kjGUTlFlvM+vAbr
 hXPAozIpBl3DIligRTAXvBXG1K+g6rji5QeaiFQMLWUvCrm8X5ZRko/e25bgRzyQK6Pa
 1x3NMI9efjFjTp3GeWjcf2Nav7wP55iTqjdHCEKDFMS34DLat6LeLX32UvnfSmrKmS6i
 GQ1+pzhXmxgHGhDgXt/NUiiRNC62o99WCeCKVxkwoUCgqF+b9XEVCo3eQltP+a89cuud
 k/HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763744996; x=1764349796;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Fm0fKRDS4YRVts/D6rPe52eqre9y2vs0bibayAdUECg=;
 b=v9JKW7yryMqYZ8Xer4gZ4A+ig4gGs8qNy7u2BB7UbPSwVR3yVabJVjems8oXkf4vwE
 j7NVNmeJVo8GgrxcJ1f/deYMc33SfLAgEv7SFm/VIpT84vKsGJhhBG2rTfzTfuKO6LUJ
 Hks8Dhfu6LXMTTYaac1OPXjkPZqruGoRZ4Mjg2g7O6J+07MvjEB0arJxyNj9dD8pSQ6e
 BT7Dkj0b2qL+2det3Mf9tYehji2F8UF2CmNen9/TWQuskPoQo3EgdC+XahIeXtJkAZ7t
 dbwvMmMFn6t31wXNpILEtviGgkK5OaEkEbqyv50B4Z6FAytepkSv8SVJfx09qk61lFjg
 G23w==
X-Gm-Message-State: AOJu0YyrCysMaDz7VMrXV/OgJ/ZbI0zolGtGYqjounD/Q6xQTkxzEZS+
 KNcM1UTdiabcdWo55Oxy3ef6scsc/cGF3LwT6j/mNZjWxSgzokW6efw/Dx284G99GGzMj2joIMs
 Jt2Mm
X-Gm-Gg: ASbGncuaC0ir8n9mBd5RlbPbKY7WBv45zO5Mq8d3QNxqvxRVeVyimvIYxKUB7NUWqu9
 Os4BXsB3MQ1GVnpwdBr8BTzZr0i4+h1sOsQnwxuX1XCA5DV5ty51uFxifqWMMpHThiVhqMZwLsx
 ipWEm0hYpCGDN8CFC/CWYviZNOoP7Yk78y+acHs0GvVfuNbhv/VIhJRh8rB+I1Pxo2m/xRD9NDb
 tUKdx8eUfIY3aHJMdKjraaiWyfXeKggmHQyxQZLTEw5rQ5UBnlU6pJNtyWQQjOSPu2vhPdYF3Te
 FpYb1UiOmAJDNlagckJK6yJKaTr7kw8Fy3KKQ4PqtN9MPQ2Z+D7eCPapufuJVN3X4vlVvLmH2oG
 kEjlQvV1xkNK7eW8VJBiPl0+ypFgSJt7ot+95oAKgPcM+NyFM06rBYoXIm33ZAxZdtHCttm4ray
 vk9tgEY0pi4BlBYFhiRPCi4ve33N0RNE+IUMQA1IQtL8UlAP9rF9dgIUNPycPO
X-Google-Smtp-Source: AGHT+IEkGx0KRQnrhqbg4FGk1iFEOTAKY67JS9I1cq789LyNcA2shEjzwkUlGOzbCQmzF0TMa/yI2Q==
X-Received: by 2002:a05:693c:6097:b0:2a4:3594:d533 with SMTP id
 5a478bee46e88-2a7193b404bmr1083846eec.0.1763744995539; 
 Fri, 21 Nov 2025 09:09:55 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2a6fc5b122dsm21341544eec.5.2025.11.21.09.09.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Nov 2025 09:09:55 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Cristian Dumitrescu <cristian.dumitrescu@intel.com>,
 Pablo de Lara <pablo.de.lara.guarch@intel.com>
Subject: [PATCH v5 5/8] test: fix format overflow warning in ACL test
Date: Fri, 21 Nov 2025 09:08:24 -0800
Message-ID: <20251121170947.134502-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251121170947.134502-1-stephen@networkplumber.org>
References: <20251110182209.104087-1-stephen@networkplumber.org>
 <20251121170947.134502-1-stephen@networkplumber.org>
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

This test has an array of input lines, but the two dimensional
array confuses compiler length checks. Convert to an array
of pointers to fixed strings which avoids the problem.
Make both variables static since not shared with other code.

Fixes: 5205954791cb ("app/test: packet framework unit tests")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 app/test/test_table_acl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/app/test/test_table_acl.c b/app/test/test_table_acl.c
index dff9bddfb9..94edf37234 100644
--- a/app/test/test_table_acl.c
+++ b/app/test/test_table_acl.c
@@ -317,7 +317,7 @@ parse_cb_ipv4_rule_del(char *str, struct rte_table_acl_rule_delete_params *v)
  * separated by ' : ', just ':'. It's a lot more readable and
  * cleaner, IMO.
  */
-char lines[][128] = {
+static const char * const lines[] = {
 	"@0.0.0.0/0 0.0.0.0/0 0:65535 0:65535 2/0xff", /* Protocol check */
 	"@192.168.3.1/32 0.0.0.0/0 0:65535 0:65535 0/0", /* Src IP checl */
 	"@0.0.0.0/0 10.4.4.1/32 0:65535 0:65535 0/0", /* dst IP check */
@@ -325,7 +325,7 @@ char lines[][128] = {
 	"@0.0.0.0/0 0.0.0.0/0 0:65535 206:206 0/0", /* dst port check */
 };
 
-char line[128];
+static char line[128];
 
 
 static int
-- 
2.51.0

