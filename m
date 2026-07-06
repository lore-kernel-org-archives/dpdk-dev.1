Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAA90C43458
	for <dpdk-dev@archiver.kernel.org>; Mon,  6 Jul 2026 11:04:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EA06C402C3;
	Mon,  6 Jul 2026 13:04:09 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id AF93D4027B
 for <dev@dpdk.org>; Mon,  6 Jul 2026 13:04:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783335848;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qREtW7BfBcNzc6J9jU3VUwBmvwhZYBZvLF8VsvYs72g=;
 b=W41Ul00hICDSgLWbW8yEywWz0ItG5MY0iwsaaKeHwvXlI5jcD6LhR0h84spkfnLU7pxdz8
 il6blAD3KkomZlKFSNqSHMeCgSAoAJqjcoMWtHSMt54S6D2hDzMKnwcV/Nuf11GUwXqJX+
 zV39UEMNbOulRzTEHrx9qFVmQdi9UV4=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-TabdS_jmMKSUiJ9Ap7-b9A-1; Mon, 06 Jul 2026 07:04:06 -0400
X-MC-Unique: TabdS_jmMKSUiJ9Ap7-b9A-1
X-Mimecast-MFC-AGG-ID: TabdS_jmMKSUiJ9Ap7-b9A_1783335845
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-5aeba222aa2so1816319e87.1
 for <dev@dpdk.org>; Mon, 06 Jul 2026 04:04:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783335845; x=1783940645;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=qREtW7BfBcNzc6J9jU3VUwBmvwhZYBZvLF8VsvYs72g=;
 b=TFNRKWv7cEpkYvajaL0tpW2EE/oivPlhaFr85Ki0kMxVoPFOK37u6pEY8ZV+XlWxXL
 XfM96/168HnZ3OlxdWUnD4XesvGqtYWeL9lUm8JOvUEZZGx6T1f65sg6/40rsLTm+Dw8
 l5iWI2Ib7sUSx/P72kgmIiLQNrzd7ESWRwGKOnsEWemRByL3LFn2zrFyO4vaW/eN3n7t
 G0SdfPyrIVihXKBOObiGLus4ZdOQ0Qa1HQAJrn39utLfGkbv8Iw03G6fi2Aml1JJeG9V
 bufM7SxIwUo+U2QNTlH2WwdEmuAHtzLyNxF0k3zEoZH26NQjd52yOTn7rcP2VfDZyufV
 oTMA==
X-Gm-Message-State: AOJu0YwPVdAVGtJuHv9pyYzqO1a7Twr//WkxA0CDMSvAvMXopxhGt2gM
 +Gv498OYm1WpoEYksENYW7j4vwZ1BkvgU0BsswSDOS2+mJyvBQaVHobpKKmG2SH+01JUlE9JTbr
 Tnc73/J07A88iQYGNe37oU84wPxHcriQwRjscqaVdhdAVzSZU6vEo7Fmr4Khrj2ZcgwXfEkBXbu
 4Fkg2sXWBEpXuQi1NsnpM=
X-Gm-Gg: AfdE7cmw0Qh8A4bvmNFTAFX/Kd0ruVibH7fvJOJF8SnY1LjmAuk6q21eLDUUU5Cpydm
 pnphCOX53eB5t4YvncIdzde+eUFSWgedBi3jAE03jiXBirCTTMP/w/iTO3p3eAItFr/1XNDhRVB
 v1rx2iUv47mtg5CkMFE6C6y+PZXIDlL+utaFmZzdDIMxgkR+ZyOSxsFh4NZ1HLRHq+p8lqSGVhW
 7iPJNGQ7lYxyxx4jlZE5rdkaJXB+XobYrNTO9ZgswR79z7e2tGbbVbU1OY=
X-Received: by 2002:a05:6512:252a:b0:5aa:6290:f78d with SMTP id
 2adb3069b0e04-5aed508f4c7mr1738466e87.2.1783335845064; 
 Mon, 06 Jul 2026 04:04:05 -0700 (PDT)
X-Received: by 2002:a05:6512:252a:b0:5aa:6290:f78d with SMTP id
 2adb3069b0e04-5aed508f4c7mr1738453e87.2.1783335844584; Mon, 06 Jul 2026
 04:04:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260703144931.2541180-1-radu.nicolau@intel.com>
 <20260706095746.2586714-2-radu.nicolau@intel.com>
In-Reply-To: <20260706095746.2586714-2-radu.nicolau@intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Mon, 6 Jul 2026 13:03:53 +0200
X-Gm-Features: AVVi8CeD2i-HIQ3PSS0O0vUXXXF9WPKCgMQYxFbu2ZqZs26JQK_IEpyIPZ73g8U
Message-ID: <CAJFAV8xA2ia56Wd7cRo0zzh-=N3onaK1pMFwpThsXpSauZwS8Q@mail.gmail.com>
Subject: Re: [PATCH v2] crypto/virtio: cookies are allocated from mempool
To: Radu Nicolau <radu.nicolau@intel.com>
Cc: dev@dpdk.org, maxime.coquelin@redhat.com, jianjay.zhou@huawei.com, 
 Yu Jiang <yux.jiang@intel.com>, Fan Zhang <fanzhang.oss@gmail.com>, 
 Akhil Goyal <gakhil@marvell.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: NKUPVeVeRwfvtyMXZWvmMFoL41pT19cDdbiQDp_pxMM_1783335845
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

On Mon, 6 Jul 2026 at 11:58, Radu Nicolau <radu.nicolau@intel.com> wrote:
>
> The Rx/Tx functions allocate cookies as needed, no need to
> allocate and free from heap.
>
> Fixes: 6f0175ff53e0 ("crypto/virtio: support basic PMD ops")
> Cc: jianjay.zhou@huawei.com
>
> Signed-off-by: Radu Nicolau <radu.nicolau@intel.com>
> Tested-by: Yu Jiang <yux.jiang@intel.com>

Reviewed-by: David Marchand <david.marchand@redhat.com>


-- 
David Marchand

