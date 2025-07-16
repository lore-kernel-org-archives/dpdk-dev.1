Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D751CC83F1B
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Jul 2025 08:42:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 11A404021E;
	Wed, 16 Jul 2025 10:42:23 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id B6B1C4013F
 for <dev@dpdk.org>; Wed, 16 Jul 2025 10:42:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752655341;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6M1tj/USdU64J0DRTlsN9jIhXaHRSCd7Oqx3VH1MQm4=;
 b=awPruDQ2VaDRLPg5Epc4AaZGFg1Fh9RueOphL9PQmLkBr56Dbg4rnjIsPdyW8Z1kEywg1O
 aVtTRi2G4TIY25OmZ9i6BEC2DVwvB6sWTDH18NEVh3f0BamXKXaxMUVKZ15Drcfa9RrPRS
 vtDmbFwN9u4AqOB1MzqEOlZ1IlZECZ4=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-203-0M2enHjbMtyep40iL68--A-1; Wed, 16 Jul 2025 04:42:19 -0400
X-MC-Unique: 0M2enHjbMtyep40iL68--A-1
X-Mimecast-MFC-AGG-ID: 0M2enHjbMtyep40iL68--A_1752655338
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-553af0e0247so379395e87.0
 for <dev@dpdk.org>; Wed, 16 Jul 2025 01:42:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752655337; x=1753260137;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6M1tj/USdU64J0DRTlsN9jIhXaHRSCd7Oqx3VH1MQm4=;
 b=ZWgn72ojv9iHIj6Yay7sXPAyMEpoR9AhNIGpllgMWSK98ZCMDjGdw6MV8NnFkEwHo6
 xLTOtTd7MN/Lxs7jpDFzUAVC7cx4P3mUoDucYKP0WRfoof84im5uSv3+fzu2bENTFoZ3
 TKzGeDTwq7kmL+KwpgfXOX/SqksuBUNua/CSbro1jJe2FvRwi2LWecGvT3USnoUHDBT8
 /KEZd6tbvBavunxYNPqV8cFp3epbMVc+9hlbKzQlhYyMU1GiyMtcVJ/CUOcmnnSavuMB
 OSLrMsC99Z64vaij/d2KizPS3w6T+WWX+a9bBx2m7JpSa6sDzY6LsicACARm/9k6k4hG
 /M2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVVjEtAz8V16jFeFqdveGOVpyM3VwO5kUzBjjPG4m6GNoskBDWpvhaQjWkI5tuY+lAdwb8=@dpdk.org
X-Gm-Message-State: AOJu0YzXkWOttA0fVy+rx4bCjcHRX0n9bBMdin4CMDMaxyqAhYVIV3TN
 UqzXI6EoybEaWWhkVfBeGaVRfAbbL03U01D1Q40iUK73BYW0LSbPIGIYXXM3Q5j1yeQfrIGIAjV
 nAA9ESGErwu/tIQr7hxOtyR43GCyb3HTmQWDCMOuFoqEqMaQNKgj0GPdWdCeowF8GioWzu6XwGk
 q8jAhwHJxaxa+v6VeFAAo=
X-Gm-Gg: ASbGncurwyN2YjvWV6n+5yeB+mNounTUKr8sRgrnWOz7xv4CFlET2G8rJfDabWon7OU
 Zxn/EIkHB5s4uYoPhIjXd4h+3J6FgzGSO9ESw0Pi96diDsacvt1hxIBxb4Axtx034DeUU6xW/nS
 XBNMGA6QvDblrufhQgXiz49cg=
X-Received: by 2002:a05:6512:2390:b0:552:20e1:5b97 with SMTP id
 2adb3069b0e04-55a238808ecmr744055e87.18.1752655337516; 
 Wed, 16 Jul 2025 01:42:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEdNNBa7wjDd4i2gZ427ISZuRpLh3Br8mTPwCWKvbHbK5WkC6Xu6R4vn6JTxHt742h8Np4bgOLGk/eQZz+wO5g=
X-Received: by 2002:a05:6512:2390:b0:552:20e1:5b97 with SMTP id
 2adb3069b0e04-55a238808ecmr744040e87.18.1752655336884; Wed, 16 Jul 2025
 01:42:16 -0700 (PDT)
MIME-Version: 1.0
References: <20250715034152.7020-14-liujie5@linkdatatechnology.com>
 <20250716082930.83026-1-liujie5@linkdatatechnology.com>
In-Reply-To: <20250716082930.83026-1-liujie5@linkdatatechnology.com>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 16 Jul 2025 10:42:05 +0200
X-Gm-Features: Ac12FXz_igHk1NyMyWpYZW5vIGfHjXIZ7vWXyr5pmvBv013Ran5qa17pp6SIdX0
Message-ID: <CAJFAV8w+43hFaBJW8ejeF8C7gnXfJUoY5R-i6xUpvzD5cCCufg@mail.gmail.com>
Subject: Re: [PATCH v9 01/14] net/sxe: add base driver directory and doc
To: Jie Liu <liujie5@linkdatatechnology.com>
Cc: stephen@networkplumber.org, dev@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: jtUbU8GrgzVCvfrM_ieiacyH423eT7kRgS9IjW6D8MI_1752655338
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hello,

On Wed, Jul 16, 2025 at 10:29=E2=80=AFAM Jie Liu <liujie5@linkdatatechnolog=
y.com> wrote:
>
> Adding a minimum maintainable directory structure for the
> network driver and request maintenance of the sxe driver.
>
> Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>

- Such a big series deserves a cover letter, with annotations/tracking
of the changes across the revisions.


- I did not look in detail but I noticed a .map file.
Driver specific API should be avoided as much as possible.

But if it is really necessary, please look at the recent changes wrt
symbol exports since .map are not used anymore.
Example of a conversion:
$ git diff v25.03 -- drivers/baseband/acc/
diff --git a/drivers/baseband/acc/rte_acc100_pmd.c
b/drivers/baseband/acc/rte_acc100_pmd.c
index d33e42c807..b7f02f56e1 100644
--- a/drivers/baseband/acc/rte_acc100_pmd.c
+++ b/drivers/baseband/acc/rte_acc100_pmd.c
@@ -4,6 +4,7 @@

 #include <unistd.h>

+#include <eal_export.h>
 #include <rte_common.h>
 #include <rte_log.h>
 #include <dev_driver.h>
@@ -4635,6 +4636,7 @@ acc100_configure(const char *dev_name, struct
rte_acc_conf *conf)
        return 0;
 }

+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_acc_configure, 22.11)
 int
 rte_acc_configure(const char *dev_name, struct rte_acc_conf *conf)
 {
diff --git a/drivers/baseband/acc/version.map b/drivers/baseband/acc/versio=
n.map
deleted file mode 100644
index 3f427caf67..0000000000
--- a/drivers/baseband/acc/version.map
+++ /dev/null
@@ -1,10 +0,0 @@
-DPDK_25 {
-       local: *;
-};
-
-EXPERIMENTAL {
-       global:
-
-       # added in 22.11
-       rte_acc_configure;
-};



--=20
David Marchand

