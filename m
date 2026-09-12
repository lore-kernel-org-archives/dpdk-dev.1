Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11455C79FB6
	for <dpdk-dev@archiver.kernel.org>; Sat, 12 Sep 2026 06:34:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B150C42DD5;
	Sat, 12 Sep 2026 08:33:57 +0200 (CEST)
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com
 [74.125.227.140])
 by mails.dpdk.org (Postfix) with ESMTP id 4666942DE9
 for <dev@dpdk.org>; Sat, 12 Sep 2026 08:33:56 +0200 (CEST)
Received: by mail-pj2-f12.google.com with SMTP id
 98e67ed59e1d1-396ccdaea75so149761a91.1
 for <dev@dpdk.org>; Fri, 11 Sep 2026 23:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789194835;
 x=1789799635; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2WG4FRBheH4wBt3Y1UhjqANNxZMWVI2bVy3rt36ZIRg=;
 b=YYFd7d1mcTzVkMzZqnC+4yJQ5Z2+qsPQwYer+hm+3DlOmOo0oXHHkcpQEErnbbHM3u
 lfzsuMUFZVk/uOMgUl/gMees1VWJLxazqSeAogPsSxrsPdAhO1KcanrBdkj8nPxvNiXM
 5KXMEG+/FtQVvSn05z27P2R96Xg+5xKobNWWtG+dyhvj86ULYoGa0NzDQE52AvrjY/I3
 L3An4Gzbk1jNAG4YptyI8FY8M2Onw4MYeCp0LQeLsAQWiZ3rh5yZqnoGzSOmYP85zAcf
 KukN9hdGniIxEpROoEtCudXChMmBDOfFiNl65JWiVJnOfSk17eylD+ufGDDw8ulzaBRw
 ud2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789194835; x=1789799635;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=2WG4FRBheH4wBt3Y1UhjqANNxZMWVI2bVy3rt36ZIRg=;
 b=JvKzGKnd8G/ZKQR3rScXZL7b0LNoFlvUSWd49TuxtuKFehE79WBpTOCeU3+Hkftnw4
 AQB1Mfm+a5Dusw9eWBQuaM2qP98egODWj/I8YHpo+xNqJbkFsVxOh2FYRgdVgfnAXvJP
 N9U6/Wk45FBj8dyHUA69P3a435IJqQDOK0sMMOXs8ivyuX277tIDGbM6La1ubw6M9N9W
 +Pjf9RUQUycQkpIzXUvPT8CBIiMG9whmwol3rQmkAJU33alIxCv4RxRQnePjoCPsgufx
 SnIM0tVrLy7aNm+FYYlo1gWKR9t/d/RmcDownZfkf0CxqZdUuYcr1PnGXVdwCjEIXYK1
 RW0w==
X-Gm-Message-State: AFuF++lDwbzUM5TKOUL+ca31npJRI5zctCp2z34DuE66j7teCsr3zuiL
 BqjRrvNzQgvUis7Z/wMoLGwa/uDF/5DnSPpXID2LIp23ka+OQREvaOgymb5iJLeuixSKfnOPXlV
 hXN9a5UE=
X-Gm-Gg: AYBFou12LdLM7uYvkwGFfLfeIcJJ+coeQlLIeUD/efFt6xapEAS+1FZLxqhPZHWdk1e
 YzoBmeOuiR8r8O1+zsO6J8SGAfTou5d78X3Vp655hH/oXyYohZTQx2OZq7PQ2LxyczK6o3Ea8PP
 IuVfs3Ii22v3TtfTqi1bqkJoWXqbAAn52+paILCQtB5w/c2CcsC5YLfw7p2bGsV5nw9tRshmtsu
 gzVIHq+iX2Llk3jdNlx0hjcHLOmxXYZGJCXtln1YQtZyyytFUj1z9Wn+I4uYL/ky/C+HbKstQ2n
 Cjv5pxjhGUe2oRCxvrcJIvcQz7Lb/dC94H0KrgUy2T/1qfwu6PvlRO0G0sE6haK3QV8fNIh2gtp
 Q/tejcBA6C6S7EJbbYLKndJNaDep98CJYhQWspNCHxlvAVg/AQ4NdN7bVtUZhAencdWQVoVT+zV
 9DKEnOkMi3LMZQvaPqQ/pmxGi2z2ZM64bJwiQ0qpDNYGFcIcLqHL4lyCTs5Si5wPH9r4YYm+cpM
 0+dfBJAyR4YR6j2PhiarH3CZLgA0d1+WC/r7w==
X-Received: by 2002:a17:90b:3cc5:b0:38e:c232:9d2c with SMTP id
 98e67ed59e1d1-39d97ea3396mr7060952a91.2.1789194835176; 
 Fri, 11 Sep 2026 23:33:55 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39d95424fccsm8661497a91.10.2026.09.11.23.33.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 23:33:54 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Tomasz Duszynski <tduszynski@marvell.com>, Long Li <longli@microsoft.com>,
 Wei Hu <weh@microsoft.com>
Subject: [PATCH 6/9] drivers/bus: remove duplicate sysfs string helpers
Date: Fri, 11 Sep 2026 23:30:25 -0700
Message-ID: <20260912063319.4117869-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912063319.4117869-1-stephen@networkplumber.org>
References: <20260912063319.4117869-1-stephen@networkplumber.org>
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

get_sysfs_string() in the vmbus bus and read_sysfs_string() in the
platform bus are both open coded copies of what the EAL routine now
provides. Each had a single caller.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/bus/platform/platform.c     | 33 +++---------------------
 drivers/bus/vmbus/linux/vmbus_bus.c | 39 +++--------------------------
 2 files changed, 8 insertions(+), 64 deletions(-)

diff --git a/drivers/bus/platform/platform.c b/drivers/bus/platform/platform.c
index 9585fb79e9..c511893aab 100644
--- a/drivers/bus/platform/platform.c
+++ b/drivers/bus/platform/platform.c
@@ -187,40 +187,15 @@ device_unmap_resources(struct rte_platform_device *pdev)
 	pdev->num_resource = 0;
 }
 
-static int
-read_sysfs_string(const char *path, char *buf, size_t size)
-{
-	FILE *f;
-	char *p;
-
-	f = fopen(path, "r");
-	if (f == NULL)
-		return -errno;
-
-	if (fgets(buf, size, f) == NULL) {
-		fclose(f);
-		return -ENODATA;
-	}
-
-	fclose(f);
-
-	p = strrchr(buf, '\n');
-	if (p != NULL)
-		*p = '\0';
-
-	return 0;
-}
-
 static char *
 of_resource_name(const char *dev_name, int index)
 {
-	char path[PATH_MAX], buf[BUFSIZ] = { };
-	int num = 0, ret;
+	char buf[BUFSIZ] = { };
+	int num = 0;
 	char *name;
 
-	snprintf(path, sizeof(path), PLATFORM_BUS_DEVICES_PATH "/%s/of_node/reg-names", dev_name);
-	ret = read_sysfs_string(path, buf, sizeof(buf) - 1);
-	if (ret)
+	if (rte_sysfs_parse_string(buf, sizeof(buf) - 1,
+			PLATFORM_BUS_DEVICES_PATH "/%s/of_node/reg-names", dev_name) < 0)
 		return NULL;
 
 	for (name = buf; *name != 0; name += strlen(name) + 1) {
diff --git a/drivers/bus/vmbus/linux/vmbus_bus.c b/drivers/bus/vmbus/linux/vmbus_bus.c
index 9ee7983eb6..00f369120f 100644
--- a/drivers/bus/vmbus/linux/vmbus_bus.c
+++ b/drivers/bus/vmbus/linux/vmbus_bus.c
@@ -84,35 +84,6 @@ parse_sysfs_uuid(const char *filename, rte_uuid_t uu)
 	return 0;
 }
 
-static int
-get_sysfs_string(const char *filename, char *buf, size_t buflen)
-{
-	char *cp;
-	FILE *f;
-
-	f = fopen(filename, "r");
-	if (f == NULL) {
-		VMBUS_LOG(ERR, "cannot open sysfs value %s:%s",
-			  filename, strerror(errno));
-		return -1;
-	}
-
-	if (fgets(buf, buflen, f) == NULL) {
-		VMBUS_LOG(ERR, "cannot read sysfs value %s",
-				filename);
-		fclose(f);
-		return -1;
-	}
-	fclose(f);
-
-	/* remove trailing newline */
-	cp = memchr(buf, '\n', buflen);
-	if (cp)
-		*cp = '\0';
-
-	return 0;
-}
-
 static int
 vmbus_get_uio_dev(const struct rte_vmbus_device *dev,
 		  char *dstbuf, size_t buflen)
@@ -169,7 +140,7 @@ RTE_EXPORT_SYMBOL(rte_vmbus_map_device)
 int
 rte_vmbus_map_device(struct rte_vmbus_device *dev)
 {
-	char uioname[PATH_MAX], filename[PATH_MAX];
+	char uioname[PATH_MAX];
 	char dirname[PATH_MAX], mapname[64];
 	int i;
 
@@ -188,11 +159,9 @@ rte_vmbus_map_device(struct rte_vmbus_device *dev)
 		snprintf(dirname, sizeof(dirname),
 			 "%s/maps/map%d", uioname, i);
 
-		snprintf(filename, sizeof(filename),
-			 "%s/name", dirname);
-
-		if (get_sysfs_string(filename, mapname, sizeof(mapname)) < 0) {
-			VMBUS_LOG(ERR, "could not read %s", filename);
+		if (rte_sysfs_parse_string(mapname, sizeof(mapname),
+				"%s/name", dirname) < 0) {
+			VMBUS_LOG(ERR, "could not read name of %s", dirname);
 			return -1;
 		}
 
-- 
2.53.0

