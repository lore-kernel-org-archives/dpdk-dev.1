Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1572BFD4F05
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Mar 2026 16:16:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D44ED410D3;
	Tue, 10 Mar 2026 17:14:24 +0100 (CET)
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com
 [209.85.210.46]) by mails.dpdk.org (Postfix) with ESMTP id 1859E40E30
 for <dev@dpdk.org>; Tue, 10 Mar 2026 17:14:22 +0100 (CET)
Received: by mail-ot1-f46.google.com with SMTP id
 46e09a7af769-7d7653db148so181565a34.2
 for <dev@dpdk.org>; Tue, 10 Mar 2026 09:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1773159261;
 x=1773764061; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7IkUl/0NLxrFpIz53KeZT2r+t1cZtUzoYXS3/PCXg6I=;
 b=t9ev2Uvk6c4+eEgPaq4kkpSXOxkB8C78etY0KIKLM6DcXLABPcryWZZRnVsR0Yzlb5
 WRAiloEyxwAkuIZYkSB2j+KeDqm5KCxkFnjnCQzYcaV3FQi6FJTeC0x9ArOXyppUsACH
 nnXNKMOzYL5EmTX9i+hwUEEWtvHCgqCVtVAUMy1He/XZFOk9tMBPGKVA+nLZV3qoElBa
 0VRN8bNawvXcDDzZD4o9n25EOU388aNVCsh2ZpsRmYus1xusjzX7gd3a7a06Wj4h7+ip
 IWUb7zsHYoHgxBTRILoiAHiLcHO/WUcxl//0CGaq6ijMX7K10aFNc9l/cIoIxg8ZxsHj
 Ct8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773159261; x=1773764061;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7IkUl/0NLxrFpIz53KeZT2r+t1cZtUzoYXS3/PCXg6I=;
 b=i7A5zqGdoDa+Qn4qQDrjxegH+HWW6ZVNfcU+qHPbSAA3wuifiCQz+kBl28a8wCUlkj
 AiWNWIQuejedk6yxC+1lCDUTiaIqMWB8P42xqnmp6A0BlV+wviFaxt96N+1j45U3XQCl
 sViq/k2mMzT62788ahFvl+gZ+gjmqbPduBP/isRr6oDFhPMUnSMqzVYxlB5e/Py5YUmd
 S2jc9NKqc+grOLG5qJDArehvsODlMJ3CBNr4sS3uh1EWH3RL14D8ct5efoMzzMloW1/Z
 cFMyeuE+iR1yJz0f3NGsBjYSjL4Es6vqumZsfhBEBJQIIlEmrEevhOiF3dD5RlzdM2Z8
 MR9g==
X-Gm-Message-State: AOJu0YxuxlDvbvllEgmy8YibNitd8xw1AFWe7IZB6ADTO68Px73WIFTC
 LzkPDbxEdDBrkzyGAse53DgcbynXjbsff2zAPAMZ71CDIgqIT9YgCDgHyoNiY/yak5CHCahdoGg
 WbCkQnO4=
X-Gm-Gg: ATEYQzzo3UDlbbsi0rhre4jNNNogMB3LxFkvqZS0OABRn5d+md6JIjyD7Eq5431WmM1
 XRbgpIoXfcfpILgDjw0q7MGx9l+n8fc+MuuegVNXPvEpD6k5gJclWs7jrA77cp3If8BlQXWc5TL
 jgzbwVDgGK28Jsoq4/1bqDWDqhgzZUWNrUSu6JxmJvIVM8hPib38Z7y4Zdg73mDbgIlm2wnu9TO
 MyNybIBk7PhI71YUnZPAAAuHVL5k1nZS8vBQoBHqKUtYgbwvQ0cT+FWj4sp2auo7z1m529SBfIO
 og9zjDjdgy9zqWn5jVYtfhjSXKQbJ8+yA0TcCanD0Pkiad8fJsc+vQAMYffc/DVcjyy0KVw33DS
 o9G4Aqo9TuIYotm8KbBxbp/ejY/gsb789uLQZUwAFMDl29ghYd0ZwCpvZyBmrqqyA4sDvExr15A
 oaBpj2Ppw/VXfeI1vuJsMnuR0c20GOx2SZ
X-Received: by 2002:a05:6830:828f:b0:7d7:4ff4:c16b with SMTP id
 46e09a7af769-7d74ff4d0cdmr4652310a34.11.1773159261377; 
 Tue, 10 Mar 2026 09:14:21 -0700 (PDT)
Received: from phoenix.lan ([104.202.29.139]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d738e3f421sm7304004a34.25.2026.03.10.09.14.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 09:14:21 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>
Subject: [PATCH v20 19/25] eal/windows: add wrapper for access function
Date: Tue, 10 Mar 2026 09:09:57 -0700
Message-ID: <20260310161356.194553-20-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260310161356.194553-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260310161356.194553-1-stephen@networkplumber.org>
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

Like other Posix functions in unistd.h add wrapper
using the Windows equivalent.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/eal/windows/include/rte_os_shim.h | 1 +
 lib/eal/windows/include/unistd.h      | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/lib/eal/windows/include/rte_os_shim.h b/lib/eal/windows/include/rte_os_shim.h
index f16b2230c8..44664a5062 100644
--- a/lib/eal/windows/include/rte_os_shim.h
+++ b/lib/eal/windows/include/rte_os_shim.h
@@ -33,6 +33,7 @@
 #define unlink(path) _unlink(path)
 #define fileno(f) _fileno(f)
 #define isatty(fd) _isatty(fd)
+#define access(path, mode) _access(path, mode)
 
 #define IPVERSION	4
 
diff --git a/lib/eal/windows/include/unistd.h b/lib/eal/windows/include/unistd.h
index 78150c6480..f95888f4e1 100644
--- a/lib/eal/windows/include/unistd.h
+++ b/lib/eal/windows/include/unistd.h
@@ -23,4 +23,11 @@
 #define STDERR_FILENO _fileno(stderr)
 #endif
 
+/* Mode values for the _access() function.  */
+#ifndef F_OK
+#define	F_OK		0	/* test for existence of file */
+#define	W_OK		0x02	/* test for write permission */
+#define	R_OK		0x04	/* test for read permission */
+#endif
+
 #endif /* _UNISTD_H_ */
-- 
2.51.0

