Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B02F7D3CC82
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Jan 2026 22:25:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 219E940E49;
	Wed, 14 Jan 2026 23:25:14 +0100 (CET)
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com
 [209.85.128.68]) by mails.dpdk.org (Postfix) with ESMTP id 51A2A40E49
 for <dev@dpdk.org>; Wed, 14 Jan 2026 23:25:12 +0100 (CET)
Received: by mail-wm1-f68.google.com with SMTP id
 5b1f17b1804b1-4779aa4f928so3165885e9.1
 for <dev@dpdk.org>; Wed, 14 Jan 2026 14:25:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768429512;
 x=1769034312; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+WQXNdx5mgp7Lo4SjFghewpBG5SeorDzlfMW2hxApO4=;
 b=bCN2rrd0iN+fBpcnryYfI6fwQ4qZlBInkGNuLmaYJyEYbRISpW/AKh88dppk+sRdzE
 ap1TRHCaS0oDvM12MzjhN6zIVEBx1Oh0uciAkBZvvqgXZO6jppgsWru2WM6SoEadaZFZ
 7UGFnnoQWBzlFjVHLMAeBarcal6EgL5SIHawJw0WDCfAUEuY6DhjNHp2mW+LtTsKa8Fm
 lY2+Zp+XJaakuq70Zz3C1MUI5PzxqUv5Go3VuwgAAhCBIkrvPLDaIUgaJirZWiyYrjW2
 2xKWV6TmWFVdDOAJdGu6/JgRYgvLVctpNyTvaMWbHzumv5AXFdlAr4Bi70Ku9Aq6hteU
 ZLyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768429512; x=1769034312;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+WQXNdx5mgp7Lo4SjFghewpBG5SeorDzlfMW2hxApO4=;
 b=kUng4mSHJfUwFi+aVkx9Ocyc8i7koP71iWUwQzi6OF1iJ68FF0NZ+Nnb0guT5jyNvP
 dEZ23U284pnyL504OIuhALCwX7IJK7d4zGX/80H3wh7AzHuMfidVRXsBtWa+pdsRmMAS
 t//BgrjGLWQVEuOMgVyD5lj5jePwOY6FbQAJcyO8ayyOxoLM5bYjAj5ieHfkMYINR6AU
 ir/R4uEuZLRl9GKH2XXGsTnGvRsEUHK3Nbo9kzWMMSyP/tVPwBAlLeaZpFIEYj4LU8SB
 WdostCaud8tKExcSy37BkF20ZNo9WGCqra4dxSlcpJSeV3wssb772qExsSq55SPRqTR3
 OfQQ==
X-Gm-Message-State: AOJu0YxjVDww8BpXvoLMh1STucL5QtncA8CCAJIiykUJpFKc4rqFXEn2
 3733BED15A6+jcZ0gYTqHuxPIJv+HxMD1oAHViG74CFTJYQFenyb3irYsrpEecPBLT0htzXJPRU
 B1MI37Og=
X-Gm-Gg: AY/fxX7TlLdXBGXHqfUa5XAD4/bu3eOOV/2oL4DOfzlUWU4Hr/JyW4eEzF4tdgQRVKy
 CVm9oT8VEjF4mQLpWKih1Q7i6NDtfTuq7nBkmbAGS02zYYt6rdp+PGQWQ+uvO9tsBWP7fiqiqAt
 QcBkOhYnoZukNHm3y4hCdbo+DPHuQ2zKVKdELb+iE+UqJkHN1gUKIY4cOjOsNClVoNMTEaMVCSj
 QGyK7TvgD8qaCLUhljSFXTmNGp0cr/fdDAgnyRhTSJw6FPmlc8kpPzUXNN81k1xJSUHRl+FSVOh
 Mqpk+4L1DhqiMaL/xLTIJk28ojAyHtDCcCSJYgXd5PW/LQBMCtIEr0/KX9lXQL7SB5d+Ev9t9Ue
 +G9p5UZSVfXCJD/PmEsj8oCDAE1mjbyr6wwkhwRmlhIyvjIJXb+ViiHkNfL8hzkMKYaUOIZVVPl
 7WECLMQZ6SjMW9w+POGRSVhns2z2ypfGNvmewwnxX1b5jq6KxgOw==
X-Received: by 2002:a05:600c:314f:b0:47a:80f8:82ab with SMTP id
 5b1f17b1804b1-47ee335e701mr45032655e9.24.1768429511877; 
 Wed, 14 Jan 2026 14:25:11 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47f42907141sm12040355e9.9.2026.01.14.14.25.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jan 2026 14:25:11 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: [PATCH 05/29] examples/ip_fragmentation: correct documentation errors
Date: Wed, 14 Jan 2026 14:21:46 -0800
Message-ID: <20260114222458.87119-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260114222458.87119-1-stephen@networkplumber.org>
References: <20260114222458.87119-1-stephen@networkplumber.org>
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

Address formatting issues in IP fragmentation sample documentation:
- Capitalize "linux" to "Linux" in two instances
- Add missing spaces before port lists in example commands

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/sample_app_ug/ip_frag.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/doc/guides/sample_app_ug/ip_frag.rst b/doc/guides/sample_app_ug/ip_frag.rst
index d2c66683e3..7dcb0177f6 100644
--- a/doc/guides/sample_app_ug/ip_frag.rst
+++ b/doc/guides/sample_app_ug/ip_frag.rst
@@ -62,7 +62,7 @@ where:
 
 *   -q NQ: Maximum number of queues per lcore (default is 1)
 
-To run the example in linux environment with 2 lcores (2,4) over 2 ports(0,2) with 1 RX queue per lcore:
+To run the example in a Linux environment with 2 lcores (2,4) over 2 ports (0,2) with 1 RX queue per lcore:
 
 .. code-block:: console
 
@@ -84,7 +84,7 @@ To run the example in linux environment with 2 lcores (2,4) over 2 ports(0,2) wi
     IP_FRAG: entering main loop on lcore 2
     IP_FRAG: -- lcoreid=2 portid=0
 
-To run the example in linux environment with 1 lcore (4) over 2 ports(0,2) with 2 RX queues per lcore:
+To run the example in a Linux environment with 1 lcore (4) over 2 ports (0,2) with 2 RX queues per lcore:
 
 .. code-block:: console
 
-- 
2.51.0

