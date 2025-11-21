Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 681BCCFC295
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Nov 2025 17:10:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E26AF40430;
	Fri, 21 Nov 2025 18:09:58 +0100 (CET)
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com
 [209.85.215.177])
 by mails.dpdk.org (Postfix) with ESMTP id 865A9402E3
 for <dev@dpdk.org>; Fri, 21 Nov 2025 18:09:54 +0100 (CET)
Received: by mail-pg1-f177.google.com with SMTP id
 41be03b00d2f7-bc17d39ccd2so1157684a12.3
 for <dev@dpdk.org>; Fri, 21 Nov 2025 09:09:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1763744993;
 x=1764349793; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0e3+WvhYOAXrDLNoZRCfl4Eb6Nr9w5f3sqZJxorPwCw=;
 b=IYJG2YK0jfsLfsso71j6xzJhHQWZhP35QZhvYIjDD2bE//udpcPdY/2LBl49us2yGY
 X6DAsw9I45fH3vG4wF3+Av+8j+az3RljoW+o8r4yIVPh4RVMQWJr44NFoi5B8hbK+ksb
 rOGtw7WWwlf/2oQoB78MPzDvDd83RFlaJqq1uyp6eVDYYZQdLWqUL3Ry/TfElRPPXy+c
 EdBZgzgPHlXVBgQ2TwgW6zKMFO5ze5Byv09V4KdEmJ4Qxxi3y/9OKC/y3i4z4tXUecWB
 KV9LVy3sm5otVWbCVeVJqSCZnW5kIyZR66vI1zh/+C0NT89bjAyACcSO441j3E9D12AB
 67Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763744993; x=1764349793;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0e3+WvhYOAXrDLNoZRCfl4Eb6Nr9w5f3sqZJxorPwCw=;
 b=WOJCBHDBDshWGt6u0/olNc7n4jLBdu63T9p/jwRymjKSUr8X4Ar7kzvSOcL70MQyMw
 YcrceD0H5oRyd5s9Fku26lN+duFGqwGp52jxGOGtgAx9JONAj1aYg2O9eeT1dTObjhg8
 1MT0p1IcauBlfpKGuFD1ZXCW3sXm87B4esWQKlBgs01XSbhz5T8DMlpUGJuyAYnxiHAH
 xzfQXKFvmyGVOxK2t93gtZDOqZQWw89n88+RAseYl8NebkRPqzLzHQ08skHgcF1St8f0
 tdjwGlt5S2lW3xintDScSIkIlPayhrtNglDtjIKhAd68MhLsSg5XaQgy/cx/WiVC0BIY
 6JBQ==
X-Gm-Message-State: AOJu0Yx4pakt+avX3MusPfStnhvOCrI2gKmhYcGQh7YYJZgIRuq47iXf
 IGUnDRuWHTFXckTAnwOt0Pn5cDhL/IzVaQR+GmNjmWqN5tn8JUzkU2tpXOFY1W8EIeAPlTPEN2C
 Brrcj
X-Gm-Gg: ASbGncuTEHtyf4Pb3I25miHPqKMbm2SAT3qUShdQO9p2TBukPsYGXBSBujc0QX612q/
 9joq5Z3XMAhhAAMgZ+bUPz2rbDXZByat4exn1V40konI7wtYY7eHZSXLw/ve89+wn3sMyDvK4fO
 8cq450WnPevxqu+ddqjOVfbo7P2WDPLOLYUVC++6akGrnWqmQwl9kKCalAzuvIK43sL8+f721ax
 XLwIDbETwO7kLX+iLN+lHTzDicU/ujPN1ObQg2EBvP4pDyAINXlTOi2PZjG0IwWVRjSRrUilhno
 g+wfcRrePWJaZ+zMLjQptv7y/opcNQ3ySaDU5i58/pvtwOmZs7ZX0p9YsO9Dl9neNYXoMg3DrSm
 Ig8f6qgjsrpjiuSrU2g0W+h+yUbNB5nx/Q7K3ghgc0yCALLtIsW7G8LJeLR1mlPtGIXXLd6w/tD
 /sXLI5+zPTsiA4qb0a8UVVrcKsffAH2ZfYAhl8mzsyrSDcbHrDCg==
X-Google-Smtp-Source: AGHT+IGtw9dV5Li3d0r95M4fMxsBV7OUbjIJLMz4ydEUE7H4Yjq4VNnxgOSdf7A9x4bF/3s0vCepxA==
X-Received: by 2002:a05:7300:f282:b0:2a4:3593:4686 with SMTP id
 5a478bee46e88-2a7192c3861mr857419eec.34.1763744993518; 
 Fri, 21 Nov 2025 09:09:53 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2a6fc5b122dsm21341544eec.5.2025.11.21.09.09.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Nov 2025 09:09:53 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v5 3/8] test: avoid overflowing huge directory path
Date: Fri, 21 Nov 2025 09:08:22 -0800
Message-ID: <20251121170947.134502-4-stephen@networkplumber.org>
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

Since the tests construct a mulit-part path in huge pages directory,
avoid overflowing the string buffer by limiting the possible
huge page directory.  Can never happen in real life, but compiler
gives warnings about string overflow that it could.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 app/test/test_eal_flags.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/app/test/test_eal_flags.c b/app/test/test_eal_flags.c
index c2e6c00edb..1d1ca87e0f 100644
--- a/app/test/test_eal_flags.c
+++ b/app/test/test_eal_flags.c
@@ -172,7 +172,7 @@ process_hugefiles(const char * prefix, enum hugepage_action action)
 	struct dirent *dirent = NULL;
 
 	char hugefile_prefix[PATH_MAX] = {0};
-	char hugedir[PATH_MAX] = {0};
+	char hugedir[PATH_MAX - NAME_MAX] = {0};
 	char line[PATH_MAX] = {0};
 
 	int fd, lck_result, result = 0;
@@ -222,7 +222,7 @@ process_hugefiles(const char * prefix, enum hugepage_action action)
 				break;
 			case HUGEPAGE_DELETE:
 				{
-					char file_path[PATH_MAX] = {0};
+					char file_path[PATH_MAX + NAME_MAX] = {0};
 
 					snprintf(file_path, sizeof(file_path),
 						"%s/%s", hugedir, dirent->d_name);
@@ -873,7 +873,7 @@ test_no_huge_flag(void)
 static int
 test_misc_flags(void)
 {
-	char hugepath[PATH_MAX] = {0};
+	char hugepath[PATH_MAX - NAME_MAX] = {0};
 	char hugepath_dir[PATH_MAX] = {0};
 	char hugepath_dir2[PATH_MAX] = {0};
 	char hugepath_dir3[PATH_MAX] = {0};
-- 
2.51.0

