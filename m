Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2037BC5B552
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Jun 2025 10:17:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EB47042E62;
	Tue, 10 Jun 2025 12:17:18 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id A103242E5D
 for <dev@dpdk.org>; Tue, 10 Jun 2025 12:17:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749550637;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8z6KrsHSTOY96eZ1yFfxMqoa1+GKgJU18CMQ29gLbJI=;
 b=h0wa5DQThbWF0rWGe482AY4+I7Je0HeZf/boWXfMzn9c34TNAulzsbYmoUwVFIstF8ENHf
 /XGTfhzChXKFdqmJpBrj8SVhHEZhCdixtLTnoMJDO6jF+2toWGKg7+0MSR/Y7j3UQce1jn
 B/UHb3rJcb/aBTUyE0tB1qBjNx9wZ64=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-gJeVo4oEPBWUQV4hoiN6_g-1; Tue, 10 Jun 2025 06:17:16 -0400
X-MC-Unique: gJeVo4oEPBWUQV4hoiN6_g-1
X-Mimecast-MFC-AGG-ID: gJeVo4oEPBWUQV4hoiN6_g_1749550635
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3a4f6ff23ccso3234859f8f.2
 for <dev@dpdk.org>; Tue, 10 Jun 2025 03:17:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749550635; x=1750155435;
 h=in-reply-to:references:user-agent:cc:subject:to:from:message-id
 :date:content-transfer-encoding:mime-version:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8z6KrsHSTOY96eZ1yFfxMqoa1+GKgJU18CMQ29gLbJI=;
 b=f/CfpLWdQNcChxfvHGkIpABCgDjIzhqO/rCA8Trkjeci1G1lsAtTlsuVTqg9ZHwt3H
 DmsTEY5XoWVbd4gKBrPqXkCtQe07I9Ws2Rw6ZBuZUHYqErV6Hj/VLB6G616zcfO4YBm8
 VmA2xOt+W8Jh6bpFgKQ6bIcRkY/d+Go0krhPWm0fvgceLxrnLTp9i95/zmXV4B+boZLi
 h+rowFtQWwH6w5rn5+6UvdlvDywnfGXqWx/hW+dIYAW9Gqtd96Ln/fPpUh+2sEEbZZO/
 TO2VBroHFHj+loiizZ9CYmyMgHFw8BeL8diW7ElF5Cs5WkrxHAh7fCkeXKQ3G+ydFbTr
 u2Og==
X-Forwarded-Encrypted: i=1;
 AJvYcCUAqdUjnrH1JjRs4h4C3UmE65N4mllySyqzmtyL6DwvAOicXixNDusXt4lOnXnwU0QjTJ4=@dpdk.org
X-Gm-Message-State: AOJu0YyxJE285Sa+lzdGaEXidm5rleADXlUiDGn/r+DWbpXjFG0k2nuJ
 kSbuGQyr+4uCGYq2z9fQ6IJ3B2dSiT4kI56KZZk/i6WYyYS6PiN46CdzRBF2Bh9pEZ3yY0nm3nL
 3cuAqMWa6z26IgtUCJhLoZ5KEBgV3pVhU+PzrABEg8S9p
X-Gm-Gg: ASbGncsFCVipALG3FUFIZFAgKRflQwcguwC9EZuvDZLLwfLo6V5kbjNvuywTTigvACb
 cDOtoKFKDBatiJXrJX+YZ6e4WcVWMiO+vg9l+6MSMNt5R/MUDmMW5bHXf+2117wfYMdcsMfVe0R
 XovR+fNM2iry+JPAvwmgQHHgJPJl4dKTX7NjJyeWI+56FMPOVvGaXsmR578UUy+/TOz2KMBPYgC
 Rrl9lkpJhC7wfRh++G2ztLZ+DZqJVcTOlQ+5KmS6PVMsxCCQU2hLav4s564FLOub6O6mpP+E46g
 S0L5mngJAqvUO7Y79eVPEFi0FkROKtPmSSFEBXpdBsiBV8qlhri5xmf0ocNSudH0+tRsN9IOR5K
 fdwly
X-Received: by 2002:a05:6000:2282:b0:3a4:f50a:bd5f with SMTP id
 ffacd0b85a97d-3a5522b7eebmr1786589f8f.31.1749550634804; 
 Tue, 10 Jun 2025 03:17:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFLiiWtzlWDsA5F6gY1haN/z0oinAIdAnd3gOsfLRxvwiSVmO6fH1XXsgKmj49cchgNZsybnw==
X-Received: by 2002:a05:6000:2282:b0:3a4:f50a:bd5f with SMTP id
 ffacd0b85a97d-3a5522b7eebmr1786566f8f.31.1749550634472; 
 Tue, 10 Jun 2025 03:17:14 -0700 (PDT)
Received: from localhost (2a01cb00021ec000b06e6b63494bd4c5.ipv6.abo.wanadoo.fr.
 [2a01:cb00:21e:c000:b06e:6b63:494b:d4c5])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a532436668sm12061784f8f.54.2025.06.10.03.17.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Jun 2025 03:17:14 -0700 (PDT)
Mime-Version: 1.0
Date: Tue, 10 Jun 2025 12:17:13 +0200
Message-Id: <DAIRXTFJ2A1G.2WOV7VEKWBEWS@redhat.com>
From: "Robin Jarry" <rjarry@redhat.com>
To: "David Marchand" <david.marchand@redhat.com>, <dev@dpdk.org>
Subject: Re: [PATCH v6 4/4] usertools: enable pmdinfo with MSVC
Cc: "Andre Muezerie" <andremue@linux.microsoft.com>, "Dmitry Kozlyuk"
 <dmitry.kozliuk@gmail.com>
User-Agent: aerc/0.20.1-98-gade1b762cdc7
References: <20250610100947.421877-1-david.marchand@redhat.com>
 <20250610100947.421877-5-david.marchand@redhat.com>
In-Reply-To: <20250610100947.421877-5-david.marchand@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 30Mc4RBdPPasbFR6kJj9Khk0xPSksXcW0ldvOyXSiWo_1749550635
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
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

David Marchand, Jun 10, 2025 at 12:09:
> From: Andre Muezerie <andremue@linux.microsoft.com>
>
> Script usertools\dpdk-pmdinfo.py was enhanced to also be able to parse
> symbols from sections in PE images.
>
> Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
> ---

Acked-by: Robin Jarry <rjarry@redhat.com>

