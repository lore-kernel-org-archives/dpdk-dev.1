Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9267B606A31B
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Nov 2026 16:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eD0xsXm2
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6DE8940E09;
	Thu,  5 Nov 2026 17:55:55 +0100 (CET)
Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com
 [74.125.224.41])
 by mails.dpdk.org (Postfix) with ESMTPS id A1A9640E09
 for <dev@dpdk.org>; Thu,  5 Nov 2026 17:55:54 +0100 (CET)
Received: by mail-yx1-f41.google.com with SMTP id
 956f58d0204a3-67c11318ad1so245664d50.1
 for <dev@dpdk.org>; Thu, 05 Nov 2026 08:55:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793897753; cv=none;
 d=google.com; s=arc-20260327;
 b=fiSH18+P+Yau23+cH0aQj0fjogr/wmEdfxqe2GezdY2QdKJnkmRwcuuiWRBOSkGvg/
 BKI+zvGpjQEXHE4ldSUqReYgqPUN2Hn6t3fu+ryveIvJQ1LZqYCx4uTl47itkNsfdhSx
 J2RVbwu7lZZVSSBBWJlEpU2MWa05JRP33N+K2CmD0dsq8OzzX4uNhPCGRtGJtatCWbNc
 doFRoTj3QU9qU/KrVrjlXW8ofB9g4mNpHY+JE5SUxe/gByM84fuBe1bl1W4oVfsv4wvJ
 rlyPa98DXS74hHwxjWCo6hMplpR6YPFhX7AWe5K52Uw/tIHlT9X1cCT3YpBvmN5PWzaO
 H+BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=lUoa6jVpFLj5O0WWnLgFmjKTalKc1OOAdV5kCAjxOMM=;
 fh=RHcoOvBANWfsh4xdN/Cv+T1WOntTOB6hsjF7MkoDKBI=;
 b=C1ANV9NXrZ+obqStnZqV2mfBqPo4F3v4KYmftMCisG7qsNKvsWjRXM/o92Uk88FoV/
 gqJo4fap9mhdpjYxnqFJERqkbxvYN7yIbMeIxl9A8cDN6u+RrUeZkeDYBYpbYN7bun+Y
 7TJ1YK9+Up7SqDFkBGHBs8A9EDJyVdJc3xzfK3JseEy28afUwtQ8Bq2E6zjbZAuMeV4f
 hzopt5WDkNDJ0ZbMKRR8daxPTg4MWt5BCr1eX1JRupwT00r0n7eBXSVNvqZwijQOiq9N
 hQPDnFVqNDLZw7Jbjo+8NdBMYpi9ITzDGmFt/uE7LkMQbAAjtIGtOqNa0MnVrTDG/lxn
 UMUg==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793897753; x=1794502553; darn=dpdk.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=lUoa6jVpFLj5O0WWnLgFmjKTalKc1OOAdV5kCAjxOMM=;
 b=eD0xsXm2PK2KUC2VfTGUGcHtB0NjSlPR8OvoxZgNRWuG+3GBsc2PNphgyqCopmCG33
 DmdBqt67mQhPoP1s8K3Ho0ECRZImpatDfg2HE3YWNVcJjuOPYG2fvpNip4tnGwaeo2ws
 +QKFsaTBkjasdNgPt9GEK1H/ihOd+ow1LcCw37mIRe/Yu/kax3lE2UtAj9JZgQYQ6lNB
 XTtvI69zZnr921XKmYmiL5t1Gnu0iWND2lV5IB8I52rRnwNVvU99Zw7AaHZyvhhhuk04
 Qa3MjFWE7Lc/8Lv16+C6HPj4XfhQ58u4WPWuBnvpF1JBXcWn9MQ/pTBQYovEGeTmWXSe
 kcQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793897753; x=1794502553;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lUoa6jVpFLj5O0WWnLgFmjKTalKc1OOAdV5kCAjxOMM=;
 b=iUtAyhDi1jm2Uq2x2/Ry/SctsieRhJuHIER2KIRgO2jvMw/Xc2RwLIy1azwEMqbJPS
 FSbIoWBbhjJoxslzdmLMEK8BLXXlHuAF9GqT5dHIMiAwPWakMJUD5AjJoJkpRtDIcxKJ
 PFe5uHUvrD0nROZZJuMes5koFuF2hUqnydV4c0NdreuDz5jGOKQ07I14w6EKUV9NGYQk
 CxKK0CeKKjJwojM6adbm5hlWcewp0dea8bUxgrkaLXELhcXxxttm6KzkqdXvfG5gWZfY
 3QTwdygvNu+N8Mm+YIc4WF4OQRFsDTfFT0gl8Y9R8UP8FBdTWXRUREVgiuUHN9GhMeni
 QRlA==
X-Forwarded-Encrypted: i=1;
 AKwUvBw+SgTUGGSnsYF01mgRVha29yoe6YdD4VU08WyRuruMPdOJLInjpiS6oRrRm34kiGLkceM=@dpdk.org
X-Gm-Message-State: APuU4Z8EwTufT/FLY4AvnkMb1uVaCeZeRd/87KAK7lJYseIr9nBW+pWc
 EuMKNnJ3Wy5iZ+Z8nR698G9s1XeoLAsMoQwycvLHTJvxlo2KkJwgF8OoX3G+ZM3sn9eR5POnDR3
 7g0bh1kwFrfyiVWeZIui8jpqQu4FJIzc=
X-Gm-Gg: AYBFou3m+c9VmdlYwVbXKITJJFMqJabKvCLVlPe78E5MiKhUsQBCZ/hGOqOp/aZMfGE
 QLXNTU0hUiShAMr15iQK+3+1eM7ikJj/OX+CL8Fy/WLE5PYekJKkx9IcQh9lIiEgvVsSQm0iksv
 fX5E+NAyALpBVy7HmQvOnto5uAYEsvUeFxE3VD0y1lrpZOJ5Y21viHGxlYV2FFI/LxG6orR4pxV
 JHaXSeL/rT+02llncRb3X2gmSeyFtAsmXxyijSJbhTRYslSCpKuEDBkcXwayYU8dF6YPh2UyQSo
 m/wO9Hu+qdJiVtHERsItDqF9nOKsOYZVXb8PwBRZDCVZLRzo5wWgR3z+7q4YSQPsZXoyHtKi1yk
 l9VxsHplVnzb7CZgiQBooLzOcbd+oqRyoLTECsTeGGcfI6jFYB1FBPx/Vos+neYIUQpuCzvF6gi
 Ex7PTI/IXNASk9oJslWCMTmAv9d3ey7g1rpvDQ6MAmON9MjmkIZv4oHI2Xo4z+I+0LKQAd4+RLF
 g==
X-Received: by 2002:a05:690e:120e:b0:67b:eb11:fe4d with SMTP id
 956f58d0204a3-67beb120f71mr3387818d50.5.1793897753342; Thu, 05 Nov 2026
 08:55:53 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261030051726.898902-1-nkishor@marvell.com>
 <CAOaVG17Zkb+0Tn7VxF8SuGpoULYU_W64vC=KnLM7YCXGGq3+Pg@mail.gmail.com>
In-Reply-To: <CAOaVG17Zkb+0Tn7VxF8SuGpoULYU_W64vC=KnLM7YCXGGq3+Pg@mail.gmail.com>
From: Jerin Jacob <jerinjacobk@gmail.com>
Date: Thu, 5 Nov 2026 22:25:26 +0530
X-Gm-Features: AclHuK9cMieRyCf6mQHAXEIQwwSj-qchTfddaEQmYzdqXQ1aufEOwHT3kprVP_M
Message-ID: <CALBAE1MQFnyqc5oo+4qM330pFtUVnKVQLZgNdP-_AhTuuYSFXA@mail.gmail.com>
Subject: Re: [PATCH] mempool/cnxk: fix halo enable devarg parsing
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Nawal Kishor <nkishor@marvell.com>, dev <dev@dpdk.org>, 
 Ashwin Sekhar T K <asekhar@marvell.com>,
 Pavan Nikhilesh <pbhagavatula@marvell.com>, 
 Jerin Jacob <jerinj@marvell.com>, Thomas Monjalon <thomas@monjalon.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Oct 30, 2026 at 10:13=E2=80=AFPM Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> one more reason to have common code for boolean flags. there is a bigish =
series to do that

Is your series merged? Stephen, Can I make this patch as Superseded?

>
> On Thu, Oct 29, 2026, 22:17 Nawal Kishor <nkishor@marvell.com> wrote:
>>
>> parse_halo_ena_handler() kept the parsed value in a uint8_t and stored
>> it through a uint8_t pointer, while the caller passes a uint32_t. The
>> narrowing happened before the 0/1 check, so 256 was accepted as 0 and
>> 257 as 1. The one-byte store also updated only the first byte of that
>> uint32_t, which is correct only on a little-endian host when the local
>> is already zero.
>>
>> Parse and store a uint32_t so the check sees the full value and the
>> caller's object is written completely.
>>
>> Fixes: 45abbfc836b1 ("mempool/cnxk: support HALO in mempool")
>>
>> Signed-off-by: Nawal Kishor <nkishor@marvell.com>
>> ---
>>  drivers/mempool/cnxk/cnxk_mempool.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/mempool/cnxk/cnxk_mempool.c b/drivers/mempool/cnxk/=
cnxk_mempool.c
>> index 6939fccff4..f1cdf9cbb5 100644
>> --- a/drivers/mempool/cnxk/cnxk_mempool.c
>> +++ b/drivers/mempool/cnxk/cnxk_mempool.c
>> @@ -51,13 +51,13 @@ static int
>>  parse_halo_ena_handler(const char *key, const char *value, void *extra_=
args)
>>  {
>>         RTE_SET_USED(key);
>> -       uint8_t val;
>> +       uint32_t val;
>>
>>         val =3D atoi(value);
>>         if (val !=3D 0 && val !=3D 1)
>>                 return -EINVAL;
>>
>> -       *(uint8_t *)extra_args =3D val;
>> +       *(uint32_t *)extra_args =3D val;
>>         return 0;
>>  }
>>
>> --
>> 2.48.1
>>
