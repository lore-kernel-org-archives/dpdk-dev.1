Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAEFBC87FCB
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Jul 2025 05:24:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7D3A240DD5;
	Wed, 30 Jul 2025 07:24:39 +0200 (CEST)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by mails.dpdk.org (Postfix) with ESMTP id 3F6A840668
 for <dev@dpdk.org>; Wed, 30 Jul 2025 07:24:38 +0200 (CEST)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-2402bbb4bf3so37212965ad.2
 for <dev@dpdk.org>; Tue, 29 Jul 2025 22:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=uetpeshawar-edu-pk.20230601.gappssmtp.com; s=20230601; t=1753853077;
 x=1754457877; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JaRrxp4EYql7Vow9Lkreot2G7kYJ0c0AoQ/z6kFwn4g=;
 b=LeBiO3GkNG5R0GFSc16WxAIVg8RmrKto8Qv7EqC2jN1YtFICxUxemaJKY0Nar7jN0/
 Am71q4oj8maVwu36FILbxBf9wxBnTBKrvBChJwuB8oiDgTUaMjSehJyYjHJN632mV6am
 gAbLul3SGVQXv33mu7hYMGKOeUWOYzjtluPYfRQNP8MusM57px44niQLqyT5lSONcdUZ
 ru8iSHDB889083AsqGy96cBNf6jNsMA4/T5UGAr/ZOzVr0ltvOpzirh4RvCOY44fR/WQ
 Xl+UQx8BgEXGxHX3xfeVeM+kYBmBP6ToRevqhWvPl1TNaUHNlLiAxPqEf3yXNgdYf+Xm
 f56Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753853077; x=1754457877;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JaRrxp4EYql7Vow9Lkreot2G7kYJ0c0AoQ/z6kFwn4g=;
 b=nkiVhLFefDIbAFAlFTQ9/mZ/CRoVS3SI2EFvFlBxCEh89WsoBdkY3/5KWQBCvnWAs7
 AcELUSs2v9KOBq5rgW3++LdYYyS/MAR+8qwD0eu/xHYvl7ofz3sQ/S1iVSYmN/4+sFx0
 KTGZfK4mrg6gai1U7sPiCPX40ebcQ3T64C4rN/n+KV2xZZuB06Mr2DxGg43pgjH1hoHa
 dj2eput3YOFU3GFLW6yuLOTcdGOHlO4Ax5sCAXuFjXI+s2StWb7nOIHpo51yU3WCwLwL
 jekUVSWzkwVWOo7mfL3ucQ05H2/NWnpmPHlsDD16LjsoJ8KjdeAVfn/utlwB+vab+V+p
 bFXg==
X-Gm-Message-State: AOJu0Yx2iz8jy4XmPR5ez25WhtBDnyBmBwBMB76a3hcuFi3dIJvXuAdz
 wf7lHU2tsgx/f/SoMIVSYH9cOt6QSywwTM3E55JqwueJ9SfV1pmV8dMZAKj4IhbbNJY=
X-Gm-Gg: ASbGnctoZguRtZHMcTZPuYShc0eVbzy1UoDQSSPZoA9SvHMnYMso5mBK1aQlpzTj+tH
 n709Md+NKmcJOOFaMDG7I/WbO39E4EbQighieTBG+gIxPDf+s5UJS53y9aPSPSjXtONlKFC3Wp1
 whW6Pp5aSgaXfjOEoyIE6QkHGCKU2A1oGVXtW1uP51q/oXTuZg6qKnSaP3lxnepYe6Kkovyr6Rp
 oZFtGTSVZA9q9ZWqLGJ99BJcP4qSn3tRr84JdWG3ssQqFTOOrEkCy10gZ1dFXrL5pSmVricJixO
 jawzIJIU9Rm4j48CUenSkZxmuMUKOJqcLKsvcnMJLFNF85ClENtXcSuKZ3hadLXqoQeT3uMnl+L
 hk+qKbYhxADDbdtsAO3GhtKwUxId44uJVPDEzy2gd+gc+NDrM
X-Google-Smtp-Source: AGHT+IEbBRq23+I882FDXdL/Cj0uVFraITLzln+rptxkIillake1Z7dcwxQkD5fwYLhbTXjWlOxicw==
X-Received: by 2002:a17:903:fa5:b0:240:2eb6:d5cc with SMTP id
 d9443c01a7336-24096abfad2mr34273555ad.17.1753853077227; 
 Tue, 29 Jul 2025 22:24:37 -0700 (PDT)
Received: from localhost.localdomain ([64.62.143.197])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-24014fb8236sm65600385ad.17.2025.07.29.22.24.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 22:24:36 -0700 (PDT)
From: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
To: stephen@networkplumber.org, thomas@monjalon.net, ferruh.yigit@amd.com,
 andrew.rybchenko@oktetlabs.ru
Cc: dev@dpdk.org,
	stable@dpdk.org
Subject: Re: [PATCH] [PATCH v5] app/testpmd: fix segfault in secondary process
 by monitoring primary
Date: Wed, 30 Jul 2025 01:24:07 -0400
Message-ID: <20250730052412.78178-1-14pwcse1224@uetpeshawar.edu.pk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250729144850.2392840f@hermes.local>
References: <20250729144850.2392840f@hermes.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
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

Hi Stephen,

Many thanks for the fix and for the suggestion that the secondary should exit 
immediately without attempting any cleanups once it detects the primary has exited.

I completely agree. I’ll supersede this patch with a new version that incorporates 
both of our changes.

Best regards,
Khadem

