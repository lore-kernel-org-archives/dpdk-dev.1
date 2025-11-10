Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5713CCF9E3
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Nov 2025 16:41:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BF12E40280;
	Mon, 10 Nov 2025 17:41:02 +0100 (CET)
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com
 [209.85.210.182])
 by mails.dpdk.org (Postfix) with ESMTP id 058274026D
 for <dev@dpdk.org>; Mon, 10 Nov 2025 17:41:01 +0100 (CET)
Received: by mail-pf1-f182.google.com with SMTP id
 d2e1a72fcca58-7a9c64dfa6eso2531508b3a.3
 for <dev@dpdk.org>; Mon, 10 Nov 2025 08:41:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1762792860;
 x=1763397660; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BT+G3kQqrvKLtJXUbxeBT0Sslt6QWZc1E+zbun6Aapg=;
 b=kCMhFQHs+E/zxKOyVvQ2xDZ2yhf7P50RbSrKT0/94dU99GyDMGQn5a8/nt7DealCAL
 0K9+7W6bMT3AH6ZbQXxcMuT7JJoiLYAH5V0ThoPL7PnzSdR2orJY+rDVPLIPRdCgWoNw
 iBEUcRpX7+aNTaX9My/U273aJPt8ELKKk4kMW0/DoD9YXmRbURYj36wRwb9tiW+V7VXC
 B9iDeZIRXZmimriN3xCR1r3yMvSha7OcHJLUECOz507GWkgQezy9hqTdsgqVOQeFNajB
 a6EjAKJ1HBKtg8gaKehqSAcfELvTeAJ9z4gnY6aJock32UmcyzZxaY0H+tbe2ZryV/1Y
 R13g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762792860; x=1763397660;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BT+G3kQqrvKLtJXUbxeBT0Sslt6QWZc1E+zbun6Aapg=;
 b=gkPc1xIu0jSepesGz1ATRYaK8sTmXFWYMaHSa+pyuA+e75DXmRl8fIyxT9rl43hg8W
 o2+62n4kGGfsIepGvtowQ+NgZbTD8cm4N2pDKE1Hebt+FvAnNZ0tMSRquDeUXhdwMvKL
 126wAHv8s98Y85n0OZfJXYEroBF1JK8n+xFZoMDJr3naYtsaOdXVMPzhsYjRnyriv3OV
 Ky3aFmVOdvfGKLftZuU7BklxqaxtlyT65I2AbwqHPQWYygHNzxEf7o8p6JTRfbTFVLqm
 HpGMgW3pQV7f7GBQ8NIMSWNIwX1wN/tySZz+cffgTotsbfSmR2oglKGfg4QnxZDA9/pN
 89eg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXjgr812z+zhsVDnVf4QSbehRmdb6yAgzg9C3taDChh1+9TXm0nf0Ow7ZqPQ+BDFwIs9CA=@dpdk.org
X-Gm-Message-State: AOJu0YwXybbKVYLVE2INbJsFI88ezjlR4GHevozQUZ2g9hghuBppE8Fe
 F7Dh2ew1nkkEP0zRGi0QJUFViHcyyfmZFKzqxSn7JyziaZkobSROD9icCxLxNDPKbPwif1JBQaF
 ghk8D
X-Gm-Gg: ASbGnctQIPg/OpnHjEj2PdHQp0Q9jR8R6YXBxQlNrPRgGGF5u7wrnTi3JLb/QHqJdO8
 UfnMyMvUJ2o//6wqNuJCEiUbOH5r15efXkmebBT+OaY/jaU8CflVrqgkKJnnLXRKWTnmArAscC5
 vMLM14tVenXjd+qegpOUnEsQFsY/WO9ZfCPPwSnW9o9n0u2EHN8W1E77a8eJjiAYxCj7gUNa1jG
 lDm5elbWAvX+mv3eUF5quDorGi6vI+W3Wz+3l6LD2EB1UZh31q2sgGpmPQ9VS7TayWwc5225LTd
 ytbLvpa/J7wLL1uNuTrrAIMDNjU+4rBWBRBXiFrcHzFNi4jZwn5m7qqzYiRne5jpuDc5JMACFXN
 1NhTcArd81qp7ZnfuSnnIyLQWUkbC3RdmMrFZAN3CzBBVyAQNIcS2XpJwadlnlpW05BMpp9Xt8i
 aHn/gvC1RVPVsTbf8cAVg0pKHYyx6ejgQB1+QHBkCQjnYR
X-Google-Smtp-Source: AGHT+IE9H7s874Vklindgkav/2N4lj1AgmcbrNfDaPWgCGEv6vo2kTlbTYhQJXj4KJ2Nbn4nz+9knw==
X-Received: by 2002:a05:6a21:3942:b0:34f:b660:7723 with SMTP id
 adf61e73a8af0-353a3d5962fmr11208713637.48.1762792860026; 
 Mon, 10 Nov 2025 08:41:00 -0800 (PST)
Received: from phoenix (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7b0cc769e59sm12199516b3a.50.2025.11.10.08.40.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Nov 2025 08:40:59 -0800 (PST)
Date: Mon, 10 Nov 2025 08:40:54 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Marat Khalili <marat.khalili@huawei.com>
Cc: Konstantin Ananyev <konstantin.ananyev@huawei.com>, <dev@dpdk.org>
Subject: Re: [PATCH 2/3] bpf: disallow empty program
Message-ID: <20251110084054.49dce858@phoenix>
In-Reply-To: <20251110153046.63518-3-marat.khalili@huawei.com>
References: <20251110153046.63518-1-marat.khalili@huawei.com>
 <20251110153046.63518-3-marat.khalili@huawei.com>
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

On Mon, 10 Nov 2025 15:30:45 +0000
Marat Khalili <marat.khalili@huawei.com> wrote:

> Add tests for some simple cases:
> * Program with no instructions;
> * Program with only EXIT instruction but no return value set;
> * Program with return value set but no EXIT instruction;
> * Minimal valid program with return value set and an EXIT instruction.
> 
> Fix found bugs:
> * a program with no instructions was accepted;
> * a program with no EXIT instruction read outside the buffer.
> 
> Signed-off-by: Marat Khalili <marat.khalili@huawei.com>

Can this just be folded into existing test_bpf file please.
