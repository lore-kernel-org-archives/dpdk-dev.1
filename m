Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37250CAC59A
	for <dpdk-dev@archiver.kernel.org>; Thu, 18 Sep 2025 15:53:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 87FD040288;
	Thu, 18 Sep 2025 17:53:10 +0200 (CEST)
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com
 [209.85.160.169])
 by mails.dpdk.org (Postfix) with ESMTP id E522B4027A
 for <dev@dpdk.org>; Thu, 18 Sep 2025 17:53:08 +0200 (CEST)
Received: by mail-qt1-f169.google.com with SMTP id
 d75a77b69052e-4b60144fc74so14405951cf.2
 for <dev@dpdk.org>; Thu, 18 Sep 2025 08:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1758210788;
 x=1758815588; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2tTe6i8CuIxrOfFxfoEKttkjyxT5U46PXXy7Xz850Vo=;
 b=TVDoDmebzO1psW6MkPu6d/0XZ9q2IhXM9LakZafnVgsdBdo7g+oz8a7Q/606vOmE84
 /6yRLsEz8xg2hI2DFP6KOEaA6cpuRn2M0Z2q2uDnmZkDAsY+BMI1su/LGAOCQCaiUebk
 pvZZkpcR6PfY/bpy7H+jvttgY/qIZpuKuZsSiejQHMrZiTZ0miI1Pev3lSX9y+wL3Sr+
 ldP53Rh/vr1C2dtsmDhhcvSUUa0hHVcxOzah+k/sgCKptATJDOKIZf8RAk2NxDoFI519
 RbjspVZILPZ4tNcZJ/f45EGqIOgPn86A+KIaj1Z9vmzx2aoLbzqFYIGF7qVNlJYvBFOP
 z3HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758210788; x=1758815588;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2tTe6i8CuIxrOfFxfoEKttkjyxT5U46PXXy7Xz850Vo=;
 b=STlS5Vp3WD09se5BcpMpAUG4ZD8u8gB9sH82HyYYZciAMZvG/uW+1y+HVk6C3+9+tl
 g0hdTa+u/uwNC2IC1TrZAH3jaTQLRkvLZ5NxnD9w+pCcbZT0MMP/aXttgjcqUTjj+I9S
 xvjuPjHt7TgMKXjZJ7VPyIrUACgaFRVJBr8M2FXy9TixZ3GuYiyraoTDIbfZx2fTxlp3
 e04UZD+/LhPCQrigC/66bLRMRnWQbUcqn05qSLeoO0ATnaeRg1m3SGtFOOA0HQrj6PbP
 8dC3WCXOT+Drh1W81PZFNA7X+O+nG8k/cmKbkU4jJYzJb60fP9DthE2sdqS3BKa3D/Ws
 pT5Q==
X-Gm-Message-State: AOJu0Yx1iByyAA6T0xDfdrKnWw4+t6BBVI9qEjR1A9VfZkOezy5SlNbC
 hESPoCMkvaDHxiX2dFSBECMGuMtlU3yGu/ySp/MZtql5H/xMUzlgHRTXLejbo1qmGTEQxk+Y/FM
 1pDTp
X-Gm-Gg: ASbGncvdcEykB2oRAa65gVUQyvK1zRhygmknobpg/8XelyKmJws0GNBDOLpwhVBFqBW
 Vu8BNil33uF/qL8tkId4ZqxB/XbOFGxZ9cyij+VWFkdspma3UzGuvvignKwk2qTIJcXLFB6NIIq
 y3klPAL75HQiouitXL7mpyaKyuizxFcKQHQc8A91X4WFW9cUzM1FqUocM0sClGmOVHIx6Rs6ERp
 uu/VbT+O7Qn6lk6rFEW7dHvo39youjmsMJ2am5UuItyoDZGXcfgrOvS//C3Cz7SAs3Xlq9Z+u2w
 pHg4xiyHuMuA2uVP66zuPGmCVvWrPKBkOA74WGymA7vHjeVldbJJQg5rcJNlS7CV354sKO1gqAr
 aekT3O0mj6ZTJiTfwTR3twQX8N+aOvZBZ0NL5PUgMaCZcFQw5iih7TBrpGO1wsCn3M2enZ69iri
 C7TgciP2+f1B0u2wdpCw==
X-Google-Smtp-Source: AGHT+IHhehOfWkzPCUNhWvI6XD6d+pWcG3SALdcVEnCVDlO2rDa05bfZ0c1x5NoCXzOw18ANWlckTw==
X-Received: by 2002:a05:622a:4ccb:b0:4b2:edae:9df2 with SMTP id
 d75a77b69052e-4ba6618ad59mr67296011cf.5.1758210788031; 
 Thu, 18 Sep 2025 08:53:08 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-83626595d3csm180700485a.6.2025.09.18.08.53.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Sep 2025 08:53:07 -0700 (PDT)
Date: Thu, 18 Sep 2025 08:53:03 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: "Renyong Wan" <wanry@yunsilicon.com>
Cc: <dev@dpdk.org>, <thomas@monjalon.net>, <qianr@yunsilicon.com>,
 <nana@yunsilicon.com>, <zhangxx@yunsilicon.com>, <xudw@yunsilicon.com>,
 <jacky@yunsilicon.com>, <weihg@yunsilicon.com>
Subject: Re: [PATCH 1/2] net/xsc: improve interrupt uninstall
Message-ID: <20250918085303.11dd9cf4@hermes.local>
In-Reply-To: <20250916100850.226649-2-wanry@yunsilicon.com>
References: <20250916100850.226649-1-wanry@yunsilicon.com>
 <20250916100850.226649-2-wanry@yunsilicon.com>
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

On Tue, 16 Sep 2025 18:08:51 +0800
"Renyong Wan" <wanry@yunsilicon.com> wrote:

> Use synchronous callback unregister to ensure no callbacks
> are running after interrupt uninstallation. This improves
> stability and prevents potential use-after-free issues during
> device teardown.
> 
> Signed-off-by: Rong Qian <qianr@yunsilicon.com>
> Signed-off-by: Renyong Wan <wanry@yunsilicon.com>
> ---

Queued to next-net. Would be good to have a Fixes tag on this.
