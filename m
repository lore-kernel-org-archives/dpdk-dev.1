Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DD05C3ABDA
	for <dpdk-dev@archiver.kernel.org>; Sat, 17 May 2025 08:21:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 491CD402E0;
	Sat, 17 May 2025 10:21:51 +0200 (CEST)
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com
 [209.85.215.178])
 by mails.dpdk.org (Postfix) with ESMTP id CB0C0402DF
 for <dev@dpdk.org>; Sat, 17 May 2025 10:21:49 +0200 (CEST)
Received: by mail-pg1-f178.google.com with SMTP id
 41be03b00d2f7-b26f7d2c1f1so1047848a12.0
 for <dev@dpdk.org>; Sat, 17 May 2025 01:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747470108; x=1748074908; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mGKlQ2qeLXhaPjyjH4RpbokKu+gDtb2C5QM6XrVdsvY=;
 b=fzbP6vDsxBIYLV3ayVG+LkMTP5aGmvceYCRbG6ensFgVm2JOKvNo1T134NhoB4rNnd
 V85LS8ymMaMHYmrHAeOuN0d9Wz57iOJupoKjUyZXiyul1R7gzQY2K2hhujK85qeSRDzd
 JLeGU58em8O96531W2FQc/amr4My3dRME52TEfZ9VarC4NhkBc/unIJs+rIbRbOGnnaP
 dnObksXiwi8f06MKASUTTcO+4HryfQLwmFQzIwntq9TlYY3NFPtPSgDurZUyFKyyey/t
 4DMfbHdA/WIze+NG1p4tXguFFrHq45h/OUwA0e3LikV9q25w7G6yA0kqTDF8G54YzWEA
 oWDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747470108; x=1748074908;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mGKlQ2qeLXhaPjyjH4RpbokKu+gDtb2C5QM6XrVdsvY=;
 b=wQKGn23pcmY/uJen8wr54yOCsmWONXYNGcpR6owqPXYNDbnxh6gkY/CGbHPM9WBdJF
 /kVsasCdyYRvR4chTRkTyK7C9BeQNQMiHnAC54cJuC0ZMX/HB8kVvvIvlJwE/QuKVxYL
 aZukjo2r8HEJ9mL8CPv757Z7p8lHdgQ9X1RbTfELP92JjY374Lq/+Pp4PieR1p/pB3DN
 dHq//v7MuWsMNLvj1slY08A3hjcfmSDpe4NGIyJlUZaEQVdzBAA5fmHrCoc9y2h/E9aA
 xomZHYVy6LuZD1liQE/JbcWxjLH8CDYGBky+bvZbGNjMFfIuIQF6YuTb7AYtYLxV5NX6
 unYQ==
X-Gm-Message-State: AOJu0Yym96yk68KU1DD14EGKh8VaBOtd+J5zEVQh+XcCjngVCxVRyNeh
 XCj+lwbAg+Fl7lqXdsFjn7oPg9xYwWYmHJjm0KY2qpie1eL15OvavMzPnUZUxZGxmjU=
X-Gm-Gg: ASbGncv7fTcilOJshYKnEWVuFsfvWyPkz2ijpMQr2fK8YGDCU+15FQ+yo+06Q7qINE3
 +uB11N/WmfQ5lTtaRJ7oOQYU6TPdDHAyldizUPSzOXfXZR4B/UvRRGS2YMVvJFbzH1mLCvLXKyP
 +zVv/mP8JlY9fabcdyzhBMnJSEGS8eTnWA8goZQV8hjLO8l6FX6lCnRBfyyqJPE1gLNRg8qU4Na
 Oo8658TF9z3V06zEmED0ueZWJinCFTtTBXLfkw3FT/RJa5tgPgoKJlmPlmH3O6MfNWJ6Yfw1TFz
 FyqlA74bq+qB2+qq/VNUXmKDs1fPuQ40DBcrdPdOroIR9SA+l98uHu7+FdFt/23DI+mjWB7aqng
 abkZt
X-Google-Smtp-Source: AGHT+IFfC4CQq6luT5LbrrPr/LJ0BCh/VEzZltgAcdKZDuXl9dZo+AlYqOicUyQvWBRTMLvaVINpwA==
X-Received: by 2002:a17:902:d486:b0:224:1609:a74a with SMTP id
 d9443c01a7336-231de3ae59amr78364145ad.34.1747470108098; 
 Sat, 17 May 2025 01:21:48 -0700 (PDT)
Received: from localhost.localdomain ([60.186.106.48])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-231e27e62aasm22685065ad.31.2025.05.17.01.21.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 May 2025 01:21:47 -0700 (PDT)
From: Yang Ming <mosesyyoung@gmail.com>
To: dev@dpdk.org
Cc: Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v3] Skip vfio in the scenario of non-privileged mode
Date: Sat, 17 May 2025 16:21:34 +0800
Message-ID: <20250517082134.364-1-mosesyyoung@gmail.com>
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

