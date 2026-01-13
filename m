Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8290FD2D0E6
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Jan 2026 12:36:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 21708402E8;
	Tue, 13 Jan 2026 13:36:51 +0100 (CET)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com
 [209.85.218.46]) by mails.dpdk.org (Postfix) with ESMTP id D2F614028C
 for <dev@dpdk.org>; Tue, 13 Jan 2026 13:36:48 +0100 (CET)
Received: by mail-ej1-f46.google.com with SMTP id
 a640c23a62f3a-b871b6e0c70so333863166b.2
 for <dev@dpdk.org>; Tue, 13 Jan 2026 04:36:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768307808; x=1768912608; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=85OPVFU5+WolpjezwKlZKplV9cv9DfETECSNPuZOl4w=;
 b=hnc7RcQrGyJS5I/W2BfEOJtpyJCkT1bzEgrKsouHPhgKNtssf31agJ9G1F5Xq3C8S1
 ER1PiqAL5CG9tMtQ4HKvQdCYVBzoCsD2Q7AlM73WP1wo7APIMK+C5ZEXh2vuQH23EP8S
 +ECJ1Oo56furknhdu2cqMltGVVp0XrRVn4ZHdisIiGOO/eMMRdSZIBqxqNNSzK6yC2MT
 StTQL49j8XCMfr2NzBzSQJ2GfvUUj+vNsoIlgEQ98x5mRCdAhwX/PUq9HR6RdvAwi7xp
 qWO0OJ4T2qnJYAREBBPRq5Zkcc67SLa/w6gultQ33A23arazNf4kNsbzlmhpg63kk6lQ
 bcdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768307808; x=1768912608;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=85OPVFU5+WolpjezwKlZKplV9cv9DfETECSNPuZOl4w=;
 b=jgJy6Dfh3EnjsU3aU6KdWyTMrkUhFU3Q+mWdlGx2+GsniykIJquPq0KpwpUDTWVNTz
 qB5kGpsFF9b9g5JsJ8VXEnnbp+5/PIRKuHuL0q3Tljl5Tj0UIZw4USTLXIbVbO8so1Wz
 upYMBKilWAI3Cqauqz60bjQfwGQJL1hNzC9jh3BiyaKko1KGy9IJdWpw61xoT8ScNwOg
 hDBdTwBl6pcPhrwa4E42lDpZc3aKQGO+x9824OqGVLcUS1PkZhQThJoBDBV73HraxORM
 3jHhwN6RYCr8e8/aY+dGXDY81ZBF+10CWOQlAC7K2tnkpr6CT417Ws1n34mZUk2zJG9S
 LxMw==
X-Gm-Message-State: AOJu0YzxqIUlArdqRk293Wtpt504zZJ7cmqhdxMWq6rOx8QvOkYf268S
 0PQHjk1ofwjle748LOFFCF5IN6splNVPAvtms82gag8FMiVOyAlqdFOZxamjiagj
X-Gm-Gg: AY/fxX724hyWc3Uag8L+tQvDb4DsZWHHxCvhVi26Bp89Z/r7U05C1LxzEko/+giXm0/
 oszH125t2wSNZP4AS2qct69ruheV1whWCmqfhvRsFVrr9hUqxulTbqsFPD5NyZcotznP1bxkRM3
 eIJWZtJ5HkuNizRGswwWBNR9wZQp3rAqD2rYw16ESNlZH7A+j09Iqa/1rA5F51n94sIWwS0QWIg
 UhONu5sG/DuAfmafR9AJhihYktNKGzNYXElhPy1vA35uFPEWBCX2tzNIyw3eNhtiwrEKtWAcLcD
 iHB3S1xy/TGQ8m3fMrpdyqUScwYwNvIJoPc5+VnAskBdz1EyobBfqHxtY7FfJbl1pVwEn6UnFZM
 vyrgdtJZwKwHugHuZ9p039PjIXIrih64i+1PCe/p5jNz76dvPPc/h1gKWFLKwMei1BX1GaJK4Hn
 fnTI6vvGP7
X-Google-Smtp-Source: AGHT+IE14KH+6BktINak/PybssgSttBuEXzbgoWXN0xE8j+QokuqN7PdwRwsbZYbmlXXZ/imWsfEhw==
X-Received: by 2002:a17:907:3a03:b0:b86:fca7:3dc2 with SMTP id
 a640c23a62f3a-b86fca73f66mr673476666b.10.1768307807800; 
 Tue, 13 Jan 2026 04:36:47 -0800 (PST)
Received: from greenberg.. ([193.89.60.110]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b872b027020sm398520266b.10.2026.01.13.04.36.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 04:36:47 -0800 (PST)
From: Konrad Sztyber <konrad.sztyber@gmail.com>
X-Google-Original-From: Konrad Sztyber <ksztyber@nvidia.com>
To: dev@dpdk.org, David Marchand <david.marchand@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>
Cc: konrad.sztyber@gmail.com, Konrad Sztyber <konrad.sztyber@intel.com>,
 stable@dpdk.org, Nipun Gupta <nipun.gupta@amd.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Peng Zhang <peng.zhang@corigine.com>, Long Wu <long.wu@corigine.com>,
 Zerun Fu <zerun.fu@corigine.com>, Chaoyong He <chaoyong.he@corigine.com>
Subject: [PATCH v4] bus/pci: don't open uio device in secondary process
Date: Tue, 13 Jan 2026 13:35:43 +0100
Message-ID: <20260113123617.1736483-1-ksztyber@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241011111533.20746-1-konrad.sztyber@intel.com>
References: <20241011111533.20746-1-konrad.sztyber@intel.com>
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

From: Konrad Sztyber <konrad.sztyber@intel.com>

The uio_pci_generic driver clears the bus master bit when the device
file is closed. So, when the secondary process terminates after probing
a device, that device becomes unusable in the primary process.

To avoid that, the device file is now opened only in the primary process
and the secondary gets it over UNIX domain socket via SCM_RIGHTS.

Fixes: 847d78fb9530 ("bus/pci: fix FD in secondary process")
Cc: stable@dpdk.org

Signed-off-by: Konrad Sztyber <konrad.sztyber@intel.com>
---
v4:
  Rebased on top of current main branch.
v3:
  Use the rte_mp_* infrastructure to pass the uio fd from the primary
  process to the secondary.
v2:
  Fixed coding style issues.
---
 drivers/bus/pci/linux/pci_uio.c | 140 ++++++++++++++++++++++++++++----
 1 file changed, 126 insertions(+), 14 deletions(-)

diff --git a/drivers/bus/pci/linux/pci_uio.c b/drivers/bus/pci/linux/pci_uio.c
index 4c1d3327a9..220390d921 100644
--- a/drivers/bus/pci/linux/pci_uio.c
+++ b/drivers/bus/pci/linux/pci_uio.c
@@ -21,14 +21,22 @@
 #include <rte_bus_pci.h>
 #include <rte_common.h>
 #include <rte_malloc.h>
+#include <rte_eal.h>
+#include <rte_errno.h>
 
 #include "eal_filesystem.h"
 #include "pci_init.h"
 #include "private.h"
 
 void *pci_map_addr = NULL;
+static int pci_uio_dev_count;
 
 #define OFF_MAX              ((uint64_t)(off_t)-1)
+#define SEND_FD_MP_KEY       "pci_uio_send_fd"
+
+struct pci_uio_send_fd_param {
+	struct rte_pci_addr addr;
+};
 
 int
 pci_uio_read_config(const struct rte_intr_handle *intr_handle,
@@ -211,6 +219,93 @@ pci_uio_free_resource(struct rte_pci_device *dev,
 		rte_intr_fd_set(dev->intr_handle, -1);
 		rte_intr_type_set(dev->intr_handle, RTE_INTR_HANDLE_UNKNOWN);
 	}
+
+	if (rte_eal_process_type() == RTE_PROC_PRIMARY) {
+		assert(pci_uio_dev_count > 0);
+		pci_uio_dev_count--;
+		if (pci_uio_dev_count == 0)
+			rte_mp_action_unregister(SEND_FD_MP_KEY);
+	}
+}
+
+static int
+pci_uio_send_fd(const struct rte_mp_msg *request, const void *peer)
+{
+	struct rte_pci_device *dev;
+	const struct pci_uio_send_fd_param *param =
+		(const struct pci_uio_send_fd_param *)request->param;
+	struct rte_mp_msg reply = {};
+	int fd;
+
+	strlcpy(reply.name, request->name, sizeof(reply.name));
+	TAILQ_FOREACH(dev, &rte_pci_bus.device_list, next) {
+		if (!rte_pci_addr_cmp(&dev->addr, &param->addr))
+			break;
+	}
+
+	if (dev == NULL) {
+		PCI_LOG(ERR, "Could not find PCI device (" PCI_PRI_FMT ")",
+			param->addr.domain, param->addr.bus,
+			param->addr.devid, param->addr.function);
+		goto reply;
+	}
+
+	fd = rte_intr_fd_get(dev->intr_handle);
+	if (fd < 0) {
+		PCI_LOG(ERR, "Could not get fd (" PCI_PRI_FMT ")",
+			param->addr.domain, param->addr.bus,
+			param->addr.devid, param->addr.function);
+		goto reply;
+	}
+
+	reply.num_fds = 1;
+	reply.fds[0] = fd;
+reply:
+	if (rte_mp_reply(&reply, peer) != 0) {
+		PCI_LOG(ERR, "Failed to send reply: %d (" PCI_PRI_FMT ")",
+			rte_errno, param->addr.domain, param->addr.bus,
+			param->addr.devid, param->addr.function);
+		return -1;
+	}
+
+	return 0;
+}
+
+static int
+pci_uio_request_fd(struct rte_pci_device *dev)
+{
+	struct rte_mp_msg request = {}, *reply;
+	struct timespec timeout = {.tv_sec = 1, .tv_nsec = 0};
+	struct pci_uio_send_fd_param *param =
+		(struct pci_uio_send_fd_param *)request.param;
+	struct rte_mp_reply replies;
+	int rc;
+
+	strlcpy(request.name, SEND_FD_MP_KEY, sizeof(request.name));
+	memcpy(&param->addr, &dev->addr, sizeof(param->addr));
+	request.len_param = sizeof(*param);
+
+	rc = rte_mp_request_sync(&request, &replies, &timeout);
+	if (rc != 0 || replies.nb_received != 1) {
+		PCI_LOG(ERR, "Failed to request fd from primary: %d (" PCI_PRI_FMT ")",
+			rte_errno, dev->addr.domain, dev->addr.bus,
+			dev->addr.devid, dev->addr.function);
+		return -1;
+	}
+
+	reply = replies.msgs;
+	if (reply->num_fds != 1) {
+		PCI_LOG(ERR, "Received unexpected number of fds: %d (" PCI_PRI_FMT ")",
+			reply->num_fds, dev->addr.domain, dev->addr.bus,
+			dev->addr.devid, dev->addr.function);
+		free(reply);
+		return -1;
+	}
+
+	rte_intr_fd_set(dev->intr_handle, reply->fds[0]);
+	free(reply);
+
+	return 0;
 }
 
 int
@@ -220,7 +315,7 @@ pci_uio_alloc_resource(struct rte_pci_device *dev,
 	char dirname[PATH_MAX];
 	char cfgname[PATH_MAX];
 	char devname[PATH_MAX]; /* contains the /dev/uioX */
-	int uio_num, fd, uio_cfg_fd;
+	int rc, uio_num, fd, uio_cfg_fd;
 	struct rte_pci_addr *loc;
 
 	loc = &dev->addr;
@@ -232,18 +327,6 @@ pci_uio_alloc_resource(struct rte_pci_device *dev,
 			loc->domain, loc->bus, loc->devid, loc->function);
 		return 1;
 	}
-	snprintf(devname, sizeof(devname), "/dev/uio%u", uio_num);
-
-	/* save fd */
-	fd = open(devname, O_RDWR);
-	if (fd < 0) {
-		PCI_LOG(ERR, "Cannot open %s: %s", devname, strerror(errno));
-		goto error;
-	}
-
-	if (rte_intr_fd_set(dev->intr_handle, fd))
-		goto error;
-
 	snprintf(cfgname, sizeof(cfgname),
 			"/sys/class/uio/uio%u/device/config", uio_num);
 
@@ -270,8 +353,27 @@ pci_uio_alloc_resource(struct rte_pci_device *dev,
 		}
 	}
 
-	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
+	if (rte_eal_process_type() != RTE_PROC_PRIMARY) {
+		if (pci_uio_request_fd(dev) != 0)
+			goto error;
 		return 0;
+	}
+
+	/*
+	 * The uio_pci_generic driver clears the bus master enable bit when the
+	 * device file is closed, so open it only in the primary process. The
+	 * secondary will get it via SCM_RIGHTS.
+	 */
+	snprintf(devname, sizeof(devname), "/dev/uio%u", uio_num);
+	/* save fd */
+	fd = open(devname, O_RDWR);
+	if (fd < 0) {
+		PCI_LOG(ERR, "Cannot open %s: %s", devname, strerror(errno));
+		goto error;
+	}
+
+	if (rte_intr_fd_set(dev->intr_handle, fd))
+		goto error;
 
 	/* allocate the mapping details for secondary processes*/
 	*uio_res = rte_zmalloc("UIO_RES", sizeof(**uio_res), 0);
@@ -280,6 +382,16 @@ pci_uio_alloc_resource(struct rte_pci_device *dev,
 		goto error;
 	}
 
+	if (pci_uio_dev_count == 0) {
+		rc = rte_mp_action_register(SEND_FD_MP_KEY, pci_uio_send_fd);
+		if (rc != 0 && rte_errno != ENOTSUP) {
+			PCI_LOG(ERR, "Failed to register multi-process callback: %d",
+				rte_errno);
+			goto error;
+		}
+	}
+
+	pci_uio_dev_count++;
 	strlcpy((*uio_res)->path, devname, sizeof((*uio_res)->path));
 	memcpy(&(*uio_res)->pci_addr, &dev->addr, sizeof((*uio_res)->pci_addr));
 
-- 
2.43.0

