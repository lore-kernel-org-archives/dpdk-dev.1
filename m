Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12FDFD0E6FA
	for <dpdk-dev@archiver.kernel.org>; Tue, 25 Nov 2025 15:22:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DAF9940DC9;
	Tue, 25 Nov 2025 16:22:43 +0100 (CET)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com
 [209.85.214.181])
 by mails.dpdk.org (Postfix) with ESMTP id 3E1F640B9C
 for <dev@dpdk.org>; Tue, 25 Nov 2025 16:22:39 +0100 (CET)
Received: by mail-pl1-f181.google.com with SMTP id
 d9443c01a7336-29555b384acso70511265ad.1
 for <dev@dpdk.org>; Tue, 25 Nov 2025 07:22:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1764084158;
 x=1764688958; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UM3XmI5IeE+Ht4ZLdte70fSdo6e6t102aLiFbDd2o/U=;
 b=JAmujJ/K0JltUnGQxmBdshUsG69GIr1WWxAf3edLi+3J9vtroUAsGMFWuRioTV3fm5
 /TWwER599nFqEZ/fT9xonx3ZTRw63lE09hRpZTk/RYWO5uV/1SqPn6yfINhchqtD50rT
 WeN+2WhedQWIhBJM6eLzd50S2r4WqOacu01M0PfufWLvUm2iM9bu/y8pkGsxvZPCcgoe
 5DP5rGU/LE+QKUGveTSMEW/A4qYkNdiz5ZA9QJANb9jGMObLBrDRINAQKwFxRKgWPR0o
 SO42tYe2F5s4jO5gXbMJkCTe0TMJm1vpDCbxGKXygITGD4IvrvrsFRAFw67quMWgnuHO
 odoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764084158; x=1764688958;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UM3XmI5IeE+Ht4ZLdte70fSdo6e6t102aLiFbDd2o/U=;
 b=xIcoxXQ8p4+lbAALw48yy82W8wqaaFsFeLo53ymGYL6B4XLMlPvLI5sULJCTj4tBub
 w+sj9Aoqtcsd3MiBJezMyrdq7KMM//nC06sXty3W1Ll+kuyaw0ZU6/nNOT15UoLfjV9z
 6m7FTAt9sofiCmw5bG5RPv3EWq31W9WPzqowO7L/7adqaWmjV/WX1lnzJNFsPEe0lnXB
 vxZjRqte3sw4/Ae+xjvK/D/QcGnVW0K3Px6eEyFaunCdb5VQoIKzAS6Fwo26nALEH1EK
 5+jEyULBoqlzHOpsUkqkUJZb6FAivXM6Hg7gAU2ZfPEJTx18vIG7zFwL59w8xvOIbCwL
 4duw==
X-Gm-Message-State: AOJu0YzKZJTEblU8RyOSM0AT00OXOHhWawoDYnh1ROlAbW4+CnMOkA/D
 Y8GgZbEJgpfX1G2lXmw/BkNUmO9G9tsnyOUaSLQh6Y2fVpM+fhKvESEo0ZFrcJNJhOzgfd/Pyp0
 rhpY5
X-Gm-Gg: ASbGncsR30qJMtlcztu+JVLMVsRP92ImKYbrxDQ1eRTbQl2PXuBvvWy7S29KKmIFy9S
 GHBnmYoT+ica1mQvWJLQRXlquvxBUUVhclTmpI/Ol1f4gXDxIAhXJOfj7JN3HZ4LXO/VnuFUKkT
 aCR+PTBroyIH2ylS0/ur7t/mTdP4MRullcUXs6QYI1O8rGjk9sQeSXBoplUy/a7wTmDHo9EL629
 dJjDY6LEu2bR3SeGHyGLQ61Ora7eyJSE9cmUTaC+5FZUJsF2+Dv5Tg15G20GnStOKy+Wu2i2slX
 F/D0YRMO2Sdu54KmGA8uHP9HBSHEx9z9XMIU7a4LrBZ4HyL2kk/U/y6TdGSB7jBWH4mVt7ct9t5
 XGp+1uxoYogJJDoyb/fdjC8chRKCVpYaeTyIxhD+4HSZv5k3GrSk3GDXJfAz61ReEAZSB01QPiL
 oMuIgarg4x5FYRw5tFzKlw7tKH2qSsErZKZGnu0nntTdy0NIqSOwCpIVa5620E
X-Google-Smtp-Source: AGHT+IHUzlafQj2FZkuuoQigHMwU6OII9s1HbaqVW2i/heyhyDCosdOEfnpIWyyhsxEulNbqKQ53kQ==
X-Received: by 2002:a17:903:11c7:b0:295:bedb:8d7 with SMTP id
 d9443c01a7336-29b6c694376mr154422015ad.48.1764084158160; 
 Tue, 25 Nov 2025 07:22:38 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29b5b111acfsm172573345ad.19.2025.11.25.07.22.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Nov 2025 07:22:37 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v7 02/10] test: add new function to get current file-prefix arg
Date: Tue, 25 Nov 2025 07:20:52 -0800
Message-ID: <20251125152232.73528-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251125152232.73528-1-stephen@networkplumber.org>
References: <20251110182209.104087-1-stephen@networkplumber.org>
 <20251125152232.73528-1-stephen@networkplumber.org>
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

Refactor so that there is one function to get current argument
for "--file-prefix=XXX".

The code does not need to initialize all these 4K buffers since
they are directly used by functions that set them.
The maximum sizeof of the current DPDK prefix is NAME_MAX (128)
not PATH_MAX(4096) so save a significant amount of space.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test/process.h | 38 ++++++++++++++++++++++++++++++++------
 1 file changed, 32 insertions(+), 6 deletions(-)

diff --git a/app/test/process.h b/app/test/process.h
index f948a89786..4e5cbaf3cf 100644
--- a/app/test/process.h
+++ b/app/test/process.h
@@ -199,15 +199,22 @@ process_dup(const char *const argv[], int numargs, const char *env_value)
 	return status;
 }
 
-/* FreeBSD doesn't support file prefixes, so force compile failures for any
- * tests attempting to use this function on FreeBSD.
- */
+/* FreeBSD doesn't support file prefixes, so no arguement passed. */
+#ifdef RTE_EXEC_ENV_FREEBSD
+static inline const char *
+file_prefix_arg(void)
+{
+	/* BSD target doesn't support prefixes at this point */
+	return "";
+}
+#else
+
 #ifdef RTE_EXEC_ENV_LINUX
 static inline char *
 get_current_prefix(char *prefix, int size)
 {
-	char path[PATH_MAX] = {0};
-	char buf[PATH_MAX] = {0};
+	char path[64];
+	char buf[PATH_MAX];
 
 	/* get file for config (fd is always 3) */
 	snprintf(path, sizeof(path), "/proc/self/fd/%d", 3);
@@ -216,10 +223,29 @@ get_current_prefix(char *prefix, int size)
 	if (readlink(path, buf, sizeof(buf)) == -1)
 		return NULL;
 
-	/* get the prefix */
+	/*
+	 * path should be something like "/var/run/dpdk/config"
+	 * which results in prefix of "dpdk"
+	 */
 	rte_basename(dirname(buf), prefix, size);
+	return prefix;
+}
+
+/* Return a --file-prefix=XXXX argument or NULL */
+static inline const char *
+file_prefix_arg(void)
+{
+	static char prefix[NAME_MAX + sizeof("--file-prefix=")];
+	char tmp[NAME_MAX];
 
+	if (get_current_prefix(tmp, sizeof(tmp)) == NULL) {
+		fprintf(stderr, "Error - unable to get current prefix!\n");
+		return NULL;
+	}
+
+	snprintf(prefix, sizeof(prefix), "--file-prefix=%s", tmp);
 	return prefix;
+#endif
 }
 #endif
 
-- 
2.51.0

