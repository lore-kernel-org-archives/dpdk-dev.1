Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99528C28B2F
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Mar 2025 11:54:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 870E1402CE;
	Wed, 12 Mar 2025 12:54:12 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id F0E7040265
 for <dev@dpdk.org>; Wed, 12 Mar 2025 12:54:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741780450;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+LUASQ8RWDMdmURda6u4o1aFVwVJlrKcz5+z8YFrkYM=;
 b=U0aO/32jT1wexIsqfUKQhQLOXGA/Jqkt7cjxM5V9cpVRt1ah6P+05RaD/MpTfEf+jB6df5
 k8F+aO8UelZ/3iNBv3aHdG4cxkuia20gyUCZOhTs8+AwW2lKZm/a1aoh/mZVYvbuSqgbFQ
 jC0xdCu7lEzC99oo5NTUic3hStp8JYw=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-JZA6zvySPI6iIGZzW5eb3A-1; Wed, 12 Mar 2025 07:54:09 -0400
X-MC-Unique: JZA6zvySPI6iIGZzW5eb3A-1
X-Mimecast-MFC-AGG-ID: JZA6zvySPI6iIGZzW5eb3A_1741780448
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-549adfc38d8so832468e87.1
 for <dev@dpdk.org>; Wed, 12 Mar 2025 04:54:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741780448; x=1742385248;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+LUASQ8RWDMdmURda6u4o1aFVwVJlrKcz5+z8YFrkYM=;
 b=a5KPYE5cSqrnuOKY2FJOEpkvecCLYi5mP55dhcxQmoKF2/1msuDbDqXh/0Sd3toXcO
 l8Y0ZyzXVFozNIm0v43AI1WAr6CCTqpTa6i331kJKK9sxlx7hRSZIn8S+Qd26IFXbZtr
 qebxLimh+AE58TlZebsj/lpNKESVUiq2D6xto+D6Gum1YDzG94enQqPNGOttwZfeDkDj
 pxEoqbYNQy+tm2gLcSOy37pvlLqZLwyZLo4/oZuThApLBrgD8W7m1dl5NBBAcOpTo3m0
 jBfbsPjwYmXITd3Y8de3vj1Y9Fdy9gnajSCqmXAE41OLQgm75b3Tz+dMQO2gwNhZMl7E
 DJ6Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQmQo05lY+PQ4YOGsAZtawNNm00i///KCi8KX0TEeHCiq4OV/hQyF1PN1DaKS2XSf9Als=@dpdk.org
X-Gm-Message-State: AOJu0YzpmEneCIuNFBw84KLI72QVEzLu2cbqzGOZPCtXHkiKlYrm0NvF
 UJkg6Z2HMDVN1veLrZJ3Zkp6k3XA6arrtRoYn0MJG74vsBi8xis+iFj8vxeqH56vCOYaLWJE3Bp
 VncT7YiKlQQ8rL1rS50DsVA99ZUL13+VP5yVcC5HbAGAYB9nCKZ/mY6qG6WCZVbAywRUGB17dHf
 XPul+qoz60vwx+uGQ=
X-Gm-Gg: ASbGncuI9iACnWLw8wfcfAjR3n7aiLes6dhGTSyIsp3CvquvglJ5kh3tMO0X78Yggqx
 wxFXuc5x4E3CZQJ1D/kpNEkwOztuVeNrzfe+6HfTc8cswKBN0WgBBt0CWD1+Q18/rZBQ7MrAqrw
 k=
X-Received: by 2002:a05:6512:10c3:b0:549:8f10:ec25 with SMTP id
 2adb3069b0e04-549abacca12mr2974767e87.31.1741780447670; 
 Wed, 12 Mar 2025 04:54:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/FgvDDF2853Cz7Y4CWVu3jOqOsIK01bQFJ3Ej+LFWHHPhuiFOYkJ0niRdm7XE0WwllZllBm0gbzObZ6qD98o=
X-Received: by 2002:a05:6512:10c3:b0:549:8f10:ec25 with SMTP id
 2adb3069b0e04-549abacca12mr2974755e87.31.1741780447289; Wed, 12 Mar 2025
 04:54:07 -0700 (PDT)
MIME-Version: 1.0
References: <1741744388-2290-1-git-send-email-andremue@linux.microsoft.com>
In-Reply-To: <1741744388-2290-1-git-send-email-andremue@linux.microsoft.com>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 12 Mar 2025 12:53:55 +0100
X-Gm-Features: AQ5f1Jr4nIc4Tvah66eC5TjC4exagvHgPLfuWoozNnCuNRS73XxmpuL44yLadjo
Message-ID: <CAJFAV8yMS4Mq3RD4+9+LdhibVhFfwyZU+F3Z=2+auQu+nYVAMA@mail.gmail.com>
Subject: Re: [PATCH] buildtools: remove invalid option for Microsoft linker
To: Andre Muezerie <andremue@linux.microsoft.com>
Cc: Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>, dev@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: wS3ooPbU1ybSmhWJ5jDrVAIdUhM_uywmYFlCrTZ2PNc_1741780448
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

On Wed, Mar 12, 2025 at 2:53=E2=80=AFAM Andre Muezerie
<andremue@linux.microsoft.com> wrote:
>
> When compiling "drivers" directory with MSVC the errors below popped up:
>
> drivers/rte_mempool_stack.pmd.c(1): error C2143: syntax error:
>     missing ')' before '('
> drivers/rte_mempool_stack.pmd.c(1): error C2059: syntax error: ')'
> drivers/rte_mempool_stack.pmd.c(1): error C2059: syntax error: ')'
> drivers/rte_mempool_stack.pmd.c(1): error C2143: syntax error:
>     missing ')' before 'const'
> drivers/rte_mempool_stack.pmd.c(1): error C2091: function returns functio=
n
>
> The fix is to use common macros compatible with MSVC.
>
> Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>

Out of curiosity, did you try dpdk-pmdinfo.py on generated binaries?


--=20
David Marchand

