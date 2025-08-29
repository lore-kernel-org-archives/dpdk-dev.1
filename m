Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93B1CCA0FF9
	for <dpdk-dev@archiver.kernel.org>; Fri, 29 Aug 2025 14:50:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E4CE04025A;
	Fri, 29 Aug 2025 16:50:10 +0200 (CEST)
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com
 [209.85.214.173])
 by mails.dpdk.org (Postfix) with ESMTP id AD6EB40150
 for <dev@dpdk.org>; Fri, 29 Aug 2025 16:50:09 +0200 (CEST)
Received: by mail-pl1-f173.google.com with SMTP id
 d9443c01a7336-24457fe9704so23196505ad.0
 for <dev@dpdk.org>; Fri, 29 Aug 2025 07:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756479008; x=1757083808; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZYrVeCO69t5fsp41im52Va7KZh62mQDFqDvKPjux/fw=;
 b=MkRBtWKlSNPiriTyityDC0RXk8s+Lk1fW1oFXGqboUm+0m44AxSdLa7KHNxHXsPBpn
 8812tnHenwRAgWmOPd06zLPjV7aDY51x4IxC/BK+mou2l1gnrccnhbK/u7MWhBxxIRgN
 CnC86HbsYwTWMFj7PLrKn3CYyEihakT85RCMgNeETOMp3d3e6NNMN/IPPWtBHEFG3GrP
 zW7Wp5AYryZE00NnwWTstdrpJhU0+QQNd7XQZtXcYwjYhDKFkKcmk6yH0A0rsLa5p+Xw
 GWwP2E/YyJPVuoxkur3EUDoQdOCzITOaV1r/uTNoIRCuNcq0I3UobRcc4oIw60EppsC2
 XM8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756479008; x=1757083808;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZYrVeCO69t5fsp41im52Va7KZh62mQDFqDvKPjux/fw=;
 b=LbqKuBDXFBDtOaNKnfwSR+Hl4KyOP7W3mUXYY+3y6zpvCrxDoiO8MJ1SA4MGeTL9s0
 SkEunuBMr8cRhVhuRjp7LP6QtjNPE+iaB+yLZDPt0PTISWQ3FfDX8KojiLBd+q6NK9km
 i7LgEjHGXzDMDVal98XtzyyhQdQbtLin+LBtAZOINb+9YQqNrjELCBWYzbwI7Ez6YDkG
 hGh1M5ZC0ZV7l3strmy5BYPrW7Zzv5SP4jstS/AhaXyMfMSkEZPIBWSQR7+MRrS9/09k
 RDHJ1mIBnkxZ216o3HsA5UL/71Jz5FMO5c1rTOij2KGokuZR0uJOPjusxQqM28vk/dJ+
 0Ntw==
X-Gm-Message-State: AOJu0YwMsypz67+mDLrjVnjcBA3xKKUPN7DhCZPdj5c0N/mDiSfc5RB7
 iK0Jcf/28b8yPSnTPqTZxVLz3ylnLcsoG0RzlfDWcPE1k4YoFcFfUccS7PZH4Iuc
X-Gm-Gg: ASbGncurZlK+SMuFYKPHalVEDt48hXZRme7AKYeKMf6lvDjV4PTrZyoGgPED7XHnDoo
 79RA7RFj3hClcIfPu6AZXr001qdHz9s3Tjl38VfD55gQ9oGso2I+x4IrjnJJTpiVIdrz61brkZM
 hH1gVZRHBN1FGZszIumf2YAUJ3hh+Ur71abVAd4DQ5GqboBmVsso4xavs+MqBwYIZgAo4CUyPMC
 g24H3RK40eqt/QG6fRfrJVhKlMrDslpvMQqbSUpOW1EPSNBm0MMjTrudZmyTf/+WXEKjWQ4Syt7
 EAuwCQEf1oDxYa4dyogseFKoGIYG7OPK+d/0AjMkcGJHkFNFDVGFHI/SOeS+QD0GOMh8fqKCAhN
 uqJ6eibu6IXmsiOQvCPq8QQCCFdGm2tIWJaviRQfmzH3dRykz4vm2scQFv43YSGZ2
X-Google-Smtp-Source: AGHT+IH0BC7EkinWO11PISDsuxNmZALrh1e3j6IsPMwdEFteq8gg7KdXbONulQv9l1nObxmJx/vftA==
X-Received: by 2002:a17:903:3bc6:b0:246:e1b6:f9b0 with SMTP id
 d9443c01a7336-246e1b6fad8mr245572145ad.18.1756479008412; 
 Fri, 29 Aug 2025 07:50:08 -0700 (PDT)
Received: from localhost.localdomain ([125.120.234.137])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-249065ad5b7sm27510985ad.128.2025.08.29.07.50.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 07:50:08 -0700 (PDT)
From: Yang Ming <mosesyyoung@gmail.com>
To: dev@dpdk.org
Cc: Dariusz Sosnowski <dsosnowski@nvidia.com>
Subject: [PATCH v3 1/2] net/mlx5: improve socket file path handling
Date: Fri, 29 Aug 2025 22:49:52 +0800
Message-ID: <20250829144954.2576-1-mosesyyoung@gmail.com>
X-Mailer: git-send-email 2.49.0.windows.1
In-Reply-To: <20250321132750.4237-1-ming.1.yang@nokia-sbell.com>
References: <20250321132750.4237-1-ming.1.yang@nokia-sbell.com>
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

The current implementation hardcodes the socket file path to
/var/tmp, which has two issues:

1. Hardcoding absolute paths is not good practice.
2. /var/tmp may not be writable in containerized or restricted
   environments (e.g. when the filesystem is mounted read-only).

This patch replaces the hardcoded path with a socket file name
(MLX5_SOCKET_FNAME) located in the DPDK runtime directory
returned by rte_eal_get_runtime_dir(). This ensures the socket
file can be created in both normal and containerized
environments, while maintaining uniqueness by appending the
process ID.

Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>

Signed-off-by: Yang Ming <mosesyyoung@gmail.com>
---
 drivers/net/mlx5/linux/mlx5_socket.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/net/mlx5/linux/mlx5_socket.c b/drivers/net/mlx5/linux/mlx5_socket.c
index 6ce0e59643..270a105f1d 100644
--- a/drivers/net/mlx5/linux/mlx5_socket.c
+++ b/drivers/net/mlx5/linux/mlx5_socket.c
@@ -20,7 +20,8 @@
 
 /* PMD socket service for tools. */
 
-#define MLX5_SOCKET_PATH "/var/tmp/dpdk_net_mlx5_%d"
+#define MLX5_SOCKET_DPATH "/var/tmp"
+#define MLX5_SOCKET_FNAME "dpdk_net_mlx5"
 #define MLX5_ALL_PORT_IDS 0xffff
 
 int server_socket = -1; /* Unix socket for primary process. */
@@ -177,8 +178,13 @@ mlx5_pmd_socket_init(void)
 	ret = fcntl(server_socket, F_SETFL, flags | O_NONBLOCK);
 	if (ret < 0)
 		goto close;
-	snprintf(sun.sun_path, sizeof(sun.sun_path), MLX5_SOCKET_PATH,
-		 getpid());
+
+	if (access(MLX5_SOCKET_DPATH, W_OK) == 0)
+		snprintf(sun.sun_path, sizeof(sun.sun_path), "%s/%s_%d",
+			 MLX5_SOCKET_DPATH, MLX5_SOCKET_FNAME, getpid());
+	else
+		snprintf(sun.sun_path, sizeof(sun.sun_path), "%s/%s_%d",
+			 rte_eal_get_runtime_dir(), MLX5_SOCKET_FNAME, getpid());
 	remove(sun.sun_path);
 	ret = bind(server_socket, (const struct sockaddr *)&sun, sizeof(sun));
 	if (ret < 0) {
@@ -223,6 +229,13 @@ mlx5_pmd_socket_uninit(void)
 					  mlx5_pmd_socket_handle, NULL);
 	claim_zero(close(server_socket));
 	server_socket = -1;
-	MKSTR(path, MLX5_SOCKET_PATH, getpid());
-	claim_zero(remove(path));
+	if (access(MLX5_SOCKET_DPATH, W_OK) == 0) {
+		MKSTR(path, "%s/%s_%d", MLX5_SOCKET_DPATH, MLX5_SOCKET_FNAME,
+		      getpid());
+		claim_zero(remove(path));
+	} else {
+		MKSTR(path2, "%s/%s_%d", rte_eal_get_runtime_dir(), MLX5_SOCKET_FNAME,
+		      getpid());
+		claim_zero(remove(path2));
+	}
 }
-- 
2.49.0.windows.1

