Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8025DC2D0CD
	for <dpdk-dev@archiver.kernel.org>; Sat, 17 May 2025 08:32:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 678A3402E0;
	Sat, 17 May 2025 10:32:19 +0200 (CEST)
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com
 [209.85.215.181])
 by mails.dpdk.org (Postfix) with ESMTP id 42A43402DF
 for <dev@dpdk.org>; Sat, 17 May 2025 10:32:18 +0200 (CEST)
Received: by mail-pg1-f181.google.com with SMTP id
 41be03b00d2f7-b26f7d2c1f1so1053464a12.0
 for <dev@dpdk.org>; Sat, 17 May 2025 01:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747470737; x=1748075537; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mGKlQ2qeLXhaPjyjH4RpbokKu+gDtb2C5QM6XrVdsvY=;
 b=kCsIvZcQLJ2rdmPxyZ9J6lnAS7O7v//p6KWLJ/iDbm5sRtvQ7Mp2FNo/DElhMYOoUB
 qRk8is0QE496aiUSiQ5gwTqd2epp9eJcmjQz2L4S/XaXLuatD9duXJeVcibKWdHkDYE1
 CdZb/gOnPCuXalTqXawJHBY4nd6BFeafnqcNt0dJC6jBX0gzYiLSYlXN9jpzfblQ5Pyp
 ptHeVjBTkQuuTNwMb0QXIlOwajhZLqFdgRRsznlB0oNQPh5Qs8HPC0vX3pzGKqbvQYXz
 N/i4UvBJiHvi0zKWyHPI2PN7FnrXevHoq+8gr8Uou0RZ57XJDJSeylw6+qUJ9U/ugeIW
 NdAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747470737; x=1748075537;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mGKlQ2qeLXhaPjyjH4RpbokKu+gDtb2C5QM6XrVdsvY=;
 b=XBHbiFxBtkNV9oFzXoRmIPyrcLtgVpASjMsHHXqrus9qha53CfIp5OoEVuijOeAVR5
 OzZUbGMppvLSuu0MlM5Ryn3R2CWrxZjxamh70htJm/7GwGiTb42bdJ4TUr4DOvWca1g6
 N8uLo5RD/Gs4rPs7OZ1szfbXnYVKEK/0cA6CyMYtiyZNqxmUEJ5FlDly5l38CrFRsYi9
 8OJeZ7AbSkZFuKqQ1gag970gSkL5ekyqyyX8NMet7g444MmrlZEQvb2YJghT4jiCbl0+
 ix7FyyUENNGVTOPJfcRgvhq/Oar551F/lo//L8HtYtZBdgUPfbiQSyB5HUx2jZCgHgun
 45oA==
X-Gm-Message-State: AOJu0Yx1vKgyMrICu8Tg0p444tDo3iKBwhpkoAaID2kOTPq6p4rBd5mU
 nmBBmkA0Dn0iRxHTwtD1zI8kzr7AKT54BRI5CAb9IgDmniS33Nv09y6L1VbQGOqP9B8=
X-Gm-Gg: ASbGncupqu94w6BtGIo3F7/MIOqX/hewieNUkioMu0FHYAh1WVFMr5ArJeHmHpt+ojW
 xAcwzPtBxPl0B2ZiibQ5awAc8yRrLm6Xn9PbL43tGPqtQ8uAuqClz9V11m7fwsCbOWv/anvm2XM
 3g5lZmW8MG+q2RZTM6qwZbSjXEpcY8ANrlg4qWFSICuoGJolaYL9ItokooVEeivFWWVjPY6hE3d
 4djxCCv4nhRehoym1mDFj3Ro+TnXn36Fc4YZvv5MlSmahQotSSkXpi20Lx9SkOXT5Bk09PDbK6E
 IBRTVjdQquT0fekSBfQva7vCoF8gOoAb1P12sXJRj6jvhWdANRoFZLx0gEm5OCeXgU4aTjSFjYD
 8m1yl
X-Google-Smtp-Source: AGHT+IGHqJe/ygzOHoJ6zQCry/Hg/q+IWgsO2TDz5JfDxbJivIIs21344PBiGu2KvJNVCDk7jLlvqw==
X-Received: by 2002:a17:902:dac7:b0:21f:7a8b:d675 with SMTP id
 d9443c01a7336-231de3515ccmr83477955ad.4.1747470736647; 
 Sat, 17 May 2025 01:32:16 -0700 (PDT)
Received: from localhost.localdomain ([60.186.106.48])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-231d4adbee1sm26184675ad.70.2025.05.17.01.32.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 May 2025 01:32:16 -0700 (PDT)
From: Yang Ming <mosesyyoung@gmail.com>
To: dev@dpdk.org
Cc: Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v4] eal/linux: skip vfio for non-privileged container
Date: Sat, 17 May 2025 16:32:01 +0800
Message-ID: <20250517083201.400-1-mosesyyoung@gmail.com>
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

