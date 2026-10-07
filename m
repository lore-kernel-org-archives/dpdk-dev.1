Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5F1BCA600A
	for <dpdk-dev@archiver.kernel.org>; Wed,  7 Oct 2026 21:42:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3F4B742DE3;
	Wed,  7 Oct 2026 23:41:40 +0200 (CEST)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177])
 by mails.dpdk.org (Postfix) with ESMTP id 1BF7342DD6
 for <dev@dpdk.org>; Wed,  7 Oct 2026 23:41:36 +0200 (CEST)
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-2dd9ec41bc4so15827925ad.2
 for <dev@dpdk.org>; Wed, 07 Oct 2026 14:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791409294;
 x=1792014094; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uthMxDcKxBviwYYGNgzg9JmbXx2+tni+p4VV5aErxVo=;
 b=dR0zlhapCsF2bSCWG170vnAU08lpzmb8wN6SuOQNOQdEZXt4kPrXp3zvZyoBdiT6BJ
 gCVRpci+q8K1YubKTajB1enYq4Yl25RMaxiiqqvr3dwayFbFNdahY17Q8j0ct3BXLv1q
 xMUOWyuUcb5UZce63U2lNc/ae3EFdpq9UR95EOTC9VWI0NoiPJek4Z3ulJC03NnR+LMr
 8QtLNqWBjbpNHVOKnaoKq9/lsRImfxDnxiOxslhSbK7vBOobMjTr/Cki70OVvEjSfg5A
 HCbFTyRS1TXfA3h/H1xhOveAm4FKF41zd29pIh1QayMI9kr+mDv2gbGpZgH3Cy5ZNr+e
 4nqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791409294; x=1792014094;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=uthMxDcKxBviwYYGNgzg9JmbXx2+tni+p4VV5aErxVo=;
 b=rMEMfRo+l9JAMLTceDG95Oi+4CiuLB2jkfJe8SyxvtPWLn9RhfgsrMztngNr1WfkB8
 SjRI4M57cdF6WrbWQ0Dscumv5ekvdo6MhRvJTW/4url2p6tEbUH/tUatgvzeIPh6ibVv
 +34Vbw59X+vLAn4rjbALqI56nvOZRPc3e3P1cwT318tOJDyTm6XyLmkvu7YZTwKnaI/D
 TZXra2HEFk1VFChqChLtTjY03zFD9RZvYEfJm6JqvZ/WMhOZGKjL5cpiSy8of2lQFKIv
 ckVKmbp0R0OER0ZMAJI1ncQViqpCEvHKUkpLR8ybxL5tQfy0MopZMoggvczMidiid2c+
 /Bcw==
X-Gm-Message-State: AFq9FYJeBCrakVrLjCOTda/lauXusai8SLT6dBd12ljhFa3NeElNtfr9
 3J2O7SDOps2Wi0xdK0bl8f25R5WinrX3/lwm15+9pSsGGwEy9nijocjNBFG+8gm36h/2QlBraLr
 /j2POgJg=
X-Gm-Gg: AYBFou0jc2gyd4TP2VM5NM80ugYSgER/Lz/r1rO6UWF24dW67UUEXJOQwA75fbDIJgy
 aXtEOfvZfMD9eyNYdHWCpzig9CEJKQe0oILIVeFtQmOSY0qOqEqHVxNGQ+D7t2ExFCeZBJMG1sa
 af97kxr5i5CqJ2vl4KkNpysh3qI7pG6DzWhg4Im9N+8na6FwrOzuR4y7g5/lylOP0wcs3vQZIEv
 7qTBo3zx6BkmTpRx9dSxuZAZ4/NshsVvYpussg4FY9BwXJEoLGnoQO6VvSRtIkc0OQNN0sT+sZt
 RVZ0/A7al9iyyjs0zc+0yVe3XFZcU/bLv0aqOCEw6iyu36VY+xeg0nBJyRc200MDk1YtKWiWCYC
 ZXGfoUUPLKvaCEM0BUYd5sre9wuPrxcIsJdhPp55h/UJ+6T2nmlGj40RAi6cdHc5aiDLgw7muB0
 GsK64ZWYx06IIakYihip8ZqKQOfm+AOcf09RZwr3cdxmmdNB45mUKED2XnmaJ8PWU7cLH1Y0pCh
 4sHnzSYH/oC0/zQBkDJqEM5wdBjF4KomitqRD8TqRaqdg/7
X-Received: by 2002:a17:902:fda7:b0:2dd:c100:b2cc with SMTP id
 d9443c01a7336-2e6005771a9mr29001645ad.55.1791409293785; 
 Wed, 07 Oct 2026 14:41:33 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e60484ca89sm16573335ad.57.2026.10.07.14.41.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 14:41:33 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 15/20] argparse: promote API to stable
Date: Wed,  7 Oct 2026 14:39:45 -0700
Message-ID: <20261007214115.3092715-16-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261007214115.3092715-1-stephen@networkplumber.org>
References: <20261007214115.3092715-1-stephen@networkplumber.org>
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

The rte_argparse_parse() and rte_argparse_parse_type() functions were
added in 24.03 and rte_argparse_print_help() in 25.11. No prototype has
changed and they are used by the EAL option parsing as well as several
applications and examples, so the interface is settled.

This promotes the whole library, so the header no longer needs
rte_compat.h.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/rel_notes/release_26_11.rst |  2 ++
 lib/argparse/rte_argparse.c            |  6 +++---
 lib/argparse/rte_argparse.h            | 13 -------------
 3 files changed, 5 insertions(+), 16 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 5b60203afd..afe28eb754 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -221,6 +221,8 @@ API Changes
    Also, make sure to start the actual text at the margin.
    =======================================================
 
+* argparse: Promoted the whole library API from experimental to stable.
+
 * cmdline: Promoted ``cmdline_token_bool_ops`` from experimental to stable.
 
 * dispatcher: Promoted the whole library API from experimental to stable.
diff --git a/lib/argparse/rte_argparse.c b/lib/argparse/rte_argparse.c
index 88c3e7740c..a056559965 100644
--- a/lib/argparse/rte_argparse.c
+++ b/lib/argparse/rte_argparse.c
@@ -899,7 +899,7 @@ show_args_opt_help(FILE *stream, const struct rte_argparse *obj, uint32_t align)
 	}
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_argparse_print_help, 25.11)
+RTE_EXPORT_SYMBOL(rte_argparse_print_help)
 void
 rte_argparse_print_help(FILE *stream, const struct rte_argparse *obj)
 {
@@ -918,7 +918,7 @@ rte_argparse_print_help(FILE *stream, const struct rte_argparse *obj)
 		fprintf(stream, "\n");
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_argparse_parse, 24.03)
+RTE_EXPORT_SYMBOL(rte_argparse_parse)
 int
 rte_argparse_parse(const struct rte_argparse *obj, int argc, char **argv)
 {
@@ -960,7 +960,7 @@ rte_argparse_parse(const struct rte_argparse *obj, int argc, char **argv)
 	return ret;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_argparse_parse_type, 24.03)
+RTE_EXPORT_SYMBOL(rte_argparse_parse_type)
 int
 rte_argparse_parse_type(const char *str, enum rte_argparse_value_type val_type, void *val)
 {
diff --git a/lib/argparse/rte_argparse.h b/lib/argparse/rte_argparse.h
index f184c9c37d..467bd2edd8 100644
--- a/lib/argparse/rte_argparse.h
+++ b/lib/argparse/rte_argparse.h
@@ -30,7 +30,6 @@
 #include <stdint.h>
 
 #include <rte_bitops.h>
-#include <rte_compat.h>
 
 #ifdef __cplusplus
 extern "C" {
@@ -181,9 +180,6 @@ struct rte_argparse {
 #define ARGPARSE_ARG_END() { NULL }
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * Parse parameters passed until all are processed,
  * or until a "--" parameter is encountered.
  *
@@ -198,13 +194,9 @@ struct rte_argparse {
  *   number of arguments parsed (>= 0) on success.
  *   Otherwise negative error code is returned.
  */
-__rte_experimental
 int rte_argparse_parse(const struct rte_argparse *obj, int argc, char **argv);
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * Output the help text information for the given argparse object.
  *
  * @param stream
@@ -212,13 +204,9 @@ int rte_argparse_parse(const struct rte_argparse *obj, int argc, char **argv);
  * @param obj
  *   Parser object.
  */
-__rte_experimental
 void rte_argparse_print_help(FILE *stream, const struct rte_argparse *obj);
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * Parse the value from the input string based on the value type.
  *
  * @param str
@@ -231,7 +219,6 @@ void rte_argparse_print_help(FILE *stream, const struct rte_argparse *obj);
  * @return
  *   0 on success. Otherwise negative value is returned.
  */
-__rte_experimental
 int rte_argparse_parse_type(const char *str, enum rte_argparse_value_type val_type, void *val);
 
 #ifdef __cplusplus
-- 
2.53.0

