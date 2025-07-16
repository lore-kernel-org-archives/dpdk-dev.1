Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA289C83F1B
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Jul 2025 07:24:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0CC614021E;
	Wed, 16 Jul 2025 09:24:31 +0200 (CEST)
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com
 [209.85.215.174])
 by mails.dpdk.org (Postfix) with ESMTP id A06494013F
 for <dev@dpdk.org>; Wed, 16 Jul 2025 09:24:29 +0200 (CEST)
Received: by mail-pg1-f174.google.com with SMTP id
 41be03b00d2f7-b170c99aa49so4707938a12.1
 for <dev@dpdk.org>; Wed, 16 Jul 2025 00:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=uetpeshawar-edu-pk.20230601.gappssmtp.com; s=20230601; t=1752650669;
 x=1753255469; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YjM/ifYIoACHltE5AbxwntBLY0luKsrDMvUpAOgppn4=;
 b=nnn8PLiGCidvChfApH6FtjClJe5qtyn9YK8sQRpSfyFNWy6VZ6foao499PvmEUn08U
 bNvsEmnaHdymqEcUPgb8mtuvN/+IQeXR9PsJM19Re1Y2X2GKW+MoqQm08LOODqawqe52
 C1bsf+AuTKRmRly2oUZo0iuNvmo9ZOgXIC0F7aVgzB5JLzr6ytwNxg5n+nUo0N7Mu+dY
 QO1AZvuDWwf4eo4lFad6VI/MSmwWbT4iJqvIob2c/LhTr2czyaE91+j6UYCNyNVT0GX4
 EQtLVYYAKa/Mfg9TQhVF9hsuVpQXT85wDbQU17smZNpp0LUOmWaLKUlwCPHkQvhbOKWW
 Mh/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752650669; x=1753255469;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YjM/ifYIoACHltE5AbxwntBLY0luKsrDMvUpAOgppn4=;
 b=Ga7sspZedEqoRdxbgTKg5AdLxto9bOaqGEyF4RXToAJyKGqMmR/Z85V7I/MTTf4VJV
 a9/0id06+1wLO4WB/c2BvPHcBXNrf238nFXn1HYVOzGTxFngDHMj3S/7sdodUlqy66h6
 VrKXOvbfkovS9A7sWBv0LpJ7zzHNrly3WavkPAlv7CNdaASLZmPLUf3E3+MEtBRMqk5M
 1QspM+CjiqYFrq81WmJdLPupTkiMasllwFYQUmtp1HDJtChCJeS+npRwPv3/8eoIleur
 UjdsMWc82BB27YSoX4u+u/DA1oiyBrxUSIum7r7OnQ5R0DcHDlHQishiIiRVCLzAu/JH
 yq2g==
X-Gm-Message-State: AOJu0YwqzdzUCewpx0KDI1P/Lbjmwnf79ys5oGKCir1+WUzCgVhFSzvf
 O74Y7cupfBSmG5Jq+HR4QaiejJojrkh/IZ+kdjBMm/i+Q1mfVNSfbwKvtQI+UJ6A4DI=
X-Gm-Gg: ASbGncvYOard13hgCvX8yrR7g3VEJ/giqdYkH8MQ39RbfFIyQKfo9R027E9vIjD0o01
 JL7AQX0IFb8gnTHqDhaBOuWHCE39Evd1aLbGud8Bg4IbjUL0gTATrko3weq7K9n0s3pj8vPer5R
 WMcGSKmr47SlVvT2KmgJPY/eT/TzASj8wjaEMh/BSItX9xQn7FL1uDo+dsFJavqp3KM65+D98B8
 KM43uo2+hbzTUvKp3SeHoHVrBnSXHLS6BzlqyKmwA/f/xUzXOmkaaAYKJVLDSS0lwNt9TEEPAY1
 yif2vUWx4xgU5/0vowSJhp/UDWwg9KsXukqegmYCCUz3sG4Md8Y7pplgPGGnTRg7EtVsvvaXqYE
 KjuU4Ars1Q17SrW4OwqC/5HUuy6nfJFf6LPy78YdR6o/P68Mz
X-Google-Smtp-Source: AGHT+IFZZe3YBj3YleZpWh6riTXGvapL9fCVQrFZMI8Tf4EXv8s8/E7GPsAAH9mY/eDGSTTpmNRHOA==
X-Received: by 2002:a17:90b:3b83:b0:311:c5d9:2c70 with SMTP id
 98e67ed59e1d1-31c9e703722mr3235294a91.15.1752650668402; 
 Wed, 16 Jul 2025 00:24:28 -0700 (PDT)
Received: from localhost.localdomain ([64.62.143.197])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31c9159ec07sm1563888a91.0.2025.07.16.00.24.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Jul 2025 00:24:28 -0700 (PDT)
From: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
To: dsosnowski@nvidia.com
Cc: dev@dpdk.org, rasland@nvidia.com, stable@dpdk.org, viacheslavo@nvidia.com,
 orika@nvidia.com, suanmingm@nvidia.com, matan@nvidia.com
Subject: Re: [PATCH] net/mlx5: fix crash when using meter in transfer flow
Date: Wed, 16 Jul 2025 03:23:19 -0400
Message-ID: <20250716072410.3534146-1-14pwcse1224@uetpeshawar.edu.pk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250715175102.ovlhlrhyjzcokexs@ds-vm-debian.local>
References: <20250715175102.ovlhlrhyjzcokexs@ds-vm-debian.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=yes
Content-Transfer-Encoding: 8bit
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

Hi Dariusz,

Yes, you are right — I believe this has been fixed since DPDK v24.11 by the commit you mentioned:
https://github.com/DPDK/dpdk/commit/c30b356a4d48542fe99c47aa470afc8cd1ced9f5

Previously, this appeared to be an edge case where a segfault was triggered when a transfer rule was created (even when not using switchdev). But as confirmed, recent versions (v24.11.2 and newer) now correctly return ENOTSUP or a validation error instead of crashing.

I understand that transfer rules are only valid in switchdev mode, and that using them outside that context is unsupported. I encountered the segfault when testing this specific combination, but it seems the issue has been properly addressed now in the latest versions.

Thanks for confirming!

Best regards,
Khadem Ullah
