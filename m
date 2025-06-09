Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B73C4C61CE8
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Jun 2025 15:25:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D087840EDF;
	Mon,  9 Jun 2025 17:25:51 +0200 (CEST)
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com
 [209.85.219.44]) by mails.dpdk.org (Postfix) with ESMTP id 10E5040EDB
 for <dev@dpdk.org>; Mon,  9 Jun 2025 17:25:50 +0200 (CEST)
Received: by mail-qv1-f44.google.com with SMTP id
 6a1803df08f44-6f0ad744811so30708586d6.1
 for <dev@dpdk.org>; Mon, 09 Jun 2025 08:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1749482749;
 x=1750087549; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WYuZ/eqKaM/DdB9qlu5cTSLheJj+51HZZ1VgIItdCMY=;
 b=mqq/lY2f3xTzElrhXEJHz5dRvF3DVG6dXtE/hD95VtBUIDIsp2ijFShNIorc/AT6MQ
 8zkdLt2JfiOoEHkKT1d7tz11XpPx3bAFPmBrcask47SPPW1A00EziIlmkxwPSfzQxHHT
 4a/pwRBjD0znw4rokGptNGwsBC9oxBLDtszFdISQr+90wcsxcC7qJ5GGlHcHGsyvK1ZF
 Pf/+FPIMc+D4V+JByNc1rGYIYFZ3zUUhNep2GiGmjF7AOpWQYr+26y1i2E0T+Jlw+lBV
 2RQ1m6T7Cv5Gbue1hHjwFpBuJ8oPe0fdwD/Bd2zofZ0/xejY3AMDTaI/0K25/ykvc4q+
 vtRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749482749; x=1750087549;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WYuZ/eqKaM/DdB9qlu5cTSLheJj+51HZZ1VgIItdCMY=;
 b=oty/EDxwTEcXwYuPJu6YdLQ58rNy6CSL8gzaPpJrURLYRFtOZqyxdR+xxmyXzx6Mds
 RC7fE3BLTlEhN4zvuG3Ym/2mouJvfrO6jpxJFp7jsRqLPNLd1cCp+ToNL3mWTM6WFVtw
 B1oSXdKRXVLZNOGPbbk5qxdyPAqRxH25JKxwyYp1MHr1MGdmAoO6ydGIjsZqYcDEaN2M
 0vaF9di7L5AZChtT4BedLCvre9XLS1MFcRHytoz1jhPGvdOw7Snakqo+4dBArNnvWW3C
 Pew9fbxq+hnUN7SHLI241iQ6Dl9Qj8VxYXNOFitPkon3LNDK6g8rClHse6B4E12++RQ5
 0bmQ==
X-Gm-Message-State: AOJu0YxbnG/NbUNKORb+E4dkHXuOG+bTMSm405Uy5b2QAiLdC7SsoxM4
 UqBCC+0phDN9qqIxVMpETwf170ZGeEl0W+1vQivG6w3s3TxnIMdqlvjSzZ/FhnPaeuXFWMkvA9o
 DcdwS
X-Gm-Gg: ASbGncsqPsUSzh1p75cgZ6hYqy9yK4thjxnQX7eu7Jsj9aiDTgjuf26QLagU7jE96Pg
 8ND9N5DlBUuVm2ZxgBSrj3WkhW/+7qFxVhCGrTwl8U9E4sibv7wuC7kZSwqkQ5SfKO+KQgDQdQM
 NyzeZwm6PLERm3G0BngcP8RKxXZTFZMeF5KzMkC2id5P8Err8R0MAT/KG1h2BZ/I+0uh/458QH4
 gj345a11mq7bFIKBZoR58B5+JDRK+rsmw39JS8rht936pPhAtvx3xPisRacWy6Ky/vTlP1lBZaO
 VQY3D5zX/N8LetrNL5MKoS4glaCPyQl1oOcpFStDZUfOzqeQCb8aa9Wztsl+A/99a9a8YLvzVNA
 N7Evgp/A6K+g9QkFvspFtwg1qiMOtNcLJwzaesWQ=
X-Google-Smtp-Source: AGHT+IHB/nEf9z6O/pM5eWnaAg1LGjpfynH5clSsv5EyE5IuBXPHdDVDlFGHjyCVudyhdMNoL8BRpg==
X-Received: by 2002:a05:6214:2522:b0:6f5:46b0:7d11 with SMTP id
 6a1803df08f44-6fb08f8d3b9mr235289016d6.36.1749482749240; 
 Mon, 09 Jun 2025 08:25:49 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6fb09ab8a31sm53158386d6.7.2025.06.09.08.25.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Jun 2025 08:25:49 -0700 (PDT)
Date: Mon, 9 Jun 2025 08:25:45 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: dev@dpdk.org
Subject: Re: [RFC PATCH] mempool: Fix some Coverity defects
Message-ID: <20250609082545.4c932967@hermes.local>
In-Reply-To: <20250609144226.232625-1-mb@smartsharesystems.com>
References: <20250609144226.232625-1-mb@smartsharesystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

On Mon,  9 Jun 2025 14:42:26 +0000
Morten Br=C3=B8rup <mb@smartsharesystems.com> wrote:

> @@ -141,8 +141,13 @@ rte_mem_page_size(void)
>  {
>  	static size_t page_size;
> =20
> -	if (!page_size)
> +	if (page_size =3D=3D 0) {
> +		errno =3D 0; /* man sysconf(3) */
>  		page_size =3D sysconf(_SC_PAGESIZE);
> +		if ((ssize_t)page_size < 0)
> +			rte_panic("sysconf(_SC_PAGESIZE) failed: %s",
> +					errno =3D=3D 0 ? "Indeterminate" : strerror(errno));
> +	}

Why not make page_size a ssize_t or long?
The return value of sysconf is long.
Not sure if setting errno to zero is required, sysconf only touchs it if re=
turn value is negative.
