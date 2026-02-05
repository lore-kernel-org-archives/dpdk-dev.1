Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE8E7ECD997
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Feb 2026 21:27:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B3BAA4021F;
	Thu,  5 Feb 2026 22:27:12 +0100 (CET)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46]) by mails.dpdk.org (Postfix) with ESMTP id 299964021E
 for <dev@dpdk.org>; Thu,  5 Feb 2026 22:27:11 +0100 (CET)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4806d23e9f1so16180145e9.2
 for <dev@dpdk.org>; Thu, 05 Feb 2026 13:27:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1770326830;
 x=1770931630; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LEjfWgzuFr2rsm2LSiwNrBaNiCmSralAg9V9jzIPsnA=;
 b=BYxuKnkMmaQQMsI64jY5Hr/k97bz/VkAIkPva2UkrIA38wRwDGN7aRskz8V/h0L9JI
 FeqUEn3ekdyWhTdcDeKloUKSK9N+5zWAR8GTvrwhDykAkPvMMrHjaNYD4VsAhAt4f7v0
 PtN84T+hBxD4JVM7mI2VdY4eR3wAbafw8+sxr9Qh+dJhtHvL1a53+h5LB8qZPUD4Nxob
 +d6keBMmGqwLPjLQE6X1aqHEia5KVV5608UF6X12CgcMHprjElBJ9lnjcwjzSsgMjrxC
 nZGuIJX+mj0txKCJ71i+xjIIIu0/JIORqTTipxM4+N5/4XVIu2Ff9MNjPhlgCCmbjZTx
 9yaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770326830; x=1770931630;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LEjfWgzuFr2rsm2LSiwNrBaNiCmSralAg9V9jzIPsnA=;
 b=J6v0+5LfoGe66ZUFc+aHe3KuIm9+ElqgB5z24DhVYTp/TcXMlWpUjsTwjhQKcRJWsU
 T/FwP3I/hCj0sV6p6yTxju4w8cBtppMJJ6Eo0O7AxIRGBIiGTSy3h5hfUU4E0OAIc0PE
 72IIPl6RI6iI5UgGA/SRFczz4hFT05YeCoYfmjmlTlGpKHrLWdQbRZcfA6RoUhwEvvcz
 33UBoxs05+OyFxCTZxq2G0IhEs45FOK1ozQM0R6LcjM30/3GcId1t5PUmziF0FfLgUpS
 0FvTHVTlVudfBAlJIKWLpc1461OhKouWjqBhkYtZW2ofgbyPVOD62kXQVORpF916aRgO
 n9JA==
X-Gm-Message-State: AOJu0YyRPBR41DgdfYla3fJYuOOvwgn8qj9Da+nXUX/GWxIBfpLcgiZx
 M3JhM2BkL9vCrHPY2Ps1qLN7ckBFB/UOekak3UM9QsnINtUZdhuyw8A94VfHIhuetUw=
X-Gm-Gg: AZuq6aL7YcF7WV5I6FTquxUEjezyRXJ+6r3jnK+Y+epjtVFG5bztWbUPKs2CRF+mR5/
 /hk2G5nMRlI2h5G5c69S7VlEcjYsUVSGCSpJrP5vwaqaE/1cNxEcGqbfX8QH4ps3UB8v5aswN0w
 Dnhg5VCyvRS27IGR3hteLqto9aEUusEZUUuvJT5gSwwJs0VM8z7wbFFv0yKTwtQk2dKTrc7AYDI
 OF78cBXHnyVC5splk5bXsX7G5y4JaOpcl7sbWVyPRzOfuptutvDbU+W8dftnpsWdkcb8fSexgYR
 Ld3wAVK07BspYYwt1g7OruQ4bhSkWBHO0qB2QMZSJLHRZDgUegGmIwH2XutQFXm1i+/xb6zVHPy
 pd++sn0Kne0ycRNJX2iar2FLlek72f0KYifr9n+pkjBDATYcyirJHFChxkAQu2cHKrTNIskgEQV
 U1w5/sSTN8ldeMCtwmvhl2/gxSRqw1EHfd+DKggTv/qyGv1bB+q2kb
X-Received: by 2002:a05:600c:1d16:b0:483:1ed8:75d4 with SMTP id
 5b1f17b1804b1-483201effc4mr11050855e9.15.1770326830400; 
 Thu, 05 Feb 2026 13:27:10 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483206cc7d3sm6429765e9.5.2026.02.05.13.27.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Feb 2026 13:27:09 -0800 (PST)
Date: Thu, 5 Feb 2026 13:27:03 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Scott Mitchell <scott.k.mitch1@gmail.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v5 4/4] net/af_packet: add software checksum offload
 support
Message-ID: <20260205132703.0eb6080f@phoenix.local>
In-Reply-To: <CAFn2buCpy6C+ahAcM6mNUjdJL33YVgUHy_5AFxE4V6HjRffL0Q@mail.gmail.com>
References: <20260202081456.4322-1-scott.k.mitch1@gmail.com>
 <20260203070740.62305-1-scott.k.mitch1@gmail.com>
 <20260203070740.62305-5-scott.k.mitch1@gmail.com>
 <20260203061358.381ec977@phoenix.local>
 <CAFn2buCpy6C+ahAcM6mNUjdJL33YVgUHy_5AFxE4V6HjRffL0Q@mail.gmail.com>
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

On Tue, 3 Feb 2026 17:39:37 -0800
Scott Mitchell <scott.k.mitch1@gmail.com> wrote:

> > Probably need to add EXPERIMENTAL into docbook comment as well.  
> 
> Done.

Rebase and resubmit, the dependent patch is already in main.
