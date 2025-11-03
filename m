Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D70AFCCF9F8
	for <dpdk-dev@archiver.kernel.org>; Mon,  3 Nov 2025 18:48:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E839340647;
	Mon,  3 Nov 2025 19:48:12 +0100 (CET)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by mails.dpdk.org (Postfix) with ESMTP id 1207C40431
 for <dev@dpdk.org>; Mon,  3 Nov 2025 19:48:11 +0100 (CET)
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-294fd2ca6acso36034195ad.0
 for <dev@dpdk.org>; Mon, 03 Nov 2025 10:48:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1762195691;
 x=1762800491; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qWGJGMvKKg++E5vR2AfvdS8BaCq/dBU10wksR0lzh1Y=;
 b=rUIVU8NZoaQlzgfgzGHqLO/IDb+1CrJ0MbdiLwcUpUL/5eb0xIYucr7fmIOW8EwPRW
 0qDsM2BcsnYQGC6FTtuo0QtkVboR9wJXal4HmsvzALUjhPPmEpqYYMrS9P0VX2uT4gnq
 8R3FHk2idaJYu1whl8ia3b6oyT/8H7ODtqhdEqWPAOlwCKv3LdCfpPwtA3c1gBTYpn5j
 Saa1Akwuc841aZkX/JGeFODUwR5F6gy5wksHOOB+biefwnAvyh6pfCaPMjSSTxYgx3Y0
 g7i1R/XmsXD0Y+1yI+c1mSm9Zh6TytoHVcQnoI74vcCC9deKJ5sClefeC8rDkKDnqOQb
 nF1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762195691; x=1762800491;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qWGJGMvKKg++E5vR2AfvdS8BaCq/dBU10wksR0lzh1Y=;
 b=Z16ubtHOoRqq2HCHpqkfWZyB9m1mWFhM6le4zW6kh0/jeFxMoyRILS+tlxktNZn1qq
 u9NLy169Z57IEds3Cgu09RESQQwXH+/kyxRZHpB3RnHoZkNpH9flagnNAve0a3aawsbF
 9tU3Vge1uP4MMhCsKvZ1Qr0Eg8vGYNnmhEiZ3Flb0XSuByv/DihGeOjP26MauZdfPtc5
 RAbAnLNsEusQsp4V1nJEiIHZbWeG2HtlpD/sIqpeHeMOZ4SfK/tKG/dhbeguRHrgKUAi
 /h+38CL5UaaDAWzmopCVdO1XW484zSkuSxBmUs5v+7iQPpXrGec4QPa8EdohkrjR8uKz
 PmTA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXeKoGJsqY0WLp9oYg/ubnlHO5ndlvHaWAPRZ6lhlZ/obg2q1odNP5pS8+U6HG9llhHOWk=@dpdk.org
X-Gm-Message-State: AOJu0YyIRhY8BIJFuuCRL4wF5jn6xNT1j/Dev0XJ8kKQVSFNH1LdHZWe
 z+3mCQluo/qVtkr+XktQ8c54KsM93TJ4vHGGeTuJmIdxmXa38eV03xDMq589TG1MwzU=
X-Gm-Gg: ASbGnct2Pfjo/BY4XpOY+OAL/LVALBFismd7zhla+vwUyQ3AMrl4ZXRF0pGZ2C2sBcL
 42rjAoDjmv1PUoW78v4fr5MIzdcK4Db9YHrzNQZOjepPUmEVHFRDXklnMH1Hou7UwtpM5FdkAiy
 z3/vsck6/gIf56Bt752RsfU9s0PGoyQwIBqMsYrMd87hlFjQB/0r2ofmjJjL6PDRRPDe9G4/PII
 DOxhRw8sKa4sCtngLZkbUjqvlPvfk6Q7mcliCElb6hlP9Y+SHcSW+v9r4AH4htYSfnvI9nVwQgf
 yWlK2eSEDdKYJ7UmFMDeBoMDZDT9L617+xy9a7vfvwsb5ct4/RbVwrRaCrj3M8EOrhr7CFsozS3
 foG4ixwhyNlQWW4xyLQy3zM7ZEAmqaNTaKWYcF3Le0iro2pE+qgtn5bhIilkbR0npVdWsppT1EB
 +ScLy5AV7gWcBk3vHCPoQXikJioBjdqqmXcw==
X-Google-Smtp-Source: AGHT+IEgcbqfdlnRmiYzkoUzGtITKYCZxUlIQARbt3Hw6emxVYCCaiNsAThMfKAuvVu0PphG2K4lxQ==
X-Received: by 2002:a17:902:d2c2:b0:295:5898:ff5c with SMTP id
 d9443c01a7336-295f94750d4mr5465195ad.16.1762195690977; 
 Mon, 03 Nov 2025 10:48:10 -0800 (PST)
Received: from phoenix (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2952774570bsm126083295ad.99.2025.11.03.10.48.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Nov 2025 10:48:10 -0800 (PST)
Date: Mon, 3 Nov 2025 10:48:03 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Konstantin Ananyev <konstantin.ananyev@huawei.com>
Cc: Wathsala Vithanage <wathsala.vithanage@arm.com>, Honnappa Nagarahalli
 <honnappa.nagarahalli@arm.com>, Tyler Retzlaff
 <roretzla@linux.microsoft.com>, "dev@dpdk.org" <dev@dpdk.org>, Ola
 Liljedahl <ola.liljedahl@arm.com>, "vattunuru@marvell.com"
 <vattunuru@marvell.com>
Subject: Re: [PATCH 1/1] eal: correct memory ordering in MCS lock
Message-ID: <20251103104803.30464227@phoenix>
In-Reply-To: <d63bc45cb32848299574333fed5e5406@huawei.com>
References: <20251023184724.1759497-1-wathsala.vithanage@arm.com>
 <f08a5a55-2a46-4f8c-9658-f7c320de57f2@arm.com>
 <20251103090717.2d181d95@phoenix>
 <b435dd1d-c56f-4d56-9f73-30ee1ec99eac@arm.com>
 <d63bc45cb32848299574333fed5e5406@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Mon, 3 Nov 2025 18:06:05 +0000
Konstantin Ananyev <konstantin.ananyev@huawei.com> wrote:

> > 
> > On 11/3/25 11:07, Stephen Hemminger wrote:  
> > > On Mon, 3 Nov 2025 09:12:39 -0600
> > > Wathsala Vithanage <wathsala.vithanage@arm.com> wrote:
> > >  
> > >> MCS lock is broken, it's just a matter of time it will run into a deadlock.
> > >>
> > >> drivers/dma/cnxk is a user of MCS lock.  
> > > I am surprised that a driver would use mcslock.
> > > MCSlock is targeted at case of large number of CPU's with lots of contention.
> > > It will likely be slower than spinlock or ticketlock for the use case of driver.  
> > It appears in |drivers/dma/cnxk/cnxk_dmadev_fp.c|, perhaps the
> > maintainer can clarify.
> >   
> 
> If MCS lock is really broken, it needs to be fixed anyway.
> It might be used by other third-party libs/apps that do use on DPDK.

100% agree it must be fixed.
It would be good to have test or static analysis tool that could validate all the lock types.
