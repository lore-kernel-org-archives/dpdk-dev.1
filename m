Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4400DC369C2
	for <dpdk-dev@archiver.kernel.org>; Tue, 22 Apr 2025 08:54:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0300E402E7;
	Tue, 22 Apr 2025 10:54:18 +0200 (CEST)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com
 [209.85.128.178])
 by mails.dpdk.org (Postfix) with ESMTP id 55C97402E6;
 Tue, 22 Apr 2025 10:54:16 +0200 (CEST)
Received: by mail-yw1-f178.google.com with SMTP id
 00721157ae682-6fedefb1c9cso34074337b3.0; 
 Tue, 22 Apr 2025 01:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745312055; x=1745916855; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=X/BBgDZTH+b1nAtj7cYVhQ7sZ5AJ+m2R/p/2UTSXNGU=;
 b=iOPNKT0uqU37X7Y3zoCIFREaP48X0hf6yYNB60++dvjCFwmI/r6FHZ4VYDDTlKsuet
 MjGTW4uJs+FFGlWRJmZRGcWttTmQSVpSiN8OoO1T5gOSpFiw06EwHEmgMtHVZtdxRLp5
 vlb3Ju8OgQ3826T92qVoTDSEZnMUC1zt4+xd6u1RW0Bt5OzJL9oXqGBDDHJ4kgb3UKNI
 LNw5/YIJnq2cHTUgHF14HDLyoASzoaD2VhTL3QOsC+R+nMVWQT2+xqcbq23h5e8f5jAx
 I9xHRY8NDBHh0GUWcU16yJ+RVSrUvwScYe+CZVu3E22Ec/pJ//58QIGI2htAMlEbHKiS
 gTNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745312055; x=1745916855;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=X/BBgDZTH+b1nAtj7cYVhQ7sZ5AJ+m2R/p/2UTSXNGU=;
 b=Oa+lKuUkN78DZdWdnxQ2hRZyZG62QAVSDhzWKSVim7KC3Rnl0SLoIIhGUGjcZepBMb
 WcIBaLr7DtSrlJPEwCF7aaFGbG35oYVXg6MUAufiXVV5BzU5dzPdsCGxLfkYamWkmygn
 Zstjkf+lQsh4A0I35pjY8atHO1vOEd0kl3ApkJU74BRHlioTiip05PA+GBJl2RreeWVE
 xQxvX/0OABbd2cG1R2Kz72WKCA8gfCl0bhTuRbkPMj2ihf0uUFP3gHTZvtvU8T4B1VLd
 H+YmsdWddabdFASqOpChysoKWfNR91PTX9bSQC5n8vzcipo+yOaXQIrnd+cTj3ps9JDk
 dhjA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/KNWJtTmdTlpK/a/yacHkY+6xiyJBMSa1ODT1CkPWOG7L0ozVMPm2z3CWpmU9nh62+pRODzs=@dpdk.org
X-Gm-Message-State: AOJu0YzHh3zc7f9Yic7NKkFhzlXZg8NbV/Lk5Qg+1l67aC+Lf4TUImBE
 RYbfjhSGhsFTZVV5nX3W43TQjYXbBcP4zTAD+lpnN252ucXfnU5kVIU5LQ2oec4sN05zs8MZ09X
 ANUQzjfCxn27cOb5clkriAtBCpGc=
X-Gm-Gg: ASbGncvoIKJ4DNdWP5xxFJNMMY1HCfAUDNz5iWUnNnV7EDiN4v63s1NNveLBcIrG+54
 V5i52LvLdcSWyoUO/z7eFbs6Poyuswu3dXnO2CAMTHwYoZnCO4wg6UT4LkeD3zG4oMfgqFM4Atp
 RzcXQ5ehJ2LpeO373/U2l8RJUdED+h1CM=
X-Google-Smtp-Source: AGHT+IEfIc5tR4X548AWUX8iaapA/s9iW6334s8iH8D3s4DJx5UpX37REvXqMTt9Lj02cemNXYtZwi6aV6dw2qEhRwY=
X-Received: by 2002:a05:690c:4b0b:b0:702:52fb:4629 with SMTP id
 00721157ae682-706ccdb6573mr172705297b3.23.1745312055454; Tue, 22 Apr 2025
 01:54:15 -0700 (PDT)
MIME-Version: 1.0
References: <20250422063754.3429965-1-patrykochal@gmail.com>
In-Reply-To: <20250422063754.3429965-1-patrykochal@gmail.com>
From: patryk ochal <patrykochal@gmail.com>
Date: Tue, 22 Apr 2025 10:54:04 +0200
X-Gm-Features: ATxdqUGNNQlOgPNmni4BUUc1enwFLC0dDr7Hyw3FesmyllJiPQMnCZ1mN-CW1LY
Message-ID: <CAO7mW7D__pXqSwMCjtoowCRqzHth3Y2qJrWA5zh7XsoEJ6nNpQ@mail.gmail.com>
Subject: [PATCH WITHDRAW] net/mlx5: fix out-of-bounds write in Rx software ring
To: Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, 
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, 
 Matan Azrad <matan@nvidia.com>, Yongseok Koh <yskoh@mellanox.com>
Cc: dev@dpdk.org, stable@dpdk.org
Content-Type: multipart/alternative; boundary="00000000000016729d06335a2157"
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

--00000000000016729d06335a2157
Content-Type: text/plain; charset="UTF-8"

Hi,

Please withdraw this patch. It was submitted prematurely as the fix for the
issue is already included here
https://mails.dpdk.org/archives/stable/2025-February/051616.html

Apologies for the confusion.

Thanks,
Patryk Ochal

--00000000000016729d06335a2157
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi,<br><br>Please withdraw this patch. It=
 was submitted prematurely as the fix for the issue is already included her=
e <a href=3D"https://mails.dpdk.org/archives/stable/2025-February/051616.ht=
ml">https://mails.dpdk.org/archives/stable/2025-February/051616.html</a><br=
><br>Apologies for the confusion.<br><br>Thanks,<br></div><div>Patryk Ochal=
</div></div>

--00000000000016729d06335a2157--
