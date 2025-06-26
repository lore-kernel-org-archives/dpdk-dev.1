Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F368FC7EE32
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Jun 2025 13:22:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 97658402E6;
	Thu, 26 Jun 2025 15:22:21 +0200 (CEST)
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com
 [209.85.210.178])
 by mails.dpdk.org (Postfix) with ESMTP id AAB5A4028D
 for <dev@dpdk.org>; Thu, 26 Jun 2025 15:22:19 +0200 (CEST)
Received: by mail-pf1-f178.google.com with SMTP id
 d2e1a72fcca58-748d982e92cso781342b3a.1
 for <dev@dpdk.org>; Thu, 26 Jun 2025 06:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=uetpeshawar-edu-pk.20230601.gappssmtp.com; s=20230601; t=1750944138;
 x=1751548938; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oEmYbJVk8mEPyCG4GxGlfjC2h+EhEBw2Rx6RviTkstA=;
 b=UextZ0eSPSLorFCEOOTHY7XjT1R/QdVRBd5JMD3kIpdXNFqZfr3UdpEJTbHgwhkyY+
 atfPMRT4Tc8v5GyU1KJDrvdf8Tf/QZPqy7iyaxX4PKDgn2kq6/SLpZRaIE64J4yLNMDB
 yRIj7JTqkqGEdMfdiWaXf22Ax36kFJOlR6Ae7wX1VYvNiB0oWHQLMYOiUjYOijjhiXxB
 bciGk/lVwef4JnxQb7vSZ9vVmC7BTFuTUdZpdhjVhrC4bcDcpkLAL6LjcXtYKak/Da0g
 +1r3kTYXhJGn4g91XtUyqlV1Bbmb7fdW6wgwfVZ2XphpL31zXkcjHZYGfcFndEadFskx
 3jbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750944138; x=1751548938;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oEmYbJVk8mEPyCG4GxGlfjC2h+EhEBw2Rx6RviTkstA=;
 b=xIYTgzJYlzj/4cCdwXcixI+W/q9qACHY4/qfZniSGXIJJuHg2ddZjumk9SFYjox5Zx
 /WXNWovChEGXnROa9Orgg6EiigS/8hUF9JD7o6HZO0oZjLgQv9GVrljKZF1j1p/wb2VJ
 p3qF2FknCfI81wFsAq4R1mvXXek3DyUlJTLWBRQM/DfzD7Rw6okT1pxkDQPoA+PXfkxX
 4/ImM7Dp+2xhVuY4OXF7DZdBxeX48ujKzIyqmTYSmuz4FvAjVbNca690CUw0ycX6/ter
 i0ibLjMgMz6yCHqrKsScUkZHLWCSRpblJgkoL6cIXwxBt8O5IylyJGrN9IW7zrWaiRGB
 iDAA==
X-Gm-Message-State: AOJu0YySKh+ithJtn54HcwoDakkBF1zxkKZht4Y0/mJNVc3WNR+38ohZ
 Tyz4V/Ad6Nn+itq97BY6ODrOHOIhCZ65t0KLJ3ku9Gkllav//3b2KGjLLQjnHEmY6ZoX5bG3o6M
 aefla3jI=
X-Gm-Gg: ASbGncsp2ueLrgDZUzwMaeIS8YMiOayJJqFwNQRw6j+/B7w8RChJEUsY3CMu46s1HeR
 yKqCirV3BDrx3khSGVZekQU454/OhVxPUJjmc5DwW4E7ONfR2H1lUBCKifp0pMeXVz6iLBtjqz1
 RGrn+ctNn3/I46lJXa6bY4Kw8SMGV+9Qlf8IUdQGkLNC+zUS1DYf4QdYA0u3bw8xeklqNgyNnwI
 99ZDzhbWa0MvBAsAm9Wo2BbaJP7UThFzBC+ptLbSuyAAa1IdI5jSibhZoOpuFxmvbd9ofkIIiUs
 MKBJaLQQsp97ElkOlJwIeFIwi2ogSLqA/NPz4QgjzlH42mRLWbW9iyrv8Y9lMnBbdm81sa5HJ/t
 VzaNpKfE1mPWF
X-Google-Smtp-Source: AGHT+IGsxhY4mhUjYAt9TKiGffS83G7DIDnDZ+6OI393lYYsdf2qKD1EHCVh69EYx4CBq17FLh7shg==
X-Received: by 2002:a05:6a20:72a4:b0:21e:f56d:e4b6 with SMTP id
 adf61e73a8af0-2207f1bf804mr10901703637.18.1750944138532; 
 Thu, 26 Jun 2025 06:22:18 -0700 (PDT)
Received: from localhost.localdomain ([64.62.143.197])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-749c8850d53sm7218938b3a.118.2025.06.26.06.22.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Jun 2025 06:22:18 -0700 (PDT)
From: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
To: dev@dpdk.org
Cc: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>,
	stable@dpdk.org
Subject: [PATCH v2] net/mlx5: fix segfault on indirect action age query with
 conntrack
Date: Thu, 26 Jun 2025 09:22:08 -0400
Message-ID: <20250626132209.3925236-1-14pwcse1224@uetpeshawar.edu.pk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250624051015.3145137-1-14pwcse1224@uetpeshawar.edu.pk>
References: <20250624051015.3145137-1-14pwcse1224@uetpeshawar.edu.pk>
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

v2:
 - Added missing check for AGE + CT conflict in flow_dv_query().
 - Removed unnecessary null check from flow_aso_age_get_by_idx().
 - Added Fixes tag for LTS tracking.
 - Ensured .mailmap and Signed-off-by addresses match.

This patch fixes a segmentation fault that occurs when querying the
AGE action of a flow rule that uses indirect connection tracking (CT).

Background:
AGE and CT indices share a union in the mlx5 flow struct. When using CT
without age, the age index is invalid. Querying AGE in this case leads
to a crash due to reading an invalid pointer.

Fix:
Add a check in `flow_dv_query()` to prevent AGE queries on indirect CT
actions. This is the correct fix rather than null-checking the pool.

Steps to reproduce:
 1. Create an indirect CT action:
    flow indirect_action 0 create ingress action conntrack / end

 2. Create a root rule with jump:
    flow create 0 ingress pattern eth / ipv4 / tcp / end actions jump group 3 / end

 3. Create a group 3 rule using the indirect action:
    flow create 0 group 3 ingress pattern eth / ipv4 / tcp / end actions indirect 0 / jump group 5 / end

 4. Create a group 5 rule matching CT state:
    flow create 0 group 5 ingress pattern eth / ipv4 / tcp / conntrack is 1 / end actions queue index 5 / end

 5. Querying the first rule causes segfault:
    flow query 0 1 age

Fixes: 2d084f69aa26 ("net/mlx5: add translation of connection tracking action")
Cc: stable@dpdk.org

Signed-off-by: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
---
 .mailmap                        | 1 +
 drivers/net/mlx5/mlx5_flow_dv.c | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/.mailmap b/.mailmap
index 8483d96ec5..6126f7e472 100644
--- a/.mailmap
+++ b/.mailmap
@@ -812,6 +812,7 @@ Kevin Scott <kevin.c.scott@intel.com>
 Kevin Traynor <ktraynor@redhat.com>
 Ke Xu <ke1.xu@intel.com>
 Ke Zhang <ke1x.zhang@intel.com>
+Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
 Khoa To <khot@microsoft.com>
 Kiran KN <kirankn@juniper.net>
 Kiran Kumar K <kirankumark@marvell.com> <kkokkilagadda@caviumnetworks.com> <kiran.kokkilagadda@caviumnetworks.com>
diff --git a/drivers/net/mlx5/mlx5_flow_dv.c b/drivers/net/mlx5/mlx5_flow_dv.c
index c217634d9b..7ce093e075 100644
--- a/drivers/net/mlx5/mlx5_flow_dv.c
+++ b/drivers/net/mlx5/mlx5_flow_dv.c
@@ -18134,6 +18134,11 @@ flow_dv_query(struct rte_eth_dev *dev,
 						  error);
 			break;
 		case RTE_FLOW_ACTION_TYPE_AGE:
+			if (flow->indirect_type == MLX5_INDIRECT_ACTION_TYPE_CT)
+				return rte_flow_error_set(error, ENOTSUP,
+						  RTE_FLOW_ERROR_TYPE_ACTION,
+						  actions,
+						  "age not available");
 			ret = flow_dv_query_age(dev, flow, data, error);
 			break;
 		default:
-- 
2.43.0

