Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0553C5DF85
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Aug 2026 19:11:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2026D40671;
	Wed, 19 Aug 2026 21:10:55 +0200 (CEST)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by mails.dpdk.org (Postfix) with ESMTP id 1E4DD40658
 for <dev@dpdk.org>; Wed, 19 Aug 2026 21:10:54 +0200 (CEST)
Received: by mail-pl1-f171.google.com with SMTP id
 d9443c01a7336-2d58efc7356so15122605ad.1
 for <dev@dpdk.org>; Wed, 19 Aug 2026 12:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787166653;
 x=1787771453; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VsBk6POxYKz9TqxRsosWf5UujmfcbgZ31UzHcanKfhA=;
 b=pUnEPyt6dwU6x0QEXiCAfxv8bgIfQG7Qzpvw6BN9g3BSK8Iy6HpTzViLnMKs1uws9J
 7NdexGjc0XBLK43NqpglwfKMQsLB/VVhCk5/DpM+HMC3QIDYeQ+LtcPVQ/r7oLNcE3am
 byiMcranTMOcttmGAuBvbZctZ6KmzFwT9MHOiLw0ngLlxa92ucGG3VvBszpfqO/2WIO3
 dX59+GdED5N8ccYI405paQJBhMef7NpnSKBbzAISEqRhx+r89MSTETgfOMYtYMmHcfSy
 FJGOQ2wWbBFRoYKMem1Y1G72scxDhZJSavbuZaTPd3vIj3kAMNXB7sBfmdWXDsRyg25m
 QOlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787166653; x=1787771453;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=VsBk6POxYKz9TqxRsosWf5UujmfcbgZ31UzHcanKfhA=;
 b=Rjw49RXme/PNq7F4FrJYX07BRd07S5LTmInbaILdNlebhwraLs7u9QXUnX0oFdOLwV
 S+zx6j6hPJqYoJByS9ybU9INIcO5JEd06JP6+pnlqAi3xrJwb6DEr18pcOMPRUqCoFVI
 adb1LFyQCcjPhIu4tWCn+rTJ9j1BzCe2V53/lfieBTh115XLl8z++Dpx1RdAVg85/Cqe
 i2mDnjfCsdi+jSu6FfZRJxUMrwlqYA5ZMnBZSKW7nFsaNNSD6/5RSr1zgo+Erdy/ggIr
 mfZ2FeJhaAQiJ9W6Bq1Q4pdwqCdQKUMIwhkxgJ/ChCQGM4WI6bRzUWY3k8CIuI6BURo+
 6ZCw==
X-Gm-Message-State: AFuF++kej2jQ7Khhun/YruXC7s2lPwErItgDs6tJ0Gj2y4aL0Qzq+4hf
 XSEcMwIKPhdhZbBaQKiOCnrlkzNhoGf2km90LZ3/7YvLOkj6oKreV3iWaEZFK7Ys5iYRw3Pe6zb
 2i9n8
X-Gm-Gg: AR+sD11tjMPIQwVw/zlbqFE9C+9Ncec3SgrB8boQsH28t83MyRIVRedM0lUVAuG9M3k
 PYIES5DYVyeDb6JIvIfUf2QRDl13K8HKBkmBbp4RCbIh5fjzliBhrY8qn45O6l/Q9RKTvuTbzPl
 JnkTIG1+qsbj0TpTv4TReR69plT5S1nhHeI2m90FzXPDBNNlJn+cSeoSQeCtu8guh8PjPxymQS4
 RhQFHjr2QuZgB1F12CPEg3YsfPgOrD7IdV9ATjQBLB1OHUG0MyM/9v4xFtbG/lT7RLnMDDtPykE
 Iz5+GH+lx/QYOS2EqS8PH0yJWqNaJr/mHdF/D41M7/0pbIpGCaVBv+vmuHsjk3l127Pek48y1d8
 O+ifbQ/hCylbqZu1AZ+R2SqlwqbQX0i2Bsx9y3cKaIc0wrukmyooIogO/NVW2PvudRh3VXp6bJX
 TJZKzY8cLL2NA24r1eafg7C90govNJ0o1LcwTV8kTFAdI6VE7oJfNaLZMf5B95F29gw3HCI27OC
 8lhU1AVgj4Cd4354tlOXwDSIBQ=
X-Received: by 2002:a17:90b:4d83:b0:381:1c96:829b with SMTP id
 98e67ed59e1d1-39580eda10bmr12312783a91.3.1787166653219; 
 Wed, 19 Aug 2026 12:10:53 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327bef77fc0sm17305416eec.8.2026.08.19.12.10.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 12:10:52 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Long Li <longli@microsoft.com>,
 Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Randy Tice <rtice@cisco.com>, Jianfeng Tan <jianfeng.tan@intel.com>,
 Jeff Guo <jia.guo@intel.com>
Subject: [PATCH v5 2/4] eal/linux: increase uevent socket buffer
Date: Wed, 19 Aug 2026 12:08:51 -0700
Message-ID: <20260819191036.679330-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260819191036.679330-1-stephen@networkplumber.org>
References: <20260817201602.120526-1-rtice@cisco.com>
 <20260819191036.679330-1-stephen@networkplumber.org>
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

The kernel netlink socket into DPDK can get overrun if DPDK
interrupt thread is not keeping up. To reduce the possibility
increase the socket receive buffer to 4M.

Fixes: 0d0f478d0483 ("eal/linux: add uevent parse and process")
Cc: stable@dpdk.org

Reported-by: Randy Tice <rtice@cisco.com>
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/eal/linux/eal_dev.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/lib/eal/linux/eal_dev.c b/lib/eal/linux/eal_dev.c
index 666967667f..fb5c8bf070 100644
--- a/lib/eal/linux/eal_dev.c
+++ b/lib/eal/linux/eal_dev.c
@@ -32,6 +32,9 @@ static bool hotplug_handle;
 /* Listen only to messages from kernel (not libudev) */
 #define EAL_UEV_GROUP_KERNEL 1
 
+/* Large uevent buffer */
+#define EAL_UEV_MSG_RCVBUF (4 * 1024 * 1024)
+
 /*
  * spinlock for device hot-unplug failure handling. If it try to access bus or
  * device, such as handle sigbus on bus or handle memory failure for device
@@ -103,6 +106,29 @@ static int cmp_dev_name(const struct rte_device *dev,
 	return strcmp(dev->name, name);
 }
 
+/*
+ * To avoid losing uevents increase the netlink receive buffer size,
+ * and override the kernel clamp value if necessary.
+ */
+static int
+dev_uev_set_rcvbuf(int fd, int n)
+{
+	int ret, val;
+	socklen_t len = sizeof(val);
+
+	ret = setsockopt(fd, SOL_SOCKET, SO_RCVBUF, &n, sizeof(n));
+	if (ret < 0)
+		return ret;
+
+	/* kernel may have clamped our request */
+	ret = getsockopt(fd, SOL_SOCKET, SO_RCVBUF, &val, &len);
+	if (ret >= 0 && len == sizeof(val) && val == n * 2)
+		return 0; /* request worked */
+
+	/* try again to override kernel restriction */
+	return setsockopt(fd, SOL_SOCKET, SO_RCVBUFFORCE, &n, sizeof(n));
+}
+
 static int
 dev_uev_socket_fd_create(void)
 {
@@ -127,6 +153,9 @@ dev_uev_socket_fd_create(void)
 		goto err;
 	}
 
+	if (dev_uev_set_rcvbuf(fd, EAL_UEV_MSG_RCVBUF) < 0)
+		EAL_LOG(NOTICE, "Failed to set rcvbuf.");
+
 	if (rte_intr_fd_set(intr_handle, fd))
 		goto err;
 
-- 
2.53.0

