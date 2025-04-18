Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A6CBC369C9
	for <dpdk-dev@archiver.kernel.org>; Fri, 18 Apr 2025 18:31:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 64F464060F;
	Fri, 18 Apr 2025 20:31:24 +0200 (CEST)
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com
 [209.85.215.170])
 by mails.dpdk.org (Postfix) with ESMTP id B71DB4064C
 for <dev@dpdk.org>; Fri, 18 Apr 2025 20:31:22 +0200 (CEST)
Received: by mail-pg1-f170.google.com with SMTP id
 41be03b00d2f7-af908bb32fdso1889836a12.1
 for <dev@dpdk.org>; Fri, 18 Apr 2025 11:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1745001082;
 x=1745605882; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W1pr7HgIMi3D0lcLM3MwIDqTjre0cLFKfQtz1M3pWtE=;
 b=ovhBSt5oAxwPfYFkVpU1jCfrz7ncdSeZGQOhEW0ohNt5/kk9W3OUI3vZ14Bck2qMQB
 61CvqCir6tAcV9kByCHf8qHQ0xEieuQ5btMhe59pEUQfJtmg7hjO2vPwmntuA58uy2xH
 N1HUtDkAGQVle6F9AdH1BBGDIbVUCvzIHDI3ekk1F4WXRwOLbOpPt3T3EmZJb+rX4+3b
 fgnWH7ltpubkjdOV7noNSagwX5YAyesR5v41ReNkQH6kHMUjuKyVdUMLW9jnAYjBcK4q
 3QbB1FU2qMCU3eXjwengXuvG4+tmdlwQ49+O6NDeRlYjBkGBMgUMM++kwZFNfnT7v3wB
 lFIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745001082; x=1745605882;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W1pr7HgIMi3D0lcLM3MwIDqTjre0cLFKfQtz1M3pWtE=;
 b=BDgDuHQ6+RxKid0BJyszyDnqGzAqkYZrOzdxJy+lKUIK+qJOxH+6d9mkAWl0lyLzHS
 8os7blPMe2ehHEe8SsR+zgLd9U9mPvxebaoX+uNhBatpuDewfxWfTprzt2qHmOIGf84i
 kzlSCZUAQruZDIQEx9mPFM1APhL50TPokdq45bsX7357sXZX6m14X5Ea2EkQPnKGa6cP
 jZIguZnWOPnt4u+QujNbKuRI3IBL4xWwhZVsAAMFTOSmvVX6xWgUAmCPrBdmpZXkyved
 Gtve24fH4BRy/3FKYYfy/MxtiUn919WqjUi6pJf8OLq1dgKLU2KFDd++CX6u3asaQX1B
 yYaQ==
X-Gm-Message-State: AOJu0YzYiGF9q/EVBrCbZlhNPUB2JBX/rHYX7r7gBh7i+vJCmo0mBbzO
 KM3ujWOgRkSS0xz1FE3WKfidT45yJA/0M/33q5r1kQvSK+u8KPDppxPv/qYJrJ8=
X-Gm-Gg: ASbGncuxUFHMPrm3CWHTI0q1c6eYYRuT9WQv9nl0MNVGCzyQM+u9Q/6AU1vaH0WR2I3
 d63WteWKoefbhff+0fSbQMcIZYRZL1KRU5DIhsRNATI+0d3wFic71bjt33z9k8zfquKRge0yxgv
 Ul7lYqP5IyDTcVNDitdjC/mcO9eCh3WKySc//pznQC6GqU9/Lr/wISMfeicFbQ7VlLNx6kxwe8O
 qsb3tbFtO63km36xp1CcyAfosgrgnHA5suDkaxJYbf5c0PkFzWQLPYQBHs5SYUAmSfO2DhnEajI
 Y3LuA16x4ymyrC3FqCnAVm+HbE/180S7V51vRrrt3htNaqu9zg3fMUGIcypbO0JGebZOYM+HU0b
 kGc43DZMGGdQSNHw2
X-Google-Smtp-Source: AGHT+IFNGqIUjHDFk6HZx2tcbvVZP+sUnxeU2n2FPSDXfqzikQsHfZ6Peacu3P4iFSJurGre73ejXA==
X-Received: by 2002:a17:90b:568b:b0:2fa:42f3:e3e4 with SMTP id
 98e67ed59e1d1-30879ab0397mr6008123a91.3.1745001081827; 
 Fri, 18 Apr 2025 11:31:21 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3087df1cc9asm1554745a91.22.2025.04.18.11.31.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Apr 2025 11:31:21 -0700 (PDT)
Date: Fri, 18 Apr 2025 11:25:40 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Feifei Wang <wff_light@vip.163.com>
Cc: dev@dpdk.org, Yi Chen <chenyi221@huawei.com>, Xin Wang
 <wangxin679@h-partners.com>, Feifei Wang <wangfeifei40@huawei.com>
Subject: Re: [RFC 17/18] net/hinic3: add FDIR flow control module
Message-ID: <20250418112540.05fc054e@hermes.local>
In-Reply-To: <20250418090621.9638-18-wff_light@vip.163.com>
References: <20250418090621.9638-1-wff_light@vip.163.com>
 <20250418090621.9638-18-wff_light@vip.163.com>
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

On Fri, 18 Apr 2025 17:06:03 +0800
Feifei Wang <wff_light@vip.163.com> wrote:

> +	(void)hinic3_mutex_unlock(&nic_dev->pause_mutuex);

Please don't add extra (void) here.
That is an older style used when C code was using lint.

And if you have an internal mutex_unlock function why is it returning
a value anyway. Should be void function.
