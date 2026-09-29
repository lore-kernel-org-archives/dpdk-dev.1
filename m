Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E72BCA5FA5
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 16:42:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3B94942F02;
	Tue, 29 Sep 2026 18:39:36 +0200 (CEST)
Received: from mail-pz2-f39.google.com (mail-pz2-f39.google.com
 [74.125.228.39]) by mails.dpdk.org (Postfix) with ESMTP id 503AF42EAC
 for <dev@dpdk.org>; Tue, 29 Sep 2026 18:38:43 +0200 (CEST)
Received: by mail-pz2-f39.google.com with SMTP id
 d2e1a72fcca58-88098db8dcdso1901532b3a.3
 for <dev@dpdk.org>; Tue, 29 Sep 2026 09:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790699922;
 x=1791304722; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yU8LJ/ORSU+mIbPHWDoHNJh0jjlgqlfFZUk30xK1pcE=;
 b=zdCdawa8WqrwDWmSERlkDd2FnFT5+OQz6w/FG/3A6Z/0SgMAFi3NbQ9VHbAqoQtPpo
 ywbFKlGWJY504BLUR7PnwrgtiSj+mbcRVPRWV+Ti6eP4S3ryc6PUhYAMVDve6kGY+Ak6
 8lsrSP11tunlPgss3vtKy93i/Ax9iA06fXCBfdtCrLghl/XH7Q240ptWXca+hvW4DF9t
 XygmSHhCct0B7cVNnDnmWRoZAqzGS+tTQwXxqe/Kmw0JAFBxaP2fM0CEZWps6v+I/DD0
 X3WwhU52tqv7Ceps2kSAHYtopakGtGAbS0hiMjv2GY8Ebq5SDmPnPIf+S9RqAcWthFuz
 ImbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790699922; x=1791304722;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=yU8LJ/ORSU+mIbPHWDoHNJh0jjlgqlfFZUk30xK1pcE=;
 b=qt9ZnnQzAQFi4pSvS3IBGonswDxw6BPSm105nMon6Qqdo1ezGmqnMTOB/TkU7bq4OG
 heKh5U9E37iJliUCDgdI3n1yL50M8ZABi6lIxg2M1E6c2RoGMwrwusbE4JGOw1JYU7Re
 +9BgSiNFZoOhMtH1eY8y91h08g/qbnt8hitDMyRT2YevunFOG6TTP5iSrc6HWoA8oxql
 irMw8w7+9hPVEBRjK2+nAz1YvQtbjgEzv9AQyVUNI85d35QAzKMXw3a+z316LL/Fm2mk
 Hmp3cjE/dwUNtmj7Yund96kqsYGwdoUt1d2+GTbI6Uqj8v5BIHbp1l8q351E6szf5bXb
 WjkQ==
X-Gm-Message-State: AFuF++n7WmJEVE6pDH87N/R5Pza+dZkWHcxlkw0h2s/jM18YohZAQEpB
 FMkWBglnq063y1OrRFkeNS+37NF95HNE41NUjhQDpjHlSX7gafo2V7DTzTFdrMO4XHoVLI4+TGR
 IIC10Z2Y=
X-Gm-Gg: AYBFou3IpOgTo8L4frC3JF9XzjCKG4U/9A0Yj3oLHr1xXaFVB3fszVu2Nb9dw6eT4Tv
 bBuZV+mdK4CD99J18zaLdHtM7D2He0Vd/tZYxrxCkuYkiXoAwH+Ctt+rjVB6rl934xRaw2iX+PT
 I9MQv6/TC7emu+gF5ttfU5lo/0SziE0rJAySoNkLHtL7XtOuWoK1+sIvT/05+wBsv6yCKOyCmZg
 3+jUArnmUmX/E2LAkmyvEFoTKp7ghAobb9YEaNvyIcNl8rMy8RJVeniqsBfSItA+gor1NJ8dBcd
 naqvh5scuMohnPs4f/B0qWj5H6Z300y/i9ds1UcwJqBQejyxI/GlIpVHqUEASPwDRcwcptr/Wgh
 0E3oQck2pahfz1fdPwzLtyYxGLCae0HW2w7chjVCoBuq2lWJNNKkQ4f0F5UyLNJuO5eXItYnhO2
 c8O3y46whLefE4J4PTrQh61E6qbr5CD5vBxn51mCBM14ISVFPWdUWZ3ZGJqNCzNcprnEAMxdpq0
 P8jso4yiboLA/RFgnoN3ZKE17qwmStDguXnoR4=
X-Received: by 2002:a05:6a00:b70f:b0:87c:47ec:f3c with SMTP id
 d2e1a72fcca58-87e9dfaf9a6mr11445590b3a.47.1790699922462; 
 Tue, 29 Sep 2026 09:38:42 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8868ba02d02sm232392b3a.21.2026.09.29.09.38.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 09:38:42 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Xingui Yang <yangxingui@huawei.com>,
 Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH v2 38/61] net/hns3: use kvargs numeric helpers
Date: Tue, 29 Sep 2026 09:36:41 -0700
Message-ID: <20260929163800.1108305-39-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929163800.1108305-1-stephen@networkplumber.org>
References: <20260914054912.755403-1-stephen@networkplumber.org>
 <20260929163800.1108305-1-stephen@networkplumber.org>
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

hns3_parse_mbx_time_limit() checks neither errno nor the end pointer, so
a malformed value such as "abc" is taken as zero and then silently
ignored by the range test that follows.

The range test is now part of the conversion, which keeps the existing
behaviour of leaving the default in place when the value is out of
range.

The device capability mask parser is converted separately, later in this
series, since it needs the hexadecimal handler rather than a decimal one.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/hns3/hns3_common.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/hns3/hns3_common.c b/drivers/net/hns3/hns3_common.c
index 29b51856d9..c21740ba5e 100644
--- a/drivers/net/hns3/hns3_common.c
+++ b/drivers/net/hns3/hns3_common.c
@@ -231,14 +231,13 @@ hns3_parse_mbx_time_limit(const char *key, const char *value, void *extra_args)
 	if (value == NULL || extra_args == NULL)
 		return 0;
 
-	val = strtoul(value, NULL, HNS3_CONVERT_TO_DECIMAL);
-
 	/*
 	 * 500ms is empirical value in process of mailbox communication. If
 	 * the delay value is set to one lower than the empirical value, mailbox
 	 * communication may fail.
 	 */
-	if (val > HNS3_MBX_DEF_TIME_LIMIT_MS && val <= UINT16_MAX)
+	if (rte_kvargs_to_uint(value, HNS3_MBX_DEF_TIME_LIMIT_MS + 1,
+			       UINT16_MAX, &val) == 0)
 		*(uint16_t *)extra_args = val;
 
 	return 0;
-- 
2.53.0

