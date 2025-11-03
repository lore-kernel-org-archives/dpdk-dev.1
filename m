Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC97CCCF9F8
	for <dpdk-dev@archiver.kernel.org>; Mon,  3 Nov 2025 23:48:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7DC6F402B1;
	Tue,  4 Nov 2025 00:48:51 +0100 (CET)
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com
 [209.85.214.173])
 by mails.dpdk.org (Postfix) with ESMTP id C451840299
 for <dev@dpdk.org>; Tue,  4 Nov 2025 00:48:50 +0100 (CET)
Received: by mail-pl1-f173.google.com with SMTP id
 d9443c01a7336-294fb21b068so56971265ad.1
 for <dev@dpdk.org>; Mon, 03 Nov 2025 15:48:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1762213730;
 x=1762818530; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=49+4O3LIoVQ8MtkPFYmcNr/5H8b7nPxKxchnD1PQeuY=;
 b=knEOEAqWLrKYNTc7I2tWpBeovZq1wfI8XxuXCceapX8wKEiOv4YT+cd2coRojGmt33
 6SRldnY3bCRivScY42YMohkQOc+dBE7drTUMPkIwTvWwQOuEvaik/rCtT0tHcjApz2ec
 +BLmW3i6anZ76xYmZmiawWMHclm9SkcJdKou0PjKWQlSsBM+m9/wgGSef+KZ/E5lvagi
 QYNXyTU9IBReREMCkEt3Ci4MXMal5i3cZibnvQ3zgzP7ZL1Tx+CQ9L7NjN95qQeA5qXS
 qsOwmzSOKHuskPjopiber94xgx2W5kKVsZ2Y3TfyxJ5MaiwM3ORbrodIPPkNgiT6lPYU
 sEMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762213730; x=1762818530;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=49+4O3LIoVQ8MtkPFYmcNr/5H8b7nPxKxchnD1PQeuY=;
 b=vx9Y6RyE0jEE/LXs7gjcjvrA0U36RRrWetEBHNQRrCv5ZXGPqsfbtGCBhcGT6dOiXg
 mfFJOk51tLMPGpIQGE8EwqjTlLCt5rCCARF45DgRdUZb9x+dT0ZJmJbumoUqnTG/GLPx
 ZFLJ5GFNJN/UyOxnelytgkOkmnw9Py5Cs2dgy5PaGjYsu0Jydw/JsEnGBJE/TuX3JCA2
 IlvbMkpn8UuPAzScSCE3NpNiX3XePcG+qeYU0HenTSd1mxmeME1O4Cn+mhpwqAc9R0hH
 o/Z4r5exbDtroEUW+XSTGtoQXav0999MT2SDQ6qSnBMTAw1y88xFtkoZ1kzLC7oe/uDs
 BtrA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUaIaEX6k2onHNDeQuZGZP9fWcDmb6KPYdxTNBV0VvbdquuMLQY5npp2vCLS4+36Zl8nks=@dpdk.org
X-Gm-Message-State: AOJu0YxTUvIRPkShkDdZ7dZLUT7JmAZXpmWcDLo5boHU8Ts4bH5hsyfs
 w+SW2H2sW0C5R4G8H8/w8vrZKazvYuTyc2XldaOKpzwcx/bxVF3WHqoyesK/BiQeI7A=
X-Gm-Gg: ASbGncuDYtUvgwQZWVDfSwZiUMEkyKlVX040oiWXsQyRz2CBWLhy98DrRPM1LiqkQxr
 0lNnydq/71j9S0gx8+3bAoM/hRFWI3p4mXxPeYknkGuHVk5xm5ybv20dWWYVXmETtMWgSlCQUbs
 zCorAGb7NjMpcyphByvpXPf4PjKi89nH2g9uNePMNsNmmW13ldB9Zx0vtsZZH8ElZ2m1GraC0pH
 kYSdgKxvuAvEtUdSZVucZNNk4azCdr6wNuTFAqiGt/7WTRWct+NEZLwIB1amTjg37AlcfcSfa8W
 IT8BYEB1GcZc78K7GthpaE3NHfQIhTbrT3v3ofE7+VlhYqKFwgeskEuNXVnspnYtRjDf1jq9klD
 3Dt6XGyoq7gkf3XCSIqVgPrM5qVALfkDV95uVScncDLJbjpHfbGjEfNLU4jKJxRvNHh4sW0gcnk
 649+eZzxiLimJFBxg3oyJDMQwo8LSUlZ0ruYA/bl3OhwJV
X-Google-Smtp-Source: AGHT+IFcDH9C31RTWV1MPt+ZQr3Gor77x6FhqFYArlgVDLgO2LtzwJSX9UjOsHT3WI+Zc8n+y/SY1A==
X-Received: by 2002:a17:902:ea0e:b0:295:c1:95f7 with SMTP id
 d9443c01a7336-2951a5271bbmr197787325ad.61.1762213729714; 
 Mon, 03 Nov 2025 15:48:49 -0800 (PST)
Received: from phoenix (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29601998d4fsm3774185ad.43.2025.11.03.15.48.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Nov 2025 15:48:49 -0800 (PST)
Date: Mon, 3 Nov 2025 15:48:46 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Wathsala Vithanage <wathsala.vithanage@arm.com>
Cc: Honnappa Nagarahalli <honnappa.nagarahalli@arm.com>, Tyler Retzlaff
 <roretzla@linux.microsoft.com>, dev@dpdk.org, Ola Liljedahl
 <ola.liljedahl@arm.com>
Subject: Re: [PATCH 1/1] eal: correct memory ordering in MCS lock
Message-ID: <20251103154846.07be1aa0@phoenix>
In-Reply-To: <20251023184724.1759497-1-wathsala.vithanage@arm.com>
References: <20251023184724.1759497-1-wathsala.vithanage@arm.com>
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

On Thu, 23 Oct 2025 18:47:24 +0000
Wathsala Vithanage <wathsala.vithanage@arm.com> wrote:

> Fix incorrect memory ordering in the MCS lock implementation by
> adding proper synchronizing edges to establish clear happens-before
> relationships between threads invoking lock() and unlock(). These
> synchronizing edges prevent potential deadlocks caused by improper
> ordering and are documented in detail through in-code comments.
>=20
> The previously relaxed load of the successor=E2=80=99s lock object pointer
> in unlock() has been upgraded to a load-acquire operation. This
> change ensures that the successor=E2=80=99s initialization does not
> overwrite the current lock holder=E2=80=99s update to the locked field,
> which could otherwise lead to deadlocks.
>=20
> Remove two unnecessary fences:
>=20
> The acquire fence in unlock() had no matching release fence, making
> it ineffective for enforcing memory order. The associated comment
> suggested it prevented speculative reordering, but such fences (data
> memory barriers) only establish memory ordering and do not control
> instruction speculation.
>=20
> The release-acquire fence pair in lock() was previously justified as
> preventing reordering between the load-acquire loop of me->locked
> and the store-release of prev->next. This is no longer needed, as the
> new synchronizing edges ensure a chain of happens-before
> relationships between memory operations of threads calling lock() and
> unlock().
>=20
> Signed-off-by: Wathsala Vithanage <wathsala.vithanage@arm.com>
> Reviewed-by: Ola Liljedahl <ola.liljedahl@arm.com>

Thanks for the good explanatory comments.

Could you please add a Fixes: tag and Cc: stable@dpdk.org
so it can go to the right stable releases as well.

I noticed that Progress64 has same effective code.



