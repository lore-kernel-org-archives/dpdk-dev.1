Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7A26C5B552
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Jun 2025 06:57:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A650A402D4;
	Tue, 10 Jun 2025 08:57:40 +0200 (CEST)
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41]) by mails.dpdk.org (Postfix) with ESMTP id D05AB40E34
 for <dev@dpdk.org>; Mon,  9 Jun 2025 22:29:02 +0200 (CEST)
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-3122368d7c4so3762653a91.1
 for <dev@dpdk.org>; Mon, 09 Jun 2025 13:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749500942; x=1750105742; darn=dpdk.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=wOekSpd8ClCwf4Mo7V02NeYj7xJEFjlIJy4YnlFdOM8=;
 b=dIFSwAgAhgB10DgvEebAi8X2lt9MDN3tIdkQNF9ErjaDz7e+h5tPV9/vOyKNT+VBIO
 OLC0sr0YqLCFIdp6vVY0oOGX4GnXqCO9X/Wt0WYWwfbPRnqtJKulrDUPzXPOhHmBQsEd
 riXHat/5VEOI0gtXQTpNYJVBP+AOD0lQ9qm7vcqlml5K/q1WPGQ4FpybPbTmihRpiWfJ
 +32ml8qzGSVah/ctHduz15+ZcqpAfiRaUvcrD1xewhBzMgXuqA29DIbwqzgDfnM2NnsF
 y3alhtXrsUsCewmUM2C+A9IjnvI/nxpOuYF90GIFjuRg4ZbHc72bjQYfuD1jpBuywYHa
 7MMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749500942; x=1750105742;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wOekSpd8ClCwf4Mo7V02NeYj7xJEFjlIJy4YnlFdOM8=;
 b=QtRJMC/s6ZJNbl9MIXt6YXzAZXR1Xa3EgwKLP1BYNeVzzFX8hPEJNRiNjjv41iM3sI
 JPMFvA7aOAo594t8AkXcRNFoOqSGEpJpnx6D5aWH+8MH7UBM3lR5HMWYY6V3FL2HoYYx
 bxfqs7Vj1lMVpIFp5vvitxEagJPwv20k+6PiSznldFqoRKBQHZnfPkPKqA5bJlesgJWj
 4rcb+cHchk5uo4+XSu2qb0WvMyAzIar3JCsWW4pM3bG3eSdjjDNchlUqIcfZStBsNcMz
 /yc+2IzeW+rparvoli6XswB6BxrLaajSu2DwUDXlpVgO1a1JepAmNPqm/8/0umS7geVb
 4Diw==
X-Gm-Message-State: AOJu0YyLmk04rnvm4S3eN2HRkodH0zwTw2LXsrWRg/TZh86PskTPKQx9
 D9/ldl1LWRE1SAi2sQIB0yt6fpcP+J75/ZCr3280+9dP4HO+60c1Dkm0fo4M1z7RqDtUGCnVIQ6
 u6tyhLX0b3hhGcxUuClc8BPBB6faloC96+rhp
X-Gm-Gg: ASbGncvCc7Q7nIn42ZsS7X1wS0mt6ELm9vGbBmQxuUP9oyR/OqutgBo5zwy/DkfYiYo
 nE86ga0deOuB1bg3jvkwYaTYdbTHhXZZhuHjFmKhOkcWwfh5lKPpDVeJCK4z9ENpELLl7jb2XCO
 tVsJzQG+r3cNboIg1AFRThAXjQrVmXrM/hErKyfKmIf+ckZZWW/PtTVqU6GBsEP8Mfpegtqxpig
 47hvw==
X-Google-Smtp-Source: AGHT+IGrOO5KIcCQSbenERQ2cy/+ybM7kJmGRgsFj2Snx65CP1x9fvm5FahYIIcerf0Jfa01KBUJxGyaYpXYgdvTM8o=
X-Received: by 2002:a17:90b:164a:b0:301:9f62:a944 with SMTP id
 98e67ed59e1d1-3134769f73dmr22061493a91.33.1749500941569; Mon, 09 Jun 2025
 13:29:01 -0700 (PDT)
MIME-Version: 1.0
From: =?UTF-8?B?16jXldei15kg16nXkdeZ?= <roishabi9@gmail.com>
Date: Mon, 9 Jun 2025 23:28:50 +0300
X-Gm-Features: AX0GCFtBc8TlO7zDEgusv5DwdzxPXfSh82s20-TpTOp3mUrsLasRNVGu-mJJef0
Message-ID: <CAPXY6zikwqrr_LPWeVmWCYVZ-auEh2ykoSKTGWubeefs5iZRKg@mail.gmail.com>
Subject: acpi_cpufreq driver suggestion
To: dev@dpdk.org
Content-Type: multipart/alternative; boundary="00000000000028137b0637296e83"
X-Mailman-Approved-At: Tue, 10 Jun 2025 08:57:39 +0200
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

--00000000000028137b0637296e83
Content-Type: text/plain; charset="UTF-8"

Hello, I have a suggestion for a small fix/feature for the acpi_cpufreq
power environment.

acpi_cpufreq already saves the original governor setting and reverts it
back after a `rte_power_exit` call, which is good; The problem I am facing
is that on `power_acpi_cpufreq_init`, the frequency is immediately set to
max without any availability of the user to saves the original frequency. I
think it would be better for it to revert to the original frequency the
same way the governor is reverted.

Hope this is the right email address for this topic.

--00000000000028137b0637296e83
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello, I have a suggestion for a small fix/feature for the=
 acpi_cpufreq power environment.<div><br><div>acpi_cpufreq already saves th=
e original governor setting and reverts it back after a `rte_power_exit` ca=
ll, which is good; The problem I am facing is that on `power_acpi_cpufreq_i=
nit`, the frequency is immediately set to max without any availability of t=
he user to saves the original frequency. I think it would be better for it =
to revert to the original frequency the same way the governor is reverted.<=
/div><div><br></div><div>Hope this is the right email address for this topi=
c.</div></div></div>

--00000000000028137b0637296e83--
