Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 678F8FED9E4
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Mar 2026 15:11:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 84CDE402B0;
	Tue, 17 Mar 2026 16:11:06 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 15D1540270
 for <dev@dpdk.org>; Tue, 17 Mar 2026 16:11:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773760264;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mS3P8WOMXegRXEHzSvbYYi1TBpN05/5yDp57EHmkEG0=;
 b=b5PNIScXTHfcR9xaW6+eFzsn0x8Ur3WtMPDo1O0Ww6ujuFRTaFe/QuTeJqH1ID3ynsjcIC
 bLlQfzG36XYLDe8EeJVW4YmWAR3i20m7iwNEYxg5YBwpnjuTq8yXUg6u4FpVFB/JVZvpSS
 gNPcTayPO4pEL1Od4HWKRRBTvdoDSbU=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-6I5SWnQvMnuvLULBlxu7Iw-1; Tue, 17 Mar 2026 11:11:03 -0400
X-MC-Unique: 6I5SWnQvMnuvLULBlxu7Iw-1
X-Mimecast-MFC-AGG-ID: 6I5SWnQvMnuvLULBlxu7Iw_1773760262
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-5a13b7948e0so4267055e87.0
 for <dev@dpdk.org>; Tue, 17 Mar 2026 08:11:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773760262; x=1774365062;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mS3P8WOMXegRXEHzSvbYYi1TBpN05/5yDp57EHmkEG0=;
 b=OZzx7e/3TrqzXAh5wvR0XDewfOvKUni4+G4+SKUwA5jZpORTeL32bXLYfQzLYy6KAQ
 z614Guutj3WcsfjHMZaHLpu7N5G/RU9bTzTU/5HDsgKAdKlJqpFo3GqsiDEj8RFF888H
 96G6sh7kiR9HaX7LO7LR9fowyZWRUt7njXAwnrHelk/cZJk2BG/akozCLktz4CXsJgW7
 YXjkWFXG4nsnkI4VCtw90nY4eP8gYJ4dzY6xBys29Ylf9xOLzX+xMuf8kbGEoRK98kv1
 CgX9qlvgDF/A+dL3YzBwTZ4xK+EDsohkUHTy0P4MYGxYPAx/Wq9IT4c3DojUGraqS+Xj
 Uy7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWj330x3mt39Jzikwxypt1IKYEdICYnlXlgJrNrjvwrSVFkEb5roaecnMvbcTKo8Qe4Vsg=@dpdk.org
X-Gm-Message-State: AOJu0YzfKL29y7t51vgK8cXo/AV49u8DyGmu8WpYNPpAeUruTjzdtku+
 DJO+vzfEtimg9li3lXAIt0auBFbZlzEKmPBF30ZlSogdGpRUdF/wBEn8KqkNfDLMmGE4Wfdzcnb
 t2W5VwMQtV0VhZdhFdVNaAj6SFp8c7g27oEbnrPYXAU7wsu/uUViTFD7WwVj8OlyG+AxK/+eCae
 e/p2Z+2MCS8IUXUBD835E=
X-Gm-Gg: ATEYQzxLnDS93J1ynSQIcXGnl5GrQLj8SslAwZ+zj7eG0U9uJlCO3DCPfScFuBKFGW/
 WwuN0Jn/bbOtP1G4V7qqexNpZemNA9HIVHOaqYL9KpWb1AkoIeuB8REppHJnYLX/CALAFgE/MgK
 5dT+yAhxQ/+xPwENqWN16vMA4oOsaj+6+h37E+YT+/7yHXnJiieF+GzoJH3c44ynGUfPbs8YwyW
 lZyoDkpXRV1QdtlUOKrABk7hdyGl2MCIEKNtuWvCngJRwk5TGlV5UB3woU38XQrl24KoA==
X-Received: by 2002:a05:6512:4387:b0:5a1:2efb:917f with SMTP id
 2adb3069b0e04-5a1626f498cmr5533759e87.4.1773760261638; 
 Tue, 17 Mar 2026 08:11:01 -0700 (PDT)
X-Received: by 2002:a05:6512:4387:b0:5a1:2efb:917f with SMTP id
 2adb3069b0e04-5a1626f498cmr5533742e87.4.1773760261154; Tue, 17 Mar 2026
 08:11:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260304070605.1150502-1-2022302111412@whu.edu.cn>
 <136dbc4f.5c499.19cd674e5c8.Coremail.sunyuechi@iscas.ac.cn>
In-Reply-To: <136dbc4f.5c499.19cd674e5c8.Coremail.sunyuechi@iscas.ac.cn>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 17 Mar 2026 16:10:48 +0100
X-Gm-Features: AaiRm52fVMOHlvZJCYNUTOOyOFzFqZQakQfinl48KqXvgwLeajrHbr79R7BQ2b0
Message-ID: <CAJFAV8w1wbhQPpK9PSYH4QuSjNP3_4=jh5Pu9oXdqOB5XnCDRw@mail.gmail.com>
Subject: Re: [PATCH v2] efd: lookup with RISC-V vector extension
To: P1erreCashon <2022302111412@whu.edu.cn>,
 gong-flying <gongxiaofei24@iscas.ac.cn>
Cc: Yipeng Wang <yipeng1.wang@intel.com>, 
 =?UTF-8?Q?Stanis=C5=82aw_Kardach?= <stanislaw.kardach@gmail.com>, 
 dev@dpdk.org, sunyuechi@iscas.ac.cn
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: sZowT2ZCTsGqThSzWMH5Uzc_j5AuKXSRYhullNf0IP8_1773760262
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
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

On Tue, 10 Mar 2026 at 07:35, <sunyuechi@iscas.ac.cn> wrote:
>
> ```
> #elif defined(RTE_ARCH_RISCV) && defined(RTE_RISCV_FEATURE_V)
> #include <riscv_vector.h>
> #include "rte_efd_rvv.h"
> ```
>
> rte_efd_rvv.h already includes #include <riscv_vector.h>
>
> ```
> EFD_LOOKUP_NUM,
> EFD_LOOKUP_RVV
> ```
>
> It seems that _NUM should be placed at the end?

Please look at this feedback.

Also update the SoB with a real name in the next revision (this change
on SoB is also necessary for other RISCV series that were submitted).


-- 
David Marchand

