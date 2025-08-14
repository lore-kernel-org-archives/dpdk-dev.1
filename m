Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A725FCA0EE4
	for <dpdk-dev@archiver.kernel.org>; Thu, 14 Aug 2025 16:53:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9516F427BD;
	Thu, 14 Aug 2025 18:53:19 +0200 (CEST)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com
 [209.85.221.42]) by mails.dpdk.org (Postfix) with ESMTP id 8F36D427B8
 for <dev@dpdk.org>; Thu, 14 Aug 2025 18:53:17 +0200 (CEST)
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-3b9dc5cd4cbso867251f8f.1
 for <dev@dpdk.org>; Thu, 14 Aug 2025 09:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1755190397;
 x=1755795197; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sA/EpXKlhQzBl31sFngWbdTwJUI3gmNFarNwZwwyqls=;
 b=n8YjKngAZmg0UzUlHGJNj27pONFDjj0RA7T37J4SQSQl2Orb1Bbf/ZJpYhR4X/OeAx
 2MveI3bZYG4GlDQo4OImCL/pEonAsVvurhvxdBqqZZHbTZCLjPTFhTwD/4Y+DO1fSbvS
 iQn1OjYiXZLNSGtytQl0f6O0tQq5ezh2FQ1oC9JnorDRUZHl3H1NWzTcsdTBmwOKyqyu
 UE9YLgajfdKsavYUayAz2Qwo/7fK0D9vfE/Gkl1PVUNi7TIlEub7bdKK9+YU1mziQwP/
 AHxlzXEhhTBDOMbxUIV4LiEtnf3AciE2jqDW6QfEUxir/D995zMO6LxgH0ilFRc0Zata
 U/wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755190397; x=1755795197;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sA/EpXKlhQzBl31sFngWbdTwJUI3gmNFarNwZwwyqls=;
 b=aVOEjAb7VBV7otdliKaEohtZhkVYQ5qyFdjAinF4PrtpyxMhxxUcYfopxiXCAzi+w3
 WnUrHQenXcFoteCu6lDMJrOatuCQb4mgi1hYOPYRZWXaINCAWwNfUVzJFhsaE8hXATar
 bWGTQzRK85eMdqFrjRFk9XgUuG+aO+BWygK8MnRpt4WGdNAW8BPGy5mYrVDpm406w1W+
 mYDRQJKXpOBLRfeIiV/MfZ7zEteIZdOGH9zwBAe19aKsNZZ0Jyxj9HB2aboVB+FnDwt1
 CAMYQ8MvFcSHgN6MY53LE3qVw0yNHvtX+eZoFtapJxmGwYjpDopd7EHBpD52okIVoesh
 wsfA==
X-Gm-Message-State: AOJu0YxbZlePWk8KNPYGeDIhc9NX7ipKye9xVTvDLJHkEHwekryZJ1Qg
 jIll1AR1M4MqnMLt5B3gl6k44W86rZFOgNygZ5fWxEC2if8/7zfn//OpW/U1NNRtFez4wwVcAni
 C7dGG
X-Gm-Gg: ASbGncsTH5UelSuph/ZvOiRNOVHO2sqpBOr3YQpgOwXMWBniAOidb0wCsEJ1qJ4nlqi
 muXdoQh8ylPE3Wz9A1W1IqRzPdsiP8Zk69x3fd/GDnvsHh6xhZf1vV3bTLZr/8+Xhh/DN4dyRmA
 A4Fc443qxABpSfrWNbwDE4GVN13JyWY+3alVNM9nsJzgAnl9tocNEO8U4dAwBKqeKWpvH3g8g7b
 bq3V7xIKwjhlW7k60R+LnWDct0nXQSrUNmg3MmLkzZSJ2msG8Q8f3g8wvm7dHl/K2TUeU7/oUBG
 iOraB7EX/9yWkbiKdDp07ElSBc2gz6g1xK75SPPkuXggMNIv2plxVxkMrahC+IVVY8+XDMM7Jk5
 9m6W8jZfrcMvNWpCth3c9jpUcaImAXNyr85Gid4onbmkCwAxxYMWGNRj7ud4vd05EEvvCDcPO
X-Google-Smtp-Source: AGHT+IE53c54OgtkCJQoJ3Kn9uO9KwCpNaUdL1fdPJxeQSskH79SBSL+hZdnTEoN90KvBGuqOPi0sw==
X-Received: by 2002:a05:6000:2c03:b0:3b9:16e9:2cc2 with SMTP id
 ffacd0b85a97d-3b9ef2f8b98mr3384472f8f.14.1755190397128; 
 Thu, 14 Aug 2025 09:53:17 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3ba54f87e17sm1748197f8f.23.2025.08.14.09.53.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Aug 2025 09:53:16 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Reshma Pattan <reshma.pattan@intel.com>,
 Suanming Mou <suanmingm@nvidia.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v2 2/8] pdump: handle primary process exit
Date: Thu, 14 Aug 2025 09:52:58 -0700
Message-ID: <20250814165307.12786-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250814165307.12786-1-stephen@networkplumber.org>
References: <20250811213632.16023-1-stephen@networkplumber.org>
 <20250814165307.12786-1-stephen@networkplumber.org>
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

If primary process exits, then it is not possible (or needed)
to cleanup resources. Instead just exit after closing the
capture file.

Bugzilla ID: 1760
Fixes: a99a311ba101 ("app/pdump: exit with primary process")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/pdump/main.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/app/pdump/main.c b/app/pdump/main.c
index fa85859703..1741d7e709 100644
--- a/app/pdump/main.c
+++ b/app/pdump/main.c
@@ -1028,13 +1028,15 @@ main(int argc, char **argv)
 	dump_packets();
 
 	disable_primary_monitor();
-	cleanup_pdump_resources();
+
 	/* dump debug stats */
 	print_pdump_stats();
 
-	ret = rte_eal_cleanup();
-	if (ret)
-		printf("Error from rte_eal_cleanup(), %d\n", ret);
+	/* If primary has exited, do not try and communicate with it */
+	if (!rte_eal_primary_proc_alive(NULL))
+		return 0;
 
-	return 0;
+	cleanup_pdump_resources();
+
+	return rte_eal_cleanup() ? EXIT_FAILURE : 0;
 }
-- 
2.47.2

