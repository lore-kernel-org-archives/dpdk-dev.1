Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34559CAC583
	for <dpdk-dev@archiver.kernel.org>; Tue,  9 Sep 2025 13:50:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 08B6340281;
	Tue,  9 Sep 2025 15:50:19 +0200 (CEST)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51]) by mails.dpdk.org (Postfix) with ESMTP id 3680E4026D
 for <dev@dpdk.org>; Tue,  9 Sep 2025 15:50:17 +0200 (CEST)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-45de2b517a3so23571985e9.3
 for <dev@dpdk.org>; Tue, 09 Sep 2025 06:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1757425816;
 x=1758030616; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BjOnk4r0PFHzduqRXVTmi8FtwwGziUY2y9xPhfgR6qo=;
 b=d9eM3+9zsp11sWff4Igv1GbxhZIgC7o+UWLh2u0jBQSDftVCxqzR35QS93ZtvpwzHd
 oYla1puExMWOslEexzQvzq/cky21AlLdyyRPUloD4v87D227fS2vi3EsPwYKS7gQjEmI
 nlsuGRLeXVbBiPJ6/1oVGiXkms3eXCGf/ybtHVXqlAAY0nMcKe/UC8qAU1VZdzhrxYEE
 dThzpO5xvWYahjcxKpJvdEIGu/ovbgVQ7YbPn728n0wl174ZQy0qcvYBtpjqYICOXeA0
 XyanD4x/9lsGrINdO69zJspivS6d4yz4O9lK/6c//hH/reEINE39hHBZ3mYmgm/kVe7x
 1ycw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757425816; x=1758030616;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BjOnk4r0PFHzduqRXVTmi8FtwwGziUY2y9xPhfgR6qo=;
 b=w5jI2qvhkcoKX6hIKQuxkneoZzm2HvY5foZPgdpVhIwm2Pywks8U+TyBfOMylnGfoA
 DpE2PaLYuJQb6+HVnj/BYschFjLbKK4fJsVS8ya60Z+4nE2ya4FrqSZ0AXMrzhZLVTJa
 o01VZ0DSstUg3lmDQ/5bamcxU+zIXo9FTRJm9aF0PBf7+hmUqkhKiZbBYqhk33d0StVy
 Dp2RO+22zVmfXLMeeihYEtv/c+/c0ZmruKObBK/IqMfvIooLPC9dF+gzjl++vTePTFyn
 PAvXpsBnZ7aWEJG78ZI/sUlpWiFaonbwfvCLEQhaAZPzeTr/ARioiEqcliY4VpcBM2mb
 KsOQ==
X-Gm-Message-State: AOJu0YymSDsqlDvIfryJI8Ecd/Ifag4mEd3LiZlAMc+rfFOC2XX56/Ut
 Gveod4S8Qx9CI2C840Jg3GUeBPEjelQQLWQPSIHxOySCBiWE9vbvuGDg3v76NoprVj67Cmb6oeU
 yHQ7e
X-Gm-Gg: ASbGnctrZn6mu0vPnQ5eademn/rGbR/mP7f3H2RQ0L10Dd7VL/NtV2JAla3YRSBE6gz
 W1aoPspLr061ftAPsiKVsoDXJAJKyVI7deqyqHE1n+zkHg+eyYanxAzXi18FZp61vb8uJxGab+9
 dMPY2SN0UbhGI7p4dSfH68ompWmscYOcm0ZTnrlavNPou7t01cgxInuOsHIwUdt37ExCrKs+f+p
 UtQPd7HofYqTV4Wr6aDzWwHQ8FHtn0hQbzERFRQ0z7q0yJy+rfszzKjh36+qW9LPwGKtEXs8F7G
 wJ70wrWrI6xBumFWUXFY9YMh+lbAXon7RE7kXf6TA+I0PGpm35qmMe7P6FOFGaOEDx1U4itrFVs
 8Oe+TLwce1tkx8sfay3YPiZzt45DCiXa7lFjbJV1EwbUrCu5YIzpLvCqAU7E7E8AvoIOqWIg95G
 Phqz8495s=
X-Google-Smtp-Source: AGHT+IGzwWRjj8bIFXKGHowzYjfQfYpaqUxB45yR/8gHyOGa1SfytxMi9lZqLhTbqhfiCga65Pldeg==
X-Received: by 2002:a05:600c:4fc9:b0:45b:7aae:7a92 with SMTP id
 5b1f17b1804b1-45ddded75e1mr94473775e9.21.1757425816167; 
 Tue, 09 Sep 2025 06:50:16 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45deff68b43sm11634465e9.2.2025.09.09.06.50.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Sep 2025 06:50:15 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Chengwen Feng <fengchengwen@huawei.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v4] test/argparse: change initialization to workaround LTO
Date: Tue,  9 Sep 2025 06:49:52 -0700
Message-ID: <20250909135010.345224-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250627162305.340042-1-stephen@networkplumber.org>
References: <20250627162305.340042-1-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

When compiled with Link Time Optimization, the existing code
generated an error, because the compiler was unable to intuit
that there was space in the flexible array.

In function ‘test_argparse_copy’,
    inlined from ‘test_argparse_init_obj’ at ../app/test/test_argparse.c:108:2,
    inlined from ‘test_argparse_opt_callback_parse_int_of_no_val’ at ../app/test/test_argparse.c:490:8:
../app/test/test_argparse.c:96:17: warning: ‘memcpy’ writing 56 bytes into a region of size 0 overflows the destination [-Wstringop-overflow=]
   96 |                 memcpy(&dst->args[i], &src->args[i], sizeof(src->args[i]));

Initializing a structure with flexible array is special case
and compiler expands the structure to fit. But inside the copy
function it no longer knew that.

The workaround is to put the copy inside the same function
and use structure assignment. Also macro should be upper case.

Fixes: 6c5c6571601c ("argparse: verify argument config")
Acked-by: Chengwen Feng <fengchengwen@huawei.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
v4 - rebase to force CI rebuild

 app/test/test_argparse.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/app/test/test_argparse.c b/app/test/test_argparse.c
index 0a229752fa..1d05196694 100644
--- a/app/test/test_argparse.c
+++ b/app/test/test_argparse.c
@@ -71,7 +71,7 @@ test_argparse_callback(uint32_t index, const char *value, void *opaque)
 }
 
 /* valid templater, must contain at least two args. */
-#define argparse_templater() { \
+#define ARGPARSE_TEMPLATE { \
 	.prog_name = "test_argparse", \
 	.usage = "-a xx -b yy", \
 	.descriptor = NULL, \
@@ -87,25 +87,24 @@ test_argparse_callback(uint32_t index, const char *value, void *opaque)
 	}, \
 }
 
-static void
-test_argparse_copy(struct rte_argparse *dst, struct rte_argparse *src)
-{
-	uint32_t i;
-	memcpy(dst, src, sizeof(*src));
-	for (i = 0; /* NULL */; i++) {
-		memcpy(&dst->args[i], &src->args[i], sizeof(src->args[i]));
-		if (src->args[i].name_long == NULL)
-			break;
-	}
-}
 
 static struct rte_argparse *
 test_argparse_init_obj(void)
 {
-	static struct rte_argparse backup = argparse_templater();
-	static struct rte_argparse obj = argparse_templater();
-	/* Because obj may be overwritten, do a deep copy. */
-	test_argparse_copy(&obj, &backup);
+	/* Note: initialization of structure with flexible array
+	 * increases the size of the variable to match.
+	 */
+	static const struct rte_argparse backup = ARGPARSE_TEMPLATE;
+	static struct rte_argparse obj = ARGPARSE_TEMPLATE;
+	unsigned int i;
+
+	obj = backup;
+	for (i = 0; ; i++) {
+		obj.args[i] = backup.args[i];
+		if (backup.args[i].name_long == NULL)
+			break;
+	}
+
 	return &obj;
 }
 
-- 
2.47.3

