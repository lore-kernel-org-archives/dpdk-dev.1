Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09B6BC83F27
	for <dpdk-dev@archiver.kernel.org>; Sat, 19 Jul 2025 15:32:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 516604026F;
	Sat, 19 Jul 2025 17:32:45 +0200 (CEST)
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com
 [209.85.210.180])
 by mails.dpdk.org (Postfix) with ESMTP id 381A0400D7;
 Sat, 19 Jul 2025 17:32:44 +0200 (CEST)
Received: by mail-pf1-f180.google.com with SMTP id
 d2e1a72fcca58-748d982e97cso2713171b3a.1; 
 Sat, 19 Jul 2025 08:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1752939163; x=1753543963; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PuxZADO9iRVmai/wZUK395HxPqllRV8REm/Y57NAjBs=;
 b=kmnwId1FJE3ceMUUHF85JZxAlVXKB7FsCB3V7N0UwJkQUBns8QpcyYzNKjWpOj+4NY
 Tmfcagfb+2Z/UHiPpV1pDUS0bXQ80EQJHgW4zdWXSaK/JvSDg9/7dGGb3e2nxeUriVA7
 en0iKH8bWv5jMbKuxuatYkzRa9nsu0TcHSHIAugYrz1ZfHRA4FJBrwHdeB81nJsio8t4
 /HI+bpU4cE/8I6SvcPqrOATuTyUPUjO9gu5bm2+FbqzvRfMTnjNTKe0RbCyV4d0SinNW
 3OtjEjR0eRC8QJ6gHLSUEzBcgZdUbMR5NapRnng9ybcmZ9RoDzRmhzPVGM83FS+igWKu
 s17w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752939163; x=1753543963;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PuxZADO9iRVmai/wZUK395HxPqllRV8REm/Y57NAjBs=;
 b=w/gJNcncCj8I18+YEBIFijkdkdyo9DNeZamEqW7xoVpFnj6U7J6lDbhy6xkJPZKpcR
 x3HRpySCSurhSoax6NfoQutmJtZQJlCAjfHygOpbvEC4miqzKFYLUZLUFpDY9m6ObtPH
 Wg5/Mlia+yETKkFugWUzgG1848InvJWc0UUEls1bwCVy1gHMIttofuKNUW712K8xK5GJ
 WN9is7/NdBDTdiuo/3koMqvlSOdoVRluFcb9EsnJzjo4s9jI6LfVjWEEQeu6UDsmTmNT
 AWefhHipDbjK9wpviJ01hRi2+9D9N+dIjHhUxEKgvqhSYjejcWpyPkddQaGsXqHrj64N
 /uDQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXqGq9LNyXOYq87xDlgydiopY2jQnlwVdn5PtTWr0ygFL7TbE8VF7E2HsoH8/btgPyetOIV7/E=@dpdk.org
X-Gm-Message-State: AOJu0YzEGYInpvblygmvZHL9xjLzsAeh/XnMTGOAW0vs7KlondAiXK9V
 CR9Hj4Jh+NRk4lzStABPu9xbWXmbs11Dhqq9z0iFRTxhPJLj+0EqhWehzUpTCQ==
X-Gm-Gg: ASbGncsDRSMB/H0tCgyYxt3FYTx8kAzQFAPQApqmLzllA/5ixemQLACGxOaZwuWHoxV
 bj6g73vmOvhtVcfPG1KoYdH9tiUOWXrKzaNznKYpaYp5flT2+IOU1wj4g/17rMYe0gUbD61JSfi
 SPOiMHj9Y5AKCpHc2QYaWhAlnIdQoH1mvYZsW+zIZOTKNPyv16ua3HFpVXn48iPRCdHC3R7IA5z
 MxLbYGwU8osQqfW1P6pnsfx/4Rw5R7/+kBbuyPrJKrJ/nSldfwUM4h6yQfNI7gOIpn9iXEJroLQ
 6ZZSdhUIAX6/0MrZblKKIJr5ILYVHuF+lUhqboGZUmhuhwYZXBuEZQKQkWgEHtjZO27YwSRa9AN
 s2NmtPDnyJ5q/4ix8+y8RK6LTH4QSnJq6eGnwqjFowLRkro7Hv3t3
X-Google-Smtp-Source: AGHT+IEZAB1QUZeMTZbXGP3J/4faKlMVzV4XnFizktmZxH86Tvu5usNwz2ytwK3mm1HhHYBk7ssvqQ==
X-Received: by 2002:a05:6a00:2e92:b0:748:ef3d:3247 with SMTP id
 d2e1a72fcca58-75724876e61mr19862228b3a.20.1752939162789; 
 Sat, 19 Jul 2025 08:32:42 -0700 (PDT)
Received: from localhost.localdomain ([122.235.156.36])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-759c89d06a8sm3038727b3a.45.2025.07.19.08.32.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Jul 2025 08:32:42 -0700 (PDT)
From: Yang Ming <mosesyyoung@gmail.com>
To: dev@dpdk.org
Cc: kevin.laatz@intel.com,
	stable@dpdk.org
Subject: [PATCH v3 1/2] eal: prevent socket closure before MP sync
Date: Sat, 19 Jul 2025 23:32:25 +0800
Message-ID: <20250719153227.1980-1-mosesyyoung@gmail.com>
X-Mailer: git-send-email 2.49.0.windows.1
In-Reply-To: <20250407052532.1913-1-ming.1.yang@nokia-sbell.com>
References: <20250407052532.1913-1-ming.1.yang@nokia-sbell.com>
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

The secordary process should not close socket file for MP
channel before performing MP request synchronization.
This prevents error logs when the secondary process exits
without any operation on the crypto device while the primary
process starts the device.

Case situation:
eal_bus_cleanup has been added in rte_eal_cleanup. But for the
secondary process, rte_eal_cleanup firstly performs
rte_mp_channel_cleanup, which closes socket file for the MP
channel, making mp_fd invalid. Subsequently, eal_bus_cleanup
triggers vdev_cleanup, which calls mp_request_sync to send a
message via the MP channel. Since mp_fd is invalid, error logs
occur.

Error logs occur as below when the secordary process exit:
EAL: failed to send to (/tmp/dpdk/l2hicu/mp_socket) due to Bad
file descriptor
EAL: Fail to send request /tmp/dpdk/l2hicu/mp_socket:
ipsec_mb_mp_msg
USER1: Create MR request to primary process failed.

Function call trace:
1. rte_eal_cleanup->rte_mp_channel_cleanup->close_socket_fd
2. rte_eal_cleanup->eal_bus_cleanup->vdev_cleanup->
rte_vdev_driver->ipsec_mb_remove->ipsec_mb_qp_release->
ipsec_mb_secondary_qp_op->rte_mp_request_sync->mp_request_sync->
send_msg->sendmsg(mp_fd, &msgh, 0);

Fixes: 1cab1a40ea9b ("bus: cleanup devices on shutdown")
Cc: kevin.laatz@intel.com
Cc: stable@dpdk.org

Signed-off-by: Yang Ming <mosesyyoung@gmail.com>
---
 lib/eal/freebsd/eal.c | 2 +-
 lib/eal/linux/eal.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/eal/freebsd/eal.c b/lib/eal/freebsd/eal.c
index c1ab8d86d2..f161ba0bac 100644
--- a/lib/eal/freebsd/eal.c
+++ b/lib/eal/freebsd/eal.c
@@ -905,8 +905,8 @@ rte_eal_cleanup(void)
 	struct internal_config *internal_conf =
 		eal_get_internal_configuration();
 	rte_service_finalize();
-	rte_mp_channel_cleanup();
 	eal_bus_cleanup();
+	rte_mp_channel_cleanup();
 	rte_eal_alarm_cleanup();
 	rte_trace_save();
 	eal_trace_fini();
diff --git a/lib/eal/linux/eal.c b/lib/eal/linux/eal.c
index 52efb8626b..d44950d563 100644
--- a/lib/eal/linux/eal.c
+++ b/lib/eal/linux/eal.c
@@ -1330,11 +1330,11 @@ rte_eal_cleanup(void)
 		rte_memseg_walk(mark_freeable, NULL);
 
 	rte_service_finalize();
+	eal_bus_cleanup();
 #ifdef VFIO_PRESENT
 	vfio_mp_sync_cleanup();
 #endif
 	rte_mp_channel_cleanup();
-	eal_bus_cleanup();
 	rte_eal_alarm_cleanup();
 	rte_trace_save();
 	eal_trace_fini();
-- 
2.49.0.windows.1

