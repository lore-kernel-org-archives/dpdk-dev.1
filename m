Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C61E3C531D0
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Jul 2026 18:12:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8F15A40A76;
	Thu, 23 Jul 2026 20:11:59 +0200 (CEST)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by mails.dpdk.org (Postfix) with ESMTP id 6BAA6406BA
 for <dev@dpdk.org>; Thu, 23 Jul 2026 20:11:58 +0200 (CEST)
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-2ceb096e675so11859165ad.0
 for <dev@dpdk.org>; Thu, 23 Jul 2026 11:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1784830317;
 x=1785435117; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dIVlSikEvS1+UTKl1B6JTcqkR71cvIgPfJZqoUj6w0M=;
 b=nIU7YkuZCh6JwtDVElMkh+rf3QRVoks9Ey0p3uss1sQjhGe7cs+A0I54CzuS2nVx9I
 6SOw+urkFefL1OhXYzhqCoHmaVhZsW7uUre5oiPXalqsnEWFaZybIWPZWJfHfnguABev
 7HF41mgkCaYdfgv9sfyC3+1ZcngBltMYLgmr4CynOnAJFLIEfeHfQ3ydyclEKJi9HjLJ
 Wg9ex1Ak/fUzKCGYMmcbtbBampCoUhMYn/0y0WqSjHs3oSbpJ7RQV0nPdkEdneTn9Bs0
 1a/ZGqs/yCBV8sUZsZ7Yr4nLNOolwSJqyMKdWbmL+93C3kcWWi5gPZ3o/M+99R9qmH+q
 IFtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784830317; x=1785435117;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=dIVlSikEvS1+UTKl1B6JTcqkR71cvIgPfJZqoUj6w0M=;
 b=adMnV7MOkl51aUaRNo99tfOLiiW46QRPeXs7t+/aCvRPmuggAyqHX3qBfQTqFG2Re7
 jRKZNIDbLde3w26vgGnnIyi9DnqZ6FYYWd7XMQeltOZo9iJScWg7mZ+a7iqHcsxeDl2i
 S7FAE4MdfEJF+fE3wBThYGKBwAiypbPDkzUjmUiIwG0zM7U+CE7kLpg4Chm+LYchMhwc
 C0sh7elXD7xbAAHAj7jbo+lbXF63n27j70RW7PIJYh306HUwsvMqOzEFfzB71Lt4XQX5
 sPhBlzboHUcq7/p0DFkrNEe/e5D85K6Sf0i/JjGUQPOyUMpzrhktjj2VtRAX9E/v/1nw
 wGBQ==
X-Gm-Message-State: AOJu0Yx+MSA6COTTsY5ujGjqVqTAlLEvUswvEFSu2pMFVI/ogKYYE1JD
 0uBJFlIuVRAMRhI/kcc9/zZYEe+wIdqztDukA1MVYCxt0K8XDuAMCOsUf3eSloL+YH4vPx02qmL
 43IgT
X-Gm-Gg: AR+sD12utwQ8n/qSaCXmu1WZgxAm3vKsvb0f7aboSQHTekqwPaqDIJHcR/oYNEequr6
 fjGrzRI8OxT9BcoLIIr94LMET7E2xBRYE21OqUcCnQfC7fAHnm/SzBS4C1LIT+WW6rj/8tmgSuC
 Dp73bK2fDdW6r4pfp3AIW0DwzyPaWqUYsmUWwiE8KB53C80j02i1ckdOhnAQSceiRq/wg3TbeWd
 t3Wgi3vT2JsiHjMIFw+zesWr1v90eIaXJAjsW8h6SWeYHZX7KoMYzV0ib4gGIImYFheCHEkFEUb
 UD8Y5aE8q9NNoKQZgvW6m45RtXjRa36oZLIT06IlNwvOnFxstfAnGs9bhOdqKhd2/dWkfH79e4/
 XXR9hsNDHGv2ZBopo7C+H9KRstzpzkWV7qzMI2iiTGc9/qQh6ZVqje9o06YQM+7eKmOq/lFDX3I
 1nW1kIJE5D9+yKrVoap3Qf2MCWbmtgwf74nvHvEDB8gvm2xyvAaOU=
X-Received: by 2002:a17:902:d4c9:b0:2ce:faa6:7cbb with SMTP id
 d9443c01a7336-2cfa6a59f30mr51902065ad.4.1784830317642; 
 Thu, 23 Jul 2026 11:11:57 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3147dc6781dsm23791932eec.9.2026.07.23.11.11.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 11:11:57 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v2 2/2] net/nfp: move socket from /tmp to runtime dir
Date: Thu, 23 Jul 2026 11:10:28 -0700
Message-ID: <20260723181153.195915-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260723181153.195915-1-stephen@networkplumber.org>
References: <20251231185803.90528-1-stephen@networkplumber.org>
 <20260723181153.195915-1-stephen@networkplumber.org>
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

The CPP bridge service created its unix socket at a fixed /tmp/<pci>
path, which is world-writable and shared across DPDK instances. Build
the path under the EAL runtime directory (e.g. /run/dpdk/<prefix>)
instead, so it follows the configured prefix and is isolated per
instance.

The old code copied the path into a struct sockaddr, whose sa_data is
only 14 bytes, and bound sizeof(struct sockaddr); a runtime-dir path
does not fit there. Use struct sockaddr_un so the full path fits, and
bail out if it is still truncated.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/nfp/nfp_cpp_bridge.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/net/nfp/nfp_cpp_bridge.c b/drivers/net/nfp/nfp_cpp_bridge.c
index da7ea35d62..c307eca730 100644
--- a/drivers/net/nfp/nfp_cpp_bridge.c
+++ b/drivers/net/nfp/nfp_cpp_bridge.c
@@ -7,6 +7,9 @@
 
 #include <unistd.h>
 #include <sys/ioctl.h>
+#include <sys/un.h>
+
+#include <rte_eal.h>
 
 #include "nfpcore/nfp_cpp.h"
 #include "nfp_logs.h"
@@ -334,17 +337,22 @@ nfp_cpp_bridge_service_func(void *args)
 	int datafd;
 	struct nfp_cpp *cpp;
 	const char *pci_name;
-	char socket_handle[14];
-	struct sockaddr address;
+	struct sockaddr_un address = { .sun_family = AF_UNIX };
 	struct nfp_pf_dev *pf_dev;
 	struct timeval timeout = {1, 0};
 
 	pf_dev = args;
 
 	pci_name = strchr(pf_dev->pci_dev->name, ':') + 1;
-	snprintf(socket_handle, sizeof(socket_handle), "/tmp/%s", pci_name);
 
-	unlink(socket_handle);
+	ret = snprintf(address.sun_path, sizeof(address.sun_path), "%s/nfp_%s",
+			rte_eal_get_runtime_dir(), pci_name);
+	if (ret < 0 || (size_t)ret >= sizeof(address.sun_path)) {
+		PMD_CPP_LOG(ERR, "Socket path too long. Service failed.");
+		return -EINVAL;
+	}
+
+	unlink(address.sun_path);
 	sockfd = socket(AF_UNIX, SOCK_STREAM, 0);
 	if (sockfd < 0) {
 		PMD_CPP_LOG(ERR, "Socket creation error. Service failed.");
@@ -353,13 +361,7 @@ nfp_cpp_bridge_service_func(void *args)
 
 	setsockopt(sockfd, SOL_SOCKET, SO_RCVTIMEO, (char *)&timeout, sizeof(timeout));
 
-	memset(&address, 0, sizeof(struct sockaddr));
-
-	address.sa_family = AF_UNIX;
-	strcpy(address.sa_data, socket_handle);
-
-	ret = bind(sockfd, (const struct sockaddr *)&address,
-			sizeof(struct sockaddr));
+	ret = bind(sockfd, (const struct sockaddr *)&address, sizeof(address));
 	if (ret < 0) {
 		PMD_CPP_LOG(ERR, "Bind error (%d). Service failed.", errno);
 		close(sockfd);
-- 
2.53.0

