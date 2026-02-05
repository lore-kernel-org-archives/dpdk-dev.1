Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F237FECD9B1
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Feb 2026 22:50:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 004D04021F;
	Thu,  5 Feb 2026 23:50:22 +0100 (CET)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48]) by mails.dpdk.org (Postfix) with ESMTP id E55E54021E
 for <dev@dpdk.org>; Thu,  5 Feb 2026 23:50:20 +0100 (CET)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-47fedb7c68dso15340055e9.2
 for <dev@dpdk.org>; Thu, 05 Feb 2026 14:50:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1770331820;
 x=1770936620; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iXXOkjO8Mnp0UiTQ1YWRy1+bTI3eoTwfSHjNlxSsyEc=;
 b=Bk/fZntWUb5dwB1jz/shiUFWVUp8T4H+mF1xI7BA4k9vQF2qHdieJLT6vpub5/yVNJ
 gKCkD6rYZkyfP+BE1ZoT0f+RXlqpCiTr8hpGX2SobITcgRIIILq4aFQBa1YfbVT6mVqb
 7ek3UOiDUjZc0fL2PWveMigBQR1sfRRnWhvMdHmutpDgrW+/uX2/jzI6chlxAhAgoAGm
 9j+QiEB2AbQpk961Xp1rDyNqiFRC9UGqKvSxai3aw7Q0hTvPfrXM52tUF1zqVplq8PPJ
 +8wxj4sPoRHVWpVXnXUK1u90iEzCmXI5AMGn/FeXIC8ifg9DP7H1hkbcf3fmy3NKaYfD
 TkDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770331820; x=1770936620;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iXXOkjO8Mnp0UiTQ1YWRy1+bTI3eoTwfSHjNlxSsyEc=;
 b=COn1E+IRA8LuFyfozLyp4b+1cy2FRrgf88GDwhWQ+srLu58KejMue8Qmv1ZodZVM+C
 na0w6jpy/or8Owd1/gozHxxdPi9/vw5h8N+IFmq9ldo/78rM6ctMi3SWlbpVKq9bk0KX
 l3JZ+b2C7DEBCUEcy/xCHn1zvw/vQlrLa6onFPc0Tlf1MmuUGWtrBiDvAHY3xFsl9F5j
 9/mqQCS/WRo1GTS8sYarXW+eJn6ycyHiWOgsbNC2rIBPVrYgkhLKriWAwWxYSknjzMpp
 MHZ72qyPGThBr3DhhDitNcJ1wc6KdLR6AD61SNr1Myxg/kHz+AiTMYzW1cil3qjDNd5F
 tKZw==
X-Gm-Message-State: AOJu0YzLyxWHJ6ItM0Zx+qXklkZsGRsVPpqxm8rbjtvMxQffkkl3vrPu
 A0ZuOVUuNMSK/ugjr/67BzSxLwY0B6CfdzpYc1uEWiFV6NoDC61LndpxeemEKANAqwA=
X-Gm-Gg: AZuq6aJaCmwzYA0YUqaldm4jF/F9TZzeU4a3k1kEOUDm3wsmNsOJqAVD0PLfjCfX+4W
 /4xNLgicvYUaZ4ijyFliGqo/qv+wY6JXn1vi1BqcgzsQrduasF2g70OHIqUwO2MH8vOkMgxmNX/
 AeakXFtnzS1wPg66lz1DBXVPvn4TxFFljUXqIPthViAHBqeACJ8NFo8VekISYrPNOQMyE9yN8fS
 C7JKCuYmlZZ1fEP6e29S42cg6OIsZKmme6ReiMHRfLJDIMxBvqxKzo8uq7kjWbw69pofUxUvYcD
 4vHIxPbQ4A1D9B2nEBGURvIw6MwauXD+mXnkIHSy4nQC1MbZkvQ5swQgnErYZafzVlPSsnn4t3g
 6XDazMJhSSUrsi9dqaw2LLf8XCVDhHUOHeBzcOY00W3ZSQ6gdBGPME7L4FtUl86VlEyXOWap83I
 bsaZhdXQ+FpktR3TJAzD1QGempTQSB89cjDafyXTJt68v3w/cpNINF
X-Received: by 2002:a05:600c:4f81:b0:479:3a89:121d with SMTP id
 5b1f17b1804b1-483209d06a9mr5563555e9.36.1770331820390; 
 Thu, 05 Feb 2026 14:50:20 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4362972fb81sm1453427f8f.20.2026.02.05.14.50.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Feb 2026 14:50:20 -0800 (PST)
Date: Thu, 5 Feb 2026 14:50:13 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Cliff Burdick <cburdick@nvidia.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>, "anatoly.burakov@intel.com"
 <anatoly.burakov@intel.com>
Subject: Re: [PATCH v4 0/2] support dmabuf
Message-ID: <20260205145013.78125c63@phoenix.local>
In-Reply-To: <SN7PR12MB6960C2AF8C689108DCDFF356AB99A@SN7PR12MB6960.namprd12.prod.outlook.com>
References: <20260203230338.1066297-1-cburdick@nvidia.com>
 <20260204155206.2345189-1-cburdick@nvidia.com>
 <20260205104844.6d2ffd9a@phoenix.local>
 <SN7PR12MB6960C2AF8C689108DCDFF356AB99A@SN7PR12MB6960.namprd12.prod.outlook.com>
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

On Thu, 5 Feb 2026 20:25:01 +0000
Cliff Burdick <cburdick@nvidia.com> wrote:

> > Any new library like this needs standalone tests so that it gets covered in CI etc.  
> 
> I did not see any existing GPU tests, and this would require a GPU to test along with a 5.15+ Linux kernel. Do those systems exist in the test infrastructure?

That was a mistake in allowing them in.
The problem was GPU requires CUDA, but that could have been handled.
