Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85634CCF9E0
	for <dpdk-dev@archiver.kernel.org>; Fri, 24 Oct 2025 21:55:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A90A3402E0;
	Fri, 24 Oct 2025 23:55:03 +0200 (CEST)
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com
 [209.85.216.43]) by mails.dpdk.org (Postfix) with ESMTP id 29B894014F
 for <dev@dpdk.org>; Fri, 24 Oct 2025 23:55:01 +0200 (CEST)
Received: by mail-pj1-f43.google.com with SMTP id
 98e67ed59e1d1-33e27a3b153so2639759a91.3
 for <dev@dpdk.org>; Fri, 24 Oct 2025 14:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1761342900;
 x=1761947700; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VSFS6Xja25kswmX5YHSMeQ3EFy5NE/0X5r6+3S33NNE=;
 b=g/cGtlYN1wqa5uK9nuNxyZrW3jOfHom0VD9KdXj2MgMLtzXoP0cpT+x/Mr4eq6nkAJ
 7Qeqy6Te6xxHpQ1RlXmq6YB52xNq1K8bOtBjfKVpScxvxnvJOECoHoKcjrLfUWpN/jpw
 tB84+j4+nzdcU+q01wLv7SidpZyh4K2U+CtCKf43QryFoA6ngj/nrkHHeZSDuRsHcZP/
 PT+OVvHtn0hILcYUc/ImqWNYN4aRjPcQi5uIhFvDNgUNlNP6aOwBK8g997YADKvMYuJF
 R3wccHaHEwjnWncnvelKl7hR526x7zTMS45WAAJZ50D/Mx0iFgJEZLwCfAsVbncnKnHx
 Ms0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761342900; x=1761947700;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VSFS6Xja25kswmX5YHSMeQ3EFy5NE/0X5r6+3S33NNE=;
 b=CqV7PHkd0Wm2sBoOFoiEZdFiaYYx5mazhN+YLEsJD0p9aXBTgqYrDOIWnShWqqNCTN
 J+b3yoMYjYZo03LKYupX9PL/WUCpYBTuNH7jqSvz5/GZXTNzikLJzZDE1S5iOs1hL+9R
 sfO88QjjezanfyeXq6euAoKaAJx/ysOVwLoQ9ynJtru7w73ZOeGr42rpqFpW/b5p3Ga7
 EBzPUkNM9wsZeXRjJNLEsobV3CdH576QTGFvUFRBnIsIb8BI0zQpfEj47Zx+reATO1ic
 yHrqk9WuoL1oWadPtTyHYWlWAyKKqRA1LPqKpT5Td/M9ih7uahQPFC6ot8iThO5ODXlV
 hNaw==
X-Gm-Message-State: AOJu0YyBOOHoG14hOo62YzPI3qdhBrrKqD5qYgU8nQMILPReQhp2j0zc
 iHTVtR6srWSkgbHpkCuuQPVDbgNfz9Sw9CwsrRJ1Pg19WL5CQk1Sb6ffqcg7y7Nq1mrfrdwphkn
 2gucU
X-Gm-Gg: ASbGncuF/3BetFWyuCMSSCbF9seauENq63cob6QjfjaZFezTqftlEz3uYRmS5u8E10t
 rsjK0+QJVxWOX8ya+6zmop1YtKVNaW1XUm+yaYeMai3CMbbIYTCQBOhPB/HWV3jvJe1xtuCZo9+
 p6rjifJe9QQslh+W6KVt09tYa8VsGVbQAD9oBd4WGaQMZ8oJAaVFQrw9ymVUO0jMOajGR8NmZbz
 RHq2Cfyi3EaG2LYJfJgZEx4IGYfJAM9Q1CX/2x0pJW73S6fGR2mneYExo1cigl9sQsY4G1q+hFF
 8nLP9+15KaeNoLxbOMoKYfvZh9Ee86YxkggyCL+faVI8W6RWuljd9nZ59e2/3mBAdAX3B8Zq9Hm
 kyee24XzeFO3RLFNnNmbRNn1ICre5Ktz3n3xByQmNJkxLiNtIdiUYaHFi8o4CrZMPPbxnp6Yczt
 xLwiP9UIeLfMQwg1rBKqDmm2x4EWIxxqsPqcoT5fYK+5Xp7d0YCA==
X-Google-Smtp-Source: AGHT+IERNLQXYn5nJqijP59iuK4x11DuQ8YSNFcWMKHkqO9gdzv571dJSGBnilu+ppZZYiI25UyBxQ==
X-Received: by 2002:a17:90b:1f89:b0:32e:3c57:8a9e with SMTP id
 98e67ed59e1d1-33fafc8a0c9mr8966985a91.35.1761342900241; 
 Fri, 24 Oct 2025 14:55:00 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7a414012de3sm252530b3a.2.2025.10.24.14.54.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Oct 2025 14:54:59 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Bruce Richardson <bruce.richardson@intel.com>,
 Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>,
 Reshma Pattan <reshma.pattan@intel.com>
Subject: [PATCH v5 1/8] dumpcap: handle primary process exit
Date: Fri, 24 Oct 2025 14:53:56 -0700
Message-ID: <20251024215456.282171-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251024215456.282171-1-stephen@networkplumber.org>
References: <250811213632.16023-1-stephen@networkplumber.org>
 <20251024215456.282171-1-stephen@networkplumber.org>
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
Fixes: cbb44143be74 ("app/dumpcap: add new packet capture application")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
Acked-by: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
---
 app/dumpcap/main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/app/dumpcap/main.c b/app/dumpcap/main.c
index e5ba36350b..3621c0ebe3 100644
--- a/app/dumpcap/main.c
+++ b/app/dumpcap/main.c
@@ -1059,6 +1059,10 @@ int main(int argc, char **argv)
 	else
 		pcap_dump_close(out.dumper);
 
+	/* If primary has exited, do not try and communicate with it */
+	if (!rte_eal_primary_proc_alive(NULL))
+		return 0;
+
 	cleanup_pdump_resources();
 
 	rte_ring_free(r);
-- 
2.51.0

