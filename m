Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29B46C87FDB
	for <dpdk-dev@archiver.kernel.org>; Mon, 11 Aug 2025 12:18:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8070B40B9A;
	Mon, 11 Aug 2025 14:18:01 +0200 (CEST)
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com
 [209.85.219.43]) by mails.dpdk.org (Postfix) with ESMTP id 93B864042E
 for <dev@dpdk.org>; Mon, 11 Aug 2025 14:18:00 +0200 (CEST)
Received: by mail-qv1-f43.google.com with SMTP id
 6a1803df08f44-7076b55460eso43976366d6.0
 for <dev@dpdk.org>; Mon, 11 Aug 2025 05:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=uetpeshawar-edu-pk.20230601.gappssmtp.com; s=20230601; t=1754914680;
 x=1755519480; darn=dpdk.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rpG8O1nWv/KVUItJBJltovGy5usz1DCVZwdi5II7rVI=;
 b=NtxSVHm6NLIOHqwWkC91QWpgMu7OS9c2+0WBp02L5umJqW8uoENxFDdbY6Tz/EQ9m9
 3ed7k5fc4LH7IBxQkYQMJvFBSTpQ649R7x2VfotfIISgO6MZl5L4cTRjfEV8wFktzzp9
 8XT0cT5tWUAsNX0F2HuEsaEMffIB6srVjeA/rdDGLdCOWYq7uLA/2XKTdMShKZP7p+dB
 jDbO2yezfaOdxu84AO62+agJD6ZIK3Rmuff7n8biNoYlb2UvSE3ufixbelhBnwEOB+Ph
 lgQn5N1G4+jspjEtmZUoxx/UNu9PgWblEzqi3W0OeZlmMXQRaBU+2FuJTxgjaO15s7C1
 zZVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754914680; x=1755519480;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rpG8O1nWv/KVUItJBJltovGy5usz1DCVZwdi5II7rVI=;
 b=t5rxycZsrQM5lPYfkcrnClNZ/Hv6s8emRvp+ch6Nau8FLcKWBN8Q8l8yGK7Marb4t+
 T0pR6+hGyRirHEbePe8vfNYCNu/X6M5hxqG1NNRoU6PQmBBpmDAF6Y5TsraoySFLCGB3
 TxMMvYUHJLirflR94pXq46dhAoWgTwV6+owNRqHPpVYBybdbJpxRA89rV8A5eDzDJJwP
 r4BbYk9Hutq2qG8RuP1SvX1hkQeRLJX2sBatUdjlBWo4Gox7Uo/nBJvTi6QKwvKOPrZP
 IzpvHmDcZY7DrNiJjkkdbVAiS9nYuQ0aYmdMHdMuxz82jdJynomcefHJfFhyoIguumjU
 xWtQ==
X-Gm-Message-State: AOJu0YwK3nSrFPdrW+Lrar1cD/DbPoY6e29efFbyw0dE254MWq16dtQ6
 wJMZwmbbPO5idS2vutlluTdiCEqWdaNf0yhxZbZRzyFi+Aqzdkpa5nPt8NGTebo/f92kDFF86uv
 1SdSJVoDOOyuQlz6XY3OWYnVhcCNhc0dbk3IPtTqo9g==
X-Gm-Gg: ASbGnctZOeSrSKGm/1b0/96cURfAjugXsbtic7RCAyqn6BW+O3LZ2t9rnI8RRsTIQCq
 5K5318YFAbzqRRX39w7Z9QlRy+R+RGKF9/eRKCKsK6rj9JZSYen2FS0vv4+M2qGzfDnqyYPzguW
 pc1WyXIp0tlOhaeOYu9V3bq7zDLkhyjsSFhlVAO5NB/SWLUm8WMSyoVRG6nGau2JUZYFvootFZL
 j+G
X-Google-Smtp-Source: AGHT+IEHfA9sJrVngNlVLmy6YKkIKW/rM1j8s47pOTa5Q5D31fXC/gfDhUNwAZ+tL+MP0bopEnX2P49ZQZVXkYh44b4=
X-Received: by 2002:a05:6214:1cc5:b0:707:7695:eaa0 with SMTP id
 6a1803df08f44-7099a434d02mr164627866d6.32.1754914679746; Mon, 11 Aug 2025
 05:17:59 -0700 (PDT)
MIME-Version: 1.0
References: <5a75dd27-a19b-4dad-b3bd-cc7f31e4619d@oktetlabs.ru>
 <20250801112834.60310-1-14pwcse1224@uetpeshawar.edu.pk>
 <7416c5c9-7485-4de1-8006-78a6df128080@oktetlabs.ru>
 <CA++2-x71R+MGC0_ZmC3p8jJ4=q3ZaW3zQeNwrGMp2UuXTkQm0Q@mail.gmail.com>
 <676e5102-280b-4ec7-ac91-9dc8dc5ffa67@oktetlabs.ru>
In-Reply-To: <676e5102-280b-4ec7-ac91-9dc8dc5ffa67@oktetlabs.ru>
From: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
Date: Mon, 11 Aug 2025 17:17:47 +0500
X-Gm-Features: Ac12FXykBGFp-ItSOghTmQuhiLm14cDiUAQAx25UWWMIo-M-EjmYhhlac6dqXwA
Message-ID: <CA++2-x7XSD8rQ+o3qrag+oviscF_PwcMq1_L5xXnf6T=7wcn4w@mail.gmail.com>
Subject: Re: [PATCH] net/rte_net: fix inner L2 length for tunneled Ethernet
 packets
To: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Cc: dev@dpdk.org, jasvinder.singh@intel.com, bruce.richardson@intel.com, 
 thomas@monjalon.net, ivan.malov@arknetworks.am, stable@dpdk.org
Content-Type: multipart/alternative; boundary="000000000000190782063c15ea80"
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

--000000000000190782063c15ea80
Content-Type: text/plain; charset="UTF-8"

Hi Andrew,
I mean, tunnel offload api and vxlan-decap provides information about inner
header after decap.
So, incase of a tunnelled packet, inner information would also contain the
information about inner header.

--000000000000190782063c15ea80
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Andrew,=C2=A0</div><div>I mean,=C2=A0tunnel offloa=
d=C2=A0api and vxlan-decap provides information about inner header after de=
cap.=C2=A0</div><div>So, incase of a tunnelled packet, inner information wo=
uld also contain the information about inner header.=C2=A0</div></div>

--000000000000190782063c15ea80--
