Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7704DC88E72
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Sep 2026 17:37:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0B8AB40C35;
	Mon, 14 Sep 2026 19:37:39 +0200 (CEST)
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com
 [209.85.210.175])
 by mails.dpdk.org (Postfix) with ESMTP id 4B6BA41132
 for <dev@dpdk.org>; Mon, 14 Sep 2026 19:37:37 +0200 (CEST)
Received: by mail-pf1-f175.google.com with SMTP id
 d2e1a72fcca58-8701fcf40d4so593662b3a.3
 for <dev@dpdk.org>; Mon, 14 Sep 2026 10:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789407456;
 x=1790012256; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2WG4FRBheH4wBt3Y1UhjqANNxZMWVI2bVy3rt36ZIRg=;
 b=HJvIO2WIlTErKNFyM6esvrvjXQO71O+W0PYQvOnXAHMbHVN7Fxs5C0yZelpmnwiu/Q
 uQ1o1eqTTtoT7zOTrGHkLozk+4pEVFsE3Ud6iauzymwGj3ll9ulVQGtqjUuFQbp4Cg6o
 kqjwZ7D7VOjfdbnkCDWyX8H70MnHr+dEqjIQmL1+T/tGpznQJbPQzSczxmrVJ8Qpt8td
 C3+lgjfsL5uQLV+PZCFP4ijgX9ihA+ez5bs5y/JpsRzDtompsZjqBkMu5Kcv9dAcEv6B
 jTa7J4yzNt9WcEuQQOOAPlx4+ZSgVicCRQ+kVb7HX5YL2iMWXNnkWdB2ZWw0NrY2gECC
 DOdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789407456; x=1790012256;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=2WG4FRBheH4wBt3Y1UhjqANNxZMWVI2bVy3rt36ZIRg=;
 b=eKNYockGzJ1puWADnJ8NHd9DGBR6wrf0jNFQrPRrXMwGUllanICU9nJ8KYHTpMxlWy
 kjLCERtYIwK0RKcjOfTTcOjeb9X0lTXjX6A7yJO8maavrEetqMvA/IN8ZWqfbER05LbH
 WwLqjrqPW3Oth6QqJNG6rkQtjH7yhuDH1HlVmyqxsdJ0QMcS1xc6jNPTUnwbULzFTTPq
 HoT1TNOFkTE/h+vVdrnQcl1t0enLW+lDuToHxGO5xPn3ZKwe9H1GMeQ3Ij1P7R2iXZmW
 GClge46xoXYHQclDQR2E40XGylspk61vnmsGmM+VcsxvyvRPdKbI/A6ngGRlEbjiaF+O
 nSRw==
X-Gm-Message-State: AFuF++nKHl1kmig7OZvmNuzKXpUsThL8Dbs6JsuThYrASnbuezlUiRMf
 p7nfv+1wZsvXkujtqMzQj7Ov5q08ZSpBUtY/tfXpOTPcKaBd2QK4SnbqgaUYfTCxLKbW0zdNsG+
 ZCJnlTKo=
X-Gm-Gg: AYBFou0Bo89QI28BvFr8m4kB+ra0jdKaEV5L15/i9VemwzW7dUC6F7hyiN+y73A6Z7D
 +lq1LKZTqD7vVGuXUPWYA09EhQe1eU7n4BOrPfFdSuD//ugp+2D4VNTbUHyFFcd/MOTXG7T3Vsk
 plU8VUiShdmTGECDPsaUWikUe4tfsyjSOw5j9qT0jeWtNfnkuybSE0dRBC4TsssFb54vWgdEYXS
 y89s3rcecsxfXz9uXgP7q2kPM7ksWWNNFhhZbwwyvVlGsj3hoWpygTx+FzxxQXC8u6UuaW3qqmA
 pvuOSA5PyNu5mUYs6EpLGGKrmuvQK6ClsSMSEM7IQC3OOUb0hCpsAykXl+fN2VodEgSCpHsA6sV
 3hydthF6eKppWPf6S7/VVCHhSHXJB2Ev49ltH8pWWhC+y66cDEC+aJgOFnFcsxw+Z1ly3L/iOPd
 NDAqlD1CvFb2LgWjn0NzxQ0H1hulNeCuZ+T8hzNB7UaQ0xBFDJQMSmKBdv96nEKfdDwqaiyYOCS
 +9iGoVF4/GgP6q5Zcm4ihtTKaz91v/MQnr5sg==
X-Received: by 2002:a05:6a00:148c:b0:857:727c:a1f6 with SMTP id
 d2e1a72fcca58-86f866af011mr6513961b3a.24.1789407456257; 
 Mon, 14 Sep 2026 10:37:36 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-86b286c49d2sm5159867b3a.10.2026.09.14.10.37.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 10:37:35 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Tomasz Duszynski <tduszynski@marvell.com>, Long Li <longli@microsoft.com>,
 Wei Hu <weh@microsoft.com>
Subject: [PATCH v3 6/9] drivers/bus: remove duplicate sysfs string helpers
Date: Mon, 14 Sep 2026 10:36:19 -0700
Message-ID: <20260914173700.2795983-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260914173700.2795983-1-stephen@networkplumber.org>
References: <20260912063319.4117869-1-stephen@networkplumber.org>
 <20260914173700.2795983-1-stephen@networkplumber.org>
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

