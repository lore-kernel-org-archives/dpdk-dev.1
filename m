Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0845BC2D0CD
	for <dpdk-dev@archiver.kernel.org>; Sat, 17 May 2025 08:15:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D3383402AF;
	Sat, 17 May 2025 10:15:21 +0200 (CEST)
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com
 [209.85.215.175])
 by mails.dpdk.org (Postfix) with ESMTP id B30E64025D
 for <dev@dpdk.org>; Sat, 17 May 2025 10:15:19 +0200 (CEST)
Received: by mail-pg1-f175.google.com with SMTP id
 41be03b00d2f7-b0db0b6a677so2325858a12.2
 for <dev@dpdk.org>; Sat, 17 May 2025 01:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747469718; x=1748074518; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mGKlQ2qeLXhaPjyjH4RpbokKu+gDtb2C5QM6XrVdsvY=;
 b=HPmbzqOBkboc5xikN5o/m0pfteMZ3cq1ghTkWT1/enK5Hg+vf2xAZ0l2UHikZD3PLw
 MZoIk7AAo81KuTdTES6fRiszl+DY4agGgGbRR/CxHiY/gc1oCOq9I9uKqBcbFR+sgSBC
 OT2+GXio6TlFb6vKwppjK7rsNkb2XtckIb4R6OLDcqJmUPsPhQn0+L2ZUvKuno5DTMOK
 KauXhGsi2R/zl/dR7m1AVgNR7lkPhziaJIMjfgOpmYB2wNjQioBGxfZGvaMDVJH7ndgM
 N5WA+GbzIBKU7Yze7fzeiqCyIF6s/SFVM0YGrCRKDms6YL/xo4bEok3KMUselHKsMFHt
 rQTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747469718; x=1748074518;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mGKlQ2qeLXhaPjyjH4RpbokKu+gDtb2C5QM6XrVdsvY=;
 b=jahr4kekYcxTxK2GAC1y3HgLl2ww4eTLftlmdhnqmyWQc5D0TGWb08R3pecKsbeawT
 qpOqQRO0tSOO3ztko6BMvm1+rIW6U+W8GnT9hr9fXqdEM26SmwnNqZU6t3DCU9ghY5Qf
 rUquW9WcqkrkEjKwrm9YTUeZQRxTxq3JX6PBvw6DaNptbn3lQp75pH4Pt4yKzQ9fGDuf
 C3nqH6ZqYP0tPDjkeA0+a7ee9G68gW5b7xcVI1PSXfsDuiSulk/rvrPByWzw6NN1wlLm
 V6MPySU2WOKQbkcALQyA4u8z9bbGaDnJ6bxKrwqVXe8cBOuMM+on2p4rTWrLq1r7275f
 pzow==
X-Gm-Message-State: AOJu0Yzrj03XtV2K91uKqubHH14AGj8EWxpFMckpcPDR87N99XEZLCFp
 BCyIOQWB2381PwEVgBn41sXjv3KW8DZTIhijMeo0E6KlRCnm6t+XdoW9l2fFsssDJNo=
X-Gm-Gg: ASbGncu8ZhYjS249tPEWeRfKEdKuE1PdaPL0zg0kKuFFebY1JixI3VVLsgbeR9N/b96
 TFvvOChLLSBz3bnXe0vz8xMv4x4Q1WKIT7k1wKkgE+GAJFOnJ4IUUBvrEhqFf1bjvol7ETLU7YE
 Lh/HU1l/TZWU2NP8V+nXG1k/8aP06n2hv3MHLCVZ1X+ue/hx7RpeLqXN02LW9adGTK5kykDrXy9
 6fnxCjkfoZ7Q3OSgvdf3aveBx+1XEJmC6Z47h4TZWZ3SqlnPh3cOCREbGB3yBByTIXzwpfR04ZU
 Uxpu0I2+8x4Qxxk/YPalvCwlDLJLNSylMrnuOMoN+RNuIUN7vG7brZ7fBuO+TtOt90pntON3BvB
 BUJ04
X-Google-Smtp-Source: AGHT+IFwQuWNPWONUUgIzecoosZ3fUqZmWmY98XKkZvSYJGXS1ScriRAf8ZA7IKaUREECadRYJseTA==
X-Received: by 2002:a17:902:dacf:b0:220:c164:6ee1 with SMTP id
 d9443c01a7336-231d4595b02mr91199345ad.32.1747469718350; 
 Sat, 17 May 2025 01:15:18 -0700 (PDT)
Received: from localhost.localdomain ([60.186.106.48])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-231d47f04d7sm26182015ad.0.2025.05.17.01.15.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 May 2025 01:15:17 -0700 (PDT)
From: Yang Ming <mosesyyoung@gmail.com>
To: dev@dpdk.org
Cc: Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH] Skip vfio in the scenario of non-privileged mode
Date: Sat, 17 May 2025 16:15:04 +0800
Message-ID: <20250517081504.309-1-mosesyyoung@gmail.com>
X-Mailer: git-send-email 2.49.0.windows.1
In-Reply-To: <20250327075711.648-1-ming.1.yang@nokia-sbell.com>
References: <20250327075711.648-1-ming.1.yang@nokia-sbell.com>
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

DPDK detect vfio container according the existence of vfio
module. But for container with non-privileged mode, there is
possibility that no VFIO_DIR(/dev/vfio) mapping from host to
container when host have both Intel NIC and Mellanox NIC but
this conntainer only allocate VFs from Mellanox NIC.
In this case, vfio kernel module has already been loaded from
the host.
This scenario will cause the error log occurs in DPDK primary
process as below:
'EAL:   cannot open VFIO container, error 2 (No such file or
directory)'
'EAL: VFIO support could not be initialized'
Because `rte_vfio_enable()` call `rte_vfio_get_container_fd()`
to execute `vfio_container_fd = open(VFIO_CONTAINER_PATH,
O_RDWR);` but VFIO_CONTAINER_PATH(/dev/vfio/vfio) doesn't exist
in this container.
This scenario will also lead to the delay of DPDK secondary
process because `default_vfio_cfg->vfio_enabled = 0` and
`default_vfio_cfg->vfio_container_fd = -1`, socket error will
be set in DPDK primary process when it sync this info to
the secondary process.
This patch use to skip this kind of useless detection for this
scenario.

Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>

Signed-off-by: Yang Ming <mosesyyoung@gmail.com>
---
 lib/eal/linux/eal_vfio.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/lib/eal/linux/eal_vfio.c b/lib/eal/linux/eal_vfio.c
index 2f5f221a0d..805f0ff92c 100644
--- a/lib/eal/linux/eal_vfio.c
+++ b/lib/eal/linux/eal_vfio.c
@@ -7,6 +7,7 @@
 #include <fcntl.h>
 #include <unistd.h>
 #include <sys/ioctl.h>
+#include <dirent.h>
 
 #include <rte_errno.h>
 #include <rte_log.h>
@@ -1089,6 +1090,7 @@ rte_vfio_enable(const char *modname)
 	/* initialize group list */
 	int i, j;
 	int vfio_available;
+	DIR *dir;
 	const struct internal_config *internal_conf =
 		eal_get_internal_configuration();
 
@@ -1125,6 +1127,15 @@ rte_vfio_enable(const char *modname)
 		return 0;
 	}
 
+	/* VFIO directory might not exist (e.g., unprivileged containers) */
+	dir = opendir(VFIO_DIR);
+	if (dir == NULL) {
+		EAL_LOG(DEBUG,
+			"VFIO directory does not exist, skipping VFIO support...");
+		return 0;
+	}
+	closedir(dir);
+
 	if (internal_conf->process_type == RTE_PROC_PRIMARY) {
 		if (vfio_mp_sync_setup() == -1) {
 			default_vfio_cfg->vfio_container_fd = -1;
-- 
2.49.0.windows.1

