Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC0ECC624A5
	for <dpdk-dev@archiver.kernel.org>; Mon, 31 Aug 2026 07:51:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0DC6F4025A;
	Mon, 31 Aug 2026 09:51:57 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 985C0400D5
 for <dev@dpdk.org>; Mon, 31 Aug 2026 09:51:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788162715;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dGyxPJZwsCFoXXiQ+XI3hZhxH7vVasjuN3NE2F9d18k=;
 b=K3sm8kAvAsqzgpqDOLzZRjkWKd6El6oHb75zZr4ETGFvOLROz3aOUz4J0UBFNRTbMZsw1R
 Q57xdQAbnjXBy2fbxgiZmO2ByMo2MFJC6y96XHJbMK1YdxeBXZrBQCgIUgDJurrVQ/W8Bq
 O/02kx1MbnbYmlnxREGTAT2VHdXJgdw=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-235-SSERJBkAMaCDHy3Zz9XvNw-1; Mon, 31 Aug 2026 03:51:53 -0400
X-MC-Unique: SSERJBkAMaCDHy3Zz9XvNw-1
X-Mimecast-MFC-AGG-ID: SSERJBkAMaCDHy3Zz9XvNw_1788162712
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-3a10378df3bso16581301fa.1
 for <dev@dpdk.org>; Mon, 31 Aug 2026 00:51:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788162712; x=1788767512;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=dGyxPJZwsCFoXXiQ+XI3hZhxH7vVasjuN3NE2F9d18k=;
 b=d8KcUpsbgf/ogOCwvtMhikgN37And2Kz1h+UQlFm2tDAl2MB65K4vy/X4LOOuKuUwh
 q9OxwWXgL7pmch2/z0HFpte1OL3NpmGzz/b2d0KTPpqDiTs/Bzmr6pFYvWSgnKUDfZm0
 eu9MdgHx3tT1x7TTIxNImPbfQTdifYqRL+8UEYJwheEX+jwmkI543RsSlueIQbpqa0gt
 zeswfCbDtaP9XgnvyqW3IVX8du982NyzWfQ6xHbN7cT8qN+AbGb4JcPnhQad+JLbT0RB
 zc6YDeVI4rJUuRCYRPFUddSDC+DQeWHe0rwve8VQ8Cdv+0QGSpAMLmo9rlI9UIqJlImK
 tJrw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxOPtLaMxIeCr12hg+Wp7K4Q9ejuy0kFT3RirtdgPy57dCmIzz9bGJyCJJ+al14VLzMUYw=@dpdk.org
X-Gm-Message-State: AFuF++mPTF4xxrk4KL1osHnV95gb1qSbv+AcWcb41iUJaC783cOJVJlN
 mOckoiuF3oSECmJ5lRSJTQSAduKbPih/8Vnp+bKkn0RXuY26xAyorSX8pP96ykRplfZPwtDkuKE
 fTjrX5wXpRik2ghC+A2KOFBhIeD1LRqyZjoGQJdvuWI3r21I98mOzLwvHUFKcfcH4MJY3p6ThnS
 ablOf4XEibuMt1LwTKboI=
X-Gm-Gg: AYBFou0vCgevEmbjySMASwYoAqkmkp9xxkyinly4JzfN40uZDoqAfenOCIm2t3P2tqj
 Pp6N+6HILeFru9SebGK53545R1ErsW7Ilj5iqC5so573zw4HMN/2dBQAXHRDq2zn5uyQrmkDPm4
 bc2lafg8dUkKeOiL8NTo3i5/K75iI9wrca5OzfnUw63ybuxr9NwIQEqrjtokkc07d1Y9Qo3CqfW
 Yx7jw3U8aIMLiXiQI+jIcJ5oXp0ITtAY6/Off6QxsMcdfUX
X-Received: by 2002:ac2:5693:0:b0:5b2:e82b:37f5 with SMTP id
 2adb3069b0e04-5b5fa57913bmr771842e87.2.1788162711684; 
 Mon, 31 Aug 2026 00:51:51 -0700 (PDT)
X-Received: by 2002:ac2:5693:0:b0:5b2:e82b:37f5 with SMTP id
 2adb3069b0e04-5b5fa57913bmr771817e87.2.1788162711158; Mon, 31 Aug 2026
 00:51:51 -0700 (PDT)
MIME-Version: 1.0
References: <OSZPR01MB8612B5D71DC37D3A5F2D428DE0AC2@OSZPR01MB8612.jpnprd01.prod.outlook.com>
In-Reply-To: <OSZPR01MB8612B5D71DC37D3A5F2D428DE0AC2@OSZPR01MB8612.jpnprd01.prod.outlook.com>
From: David Marchand <david.marchand@redhat.com>
Date: Mon, 31 Aug 2026 09:51:38 +0200
X-Gm-Features: AcwNN1XBTiVqHjaGkOA1iDDO2bialP26-4NdOSPO22URvOtwbS74srw2K1KmT30
Message-ID: <CAJFAV8zN6KcnH59vrH4HQVBRpjbdLLMopz+ZSDPYqr+-DdYeLQ@mail.gmail.com>
Subject: Re: [PATCH] eal/x86: fix LZCNT CPU feature bit
To: Yonghao Li <cruselee1@live.cn>, bruce.richardson@intel.com
Cc: thomas@monjalon.net, konstantin.ananyev@huawei.com, dev@dpdk.org, 
 stable@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: j2VveGp5eVZRb2r7xHSldqTUa1Qj15Fjy7y0XoTW-f8_1788162712
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

On Fri, 28 Aug 2026 at 22:33, Yonghao Li <cruselee1@live.cn> wrote:
>
> LZCNT support is enumerated by CPUID.80000001H:ECX[5]. The current
> definition checks ECX bit 4, which identifies CR8 legacy mode on AMD
> processors and is reserved on Intel processors. As a result,
> RTE_CPUFLAG_LZCNT can be reported incorrectly.
>
> Check ECX bit 5 instead.
>
> Fixes: af75078fece3 ("first public release")
> Cc: stable@dpdk.org
> Signed-off-by: Yonghao Li <cruselee1@live.cn>

This looks correct to me.
Acked-by: David Marchand <david.marchand@redhat.com>

Bruce, can I use a second pair of eyes?


-- 
David Marchand

