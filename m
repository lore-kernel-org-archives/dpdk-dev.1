Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 986E3C9830C
	for <dpdk-dev@archiver.kernel.org>; Sun, 18 Jan 2026 19:18:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ED21142E97;
	Sun, 18 Jan 2026 20:14:53 +0100 (CET)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com
 [209.85.218.54]) by mails.dpdk.org (Postfix) with ESMTP id A8471427B8
 for <dev@dpdk.org>; Sun, 18 Jan 2026 20:14:51 +0100 (CET)
Received: by mail-ej1-f54.google.com with SMTP id
 a640c23a62f3a-b86f69bbe60so539454766b.1
 for <dev@dpdk.org>; Sun, 18 Jan 2026 11:14:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768763691;
 x=1769368491; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Te4ozvjodl8bM6ICsXwrSL6XOmmN9IWdGKhjX0AI0W4=;
 b=0ZSBnQTvX72xy0ebUQd0OLO2ZhWCfVI5DgHBRs/hLFbstKo7BQkU8Z8JBAv/HAUyOm
 IOORjoezyQ23hmwrr+qI+Y0lmcFaY/f09vUBDyjDU7VEcmz9zpRM4rVtMLTPvKgeR0ck
 5WhYPEKgspkDus89RP/2cKkvc9RlsDfJ+vSs/Q0oHTOYUVPCeATQZe0KmwBOLK4WgzKD
 2t1fjXhF6z4JBPIheNC8kTFnqUc4hxpg9y592fO/sqwADsEwFf4R/EoRQY8yj5LAHDJj
 bQDpWt9PUceUondxYgAPPCNpFanQTvDijhv3Iw6Y2xktyVYsONy0dit7dtlRYVDQkQXP
 ZTWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768763691; x=1769368491;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Te4ozvjodl8bM6ICsXwrSL6XOmmN9IWdGKhjX0AI0W4=;
 b=fVxUy9rhNagDaVKx/UvkeIB028lqKTCdM5Nx+crBQhKs9sZvGZ/mU4EHdnoRde/gvA
 qI8CSaFd+V+91BWP06Tvnqt77wynSGFIH3I/6BVoLLsio3PbdDkzX94OwVnp4bmnz3d+
 N+aa+P+Y/jXSQtZhJuAEy3xmp/Z2Go2p834sQwz8IFd1wFzYvyTSLm0HB1ZKov/BJbtG
 GwxrVgU+nlFlKUIcsFq9dJmAbUUKClO6CWCIC+QfECnnVTK47Ll4UZZg0gSGUKE6a1Pm
 SUqe2rMxIcxA4RLjOAz9zGVrWJ5IJLyqn1O2756sPGddfhjoMffNG0ydAk8oSt+VxGma
 NXaA==
X-Gm-Message-State: AOJu0YzEulTR/FVvVQ46IvR3D9K2Dm8+urXB1uuF8N1lOTEPsahraEwW
 c8EGbFySJtCnZns/VjfmurS0LsV6DmJ16/+4YWJOJk9HV/gS5XUaUixnR4l5TxhSmaMiANRxpW0
 ctl3o
X-Gm-Gg: AY/fxX6jYrmgDmfoHz9Ca4Ane8GTy36ctnIe9iIBv5eszRTWXr/2cRFWOcSvsM0TCmL
 OVh0R8e6O2WAqkzY896y+bkOGikcOX4hidQcGVq26638a8ew+jE55S3yQrJ6uJyf9YXATqpb469
 CIVspljhGIiibk3G5AZklo1Kbtt12QhTuwxtjsrQhEpCsB+GpWCIf5/RSXn6dGY2Sel8K7n9vkG
 lfUwlebRdHHWexmQDed+nAsFyYdcVXaXREBYH5rSBQK4/GenkLf0cBw8mPD9DBbqY1NtXTFRRSt
 ILUqZy9Z+s3FrrGX4jcOVPmtZgsqY6hIaTxjoIs9G9nfOrPJCZSewi6nCaKa4a2mfUUvVjS56Eo
 tbms09r6FBRpArKQnMvi/bnj+3xfLZONNOMO1QWhmrIHdl9h6dzjy/HJ5YiTBVrdQ45xd1uCEMy
 lxLaKAkk6IATe9INvLg5Pms8qn6ocFNwtWQxCitJgPW7Wqxho9+Q==
X-Received: by 2002:a17:907:9689:b0:b87:965:9078 with SMTP id
 a640c23a62f3a-b87968b7de1mr679990266b.7.1768763691272; 
 Sun, 18 Jan 2026 11:14:51 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b87959c9f8dsm886287166b.36.2026.01.18.11.14.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jan 2026 11:14:50 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v5 54/54] doc: correct whitespace in efficient code guide
Date: Sun, 18 Jan 2026 11:10:57 -0800
Message-ID: <20260118191323.241013-55-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260118191323.241013-1-stephen@networkplumber.org>
References: <20240513155911.31872-1-nandinipersad361@gmail.com>
 <20260118191323.241013-1-stephen@networkplumber.org>
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

Remove extra space in "rte_malloc ()" function name reference.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/prog_guide/writing_efficient_code.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/guides/prog_guide/writing_efficient_code.rst b/doc/guides/prog_guide/writing_efficient_code.rst
index b63fa8e459..6fbdb57fa8 100644
--- a/doc/guides/prog_guide/writing_efficient_code.rst
+++ b/doc/guides/prog_guide/writing_efficient_code.rst
@@ -41,7 +41,7 @@ If you really need dynamic allocation in the data plane, it is better to use a m
 This API is provided by librte_mempool.
 This data structure provides several services that increase performance, such as memory alignment of objects,
 lockless access to objects, NUMA awareness, bulk get/put and per-lcore cache.
-The rte_malloc () function uses a similar concept to mempools.
+The rte_malloc() function uses a similar concept to mempools.
 
 Concurrent Access to the Same Memory Area
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- 
2.51.0

