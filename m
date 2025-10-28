Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 273CDCCD1BF
	for <dpdk-dev@archiver.kernel.org>; Tue, 28 Oct 2025 13:46:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 509844028D;
	Tue, 28 Oct 2025 14:46:58 +0100 (CET)
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com
 [209.85.210.175])
 by mails.dpdk.org (Postfix) with ESMTP id B6DEF4021E
 for <dev@dpdk.org>; Tue, 28 Oct 2025 14:46:56 +0100 (CET)
Received: by mail-pf1-f175.google.com with SMTP id
 d2e1a72fcca58-7a26b04bfc8so6643093b3a.2
 for <dev@dpdk.org>; Tue, 28 Oct 2025 06:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1761659216;
 x=1762264016; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=91yg/NfmJyB8Fj73nfPqRaSm+gXmPiPvpQfiGF+KZ0A=;
 b=yGtwwAFSIYEqbRx38K90JBT7K69F3pFkZ0pf85oNS82zWuiR3GELxaM8XFpuHHByap
 dV7ALYwnOEx7BZM0ZgYI7O/4vSOQFudeESSTQgX63BZ/PbfJf6/sZI0iiLVIRX+yY9tI
 l9MXTMbJ/aPGW2ASH6DNXSOrjnjBhcz3axIFQ9ViwF3TJnyMeqwnci/CJE2k3au6aJeZ
 hN4ajPGR1cY3BZiqKaUth/9eC3X2sP3GMP3O/kqHUnwhs/6VsRo8CIp9lj0Pkx4quovZ
 bmfSn9ogyktpUsOtuDMyga6oqZve5eOpm0Kfq+7zfO6BG3V4Lp0QVSC7JIcnkGEtnvo0
 ic7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761659216; x=1762264016;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=91yg/NfmJyB8Fj73nfPqRaSm+gXmPiPvpQfiGF+KZ0A=;
 b=YHqQ0kbobZfLH7eszo+LlJRF20QIgv2QlEwUZeoeMDZqyL+KpvmJhLUpGbe9JAkEIJ
 ckv0O6DqHABisIIox0uoKRHSJ/xnTTwTUj2gwIUmZqUP8bgzpe3KB5l4rcA6UO2U+qG5
 tDMKl0X68CO1SY2IaomSrn2u5RU+pMRVDRDKQesqNRZze/+bqQrFmXUkH8RRM5zeogRa
 3QU7mh14+TJ9OigCQ4DE9/K+/7TSBiTqGnAAz9rj/CsPSL65SQJXR1MZHnhQqToFTYGo
 l2BG+oLUeEVQvThIU9Ka/XDHzriOu/ni7n1rIHMgozetiCOkYemwZwD/7QpqBHoYZXnf
 Q1vQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWvtMRZEDOn4g/6hMU5bWj2tuUkA0zN7l5mGFR4Sdp41P6tDd5A98pnuwZ9qT47uGF3qoA=@dpdk.org
X-Gm-Message-State: AOJu0YyVawiKQBU2tjQP2XvzGsgYYV8lESpEYae9hyDgjF8gCptKXPdo
 NcpwinGAIdOrNiqYGNsAXQkK5t5Wm/vqyHkWBdsHF76CNhEkoqexnnKfpi43aJEFIg0=
X-Gm-Gg: ASbGncvejytBGS4C5NuaUNf4AE0f98UnYFeTApI5pDrLqA7Etfe/er3zh/o1ZiEJNGi
 RbhPFyrVqGDGRWAcBNtcDfYDXqksbTSjxMkEeMG4kPG1wWs4m4J79lNtD8qCDhkv4YEg6ZIVpMc
 FG60R2Rv3yJTKujH8mYzgBG5/0Q5vkwpDbx4e2FIr3WgfbvXSbg03XSdl40aQ58yucarKtLwyoN
 97ygy21AAHtg3czp9dFT2GN/2mvodc3YmFev5Cf1MlivPVg5VmS3REIwl8Ib/+NDQHHhkQjx5fS
 yJMgF5+D4I6XUtQw32Wek2dIoTRvblOlzXlp4Ca7oSIF9dTrBvJ0GPe4EjQ8pWAubzhSlwBSUfg
 N/mZxzJJY6EQ3KBPZoa3CMdpEsXLksy8z9l9cpTc2h0lzvfDvTpj8+mY958UAr1dfSJFsVx7rqR
 rcPFN1DlYvnXdKi3q2zIShOrkBY3ilpNrRemvZHXFgqmh3
X-Google-Smtp-Source: AGHT+IGRnv/dE81mssUOj4GXYE4oCYINWIsNp0NwptCBpWzL0Sj/CzPfNYyeyrp5MFT0CHOL5Phnpg==
X-Received: by 2002:a05:6a00:a08:b0:7a2:7610:364d with SMTP id
 d2e1a72fcca58-7a441c3268fmr4743567b3a.15.1761659215599; 
 Tue, 28 Oct 2025 06:46:55 -0700 (PDT)
Received: from phoenix (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7a41407a0fasm11631247b3a.54.2025.10.28.06.46.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Oct 2025 06:46:55 -0700 (PDT)
Date: Tue, 28 Oct 2025 06:46:53 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Chengwen Feng <fengchengwen@huawei.com>
Cc: <thomas@monjalon.net>, <dev@dpdk.org>
Subject: Re: [PATCH 0/2] enhance ethdev telemetry
Message-ID: <20251028064653.54941255@phoenix>
In-Reply-To: <20251025094239.4915-1-fengchengwen@huawei.com>
References: <20251025094239.4915-1-fengchengwen@huawei.com>
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

On Sat, 25 Oct 2025 17:42:37 +0800
Chengwen Feng <fengchengwen@huawei.com> wrote:

> This patchset contains two commits which enhancing ethdev telemetry.
> 
> Chengwen Feng (2):
>   ethdev: support telemetry RSS algorithm
>   ethdev: support hide zero when telemetry regs
> 
>  lib/ethdev/rte_ethdev_telemetry.c | 56 ++++++++++++++++++++++---------
>  1 file changed, 40 insertions(+), 16 deletions(-)
> 

Queued to next-net

Does the documentation need updating? or a release note?
