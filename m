Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57C16C83F27
	for <dpdk-dev@archiver.kernel.org>; Tue, 22 Jul 2025 14:31:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AD74740661;
	Tue, 22 Jul 2025 16:31:15 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 129E940667
 for <dev@dpdk.org>; Tue, 22 Jul 2025 16:31:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753194673;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ngcsAuogk1AkLCzDvzKFdhqFHB4qtJ9WG01BFoFgM6A=;
 b=IwSrInHSC9lhSEWMcHnX78U0l2ExGasbXQV3QrI6dIgQkKUOhS90w6S6k8BR3wFfWGxgFY
 1TXK1c4Fcnm//CJWUUuGuEuPd8dQd+unQ05cvomUBqkOCl3vHFwxLiQtcVUJ3d9hWV1Ui+
 mvy3rfnHqQqJdz9Yg0WTKhFUH7im1DA=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-387-GiVKyCxTNem35dRQHEeQJg-1; Tue, 22 Jul 2025 10:31:12 -0400
X-MC-Unique: GiVKyCxTNem35dRQHEeQJg-1
X-Mimecast-MFC-AGG-ID: GiVKyCxTNem35dRQHEeQJg_1753194670
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-553ea44a706so2841127e87.0
 for <dev@dpdk.org>; Tue, 22 Jul 2025 07:31:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753194670; x=1753799470;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ngcsAuogk1AkLCzDvzKFdhqFHB4qtJ9WG01BFoFgM6A=;
 b=PknIpDV+97ZX5vJ1UEzk6WtLFlNAVMjVh/kn/KwxQ7Yh5LstMy+042yxkSTYZJGLt6
 L2pUpXupF5VV/ig+ah6Aal1/HSnsuM7+lhX7teXXFns4VijsKJflfPyrhmS3IUkBuZOR
 e5vcBKgJXlOX5GnXkxPIrLc9wiMyC9XeFAyGSv10yLa0dHe2rB5+RZB4iXBVBqr+nEu7
 QXxz1ChmGaDmV1C1MSnA/rk0AtDb1sox1dthXJajuvoPwdNKERn87UR+fo5fAkyIv6Dm
 hRbjBubGjJcUakCESSmTqT1hl8UEBDJaG1SglS4mxVd2TcjeACInwDL5+A4MqH/alkle
 NdHA==
X-Gm-Message-State: AOJu0Yw7Ynl+u1KyNBSPjUIeaSIdRVx7hEPApdbR1fFgxsb1ToLU+7HM
 IZiEN4FwVgdjctZnZpX4vB5UTF9qzn/7PT9EPszxAZLQ4Axb7BOpcEL/yod/km+ONem0gg/IKAw
 IFFpJ0DNuwoy/HUzzw+WJKJRcISyk2ysf3TRC67xdcJfD6IV9c8D6zYlJGFmAvrzTrZPXJ8eiKB
 O+oXWHN5V6+4wSFz5fZf2Sv3tjb/EppQ==
X-Gm-Gg: ASbGncvrl4alPxaEsOomNSFymFUISU0Y6cisorg75o215AWkxQdbpVq8/hTVXtA87Qg
 RHVJaaq5jkRIXG/kMoXrraYmnvQCja/hh0kl3MAcXaQ8k9aA/Dto26h0yrOZTNIIGtrHq8yEuXZ
 Xw7J38o8tXsdM7txFYERXL/Bw=
X-Received: by 2002:a05:6512:3a87:b0:553:2c65:f1ca with SMTP id
 2adb3069b0e04-55a23ef7ce7mr7691127e87.19.1753194669663; 
 Tue, 22 Jul 2025 07:31:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGhiOLWVqr+9xawmK/FAqvHeV2iQP7Ec9oznjtURurjIsnvZhpCSiYD+5UUVnvTZQ07lqfEMGczF3zODmE+aqw=
X-Received: by 2002:a05:6512:3a87:b0:553:2c65:f1ca with SMTP id
 2adb3069b0e04-55a23ef7ce7mr7691117e87.19.1753194669133; Tue, 22 Jul 2025
 07:31:09 -0700 (PDT)
MIME-Version: 1.0
References: <1747401734-6303-1-git-send-email-andremue@linux.microsoft.com>
 <1753130343-29500-1-git-send-email-andremue@linux.microsoft.com>
 <1753130343-29500-2-git-send-email-andremue@linux.microsoft.com>
In-Reply-To: <1753130343-29500-2-git-send-email-andremue@linux.microsoft.com>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 22 Jul 2025 16:30:57 +0200
X-Gm-Features: Ac12FXycr-roEwfaoaAzkpaRbzDrV2QM9JQhHhTRNDYD-4kSLKsNx95eRs7Ybfw
Message-ID: <CAJFAV8x4qO9-y+0C_PoJsw0eYmVcPs+CzpfPBvD0=opC7KQ-2w@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] test/strsep: add tests for function strsep()
To: Andre Muezerie <andremue@linux.microsoft.com>
Cc: dev@dpdk.org, dmitry.kozliuk@gmail.com, roretzla@linux.microsoft.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: v1AkuKqXKDrtD1IOUx-KTrviHw6DY5dMztyJbNUIgwY_1753194670
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

Hello Andre,

On Mon, Jul 21, 2025 at 10:39=E2=80=AFPM Andre Muezerie
<andremue@linux.microsoft.com> wrote:
> diff --git a/app/test/test_strsep.c b/app/test/test_strsep.c
> new file mode 100644
> index 0000000000..19df8f31ee
> --- /dev/null
> +++ b/app/test/test_strsep.c
> @@ -0,0 +1,108 @@
> +/* SPDX-License-Identifier: BSD-3-Clause
> + * Copyright (C) 2025 Microsoft Corporation
> + */
> +
> +#include <string.h>
> +#include <rte_os_shim.h>
> +
> +#include "test.h"
> +
> +static int
> +test_strsep_helper(const char *str, const char *delim,
> +                  const char * const expected_tokens[], size_t expected_=
tokens_count)
> +{
> +       char *s =3D str !=3D NULL ? strdup(str) : NULL;
> +       const char *token;
> +       for (size_t i =3D 0; i < expected_tokens_count; i++) {
> +               token =3D strsep(&s, delim);

The reference to the dupped string gets lost, since calling strsep updates =
s.
Caught by ASan:

=3D=3D49990=3D=3DERROR: LeakSanitizer: detected memory leaks

Direct leak of 51 byte(s) in 4 object(s) allocated from:
    #0 0x5632dd8cbe83 in strdup
(/home/runner/work/dpdk/dpdk/build/app/dpdk-test+0x271e83) (BuildId:
01a7571ab7814bc83923733b3dae34d28e6ff3e1)
    #1 0x5632de39bad2 in test_strsep_helper
/home/runner/work/dpdk/dpdk/build/../app/test/test_strsep.c:14:26
    #2 0x5632dd91d86f in unit_test_suite_runner
/home/runner/work/dpdk/dpdk/build/../app/test/test.c:364:20
    #3 0x5632dd91c2b0 in cmd_autotest_parsed
/home/runner/work/dpdk/dpdk/build/../app/test/commands.c:68:10
    #4 0x7fba8b3bfc58 in __cmdline_parse
/home/runner/work/dpdk/dpdk/build/../lib/cmdline/cmdline_parse.c:296:3
    #5 0x7fba8b3bfc58 in cmdline_parse
/home/runner/work/dpdk/dpdk/build/../lib/cmdline/cmdline_parse.c:305:9
    #6 0x7fba8b3bcbf7 in cmdline_valid_buffer
/home/runner/work/dpdk/dpdk/build/../lib/cmdline/cmdline.c:25:8
    #7 0x7fba8b3c50ec in rdline_char_in
/home/runner/work/dpdk/dpdk/build/../lib/cmdline/cmdline_rdline.c:456:5
    #8 0x7fba8b3bcfde in cmdline_in
/home/runner/work/dpdk/dpdk/build/../lib/cmdline/cmdline.c:154:9
    #9 0x5632dd91d2ba in main
/home/runner/work/dpdk/dpdk/build/../app/test/test.c:231:15
    #10 0x7fba89a29d8f in __libc_start_call_main
csu/../sysdeps/nptl/libc_start_call_main.h:58:16

SUMMARY: AddressSanitizer: 51 byte(s) leaked in 4 allocation(s).
---------------------------------------------------------------------------=
---


--=20
David Marchand

