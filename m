Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2182CCCF9EE
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Oct 2025 19:46:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E2C3D4025E;
	Wed, 29 Oct 2025 20:46:55 +0100 (CET)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com
 [209.85.167.52]) by mails.dpdk.org (Postfix) with ESMTP id 0946240150
 for <dev@dpdk.org>; Wed, 29 Oct 2025 20:46:55 +0100 (CET)
Received: by mail-lf1-f52.google.com with SMTP id
 2adb3069b0e04-59093250aabso225099e87.2
 for <dev@dpdk.org>; Wed, 29 Oct 2025 12:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761767214; x=1762372014; darn=dpdk.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7carhqy2x8dN4x7eGdDXrIm/W9EzQrRhTBFVpj+wiio=;
 b=HhB4QHZ/wruFC0WhGB9InGBqtN9PLcQDUuWDGqcIxsPhGBZp3sY3RS79tQlV6yqAvP
 B3zRWVBTUZ3GI7mJ2zpeEzs7k/ALOKrJ915WXyQFy8XJgAj5p0n+DMwkFqvS3qjuNrDr
 yW4Hna69HzkAwV0WHAfS9MHWbAfbpJPUgN/3qO7RgrWCwio22DmNmIb+coZLajUSXwh8
 hH8ib5kW24nBUG6VZvtWqYpqvppmY/W3gtP7YiHSYTBLzaDYwISEwTGMNdBWV1pEp7Yh
 K0UwxVnkJjbqDLjHHNf8ef3Yhr/czuTZLnG31j+eWZAml4zZy9NJoIIAw82d2Ca91PGl
 Dg+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761767214; x=1762372014;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7carhqy2x8dN4x7eGdDXrIm/W9EzQrRhTBFVpj+wiio=;
 b=j03Xrwlv6rbMu295hMqyQmgPchk8l8S+sSvRAVREKAkUKuoyideCqo7iGu1mwIhY0x
 8HSuyuy1u/Y4SHPBpPCJzPa3Q4XVYIr5iWxJmZIMn9W9DJJW5/Jvuau0JqWBa2i39g/y
 j03Y1Rl57B5Mx2QAkD739sNQaptrcgJ3E/zVPn7QCqJATecwjR288k/W/uxd2nM3Qv5C
 y9bUWi5OKqRPMAWxNYX9aBaiX/Wft5+RS6C1y2mscDQnYBlQpVcG5jzJjQG1E6yku+dl
 gfb6bouT+++2sAJCTXABxwidBnvrN0Da8yY42oQiqaEabW1GpuRRyoDLEfNdyeSVzOsV
 Y/Wg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZD1LRUOwr3SCK/3Xe/4Ga95CHiynvfNLqt2wUlu+JovcfdP3MEvAwcYaVAqZtROb/5vg=@dpdk.org
X-Gm-Message-State: AOJu0Yy8vmuRaDR1VttlctNjTdEfPV+GUuym58PwdP6rG7MMA27B3bz4
 L7U1pdpxeWV+sDRCuu/HiK0nm/gaWzaOQ+IEYL+wpajt8esBnS3CISiQ
X-Gm-Gg: ASbGncuBokDTD3ntKGde4xc0pkivlBSLqxOQVpV3Uzr6st6p4osuvY0/ds3ALyKk5IY
 1sSFvqz4W/6MBcoYa5T3gyxJ8go/YKIN598Ol+hBwv/dbSJ9wldSDM794ndAS6mvU1FR+/j33EI
 +vzhNE8XQUOvokGTLNZxlYJJFdWi1im3tS9BuWppFoP6RJG3rPxNHJ6kQ7EmEBH7ZEW7XCfMwHR
 9JaLgMegzEQtpw1Z1RYN2TlEjDKP/F6G2y4rdRqdO++gXmQ44yv9hiNVBKNvqIWHOsHryOL9+br
 mhDqbA7Lk25E6PJsoyr/6epmIJRJ/N98Pb1BAsyOFBMeibdTnxjGyDxAg/aJcYHMMPRKW/fW/dX
 YGvGC7+1BXYj4iMuatGmO78VbSl/FQ3yZxI+VlS0pCpDEOlUdp1TTQKNaTN+obt0z8U6i6wHmbg
 qUdwSvWiaXhf2fWdvNCm7npbAmRJc0C7c5nBOWGSWEoe/qmrfXDsp+iDq0kqiz/RMENA==
X-Google-Smtp-Source: AGHT+IGngjFC3yDsrfEZayROqi5x3KckWUf9CqXTtQTzaKFWxbEWJ4Zwa8OvIa0zOLBEUHx1hDLU1A==
X-Received: by 2002:a05:6512:3e03:b0:591:eb9d:ac2d with SMTP id
 2adb3069b0e04-59416eed1aamr184434e87.27.1761767213948; 
 Wed, 29 Oct 2025 12:46:53 -0700 (PDT)
Received: from [192.168.88.232] (broadband-188-32-202-29.ip.moscow.rt.ru.
 [188.32.202.29]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-59301f41bafsm4021345e87.12.2025.10.29.12.46.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Oct 2025 12:46:53 -0700 (PDT)
Message-ID: <0be32835-370e-4e59-b0f2-7034a2472a7b@gmail.com>
Date: Wed, 29 Oct 2025 22:46:51 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dpdk] pmdinfogen: fix warning with python 3.14
To: Robin Jarry <rjarry@redhat.com>, dev@dpdk.org
References: <20251029164616.76233-2-rjarry@redhat.com>
Content-Language: en-US
From: Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>
In-Reply-To: <20251029164616.76233-2-rjarry@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Acked-by: Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>

