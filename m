Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1265CC9830C
	for <dpdk-dev@archiver.kernel.org>; Sat, 17 Jan 2026 02:38:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C7C6F42F09;
	Sat, 17 Jan 2026 03:38:31 +0100 (CET)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com
 [209.85.218.45]) by mails.dpdk.org (Postfix) with ESMTP id 94A4A42EFC
 for <dev@dpdk.org>; Sat, 17 Jan 2026 03:38:30 +0100 (CET)
Received: by mail-ej1-f45.google.com with SMTP id
 a640c23a62f3a-b8718187eb6so401209866b.2
 for <dev@dpdk.org>; Fri, 16 Jan 2026 18:38:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768617510;
 x=1769222310; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bbs4p8Zf5fG0wh5pZQmnyKip7RhZ0QufmWBpfOo4Rko=;
 b=nApnKFbh+OaTdIZskndR8aJQHSsg8xj/ppuAjgrA/jyyXuHP2t3/obiwcT0tE0X8Rh
 KUuTnyBDRvLm4gBkdtWR5lIM0WQPJFTgoSxrjD3Qg3ZOpN/iw3BEKzKdyZ5pj22j8fNE
 vmi4qutWgAzCtnJCf/LZyXI4Algm9wYqcmXqpvlnjYzO1qaPjxc1qbcQBXIjX2UwYt1E
 lIk1EET76f7B8HE4hiG/VmRw625sr5gfJCTTKaX9lsn9nI9G57B19q9bR95aiqiMPhqd
 h2A0jBYmNBp1O2z4Vc+CRZhOuIW4grIrDfSyhHURb0r29PU7qCJqRy/jica9ec2l3O+i
 q7Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768617510; x=1769222310;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bbs4p8Zf5fG0wh5pZQmnyKip7RhZ0QufmWBpfOo4Rko=;
 b=q9dF3hW7m0fxq05Zuivi94CvkSZnd4HDin5Oo0lkq1M72I4XTzz1Bgsd70db/rpWal
 Qc4Obcvj1yccfUgN1rRbT1rEEvIQBWQ3R1Lb5Ijv4PJiE99zGGBaO0xNfa1Jgrk1noHd
 qsHQ8hsJCQSZ+fjEkk+Uia3xRETQXZp7zJAfJ5/fhDcSF2YkmB/xfCXs4yLlJQxou7AX
 /fB7dVc66ao/2aJkNl39ube7H2yq1b4EvNc5HrvpU1kQMkeT5Lmd7f7Is4/WXQ3SWBV+
 UUDaIGABBsrZ/PlxN5jS715Q+Mnm5I0unhCtDsY2joMQVEAml2qakVgC0TjEJWPhag9/
 a8qA==
X-Gm-Message-State: AOJu0Yy06YQf4iKfTNSdZwTEW+qcTOLW4Lru6oMcTH273o/BjxBz+vUO
 cCBTiimk5PJKeGyVfg5nZLgyNsZiCC+JqhNnG+dfrA8TT0HgUH/sq3pfhfmEGL9KcJZezjfjogO
 aoL75
X-Gm-Gg: AY/fxX4VDu+j28uvz/sFFtyKwfajbmGP6cuFuG+dsJNj0JA75f+3rkqhx0jJPbymkLj
 X1WHecMtdhER/axDWDfM9pydb/hFne3QBVmNoaI4HpMbenXMTJEKHwR8qFxuYbtRMJCtYraXSFf
 4gmtszUJFNjUzVQhky6FHlL08aev1jpvmoOJ6mBEPEMW20dH5icKpIqyiumP92I1ObqjO840rDF
 AmOOKlXa3zOvx96Bo1y0WuMWyLZQ5NE3KQEAbR0kZMaWwL+pslHgwXpIGLb55RcySnd0l1Jf9oc
 F+AVaZM/l99vBXfH4P34HYjbPtA7LFBpmumiiKT+40Lg1VtoMpAAdcj6GYryQGjHZwNNIFxAaEG
 I1vsFZVy7MUJJ657cR8NaK6pf/VOORGtmQ2yf0GlgfxOZJqa/6LshJTS9auBxBd4UB/PVeQJBSi
 zpm5rb+VjHYHT4wm8PNH6K7n622SZh82AjV1YQ+kfWtndfmKzMqg==
X-Received: by 2002:a17:907:268b:b0:b87:65c5:603a with SMTP id
 a640c23a62f3a-b8793244052mr464053866b.39.1768617510067; 
 Fri, 16 Jan 2026 18:38:30 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b87959fb980sm439960166b.49.2026.01.16.18.38.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Jan 2026 18:38:29 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Cristian Dumitrescu <cristian.dumitrescu@intel.com>,
 Pablo de Lara <pablo.de.lara.guarch@intel.com>
Subject: [PATCH v11 4/6] test: fix format overflow warning in ACL test
Date: Fri, 16 Jan 2026 18:36:59 -0800
Message-ID: <20260117023817.196694-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260117023817.196694-1-stephen@networkplumber.org>
References: <20251110182209.104087-1-stephen@networkplumber.org>
 <20260117023817.196694-1-stephen@networkplumber.org>
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
 app/test/test_table_acl.c | 30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/app/test/test_table_acl.c b/app/test/test_table_acl.c
index dff9bddfb9..7b6ea16cfd 100644
--- a/app/test/test_table_acl.c
+++ b/app/test/test_table_acl.c
@@ -312,22 +312,6 @@ parse_cb_ipv4_rule_del(char *str, struct rte_table_acl_rule_delete_params *v)
 	return 0;
 }
 
-/*
- * The format for these rules DO NOT need the port ranges to be
- * separated by ' : ', just ':'. It's a lot more readable and
- * cleaner, IMO.
- */
-char lines[][128] = {
-	"@0.0.0.0/0 0.0.0.0/0 0:65535 0:65535 2/0xff", /* Protocol check */
-	"@192.168.3.1/32 0.0.0.0/0 0:65535 0:65535 0/0", /* Src IP checl */
-	"@0.0.0.0/0 10.4.4.1/32 0:65535 0:65535 0/0", /* dst IP check */
-	"@0.0.0.0/0 0.0.0.0/0 105:105 0:65535 0/0", /* src port check */
-	"@0.0.0.0/0 0.0.0.0/0 0:65535 206:206 0/0", /* dst port check */
-};
-
-char line[128];
-
-
 static int
 setup_acl_pipeline(void)
 {
@@ -343,6 +327,20 @@ setup_acl_pipeline(void)
 	parse_5tuple parser;
 	char acl_name[64];
 
+	/*
+	 * The format for these rules DO NOT need the port ranges to be
+	 * separated by ' : ', just ':'. It's a lot more readable and
+	 * cleaner, IMO.
+	 */
+	static const char * const lines[] = {
+		"@0.0.0.0/0 0.0.0.0/0 0:65535 0:65535 2/0xff", /* Protocol check */
+		"@192.168.3.1/32 0.0.0.0/0 0:65535 0:65535 0/0", /* Src IP checl */
+		"@0.0.0.0/0 10.4.4.1/32 0:65535 0:65535 0/0", /* dst IP check */
+		"@0.0.0.0/0 0.0.0.0/0 105:105 0:65535 0/0", /* src port check */
+		"@0.0.0.0/0 0.0.0.0/0 0:65535 206:206 0/0", /* dst port check */
+	};
+	char line[LINE_MAX];
+
 	/* Pipeline configuration */
 	p = rte_pipeline_create(&pipeline_params);
 	if (p == NULL) {
-- 
2.51.0

