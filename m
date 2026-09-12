Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2984FC88E59
	for <dpdk-dev@archiver.kernel.org>; Sat, 12 Sep 2026 17:04:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2FA90406BA;
	Sat, 12 Sep 2026 19:04:18 +0200 (CEST)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by mails.dpdk.org (Postfix) with ESMTP id A79E2402EB
 for <dev@dpdk.org>; Sat, 12 Sep 2026 19:04:16 +0200 (CEST)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-2db3305f94fso28432565ad.0
 for <dev@dpdk.org>; Sat, 12 Sep 2026 10:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789232656;
 x=1789837456; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2WG4FRBheH4wBt3Y1UhjqANNxZMWVI2bVy3rt36ZIRg=;
 b=kROJFOj9zWbTo7WWgHYsA7ucnJKKZi3PKRiAauhwMa5HIYPLb34lVYjjD4o5nqWyei
 0TrjWXRS8VlQqZKpoedANacH1fB8vzbdr9rlLIXPOWYolae9rFzn38sMjQeBSNVN53Lm
 B+Lk4s5Axr59oLQlPSPyv++Jzr4eSaBLmnX7Di8lVpMWn6GRsGYjKM8PNs18Ylm6DG/I
 qRnMcF5r6dIr2dMqyQAwtZS8tWxrVk7xIksYdoMgLhPzuyBtV6mO8KETAjnAavcGGrYH
 iC+PgOFsEZt/Wsj9B5RJ45dW5bxPNoFMAALhV6NSZEM7ERmiwuXBOGeYTGLvI8virYHa
 Kv+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789232656; x=1789837456;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=2WG4FRBheH4wBt3Y1UhjqANNxZMWVI2bVy3rt36ZIRg=;
 b=cb5gTinxo16uUe0exBhAOGuPpRjotH44oRilzYf2TcO/uj0+71o5vW4HUYTVoRMG/f
 zbmzMNNmNVm/F0z/FMf7pgW/pJIplMBVSasuoiOHRhcVbkHyu68eiCI2tJUMwQc5E/T4
 nE8vW3sHqdenFJy3/ixIxmpczvphA2OsWGjYZIYj7/UPRhCbf0RB+s675jX9lMblmgAw
 CrmqKpwsajN9MoeLNEsRR6OjTsTyoV6Bh7vZ10tvXCTI7fbczLRrgiUBC9/q7L8U6yy6
 duCt+8fpt+wWiPJBYMuhzKZOJM0kgC6pgAzGRBV13TPO9tzlw2stbAEwz79m7h7BT4OQ
 rdOQ==
X-Gm-Message-State: AFuF++lgjrjcsjE/+zw0LHQbCuVRWYXxeZmyIKKdH40k1DnVmR5jF0gw
 mT1uYcQNhiFkz22HFAWIzcyhnPD8gH1hgNrlvh9WydJ9+D0u+3k2vPCOP2anHCAbIqxQKLNIJcs
 cRkzddCs=
X-Gm-Gg: AYBFou12enRt8bOuGj/F6l6NZdQ5gsQOmiGiZxMnKBIiUkk7gpyFM+TnywTqLXPwtrv
 gzaTMe+lmIjwaKrClLh4Woaxsb3FqTAje9O2VnIpsPWaL6NR8Dp97dUS3Mh/HGfNoq7fr69gwL0
 6+1iQ4vUWuJbpRGyGPn60RHz08Ejn6Na6KGLL72KAhYdJ8eKThv1KLOgeHHE9aKa2/vXweWVFf1
 syq/RtdmYpFkFeuJI9iTbATds4T2OCZQEZnnsWRQgPcaAvcrOIKXkMUJGDfd5ipo3aavb5uAn+J
 ZaiDoBm0JfVkVVARzfozMyVG4om/i/q2uePPHPqTyQFoYDVr77ZNGPSgiDLgVw18Jj0ENYpXArf
 RTw3xJPSlviH6Dv3vyLJkeT3iAARPJueeBsIuWpHEm2lirspRmphlM2Pndn3WJgDH3zI1iLaZwD
 Xop44+Lf1q1DZfePll4F9bbW8iAgMFxdpL4xNFoT+Gl+R7tq5pAtHzwcFil47fzaPagudCdWaBB
 BLUBhh7/WBbiPmuvjATciK7lwZRlWM/whlA56E=
X-Received: by 2002:a17:902:f546:b0:2dd:40cb:a04c with SMTP id
 d9443c01a7336-2dd40cba291mr102343375ad.19.1789232655721; 
 Sat, 12 Sep 2026 10:04:15 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc4c655c2f0sm2719569a12.18.2026.09.12.10.04.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 10:04:15 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Tomasz Duszynski <tduszynski@marvell.com>, Long Li <longli@microsoft.com>,
 Wei Hu <weh@microsoft.com>
Subject: [PATCH v2 6/9] drivers/bus: remove duplicate sysfs string helpers
Date: Sat, 12 Sep 2026 10:02:18 -0700
Message-ID: <20260912170338.486978-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912170338.486978-1-stephen@networkplumber.org>
References: <20260912063319.4117869-1-stephen@networkplumber.org>
 <20260912170338.486978-1-stephen@networkplumber.org>
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

