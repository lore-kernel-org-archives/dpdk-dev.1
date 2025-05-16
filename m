Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6057C3ABDD
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 May 2025 09:17:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7D0EA400EF;
	Fri, 16 May 2025 11:17:51 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 1AC1040041
 for <dev@dpdk.org>; Fri, 16 May 2025 11:17:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747387069;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gdTekWnszbvoS3KhALs/J1fkUemAxjFQkVGwT76wqNw=;
 b=g7NK4pGTrfypCeaCtpMhMW0LwibesyYm1rrt5dpMcrrNEWJqmYQcYUbpooaXmw0+G8IuJB
 Lq7LogZpV+Zo9GXoOSxhMm6S42kptLrzmzsMG/yD7hKeA24y2keL+vqZ5mSxdhSDEYN9C1
 hP/adL8NDjxegUcjzf0s0id6uCgngnY=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672-gaTom9jDOjOkH0qKTgGfNg-1; Fri, 16 May 2025 05:17:48 -0400
X-MC-Unique: gaTom9jDOjOkH0qKTgGfNg-1
X-Mimecast-MFC-AGG-ID: gaTom9jDOjOkH0qKTgGfNg_1747387067
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-326c8e524e0so8287881fa.3
 for <dev@dpdk.org>; Fri, 16 May 2025 02:17:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747387066; x=1747991866;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gdTekWnszbvoS3KhALs/J1fkUemAxjFQkVGwT76wqNw=;
 b=YyvEHT8NBycyXV6lhT/tX37tM5u3gTXQV647d7R+rzPJldRt3fhzdFt9cv2lMWphJq
 LK4tQvdZK1dHXIybpFY+GqQEJ+LYjRDON3YO+KJu7HuZSQ9M9ApCBUdPvPFem1wKPySb
 NvIwx9x47hzQqFcjl4sYLprlE+NIqdIBJILXgQdaRnWOxh46wpECRBg6R2g0tosSefw2
 l42QSkdfyb7T/FA1JQX1UTLyB9TJ3sW6//L4P90DeVOXZSfsKQR3z9e3xjAPd3OKLr9N
 56yi0eiIJVQFoie8FeGnMA9NjzXnUT6cCzbigL5/YP1suT1o4NlA8GshoT6Ovdqrys35
 GaIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+sl3XncDBK/izrbG4f9R2cWE9QFgJ0e1DA19HW+UYqgXkYoVkDTn27LEWMEKq+6DDdL8=@dpdk.org
X-Gm-Message-State: AOJu0YyRh0G69OhSls5ZqYg2neBfXiHL5DCch/1rK+jeFid7mwq2y4oe
 bpT8XOkqMBcPjkQAdSof2BuBO4E0GhbiGZ8CiT1mDF3S69mXK1zoVHYkyYy6BRntV/2MYBusAmM
 Q4D4W1Yt9O8nUSGZVzPwP7C12FuCCEjX2lGvI/A2qtxGcLgHqSFuvEqX620IaaOcGnwDvvvj7X+
 CM27T0BMddcDibszEWfhM=
X-Gm-Gg: ASbGnctI3/H4bmVBlqZyP9SQ6XsrO/WfCreiaZ8+E/8rGsFipNAmnxio5+I1AO5vbXi
 OoS4ggqELUj/85xKhYbkC/xvWsk7O1KQ2+zHbDU/2C9Vm1ADHyHA0KAMYslLmMYbZY/sqTbM=
X-Received: by 2002:a05:6512:4508:b0:549:5c5f:c0c0 with SMTP id
 2adb3069b0e04-550e7245505mr784644e87.41.1747387066573; 
 Fri, 16 May 2025 02:17:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFHUpCmXschU4e4CmJYIo67fWo/1FCexKIeMgH5cZbeYhI/F8rVXKbwFCQtO8qAcCMSiRO6SUsM4JNmhMxcXoI=
X-Received: by 2002:a05:6512:4508:b0:549:5c5f:c0c0 with SMTP id
 2adb3069b0e04-550e7245505mr784638e87.41.1747387066167; Fri, 16 May 2025
 02:17:46 -0700 (PDT)
MIME-Version: 1.0
References: <1741313581-14300-1-git-send-email-andremue@linux.microsoft.com>
In-Reply-To: <1741313581-14300-1-git-send-email-andremue@linux.microsoft.com>
From: David Marchand <david.marchand@redhat.com>
Date: Fri, 16 May 2025 11:17:34 +0200
X-Gm-Features: AX0GCFvK9FWBIcbMF1Yu6eBU-Nz8i-W9ZdfuISgqtLxzqUsB8I9ClB3I65uwj3w
Message-ID: <CAJFAV8wqi0v6FP7v4WKc+rd=DrDK5Y06qqO1W3unoEXQ6KMKLw@mail.gmail.com>
Subject: Re: [PATCH] test_ipfrag: remove array of size zero
To: Andre Muezerie <andremue@linux.microsoft.com>
Cc: Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>, dev@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: V6q8trPUqsFZvPL33CH4AbGINfKlCbYh1DhoO6SGWm8_1747387067
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

On Fri, Mar 7, 2025 at 3:13=E2=80=AFAM Andre Muezerie
<andremue@linux.microsoft.com> wrote:
>
> When compiling with MSVC the error below pops up:
>
> ../app/test/test_ipfrag.c(39): error C2466:
>     cannot allocate an array of constant size 0
> ../app/test/test_ipfrag.c(157): warning C4034: sizeof returns 0
> ../app/test/test_ipfrag.c(160): warning C4034: sizeof returns 0
>
> The fix is to simplify the code and remove the zero-size array.
>
> Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>

Looks simple enough and valid.
Reviewed-by: David Marchand <david.marchand@redhat.com>


--=20
David Marchand

