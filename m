Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9733C3600C
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Apr 2025 09:26:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8ACA840A6E;
	Thu,  3 Apr 2025 11:26:14 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 2F59D4060C
 for <dev@dpdk.org>; Thu,  3 Apr 2025 11:26:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743672372;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1n6UCG5zAXBYC35w+2QD1Z9zh69/o6HHx/WVjlpyLZ0=;
 b=E2pxEOS+ZzxyO57BAQE0Y+2UT7vpmBSHjYT4Ze3tYAbDgoPIfObhhURNRxDJtATeh8q3gD
 KVEXFid1gYBb/R1aoxwbgfjqShoyyKHmyR4oZc/8Aioi8ar5bxP7UD7xjvR/BGjh42kIS9
 imnb5aPJudBeXwUjZ3oiBESTSS/2IHg=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-228-BWE7N26ANuikcklSLygibw-1; Thu, 03 Apr 2025 05:26:11 -0400
X-MC-Unique: BWE7N26ANuikcklSLygibw-1
X-Mimecast-MFC-AGG-ID: BWE7N26ANuikcklSLygibw_1743672370
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-5499d4435caso297825e87.0
 for <dev@dpdk.org>; Thu, 03 Apr 2025 02:26:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743672369; x=1744277169;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1n6UCG5zAXBYC35w+2QD1Z9zh69/o6HHx/WVjlpyLZ0=;
 b=PXjbOANApz9l0o2bFaf6ygiiQs5mtFuS18KiNEFt8UpQi55J30ZsC2FFLRgE0jQ095
 3AqmmkKmjGG6JzJtwmmiVjarwxyFunpNTypLMKuM38hhzuBQ8qNJ8/t1cfkwZIWUE37y
 A3cEtJRoNsId7t5NnX7JIqxXByKFdf+dsXdl04nrerFDbyao0ReWGbYjqYGEsnegb8gx
 3EERhqSBAWhCJaFTAc7nIUJDOo2kWOXCxO12EBqO3icLk/37vZpD3RKVxDUeaEJS2KRk
 NqsgR784V5ESuUB3A3kKQEWFcOc0pCoOD3UkBZmvMz4myfGQrrAgeE/z3UBh7N5DaYvi
 TB0A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwp/26XXvDvGl8kFqJ5qxYI2qo3QqgyUJlXNZ1eFWRpC0elhAe1kmEKpWeZ8zXZJmO+8E=@dpdk.org
X-Gm-Message-State: AOJu0YzKbDnUdnKXuDyTADS9zegTGqv1Oc3afLhEnvCDeu1Bbc3VeFQ4
 OMjC5GjGKtQxV2x3mHywiy4QRfvAQWvQSYjKj+5EkrdBBVixyRfMWh8/ETlXiFuJPxr+SEdmczT
 Y/i1dY0YMpOgg6xAxmcYGeeYfLV8id52lJxGcH5eVPxhRcDbiqlOaQVlsRzC+fKBnGZCgXNGkfq
 cy6uFbdg/O1s/LGoM=
X-Gm-Gg: ASbGncslp+najTuF6rE1KOtpzVkuuiinczaYTGGnJpnIVLNMYNq1KNReNrOAIjF/tAZ
 ilUrvEP9xepp9lBAOYGwpKJOSVVSuhrN6RtTZz+NAIzu2iqeORmWngfa6vxq3koxSjnccA/sdAf
 8=
X-Received: by 2002:a05:6512:39c1:b0:549:43f8:824 with SMTP id
 2adb3069b0e04-54b10ecc1d0mr5335172e87.26.1743672369531; 
 Thu, 03 Apr 2025 02:26:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQHARP27wM0mBOrF4hLjlWePBb0u8ftSmFhSLWPmRj2RI6zyDitoTrge7L8LmDi1bfS9K7AyK8AlF1lTDuOWY=
X-Received: by 2002:a05:6512:39c1:b0:549:43f8:824 with SMTP id
 2adb3069b0e04-54b10ecc1d0mr5335158e87.26.1743672369135; Thu, 03 Apr 2025
 02:26:09 -0700 (PDT)
MIME-Version: 1.0
References: <20250402093309.10394-1-oleksandrn@interfacemasters.com>
In-Reply-To: <20250402093309.10394-1-oleksandrn@interfacemasters.com>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 3 Apr 2025 11:25:56 +0200
X-Gm-Features: AQ5f1JqNAGHIqSRgh9UfJZ44B8T0mmQ7w5719yVfBXvhSpv5MPl_Qwbxr0D0Q_Q
Message-ID: <CAJFAV8xaLd0wQDFRAFG=oA1MzpDmdLVywCqsabXXQ3nZm7vm=g@mail.gmail.com>
Subject: Re: [PATCH] trace: fix out of bounds write in __rte_trace_mem_get
To: Oleksandr Nahnybida <oleksandrn@interfacemasters.com>,
 Sunil Kumar Kori <skori@marvell.com>
Cc: Jerin Jacob <jerinj@marvell.com>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>, dev@dpdk.org, 
 stable@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 8l7ANPvUa1PPYugqIl6AcU5z2eqjG0V992sJgxNR4LE_1743672370
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

On Wed, Apr 2, 2025 at 11:35=E2=80=AFAM Oleksandr Nahnybida
<oleksandrn@interfacemasters.com> wrote:
>
> Offset should be aligned first before checking if there is free space for
> another write.
>
> Bugzilla ID: 1665
> Fixes: ebaee6409702 ("trace: simplify trace point headers")

This commit ebaee6409702 ("trace: simplify trace point headers") just
moved code around.

I think the bug was present since the first implementation, so:
Fixes: 032a7e5499a0 ("trace: implement provider payload")


--=20
David Marchand

