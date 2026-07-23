Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4354FC44524
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Jul 2026 08:32:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BEA514028A;
	Thu, 23 Jul 2026 10:32:07 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id C27BC4027C
 for <dev@dpdk.org>; Thu, 23 Jul 2026 10:32:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784795525;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=E8M2vWuBmGAReo7yiZ5dxzy4AHq2fOwWv2ECyK3Wrr0=;
 b=U6cVffWA3ip5w00n8XNG1zmF1aigarW0//gYeC6cHkdus800XArcqP5C32pRAz88CRX80m
 OY6b0vsybRUiBaFFJatTj4wdqrvLiy1k9S0u6vTnhRNkaSCY3PcU7UppNc5x9jyHU7mgk4
 JRHpydkGFpC5y9TeZ+izPDYxBU3ZFeE=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-Rpqa2HMjMnmswLTzE-zB9g-1; Thu, 23 Jul 2026 04:32:03 -0400
X-MC-Unique: Rpqa2HMjMnmswLTzE-zB9g-1
X-Mimecast-MFC-AGG-ID: Rpqa2HMjMnmswLTzE-zB9g_1784795522
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-5aeba7dc09cso271166e87.1
 for <dev@dpdk.org>; Thu, 23 Jul 2026 01:32:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784795522; x=1785400322;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=E8M2vWuBmGAReo7yiZ5dxzy4AHq2fOwWv2ECyK3Wrr0=;
 b=QIG+YfLIcwMqF5cjtA2mjGFvt4qgzjhkYVV1804j8y5KwN4jQxYdsr4+6XixIP4xQm
 8w3BLuXne3c2t4UFUHMtORidfuqMBo/+yqyDNoKWx8f4hmrM7+9X65W7iGV8tRdTt9fx
 7nAk88lwo/GuiqzrJSxkbpsLb7Fr/6uVQCo0nRFRwt7LBTh6yU9Ezg7GsmExqv9+r2wd
 9rqsND9KeXWSTJZ6LjGNSQtZ1dlo7AofAuOI6kFA0WRHWOjadMBKHDqux1W7OBk/LPYU
 kgJrPPV2FZTJI2PMHLKO/vuZZ+2h4tm5M4f+rHYKKFxdjtljO+RZ/jP0LQV7n+fnnVvl
 /TAA==
X-Forwarded-Encrypted: i=1;
 AHgh+RprBdhHKeXhM6XReGbbWq5ee3SvqQebVNrQwo6u0/eBfC1gIxRuGsR/uyJaLad/so3PJzI=@dpdk.org
X-Gm-Message-State: AOJu0YznLS1ybn6nNWPsgiF7xoTMDvUeP2wpVkYBWW9ixvxsMWN5WOVW
 cDLu1JOolAm50PP5q5yfW/toHXipEei8Yn49kQA3b3huJ4Oj+1nK+ZiC0lF1BOKwGB+nE59XV4Z
 Y6NS/+5Wah7zqbpFvyzN00rrsZMqPYkiZxT06ZF3IluXfuOjiwm9B5IgDUNS7166CpuwRKnx3T8
 wQx7Bu88z5Ck2rcJrQvFY=
X-Gm-Gg: AR+sD1263aI2P65n8dhJxAHr89E5YYsah/j8Z7cciEej29EK/xw3sQPW0p0kQcVMudf
 X6tuzl0rmIL8WEGPA+5ma4D6aBERqH4XwEAiS7R8qmYIeNoWqU7l3ApBy1+dUC+2C2BPpsim8Ah
 AW3sCtiqOHxxrxClmWV4O5fJZfdU0nqIe6x0lPuULa0oqsKyXbwyDT9XzU3qH4wgblwsVrD2WUI
 8EslHJkMOk4ykMN4DF05YD66K0iGE2Z4j77vCIgxOGBk7O5
X-Received: by 2002:a05:6512:118a:b0:5b0:172f:2ef3 with SMTP id
 2adb3069b0e04-5b2b2f6aa60mr515027e87.38.1784795521989; 
 Thu, 23 Jul 2026 01:32:01 -0700 (PDT)
X-Received: by 2002:a05:6512:118a:b0:5b0:172f:2ef3 with SMTP id
 2adb3069b0e04-5b2b2f6aa60mr515016e87.38.1784795521464; Thu, 23 Jul 2026
 01:32:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260713105935.24152-1-dsosnowski@nvidia.com>
In-Reply-To: <20260713105935.24152-1-dsosnowski@nvidia.com>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 23 Jul 2026 10:31:48 +0200
X-Gm-Features: AUfX_mx23MozcjhHM0EysW7WTV8A1wC_Io-fTLv8wu8XNLfW9NUwwS8T4Pzl6SQ
Message-ID: <CAJFAV8yNeZiiBrOn4Uei=Yg_T2he9p88jeizAh+3_ucqnRt_dQ@mail.gmail.com>
Subject: Re: [PATCH 26.11] ethdev: remove flow metadata symbol aliases
To: Dariusz Sosnowski <dsosnowski@nvidia.com>
Cc: Thomas Monjalon <thomas@monjalon.net>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>, 
 Ori Kam <orika@nvidia.com>, dev@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 9cA6k-cZCuUzjFktWs75d-DgFBbRqZ7LrpT1cR-NWjE_1784795522
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

On Mon, 13 Jul 2026 at 13:00, Dariusz Sosnowski <dsosnowski@nvidia.com> wrote:
>
> Version aliases for rte_flow_dynf_metadata_register
> and EXPERIMENTAL version on rte_flow_dynf_metadata_offs
> and rte_flow_dynf_metadata_mask symbols added in [1]
> are not needed after ABI version bump.
> This patch removes them.
>
> [1]: 56045d198968 ("ethdev: add aliases for flow metadata symbols")
>
> Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>

Acked-by: David Marchand <david.marchand@redhat.com>


-- 
David Marchand

